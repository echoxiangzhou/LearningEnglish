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
# Vocabulary models removed - analytics now focuses on dictation and reading
from app.models.word import Word
from app.models.user import User
from app.models.dictation_practice import DictationSession, DictationWordAttempt


class AnalyticsService:
    """Service for generating comprehensive learning analytics"""
    
    @staticmethod
    def get_progress_dashboard(user_id: int) -> Dict[str, Any]:
        """Get comprehensive progress dashboard data"""
        
        # Basic vocabulary statistics
        vocab_stats = AnalyticsService._get_vocabulary_overview(user_id)
        
        # Learning progress over time
        progress_timeline = AnalyticsService._get_progress_timeline(user_id)
        
        # Mastery distribution
        mastery_distribution = AnalyticsService._get_mastery_distribution(user_id)
        
        # Category performance
        category_performance = AnalyticsService._get_category_performance(user_id)
        
        # Recent activity
        recent_activity = AnalyticsService._get_recent_activity(user_id)
        
        # Achievements
        achievements = AnalyticsService._get_user_achievements(user_id)
        
        # Learning streaks
        streak_data = AnalyticsService._get_streak_analytics(user_id)
        
        # Performance trends
        performance_trends = AnalyticsService._get_performance_trends(user_id)
        
        return {
            'overview': vocab_stats,
            'progress_timeline': progress_timeline,
            'mastery_distribution': mastery_distribution,
            'category_performance': category_performance,
            'recent_activity': recent_activity,
            'achievements': achievements,
            'streak_data': streak_data,
            'performance_trends': performance_trends,
            'generated_at': datetime.utcnow().isoformat()
        }
    
    @staticmethod
    def _get_vocabulary_overview(user_id: int) -> Dict[str, Any]:
        """Get basic vocabulary statistics overview"""
        total_words = UserVocabulary.query.filter(UserVocabulary.user_id == user_id).count()
        
        # Words by mastery level
        mastery_counts = (db.session.query(
            UserVocabulary.mastery_level,
            func.count(UserVocabulary.id)
        ).filter(UserVocabulary.user_id == user_id)
         .group_by(UserVocabulary.mastery_level)
         .all())
        
        mastery_stats = {level.value: 0 for level in MasteryLevel}
        for level, count in mastery_counts:
            mastery_stats[level.value] = count
        
        # Due for review
        due_count = (UserVocabulary.query
                    .filter(UserVocabulary.user_id == user_id)
                    .filter(or_(
                        UserVocabulary.due_for_review == True,
                        UserVocabulary.next_review <= datetime.utcnow()
                    )).count())
        
        # Average success rate
        avg_success_rate = (db.session.query(func.avg(UserVocabulary.success_rate))
                           .filter(UserVocabulary.user_id == user_id)
                           .filter(UserVocabulary.review_count > 0)
                           .scalar() or 0.0)
        
        # Total test attempts
        total_tests = VocabularyTestResult.query.filter(
            VocabularyTestResult.user_id == user_id
        ).count()
        
        # Recent accuracy (last 7 days)
        recent_cutoff = datetime.utcnow() - timedelta(days=7)
        recent_accuracy = (db.session.query(func.avg(func.cast(VocabularyTestResult.is_correct, db.Float)))
                          .filter(VocabularyTestResult.user_id == user_id)
                          .filter(VocabularyTestResult.created_at >= recent_cutoff)
                          .scalar() or 0.0)
        
        return {
            'total_words': total_words,
            'mastery_distribution': mastery_stats,
            'due_for_review': due_count,
            'average_success_rate': round(avg_success_rate * 100, 1),
            'recent_accuracy': round(recent_accuracy * 100, 1),
            'total_tests': total_tests,
            'mastered_words': mastery_stats.get('mastered', 0),
            'learning_words': mastery_stats.get('learning', 0) + mastery_stats.get('familiar', 0)
        }
    
    @staticmethod
    def _get_progress_timeline(user_id: int, days: int = 30) -> Dict[str, Any]:
        """Get progress timeline for the last N days"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Daily test activity
        daily_tests = (db.session.query(
            func.date(VocabularyTestResult.created_at).label('test_date'),
            func.count(VocabularyTestResult.id).label('test_count'),
            func.avg(func.cast(VocabularyTestResult.is_correct, db.Float)).label('accuracy')
        ).filter(VocabularyTestResult.user_id == user_id)
         .filter(VocabularyTestResult.created_at >= cutoff_date)
         .group_by(func.date(VocabularyTestResult.created_at))
         .order_by(func.date(VocabularyTestResult.created_at))
         .all())
        
        # Daily new words added
        daily_new_words = (db.session.query(
            func.date(UserVocabulary.first_seen).label('date'),
            func.count(UserVocabulary.id).label('new_words')
        ).filter(UserVocabulary.user_id == user_id)
         .filter(UserVocabulary.first_seen >= cutoff_date)
         .group_by(func.date(UserVocabulary.first_seen))
         .order_by(func.date(UserVocabulary.first_seen))
         .all())
        
        # Format timeline data
        timeline_data = []
        test_dict = {str(date): {'count': count, 'accuracy': float(accuracy) if accuracy else 0.0} 
                    for date, count, accuracy in daily_tests}
        new_words_dict = {str(date): count for date, count in daily_new_words}
        
        # Generate data for each day
        for i in range(days):
            date = (datetime.utcnow() - timedelta(days=days-1-i)).date()
            date_str = str(date)
            
            timeline_data.append({
                'date': date_str,
                'test_count': test_dict.get(date_str, {}).get('count', 0),
                'accuracy': test_dict.get(date_str, {}).get('accuracy', 0.0),
                'new_words': new_words_dict.get(date_str, 0)
            })
        
        return {
            'timeline': timeline_data,
            'period_days': days,
            'total_tests': sum(item['test_count'] for item in timeline_data),
            'average_accuracy': sum(item['accuracy'] for item in timeline_data if item['accuracy'] > 0) / 
                               max(1, len([item for item in timeline_data if item['accuracy'] > 0]))
        }
    
    @staticmethod
    def _get_mastery_distribution(user_id: int) -> Dict[str, Any]:
        """Get detailed mastery level distribution with trends"""
        # Current distribution
        current_distribution = (db.session.query(
            UserVocabulary.mastery_level,
            func.count(UserVocabulary.id)
        ).filter(UserVocabulary.user_id == user_id)
         .group_by(UserVocabulary.mastery_level)
         .all())
        
        distribution = {level.value: 0 for level in MasteryLevel}
        total_words = 0
        
        for level, count in current_distribution:
            distribution[level.value] = count
            total_words += count
        
        # Calculate percentages
        percentages = {}
        for level, count in distribution.items():
            percentages[level] = round((count / max(1, total_words)) * 100, 1)
        
        # Weekly progression (words that changed mastery levels)
        week_ago = datetime.utcnow() - timedelta(days=7)
        recent_progressions = (db.session.query(
            UserVocabulary.mastery_level,
            func.count(UserVocabulary.id)
        ).filter(UserVocabulary.user_id == user_id)
         .filter(UserVocabulary.last_updated >= week_ago)
         .group_by(UserVocabulary.mastery_level)
         .all())
        
        weekly_changes = {level.value: 0 for level in MasteryLevel}
        for level, count in recent_progressions:
            weekly_changes[level.value] = count
        
        return {
            'distribution': distribution,
            'percentages': percentages,
            'total_words': total_words,
            'weekly_changes': weekly_changes,
            'mastery_score': AnalyticsService._calculate_mastery_score(distribution)
        }
    
    @staticmethod
    def _calculate_mastery_score(distribution: Dict[str, int]) -> float:
        """Calculate overall mastery score (0-100)"""
        weights = {
            'new': 0,
            'learning': 20,
            'familiar': 40,
            'proficient': 70,
            'mastered': 100
        }
        
        total_score = 0
        total_words = 0
        
        for level, count in distribution.items():
            total_score += weights.get(level, 0) * count
            total_words += count
        
        return round(total_score / max(1, total_words), 1)
    
    @staticmethod
    def _get_category_performance(user_id: int) -> List[Dict[str, Any]]:
        """Get performance breakdown by vocabulary categories"""
        category_stats = (db.session.query(
            VocabularyCategory.id,
            VocabularyCategory.name,
            func.count(UserVocabulary.id).label('total_words'),
            func.avg(UserVocabulary.success_rate).label('avg_success_rate'),
            func.count(
                func.case([(UserVocabulary.mastery_level == MasteryLevel.MASTERED, 1)])
            ).label('mastered_count')
        ).join(Word.categories)
         .join(UserVocabulary, UserVocabulary.word_id == Word.id)
         .filter(UserVocabulary.user_id == user_id)
         .group_by(VocabularyCategory.id, VocabularyCategory.name)
         .order_by(desc('avg_success_rate'))
         .all())
        
        result = []
        for category_id, name, total, avg_rate, mastered in category_stats:
            result.append({
                'category_id': category_id,
                'category_name': name,
                'total_words': total,
                'mastered_words': mastered,
                'average_success_rate': round(float(avg_rate or 0) * 100, 1),
                'mastery_percentage': round((mastered / max(1, total)) * 100, 1)
            })
        
        return result
    
    @staticmethod
    def _get_recent_activity(user_id: int, days: int = 7) -> Dict[str, Any]:
        """Get recent learning activity summary"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Recent tests
        recent_tests = VocabularyTestResult.query.filter(
            VocabularyTestResult.user_id == user_id,
            VocabularyTestResult.created_at >= cutoff_date
        ).order_by(desc(VocabularyTestResult.created_at)).limit(10).all()
        
        # Recent sessions
        recent_sessions = VocabularySession.query.filter(
            VocabularySession.user_id == user_id,
            VocabularySession.started_at >= cutoff_date
        ).order_by(desc(VocabularySession.started_at)).limit(5).all()
        
        # Activity by test type
        test_type_stats = (db.session.query(
            VocabularyTestResult.test_type,
            func.count(VocabularyTestResult.id).label('count'),
            func.avg(func.cast(VocabularyTestResult.is_correct, db.Float)).label('accuracy')
        ).filter(VocabularyTestResult.user_id == user_id)
         .filter(VocabularyTestResult.created_at >= cutoff_date)
         .group_by(VocabularyTestResult.test_type)
         .all())
        
        test_types = []
        for test_type, count, accuracy in test_type_stats:
            test_types.append({
                'test_type': test_type.value,
                'count': count,
                'accuracy': round(float(accuracy) * 100, 1)
            })
        
        return {
            'recent_tests': [test.to_dict() for test in recent_tests],
            'recent_sessions': [session.to_dict() for session in recent_sessions],
            'test_type_breakdown': test_types,
            'total_recent_tests': len(recent_tests),
            'total_recent_sessions': len(recent_sessions)
        }
    
    @staticmethod
    def _get_user_achievements(user_id: int) -> Dict[str, Any]:
        """Get user achievements and progress toward new ones"""
        # Current achievements
        current_achievements = VocabularyAchievement.query.filter(
            VocabularyAchievement.user_id == user_id,
            VocabularyAchievement.is_displayed == True
        ).order_by(desc(VocabularyAchievement.earned_at)).all()
        
        # Calculate potential new achievements
        potential_achievements = AnalyticsService._calculate_potential_achievements(user_id)
        
        # Recent achievements (last 30 days)
        recent_cutoff = datetime.utcnow() - timedelta(days=30)
        recent_achievements = [
            ach for ach in current_achievements 
            if ach.earned_at >= recent_cutoff
        ]
        
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
        stats = AnalyticsService._get_vocabulary_overview(user_id)
        streak = AnalyticsService._calculate_learning_streak(user_id)
        
        # Streak achievements
        streak_milestones = [7, 14, 30, 60, 100]
        for milestone in streak_milestones:
            if streak < milestone:
                potential.append({
                    'type': 'streak',
                    'name': f'{milestone} Day Streak',
                    'description': f'Study vocabulary for {milestone} consecutive days',
                    'current_progress': streak,
                    'target': milestone,
                    'progress_percentage': round((streak / milestone) * 100, 1)
                })
                break
        
        # Mastery achievements
        mastered_count = stats['mastered_words']
        mastery_milestones = [10, 25, 50, 100, 250, 500]
        for milestone in mastery_milestones:
            if mastered_count < milestone:
                potential.append({
                    'type': 'mastery',
                    'name': f'{milestone} Words Mastered',
                    'description': f'Reach mastery level on {milestone} words',
                    'current_progress': mastered_count,
                    'target': milestone,
                    'progress_percentage': round((mastered_count / milestone) * 100, 1)
                })
                break
        
        # Accuracy achievements
        accuracy = stats['average_success_rate']
        accuracy_milestones = [80, 90, 95]
        for milestone in accuracy_milestones:
            if accuracy < milestone:
                potential.append({
                    'type': 'accuracy',
                    'name': f'{milestone}% Accuracy',
                    'description': f'Maintain {milestone}% average accuracy',
                    'current_progress': accuracy,
                    'target': milestone,
                    'progress_percentage': round((accuracy / milestone) * 100, 1)
                })
                break
        
        return potential
    
    @staticmethod
    def _get_streak_analytics(user_id: int) -> Dict[str, Any]:
        """Get detailed streak analytics"""
        current_streak = AnalyticsService._calculate_learning_streak(user_id)
        
        # Longest streak
        longest_streak = AnalyticsService._calculate_longest_streak(user_id)
        
        # Streak history (last 30 days)
        streak_history = AnalyticsService._get_streak_history(user_id, 30)
        
        return {
            'current_streak': current_streak,
            'longest_streak': longest_streak,
            'streak_history': streak_history,
            'streak_goal': max(7, current_streak + 1)  # Next milestone
        }
    
    @staticmethod
    def _calculate_learning_streak(user_id: int) -> int:
        """Calculate current consecutive learning streak"""
        # Get unique test dates for the last 60 days
        cutoff_date = datetime.utcnow() - timedelta(days=60)
        test_dates = (db.session.query(
            func.date(VocabularyTestResult.created_at).label('test_date')
        ).filter(VocabularyTestResult.user_id == user_id)
         .filter(VocabularyTestResult.created_at >= cutoff_date)
         .distinct()
         .order_by(func.date(VocabularyTestResult.created_at).desc())
         .all())
        
        if not test_dates:
            return 0
        
        # Calculate consecutive days
        streak = 0
        current_date = datetime.utcnow().date()
        
        for test_date_tuple in test_dates:
            test_date = test_date_tuple[0]
            days_diff = (current_date - test_date).days
            
            if days_diff == streak:
                streak += 1
            elif days_diff == streak + 1:
                streak += 1
            else:
                break
        
        return streak
    
    @staticmethod
    def _calculate_longest_streak(user_id: int) -> int:
        """Calculate the longest streak ever achieved"""
        # Get all test dates
        test_dates = (db.session.query(
            func.date(VocabularyTestResult.created_at).label('test_date')
        ).filter(VocabularyTestResult.user_id == user_id)
         .distinct()
         .order_by(func.date(VocabularyTestResult.created_at))
         .all())
        
        if not test_dates:
            return 0
        
        dates = [test_date[0] for test_date in test_dates]
        
        longest_streak = 0
        current_streak = 1
        
        for i in range(1, len(dates)):
            if (dates[i] - dates[i-1]).days == 1:
                current_streak += 1
            else:
                longest_streak = max(longest_streak, current_streak)
                current_streak = 1
        
        return max(longest_streak, current_streak)
    
    @staticmethod
    def _get_streak_history(user_id: int, days: int) -> List[Dict[str, Any]]:
        """Get streak history for visualization"""
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        
        # Get daily activity
        daily_activity = (db.session.query(
            func.date(VocabularyTestResult.created_at).label('date'),
            func.count(VocabularyTestResult.id).label('activity_count')
        ).filter(VocabularyTestResult.user_id == user_id)
         .filter(VocabularyTestResult.created_at >= cutoff_date)
         .group_by(func.date(VocabularyTestResult.created_at))
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
                func.count(VocabularyTestResult.id).label('total_tests'),
                func.avg(func.cast(VocabularyTestResult.is_correct, db.Float)).label('accuracy'),
                func.avg(VocabularyTestResult.response_time).label('avg_response_time')
            ).filter(VocabularyTestResult.user_id == user_id)
             .filter(VocabularyTestResult.created_at >= month_start)
             .filter(VocabularyTestResult.created_at <= month_end)
             .first())
            
            months_data.append({
                'month': month_start.strftime('%Y-%m'),
                'month_name': month_start.strftime('%B %Y'),
                'total_tests': month_stats.total_tests or 0,
                'accuracy': round(float(month_stats.accuracy or 0) * 100, 1),
                'avg_response_time': round(float(month_stats.avg_response_time or 0), 1)
            })
        
        # Response time trends
        response_time_trends = (db.session.query(
            func.date(VocabularyTestResult.created_at).label('date'),
            func.avg(VocabularyTestResult.response_time).label('avg_time')
        ).filter(VocabularyTestResult.user_id == user_id)
         .filter(VocabularyTestResult.created_at >= datetime.utcnow() - timedelta(days=30))
         .group_by(func.date(VocabularyTestResult.created_at))
         .order_by(func.date(VocabularyTestResult.created_at))
         .all())
        
        return {
            'monthly_performance': list(reversed(months_data)),
            'response_time_trend': [
                {
                    'date': str(date),
                    'avg_response_time': round(float(avg_time), 1)
                } for date, avg_time in response_time_trends
            ],
            'improvement_indicators': AnalyticsService._calculate_improvement_indicators(user_id)
        }
    
    @staticmethod
    def _calculate_improvement_indicators(user_id: int) -> Dict[str, Any]:
        """Calculate improvement indicators comparing recent vs older performance"""
        # Recent performance (last 7 days)
        recent_cutoff = datetime.utcnow() - timedelta(days=7)
        recent_stats = (db.session.query(
            func.avg(func.cast(VocabularyTestResult.is_correct, db.Float)).label('accuracy'),
            func.avg(VocabularyTestResult.response_time).label('response_time')
        ).filter(VocabularyTestResult.user_id == user_id)
         .filter(VocabularyTestResult.created_at >= recent_cutoff)
         .first())
        
        # Previous period (7-14 days ago)
        previous_start = datetime.utcnow() - timedelta(days=14)
        previous_end = datetime.utcnow() - timedelta(days=7)
        previous_stats = (db.session.query(
            func.avg(func.cast(VocabularyTestResult.is_correct, db.Float)).label('accuracy'),
            func.avg(VocabularyTestResult.response_time).label('response_time')
        ).filter(VocabularyTestResult.user_id == user_id)
         .filter(VocabularyTestResult.created_at >= previous_start)
         .filter(VocabularyTestResult.created_at <= previous_end)
         .first())
        
        indicators = {}
        
        if recent_stats.accuracy and previous_stats.accuracy:
            accuracy_change = (recent_stats.accuracy - previous_stats.accuracy) * 100
            indicators['accuracy_trend'] = {
                'change_percentage': round(accuracy_change, 1),
                'direction': 'improving' if accuracy_change > 0 else 'declining' if accuracy_change < 0 else 'stable'
            }
        
        if recent_stats.response_time and previous_stats.response_time:
            time_change = ((recent_stats.response_time - previous_stats.response_time) / previous_stats.response_time) * 100
            indicators['speed_trend'] = {
                'change_percentage': round(time_change, 1),
                'direction': 'faster' if time_change < 0 else 'slower' if time_change > 0 else 'stable'
            }
        
        return indicators
    
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
        
        # Additional report-specific data
        period_stats = (db.session.query(
            func.count(VocabularyTestResult.id).label('total_tests'),
            func.sum(func.cast(VocabularyTestResult.is_correct, db.Integer)).label('correct_tests'),
            func.count(func.distinct(func.date(VocabularyTestResult.created_at))).label('active_days')
        ).filter(VocabularyTestResult.user_id == user_id)
         .filter(VocabularyTestResult.created_at >= cutoff_date)
         .first())
        
        # Words progress during period
        words_progress = (db.session.query(
            func.count(UserVocabulary.id).label('words_reviewed'),
            func.sum(func.case([(UserVocabulary.last_updated >= cutoff_date, 1)], else_=0)).label('words_updated')
        ).filter(UserVocabulary.user_id == user_id)
         .first())
        
        report = {
            'report_type': report_type,
            'period_days': days,
            'period_start': cutoff_date.isoformat(),
            'period_end': datetime.utcnow().isoformat(),
            'period_summary': {
                'total_tests': period_stats.total_tests or 0,
                'correct_tests': period_stats.correct_tests or 0,
                'accuracy': round(((period_stats.correct_tests or 0) / max(1, period_stats.total_tests or 1)) * 100, 1),
                'active_days': period_stats.active_days or 0,
                'words_reviewed': words_progress.words_reviewed or 0,
                'words_updated': words_progress.words_updated or 0
            },
            'dashboard_data': dashboard_data,
            'recommendations': AnalyticsService._generate_recommendations(user_id, dashboard_data),
            'generated_at': datetime.utcnow().isoformat()
        }
        
        return report
    
    @staticmethod
    def _generate_recommendations(user_id: int, dashboard_data: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Generate personalized learning recommendations"""
        recommendations = []
        
        overview = dashboard_data['overview']
        streak_data = dashboard_data['streak_data']
        
        # Review recommendations
        if overview['due_for_review'] > 0:
            recommendations.append({
                'type': 'review',
                'priority': 'high',
                'title': 'Review Due Words',
                'description': f'You have {overview["due_for_review"]} words due for review. Review them to maintain your progress.',
                'action': 'Start review session'
            })
        
        # Streak recommendations
        if streak_data['current_streak'] == 0:
            recommendations.append({
                'type': 'streak',
                'priority': 'medium',
                'title': 'Start Your Learning Streak',
                'description': 'Begin a daily learning streak to build consistent study habits.',
                'action': 'Practice vocabulary today'
            })
        elif streak_data['current_streak'] < 7:
            recommendations.append({
                'type': 'streak',
                'priority': 'medium',
                'title': 'Build Your Streak',
                'description': f'You have a {streak_data["current_streak"]} day streak. Keep it going!',
                'action': 'Continue daily practice'
            })
        
        # Accuracy recommendations
        if overview['average_success_rate'] < 70:
            recommendations.append({
                'type': 'accuracy',
                'priority': 'high',
                'title': 'Improve Accuracy',
                'description': 'Your accuracy is below 70%. Focus on reviewing familiar words.',
                'action': 'Review lower-level words'
            })
        
        # New words recommendations
        if overview['learning_words'] < 5:
            recommendations.append({
                'type': 'expansion',
                'priority': 'medium',
                'title': 'Learn New Words',
                'description': 'Add more words to your vocabulary to expand your learning.',
                'action': 'Browse vocabulary categories'
            })
        
        return recommendations