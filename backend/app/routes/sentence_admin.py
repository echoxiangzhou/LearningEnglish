"""
Sentence Administration API Routes

Provides REST API endpoints for administrative sentence management.
"""

from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from marshmallow import Schema, fields, validate, ValidationError
import logging

from app.services.sentence_admin_service import SentenceAdminService
from app.services.sentence_generation_service import DifficultyLevel, SentencePattern
from app.models.generated_sentence import ApprovalStatus
from app.models.user import User
from app import db

logger = logging.getLogger(__name__)

# Create blueprint
sentence_admin_bp = Blueprint('sentence_admin', __name__, url_prefix='/api/admin/sentences')

# Initialize service
admin_service = SentenceAdminService()


# Helper function to check admin permissions
def require_admin():
    """Check if current user has admin permissions"""
    user_id = get_jwt_identity()
    user = User.query.get(user_id)
    
    if not user or not user.is_admin:
        return False
    return True


# Request/Response Schemas
class GenerateAndValidateSchema(Schema):
    """Schema for generate and validate request"""
    target_words = fields.List(fields.Str(validate=validate.Length(min=1, max=50)), 
                              required=True, validate=validate.Length(min=1, max=100))
    difficulty = fields.Str(validate=validate.OneOf([d.value for d in DifficultyLevel]), 
                           load_default=DifficultyLevel.ELEMENTARY.value)
    sentences_per_word = fields.Int(validate=validate.Range(min=1, max=10), load_default=3)
    auto_approve_threshold = fields.Float(validate=validate.Range(min=0.0, max=1.0), load_default=0.8)


class ApprovalSchema(Schema):
    """Schema for sentence approval/rejection"""
    sentence_ids = fields.List(fields.Int(), required=True, validate=validate.Length(min=1))
    notes = fields.Str(validate=validate.Length(max=500))


class SearchSchema(Schema):
    """Schema for sentence search"""
    query = fields.Str(required=True, validate=validate.Length(min=1, max=100))
    difficulty = fields.Str(validate=validate.OneOf([d.value for d in DifficultyLevel]))
    approval_status = fields.Str(validate=validate.OneOf([s.value for s in ApprovalStatus]))
    limit = fields.Int(validate=validate.Range(min=1, max=100), load_default=50)


class ExportSchema(Schema):
    """Schema for sentence export"""
    difficulty = fields.Str(validate=validate.OneOf([d.value for d in DifficultyLevel]))
    target_words = fields.List(fields.Str(validate=validate.Length(min=1, max=50)))


@sentence_admin_bp.route('/generate-and-validate', methods=['POST'])
@jwt_required()
def generate_and_validate():
    """Generate sentences for words and validate them"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        schema = GenerateAndValidateSchema()
        data = schema.load(request.json)
        
        difficulty = DifficultyLevel(data['difficulty'])
        
        result = admin_service.generate_and_validate_sentences(
            target_words=data['target_words'],
            difficulty=difficulty,
            sentences_per_word=data['sentences_per_word'],
            auto_approve_threshold=data['auto_approve_threshold']
        )
        
        return jsonify(result), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error in generate_and_validate: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/pending-review', methods=['GET'])
@jwt_required()
def get_pending_review():
    """Get sentences pending approval"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        limit = request.args.get('limit', 50, type=int)
        difficulty = request.args.get('difficulty')
        target_word = request.args.get('target_word')
        
        difficulty_enum = None
        if difficulty:
            difficulty_enum = DifficultyLevel(difficulty)
        
        sentences = admin_service.get_sentences_for_review(
            limit=limit,
            difficulty=difficulty_enum,
            target_word=target_word
        )
        
        return jsonify({
            'success': True,
            'sentences': [sentence.to_dict() for sentence in sentences],
            'count': len(sentences)
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting pending review: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/approve', methods=['POST'])
@jwt_required()
def approve_sentences():
    """Approve one or more sentences"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        schema = ApprovalSchema()
        data = schema.load(request.json)
        
        user_id = get_jwt_identity()
        sentence_ids = data['sentence_ids']
        notes = data.get('notes')
        
        if len(sentence_ids) == 1:
            # Single approval
            success = admin_service.approve_sentence(
                sentence_ids[0], user_id, notes
            )
            return jsonify({
                'success': success,
                'approved_count': 1 if success else 0
            }), 200
        else:
            # Batch approval
            result = admin_service.batch_approve_sentences(sentence_ids, user_id)
            return jsonify({
                'success': True,
                'approved_count': result['approved'],
                'failed_count': result['failed']
            }), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error approving sentences: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/reject', methods=['POST'])
@jwt_required()
def reject_sentences():
    """Reject one or more sentences"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        schema = ApprovalSchema()
        data = schema.load(request.json)
        
        user_id = get_jwt_identity()
        sentence_ids = data['sentence_ids']
        notes = data.get('notes')
        
        rejected_count = 0
        failed_count = 0
        
        for sentence_id in sentence_ids:
            success = admin_service.reject_sentence(sentence_id, user_id, notes)
            if success:
                rejected_count += 1
            else:
                failed_count += 1
        
        return jsonify({
            'success': True,
            'rejected_count': rejected_count,
            'failed_count': failed_count
        }), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error rejecting sentences: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/statistics', methods=['GET'])
@jwt_required()
def get_statistics():
    """Get comprehensive sentence statistics"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        stats = admin_service.get_sentence_statistics()
        
        return jsonify({
            'success': True,
            'statistics': stats
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting statistics: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/search', methods=['GET'])
@jwt_required()
def search_sentences():
    """Search sentences by content or target word"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        schema = SearchSchema()
        args = schema.load(request.args)
        
        difficulty_enum = None
        if args.get('difficulty'):
            difficulty_enum = DifficultyLevel(args['difficulty'])
        
        approval_status_enum = None
        if args.get('approval_status'):
            approval_status_enum = ApprovalStatus(args['approval_status'])
        
        sentences = admin_service.search_sentences(
            query=args['query'],
            difficulty=difficulty_enum,
            approval_status=approval_status_enum,
            limit=args['limit']
        )
        
        return jsonify({
            'success': True,
            'sentences': [sentence.to_dict() for sentence in sentences],
            'count': len(sentences),
            'query': args['query']
        }), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error searching sentences: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/patterns', methods=['GET'])
@jwt_required()
def get_pattern_management():
    """Get pattern management information"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        pattern_info = admin_service.manage_sentence_patterns()
        
        return jsonify({
            'success': True,
            'pattern_management': pattern_info
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting pattern management: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/export', methods=['POST'])
@jwt_required()
def export_sentences():
    """Export approved sentences"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        schema = ExportSchema()
        data = schema.load(request.json)
        
        difficulty_enum = None
        if data.get('difficulty'):
            difficulty_enum = DifficultyLevel(data['difficulty'])
        
        sentences = admin_service.export_approved_sentences(
            difficulty=difficulty_enum,
            target_words=data.get('target_words')
        )
        
        return jsonify({
            'success': True,
            'sentences': sentences,
            'count': len(sentences)
        }), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error exporting sentences: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/cleanup', methods=['POST'])
@jwt_required()
def cleanup_sentences():
    """Clean up old rejected sentences"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        days_old = request.json.get('days_old', 30)
        
        if not isinstance(days_old, int) or days_old < 1:
            return jsonify({
                'success': False, 
                'error': 'days_old must be a positive integer'
            }), 400
        
        deleted_count = admin_service.cleanup_rejected_sentences(days_old)
        
        return jsonify({
            'success': True,
            'deleted_count': deleted_count,
            'days_old': days_old
        }), 200
        
    except Exception as e:
        logger.error(f"Error cleaning up sentences: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/sentence/<int:sentence_id>', methods=['GET'])
@jwt_required()
def get_sentence_details():
    """Get detailed information about a specific sentence"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        from app.models.generated_sentence import GeneratedSentence
        
        sentence = GeneratedSentence.query.get(sentence_id)
        if not sentence:
            return jsonify({
                'success': False, 
                'error': 'Sentence not found'
            }), 404
        
        # Get additional context
        similar_sentences = GeneratedSentence.query.filter(
            GeneratedSentence.target_word == sentence.target_word,
            GeneratedSentence.id != sentence.id
        ).limit(5).all()
        
        return jsonify({
            'success': True,
            'sentence': sentence.to_dict(),
            'similar_sentences': [s.to_dict() for s in similar_sentences]
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting sentence details: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/sentence/<int:sentence_id>', methods=['PUT'])
@jwt_required()
def update_sentence():
    """Update sentence details"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        from app.models.generated_sentence import GeneratedSentence
        
        sentence = GeneratedSentence.query.get(sentence_id)
        if not sentence:
            return jsonify({
                'success': False, 
                'error': 'Sentence not found'
            }), 404
        
        data = request.json
        
        # Update allowed fields
        if 'text' in data:
            sentence.text = data['text']
        
        if 'approval_notes' in data:
            sentence.approval_notes = data['approval_notes']
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'sentence': sentence.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        logger.error(f"Error updating sentence: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/sentence/<int:sentence_id>', methods=['DELETE'])
@jwt_required()
def delete_sentence():
    """Delete a sentence"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        from app.models.generated_sentence import GeneratedSentence
        
        sentence = GeneratedSentence.query.get(sentence_id)
        if not sentence:
            return jsonify({
                'success': False, 
                'error': 'Sentence not found'
            }), 404
        
        db.session.delete(sentence)
        db.session.commit()
        
        return jsonify({
            'success': True,
            'message': 'Sentence deleted successfully'
        }), 200
        
    except Exception as e:
        db.session.rollback()
        logger.error(f"Error deleting sentence: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@sentence_admin_bp.route('/health', methods=['GET'])
@jwt_required()
def admin_health_check():
    """Health check for admin functionality"""
    if not require_admin():
        return jsonify({'success': False, 'error': 'Admin access required'}), 403
    
    try:
        # Check database connectivity
        from app.models.generated_sentence import GeneratedSentence
        sentence_count = GeneratedSentence.query.count()
        
        # Check services
        service_status = {
            'sentence_admin_service': 'ready',
            'sentence_generation_service': 'ready' if admin_service.sentence_service.nlp else 'not_ready',
            'validation_service': 'ready'
        }
        
        return jsonify({
            'success': True,
            'status': 'healthy',
            'database': {
                'connected': True,
                'sentence_count': sentence_count
            },
            'services': service_status
        }), 200
        
    except Exception as e:
        logger.error(f"Admin health check error: {str(e)}")
        return jsonify({
            'success': False,
            'status': 'unhealthy',
            'error': str(e)
        }), 500