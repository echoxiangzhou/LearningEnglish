"""
Analytics API Routes

Provides endpoints for vocabulary learning analytics, progress tracking,
and dashboard data visualization.
"""
from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.services.analytics_service import AnalyticsService
from app.models.user import User
from app import db
from datetime import datetime, timedelta
import logging

analytics_bp = Blueprint('analytics', __name__)
logger = logging.getLogger(__name__)


@analytics_bp.route('/dashboard', methods=['GET'])
@jwt_required()
def get_progress_dashboard():
    """Get comprehensive progress dashboard data"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get dashboard data
        dashboard_data = AnalyticsService.get_progress_dashboard(user_id)
        
        return jsonify({
            'success': True,
            'data': dashboard_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting progress dashboard: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load dashboard data'
        }), 500


@analytics_bp.route('/overview', methods=['GET'])
@jwt_required()
def get_vocabulary_overview():
    """Get basic vocabulary statistics overview"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get basic statistics
        stats = VocabularyService.get_vocabulary_statistics(user_id)
        
        return jsonify({
            'success': True,
            'data': stats
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting vocabulary overview: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load overview data'
        }), 500


@analytics_bp.route('/progress-timeline', methods=['GET'])
@jwt_required()
def get_progress_timeline():
    """Get progress timeline for a specific period"""
    try:
        user_id = int(get_jwt_identity())
        days = request.args.get('days', 30, type=int)
        
        # Validate days parameter
        if days not in [7, 14, 30, 60, 90]:
            days = 30
        
        # Get timeline data
        timeline_data = AnalyticsService._get_progress_timeline(user_id, days)
        
        return jsonify({
            'success': True,
            'data': timeline_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting progress timeline: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load timeline data'
        }), 500


@analytics_bp.route('/mastery-distribution', methods=['GET'])
@jwt_required()
def get_mastery_distribution():
    """Get mastery level distribution"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get mastery distribution
        mastery_data = AnalyticsService._get_mastery_distribution(user_id)
        
        return jsonify({
            'success': True,
            'data': mastery_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting mastery distribution: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load mastery data'
        }), 500


@analytics_bp.route('/category-performance', methods=['GET'])
@jwt_required()
def get_category_performance():
    """Get performance breakdown by vocabulary categories"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get category performance
        performance_data = AnalyticsService._get_category_performance(user_id)
        
        return jsonify({
            'success': True,
            'data': performance_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting category performance: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load category performance data'
        }), 500


@analytics_bp.route('/recent-activity', methods=['GET'])
@jwt_required()
def get_recent_activity():
    """Get recent learning activity"""
    try:
        user_id = int(get_jwt_identity())
        days = request.args.get('days', 7, type=int)
        
        # Validate days parameter
        if days not in [1, 3, 7, 14, 30]:
            days = 7
        
        # Get recent activity
        activity_data = AnalyticsService._get_recent_activity(user_id, days)
        
        return jsonify({
            'success': True,
            'data': activity_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting recent activity: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load recent activity data'
        }), 500


@analytics_bp.route('/achievements', methods=['GET'])
@jwt_required()
def get_user_achievements():
    """Get user achievements and progress"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get achievements data
        achievements_data = AnalyticsService._get_user_achievements(user_id)
        
        return jsonify({
            'success': True,
            'data': achievements_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting achievements: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load achievements data'
        }), 500


@analytics_bp.route('/streak-analytics', methods=['GET'])
@jwt_required()
def get_streak_analytics():
    """Get detailed streak analytics"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get streak data
        streak_data = AnalyticsService._get_streak_analytics(user_id)
        
        return jsonify({
            'success': True,
            'data': streak_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting streak analytics: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load streak data'
        }), 500


@analytics_bp.route('/performance-trends', methods=['GET'])
@jwt_required()
def get_performance_trends():
    """Get performance trends over time"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get performance trends
        trends_data = AnalyticsService._get_performance_trends(user_id)
        
        return jsonify({
            'success': True,
            'data': trends_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting performance trends: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load performance trends data'
        }), 500


@analytics_bp.route('/progress-report', methods=['GET'])
@jwt_required()
def generate_progress_report():
    """Generate a comprehensive progress report"""
    try:
        user_id = int(get_jwt_identity())
        report_type = request.args.get('type', 'weekly')
        
        # Validate report type
        if report_type not in ['weekly', 'monthly']:
            report_type = 'weekly'
        
        # Generate report
        report_data = AnalyticsService.generate_progress_report(user_id, report_type)
        
        return jsonify({
            'success': True,
            'data': report_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error generating progress report: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to generate progress report'
        }), 500


@analytics_bp.route('/learning-recommendations', methods=['GET'])
@jwt_required()
def get_learning_recommendations():
    """Get personalized learning recommendations"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get dashboard data for recommendations
        dashboard_data = AnalyticsService.get_progress_dashboard(user_id)
        
        # Generate recommendations
        recommendations = AnalyticsService._generate_recommendations(user_id, dashboard_data)
        
        return jsonify({
            'success': True,
            'data': {
                'recommendations': recommendations,
                'generated_at': datetime.utcnow().isoformat()
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting learning recommendations: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to generate recommendations'
        }), 500


@analytics_bp.route('/session-analytics', methods=['GET'])
@jwt_required()
def get_session_analytics():
    """Get analytics for vocabulary sessions"""
    try:
        user_id = int(get_jwt_identity())
        days = request.args.get('days', 30, type=int)
        
        # Get session data
        cutoff_date = datetime.utcnow() - timedelta(days=days)
        sessions = VocabularySession.query.filter(
            VocabularySession.user_id == user_id,
            VocabularySession.started_at >= cutoff_date
        ).order_by(VocabularySession.started_at.desc()).all()
        
        # Calculate session statistics
        total_sessions = len(sessions)
        completed_sessions = len([s for s in sessions if s.is_completed])
        total_words_studied = sum(s.words_studied for s in sessions)
        total_time = sum(s.total_time or 0 for s in sessions if s.total_time)
        
        # Average session metrics
        avg_words_per_session = total_words_studied / max(1, total_sessions)
        avg_time_per_session = total_time / max(1, completed_sessions)
        avg_accuracy = sum(s.calculate_accuracy() for s in sessions) / max(1, total_sessions)
        
        # Session type breakdown
        session_types = {}
        for session in sessions:
            session_type = session.session_type or 'unknown'
            if session_type not in session_types:
                session_types[session_type] = {
                    'count': 0,
                    'total_words': 0,
                    'avg_accuracy': 0
                }
            session_types[session_type]['count'] += 1
            session_types[session_type]['total_words'] += session.words_studied
            session_types[session_type]['avg_accuracy'] += session.calculate_accuracy()
        
        # Calculate averages for session types
        for session_type, data in session_types.items():
            data['avg_accuracy'] = round(data['avg_accuracy'] / data['count'], 1)
            data['avg_words_per_session'] = round(data['total_words'] / data['count'], 1)
        
        return jsonify({
            'success': True,
            'data': {
                'period_days': days,
                'summary': {
                    'total_sessions': total_sessions,
                    'completed_sessions': completed_sessions,
                    'completion_rate': round((completed_sessions / max(1, total_sessions)) * 100, 1),
                    'total_words_studied': total_words_studied,
                    'total_time_seconds': total_time,
                    'avg_words_per_session': round(avg_words_per_session, 1),
                    'avg_time_per_session': round(avg_time_per_session, 1),
                    'avg_accuracy': round(avg_accuracy, 1)
                },
                'session_types': session_types,
                'recent_sessions': [session.to_dict() for session in sessions[:10]]
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting session analytics: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load session analytics'
        }), 500


@analytics_bp.route('/word-progress/<int:word_id>', methods=['GET'])
@jwt_required()
def get_word_progress(word_id):
    """Get detailed progress for a specific word"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get user vocabulary entry
        user_vocab = UserVocabulary.query.filter(
            UserVocabulary.user_id == user_id,
            UserVocabulary.word_id == word_id
        ).first()
        
        if not user_vocab:
            return jsonify({
                'success': False,
                'error': 'Word not found in user vocabulary'
            }), 404
        
        # Get test history
        test_history = VocabularyTestResult.query.filter(
            VocabularyTestResult.user_id == user_id,
            VocabularyTestResult.word_id == word_id
        ).order_by(VocabularyTestResult.created_at.desc()).all()
        
        # Calculate progress metrics
        total_attempts = len(test_history)
        correct_attempts = len([t for t in test_history if t.is_correct])
        accuracy = (correct_attempts / max(1, total_attempts)) * 100
        
        # Recent performance (last 5 attempts)
        recent_attempts = test_history[:5]
        recent_accuracy = (len([t for t in recent_attempts if t.is_correct]) / max(1, len(recent_attempts))) * 100
        
        return jsonify({
            'success': True,
            'data': {
                'word_id': word_id,
                'user_vocabulary': user_vocab.to_dict(),
                'progress_metrics': {
                    'total_attempts': total_attempts,
                    'correct_attempts': correct_attempts,
                    'accuracy': round(accuracy, 1),
                    'recent_accuracy': round(recent_accuracy, 1),
                    'mastery_level': user_vocab.mastery_level.value,
                    'next_review': user_vocab.next_review.isoformat() if user_vocab.next_review else None,
                    'learning_days': (datetime.utcnow() - user_vocab.first_seen).days
                },
                'test_history': [test.to_dict() for test in test_history[:20]]  # Last 20 attempts
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting word progress: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load word progress'
        }), 500


@analytics_bp.route('/export-data', methods=['GET'])
@jwt_required()
def export_user_data():
    """Export user's vocabulary learning data"""
    try:
        user_id = int(get_jwt_identity())
        format_type = request.args.get('format', 'json')
        
        if format_type not in ['json', 'csv']:
            format_type = 'json'
        
        # Get comprehensive user data
        user_vocabulary = UserVocabulary.query.filter(
            UserVocabulary.user_id == user_id
        ).all()
        
        test_results = VocabularyTestResult.query.filter(
            VocabularyTestResult.user_id == user_id
        ).all()
        
        sessions = VocabularySession.query.filter(
            VocabularySession.user_id == user_id
        ).all()
        
        export_data = {
            'export_date': datetime.utcnow().isoformat(),
            'user_id': user_id,
            'vocabulary_progress': [vocab.to_dict() for vocab in user_vocabulary],
            'test_results': [test.to_dict() for test in test_results],
            'sessions': [session.to_dict() for session in sessions],
            'summary': {
                'total_words': len(user_vocabulary),
                'total_tests': len(test_results),
                'total_sessions': len(sessions)
            }
        }
        
        if format_type == 'csv':
            # For CSV, we'd need to implement CSV formatting
            # For now, return JSON with CSV indication
            return jsonify({
                'success': True,
                'message': 'CSV export not implemented yet',
                'data': export_data
            }), 200
        
        return jsonify({
            'success': True,
            'data': export_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error exporting user data: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to export data'
        }), 500


# Error handlers
@analytics_bp.errorhandler(400)
def bad_request(error):
    return jsonify({
        'success': False,
        'error': 'Bad request'
    }), 400


@analytics_bp.errorhandler(404)
def not_found(error):
    return jsonify({
        'success': False,
        'error': 'Resource not found'
    }), 404


@analytics_bp.errorhandler(500)
def internal_error(error):
    return jsonify({
        'success': False,
        'error': 'Internal server error'
    }), 500