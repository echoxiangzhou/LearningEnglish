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
def get_learning_overview():
    """Get basic learning statistics overview"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get basic statistics
        stats = AnalyticsService._get_learning_overview(user_id)
        
        return jsonify({
            'success': True,
            'data': stats
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting learning overview: {str(e)}")
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


@analytics_bp.route('/module-performance', methods=['GET'])
@jwt_required()
def get_module_performance():
    """Get performance breakdown by learning modules"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get module performance
        performance_data = AnalyticsService._get_module_performance(user_id)
        
        return jsonify({
            'success': True,
            'data': performance_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting module performance: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load module performance data'
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