"""
Unified Analytics API Routes

Enhanced analytics endpoints that provide comprehensive cross-module analytics,
real-time progress tracking, achievements, and personalized recommendations.
"""

from flask import Blueprint, request, jsonify, send_file
from flask_jwt_extended import jwt_required, get_jwt_identity
from datetime import datetime, timedelta
import logging
import json
import csv
import io
from typing import Dict, Any

from app.services.unified_analytics_service import analytics_service
from app.models.analytics import (
    UserProgress, LearningStats, UserAchievements, ErrorAnalysis,
    LearningRecommendations, ModuleType, ActivityType, CompletionStatus,
    AchievementType, ErrorCategory, RecommendationType
)
from app.models.user import User
from app import db

unified_analytics_bp = Blueprint('unified_analytics', __name__)
logger = logging.getLogger(__name__)


# =============================================================================
# DASHBOARD ENDPOINTS
# =============================================================================

@unified_analytics_bp.route('/dashboard', methods=['GET'])
@jwt_required()
def get_unified_dashboard():
    """Get comprehensive analytics dashboard across all modules"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get unified dashboard data
        dashboard_data = analytics_service.get_unified_dashboard(user_id)
        
        return jsonify({
            'success': True,
            'data': dashboard_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting unified dashboard: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load dashboard data'
        }), 500


@unified_analytics_bp.route('/overview', methods=['GET'])
@jwt_required()
def get_analytics_overview():
    """Get high-level analytics overview"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get learning statistics
        stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
        if not stats:
            stats = LearningStats(user_id=user_id)
            db.session.add(stats)
            db.session.commit()
        
        # Get recent activity count
        week_ago = datetime.utcnow() - timedelta(days=7)
        recent_sessions = UserProgress.query.filter(
            UserProgress.user_id == user_id,
            UserProgress.session_start >= week_ago,
            UserProgress.completion_status == CompletionStatus.COMPLETED
        ).count()
        
        # Get achievement count
        achievement_count = UserAchievements.query.filter(
            UserAchievements.user_id == user_id
        ).count()
        
        overview_data = {
            'total_sessions': stats.total_sessions,
            'total_time_hours': round(stats.total_time_spent / 3600, 1),
            'average_accuracy': round(stats.average_accuracy, 1),
            'current_streak': stats.current_streak,
            'longest_streak': stats.longest_streak,
            'recent_sessions': recent_sessions,
            'total_achievements': achievement_count,
            'last_activity': stats.last_activity_date.isoformat() if stats.last_activity_date else None
        }
        
        return jsonify({
            'success': True,
            'data': overview_data
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting analytics overview: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load overview data'
        }), 500


# =============================================================================
# PROGRESS TRACKING ENDPOINTS
# =============================================================================

@unified_analytics_bp.route('/sessions', methods=['POST'])
@jwt_required()
def start_session():
    """Start a new learning session"""
    try:
        user_id = int(get_jwt_identity())
        data = request.get_json()
        
        # Validate required fields
        module_type = data.get('module_type')
        activity_type = data.get('activity_type')
        
        if not module_type or not activity_type:
            return jsonify({
                'success': False,
                'error': 'module_type and activity_type are required'
            }), 400
        
        try:
            module_enum = ModuleType(module_type.upper())
            activity_enum = ActivityType(activity_type.upper())
        except ValueError:
            return jsonify({
                'success': False,
                'error': 'Invalid module_type or activity_type'
            }), 400
        
        session_data = data.get('session_data', {})
        
        # Start tracking session
        session_id = analytics_service.track_session_start(
            user_id=user_id,
            module_type=module_enum,
            activity_type=activity_enum,
            session_data=session_data
        )
        
        if session_id:
            return jsonify({
                'success': True,
                'data': {'session_id': session_id}
            }), 201
        else:
            return jsonify({
                'success': False,
                'error': 'Failed to start session'
            }), 500
        
    except Exception as e:
        logger.error(f"Error starting session: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to start session'
        }), 500


@unified_analytics_bp.route('/sessions/<int:session_id>', methods=['PUT'])
@jwt_required()
def update_session(session_id):
    """Update progress for an ongoing session"""
    try:
        user_id = int(get_jwt_identity())
        data = request.get_json()
        
        # Verify session belongs to user
        session = UserProgress.query.filter(
            UserProgress.id == session_id,
            UserProgress.user_id == user_id
        ).first()
        
        if not session:
            return jsonify({
                'success': False,
                'error': 'Session not found'
            }), 404
        
        # Update session progress
        success = analytics_service.update_session_progress(
            session_id=session_id,
            items_attempted=data.get('items_attempted'),
            items_correct=data.get('items_correct'),
            hints_used=data.get('hints_used'),
            session_data=data.get('session_data')
        )
        
        if success:
            return jsonify({
                'success': True,
                'data': {'session_id': session_id}
            }), 200
        else:
            return jsonify({
                'success': False,
                'error': 'Failed to update session'
            }), 500
        
    except Exception as e:
        logger.error(f"Error updating session: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to update session'
        }), 500


@unified_analytics_bp.route('/sessions/<int:session_id>/complete', methods=['POST'])
@jwt_required()
def complete_session(session_id):
    """Complete a learning session"""
    try:
        user_id = int(get_jwt_identity())
        data = request.get_json() or {}
        
        # Verify session belongs to user
        session = UserProgress.query.filter(
            UserProgress.id == session_id,
            UserProgress.user_id == user_id
        ).first()
        
        if not session:
            return jsonify({
                'success': False,
                'error': 'Session not found'
            }), 404
        
        # Get completion status
        completion_status_str = data.get('completion_status', 'completed')
        try:
            completion_status = CompletionStatus(completion_status_str.upper())
        except ValueError:
            completion_status = CompletionStatus.COMPLETED
        
        # Complete session
        success = analytics_service.complete_session(session_id, completion_status)
        
        if success:
            return jsonify({
                'success': True,
                'data': {
                    'session_id': session_id,
                    'completion_status': completion_status.value
                }
            }), 200
        else:
            return jsonify({
                'success': False,
                'error': 'Failed to complete session'
            }), 500
        
    except Exception as e:
        logger.error(f"Error completing session: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to complete session'
        }), 500


@unified_analytics_bp.route('/errors', methods=['POST'])
@jwt_required()
def track_error():
    """Track a learning error for analysis"""
    try:
        user_id = int(get_jwt_identity())
        data = request.get_json()
        
        # Validate required fields
        required_fields = ['module_type', 'error_type', 'word_or_concept', 'user_response', 'correct_response']
        for field in required_fields:
            if not data.get(field):
                return jsonify({
                    'success': False,
                    'error': f'{field} is required'
                }), 400
        
        try:
            module_type = ModuleType(data['module_type'].upper())
            error_type = ErrorCategory(data['error_type'].upper())
        except ValueError:
            return jsonify({
                'success': False,
                'error': 'Invalid module_type or error_type'
            }), 400
        
        # Track the error
        analytics_service.track_error(
            user_id=user_id,
            module_type=module_type,
            error_type=error_type,
            word_or_concept=data['word_or_concept'],
            user_response=data['user_response'],
            correct_response=data['correct_response'],
            context=data.get('context'),
            difficulty_level=data.get('difficulty_level', 1)
        )
        
        return jsonify({
            'success': True,
            'message': 'Error tracked successfully'
        }), 201
        
    except Exception as e:
        logger.error(f"Error tracking error: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to track error'
        }), 500


# =============================================================================
# ACHIEVEMENTS ENDPOINTS
# =============================================================================

@unified_analytics_bp.route('/achievements', methods=['GET'])
@jwt_required()
def get_achievements():
    """Get user's achievements and progress"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get all achievements
        achievements = UserAchievements.query.filter(
            UserAchievements.user_id == user_id,
            UserAchievements.is_displayed == True
        ).order_by(UserAchievements.unlocked_at.desc()).all()
        
        # Group by type
        by_type = {}
        for achievement in achievements:
            achievement_type = achievement.achievement_type.value
            if achievement_type not in by_type:
                by_type[achievement_type] = []
            by_type[achievement_type].append(achievement.to_dict())
        
        # Recent achievements (last 30 days)
        recent_cutoff = datetime.utcnow() - timedelta(days=30)
        recent_achievements = [
            ach.to_dict() for ach in achievements 
            if ach.unlocked_at >= recent_cutoff
        ]
        
        return jsonify({
            'success': True,
            'data': {
                'achievements': [ach.to_dict() for ach in achievements],
                'by_type': by_type,
                'recent_achievements': recent_achievements,
                'total_achievements': len(achievements),
                'total_points': sum(ach.points_awarded for ach in achievements)
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting achievements: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load achievements'
        }), 500


@unified_analytics_bp.route('/achievements/progress', methods=['GET'])
@jwt_required()
def get_achievement_progress():
    """Get progress toward potential achievements"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get learning stats
        stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
        if not stats:
            return jsonify({
                'success': True,
                'data': {'potential_achievements': []}
            }), 200
        
        # Calculate progress toward next achievements
        potential_achievements = []
        
        # Streak achievements
        streak_thresholds = [7, 14, 30, 60, 100, 200]
        for threshold in streak_thresholds:
            if stats.current_streak < threshold:
                badge_name = f"{threshold} Day Streak"
                # Check if user already has this achievement
                existing = UserAchievements.query.filter(
                    UserAchievements.user_id == user_id,
                    UserAchievements.badge_name == badge_name
                ).first()
                
                if not existing:
                    potential_achievements.append({
                        'type': 'streak',
                        'name': badge_name,
                        'description': f'Study for {threshold} consecutive days',
                        'current_progress': stats.current_streak,
                        'target': threshold,
                        'progress_percentage': round((stats.current_streak / threshold) * 100, 1)
                    })
                    break
        
        # Accuracy achievements
        accuracy_thresholds = [70, 80, 85, 90, 95]
        for threshold in accuracy_thresholds:
            if stats.average_accuracy < threshold:
                badge_name = f"{threshold}% Accuracy Master"
                existing = UserAchievements.query.filter(
                    UserAchievements.user_id == user_id,
                    UserAchievements.badge_name == badge_name
                ).first()
                
                if not existing:
                    potential_achievements.append({
                        'type': 'accuracy',
                        'name': badge_name,
                        'description': f'Achieve {threshold}% average accuracy',
                        'current_progress': round(stats.average_accuracy, 1),
                        'target': threshold,
                        'progress_percentage': round((stats.average_accuracy / threshold) * 100, 1)
                    })
                    break
        
        return jsonify({
            'success': True,
            'data': {'potential_achievements': potential_achievements}
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting achievement progress: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load achievement progress'
        }), 500


# =============================================================================
# RECOMMENDATIONS ENDPOINTS
# =============================================================================

@unified_analytics_bp.route('/recommendations', methods=['GET'])
@jwt_required()
def get_recommendations():
    """Get personalized learning recommendations"""
    try:
        user_id = int(get_jwt_identity())
        
        # Get active recommendations
        recommendations = LearningRecommendations.query.filter(
            LearningRecommendations.user_id == user_id,
            LearningRecommendations.is_active == True,
            LearningRecommendations.expires_at > datetime.utcnow()
        ).order_by(
            LearningRecommendations.priority.desc(),
            LearningRecommendations.created_at
        ).all()
        
        return jsonify({
            'success': True,
            'data': {
                'recommendations': [rec.to_dict() for rec in recommendations],
                'total_recommendations': len(recommendations)
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting recommendations: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load recommendations'
        }), 500


@unified_analytics_bp.route('/recommendations/<int:recommendation_id>/click', methods=['POST'])
@jwt_required()
def track_recommendation_click(recommendation_id):
    """Track when a user clicks on a recommendation"""
    try:
        user_id = int(get_jwt_identity())
        
        recommendation = LearningRecommendations.query.filter(
            LearningRecommendations.id == recommendation_id,
            LearningRecommendations.user_id == user_id
        ).first()
        
        if not recommendation:
            return jsonify({
                'success': False,
                'error': 'Recommendation not found'
            }), 404
        
        recommendation.mark_clicked()
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Click tracked successfully'
        }), 200
        
    except Exception as e:
        logger.error(f"Error tracking recommendation click: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to track click'
        }), 500


@unified_analytics_bp.route('/recommendations/<int:recommendation_id>/complete', methods=['POST'])
@jwt_required()
def mark_recommendation_complete(recommendation_id):
    """Mark a recommendation as completed"""
    try:
        user_id = int(get_jwt_identity())
        
        recommendation = LearningRecommendations.query.filter(
            LearningRecommendations.id == recommendation_id,
            LearningRecommendations.user_id == user_id
        ).first()
        
        if not recommendation:
            return jsonify({
                'success': False,
                'error': 'Recommendation not found'
            }), 404
        
        recommendation.mark_completed()
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Recommendation marked as completed'
        }), 200
        
    except Exception as e:
        logger.error(f"Error marking recommendation complete: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to mark recommendation complete'
        }), 500


# =============================================================================
# ANALYTICS AND REPORTING ENDPOINTS
# =============================================================================

@unified_analytics_bp.route('/timeline', methods=['GET'])
@jwt_required()
def get_progress_timeline():
    """Get detailed progress timeline"""
    try:
        user_id = int(get_jwt_identity())
        days = request.args.get('days', 30, type=int)
        
        # Validate days parameter
        if days not in [7, 14, 30, 60, 90]:
            days = 30
        
        dashboard_data = analytics_service.get_unified_dashboard(user_id)
        timeline_data = dashboard_data.get('progress_timeline', [])
        
        return jsonify({
            'success': True,
            'data': {
                'timeline': timeline_data,
                'period_days': days
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting progress timeline: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load timeline data'
        }), 500


@unified_analytics_bp.route('/errors/analysis', methods=['GET'])
@jwt_required()
def get_error_analysis():
    """Get detailed error analysis and patterns"""
    try:
        user_id = int(get_jwt_identity())
        
        dashboard_data = analytics_service.get_unified_dashboard(user_id)
        error_analysis = dashboard_data.get('error_analysis', {})
        
        return jsonify({
            'success': True,
            'data': error_analysis
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting error analysis: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to load error analysis'
        }), 500


@unified_analytics_bp.route('/report', methods=['GET'])
@jwt_required()
def generate_progress_report():
    """Generate comprehensive progress report"""
    try:
        user_id = int(get_jwt_identity())
        report_type = request.args.get('type', 'weekly')
        format_type = request.args.get('format', 'json')
        
        if report_type not in ['weekly', 'monthly']:
            report_type = 'weekly'
        
        if format_type not in ['json', 'csv']:
            format_type = 'json'
        
        # Get comprehensive dashboard data
        dashboard_data = analytics_service.get_unified_dashboard(user_id)
        
        # Calculate report period
        days = 7 if report_type == 'weekly' else 30
        period_start = datetime.utcnow() - timedelta(days=days)
        
        # Get period-specific stats
        period_sessions = UserProgress.query.filter(
            UserProgress.user_id == user_id,
            UserProgress.session_start >= period_start,
            UserProgress.completion_status == CompletionStatus.COMPLETED
        ).all()
        
        report_data = {
            'report_type': report_type,
            'period_start': period_start.isoformat(),
            'period_end': datetime.utcnow().isoformat(),
            'user_id': user_id,
            'period_summary': {
                'total_sessions': len(period_sessions),
                'total_time_hours': round(sum(s.time_spent or 0 for s in period_sessions) / 3600, 1),
                'average_accuracy': round(sum(s.accuracy_rate or 0 for s in period_sessions) / max(1, len(period_sessions)), 1),
                'total_items_practiced': sum(s.items_attempted or 0 for s in period_sessions),
                'total_correct': sum(s.items_correct or 0 for s in period_sessions)
            },
            'dashboard_data': dashboard_data,
            'generated_at': datetime.utcnow().isoformat()
        }
        
        if format_type == 'json':
            return jsonify({
                'success': True,
                'data': report_data
            }), 200
        else:
            # Generate CSV report
            output = io.StringIO()
            writer = csv.writer(output)
            
            # Write header
            writer.writerow(['Report Type', report_type])
            writer.writerow(['Period', f"{period_start.strftime('%Y-%m-%d')} to {datetime.utcnow().strftime('%Y-%m-%d')}"])
            writer.writerow(['Generated', datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')])
            writer.writerow([])
            
            # Write summary
            writer.writerow(['Summary'])
            for key, value in report_data['period_summary'].items():
                writer.writerow([key.replace('_', ' ').title(), value])
            
            output.seek(0)
            
            return send_file(
                io.BytesIO(output.getvalue().encode()),
                mimetype='text/csv',
                as_attachment=True,
                download_name=f'progress_report_{report_type}_{datetime.utcnow().strftime("%Y%m%d")}.csv'
            )
        
    except Exception as e:
        logger.error(f"Error generating progress report: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to generate progress report'
        }), 500


@unified_analytics_bp.route('/export', methods=['GET'])
@jwt_required()
def export_analytics_data():
    """Export comprehensive analytics data"""
    try:
        user_id = int(get_jwt_identity())
        format_type = request.args.get('format', 'json')
        
        if format_type not in ['json', 'csv']:
            format_type = 'json'
        
        # Get all user data
        sessions = UserProgress.query.filter(UserProgress.user_id == user_id).all()
        achievements = UserAchievements.query.filter(UserAchievements.user_id == user_id).all()
        errors = ErrorAnalysis.query.filter(ErrorAnalysis.user_id == user_id).all()
        stats = LearningStats.query.filter(LearningStats.user_id == user_id).first()
        
        export_data = {
            'export_date': datetime.utcnow().isoformat(),
            'user_id': user_id,
            'learning_stats': stats.to_dict() if stats else {},
            'sessions': [session.to_dict() for session in sessions],
            'achievements': [achievement.to_dict() for achievement in achievements],
            'errors': [error.to_dict() for error in errors],
            'summary': {
                'total_sessions': len(sessions),
                'total_achievements': len(achievements),
                'total_errors': len(errors)
            }
        }
        
        if format_type == 'json':
            return jsonify({
                'success': True,
                'data': export_data
            }), 200
        else:
            # Generate CSV export
            output = io.StringIO()
            writer = csv.writer(output)
            
            # Write sessions data
            writer.writerow(['Sessions'])
            if sessions:
                headers = list(sessions[0].to_dict().keys())
                writer.writerow(headers)
                for session in sessions:
                    row = [session.to_dict().get(header, '') for header in headers]
                    writer.writerow(row)
            
            writer.writerow([])
            
            # Write achievements data
            writer.writerow(['Achievements'])
            if achievements:
                headers = list(achievements[0].to_dict().keys())
                writer.writerow(headers)
                for achievement in achievements:
                    row = [achievement.to_dict().get(header, '') for header in headers]
                    writer.writerow(row)
            
            output.seek(0)
            
            return send_file(
                io.BytesIO(output.getvalue().encode()),
                mimetype='text/csv',
                as_attachment=True,
                download_name=f'analytics_export_{datetime.utcnow().strftime("%Y%m%d")}.csv'
            )
        
    except Exception as e:
        logger.error(f"Error exporting analytics data: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to export data'
        }), 500


# =============================================================================
# CACHE MANAGEMENT
# =============================================================================

@unified_analytics_bp.route('/cache/clear', methods=['POST'])
@jwt_required()
def clear_analytics_cache():
    """Clear user's analytics cache"""
    try:
        user_id = int(get_jwt_identity())
        
        from app.models.analytics import AnalyticsCache
        AnalyticsCache.clear_user_cache(user_id)
        
        return jsonify({
            'success': True,
            'message': 'Analytics cache cleared successfully'
        }), 200
        
    except Exception as e:
        logger.error(f"Error clearing analytics cache: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to clear cache'
        }), 500


# =============================================================================
# ERROR HANDLERS
# =============================================================================

@unified_analytics_bp.errorhandler(400)
def bad_request(error):
    return jsonify({
        'success': False,
        'error': 'Bad request'
    }), 400


@unified_analytics_bp.errorhandler(404)
def not_found(error):
    return jsonify({
        'success': False,
        'error': 'Resource not found'
    }), 404


@unified_analytics_bp.errorhandler(500)
def internal_error(error):
    return jsonify({
        'success': False,
        'error': 'Internal server error'
    }), 500