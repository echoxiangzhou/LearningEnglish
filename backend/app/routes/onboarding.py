from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app import db
from app.models import User, VocabularyLibrary, LibraryAssignment, UserCategoryAssignment, Article
from datetime import datetime
import logging

bp = Blueprint('onboarding', __name__)

@bp.route('/libraries', methods=['GET'])
@jwt_required()
def get_available_libraries():
    """Get available libraries for onboarding selection"""
    try:
        current_user_id = int(get_jwt_identity())
        user = User.query.get(current_user_id)
        
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        # Get available vocabulary libraries
        vocabulary_libraries = VocabularyLibrary.query.filter_by(
            is_active=True,
            is_public=True
        ).all()
        
        # Group vocabulary libraries by type and grade
        vocab_by_type = {}
        for lib in vocabulary_libraries:
            lib_type = lib.library_type or 'other'
            if lib_type not in vocab_by_type:
                vocab_by_type[lib_type] = []
            
            vocab_by_type[lib_type].append({
                'id': lib.id,
                'library_id': lib.library_id,
                'name': lib.name,
                'description': lib.description,
                'grade_level': lib.grade_level,
                'total_words': lib.total_words,
                'difficulty_range': f"{lib.difficulty_min}-{lib.difficulty_max}" if lib.difficulty_min and lib.difficulty_max else None,
                'categories': lib.categories,
                'tags': lib.tags
            })
        
        # Get available sentence categories (from existing sentence categorization)
        sentence_categories_query = db.session.query(
            db.func.distinct(db.text("source_category"))
        ).filter(db.text("source_category IS NOT NULL")).all()
        
        sentence_categories = []
        for category in sentence_categories_query:
            if category[0]:  # Skip null values
                sentence_categories.append({
                    'id': category[0],
                    'name': category[0].replace('_', ' ').title(),
                    'description': f'Sentences from {category[0].replace("_", " ")} category'
                })
        
        # Get available reading libraries (articles grouped by topic/grade)
        articles_by_topic = db.session.query(
            Article.topic,
            Article.grade_level,
            db.func.count(Article.id).label('article_count'),
            db.func.avg(Article.difficulty).label('avg_difficulty')
        ).filter(
            Article.is_active == True
        ).group_by(Article.topic, Article.grade_level).all()
        
        reading_libraries = []
        for topic_group in articles_by_topic:
            if topic_group.topic:  # Skip null topics
                reading_libraries.append({
                    'id': f"{topic_group.topic}_{topic_group.grade_level}",
                    'topic': topic_group.topic,
                    'grade_level': topic_group.grade_level,
                    'name': f"{topic_group.topic.title()} - Grade {topic_group.grade_level}",
                    'description': f"Reading comprehension materials for {topic_group.topic}",
                    'article_count': topic_group.article_count,
                    'average_difficulty': round(float(topic_group.avg_difficulty), 1) if topic_group.avg_difficulty else None
                })
        
        return jsonify({
            'vocabulary_libraries': vocab_by_type,
            'sentence_categories': sentence_categories,
            'reading_libraries': reading_libraries
        }), 200
        
    except Exception as e:
        logging.error(f"Error fetching onboarding libraries: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/complete', methods=['POST'])
@jwt_required()
def complete_onboarding():
    """Complete onboarding with selected libraries"""
    try:
        current_user_id = int(get_jwt_identity())
        user = User.query.get(current_user_id)
        
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        if user.has_completed_onboarding:
            return jsonify({'error': 'Onboarding already completed'}), 400
        
        data = request.get_json()
        
        # Validate input
        vocabulary_library_ids = data.get('vocabulary_libraries', [])
        sentence_category_ids = data.get('sentence_categories', [])
        reading_library_ids = data.get('reading_libraries', [])
        
        if not vocabulary_library_ids and not sentence_category_ids and not reading_library_ids:
            return jsonify({'error': 'At least one library selection is required'}), 400
        
        # Assign vocabulary libraries
        for vocab_lib_id in vocabulary_library_ids:
            vocab_lib = VocabularyLibrary.query.get(vocab_lib_id)
            if vocab_lib and vocab_lib.is_active and vocab_lib.is_public:
                # Check if assignment already exists
                existing_assignment = LibraryAssignment.query.filter_by(
                    user_id=current_user_id,
                    library_id=vocab_lib.id
                ).first()
                
                if not existing_assignment:
                    assignment = LibraryAssignment(
                        user_id=current_user_id,
                        library_id=vocab_lib.id,
                        assigned_by_id=current_user_id,  # Self-assigned during onboarding
                        assignment_type='optional',
                        is_active=True
                    )
                    db.session.add(assignment)
        
        # Assign sentence categories
        for category_id in sentence_category_ids:
            # Check if assignment already exists
            existing_assignment = UserCategoryAssignment.query.filter_by(
                user_id=current_user_id,
                category=category_id
            ).first()
            
            if not existing_assignment:
                assignment = UserCategoryAssignment(
                    user_id=current_user_id,
                    category=category_id,
                    assigned_by_id=current_user_id,
                    is_active=True
                )
                db.session.add(assignment)
        
        # For reading libraries, we'll create a simple preference tracking
        # (This could be extended with a dedicated ReadingLibraryAssignment model)
        user_preferences = data.get('preferences', {})
        user_preferences['selected_reading_libraries'] = reading_library_ids
        
        # Mark onboarding as complete
        user.has_completed_onboarding = True
        user.onboarding_completed_at = datetime.utcnow()
        user.updated_at = datetime.utcnow()
        
        db.session.commit()
        
        # Count assignments made
        vocab_count = len(vocabulary_library_ids)
        sentence_count = len(sentence_category_ids)
        reading_count = len(reading_library_ids)
        
        return jsonify({
            'message': 'Onboarding completed successfully',
            'assignments_created': {
                'vocabulary_libraries': vocab_count,
                'sentence_categories': sentence_count,
                'reading_libraries': reading_count
            },
            'user': user.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        logging.error(f"Error completing onboarding: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/status', methods=['GET'])
@jwt_required()
def get_onboarding_status():
    """Get current user's onboarding status"""
    try:
        current_user_id = int(get_jwt_identity())
        user = User.query.get(current_user_id)
        
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        return jsonify({
            'has_completed_onboarding': user.has_completed_onboarding,
            'onboarding_completed_at': user.onboarding_completed_at.isoformat() if user.onboarding_completed_at else None,
            'user': user.to_dict()
        }), 200
        
    except Exception as e:
        logging.error(f"Error getting onboarding status: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@bp.route('/reset', methods=['POST'])
@jwt_required()
def reset_onboarding():
    """Reset onboarding status (for testing or re-selection)"""
    try:
        current_user_id = int(get_jwt_identity())
        user = User.query.get(current_user_id)
        
        if not user:
            return jsonify({'error': 'User not found'}), 404
        
        # Only allow admin or the user themselves to reset
        if not (user.is_admin or current_user_id == user.id):
            return jsonify({'error': 'Permission denied'}), 403
        
        # Reset onboarding status
        user.has_completed_onboarding = False
        user.onboarding_completed_at = None
        user.updated_at = datetime.utcnow()
        
        # Optionally remove all library assignments (uncomment if needed)
        # LibraryAssignment.query.filter_by(user_id=current_user_id).delete()
        # UserCategoryAssignment.query.filter_by(user_id=current_user_id).delete()
        
        db.session.commit()
        
        return jsonify({
            'message': 'Onboarding status reset successfully',
            'user': user.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        logging.error(f"Error resetting onboarding: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500