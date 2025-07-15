"""
Audio Playback Service

Handles audio generation, caching, and playback control for dictation practice.
"""

import os
import hashlib
import json
from typing import Dict, Optional, Tuple, List
from datetime import datetime, timedelta
import logging
from pathlib import Path
import tempfile

from flask import current_app
import requests

from ..models.generated_sentence import GeneratedSentence
from .tts_service import TTSService

logger = logging.getLogger(__name__)


class AudioPlaybackService:
    """Service for managing audio playback in dictation practice"""
    
    def __init__(self):
        self.tts_service = TTSService()
        self.cache_dir = None
        self.supported_speeds = [0.5, 0.75, 1.0, 1.25, 1.5]
        self._setup_cache_directory()
    
    def _setup_cache_directory(self):
        """Set up audio cache directory"""
        try:
            # Use app's instance folder for caching
            if current_app:
                cache_path = os.path.join(current_app.instance_path, 'audio_cache')
            else:
                cache_path = os.path.join(tempfile.gettempdir(), 'dictation_audio_cache')
            
            Path(cache_path).mkdir(parents=True, exist_ok=True)
            self.cache_dir = cache_path
            logger.info(f"Audio cache directory set up at: {cache_path}")
            
        except Exception as e:
            logger.error(f"Error setting up cache directory: {str(e)}")
            self.cache_dir = tempfile.gettempdir()
    
    def get_audio_url(self, sentence_id: int, speed: float = 1.0) -> Dict:
        """Get audio URL for a sentence, generating if necessary"""
        try:
            # Get sentence
            sentence = GeneratedSentence.query.get(sentence_id)
            if not sentence:
                return {'success': False, 'error': 'Sentence not found'}
            
            # Normalize speed to supported values
            speed = self._normalize_speed(speed)
            
            # Check cache first
            cached_file = self._get_cached_audio(sentence.id, sentence.text, speed)
            if cached_file:
                return {
                    'success': True,
                    'audio_url': f'/api/dictation/audio/{sentence.id}?speed={speed}',
                    'cached': True,
                    'duration': cached_file.get('duration', 0)
                }
            
            # Generate new audio
            audio_data = self._generate_audio(sentence.text, speed)
            if not audio_data:
                return {'success': False, 'error': 'Failed to generate audio'}
            
            # Cache the audio
            self._cache_audio(sentence.id, sentence.text, speed, audio_data)
            
            return {
                'success': True,
                'audio_url': f'/api/dictation/audio/{sentence.id}?speed={speed}',
                'cached': False,
                'duration': audio_data.get('duration', 0)
            }
            
        except Exception as e:
            logger.error(f"Error getting audio URL: {str(e)}")
            return {'success': False, 'error': str(e)}
    
    def _normalize_speed(self, speed: float) -> float:
        """Normalize speed to closest supported value"""
        if speed <= 0.5:
            return 0.5
        elif speed >= 1.5:
            return 1.5
        
        # Find closest supported speed
        closest = min(self.supported_speeds, key=lambda x: abs(x - speed))
        return closest
    
    def _get_cache_key(self, sentence_id: int, text: str, speed: float) -> str:
        """Generate cache key for audio file"""
        # Include text hash to invalidate cache if sentence changes
        text_hash = hashlib.md5(text.encode()).hexdigest()[:8]
        return f"dictation_{sentence_id}_{text_hash}_{speed}x"
    
    def _get_cached_audio(self, sentence_id: int, text: str, speed: float) -> Optional[Dict]:
        """Check if audio exists in cache"""
        if not self.cache_dir:
            return None
        
        cache_key = self._get_cache_key(sentence_id, text, speed)
        audio_path = os.path.join(self.cache_dir, f"{cache_key}.mp3")
        meta_path = os.path.join(self.cache_dir, f"{cache_key}.json")
        
        if os.path.exists(audio_path) and os.path.exists(meta_path):
            # Check if cache is still valid (24 hours)
            file_age = datetime.now() - datetime.fromtimestamp(os.path.getmtime(audio_path))
            if file_age < timedelta(hours=24):
                try:
                    with open(meta_path, 'r') as f:
                        metadata = json.load(f)
                    
                    return {
                        'path': audio_path,
                        'duration': metadata.get('duration', 0),
                        'created_at': metadata.get('created_at')
                    }
                except Exception as e:
                    logger.error(f"Error reading cache metadata: {str(e)}")
        
        return None
    
    def _generate_audio(self, text: str, speed: float) -> Optional[Dict]:
        """Generate audio using TTS service"""
        try:
            # Adjust speech rate based on speed
            speech_rate = self._calculate_speech_rate(speed)
            
            # Generate audio with TTS service
            result = self.tts_service.generate_speech(
                text=text,
                voice_settings={
                    'speed': speech_rate,
                    'pitch': 1.0,  # Keep pitch normal
                    'volume': 1.0
                }
            )
            
            if result['success']:
                audio_data = result.get('audio_data')
                if audio_data:
                    # Estimate duration (rough calculation)
                    word_count = len(text.split())
                    duration = word_count * 0.5 / speed  # Rough estimate
                    
                    return {
                        'audio_data': audio_data,
                        'duration': duration,
                        'format': 'mp3'
                    }
            
            return None
            
        except Exception as e:
            logger.error(f"Error generating audio: {str(e)}")
            return None
    
    def _calculate_speech_rate(self, playback_speed: float) -> float:
        """Calculate TTS speech rate from playback speed"""
        # Map playback speed to speech rate
        # Most TTS services use different scales
        speech_rate_map = {
            0.5: 0.75,    # Very slow
            0.75: 0.85,   # Slow
            1.0: 1.0,     # Normal
            1.25: 1.15,   # Slightly fast
            1.5: 1.25     # Fast
        }
        
        return speech_rate_map.get(playback_speed, 1.0)
    
    def _cache_audio(self, sentence_id: int, text: str, speed: float, audio_data: Dict):
        """Cache audio file and metadata"""
        if not self.cache_dir:
            return
        
        try:
            cache_key = self._get_cache_key(sentence_id, text, speed)
            audio_path = os.path.join(self.cache_dir, f"{cache_key}.mp3")
            meta_path = os.path.join(self.cache_dir, f"{cache_key}.json")
            
            # Save audio file
            with open(audio_path, 'wb') as f:
                f.write(audio_data['audio_data'])
            
            # Save metadata
            metadata = {
                'sentence_id': sentence_id,
                'text': text,
                'speed': speed,
                'duration': audio_data.get('duration', 0),
                'format': audio_data.get('format', 'mp3'),
                'created_at': datetime.now().isoformat()
            }
            
            with open(meta_path, 'w') as f:
                json.dump(metadata, f)
            
            logger.info(f"Cached audio for sentence {sentence_id} at speed {speed}x")
            
        except Exception as e:
            logger.error(f"Error caching audio: {str(e)}")
    
    def get_cached_audio_file(self, sentence_id: int, speed: float) -> Optional[str]:
        """Get path to cached audio file"""
        try:
            sentence = GeneratedSentence.query.get(sentence_id)
            if not sentence:
                return None
            
            speed = self._normalize_speed(speed)
            cached_file = self._get_cached_audio(sentence.id, sentence.text, speed)
            
            if cached_file:
                return cached_file['path']
            
            # Generate if not cached
            audio_data = self._generate_audio(sentence.text, speed)
            if audio_data:
                self._cache_audio(sentence.id, sentence.text, speed, audio_data)
                cached_file = self._get_cached_audio(sentence.id, sentence.text, speed)
                if cached_file:
                    return cached_file['path']
            
            return None
            
        except Exception as e:
            logger.error(f"Error getting cached audio file: {str(e)}")
            return None
    
    def preload_audio(self, sentence_ids: List[int], speeds: List[float] = None):
        """Preload audio for multiple sentences"""
        if speeds is None:
            speeds = [1.0]  # Default to normal speed
        
        results = []
        for sentence_id in sentence_ids:
            for speed in speeds:
                result = self.get_audio_url(sentence_id, speed)
                results.append({
                    'sentence_id': sentence_id,
                    'speed': speed,
                    'success': result.get('success', False),
                    'cached': result.get('cached', False)
                })
        
        return results
    
    def cleanup_old_cache(self, days_old: int = 7):
        """Clean up old cached audio files"""
        if not self.cache_dir:
            return 0
        
        try:
            cutoff_time = datetime.now() - timedelta(days=days_old)
            removed_count = 0
            
            for filename in os.listdir(self.cache_dir):
                file_path = os.path.join(self.cache_dir, filename)
                
                if os.path.isfile(file_path):
                    file_time = datetime.fromtimestamp(os.path.getmtime(file_path))
                    if file_time < cutoff_time:
                        os.remove(file_path)
                        removed_count += 1
            
            logger.info(f"Cleaned up {removed_count} old cache files")
            return removed_count
            
        except Exception as e:
            logger.error(f"Error cleaning up cache: {str(e)}")
            return 0
    
    def get_audio_metadata(self, sentence_id: int, speed: float = 1.0) -> Optional[Dict]:
        """Get metadata for cached audio without loading the file"""
        try:
            sentence = GeneratedSentence.query.get(sentence_id)
            if not sentence:
                return None
            
            speed = self._normalize_speed(speed)
            cache_key = self._get_cache_key(sentence.id, sentence.text, speed)
            meta_path = os.path.join(self.cache_dir, f"{cache_key}.json")
            
            if os.path.exists(meta_path):
                with open(meta_path, 'r') as f:
                    return json.load(f)
            
            return None
            
        except Exception as e:
            logger.error(f"Error getting audio metadata: {str(e)}")
            return None


class AudioStreamService:
    """Service for streaming audio with synchronized highlighting"""
    
    def __init__(self):
        self.word_timings = {}
    
    def generate_word_timings(self, text: str, audio_duration: float) -> List[Dict]:
        """Generate word timing information for synchronized highlighting"""
        words = text.split()
        if not words:
            return []
        
        # Simple linear distribution
        # In production, use speech recognition or TTS timing data
        time_per_word = audio_duration / len(words)
        
        timings = []
        current_time = 0
        
        for i, word in enumerate(words):
            timing = {
                'word': word,
                'position': i,
                'start_time': round(current_time, 2),
                'end_time': round(current_time + time_per_word, 2)
            }
            timings.append(timing)
            current_time += time_per_word
        
        return timings
    
    def get_current_word(self, timings: List[Dict], current_time: float) -> Optional[int]:
        """Get the word position that should be highlighted at current time"""
        for timing in timings:
            if timing['start_time'] <= current_time < timing['end_time']:
                return timing['position']
        
        return None