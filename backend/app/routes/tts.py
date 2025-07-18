from flask import Blueprint, request, jsonify, send_file, Response
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.services.tts_service import TTSService
from app.models.generated_sentence import GeneratedSentence
from app import db
import os
import base64
import io
import hashlib
from typing import Generator

bp = Blueprint('tts', __name__, url_prefix='/api/tts')
tts_service = TTSService()

@bp.route('/sentence-audio', methods=['POST'])
@jwt_required()
def get_sentence_audio():
    """
    Get audio for a sentence (preferably from pre-generated audio)
    
    Request body:
    {
        "text": "Text to get audio for",
        "voice": "af_bella" (optional),
        "speed": 1.0 (optional)
    }
    """
    try:
        data = request.get_json()
        
        if not data or 'text' not in data:
            return jsonify({'error': 'Text is required'}), 400
        
        text = data.get('text').strip()
        if not text:
            return jsonify({'error': 'Text cannot be empty'}), 400
        
        voice = data.get('voice', 'af_bella')
        speed = float(data.get('speed', 1.0))
        
        # Generate cache key
        cache_key = hashlib.md5(f"kokoro_{text}_{voice}_{speed}".encode()).hexdigest()
        
        # First try to find pre-generated audio in database
        sentence = GeneratedSentence.query.filter_by(
            text=text,
            audio_cache_key=cache_key
        ).first()
        
        if sentence and sentence.audio_file_path and os.path.exists(sentence.audio_file_path):
            print(f"Serving pre-generated audio for: {text[:30]}...")
            return send_file(
                sentence.audio_file_path,
                mimetype='audio/mpeg',
                as_attachment=False,
                download_name=f'sentence_{sentence.id}.mp3'
            )
        
        # Fallback to real-time generation
        print(f"No pre-generated audio found, generating on-demand for: {text[:30]}...")
        file_path, error = tts_service.generate_audio(
            text=text,
            provider='kokoro',
            voice=voice,
            speed=speed
        )
        
        if error:
            return jsonify({'error': error}), 500
        
        if not file_path or not os.path.exists(file_path):
            return jsonify({'error': 'Failed to generate audio'}), 500
        
        # Store the generated audio info back to database if it's a known sentence
        sentence = GeneratedSentence.query.filter_by(text=text).first()
        if sentence:
            sentence.audio_file_path = file_path
            sentence.audio_cache_key = cache_key
            sentence.audio_generated_at = db.func.now()
            db.session.commit()
            print(f"Saved audio info to database for sentence ID: {sentence.id}")
        
        return send_file(
            file_path,
            mimetype='audio/mpeg',
            as_attachment=False,
            download_name=os.path.basename(file_path)
        )
        
    except Exception as e:
        print(f"Error in get_sentence_audio: {str(e)}")
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/generate', methods=['POST'])
@jwt_required()
def generate_audio():
    """
    Generate audio from text using TTS service
    
    Request body:
    {
        "text": "Text to convert to speech",
        "provider": "kokoro" or "minimax" (optional, default: kokoro),
        "voice": "voice_id" (optional),
        "speed": 1.0 (optional, 0.5-2.0),
        "emotion": "neutral" (optional, for minimax),
        "format": "mp3" (optional, mp3/wav/flac)
    }
    """
    try:
        data = request.get_json()
        
        # Validate required fields
        if not data or 'text' not in data:
            return jsonify({'error': 'Text is required'}), 400
        
        text = data.get('text')
        if not text or len(text.strip()) == 0:
            return jsonify({'error': 'Text cannot be empty'}), 400
        
        # Limit text length
        if len(text) > 1000:
            return jsonify({'error': 'Text too long. Maximum 1000 characters allowed'}), 400
        
        # Extract parameters
        provider = data.get('provider')
        voice = data.get('voice')
        speed = float(data.get('speed', 1.0))
        
        # Validate speed
        if speed < 0.5 or speed > 2.0:
            return jsonify({'error': 'Speed must be between 0.5 and 2.0'}), 400
        
        # Additional parameters for MiniMax
        kwargs = {}
        if provider == 'minimax':
            kwargs['emotion'] = data.get('emotion', 'neutral')
            kwargs['format'] = data.get('format', 'mp3')
            kwargs['model'] = data.get('model', 'speech-02-hd')
        
        # Log the request for debugging
        print(f"TTS Request - Text: {text[:50]}..., Provider: {provider}, Voice: {voice}, Speed: {speed}")
        
        # Generate audio
        file_path, error = tts_service.generate_audio(
            text=text,
            provider=provider,
            voice=voice,
            speed=speed,
            **kwargs
        )
        
        if error:
            return jsonify({'error': error}), 500
        
        if not file_path or not os.path.exists(file_path):
            return jsonify({'error': 'Failed to generate audio'}), 500
        
        # Return audio file
        return send_file(
            file_path,
            mimetype='audio/mpeg',
            as_attachment=False,
            download_name=os.path.basename(file_path)
        )
        
    except ValueError as e:
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/generate-with-timestamps', methods=['POST'])
@jwt_required()
def generate_audio_with_timestamps():
    """
    Generate audio with word-level timestamps (Kokoro only)
    
    Request body:
    {
        "text": "Text to convert to speech",
        "voice": "af_bella" (optional),
        "speed": 1.0 (optional)
    }
    """
    try:
        data = request.get_json()
        
        # Validate required fields
        if not data or 'text' not in data:
            return jsonify({'error': 'Text is required'}), 400
        
        text = data.get('text')
        if not text or len(text.strip()) == 0:
            return jsonify({'error': 'Text cannot be empty'}), 400
        
        # Limit text length
        if len(text) > 1000:
            return jsonify({'error': 'Text too long. Maximum 1000 characters allowed'}), 400
        
        # Extract parameters
        voice = data.get('voice', 'af_bella')
        speed = float(data.get('speed', 1.0))
        
        # Validate speed
        if speed < 0.5 or speed > 2.0:
            return jsonify({'error': 'Speed must be between 0.5 and 2.0'}), 400
        
        # Generate audio with timestamps
        result = tts_service.generate_audio_with_timestamps(text, voice, speed)
        
        if not result:
            return jsonify({'error': 'Failed to generate audio with timestamps'}), 500
        
        return jsonify(result), 200
        
    except ValueError as e:
        return jsonify({'error': str(e)}), 400
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/voices', methods=['GET'])
@jwt_required()
def list_voices():
    """
    List available voices for all providers or a specific provider
    
    Query parameters:
    - provider: "kokoro" or "minimax" (optional)
    """
    try:
        provider = request.args.get('provider')
        voices = tts_service.list_voices(provider)
        return jsonify(voices), 200
        
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/providers', methods=['GET'])
@jwt_required()
def list_providers():
    """Get list of available TTS providers and their status"""
    try:
        providers = tts_service.get_available_providers()
        return jsonify({'providers': providers}), 200
        
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/batch', methods=['POST'])
@jwt_required()
def batch_generate():
    """
    Generate audio for multiple texts in batch
    
    Request body:
    {
        "items": [
            {
                "id": "unique_id",
                "text": "Text to convert",
                "provider": "kokoro",
                "voice": "af_bella",
                "speed": 1.0
            },
            ...
        ]
    }
    """
    try:
        data = request.get_json()
        
        if not data or 'items' not in data:
            return jsonify({'error': 'Items array is required'}), 400
        
        items = data.get('items', [])
        if len(items) == 0:
            return jsonify({'error': 'Items array cannot be empty'}), 400
        
        if len(items) > 10:
            return jsonify({'error': 'Maximum 10 items allowed per batch'}), 400
        
        results = []
        
        for item in items:
            item_id = item.get('id', '')
            text = item.get('text', '')
            
            if not text:
                results.append({
                    'id': item_id,
                    'success': False,
                    'error': 'Text is required'
                })
                continue
            
            # Generate audio
            file_path, error = tts_service.generate_audio(
                text=text,
                provider=item.get('provider'),
                voice=item.get('voice'),
                speed=float(item.get('speed', 1.0))
            )
            
            if error:
                results.append({
                    'id': item_id,
                    'success': False,
                    'error': error
                })
            else:
                # Read file and convert to base64
                try:
                    with open(file_path, 'rb') as f:
                        audio_data = base64.b64encode(f.read()).decode('utf-8')
                    
                    results.append({
                        'id': item_id,
                        'success': True,
                        'audio_base64': audio_data,
                        'format': 'mp3'
                    })
                except Exception as e:
                    results.append({
                        'id': item_id,
                        'success': False,
                        'error': f'Failed to read audio file: {str(e)}'
                    })
        
        return jsonify({'results': results}), 200
        
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/cache/clear', methods=['POST'])
@jwt_required()
def clear_cache():
    """
    Clear old audio cache files
    
    Request body:
    {
        "older_than_days": 7 (optional, default: 7)
    }
    """
    try:
        # Check if user is admin
        current_user = int(get_jwt_identity())
        # TODO: Add proper admin check when user roles are implemented
        
        data = request.get_json() or {}
        older_than_days = int(data.get('older_than_days', 7))
        
        if older_than_days < 1:
            return jsonify({'error': 'older_than_days must be at least 1'}), 400
        
        count = tts_service.clear_cache(older_than_days)
        
        return jsonify({
            'success': True,
            'files_deleted': count,
            'message': f'Deleted {count} cache files older than {older_than_days} days'
        }), 200
        
    except ValueError as e:
        return jsonify({'error': 'Invalid parameter value'}), 400
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/stream', methods=['POST'])
@jwt_required()
def stream_audio():
    """
    Stream audio generation for real-time playback
    
    Request body:
    {
        "text": "Text to convert to speech",
        "provider": "kokoro" or "minimax" (optional),
        "voice": "voice_id" (optional),
        "speed": 1.0 (optional)
    }
    """
    try:
        data = request.get_json()
        
        if not data or 'text' not in data:
            return jsonify({'error': 'Text is required'}), 400
        
        text = data.get('text')
        if not text or len(text.strip()) == 0:
            return jsonify({'error': 'Text cannot be empty'}), 400
        
        # For streaming, we'll use chunked transfer encoding
        def generate():
            # First, generate the complete audio file
            file_path, error = tts_service.generate_audio(
                text=text,
                provider=data.get('provider'),
                voice=data.get('voice'),
                speed=float(data.get('speed', 1.0))
            )
            
            if error or not file_path:
                yield b'ERROR: ' + (error or 'Failed to generate audio').encode()
                return
            
            # Stream the file in chunks
            with open(file_path, 'rb') as f:
                while True:
                    chunk = f.read(4096)  # 4KB chunks
                    if not chunk:
                        break
                    yield chunk
        
        return Response(
            generate(),
            mimetype='audio/mpeg',
            headers={
                'Content-Type': 'audio/mpeg',
                'Cache-Control': 'no-cache',
                'Transfer-Encoding': 'chunked'
            }
        )
        
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/phonetic', methods=['POST'])
@jwt_required()
def generate_phonetic_audio():
    """
    Generate audio for phonetic pronunciation of words
    
    Request body:
    {
        "word": "example",
        "phonetic": "/ɪɡˈzæmpəl/",  (optional, will be generated if not provided)
        "provider": "kokoro" (optional),
        "voice": "af_bella" (optional),
        "speed": 0.8 (optional, slower for clarity)
    }
    """
    try:
        data = request.get_json()
        
        if not data or 'word' not in data:
            return jsonify({'error': 'Word is required'}), 400
        
        word = data.get('word').strip()
        if not word:
            return jsonify({'error': 'Word cannot be empty'}), 400
        
        # Get phonetic transcription if not provided
        phonetic = data.get('phonetic')
        if not phonetic:
            # For now, we'll use the word itself with emphasis
            # In production, integrate with a phonetic dictionary API
            phonetic = word
        
        # Generate audio with slower speed for clarity
        provider = data.get('provider', 'kokoro')
        voice = data.get('voice', 'af_bella' if provider == 'kokoro' else 'presenter_female')
        speed = float(data.get('speed', 0.8))  # Default slower speed
        
        # Add pauses and emphasis for phonetic pronunciation
        phonetic_text = f"<speak>{word}. <break time='500ms'/> {phonetic}</speak>"
        
        file_path, error = tts_service.generate_audio(
            text=phonetic_text,
            provider=provider,
            voice=voice,
            speed=speed
        )
        
        if error:
            return jsonify({'error': error}), 500
        
        if not file_path or not os.path.exists(file_path):
            return jsonify({'error': 'Failed to generate phonetic audio'}), 500
        
        return send_file(
            file_path,
            mimetype='audio/mpeg',
            as_attachment=False,
            download_name=f"{word}_phonetic.mp3"
        )
        
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@bp.route('/word-emphasis', methods=['POST'])
@jwt_required()
def generate_word_emphasis():
    """
    Generate audio with emphasis on specific words in a sentence
    
    Request body:
    {
        "sentence": "The quick brown fox jumps over the lazy dog",
        "emphasis_words": ["quick", "jumps"],
        "provider": "kokoro" (optional),
        "voice": "af_bella" (optional),
        "speed": 1.0 (optional)
    }
    """
    try:
        data = request.get_json()
        
        if not data or 'sentence' not in data:
            return jsonify({'error': 'Sentence is required'}), 400
        
        sentence = data.get('sentence').strip()
        if not sentence:
            return jsonify({'error': 'Sentence cannot be empty'}), 400
        
        emphasis_words = data.get('emphasis_words', [])
        
        # Process sentence to add emphasis tags
        if emphasis_words:
            for word in emphasis_words:
                # Add SSML emphasis tags around the words
                sentence = sentence.replace(
                    word, 
                    f'<emphasis level="strong">{word}</emphasis>'
                )
        
        # Wrap in SSML speak tag
        ssml_text = f'<speak>{sentence}</speak>'
        
        # Generate audio
        file_path, error = tts_service.generate_audio(
            text=ssml_text,
            provider=data.get('provider'),
            voice=data.get('voice'),
            speed=float(data.get('speed', 1.0))
        )
        
        if error:
            return jsonify({'error': error}), 500
        
        if not file_path or not os.path.exists(file_path):
            return jsonify({'error': 'Failed to generate audio with emphasis'}), 500
        
        return send_file(
            file_path,
            mimetype='audio/mpeg',
            as_attachment=False,
            download_name='emphasized_audio.mp3'
        )
        
    except Exception as e:
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500