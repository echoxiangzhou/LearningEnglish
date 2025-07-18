/**
 * Sound Configuration Service
 * 
 * Service for managing sound effects configuration
 */

export interface SoundEffect {
  id: string;
  name: string;
  file: string;
  description: string;
}

export interface SoundEffects {
  keyboard: SoundEffect[];
  success: SoundEffect[];
  error: SoundEffect[];
  completion: SoundEffect[];
}

export interface SoundConfig {
  id?: number;
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
  settings_json?: any;
  notes?: string;
  created_at?: string;
  updated_at?: string;
}

export interface SoundConfigResponse {
  success: boolean;
  config?: SoundConfig;
  error?: string;
  message?: string;
}

class SoundConfigService {
  private baseUrl = '/api/sound';

  async getSoundConfig(): Promise<SoundConfig> {
    const response = await fetch(`${this.baseUrl}/config`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('access_token')}`
      }
    });

    if (!response.ok) {
      throw new Error('Failed to fetch sound configuration');
    }

    const data: SoundConfigResponse = await response.json();
    if (!data.success || !data.config) {
      throw new Error(data.error || 'Failed to get sound configuration');
    }

    return data.config;
  }

  async updateSoundConfig(config: Partial<SoundConfig>): Promise<SoundConfig> {
    const response = await fetch(`${this.baseUrl}/config`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('access_token')}`
      },
      body: JSON.stringify(config)
    });

    if (!response.ok) {
      throw new Error('Failed to update sound configuration');
    }

    const data: SoundConfigResponse = await response.json();
    if (!data.success || !data.config) {
      throw new Error(data.error || 'Failed to update sound configuration');
    }

    return data.config;
  }

  async resetSoundConfig(): Promise<SoundConfig> {
    const response = await fetch(`${this.baseUrl}/config/reset`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('access_token')}`
      }
    });

    if (!response.ok) {
      throw new Error('Failed to reset sound configuration');
    }

    const data: SoundConfigResponse = await response.json();
    if (!data.success || !data.config) {
      throw new Error(data.error || 'Failed to reset sound configuration');
    }

    return data.config;
  }

  async testSound(soundType: 'keyboard' | 'success' | 'error' | 'completion'): Promise<any> {
    const response = await fetch(`${this.baseUrl}/test-sound`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('access_token')}`
      },
      body: JSON.stringify({ sound_type: soundType })
    });

    if (!response.ok) {
      throw new Error('Failed to test sound');
    }

    const data = await response.json();
    if (!data.success) {
      throw new Error(data.error || 'Failed to test sound');
    }

    return data;
  }

  async getSoundEffects(): Promise<SoundEffects> {
    const response = await fetch(`${this.baseUrl}/effects`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('access_token')}`
      }
    });

    if (!response.ok) {
      throw new Error('Failed to fetch sound effects');
    }

    const data = await response.json();
    if (!data.success) {
      throw new Error(data.error || 'Failed to get sound effects');
    }

    return data.sound_effects;
  }

  async getSoundEffectsByType(soundType: 'keyboard' | 'success' | 'error' | 'completion'): Promise<SoundEffect[]> {
    const response = await fetch(`${this.baseUrl}/effects/${soundType}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${localStorage.getItem('access_token')}`
      }
    });

    if (!response.ok) {
      throw new Error('Failed to fetch sound effects');
    }

    const data = await response.json();
    if (!data.success) {
      throw new Error(data.error || 'Failed to get sound effects');
    }

    return data.sound_effects;
  }

  getSoundEffectPath(soundType: 'keyboard' | 'success' | 'error' | 'completion', filename: string): string {
    return `/sounds/${soundType}/${filename}`;
  }
}

export const soundConfigService = new SoundConfigService();