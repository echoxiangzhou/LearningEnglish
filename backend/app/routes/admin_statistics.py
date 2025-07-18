"""
Admin Statistics API Routes

Provides comprehensive statistics for admin dashboard including
user counts, content counts, system health metrics, etc.
"""

from flask import Blueprint, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy import func, and_
from datetime import datetime, timedelta
import logging

from app.models.user import User
from app.models.word import Word
from app.models.generated_sentence import GeneratedSentence, ApprovalStatus
# VocabularyCategory removed
from app.models.vocabulary_library import VocabularyLibrary
from app import db

logger = logging.getLogger(__name__)

# Create blueprint
admin_stats_bp = Blueprint('admin_statistics', __name__, url_prefix='/api/admin')


def require_admin():
    """Check if current user has admin permissions"""
    user_id = int(get_jwt_identity())
    user = User.query.get(user_id)
    
    if not user or not user.is_admin:
        return False
    return True


@admin_stats_bp.route('/stats/dashboard', methods=['GET'])
@jwt_required()
def get_dashboard_stats():
    """Get comprehensive dashboard statistics"""
    if not require_admin():
        return jsonify({'error': 'Admin access required'}), 403
    
    try:
        # User statistics
        total_users = User.query.count()
        
        # Active users (logged in within last 30 days)
        thirty_days_ago = datetime.utcnow() - timedelta(days=30)
        active_users = User.query.filter(
            User.last_login >= thirty_days_ago
        ).count()
        
        # Vocabulary statistics
        total_vocabulary = Word.query.filter_by(is_active=True).count()
        
        # Sentence statistics
        total_sentences = GeneratedSentence.query.count()
        pending_sentences = GeneratedSentence.query.filter_by(
            approval_status=ApprovalStatus.PENDING
        ).count()
        
        # System health calculation
        system_health = calculate_system_health(
            total_users, active_users, pending_sentences
        )
        
        # Storage usage (simplified calculation)
        storage_used = calculate_storage_usage()
        
        return jsonify({
            'success': True,
            'data': {
                'totalUsers': total_users,
                'activeUsers': active_users,
                'totalVocabulary': total_vocabulary,
                'totalSentences': total_sentences,
                'pendingSentences': pending_sentences,
                'systemHealth': system_health,
                'storageUsed': storage_used,
                'lastUpdated': datetime.utcnow().isoformat()
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error fetching dashboard stats: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to fetch dashboard statistics'
        }), 500


@admin_stats_bp.route('/stats/users', methods=['GET'])
@jwt_required()
def get_user_stats():
    """Get detailed user statistics"""
    if not require_admin():
        return jsonify({'error': 'Admin access required'}), 403
    
    try:
        # Total users by role
        role_counts = db.session.query(
            User.role, func.count(User.id)
        ).group_by(User.role).all()
        
        # Users by status
        active_users = User.query.filter_by(is_active=True).count()
        inactive_users = User.query.filter_by(is_active=False).count()
        
        # Recent registrations (last 7 days)
        week_ago = datetime.utcnow() - timedelta(days=7)
        recent_registrations = User.query.filter(
            User.created_at >= week_ago
        ).count()
        
        # Users by creation date (last 30 days)
        daily_registrations = []
        for i in range(30):
            date = datetime.utcnow() - timedelta(days=i)
            start_date = date.replace(hour=0, minute=0, second=0, microsecond=0)
            end_date = start_date + timedelta(days=1)
            
            count = User.query.filter(
                and_(User.created_at >= start_date, User.created_at < end_date)
            ).count()
            
            daily_registrations.append({
                'date': start_date.strftime('%Y-%m-%d'),
                'count': count
            })
        
        return jsonify({
            'success': True,
            'data': {
                'total_users': User.query.count(),
                'active_users': active_users,
                'inactive_users': inactive_users,
                'recent_registrations': recent_registrations,
                'role_distribution': [{'role': role, 'count': count} for role, count in role_counts],
                'daily_registrations': daily_registrations
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error fetching user stats: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to fetch user statistics'
        }), 500


@admin_stats_bp.route('/stats/content', methods=['GET'])
@jwt_required()
def get_content_stats():
    """Get content statistics"""
    if not require_admin():
        return jsonify({'error': 'Admin access required'}), 403
    
    try:
        # Sentence statistics
        total_sentences = GeneratedSentence.query.count()
        approved_sentences = GeneratedSentence.query.filter_by(
            approval_status=ApprovalStatus.APPROVED
        ).count()
        pending_sentences = GeneratedSentence.query.filter_by(
            approval_status=ApprovalStatus.PENDING
        ).count()
        rejected_sentences = GeneratedSentence.query.filter_by(
            approval_status=ApprovalStatus.REJECTED
        ).count()
        
        # Sentences by difficulty
        difficulty_counts = db.session.query(
            GeneratedSentence.difficulty, func.count(GeneratedSentence.id)
        ).group_by(GeneratedSentence.difficulty).all()
        
        # Sentences by category
        category_counts = db.session.query(
            GeneratedSentence.source_category, func.count(GeneratedSentence.id)
        ).group_by(GeneratedSentence.source_category).all()
        
        return jsonify({
            'success': True,
            'data': {
                'total_sentences': total_sentences,
                'approved_sentences': approved_sentences,
                'pending_sentences': pending_sentences,
                'rejected_sentences': rejected_sentences,
                'difficulty_distribution': [
                    {'difficulty': diff, 'count': count} 
                    for diff, count in difficulty_counts
                ],
                'category_distribution': [
                    {'category': cat or 'Uncategorized', 'count': count} 
                    for cat, count in category_counts
                ],
                'approval_rate': round((approved_sentences / max(total_sentences, 1)) * 100, 1)
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error fetching content stats: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to fetch content statistics'
        }), 500


@admin_stats_bp.route('/stats/vocabulary', methods=['GET'])
@jwt_required()
def get_vocabulary_stats():
    """Get vocabulary statistics"""
    if not require_admin():
        return jsonify({'error': 'Admin access required'}), 403
    
    try:
        # Total words
        total_words = Word.query.filter_by(is_active=True).count()
        
        # Words by difficulty
        difficulty_counts = db.session.query(
            Word.difficulty, func.count(Word.id)
        ).filter_by(is_active=True).group_by(Word.difficulty).all()
        
        # Words by grade level
        grade_counts = db.session.query(
            Word.grade_level, func.count(Word.id)
        ).filter_by(is_active=True).group_by(Word.grade_level).all()
        
        return jsonify({
            'success': True,
            'data': {
                'total_words': total_words,
                'difficulty_distribution': [
                    {'difficulty': diff or 'Unknown', 'count': count} 
                    for diff, count in difficulty_counts
                ],
                'grade_distribution': [
                    {'grade': grade or 'Unknown', 'count': count} 
                    for grade, count in grade_counts
                ]
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error fetching vocabulary stats: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to fetch vocabulary statistics'
        }), 500


@admin_stats_bp.route('/stats/system', methods=['GET'])
@jwt_required()
def get_system_stats():
    """Get system performance statistics"""
    if not require_admin():
        return jsonify({'error': 'Admin access required'}), 403
    
    try:
        # Database size estimation
        user_count = User.query.count()
        word_count = Word.query.count()
        sentence_count = GeneratedSentence.query.count()
        
        # Estimated storage (simplified)
        estimated_storage_mb = (user_count * 0.5) + (word_count * 0.1) + (sentence_count * 0.2)
        storage_percentage = min((estimated_storage_mb / 1000) * 100, 95)  # Cap at 95%
        
        # System health metrics
        health_score = calculate_system_health(user_count, 0, 0)
        
        return jsonify({
            'success': True,
            'data': {
                'database_records': {
                    'users': user_count,
                    'words': word_count,
                    'sentences': sentence_count
                },
                'storage': {
                    'estimated_mb': round(estimated_storage_mb, 2),
                    'percentage_used': round(storage_percentage, 1)
                },
                'health_score': health_score,
                'last_updated': datetime.utcnow().isoformat()
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Error fetching system stats: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to fetch system statistics'
        }), 500


def calculate_system_health(total_users, active_users, pending_sentences):
    """Calculate system health score based on various metrics"""
    health = 100
    
    # Penalize if too many pending sentences
    if pending_sentences > 50:
        health -= 10
    elif pending_sentences > 20:
        health -= 5
    
    # Penalize if user activity is low
    if total_users > 0:
        activity_rate = active_users / total_users
        if activity_rate < 0.1:  # Less than 10% active
            health -= 15
        elif activity_rate < 0.3:  # Less than 30% active
            health -= 5
    
    return max(health, 0)


def calculate_storage_usage():
    """Calculate estimated storage usage percentage"""
    try:
        # Simple estimation based on record counts
        user_count = User.query.count()
        word_count = Word.query.count()
        sentence_count = GeneratedSentence.query.count()
        
        # Estimated storage per record (in KB)
        estimated_kb = (user_count * 2) + (word_count * 0.5) + (sentence_count * 1)
        
        # Convert to percentage (assuming 100MB total capacity for demo)
        percentage = min((estimated_kb / 102400) * 100, 95)  # Cap at 95%
        
        return round(percentage, 1)
    except:
        return 45  # Fallback value