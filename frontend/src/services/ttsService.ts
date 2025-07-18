class TTSService {
  private audioContext: AudioContext | null = null;
  private currentAudio: HTMLAudioElement | null = null;

  constructor() {
    // 初始化Web Audio API
    if (typeof window !== 'undefined' && window.AudioContext) {
      this.audioContext = new AudioContext();
    }
  }

  /**
   * 使用现有的kokoro-fastapi TTS服务生成语音
   */
  async generateSpeech(text: string, options: {
    speed?: number;
    voice?: string;
    provider?: string;
  } = {}): Promise<string> {
    const { speed = 0.7, voice = 'af_bella', provider = 'kokoro' } = options;

    try {
      // 获取认证token（如果需要）
      const token = localStorage.getItem('access_token');
      const headers: HeadersInit = {
        'Content-Type': 'application/json',
      };
      
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }

      const response = await fetch('/api/tts/sentence-audio', {
        method: 'POST',
        headers,
        body: JSON.stringify({
          text,
          speed,
          voice,
          provider
        })
      });

      if (!response.ok) {
        throw new Error(`TTS API failed: ${response.status}`);
      }

      // 检查响应是否为JSON（包含audio_url）或直接为音频文件
      const contentType = response.headers.get('content-type');
      
      if (contentType && contentType.includes('application/json')) {
        // JSON响应包含audio_url
        const data = await response.json();
        return data.audio_url;
      } else {
        // 直接返回音频文件
        const audioBlob = await response.blob();
        return URL.createObjectURL(audioBlob);
      }
    } catch (error) {
      console.error('Kokoro TTS API error:', error);
      // 降级到浏览器内置TTS
      return this.fallbackToWebSpeech(text, options);
    }
  }

  /**
   * 降级方案：使用浏览器内置的Web Speech API
   */
  private fallbackToWebSpeech(text: string, options: {
    speed?: number;
    voice?: string;
    language?: string;
    onStart?: () => void;
    onEnd?: () => void;
    onError?: (error: Error) => void;
  } = {}): Promise<string> {
    return new Promise((resolve, reject) => {
      if (!('speechSynthesis' in window)) {
        reject(new Error('Speech synthesis not supported'));
        return;
      }

      const { speed = 0.7, language = 'en-US', onStart, onEnd, onError } = options;
      const utterance = new SpeechSynthesisUtterance(text);
      
      utterance.lang = language;
      utterance.rate = speed;
      utterance.pitch = 1.0;
      utterance.volume = 1.0;

      // 选择声音
      const voices = speechSynthesis.getVoices();
      const englishVoice = voices.find(voice => 
        voice.lang.startsWith('en') && 
        (voice.name.includes('Google') || voice.name.includes('Microsoft'))
      );
      
      if (englishVoice) {
        utterance.voice = englishVoice;
      }

      utterance.onstart = () => {
        if (onStart) {
          onStart();
        }
      };

      utterance.onend = () => {
        if (onEnd) {
          onEnd();
        }
        resolve('web-speech-api'); // 表示使用了Web Speech API
      };

      utterance.onerror = (event) => {
        const error = new Error(`Speech synthesis failed: ${event.error}`);
        if (onError) {
          onError(error);
        }
        reject(error);
      };

      speechSynthesis.speak(utterance);
    });
  }

  /**
   * 播放音频文件
   */
  async playAudio(audioUrl: string, options: {
    speed?: number;
    onStart?: () => void;
    onProgress?: (currentTime: number, duration: number) => void;
    onEnd?: () => void;
    onError?: (error: Error) => void;
  } = {}): Promise<void> {
    const { speed = 0.7, onStart, onProgress, onEnd, onError } = options;

    return new Promise((resolve, reject) => {
      // 停止当前播放的音频
      this.stopCurrentAudio();

      if (audioUrl === 'web-speech-api') {
        // Web Speech API 已经在 fallbackToWebSpeech 中播放了
        resolve();
        return;
      }

      const audio = new Audio(audioUrl);
      this.currentAudio = audio;

      audio.playbackRate = speed;
      audio.preload = 'auto';

      audio.addEventListener('loadedmetadata', () => {
        // 音频元数据加载完成
      });

      audio.addEventListener('canplaythrough', () => {
        // 音频可以播放
        if (onStart) {
          onStart();
        }
      });

      audio.addEventListener('timeupdate', () => {
        if (onProgress) {
          onProgress(audio.currentTime, audio.duration);
        }
      });

      audio.addEventListener('ended', () => {
        this.currentAudio = null;
        if (onEnd) {
          onEnd();
        }
        resolve();
      });

      audio.addEventListener('error', (event) => {
        this.currentAudio = null;
        const error = new Error(`Audio playback failed: ${audio.error?.message || 'Unknown error'}`);
        if (onError) onError(error);
        reject(error);
      });

      audio.play().then(() => {
        if (onStart) {
          onStart();
        }
      }).catch((error) => {
        this.currentAudio = null;
        const playError = new Error(`Failed to start audio playback: ${error.message}`);
        if (onError) onError(playError);
        reject(playError);
      });
    });
  }

  /**
   * 直接朗读文本（使用最佳可用方法）
   */
  async speakText(text: string, options: {
    speed?: number;
    voice?: string;
    language?: string;
    onStart?: () => void;
    onProgress?: (currentTime: number, duration: number) => void;
    onEnd?: () => void;
    onError?: (error: Error) => void;
  } = {}): Promise<void> {
    try {
      // 首先尝试使用后端TTS
      const audioUrl = await this.generateSpeech(text, options);
      await this.playAudio(audioUrl, options);
    } catch (error) {
      // 如果后端TTS失败，尝试Web Speech API
      console.warn('Backend TTS failed, falling back to Web Speech API:', error);
      
      if (options.onError) {
        options.onError(error as Error);
      }
      
      // 这里不抛出错误，因为 fallbackToWebSpeech 会直接播放
    }
  }

  /**
   * 停止当前播放的音频
   */
  stopCurrentAudio(): void {
    if (this.currentAudio) {
      this.currentAudio.pause();
      this.currentAudio.currentTime = 0;
      this.currentAudio = null;
    }

    // 停止Web Speech API
    if ('speechSynthesis' in window) {
      speechSynthesis.cancel();
    }
  }

  /**
   * 暂停当前音频
   */
  pauseCurrentAudio(): void {
    if (this.currentAudio) {
      this.currentAudio.pause();
    }

    if ('speechSynthesis' in window) {
      speechSynthesis.pause();
    }
  }

  /**
   * 恢复播放
   */
  resumeCurrentAudio(): void {
    if (this.currentAudio && this.currentAudio.paused) {
      this.currentAudio.play();
    }

    if ('speechSynthesis' in window) {
      speechSynthesis.resume();
    }
  }

  /**
   * 检查是否正在播放
   */
  isPlaying(): boolean {
    if (this.currentAudio) {
      return !this.currentAudio.paused && !this.currentAudio.ended;
    }

    if ('speechSynthesis' in window) {
      return speechSynthesis.speaking;
    }

    return false;
  }

  /**
   * 获取可用的TTS语音列表（来自kokoro服务）
   */
  async getAvailableTTSVoices(provider = 'kokoro'): Promise<Array<{
    id: string;
    name: string;
    gender: string;
    language: string;
    accent: string;
  }>> {
    try {
      const token = localStorage.getItem('access_token');
      const headers: HeadersInit = {};
      
      if (token) {
        headers['Authorization'] = `Bearer ${token}`;
      }

      const response = await fetch(`/api/tts/voices?provider=${provider}`, {
        headers
      });

      if (!response.ok) {
        throw new Error('Failed to fetch TTS voices');
      }

      const data = await response.json();
      return data.voices || [];
    } catch (error) {
      console.error('Failed to get TTS voices:', error);
      return [];
    }
  }

  /**
   * 获取浏览器内置的声音列表
   */
  getBrowserVoices(): SpeechSynthesisVoice[] {
    if ('speechSynthesis' in window) {
      return speechSynthesis.getVoices().filter(voice => voice.lang.startsWith('en'));
    }
    return [];
  }

  /**
   * 预加载音频（用于提高响应速度）
   */
  async preloadAudio(text: string, options: {
    speed?: number;
    voice?: string;
    language?: string;
  } = {}): Promise<string> {
    try {
      return await this.generateSpeech(text, options);
    } catch (error) {
      console.warn('Failed to preload audio:', error);
      return 'web-speech-api';
    }
  }

  /**
   * 清理资源
   */
  cleanup(): void {
    this.stopCurrentAudio();
    
    if (this.audioContext && this.audioContext.state !== 'closed') {
      this.audioContext.close();
      this.audioContext = null;
    }
  }
}

export const ttsService = new TTSService();