from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.services.error_tracking_service import ErrorTrackingService
from app.models.word_error import WordError, ErrorReview
from app import db

error_tracking_bp = Blueprint('error_tracking', __name__)


@error_tracking_bp.route('/api/errors/record', methods=['POST'])
@jwt_required()
def record_error():
    """Record a word error during practice"""
    try:
        data = request.get_json()
        
        required_fields = ['expected_text', 'actual_text', 'practice_type']
        if not all(field in data for field in required_fields):
            return jsonify({'error': 'Missing required fields'}), 400
        
        word_error = ErrorTrackingService.record_word_error(
            user_id=int(get_jwt_identity()),
            expected_text=data['expected_text'],
            actual_text=data['actual_text'],
            practice_type=data['practice_type'],
            word_id=data.get('word_id'),
            sentence_id=data.get('sentence_id'),
            context=data.get('context'),
            session_id=data.get('session_id')
        )
        
        return jsonify({
            'success': True,
            'error_id': word_error.id,
            'error': word_error.to_dict()
        })
        
    except Exception as e:
        current_app.logger.error(f"Error recording word error: {str(e)}")
        return jsonify({'error': 'Failed to record error'}), 500


@error_tracking_bp.route('/api/errors/list', methods=['GET'])
@jwt_required()
def get_user_errors():
    """Get user's word errors"""
    try:
        practice_type = request.args.get('practice_type')
        include_resolved = request.args.get('include_resolved', 'false').lower() == 'true'
        
        errors = ErrorTrackingService.get_user_errors(
            user_id=int(get_jwt_identity()),
            practice_type=practice_type,
            include_resolved=include_resolved
        )
        
        return jsonify({
            'success': True,
            'errors': [error.to_dict() for error in errors]
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting user errors: {str(e)}")
        return jsonify({'error': 'Failed to get errors'}), 500


@error_tracking_bp.route('/api/errors/statistics', methods=['GET'])
@jwt_required()
def get_error_statistics():
    """Get comprehensive error statistics for user"""
    try:
        stats = ErrorTrackingService.get_error_statistics(int(get_jwt_identity()))
        
        return jsonify({
            'success': True,
            'statistics': stats
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting error statistics: {str(e)}")
        return jsonify({'error': 'Failed to get statistics'}), 500


@error_tracking_bp.route('/api/errors/<int:error_id>/resolve', methods=['POST'])
@jwt_required()
def resolve_error(error_id):
    """Mark an error as resolved"""
    try:
        success = ErrorTrackingService.mark_error_resolved(error_id, int(get_jwt_identity()))
        
        if success:
            return jsonify({
                'success': True,
                'message': 'Error marked as resolved'
            })
        else:
            return jsonify({'error': 'Error not found or not owned by user'}), 404
            
    except Exception as e:
        current_app.logger.error(f"Error resolving error: {str(e)}")
        return jsonify({'error': 'Failed to resolve error'}), 500


@error_tracking_bp.route('/api/errors/review-words', methods=['GET'])
@jwt_required()
def get_review_words():
    """Get words that need review"""
    try:
        limit = request.args.get('limit', 10, type=int)
        
        words_for_review = ErrorTrackingService.get_words_for_review(
            user_id=int(get_jwt_identity()),
            limit=limit
        )
        
        return jsonify({
            'success': True,
            'words_for_review': [error.to_dict() for error in words_for_review]
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting review words: {str(e)}")
        return jsonify({'error': 'Failed to get review words'}), 500


@error_tracking_bp.route('/api/errors/create-review-session', methods=['POST'])
@jwt_required()
def create_review_session():
    """Create a review session for specific word errors"""
    try:
        data = request.get_json()
        word_error_ids = data.get('word_error_ids', [])
        
        if not word_error_ids:
            return jsonify({'error': 'No word error IDs provided'}), 400
        
        reviews = ErrorTrackingService.create_review_session(
            user_id=int(get_jwt_identity()),
            word_error_ids=word_error_ids
        )
        
        return jsonify({
            'success': True,
            'reviews': [review.to_dict() for review in reviews]
        })
        
    except Exception as e:
        current_app.logger.error(f"Error creating review session: {str(e)}")
        return jsonify({'error': 'Failed to create review session'}), 500


@error_tracking_bp.route('/api/errors/review/<int:review_id>/update', methods=['POST'])
@jwt_required()
def update_review_result(review_id):
    """Update the result of a review session"""
    try:
        data = request.get_json()
        
        was_correct = data.get('was_correct')
        if was_correct is None:
            return jsonify({'error': 'was_correct field is required'}), 400
        
        review = ErrorTrackingService.update_review_result(
            review_id=review_id,
            was_correct=was_correct,
            response_time=data.get('response_time'),
            confidence_level=data.get('confidence_level')
        )
        
        if review:
            return jsonify({
                'success': True,
                'review': review.to_dict()
            })
        else:
            return jsonify({'error': 'Review not found'}), 404
            
    except Exception as e:
        current_app.logger.error(f"Error updating review result: {str(e)}")
        return jsonify({'error': 'Failed to update review result'}), 500


@error_tracking_bp.route('/api/errors/patterns', methods=['GET'])
@jwt_required()
def get_error_patterns():
    """Get user's error patterns"""
    try:
        from app.models.word_error import ErrorPattern
        
        patterns = ErrorPattern.query.filter_by(user_id=int(get_jwt_identity())).order_by(
            ErrorPattern.frequency.desc()
        ).all()
        
        return jsonify({
            'success': True,
            'patterns': [pattern.to_dict() for pattern in patterns]
        })
        
    except Exception as e:
        current_app.logger.error(f"Error getting error patterns: {str(e)}")
        return jsonify({'error': 'Failed to get error patterns'}), 500


@error_tracking_bp.route('/api/errors/export', methods=['GET'])
@jwt_required()
def export_user_errors():
    """Export user's error data for analysis"""
    try:
        include_resolved = request.args.get('include_resolved', 'true').lower() == 'true'
        format_type = request.args.get('format', 'json')  # json or csv
        
        errors = ErrorTrackingService.get_user_errors(
            user_id=int(get_jwt_identity()),
            include_resolved=include_resolved
        )
        
        if format_type == 'csv':
            # Return CSV format for data analysis
            import csv
            import io
            
            output = io.StringIO()
            writer = csv.writer(output)
            
            # Write header
            writer.writerow([
                'Error ID', 'Expected Text', 'Actual Text', 'Error Type',
                'Practice Type', 'Error Count', 'First Error Date',
                'Last Error Date', 'Is Resolved', 'Context'
            ])
            
            # Write data
            for error in errors:
                writer.writerow([
                    error.id, error.expected_text, error.actual_text,
                    error.error_type.value, error.practice_type,
                    error.error_count, error.first_error_date,
                    error.last_error_date, error.is_resolved, error.context
                ])
            
            output.seek(0)
            
            from flask import Response
            return Response(
                output.getvalue(),
                mimetype='text/csv',
                headers={'Content-Disposition': 'attachment; filename=word_errors.csv'}
            )
        
        else:
            # Return JSON format
            return jsonify({
                'success': True,
                'errors': [error.to_dict() for error in errors],
                'export_date': datetime.utcnow().isoformat(),
                'total_count': len(errors)
            })
        
    except Exception as e:
        current_app.logger.error(f"Error exporting user errors: {str(e)}")
        return jsonify({'error': 'Failed to export errors'}), 500