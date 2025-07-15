import os
import requests
import hashlib
import json
import tempfile
import uuid
from pathlib import Path
from abc import ABC, abstractmethod
from typing import Optional, Dict, Any, Tuple
from enum import Enum

class TTSProvider(Enum):
    KOKORO = "kokoro"
    MINIMAX = "minimax"

class TTSProviderInterface(ABC):
    """Abstract base class for TTS providers"""
    
    @abstractmethod
    def generate_audio(self, text: str, voice: str, speed: float = 1.0, **kwargs) -> Optional[str]:
        """Generate audio and return file path"""
        pass
    
    @abstractmethod
    def list_voices(self) -> Dict[str, Any]:
        """List available voices"""
        pass
    
    @abstractmethod
    def is_available(self) -> bool:
        """Check if the provider is available"""
        pass

class KokoroTTSProvider(TTSProviderInterface):
    """Kokoro TTS provider implementation"""
    
    def __init__(self, api_url: str, api_key: str, cache_dir: Path):
        self.api_url = api_url
        self.api_key = api_key
        self.cache_dir = cache_dir
        
    def generate_audio(self, text: str, voice: str = 'af_bella', speed: float = 1.0, **kwargs) -> Optional[str]:
        """Generate audio using Kokoro TTS"""
        # Generate cache key
        cache_key = hashlib.md5(f"kokoro_{text}_{voice}_{speed}".encode()).hexdigest()
        cache_file = self.cache_dir / f"{cache_key}.mp3"
        
        # Return cached file if exists
        if cache_file.exists():
            return str(cache_file)
        
        try:
            response = requests.post(
                f"{self.api_url}/v1/audio/speech",
                headers={
                    "Authorization": f"Bearer {self.api_key}",
                    "Content-Type": "application/json"
                },
                json={
                    "model": "kokoro",
                    "input": text,
                    "voice": voice,
                    "response_format": "mp3",
                    "speed": speed
                },
                timeout=30
            )
            
            if response.status_code == 200:
                with open(cache_file, 'wb') as f:
                    f.write(response.content)
                return str(cache_file)
            else:
                print(f"Kokoro TTS error: {response.status_code} - {response.text}")
                return None
                
        except Exception as e:
            print(f"Error generating audio with Kokoro: {str(e)}")
            return None
    
    def generate_audio_with_timestamps(self, text: str, voice: str = 'af_bella', speed: float = 1.0) -> Optional[Dict]:
        """Generate audio with word-level timestamps"""
        try:
            response = requests.post(
                f"{self.api_url}/dev/captioned_speech",
                json={
                    "model": "kokoro",
                    "input": text,
                    "voice": voice,
                    "speed": speed,
                    "response_format": "mp3",
                    "stream": False
                },
                timeout=30
            )
            
            if response.status_code == 200:
                return response.json()
            else:
                print(f"Kokoro captioned speech error: {response.status_code}")
                return None
                
        except Exception as e:
            print(f"Error generating captioned audio: {str(e)}")
            return None
    
    def list_voices(self) -> Dict[str, Any]:
        """List available Kokoro voices"""
        voices = {
            "voices": [
                {"id": "af_bella", "name": "Bella (American Female)", "language": "en-US", "gender": "female"},
                {"id": "af_sarah", "name": "Sarah (American Female)", "language": "en-US", "gender": "female"},
                {"id": "af_sky", "name": "Sky (American Female)", "language": "en-US", "gender": "female"},
                {"id": "am_adam", "name": "Adam (American Male)", "language": "en-US", "gender": "male"},
                {"id": "am_michael", "name": "Michael (American Male)", "language": "en-US", "gender": "male"},
                {"id": "bf_emma", "name": "Emma (British Female)", "language": "en-GB", "gender": "female"},
                {"id": "bf_isabella", "name": "Isabella (British Female)", "language": "en-GB", "gender": "female"},
                {"id": "bm_george", "name": "George (British Male)", "language": "en-GB", "gender": "male"},
                {"id": "bm_lewis", "name": "Lewis (British Male)", "language": "en-GB", "gender": "male"}
            ]
        }
        return voices
    
    def is_available(self) -> bool:
        """Check if Kokoro service is available"""
        try:
            response = requests.get(f"{self.api_url}/v1/audio/voices", timeout=5)
            return response.status_code == 200
        except:
            return False

class MiniMaxTTSProvider(TTSProviderInterface):
    """MiniMax TTS provider implementation"""
    
    def __init__(self, api_key: str, group_id: str, api_host: str, cache_dir: Path):
        self.api_key = api_key
        self.group_id = group_id
        self.api_host = api_host
        self.cache_dir = cache_dir
        self.headers = {
            'Authorization': f'Bearer {api_key}',
            'Content-Type': 'application/json'
        }
    
    def generate_audio(self, text: str, voice: str = 'female-shaonv', speed: float = 1.0, **kwargs) -> Optional[str]:
        """Generate audio using MiniMax TTS"""
        # Extract additional parameters
        model = kwargs.get('model', 'speech-02-hd')
        emotion = kwargs.get('emotion', 'neutral')
        format = kwargs.get('format', 'mp3')
        volume = kwargs.get('volume', 1.0)
        pitch = kwargs.get('pitch', 0)
        
        # Generate cache key
        cache_key = hashlib.md5(
            f"minimax_{text}_{voice}_{speed}_{model}_{emotion}".encode()
        ).hexdigest()
        cache_file = self.cache_dir / f"{cache_key}.{format}"
        
        # Return cached file if exists
        if cache_file.exists():
            return str(cache_file)
        
        try:
            endpoint = f"{self.api_host}/v1/t2a_v2"
            
            payload = {
                "model": model,
                "text": text,
                "stream": False,
                "voice_setting": {
                    "voice_id": voice,
                    "speed": speed,
                    "vol": volume,
                    "pitch": pitch,
                    "emotion": emotion
                },
                "audio_setting": {
                    "format": format,
                    "sample_rate": 32000,
                    "bitrate": 128000,
                    "channel": 1
                }
            }
            
            headers = self.headers.copy()
            headers['X-Group-Id'] = self.group_id
            
            response = requests.post(endpoint, json=payload, headers=headers, timeout=30)
            
            if response.status_code == 200:
                with open(cache_file, 'wb') as f:
                    f.write(response.content)
                return str(cache_file)
            else:
                print(f"MiniMax TTS error: {response.status_code} - {response.text}")
                return None
                
        except Exception as e:
            print(f"Error generating audio with MiniMax: {str(e)}")
            return None
    
    def list_voices(self) -> Dict[str, Any]:
        """List available MiniMax voices"""
        voices = {
            "voices": [
                {"id": "female-shaonv", "name": "Shaonv (Female)", "language": "zh-CN", "gender": "female"},
                {"id": "male-qn-qingse", "name": "Qingse (Male)", "language": "zh-CN", "gender": "male"},
                {"id": "female-yujie", "name": "Yujie (Female)", "language": "zh-CN", "gender": "female"},
                {"id": "female-tianmei", "name": "Tianmei (Female)", "language": "zh-CN", "gender": "female"},
                {"id": "presenter_male", "name": "Presenter (Male)", "language": "en-US", "gender": "male"},
                {"id": "presenter_female", "name": "Presenter (Female)", "language": "en-US", "gender": "female"}
            ]
        }
        return voices
    
    def is_available(self) -> bool:
        """Check if MiniMax service is available"""
        try:
            # Simple ping to check API availability
            endpoint = f"{self.api_host}/v1/t2a_v2"
            headers = self.headers.copy()
            headers['X-Group-Id'] = self.group_id
            
            # Use a very short test text
            payload = {
                "model": "speech-01-turbo",
                "text": "test",
                "stream": False,
                "voice_setting": {"voice_id": "presenter_male"},
                "audio_setting": {"format": "mp3"}
            }
            
            response = requests.post(endpoint, json=payload, headers=headers, timeout=5)
            return response.status_code in [200, 400]  # 400 might mean invalid text but API is up
        except:
            return False

class TTSService:
    """Main TTS service that manages multiple providers"""
    
    def __init__(self):
        # Initialize cache directory
        self.audio_cache_dir = Path('static/audio_cache')
        self.audio_cache_dir.mkdir(parents=True, exist_ok=True)
        
        # Initialize providers
        self.providers = {}
        
        # Initialize Kokoro provider
        kokoro_url = os.environ.get('KOKORO_API_URL', 'http://localhost:8880')
        kokoro_api_key = os.environ.get('KOKORO_API_KEY', 'not-needed')
        self.providers[TTSProvider.KOKORO] = KokoroTTSProvider(
            kokoro_url, kokoro_api_key, self.audio_cache_dir
        )
        
        # Initialize MiniMax provider
        minimax_api_key = os.environ.get('MINIMAX_API_KEY')
        minimax_group_id = os.environ.get('MINIMAX_GROUP_ID')
        minimax_api_host = os.environ.get('MINIMAX_API_HOST', 'https://api.minimaxi.chat')
        
        if minimax_api_key and minimax_group_id:
            self.providers[TTSProvider.MINIMAX] = MiniMaxTTSProvider(
                minimax_api_key, minimax_group_id, minimax_api_host, self.audio_cache_dir
            )
        
        # Default provider
        self.default_provider = TTSProvider.KOKORO
    
    def generate_audio(self, text: str, provider: Optional[str] = None, voice: Optional[str] = None, 
                      speed: float = 1.0, **kwargs) -> Tuple[Optional[str], Optional[str]]:
        """
        Generate audio using specified provider
        Returns: (file_path, error_message)
        """
        # Select provider
        if provider:
            try:
                provider_enum = TTSProvider(provider)
            except ValueError:
                return None, f"Invalid provider: {provider}"
        else:
            provider_enum = self.default_provider
        
        # Check if provider exists
        if provider_enum not in self.providers:
            return None, f"Provider {provider_enum.value} not configured"
        
        provider_instance = self.providers[provider_enum]
        
        # Use default voice if not specified
        if not voice:
            if provider_enum == TTSProvider.KOKORO:
                voice = 'af_bella'
            elif provider_enum == TTSProvider.MINIMAX:
                voice = 'presenter_female'
        
        # Generate audio
        try:
            file_path = provider_instance.generate_audio(text, voice, speed, **kwargs)
            if file_path:
                return file_path, None
            else:
                # Try fallback provider if available
                fallback = self._get_fallback_provider(provider_enum)
                if fallback:
                    print(f"Falling back from {provider_enum.value} to {fallback.value}")
                    fallback_instance = self.providers[fallback]
                    # Use appropriate default voice for fallback
                    fallback_voice = 'af_bella' if fallback == TTSProvider.KOKORO else 'presenter_female'
                    file_path = fallback_instance.generate_audio(text, fallback_voice, speed, **kwargs)
                    if file_path:
                        return file_path, None
                
                return None, f"Failed to generate audio with {provider_enum.value}"
        except Exception as e:
            return None, str(e)
    
    def generate_audio_with_timestamps(self, text: str, voice: str = 'af_bella', 
                                     speed: float = 1.0) -> Optional[Dict]:
        """Generate audio with timestamps (Kokoro only)"""
        if TTSProvider.KOKORO in self.providers:
            provider = self.providers[TTSProvider.KOKORO]
            if hasattr(provider, 'generate_audio_with_timestamps'):
                return provider.generate_audio_with_timestamps(text, voice, speed)
        return None
    
    def list_voices(self, provider: Optional[str] = None) -> Dict[str, Any]:
        """List voices for a specific provider or all providers"""
        if provider:
            try:
                provider_enum = TTSProvider(provider)
                if provider_enum in self.providers:
                    return self.providers[provider_enum].list_voices()
                else:
                    return {"error": f"Provider {provider} not configured"}
            except ValueError:
                return {"error": f"Invalid provider: {provider}"}
        else:
            # Return voices from all providers
            all_voices = {"voices": {}}
            for provider_enum, provider_instance in self.providers.items():
                voices = provider_instance.list_voices()
                all_voices["voices"][provider_enum.value] = voices.get("voices", [])
            return all_voices
    
    def get_available_providers(self) -> Dict[str, bool]:
        """Get list of available providers and their status"""
        status = {}
        for provider_enum, provider_instance in self.providers.items():
            status[provider_enum.value] = provider_instance.is_available()
        return status
    
    def _get_fallback_provider(self, failed_provider: TTSProvider) -> Optional[TTSProvider]:
        """Get fallback provider when primary fails"""
        for provider_enum, provider_instance in self.providers.items():
            if provider_enum != failed_provider and provider_instance.is_available():
                return provider_enum
        return None
    
    def clear_cache(self, older_than_days: int = 7) -> int:
        """Clear old cache files"""
        import time
        count = 0
        current_time = time.time()
        
        for file_path in self.audio_cache_dir.glob("*.mp3"):
            file_age_days = (current_time - file_path.stat().st_mtime) / (24 * 3600)
            if file_age_days > older_than_days:
                file_path.unlink()
                count += 1
        
        return count