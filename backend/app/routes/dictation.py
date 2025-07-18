"""
Dictation Practice API Routes

Provides REST API endpoints for dictation practice functionality.
"""

from flask import Blueprint, request, jsonify, send_file, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from marshmallow import Schema, fields, validate, ValidationError
import logging
import os

from app.services.dictation_service import DictationService, HintType
from app.services.audio_playback_service import AudioPlaybackService, AudioStreamService
from app.models.dictation_practice import DictationDifficulty, DictationSettings
from app import db

logger = logging.getLogger(__name__)

# Create blueprint
dictation_bp = Blueprint('dictation', __name__, url_prefix='/api/dictation')

# Initialize services
dictation_service = DictationService()
audio_service = AudioPlaybackService()
stream_service = AudioStreamService()


# Request/Response Schemas
class CreateSessionSchema(Schema):
    """Schema for creating dictation session"""
    sentence_id = fields.Int(required=True)
    difficulty = fields.Str(validate=validate.OneOf([d.value for d in DictationDifficulty]))
    blank_percentage = fields.Float(validate=validate.Range(min=0.1, max=1.0))


class SubmitWordSchema(Schema):
    """Schema for word submission"""
    session_id = fields.Int(required=True)
    position = fields.Int(required=True, validate=validate.Range(min=0))
    user_input = fields.Str(required=True, validate=validate.Length(min=1, max=100))


class GetHintSchema(Schema):
    """Schema for hint request"""
    session_id = fields.Int(required=True)
    position = fields.Int(required=True, validate=validate.Range(min=0))
    hint_type = fields.Str(required=True, validate=validate.OneOf([h.value for h in HintType]))


class UpdateSpeedSchema(Schema):
    """Schema for playback speed update"""
    session_id = fields.Int(required=True)
    speed = fields.Float(required=True, validate=validate.Range(min=0.5, max=2.0))


class UpdateSettingsSchema(Schema):
    """Schema for user settings update"""
    audio = fields.Dict(keys=fields.Str(), values=fields.Raw())
    difficulty = fields.Dict(keys=fields.Str(), values=fields.Raw())
    hints = fields.Dict(keys=fields.Str(), values=fields.Raw())
    ui = fields.Dict(keys=fields.Str(), values=fields.Raw())
    feedback = fields.Dict(keys=fields.Str(), values=fields.Raw())
    session = fields.Dict(keys=fields.Str(), values=fields.Raw())


@dictation_bp.route('/session', methods=['POST'])
@jwt_required()
def create_session():
    """Create a new dictation practice session"""
    try:
        schema = CreateSessionSchema()
        data = schema.load(request.json)
        
        user_id = int(get_jwt_identity())
        
        # Parse difficulty if provided
        difficulty = None
        if data.get('difficulty'):
            difficulty = DictationDifficulty(data['difficulty'])
        
        # Create session
        session = dictation_service.create_dictation_session(
            user_id=user_id,
            sentence_id=data['sentence_id'],
            difficulty=difficulty,
            blank_percentage=data.get('blank_percentage')
        )
        
        # Get initial state
        state = dictation_service.get_session_state(session.id)
        
        # Get audio URL
        audio_result = audio_service.get_audio_url(
            session.sentence_id, 
            session.playback_speed
        )
        
        response_data = {
            'success': True,
            'session': state,
            'audio': audio_result
        }
        
        # Add word timings for synchronized highlighting
        if audio_result.get('success'):
            sentence_text = session.session_data.get('sentence_text', '')
            duration = audio_result.get('duration', 0)
            timings = stream_service.generate_word_timings(sentence_text, duration)
            response_data['word_timings'] = timings
        
        return jsonify(response_data), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except ValueError as e:
        return jsonify({'success': False, 'error': str(e)}), 400
    except Exception as e:
        logger.error(f"Error creating dictation session: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/session/<int:session_id>', methods=['GET'])
@jwt_required()
def get_session(session_id):
    """Get current session state"""
    try:
        user_id = int(get_jwt_identity())
        
        # Verify session belongs to user
        from app.models.dictation_practice import DictationSession
        session = DictationSession.query.get(session_id)
        if not session or session.user_id != user_id:
            return jsonify({'success': False, 'error': 'Session not found'}), 404
        
        state = dictation_service.get_session_state(session_id)
        if not state:
            return jsonify({'success': False, 'error': 'Session not found'}), 404
        
        return jsonify({
            'success': True,
            'session': state
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting session: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/submit-word', methods=['POST'])
@jwt_required()
def submit_word():
    """Submit user input for a word"""
    try:
        schema = SubmitWordSchema()
        data = schema.load(request.json)
        
        user_id = int(get_jwt_identity())
        
        # Verify session belongs to user
        from app.models.dictation_practice import DictationSession
        session = DictationSession.query.get(data['session_id'])
        if not session or session.user_id != user_id:
            return jsonify({'success': False, 'error': 'Session not found'}), 404
        
        # Submit word
        result = dictation_service.submit_word(
            session_id=data['session_id'],
            position=data['position'],
            user_input=data['user_input']
        )
        
        return jsonify(result), 200 if result['success'] else 400
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error submitting word: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/hint', methods=['POST'])
@jwt_required()
def get_hint():
    """Get a hint for a specific word"""
    try:
        schema = GetHintSchema()
        data = schema.load(request.json)
        
        user_id = int(get_jwt_identity())
        
        # Verify session belongs to user
        from app.models.dictation_practice import DictationSession
        session = DictationSession.query.get(data['session_id'])
        if not session or session.user_id != user_id:
            return jsonify({'success': False, 'error': 'Session not found'}), 404
        
        # Get hint
        hint_type = HintType(data['hint_type'])
        result = dictation_service.get_hint(
            session_id=data['session_id'],
            position=data['position'],
            hint_type=hint_type
        )
        
        return jsonify(result), 200 if result['success'] else 400
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error getting hint: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/playback-speed', methods=['PUT'])
@jwt_required()
def update_playback_speed():
    """Update playback speed for a session"""
    try:
        schema = UpdateSpeedSchema()
        data = schema.load(request.json)
        
        user_id = int(get_jwt_identity())
        
        # Verify session belongs to user
        from app.models.dictation_practice import DictationSession
        session = DictationSession.query.get(data['session_id'])
        if not session or session.user_id != user_id:
            return jsonify({'success': False, 'error': 'Session not found'}), 404
        
        # Update speed
        success = dictation_service.update_playback_speed(
            session_id=data['session_id'],
            speed=data['speed']
        )
        
        if success:
            # Get new audio URL
            audio_result = audio_service.get_audio_url(
                session.sentence_id,
                data['speed']
            )
            
            return jsonify({
                'success': True,
                'speed': data['speed'],
                'audio': audio_result
            }), 200
        
        return jsonify({'success': False, 'error': 'Failed to update speed'}), 400
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        logger.error(f"Error updating playback speed: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/record-playback', methods=['POST'])
@jwt_required()
def record_playback():
    """Record audio playback event"""
    try:
        data = request.json
        session_id = data.get('session_id')
        duration = data.get('duration', 0)
        
        if not session_id:
            return jsonify({'success': False, 'error': 'Session ID required'}), 400
        
        user_id = int(get_jwt_identity())
        
        # Verify session belongs to user
        from app.models.dictation_practice import DictationSession
        session = DictationSession.query.get(session_id)
        if not session or session.user_id != user_id:
            return jsonify({'success': False, 'error': 'Session not found'}), 404
        
        # Record playback
        success = dictation_service.record_audio_playback(session_id, duration)
        
        return jsonify({'success': success}), 200
        
    except Exception as e:
        logger.error(f"Error recording playback: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/statistics', methods=['GET'])
@jwt_required()
def get_statistics():
    """Get user's dictation practice statistics"""
    try:
        user_id = int(get_jwt_identity())
        stats = dictation_service.get_user_statistics(user_id)
        
        return jsonify({
            'success': True,
            'statistics': stats
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting statistics: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/practice-sentences', methods=['GET'])
@jwt_required()
def get_practice_sentences():
    """Get sentences for practice based on user's needs"""
    try:
        user_id = int(get_jwt_identity())
        count = request.args.get('count', 5, type=int)
        focus_problem_words = request.args.get('focus_problem_words', 'true').lower() == 'true'
        
        # Get category IDs from request
        category_ids = request.args.getlist('categories', type=int)
        
        sentences = dictation_service.get_practice_sentences(
            user_id=user_id,
            count=count,
            focus_problem_words=focus_problem_words,
            category_ids=category_ids
        )
        
        return jsonify({
            'success': True,
            'sentences': [
                {
                    'id': s.id,
                    'text': s.text,
                    'target_word': s.target_word,
                    'difficulty': s.difficulty,
                    'word_count': len(s.text.split()),
                    'chinese_translation': s.chinese_translation
                }
                for s in sentences
            ],
            'count': len(sentences)
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting practice sentences: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/session/<int:session_id>/review', methods=['GET'])
@jwt_required()
def get_session_review(session_id):
    """Get detailed review for a completed session"""
    try:
        user_id = int(get_jwt_identity())
        
        # Verify session belongs to user
        from app.models.dictation_practice import DictationSession
        session = DictationSession.query.get(session_id)
        if not session or session.user_id != user_id:
            return jsonify({'success': False, 'error': 'Session not found'}), 404
        
        review = dictation_service.get_session_review(session_id)
        if not review:
            return jsonify({'success': False, 'error': 'Review not available'}), 404
        
        return jsonify({
            'success': True,
            'review': review
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting session review: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/settings', methods=['GET'])
@jwt_required()
def get_settings():
    """Get user's dictation settings"""
    try:
        user_id = int(get_jwt_identity())
        
        settings = DictationSettings.query.filter_by(user_id=user_id).first()
        if not settings:
            # Create default settings
            settings = DictationSettings(user_id=user_id)
            db.session.add(settings)
            db.session.commit()
        
        return jsonify({
            'success': True,
            'settings': settings.to_dict()
        }), 200
        
    except Exception as e:
        logger.error(f"Error getting settings: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/settings', methods=['PUT'])
@jwt_required()
def update_settings():
    """Update user's dictation settings"""
    try:
        schema = UpdateSettingsSchema()
        data = schema.load(request.json)
        
        user_id = int(get_jwt_identity())
        
        settings = DictationSettings.query.filter_by(user_id=user_id).first()
        if not settings:
            settings = DictationSettings(user_id=user_id)
            db.session.add(settings)
        
        # Update audio settings
        if 'audio' in data:
            audio = data['audio']
            if 'default_playback_speed' in audio:
                settings.default_playback_speed = audio['default_playback_speed']
            if 'auto_replay' in audio:
                settings.auto_replay = audio['auto_replay']
            if 'replay_delay_seconds' in audio:
                settings.replay_delay_seconds = audio['replay_delay_seconds']
        
        # Update difficulty settings
        if 'difficulty' in data:
            diff = data['difficulty']
            if 'preferred_difficulty' in diff:
                settings.preferred_difficulty = DictationDifficulty(diff['preferred_difficulty'])
            if 'auto_difficulty_adjustment' in diff:
                settings.auto_difficulty_adjustment = diff['auto_difficulty_adjustment']
            if 'blank_percentage' in diff:
                settings.blank_percentage = diff['blank_percentage']
        
        # Update hint settings
        if 'hints' in data:
            hints = data['hints']
            if 'enable_hints' in hints:
                settings.enable_hints = hints['enable_hints']
            if 'hint_delay_seconds' in hints:
                settings.hint_delay_seconds = hints['hint_delay_seconds']
            if 'max_hints_per_word' in hints:
                settings.max_hints_per_word = hints['max_hints_per_word']
        
        # Update UI preferences
        if 'ui' in data:
            ui = data['ui']
            if 'show_word_count' in ui:
                settings.show_word_count = ui['show_word_count']
            if 'show_timer' in ui:
                settings.show_timer = ui['show_timer']
            if 'show_progress_bar' in ui:
                settings.show_progress_bar = ui['show_progress_bar']
            if 'enable_keyboard_shortcuts' in ui:
                settings.enable_keyboard_shortcuts = ui['enable_keyboard_shortcuts']
        
        # Update feedback settings
        if 'feedback' in data:
            feedback = data['feedback']
            if 'enable_sound_effects' in feedback:
                settings.enable_sound_effects = feedback['enable_sound_effects']
            if 'enable_visual_feedback' in feedback:
                settings.enable_visual_feedback = feedback['enable_visual_feedback']
            if 'celebrate_completion' in feedback:
                settings.celebrate_completion = feedback['celebrate_completion']
        
        # Update session preferences
        if 'session' in data:
            session_prefs = data['session']
            if 'session_length_words' in session_prefs:
                settings.session_length_words = session_prefs['session_length_words']
            if 'focus_on_problem_words' in session_prefs:
                settings.focus_on_problem_words = session_prefs['focus_on_problem_words']
            if 'review_mistakes_after_session' in session_prefs:
                settings.review_mistakes_after_session = session_prefs['review_mistakes_after_session']
        
        db.session.commit()
        
        return jsonify({
            'success': True,
            'settings': settings.to_dict()
        }), 200
        
    except ValidationError as e:
        return jsonify({'success': False, 'errors': e.messages}), 400
    except Exception as e:
        db.session.rollback()
        logger.error(f"Error updating settings: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/audio/<int:sentence_id>', methods=['GET'])
@jwt_required()
def get_audio(sentence_id):
    """Get audio file for a sentence"""
    try:
        speed = request.args.get('speed', 1.0, type=float)
        
        # Get cached audio file path
        audio_path = audio_service.get_cached_audio_file(sentence_id, speed)
        
        if audio_path and os.path.exists(audio_path):
            return send_file(
                audio_path,
                mimetype='audio/mpeg',
                as_attachment=False,
                download_name=f'dictation_{sentence_id}_{speed}x.mp3'
            )
        
        return jsonify({'success': False, 'error': 'Audio not found'}), 404
        
    except Exception as e:
        logger.error(f"Error getting audio: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/preload-audio', methods=['POST'])
@jwt_required()
def preload_audio():
    """Preload audio for multiple sentences"""
    try:
        data = request.json
        sentence_ids = data.get('sentence_ids', [])
        speeds = data.get('speeds', [1.0])
        
        if not sentence_ids:
            return jsonify({'success': False, 'error': 'No sentence IDs provided'}), 400
        
        results = audio_service.preload_audio(sentence_ids, speeds)
        
        return jsonify({
            'success': True,
            'results': results
        }), 200
        
    except Exception as e:
        logger.error(f"Error preloading audio: {str(e)}")
        return jsonify({'success': False, 'error': 'Internal server error'}), 500


@dictation_bp.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    try:
        # Check services
        from app.models.dictation_practice import DictationSession
        session_count = DictationSession.query.count()
        
        return jsonify({
            'success': True,
            'status': 'healthy',
            'components': {
                'dictation_service': 'ready',
                'audio_service': 'ready',
                'database': {
                    'connected': True,
                    'session_count': session_count
                }
            }
        }), 200
        
    except Exception as e:
        logger.error(f"Health check error: {str(e)}")
        return jsonify({
            'success': False,
            'status': 'unhealthy',
            'error': str(e)
        }), 500