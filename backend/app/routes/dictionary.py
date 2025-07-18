from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.services.dictionary_service import DictionaryService
from app.models.user import User
from app.models.article import ReadingSession
from app import db
import traceback

dictionary_bp = Blueprint('dictionary', __name__)


@dictionary_bp.route('/definition/<word>', methods=['GET'])
@jwt_required()
def get_word_definition(word):
    """
    Get word definition.
    
    Args:
        word: The word to look up
        
    Returns:
        JSON response with word definition
    """
    try:
        user_id = int(get_jwt_identity())
        
        # Get optional parameters
        context_sentence = request.args.get('context')
        article_position = request.args.get('position', type=int)
        reading_session_id = request.args.get('session_id', type=int)
        
        # Get word definition
        definition = DictionaryService.get_word_definition(word, user_id)
        
        # Save lookup if additional context provided
        if context_sentence or article_position or reading_session_id:
            DictionaryService.save_word_lookup(
                user_id=user_id,
                word=word,
                context_sentence=context_sentence,
                article_position=article_position,
                reading_session_id=reading_session_id
            )
        
        return jsonify({
            'success': True,
            'data': definition
        }), 200
        
    except Exception as e:
        current_app.logger.error(f"Error in get_word_definition: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to get word definition'
        }), 500


@dictionary_bp.route('/lookup', methods=['POST'])
@jwt_required()
def lookup_word():
    """
    Look up a word and save the lookup activity.
    
    Expected JSON body:
    {
        "word": "example",
        "context_sentence": "This is an example sentence.",
        "article_position": 150,
        "reading_session_id": 123
    }
    
    Returns:
        JSON response with word definition and lookup tracking
    """
    try:
        user_id = int(get_jwt_identity())
        data = request.get_json()
        
        if not data or 'word' not in data:
            return jsonify({
                'success': False,
                'error': 'Word is required'
            }), 400
        
        word = data['word'].strip()
        context_sentence = data.get('context_sentence')
        article_position = data.get('article_position')
        reading_session_id = data.get('reading_session_id')
        
        # Validate reading session if provided
        if reading_session_id:
            session = ReadingSession.query.filter_by(
                id=reading_session_id,
                user_id=user_id
            ).first()
            if not session:
                return jsonify({
                    'success': False,
                    'error': 'Invalid reading session'
                }), 400
        
        # Get word definition
        definition = DictionaryService.get_word_definition(word, user_id)
        
        # Save lookup activity
        lookup_saved = DictionaryService.save_word_lookup(
            user_id=user_id,
            word=word,
            context_sentence=context_sentence,
            article_position=article_position,
            reading_session_id=reading_session_id
        )
        
        return jsonify({
            'success': True,
            'data': {
                'definition': definition,
                'lookup_saved': lookup_saved
            }
        }), 200
        
    except Exception as e:
        current_app.logger.error(f"Error in lookup_word: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to lookup word'
        }), 500


@dictionary_bp.route('/history', methods=['GET'])
@jwt_required()
def get_lookup_history():
    """
    Get user's word lookup history.
    
    Query parameters:
        limit: Maximum number of lookups to return (default: 50)
        
    Returns:
        JSON response with lookup history
    """
    try:
        user_id = int(get_jwt_identity())
        limit = request.args.get('limit', default=50, type=int)
        
        # Validate limit
        if limit < 1 or limit > 100:
            limit = 50
        
        history = DictionaryService.get_user_lookup_history(user_id, limit)
        
        return jsonify({
            'success': True,
            'data': {
                'history': history,
                'count': len(history)
            }
        }), 200
        
    except Exception as e:
        current_app.logger.error(f"Error in get_lookup_history: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to get lookup history'
        }), 500


@dictionary_bp.route('/popular', methods=['GET'])
def get_popular_words():
    """
    Get most looked up words across all users.
    
    Query parameters:
        limit: Maximum number of words to return (default: 20)
        
    Returns:
        JSON response with popular words
    """
    try:
        limit = request.args.get('limit', default=20, type=int)
        
        # Validate limit
        if limit < 1 or limit > 100:
            limit = 20
        
        popular_words = DictionaryService.get_popular_words(limit)
        
        return jsonify({
            'success': True,
            'data': {
                'popular_words': popular_words,
                'count': len(popular_words)
            }
        }), 200
        
    except Exception as e:
        current_app.logger.error(f"Error in get_popular_words: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to get popular words'
        }), 500


@dictionary_bp.route('/stats', methods=['GET'])
@jwt_required()
def get_vocabulary_stats():
    """
    Get user's vocabulary learning statistics.
    
    Returns:
        JSON response with vocabulary statistics
    """
    try:
        user_id = int(get_jwt_identity())
        
        stats = DictionaryService.get_user_vocabulary_stats(user_id)
        
        return jsonify({
            'success': True,
            'data': stats
        }), 200
        
    except Exception as e:
        current_app.logger.error(f"Error in get_vocabulary_stats: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to get vocabulary statistics'
        }), 500


@dictionary_bp.route('/phonetic/<word>', methods=['GET'])
@jwt_required()
def get_word_phonetic(word):
    """
    Get phonetic pronunciation for a word.
    
    Args:
        word: The word to get phonetic for
        
    Returns:
        JSON response with phonetic pronunciation
    """
    try:
        user_id = int(get_jwt_identity())
        
        # Get word definition which includes phonetic
        definition = DictionaryService.get_word_definition(word, user_id)
        
        return jsonify({
            'success': True,
            'data': {
                'word': word,
                'phonetic': definition.get('phonetic'),
                'found': definition.get('phonetic') is not None
            }
        }), 200
        
    except Exception as e:
        current_app.logger.error(f"Error in get_word_phonetic: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to get phonetic pronunciation'
        }), 500


@dictionary_bp.route('/batch-lookup', methods=['POST'])
@jwt_required()
def batch_lookup():
    """
    Look up multiple words at once.
    
    Expected JSON body:
    {
        "words": ["word1", "word2", "word3"],
        "context_data": {
            "reading_session_id": 123,
            "article_position": 150
        }
    }
    
    Returns:
        JSON response with definitions for all words
    """
    try:
        user_id = int(get_jwt_identity())
        data = request.get_json()
        
        if not data or 'words' not in data:
            return jsonify({
                'success': False,
                'error': 'Words list is required'
            }), 400
        
        words = data['words']
        context_data = data.get('context_data', {})
        
        if not isinstance(words, list) or len(words) == 0:
            return jsonify({
                'success': False,
                'error': 'Words must be a non-empty list'
            }), 400
        
        # Limit batch size
        if len(words) > 10:
            return jsonify({
                'success': False,
                'error': 'Maximum 10 words per batch'
            }), 400
        
        results = []
        for word in words:
            if isinstance(word, str) and word.strip():
                definition = DictionaryService.get_word_definition(word.strip(), user_id)
                results.append({
                    'word': word.strip(),
                    'definition': definition
                })
                
                # Save lookup if context provided
                if context_data:
                    DictionaryService.save_word_lookup(
                        user_id=user_id,
                        word=word.strip(),
                        context_sentence=context_data.get('context_sentence'),
                        article_position=context_data.get('article_position'),
                        reading_session_id=context_data.get('reading_session_id')
                    )
        
        return jsonify({
            'success': True,
            'data': {
                'results': results,
                'count': len(results)
            }
        }), 200
        
    except Exception as e:
        current_app.logger.error(f"Error in batch_lookup: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Failed to perform batch lookup'
        }), 500


@dictionary_bp.errorhandler(400)
def bad_request(error):
    """Handle bad request errors."""
    return jsonify({
        'success': False,
        'error': 'Bad request'
    }), 400


@dictionary_bp.errorhandler(404)
def not_found(error):
    """Handle not found errors."""
    return jsonify({
        'success': False,
        'error': 'Not found'
    }), 404


@dictionary_bp.errorhandler(500)
def internal_error(error):
    """Handle internal server errors."""
    current_app.logger.error(f"Internal error: {str(error)}")
    return jsonify({
        'success': False,
        'error': 'Internal server error'
    }), 500