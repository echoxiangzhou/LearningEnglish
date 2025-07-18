"""
Unified Analytics Service for Smart English Learning Platform

This service provides comprehensive analytics tracking across all learning modules
(dictation, vocabulary, and reading) with real-time updates and intelligent recommendations.
"""

import logging
from datetime import datetime, timedelta, date
from typing import Dict, List, Optional, Any, Tuple
from sqlalchemy import func, desc, and_, or_
# from sqlalchemy.orm import Session  # Not used, using Flask-SQLAlchemy db.session instead
from collections import defaultdict, Counter
import json

from app import db, socketio
from app.models.analytics import (
    UserProgress, LearningStats, UserAchievements, ErrorAnalysis,
    LearningRecommendations, AnalyticsCache, ModuleType, ActivityType,
    CompletionStatus, AchievementType, ErrorCategory, RecommendationType
)
from app.models.user import User
# Vocabulary models removed
from app.models.dictation_practice import DictationSession, DictationWordAttempt
from app.models.article import ReadingSession, QuestionAttempt

logger = logging.getLogger(__name__)


class UnifiedAnalyticsService:
    """Comprehensive analytics service for all learning modules"""
    
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.achievement_thresholds = self._load_achievement_thresholds()
    
    def _load_achievement_thresholds(self) -> Dict[str, Any]:
        """Load achievement thresholds configuration"""
        return {
            'streak': [7, 14, 30, 60, 100, 200],
            'accuracy': [70, 80, 85, 90, 95],
            'mastery': [10, 25, 50, 100, 250, 500, 1000],
            'volume': [100, 500, 1000, 2500, 5000, 10000],
            'consistency': [5, 10, 20, 30, 50],  # days in a month
            'improvement': [5, 10, 20, 30, 50]   # percentage improvement
        }
    
    # =============================================================================
    # PROGRESS TRACKING
    # =============================================================================
    
    def track_session_start(self, user_id: int, module_type: ModuleType, 
                           activity_type: ActivityType, session_data: Dict = None) -> int:
        """Start tracking a new learning session"""
        try:
            session = UserProgress(
                user_id=user_id,
                module_type=module_type,
                activity_type=activity_type,
                session_start=datetime.utcnow(),
                completion_status=CompletionStatus.IN_PROGRESS,
                session_data=session_data or {}
            )
            
            db.session.add(session)
            db.session.commit()
            
            # Emit real-time update
            self._emit_session_update(user_id, 'session_started', {
                'session_id': session.id,
                'module_type': module_type.value,
                'activity_type': activity_type.value
            })
            
            return session.id
            
        except Exception as e:
            self.logger.error(f"Error tracking session start: {str(e)}")
            db.session.rollback()
            return None
    
    def update_session_progress(self, session_id: int, items_attempted: int = None,
                               items_correct: int = None, hints_used: int = None,
                               session_data: Dict = None):
        """Update progress for an ongoing session"""
        try:
            session = UserProgress.query.get(session_id)
            if not session:
                self.logger.warning(f"Session {session_id} not found")
                return False
            
            if items_attempted is not None:
                session.items_attempted = items_attempted
            if items_correct is not None:
                session.items_correct = items_correct
            if hints_used is not None:
                session.hints_used = hints_used
            if session_data:
                session.session_data = {**(session.session_data or {}), **session_data}
            
            # Calculate current accuracy
            if session.items_attempted and session.items_attempted > 0:
                session.accuracy_rate = (session.items_correct / session.items_attempted) * 100
            
            session.updated_at = datetime.utcnow()
            db.session.commit()
            
            # Emit real-time update
            self._emit_session_update(session.user_id, 'session_progress', {
                'session_id': session_id,
                'accuracy_rate': session.accuracy_rate,
                'items_attempted': session.items_attempted,
                'items_correct': session.items_correct
            })
            
            return True
            
        except Exception as e:
            self.logger.error(f"Error updating session progress: {str(e)}")
            db.session.rollback()
            return False
    
    def complete_session(self, session_id: int, completion_status: CompletionStatus = CompletionStatus.COMPLETED):
        """Complete a learning session and update analytics"""
        try:
            session = UserProgress.query.get(session_id)
            if not session:
                self.logger.warning(f"Session {session_id} not found")
                return False
            
            # Mark session as completed
            session.complete_session()
            session.completion_status = completion_status
            db.session.commit()
            
            # Update aggregated statistics
            self._update_learning_stats(session)
            
            # Check for new achievements
            self._check_achievements(session.user_id)
            
            # Update recommendations
            self._update_recommendations(session.user_id)
            
            # Clear user's analytics cache
            AnalyticsCache.clear_user_cache(session.user_id)
            
            # Emit completion update
            self._emit_session_update(session.user_id, 'session_completed', {
                'session_id': session_id,
                'completion_status': completion_status.value,
                'accuracy_rate': session.accuracy_rate,
                'time_spent': session.time_spent
            })
            
            return True
            
        except Exception as e:
            self.logger.error(f"Error completing session: {str(e)}")
            db.session.rollback()
            return False
    
    def track_error(self, user_id: int, module_type: ModuleType, error_type: ErrorCategory,
                   word_or_concept: str, user_response: str, correct_response: str,
                   context: str = None, difficulty_level: int = 1):
        """Track and analyze learning errors"""
        try:
            # Check if this error already exists
            existing_error = ErrorAnalysis.query.filter(
                ErrorAnalysis.user_id == user_id,
                ErrorAnalysis.module_type == module_type,
                ErrorAnalysis.error_type == error_type,
                ErrorAnalysis.word_or_concept == word_or_concept
            ).first()
            
            if existing_error:
                existing_error.update_frequency()
                existing_error.user_response = user_response
                existing_error.correct_response = correct_response
                if context:
                    existing_error.context = context
            else:
                error = ErrorAnalysis(
                    user_id=user_id,
                    module_type=module_type,
                    error_type=error_type,
                    word_or_concept=word_or_concept,
                    user_response=user_response,
                    correct_response=correct_response,
                    context=context,
                    difficulty_level=difficulty_level
                )
                db.session.add(error)
            
            db.session.commit()
            
            # Generate targeted recommendations for systematic errors
            if existing_error and existing_error.is_systematic:
                self._generate_error_remediation_recommendation(user_id, existing_error)
            
        except Exception as e:
            self.logger.error(f"Error tracking error: {str(e)}")
            db.session.rollback()
    
    # =============================================================================
    # STATISTICS CALCULATION
    # =============================================================================
    
    def _update_learning_stats(self, session: UserProgress):
        """Update aggregated learning statistics"""
        try:
            stats = LearningStats.query.filter(LearningStats.user_id == session.user_id).first()
            if not stats:
                stats = LearningStats(user_id=session.user_id)
                db.session.add(stats)
            
            stats.update_from_session(session)
            db.session.commit()
            
        except Exception as e:
            self.logger.error(f"Error updating learning stats: {str(e)}")
            db.session.rollback()
    
    def get_unified_dashboard(self, user_id: int) -> Dict[str, Any]:
        """Get comprehensive dashboard data across all modules"""
        try:
            # Check cache first
            cache_key = f"dashboard_{user_id}"
            cached_data = AnalyticsCache.get_cached_data(cache_key)
            if cached_data:
                return cached_data
            
            # Get learning statistics
            stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
            if not stats:
                stats = LearningStats(user_id=user_id)
                db.session.add(stats)
                db.session.commit()
            
            # Get module-specific data
            dashboard_data = {
                'overview': self._get_overview_stats(user_id, stats),
                'module_performance': self._get_module_performance(user_id),
                'progress_timeline': self._get_progress_timeline(user_id),
                'achievements': self._get_user_achievements_summary(user_id),
                'recommendations': self._get_active_recommendations(user_id),
                'error_analysis': self._get_error_analysis_summary(user_id),
                'streak_data': self._get_streak_analytics(user_id, stats),
                'performance_trends': self._get_performance_trends(user_id),
                'generated_at': datetime.utcnow().isoformat()
            }
            
            # Cache the results
            AnalyticsCache.set_cached_data(cache_key, dashboard_data, user_id, 'dashboard')
            
            return dashboard_data
            
        except Exception as e:
            self.logger.error(f"Error getting unified dashboard: {str(e)}")
            return {}
    
    def _get_overview_stats(self, user_id: int, stats: LearningStats) -> Dict[str, Any]:
        """Get high-level overview statistics"""
        # Recent activity (last 7 days)
        week_ago = datetime.utcnow() - timedelta(days=7)
        recent_sessions = UserProgress.query.filter(
            UserProgress.user_id == user_id,
            UserProgress.session_start >= week_ago,
            UserProgress.completion_status == CompletionStatus.COMPLETED
        ).count()
        
        # Due items across modules
        due_vocabulary = UserVocabulary.query.filter(
            UserVocabulary.user_id == user_id,
            or_(
                UserVocabulary.due_for_review == True,
                UserVocabulary.next_review <= datetime.utcnow()
            )
        ).count()
        
        return {
            'total_sessions': stats.total_sessions,
            'total_time_hours': round(stats.total_time_spent / 3600, 1),
            'average_accuracy': round(stats.average_accuracy, 1),
            'current_streak': stats.current_streak,
            'longest_streak': stats.longest_streak,
            'recent_sessions': recent_sessions,
            'due_vocabulary': due_vocabulary,
            'last_activity': stats.last_activity_date.isoformat() if stats.last_activity_date else None
        }
    
    def _get_module_performance(self, user_id: int) -> Dict[str, Any]:
        """Get performance breakdown by learning module"""
        # Get session counts and averages by module
        module_stats = db.session.query(
            UserProgress.module_type,
            func.count(UserProgress.id).label('session_count'),
            func.avg(UserProgress.accuracy_rate).label('avg_accuracy'),
            func.sum(UserProgress.time_spent).label('total_time'),
            func.avg(UserProgress.time_spent).label('avg_time')
        ).filter(
            UserProgress.user_id == user_id,
            UserProgress.completion_status == CompletionStatus.COMPLETED
        ).group_by(UserProgress.module_type).all()
        
        performance = {}
        for module_type, count, accuracy, total_time, avg_time in module_stats:
            performance[module_type.value] = {
                'session_count': count,
                'average_accuracy': round(float(accuracy or 0), 1),
                'total_time_minutes': round((total_time or 0) / 60, 1),
                'average_session_time': round((avg_time or 0) / 60, 1)
            }
        
        return performance
    
    def _get_progress_timeline(self, user_id: int, days: int = 30) -> List[Dict[str, Any]]:
        """Get daily progress timeline"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Get daily session data
        daily_data = db.session.query(
            func.date(UserProgress.session_start).label('date'),
            UserProgress.module_type,
            func.count(UserProgress.id).label('sessions'),
            func.avg(UserProgress.accuracy_rate).label('accuracy'),
            func.sum(UserProgress.time_spent).label('time_spent')
        ).filter(
            UserProgress.user_id == user_id,
            UserProgress.session_start >= cutoff_date,
            UserProgress.completion_status == CompletionStatus.COMPLETED
        ).group_by(
            func.date(UserProgress.session_start),
            UserProgress.module_type
        ).all()
        
        # Organize data by date
        timeline_data = defaultdict(lambda: {
            'date': None,
            'total_sessions': 0,
            'total_time_minutes': 0,
            'overall_accuracy': 0,
            'modules': {}
        })
        
        for date_obj, module_type, sessions, accuracy, time_spent in daily_data:
            date_str = date_obj.isoformat()
            timeline_data[date_str]['date'] = date_str
            timeline_data[date_str]['total_sessions'] += sessions
            timeline_data[date_str]['total_time_minutes'] += (time_spent or 0) / 60
            timeline_data[date_str]['modules'][module_type.value] = {
                'sessions': sessions,
                'accuracy': round(float(accuracy or 0), 1),
                'time_minutes': round((time_spent or 0) / 60, 1)
            }
        
        # Calculate overall accuracy for each day
        for day_data in timeline_data.values():
            if day_data['modules']:
                accuracies = [mod_data['accuracy'] for mod_data in day_data['modules'].values() if mod_data['accuracy'] > 0]
                day_data['overall_accuracy'] = round(sum(accuracies) / max(1, len(accuracies)), 1)
        
        return sorted(timeline_data.values(), key=lambda x: x['date'])
    
    # =============================================================================
    # ACHIEVEMENT SYSTEM
    # =============================================================================
    
    def _check_achievements(self, user_id: int):
        """Check for new achievements after session completion"""
        try:
            stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
            if not stats:
                return
            
            # Check streak achievements
            self._check_streak_achievements(user_id, stats.current_streak)
            
            # Check accuracy achievements
            self._check_accuracy_achievements(user_id, stats.average_accuracy)
            
            # Check volume achievements
            self._check_volume_achievements(user_id, stats.total_sessions)
            
            # Check mastery achievements (vocabulary-specific)
            self._check_mastery_achievements(user_id)
            
            # Check consistency achievements
            self._check_consistency_achievements(user_id)
            
        except Exception as e:
            self.logger.error(f"Error checking achievements: {str(e)}")
    
    def _check_streak_achievements(self, user_id: int, current_streak: int):
        """Check for streak-based achievements"""
        for threshold in self.achievement_thresholds['streak']:
            if current_streak >= threshold:
                badge_name = f"{threshold} Day Streak"
                if not self._has_achievement(user_id, badge_name):
                    self._award_achievement(
                        user_id=user_id,
                        achievement_type=AchievementType.STREAK,
                        badge_name=badge_name,
                        description=f"Maintained a {threshold} day learning streak!",
                        icon="🔥",
                        points=threshold * 2,
                        tier=self._get_achievement_tier(threshold, self.achievement_thresholds['streak'])
                    )
    
    def _check_accuracy_achievements(self, user_id: int, accuracy: float):
        """Check for accuracy-based achievements"""
        for threshold in self.achievement_thresholds['accuracy']:
            if accuracy >= threshold:
                badge_name = f"{threshold}% Accuracy Master"
                if not self._has_achievement(user_id, badge_name):
                    self._award_achievement(
                        user_id=user_id,
                        achievement_type=AchievementType.ACCURACY,
                        badge_name=badge_name,
                        description=f"Achieved {threshold}% average accuracy!",
                        icon="🎯",
                        points=threshold,
                        tier=self._get_achievement_tier(threshold, self.achievement_thresholds['accuracy'])
                    )
    
    def _check_volume_achievements(self, user_id: int, total_sessions: int):
        """Check for volume-based achievements"""
        for threshold in self.achievement_thresholds['volume']:
            if total_sessions >= threshold:
                badge_name = f"{threshold} Sessions Completed"
                if not self._has_achievement(user_id, badge_name):
                    self._award_achievement(
                        user_id=user_id,
                        achievement_type=AchievementType.VOLUME,
                        badge_name=badge_name,
                        description=f"Completed {threshold} learning sessions!",
                        icon="📚",
                        points=threshold // 10,
                        tier=self._get_achievement_tier(threshold, self.achievement_thresholds['volume'])
                    )
    
    def _check_mastery_achievements(self, user_id: int):
        """Check for vocabulary mastery achievements"""
        mastered_count = UserVocabulary.query.filter(
            UserVocabulary.user_id == user_id,
            UserVocabulary.mastery_level == 'mastered'
        ).count()
        
        for threshold in self.achievement_thresholds['mastery']:
            if mastered_count >= threshold:
                badge_name = f"{threshold} Words Mastered"
                if not self._has_achievement(user_id, badge_name):
                    self._award_achievement(
                        user_id=user_id,
                        achievement_type=AchievementType.MASTERY,
                        badge_name=badge_name,
                        description=f"Mastered {threshold} vocabulary words!",
                        icon="🌟",
                        points=threshold,
                        tier=self._get_achievement_tier(threshold, self.achievement_thresholds['mastery'])
                    )
    
    def _check_consistency_achievements(self, user_id: int):
        """Check for consistency achievements (active days in current month)"""
        # Get active days in current month
        month_start = datetime.utcnow().replace(day=1, hour=0, minute=0, second=0, microsecond=0)
        active_days = db.session.query(
            func.count(func.distinct(func.date(UserProgress.session_start)))
        ).filter(
            UserProgress.user_id == user_id,
            UserProgress.session_start >= month_start,
            UserProgress.completion_status == CompletionStatus.COMPLETED
        ).scalar() or 0
        
        for threshold in self.achievement_thresholds['consistency']:
            if active_days >= threshold:
                badge_name = f"{threshold} Days This Month"
                if not self._has_achievement(user_id, badge_name):
                    self._award_achievement(
                        user_id=user_id,
                        achievement_type=AchievementType.CONSISTENCY,
                        badge_name=badge_name,
                        description=f"Studied on {threshold} different days this month!",
                        icon="📅",
                        points=threshold * 5,
                        tier=self._get_achievement_tier(threshold, self.achievement_thresholds['consistency'])
                    )
    
    def _has_achievement(self, user_id: int, badge_name: str) -> bool:
        """Check if user already has a specific achievement"""
        return UserAchievements.query.filter(
            UserAchievements.user_id == user_id,
            UserAchievements.badge_name == badge_name
        ).first() is not None
    
    def _award_achievement(self, user_id: int, achievement_type: AchievementType,
                          badge_name: str, description: str, icon: str,
                          points: int, tier: str):
        """Award a new achievement to the user"""
        try:
            achievement = UserAchievements(
                user_id=user_id,
                achievement_type=achievement_type,
                badge_name=badge_name,
                badge_description=description,
                badge_icon=icon,
                points_awarded=points,
                tier=tier
            )
            
            db.session.add(achievement)
            db.session.commit()
            
            # Emit achievement notification
            self._emit_achievement_unlocked(user_id, achievement.to_dict())
            
        except Exception as e:
            self.logger.error(f"Error awarding achievement: {str(e)}")
            db.session.rollback()
    
    def _get_achievement_tier(self, value: int, thresholds: List[int]) -> str:
        """Determine achievement tier based on thresholds"""
        position = thresholds.index(value) if value in thresholds else len(thresholds) - 1
        total_tiers = len(thresholds)
        
        if position < total_tiers * 0.25:
            return 'bronze'
        elif position < total_tiers * 0.5:
            return 'silver'
        elif position < total_tiers * 0.75:
            return 'gold'
        else:
            return 'platinum'
    
    # =============================================================================
    # RECOMMENDATIONS ENGINE
    # =============================================================================
    
    def _update_recommendations(self, user_id: int):
        """Update personalized learning recommendations"""
        try:
            # Deactivate old recommendations
            LearningRecommendations.query.filter(
                LearningRecommendations.user_id == user_id,
                LearningRecommendations.is_active == True
            ).update({'is_active': False})
            
            # Generate new recommendations
            recommendations = self._generate_recommendations(user_id)
            
            for rec_data in recommendations:
                recommendation = LearningRecommendations(**rec_data)
                db.session.add(recommendation)
            
            db.session.commit()
            
        except Exception as e:
            self.logger.error(f"Error updating recommendations: {str(e)}")
            db.session.rollback()
    
    def _generate_recommendations(self, user_id: int) -> List[Dict[str, Any]]:
        """Generate personalized recommendations based on user performance"""
        recommendations = []
        
        # Get user stats and recent performance
        stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
        if not stats:
            return recommendations
        
        # Review recommendations
        due_vocabulary = UserVocabulary.query.filter(
            UserVocabulary.user_id == user_id,
            or_(
                UserVocabulary.due_for_review == True,
                UserVocabulary.next_review <= datetime.utcnow()
            )
        ).count()
        
        if due_vocabulary > 0:
            recommendations.append({
                'user_id': user_id,
                'recommendation_type': RecommendationType.REVIEW_DUE,
                'title': 'Review Due Words',
                'description': f'You have {due_vocabulary} words due for review.',
                'action_url': '/vocabulary/review',
                'module_type': ModuleType.VOCABULARY,
                'priority': 'high',
                'estimated_time_minutes': min(due_vocabulary * 2, 30)
            })
        
        # Streak recommendations
        if stats.current_streak == 0:
            recommendations.append({
                'user_id': user_id,
                'recommendation_type': RecommendationType.BUILD_STREAK,
                'title': 'Start Learning Streak',
                'description': 'Begin a daily learning streak to build consistent habits.',
                'action_url': '/practice',
                'priority': 'medium',
                'estimated_time_minutes': 10
            })
        elif stats.current_streak < 7:
            recommendations.append({
                'user_id': user_id,
                'recommendation_type': RecommendationType.BUILD_STREAK,
                'title': 'Continue Your Streak',
                'description': f'Keep your {stats.current_streak}-day streak going!',
                'action_url': '/practice',
                'priority': 'medium',
                'estimated_time_minutes': 15
            })
        
        # Accuracy-based recommendations
        if stats.average_accuracy < 70:
            recommendations.append({
                'user_id': user_id,
                'recommendation_type': RecommendationType.IMPROVE_ACCURACY,
                'title': 'Improve Accuracy',
                'description': 'Focus on reviewing familiar content to boost accuracy.',
                'action_url': '/practice/review',
                'priority': 'high',
                'estimated_time_minutes': 20
            })
        
        # Module-specific recommendations
        if stats.dictation_sessions < 5:
            recommendations.append({
                'user_id': user_id,
                'recommendation_type': RecommendationType.PRACTICE_DICTATION,
                'title': 'Try Dictation Practice',
                'description': 'Improve listening skills with dictation exercises.',
                'action_url': '/dictation',
                'module_type': ModuleType.DICTATION,
                'priority': 'medium',
                'estimated_time_minutes': 15
            })
        
        if stats.reading_sessions < 5:
            recommendations.append({
                'user_id': user_id,
                'recommendation_type': RecommendationType.READ_MORE,
                'title': 'Reading Comprehension',
                'description': 'Enhance comprehension with reading exercises.',
                'action_url': '/reading',
                'module_type': ModuleType.READING,
                'priority': 'medium',
                'estimated_time_minutes': 20
            })
        
        return recommendations
    
    # =============================================================================
    # ERROR ANALYSIS
    # =============================================================================
    
    def _get_error_analysis_summary(self, user_id: int) -> Dict[str, Any]:
        """Get summary of user's learning errors and patterns"""
        # Get error frequency by type
        error_stats = db.session.query(
            ErrorAnalysis.error_type,
            ErrorAnalysis.module_type,
            func.count(ErrorAnalysis.id).label('count'),
            func.sum(ErrorAnalysis.frequency).label('total_frequency')
        ).filter(
            ErrorAnalysis.user_id == user_id
        ).group_by(
            ErrorAnalysis.error_type,
            ErrorAnalysis.module_type
        ).all()
        
        error_summary = defaultdict(lambda: defaultdict(int))
        for error_type, module_type, count, frequency in error_stats:
            error_summary[module_type.value][error_type.value] = {
                'unique_errors': count,
                'total_frequency': frequency
            }
        
        # Get systematic errors
        systematic_errors = ErrorAnalysis.query.filter(
            ErrorAnalysis.user_id == user_id,
            ErrorAnalysis.is_systematic == True,
            ErrorAnalysis.remediation_completed == False
        ).limit(5).all()
        
        return {
            'error_breakdown': dict(error_summary),
            'systematic_errors': [error.to_dict() for error in systematic_errors],
            'needs_attention': len(systematic_errors)
        }
    
    def _generate_error_remediation_recommendation(self, user_id: int, error: ErrorAnalysis):
        """Generate targeted recommendation for systematic errors"""
        try:
            recommendation = LearningRecommendations(
                user_id=user_id,
                recommendation_type=RecommendationType.TARGET_WEAKNESS,
                title=f"Practice: {error.word_or_concept}",
                description=f"You've made this {error.error_type.value} error {error.frequency} times. Let's practice!",
                action_url=f"/{error.module_type.value}/practice?focus={error.word_or_concept}",
                content_id=error.id,
                module_type=error.module_type,
                priority='high',
                estimated_time_minutes=10
            )
            
            db.session.add(recommendation)
            db.session.commit()
            
            # Mark remediation as suggested
            error.remediation_suggested = True
            db.session.commit()
            
        except Exception as e:
            self.logger.error(f"Error generating remediation recommendation: {str(e)}")
            db.session.rollback()
    
    # =============================================================================
    # HELPER METHODS
    # =============================================================================
    
    def _get_user_achievements_summary(self, user_id: int) -> Dict[str, Any]:
        """Get user achievements summary"""
        achievements = UserAchievements.query.filter(
            UserAchievements.user_id == user_id,
            UserAchievements.is_displayed == True
        ).order_by(desc(UserAchievements.unlocked_at)).all()
        
        # Group by type
        by_type = defaultdict(list)
        for achievement in achievements:
            by_type[achievement.achievement_type.value].append(achievement.to_dict())
        
        # Recent achievements (last 30 days)
        recent_cutoff = datetime.utcnow() - timedelta(days=30)
        recent = [ach for ach in achievements if ach.unlocked_at >= recent_cutoff]
        
        return {
            'total_achievements': len(achievements),
            'recent_achievements': [ach.to_dict() for ach in recent],
            'by_type': dict(by_type),
            'total_points': sum(ach.points_awarded for ach in achievements)
        }
    
    def _get_active_recommendations(self, user_id: int) -> List[Dict[str, Any]]:
        """Get active recommendations for user"""
        recommendations = LearningRecommendations.query.filter(
            LearningRecommendations.user_id == user_id,
            LearningRecommendations.is_active == True,
            or_(
                LearningRecommendations.expires_at.is_(None),
                LearningRecommendations.expires_at > datetime.utcnow()
            )
        ).order_by(
            LearningRecommendations.priority.desc(),
            LearningRecommendations.created_at
        ).limit(5).all()
        
        return [rec.to_dict() for rec in recommendations]
    
    def _get_streak_analytics(self, user_id: int, stats: LearningStats) -> Dict[str, Any]:
        """Get detailed streak analytics"""
        # Get activity calendar for last 30 days
        cutoff_date = datetime.utcnow() - timedelta(days=30)
        daily_activity = db.session.query(
            func.date(UserProgress.session_start).label('date'),
            func.count(UserProgress.id).label('sessions')
        ).filter(
            UserProgress.user_id == user_id,
            UserProgress.session_start >= cutoff_date,
            UserProgress.completion_status == CompletionStatus.COMPLETED
        ).group_by(func.date(UserProgress.session_start)).all()
        
        activity_calendar = []
        for i in range(30):
            date_obj = (datetime.utcnow() - timedelta(days=29-i)).date()
            sessions = next((sessions for date, sessions in daily_activity if date == date_obj), 0)
            activity_calendar.append({
                'date': date_obj.isoformat(),
                'sessions': sessions,
                'has_activity': sessions > 0
            })
        
        return {
            'current_streak': stats.current_streak,
            'longest_streak': stats.longest_streak,
            'activity_calendar': activity_calendar,
            'last_activity_date': stats.last_activity_date.isoformat() if stats.last_activity_date else None
        }
    
    def _get_performance_trends(self, user_id: int) -> Dict[str, Any]:
        """Get performance trends over time"""
        # Weekly performance for last 8 weeks
        weeks_data = []
        for i in range(8):
            week_start = datetime.utcnow() - timedelta(weeks=i+1)
            week_end = datetime.utcnow() - timedelta(weeks=i)
            
            week_stats = db.session.query(
                func.count(UserProgress.id).label('sessions'),
                func.avg(UserProgress.accuracy_rate).label('accuracy'),
                func.sum(UserProgress.time_spent).label('time_spent')
            ).filter(
                UserProgress.user_id == user_id,
                UserProgress.session_start >= week_start,
                UserProgress.session_start < week_end,
                UserProgress.completion_status == CompletionStatus.COMPLETED
            ).first()
            
            weeks_data.append({
                'week_start': week_start.strftime('%Y-%m-%d'),
                'sessions': week_stats.sessions or 0,
                'accuracy': round(float(week_stats.accuracy or 0), 1),
                'time_hours': round((week_stats.time_spent or 0) / 3600, 1)
            })
        
        weeks_data.reverse()  # Chronological order
        
        # Calculate trends
        if len(weeks_data) >= 2:
            recent_avg = sum(w['accuracy'] for w in weeks_data[-2:] if w['accuracy']) / 2
            older_avg = sum(w['accuracy'] for w in weeks_data[:2] if w['accuracy']) / 2
            accuracy_trend = recent_avg - older_avg if older_avg > 0 else 0
        else:
            accuracy_trend = 0
        
        return {
            'weekly_data': weeks_data,
            'accuracy_trend': round(accuracy_trend, 1),
            'trend_direction': 'improving' if accuracy_trend > 2 else 'declining' if accuracy_trend < -2 else 'stable'
        }
    
    # =============================================================================
    # REAL-TIME UPDATES
    # =============================================================================
    
    def _emit_session_update(self, user_id: int, event: str, data: Dict[str, Any]):
        """Emit real-time session update via WebSocket"""
        try:
            room = f"user_{user_id}"
            socketio.emit(event, data, room=room)
        except Exception as e:
            self.logger.error(f"Error emitting session update: {str(e)}")
    
    def _emit_achievement_unlocked(self, user_id: int, achievement: Dict[str, Any]):
        """Emit achievement unlock notification"""
        try:
            room = f"user_{user_id}"
            socketio.emit('achievement_unlocked', achievement, room=room)
        except Exception as e:
            self.logger.error(f"Error emitting achievement notification: {str(e)}")


# Global service instance
analytics_service = UnifiedAnalyticsService()