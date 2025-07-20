"""
Analytics Service for Vocabulary Learning Progress

Provides comprehensive analytics and progress tracking for vocabulary learning
including visual data preparation, achievements, and detailed reporting.
"""
from datetime import datetime, timedelta
from typing import List, Dict, Optional, Any, Tuple
from sqlalchemy import and_, or_, func, text, desc, asc
from sqlalchemy.orm import joinedload
from collections import defaultdict, Counter
import json
import calendar

from app import db
from app.models.user import User
from app.models.dictation_practice import DictationSession, DictationWordAttempt
from app.models.analytics import (
    UserProgress, LearningStats, UserAchievements, ErrorAnalysis,
    LearningRecommendations, AnalyticsCache, ModuleType, ActivityType,
    CompletionStatus, AchievementType, ErrorCategory, RecommendationType
)
from app.models.learning_session import LearningSession, Progress, UserWordProgress
from app.models.article import ReadingSession, QuestionAttempt


class AnalyticsService:
    """Service for generating comprehensive learning analytics"""
    
    @staticmethod
    def get_progress_dashboard(user_id: int) -> Dict[str, Any]:
        """Get comprehensive progress dashboard data"""
        
        # Check cache first
        cache_key = f"dashboard_{user_id}"
        cached_data = AnalyticsCache.get_cached_data(cache_key)
        if cached_data:
            return cached_data
        
        # Basic learning statistics
        learning_stats = AnalyticsService._get_learning_overview(user_id)
        
        # Learning progress over time
        progress_timeline = AnalyticsService._get_progress_timeline(user_id)
        
        # Module performance distribution
        module_performance = AnalyticsService._get_module_performance(user_id)
        
        # Recent activity
        recent_activity = AnalyticsService._get_recent_activity(user_id)
        
        # Achievements
        achievements = AnalyticsService._get_user_achievements(user_id)
        
        # Learning streaks
        streak_data = AnalyticsService._get_streak_analytics(user_id)
        
        # Performance trends
        performance_trends = AnalyticsService._get_performance_trends(user_id)
        
        dashboard_data = {
            'overview': learning_stats,
            'progress_timeline': progress_timeline,
            'module_performance': module_performance,
            'recent_activity': recent_activity,
            'achievements': achievements,
            'streak_data': streak_data,
            'performance_trends': performance_trends,
            'generated_at': datetime.utcnow().isoformat()
        }
        
        # Cache the result for 15 minutes
        AnalyticsCache.set_cached_data(cache_key, dashboard_data, user_id, 'dashboard', 15)
        
        return dashboard_data
    
    @staticmethod
    def _get_learning_overview(user_id: int) -> Dict[str, Any]:
        """Get basic learning statistics overview"""
        # Get or create learning stats
        learning_stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
        if not learning_stats:
            learning_stats = LearningStats(user_id=user_id)
            db.session.add(learning_stats)
            db.session.commit()
        
        # Calculate today's stats
        today = datetime.utcnow().date()
        today_sessions = UserProgress.query.filter(
            UserProgress.user_id == user_id,
            func.date(UserProgress.session_start) == today,
            UserProgress.completion_status == CompletionStatus.COMPLETED
        ).all()
        
        today_time = sum(session.time_spent for session in today_sessions) // 60  # Convert to minutes
        today_items = sum(session.items_attempted for session in today_sessions)
        today_accuracy = 0
        if today_sessions:
            total_correct = sum(session.items_correct for session in today_sessions)
            total_attempted = sum(session.items_attempted for session in today_sessions)
            if total_attempted > 0:
                today_accuracy = (total_correct / total_attempted) * 100
        
        # Words learned progress (from word progress)
        words_learned = UserWordProgress.query.filter(
            UserWordProgress.user_id == user_id,
            UserWordProgress.mastery_level >= 3  # Assuming level 3+ is "learned"
        ).count()
        
        return {
            'total_sessions': learning_stats.total_sessions,
            'total_time_spent': learning_stats.total_time_spent // 60,  # Convert to minutes
            'total_items_practiced': learning_stats.total_items_practiced,
            'average_accuracy': round(learning_stats.average_accuracy, 1),
            'current_streak': learning_stats.current_streak,
            'longest_streak': learning_stats.longest_streak,
            'words_learned': words_learned,
            'today_stats': {
                'study_time': today_time,
                'items_practiced': today_items,
                'accuracy': round(today_accuracy, 1)
            },
            'module_stats': {
                'dictation': {
                    'sessions': learning_stats.dictation_sessions,
                    'accuracy': round(learning_stats.dictation_accuracy, 1)
                },
                'vocabulary': {
                    'sessions': learning_stats.vocabulary_sessions,
                    'accuracy': round(learning_stats.vocabulary_accuracy, 1)
                },
                'reading': {
                    'sessions': learning_stats.reading_sessions,
                    'accuracy': round(learning_stats.reading_accuracy, 1)
                }
            }
        }
    
    @staticmethod
    def _get_progress_timeline(user_id: int, days: int = 30) -> Dict[str, Any]:
        """Get progress timeline for the last N days"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Daily learning activity
        daily_activity = (db.session.query(
            func.date(UserProgress.session_start).label('activity_date'),
            func.count(UserProgress.id).label('session_count'),
            func.sum(UserProgress.items_attempted).label('items_attempted'),
            func.sum(UserProgress.items_correct).label('items_correct'),
            func.sum(UserProgress.time_spent).label('total_time')
        ).filter(UserProgress.user_id == user_id)
         .filter(UserProgress.session_start >= cutoff_date)
         .filter(UserProgress.completion_status == CompletionStatus.COMPLETED)
         .group_by(func.date(UserProgress.session_start))
         .order_by(func.date(UserProgress.session_start))
         .all())
        
        # Format timeline data
        timeline_data = []
        activity_dict = {}
        for date, sessions, attempted, correct, time_spent in daily_activity:
            accuracy = (correct / max(1, attempted)) * 100 if attempted > 0 else 0
            activity_dict[str(date)] = {
                'sessions': sessions,
                'items_attempted': attempted or 0,
                'items_correct': correct or 0,
                'accuracy': accuracy,
                'time_spent': (time_spent or 0) // 60  # Convert to minutes
            }
        
        # Generate data for each day
        total_sessions = 0
        total_time = 0
        accuracy_sum = 0
        accuracy_days = 0
        
        for i in range(days):
            date = (datetime.utcnow() - timedelta(days=days-1-i)).date()
            date_str = str(date)
            
            day_data = activity_dict.get(date_str, {
                'sessions': 0,
                'items_attempted': 0,
                'items_correct': 0,
                'accuracy': 0,
                'time_spent': 0
            })
            
            timeline_data.append({
                'date': date_str,
                'sessions': day_data['sessions'],
                'items_attempted': day_data['items_attempted'],
                'items_correct': day_data['items_correct'],
                'accuracy': round(day_data['accuracy'], 1),
                'time_spent': day_data['time_spent']
            })
            
            total_sessions += day_data['sessions']
            total_time += day_data['time_spent']
            if day_data['accuracy'] > 0:
                accuracy_sum += day_data['accuracy']
                accuracy_days += 1
        
        return {
            'timeline': timeline_data,
            'period_days': days,
            'total_sessions': total_sessions,
            'total_time': total_time,
            'average_accuracy': round(accuracy_sum / max(1, accuracy_days), 1)
        }
    
    @staticmethod
    def _get_module_performance(user_id: int) -> List[Dict[str, Any]]:
        """Get performance breakdown by learning modules"""
        module_stats = (db.session.query(
            UserProgress.module_type,
            func.count(UserProgress.id).label('total_sessions'),
            func.avg(UserProgress.accuracy_rate).label('avg_accuracy'),
            func.sum(UserProgress.time_spent).label('total_time'),
            func.sum(UserProgress.items_attempted).label('total_items'),
            func.sum(UserProgress.items_correct).label('correct_items')
        ).filter(UserProgress.user_id == user_id)
         .filter(UserProgress.completion_status == CompletionStatus.COMPLETED)
         .group_by(UserProgress.module_type)
         .all())
        
        result = []
        for module_type, sessions, avg_accuracy, total_time, total_items, correct_items in module_stats:
            # Calculate recent progress (last 7 days)
            week_ago = datetime.utcnow() - timedelta(days=7)
            recent_sessions = UserProgress.query.filter(
                UserProgress.user_id == user_id,
                UserProgress.module_type == module_type,
                UserProgress.session_start >= week_ago,
                UserProgress.completion_status == CompletionStatus.COMPLETED
            ).count()
            
            result.append({
                'module_type': module_type.value,
                'module_name': {
                    'dictation': '听写练习',
                    'vocabulary': '词汇学习',
                    'reading': '阅读理解'
                }.get(module_type.value, module_type.value),
                'total_sessions': sessions,
                'average_accuracy': round(float(avg_accuracy or 0), 1),
                'total_time_minutes': (total_time or 0) // 60,
                'total_items': total_items or 0,
                'correct_items': correct_items or 0,
                'recent_sessions': recent_sessions,
                'progress_percentage': min(100, (sessions / max(1, 10)) * 100)  # Assuming 10 sessions as "good progress"
            })
        
        return result
    
    @staticmethod
    def _get_recent_activity(user_id: int, days: int = 7) -> Dict[str, Any]:
        """Get recent learning activity summary"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Recent sessions
        recent_sessions = UserProgress.query.filter(
            UserProgress.user_id == user_id,
            UserProgress.session_start >= cutoff_date
        ).order_by(desc(UserProgress.session_start)).limit(10).all()
        
        # Activity by module type
        module_activity = (db.session.query(
            UserProgress.module_type,
            func.count(UserProgress.id).label('count'),
            func.avg(UserProgress.accuracy_rate).label('accuracy')
        ).filter(UserProgress.user_id == user_id)
         .filter(UserProgress.session_start >= cutoff_date)
         .filter(UserProgress.completion_status == CompletionStatus.COMPLETED)
         .group_by(UserProgress.module_type)
         .all())
        
        module_breakdown = []
        for module_type, count, accuracy in module_activity:
            module_breakdown.append({
                'module_type': module_type.value,
                'module_name': {
                    'dictation': '听写练习',
                    'vocabulary': '词汇学习', 
                    'reading': '阅读理解'
                }.get(module_type.value, module_type.value),
                'session_count': count,
                'average_accuracy': round(float(accuracy or 0), 1)
            })
        
        return {
            'recent_sessions': [session.to_dict() for session in recent_sessions],
            'module_breakdown': module_breakdown,
            'total_recent_sessions': len(recent_sessions),
            'period_days': days
        }
    
    @staticmethod
    def _get_user_achievements(user_id: int) -> Dict[str, Any]:
        """Get user achievements and progress toward new ones"""
        # Current achievements
        current_achievements = UserAchievements.query.filter(
            UserAchievements.user_id == user_id,
            UserAchievements.is_displayed == True
        ).order_by(desc(UserAchievements.unlocked_at)).all()
        
        # Recent achievements (last 30 days)
        recent_cutoff = datetime.utcnow() - timedelta(days=30)
        recent_achievements = [
            ach for ach in current_achievements 
            if ach.unlocked_at >= recent_cutoff
        ]
        
        # Calculate potential new achievements
        potential_achievements = AnalyticsService._calculate_potential_achievements(user_id)
        
        return {
            'current_achievements': [ach.to_dict() for ach in current_achievements],
            'recent_achievements': [ach.to_dict() for ach in recent_achievements],
            'potential_achievements': potential_achievements,
            'total_achievements': len(current_achievements)
        }
    
    @staticmethod
    def _calculate_potential_achievements(user_id: int) -> List[Dict[str, Any]]:
        """Calculate achievements user is close to earning"""
        potential = []
        
        # Get user stats
        learning_stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
        if not learning_stats:
            return potential
        
        # Streak achievements
        current_streak = learning_stats.current_streak
        streak_milestones = [7, 14, 30, 60, 100]
        for milestone in streak_milestones:
            if current_streak < milestone:
                potential.append({
                    'type': 'streak',
                    'name': f'{milestone}天连续学习',
                    'description': f'连续学习{milestone}天',
                    'current_progress': current_streak,
                    'target': milestone,
                    'progress_percentage': round((current_streak / milestone) * 100, 1)
                })
                break
        
        # Session milestones
        total_sessions = learning_stats.total_sessions
        session_milestones = [10, 25, 50, 100, 250]
        for milestone in session_milestones:
            if total_sessions < milestone:
                potential.append({
                    'type': 'volume',
                    'name': f'完成{milestone}次练习',
                    'description': f'完成{milestone}次学习练习',
                    'current_progress': total_sessions,
                    'target': milestone,
                    'progress_percentage': round((total_sessions / milestone) * 100, 1)
                })
                break
        
        # Accuracy achievements
        accuracy = learning_stats.average_accuracy
        accuracy_milestones = [80, 90, 95]
        for milestone in accuracy_milestones:
            if accuracy < milestone:
                potential.append({
                    'type': 'accuracy',
                    'name': f'{milestone}%正确率',
                    'description': f'保持{milestone}%平均正确率',
                    'current_progress': round(accuracy, 1),
                    'target': milestone,
                    'progress_percentage': round((accuracy / milestone) * 100, 1)
                })
                break
        
        return potential
    
    @staticmethod
    def _get_streak_analytics(user_id: int) -> Dict[str, Any]:
        """Get detailed streak analytics"""
        learning_stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
        if not learning_stats:
            return {
                'current_streak': 0,
                'longest_streak': 0,
                'streak_history': [],
                'streak_goal': 7
            }
        
        # Get streak history (last 30 days)
        streak_history = AnalyticsService._get_streak_history(user_id, 30)
        
        return {
            'current_streak': learning_stats.current_streak,
            'longest_streak': learning_stats.longest_streak,
            'streak_history': streak_history,
            'streak_goal': max(7, learning_stats.current_streak + 1)
        }
    
    @staticmethod
    def _get_streak_history(user_id: int, days: int) -> List[Dict[str, Any]]:
        """Get streak history for visualization"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Get daily activity
        daily_activity = (db.session.query(
            func.date(UserProgress.session_start).label('date'),
            func.count(UserProgress.id).label('activity_count')
        ).filter(UserProgress.user_id == user_id)
         .filter(UserProgress.session_start >= cutoff_date)
         .filter(UserProgress.completion_status == CompletionStatus.COMPLETED)
         .group_by(func.date(UserProgress.session_start))
         .all())
        
        activity_dict = {str(date): count for date, count in daily_activity}
        
        # Generate daily streak data
        history = []
        for i in range(days):
            date = (datetime.utcnow() - timedelta(days=days-1-i)).date()
            date_str = str(date)
            
            history.append({
                'date': date_str,
                'has_activity': activity_dict.get(date_str, 0) > 0,
                'activity_count': activity_dict.get(date_str, 0)
            })
        
        return history
    
    @staticmethod
    def _get_performance_trends(user_id: int) -> Dict[str, Any]:
        """Get performance trends over time"""
        # Monthly performance for the last 6 months
        months_data = []
        for i in range(6):
            month_start = datetime.utcnow().replace(day=1) - timedelta(days=i*30)
            month_end = (month_start + timedelta(days=32)).replace(day=1) - timedelta(days=1)
            
            month_stats = (db.session.query(
                func.count(UserProgress.id).label('total_sessions'),
                func.avg(UserProgress.accuracy_rate).label('accuracy'),
                func.sum(UserProgress.time_spent).label('total_time')
            ).filter(UserProgress.user_id == user_id)
             .filter(UserProgress.session_start >= month_start)
             .filter(UserProgress.session_start <= month_end)
             .filter(UserProgress.completion_status == CompletionStatus.COMPLETED)
             .first())
            
            months_data.append({
                'month': month_start.strftime('%Y-%m'),
                'month_name': month_start.strftime('%B %Y'),
                'total_sessions': month_stats.total_sessions or 0,
                'accuracy': round(float(month_stats.accuracy or 0), 1),
                'total_time_minutes': (month_stats.total_time or 0) // 60
            })
        
        return {
            'monthly_performance': list(reversed(months_data)),
            'improvement_indicators': AnalyticsService._calculate_improvement_indicators(user_id)
        }
    
    @staticmethod
    def _calculate_improvement_indicators(user_id: int) -> Dict[str, Any]:
        """Calculate improvement indicators comparing recent vs older performance"""
        # Recent performance (last 7 days)
        recent_cutoff = datetime.utcnow() - timedelta(days=7)
        recent_stats = (db.session.query(
            func.avg(UserProgress.accuracy_rate).label('accuracy'),
            func.avg(UserProgress.time_spent).label('time_spent')
        ).filter(UserProgress.user_id == user_id)
         .filter(UserProgress.session_start >= recent_cutoff)
         .filter(UserProgress.completion_status == CompletionStatus.COMPLETED)
         .first())
        
        # Previous period (7-14 days ago)
        previous_start = datetime.utcnow() - timedelta(days=14)
        previous_end = datetime.utcnow() - timedelta(days=7)
        previous_stats = (db.session.query(
            func.avg(UserProgress.accuracy_rate).label('accuracy'),
            func.avg(UserProgress.time_spent).label('time_spent')
        ).filter(UserProgress.user_id == user_id)
         .filter(UserProgress.session_start >= previous_start)
         .filter(UserProgress.session_start <= previous_end)
         .filter(UserProgress.completion_status == CompletionStatus.COMPLETED)
         .first())
        
        indicators = {}
        
        if recent_stats.accuracy and previous_stats.accuracy:
            accuracy_change = recent_stats.accuracy - previous_stats.accuracy
            indicators['accuracy_trend'] = {
                'change_percentage': round(accuracy_change, 1),
                'direction': 'improving' if accuracy_change > 0 else 'declining' if accuracy_change < 0 else 'stable'
            }
        
        if recent_stats.time_spent and previous_stats.time_spent:
            time_change = ((recent_stats.time_spent - previous_stats.time_spent) / previous_stats.time_spent) * 100
            indicators['efficiency_trend'] = {
                'change_percentage': round(time_change, 1),
                'direction': 'faster' if time_change < 0 else 'slower' if time_change > 0 else 'stable'
            }
        
        return indicators
    
    @staticmethod
    def _generate_recommendations(user_id: int, dashboard_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Generate personalized learning recommendations"""
        recommendations = []
        
        overview = dashboard_data['overview']
        streak_data = dashboard_data['streak_data']
        
        # Streak recommendations
        if streak_data['current_streak'] == 0:
            recommendations.append({
                'type': 'streak',
                'priority': 'medium',
                'title': '开始学习连击',
                'description': '建立每日学习习惯，开始您的学习连击。',
                'action': '今天开始练习'
            })
        elif streak_data['current_streak'] < 7:
            recommendations.append({
                'type': 'streak',
                'priority': 'medium',
                'title': '继续学习连击',
                'description': f'您已连续学习{streak_data["current_streak"]}天，继续保持！',
                'action': '继续每日练习'
            })
        
        # Accuracy recommendations
        if overview['average_accuracy'] < 70:
            recommendations.append({
                'type': 'accuracy',
                'priority': 'high',
                'title': '提高学习准确率',
                'description': '您的平均准确率低于70%，建议复习基础内容。',
                'action': '复习基础练习'
            })
        
        # Activity recommendations
        if overview['total_sessions'] < 5:
            recommendations.append({
                'type': 'expansion',
                'priority': 'medium',
                'title': '增加学习频率',
                'description': '增加练习次数以提高学习效果。',
                'action': '浏览学习模块'
            })
        
        return recommendations
    
    
    @staticmethod
    def generate_progress_report(user_id: int, report_type: str = 'weekly') -> Dict[str, Any]:
        """Generate a comprehensive progress report"""
        if report_type == 'weekly':
            days = 7
        elif report_type == 'monthly':
            days = 30
        else:
            days = 7
        
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Get comprehensive data
        dashboard_data = AnalyticsService.get_progress_dashboard(user_id)
        
        # Additional report-specific data for UserProgress sessions
        period_stats = (db.session.query(
            func.count(UserProgress.id).label('total_sessions'),
            func.sum(UserProgress.items_correct).label('correct_items'),
            func.sum(UserProgress.items_attempted).label('attempted_items'),
            func.count(func.distinct(func.date(UserProgress.session_start))).label('active_days')
        ).filter(UserProgress.user_id == user_id)
         .filter(UserProgress.session_start >= cutoff_date)
         .filter(UserProgress.completion_status == CompletionStatus.COMPLETED)
         .first())
        
        # Words progress during period (from UserWordProgress)
        words_progress = (db.session.query(
            func.count(UserWordProgress.id).label('words_reviewed')
        ).filter(UserWordProgress.user_id == user_id)
         .first())
        
        report = {
            'report_type': report_type,
            'period_days': days,
            'period_start': cutoff_date.isoformat(),
            'period_end': datetime.utcnow().isoformat(),
            'period_summary': {
                'total_sessions': period_stats.total_sessions or 0,
                'correct_items': period_stats.correct_items or 0,
                'attempted_items': period_stats.attempted_items or 0,
                'accuracy': round(((period_stats.correct_items or 0) / max(1, period_stats.attempted_items or 1)) * 100, 1),
                'active_days': period_stats.active_days or 0,
                'words_reviewed': words_progress.words_reviewed or 0
            },
            'dashboard_data': dashboard_data,
            'recommendations': AnalyticsService._generate_recommendations(user_id, dashboard_data),
            'generated_at': datetime.utcnow().isoformat()
        }
        
        return report