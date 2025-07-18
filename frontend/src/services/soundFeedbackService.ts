interface SoundConfig {
  keyboard_sound_enabled: boolean;
  keyboard_sound_volume: number;
  keyboard_sound_file: string;
  success_sound_enabled: boolean;
  success_sound_volume: number;
  success_sound_file: string;
  error_sound_enabled: boolean;
  error_sound_volume: number;
  error_sound_file: string;
  completion_sound_enabled: boolean;
  completion_sound_volume: number;
  completion_sound_file: string;
  master_volume: number;
  sounds_enabled: boolean;
}

interface SoundEffects {
  keyboard: Array<{id: string; name: string; file: string; description: string}>;
  success: Array<{id: string; name: string; file: string; description: string}>;
  error: Array<{id: string; name: string; file: string; description: string}>;
  completion: Array<{id: string; name: string; file: string; description: string}>;
}

class SoundFeedbackService {
  private audioContext: AudioContext | null = null;
  private keyboardSoundBuffer: AudioBuffer | null = null;
  private successSoundBuffer: AudioBuffer | null = null;
  private errorSoundBuffer: AudioBuffer | null = null;
  private completionSoundBuffer: AudioBuffer | null = null;
  private soundConfig: SoundConfig | null = null;
  private soundEffects: SoundEffects | null = null;
  private audioCache: Map<string, HTMLAudioElement> = new Map();

  constructor() {
    this.initializeAudioContext();
    this.createSounds();
    // Set default configs initially, will be loaded from API after user login
    this.setDefaultSoundConfig();
    this.setDefaultSoundEffects();
  }

  public async initialize() {
    // Ensure audio context is properly initialized on user interaction
    if (this.audioContext && this.audioContext.state === 'suspended') {
      await this.audioContext.resume();
    }
    
    // Try to load config from API if user is logged in
    const token = localStorage.getItem('access_token');
    if (token) {
      await this.loadSoundConfig();
      await this.loadSoundEffects();
    }
  }

  private initializeAudioContext() {
    if (typeof window !== 'undefined' && (window.AudioContext || (window as any).webkitAudioContext)) {
      this.audioContext = new (window.AudioContext || (window as any).webkitAudioContext)();
    }
  }

  private async loadSoundConfig() {
    try {
      const token = localStorage.getItem('access_token');
      if (!token) {
        // No token available, use default config
        this.setDefaultSoundConfig();
        return;
      }

      const response = await fetch('/api/sound/config', {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }
      
      const data = await response.json();
      if (data.success) {
        this.soundConfig = data.config;
      } else {
        throw new Error(data.error || 'Failed to get sound config');
      }
    } catch (error) {
      console.warn('Failed to load sound configuration:', error);
      // Use default config
      this.setDefaultSoundConfig();
    }
  }

  private async loadSoundEffects() {
    try {
      const token = localStorage.getItem('access_token');
      if (!token) {
        // No token available, use default effects
        this.setDefaultSoundEffects();
        return;
      }

      const response = await fetch('/api/sound/effects', {
        headers: {
          'Authorization': `Bearer ${token}`
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }
      
      const data = await response.json();
      if (data.success) {
        this.soundEffects = data.sound_effects;
      } else {
        throw new Error(data.error || 'Failed to get sound effects');
      }
    } catch (error) {
      console.warn('Failed to load sound effects:', error);
      // Use default sound effects
      this.setDefaultSoundEffects();
    }
  }

  private async createSounds() {
    if (!this.audioContext) return;

    // Create keyboard typing sound (short click)
    this.keyboardSoundBuffer = await this.createKeyboardSound();
    
    // Create success sound (cheerful beep sequence)
    this.successSoundBuffer = await this.createSuccessSound();
    
    // Create error sound (warning beep)
    this.errorSoundBuffer = await this.createErrorSound();
    
    // Create completion sound (achievement melody)
    this.completionSoundBuffer = await this.createCompletionSound();
  }

  private async createKeyboardSound(): Promise<AudioBuffer | null> {
    if (!this.audioContext) return null;

    const sampleRate = this.audioContext.sampleRate;
    const duration = 0.1; // 100ms
    const buffer = this.audioContext.createBuffer(1, sampleRate * duration, sampleRate);
    const channelData = buffer.getChannelData(0);

    // Create a short click sound
    for (let i = 0; i < channelData.length; i++) {
      const t = i / sampleRate;
      const envelope = Math.exp(-t * 50); // Exponential decay
      const frequency = 800 + Math.random() * 200; // Random frequency between 800-1000Hz
      channelData[i] = Math.sin(2 * Math.PI * frequency * t) * envelope * 0.1;
    }

    return buffer;
  }

  private async createSuccessSound(): Promise<AudioBuffer | null> {
    if (!this.audioContext) return null;

    const sampleRate = this.audioContext.sampleRate;
    const duration = 0.8; // 800ms
    const buffer = this.audioContext.createBuffer(1, sampleRate * duration, sampleRate);
    const channelData = buffer.getChannelData(0);

    // Create a happy melody (C-E-G-C)
    const notes = [261.63, 329.63, 392.00, 523.25]; // C4, E4, G4, C5
    const noteDuration = duration / notes.length;

    for (let i = 0; i < channelData.length; i++) {
      const t = i / sampleRate;
      const noteIndex = Math.floor(t / noteDuration);
      const noteTime = t - noteIndex * noteDuration;
      
      if (noteIndex < notes.length) {
        const frequency = notes[noteIndex];
        const envelope = Math.exp(-noteTime * 3) * Math.max(0, 1 - noteTime / noteDuration);
        channelData[i] = Math.sin(2 * Math.PI * frequency * noteTime) * envelope * 0.2;
      }
    }

    return buffer;
  }

  private async createErrorSound(): Promise<AudioBuffer | null> {
    if (!this.audioContext) return null;

    const sampleRate = this.audioContext.sampleRate;
    const duration = 0.4; // 400ms
    const buffer = this.audioContext.createBuffer(1, sampleRate * duration, sampleRate);
    const channelData = buffer.getChannelData(0);

    // Create a warning beep (low frequency buzz)
    for (let i = 0; i < channelData.length; i++) {
      const t = i / sampleRate;
      const envelope = Math.exp(-t * 4); // Slower decay
      const frequency = 220; // A3 note, lower and more warning-like
      channelData[i] = Math.sin(2 * Math.PI * frequency * t) * envelope * 0.3;
    }

    return buffer;
  }

  private async createCompletionSound(): Promise<AudioBuffer | null> {
    if (!this.audioContext) return null;

    const sampleRate = this.audioContext.sampleRate;
    const duration = 1.2; // 1200ms
    const buffer = this.audioContext.createBuffer(1, sampleRate * duration, sampleRate);
    const channelData = buffer.getChannelData(0);

    // Create an achievement melody (C-D-E-F-G-A-B-C)
    const notes = [261.63, 293.66, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25];
    const noteDuration = duration / notes.length;

    for (let i = 0; i < channelData.length; i++) {
      const t = i / sampleRate;
      const noteIndex = Math.floor(t / noteDuration);
      const noteTime = t - noteIndex * noteDuration;
      
      if (noteIndex < notes.length) {
        const frequency = notes[noteIndex];
        const envelope = Math.exp(-noteTime * 2) * Math.max(0, 1 - noteTime / noteDuration);
        channelData[i] = Math.sin(2 * Math.PI * frequency * noteTime) * envelope * 0.25;
      }
    }

    return buffer;
  }

  public async playKeyboardSound() {
    if (!this.shouldPlaySound('keyboard')) return;

    try {
      await this.playConfiguredSound('keyboard');
    } catch (error) {
      console.warn('Failed to play keyboard sound:', error);
    }
  }

  public async playSuccessSound() {
    if (!this.shouldPlaySound('success')) return;

    try {
      await this.playConfiguredSound('success');
    } catch (error) {
      console.warn('Failed to play success sound:', error);
    }
  }

  public async playErrorSound() {
    if (!this.shouldPlaySound('error')) return;

    try {
      await this.playConfiguredSound('error');
    } catch (error) {
      console.warn('Failed to play error sound:', error);
    }
  }

  public async playCompletionSound() {
    if (!this.shouldPlaySound('completion')) return;

    try {
      await this.playConfiguredSound('completion');
    } catch (error) {
      console.warn('Failed to play completion sound:', error);
    }
  }

  private async playConfiguredSound(soundType: 'keyboard' | 'success' | 'error' | 'completion') {
    if (!this.soundConfig || !this.soundEffects) return;

    const soundId = this.soundConfig[`${soundType}_sound_file`];
    const soundEffect = this.soundEffects[soundType].find(s => s.id === soundId);
    
    if (soundEffect) {
      // Play file-based sound
      await this.playFileSound(soundType, soundEffect.file);
    } else {
      // Fallback to programmatic sound
      await this.playProgrammaticSound(soundType);
    }
  }

  private async playFileSound(soundType: 'keyboard' | 'success' | 'error' | 'completion', filename: string) {
    const soundPath = `/sounds/${soundType}/${filename}`;
    
    let audio = this.audioCache.get(soundPath);
    if (!audio) {
      audio = new Audio(soundPath);
      this.audioCache.set(soundPath, audio);
    }
    
    // Set volume
    if (this.soundConfig) {
      const volume = this.soundConfig.master_volume * this.soundConfig[`${soundType}_sound_volume`];
      audio.volume = Math.max(0, Math.min(1, volume));
    }
    
    await audio.play();
  }

  private async playProgrammaticSound(soundType: 'keyboard' | 'success' | 'error' | 'completion') {
    if (!this.audioContext) return;
    
    let buffer: AudioBuffer | null = null;
    switch (soundType) {
      case 'keyboard':
        buffer = this.keyboardSoundBuffer;
        break;
      case 'success':
        buffer = this.successSoundBuffer;
        break;
      case 'error':
        buffer = this.errorSoundBuffer;
        break;
      case 'completion':
        buffer = this.completionSoundBuffer;
        break;
    }
    
    if (buffer) {
      await this.playSound(buffer, soundType);
    }
  }

  private shouldPlaySound(soundType: 'keyboard' | 'success' | 'error' | 'completion'): boolean {
    if (!this.soundConfig || !this.soundConfig.sounds_enabled) return false;
    
    switch (soundType) {
      case 'keyboard':
        return this.soundConfig.keyboard_sound_enabled;
      case 'success':
        return this.soundConfig.success_sound_enabled;
      case 'error':
        return this.soundConfig.error_sound_enabled;
      case 'completion':
        return this.soundConfig.completion_sound_enabled;
      default:
        return false;
    }
  }

  private async playSound(buffer: AudioBuffer, soundType: 'keyboard' | 'success' | 'error' | 'completion') {
    if (!this.audioContext || !this.soundConfig) return;

    // Resume audio context if it's suspended
    if (this.audioContext.state === 'suspended') {
      await this.audioContext.resume();
    }

    const source = this.audioContext.createBufferSource();
    const gainNode = this.audioContext.createGain();
    
    source.buffer = buffer;
    source.connect(gainNode);
    gainNode.connect(this.audioContext.destination);
    
    // Set volume based on sound type and master volume
    let volume = this.soundConfig.master_volume;
    switch (soundType) {
      case 'keyboard':
        volume *= this.soundConfig.keyboard_sound_volume;
        break;
      case 'success':
        volume *= this.soundConfig.success_sound_volume;
        break;
      case 'error':
        volume *= this.soundConfig.error_sound_volume;
        break;
      case 'completion':
        volume *= this.soundConfig.completion_sound_volume;
        break;
    }
    
    gainNode.gain.value = volume;
    source.start();
  }

  private setDefaultSoundConfig() {
    this.soundConfig = {
      keyboard_sound_enabled: true,
      keyboard_sound_volume: 0.3,
      keyboard_sound_file: 'keyboard_click_01',
      success_sound_enabled: true,
      success_sound_volume: 0.5,
      success_sound_file: 'success_bell_01',
      error_sound_enabled: true,
      error_sound_volume: 0.5,
      error_sound_file: 'error_buzz_01',
      completion_sound_enabled: true,
      completion_sound_volume: 0.6,
      completion_sound_file: 'completion_fanfare_01',
      master_volume: 0.8,
      sounds_enabled: true
    };
  }

  private setDefaultSoundEffects() {
    this.soundEffects = {
      keyboard: [
        {id: 'keyboard_click_01', name: 'Mechanical Click', file: 'keyboard_click_01.wav', description: 'Sharp mechanical keyboard click'}
      ],
      success: [
        {id: 'success_bell_01', name: 'Bell Ring', file: 'success_bell_01.wav', description: 'Pleasant bell sound'}
      ],
      error: [
        {id: 'error_buzz_01', name: 'Buzz', file: 'error_buzz_01.wav', description: 'Error buzz sound'}
      ],
      completion: [
        {id: 'completion_fanfare_01', name: 'Fanfare', file: 'completion_fanfare_01.wav', description: 'Completion fanfare'}
      ]
    };
  }

  public async reloadSoundConfig() {
    await this.loadSoundConfig();
    await this.loadSoundEffects();
  }

  public setVolume(volume: number) {
    // This could be implemented with a GainNode if needed
    // For now, the sounds are created with appropriate volume levels
  }

  public cleanup() {
    if (this.audioContext && this.audioContext.state !== 'closed') {
      this.audioContext.close();
    }
  }
}

export const soundFeedbackService = new SoundFeedbackService();