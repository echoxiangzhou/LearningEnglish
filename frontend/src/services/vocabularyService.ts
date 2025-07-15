import type { Word, VocabularyCategory, UserVocabulary } from '../types/vocabulary';

const API_BASE = '/api';

class VocabularyService {
  private getAuthHeaders() {
    const token = localStorage.getItem('token');
    return {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    };
  }

  async getCategories(parentId?: number, gradeLevel?: number): Promise<VocabularyCategory[]> {
    const params = new URLSearchParams();
    if (parentId !== undefined) params.append('parent_id', parentId.toString());
    if (gradeLevel !== undefined) params.append('grade_level', gradeLevel.toString());

    const response = await fetch(`${API_BASE}/vocabulary/categories?${params}`, {
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to fetch categories');
    }

    const data = await response.json();
    return data.categories;
  }

  async getCategoryWords(categoryId: number, limit = 50, offset = 0): Promise<Word[]> {
    const params = new URLSearchParams({
      limit: limit.toString(),
      offset: offset.toString()
    });

    const response = await fetch(`${API_BASE}/vocabulary/categories/${categoryId}/words?${params}`, {
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to fetch words');
    }

    const data = await response.json();
    return data.words;
  }

  async searchWords(query: string, limit = 20): Promise<Word[]> {
    const params = new URLSearchParams({
      q: query,
      limit: limit.toString()
    });

    const response = await fetch(`${API_BASE}/vocabulary/search?${params}`, {
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to search words');
    }

    const data = await response.json();
    return data.words;
  }

  async getUserVocabulary(wordId: number): Promise<UserVocabulary | null> {
    const response = await fetch(`${API_BASE}/vocabulary/personal/${wordId}`, {
      headers: this.getAuthHeaders()
    });

    if (response.status === 404) {
      return null;
    }

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to fetch user vocabulary');
    }

    const data = await response.json();
    return data.vocabulary;
  }

  async addToFavorites(wordId: number, notes?: string): Promise<UserVocabulary> {
    const response = await fetch(`${API_BASE}/vocabulary/personal`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify({ word_id: wordId, notes })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to add to favorites');
    }

    const data = await response.json();
    return data.vocabulary;
  }

  async removeFromFavorites(wordId: number): Promise<void> {
    const response = await fetch(`${API_BASE}/vocabulary/personal/${wordId}`, {
      method: 'DELETE',
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to remove from favorites');
    }
  }

  async generateAudio(text: string): Promise<string> {
    const response = await fetch(`${API_BASE}/tts/generate`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify({ 
        text,
        provider: 'minimax',
        voice_setting: {
          voice_id: 'female-english',
          speed: 1.0,
          emotion: 'neutral'
        }
      })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to generate audio');
    }

    const data = await response.json();
    return data.audio_url;
  }

  async generateWordAudio(word: string): Promise<string> {
    const response = await fetch(`${API_BASE}/tts/word-emphasis`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify({ 
        word,
        provider: 'minimax',
        voice_setting: {
          voice_id: 'female-english',
          speed: 0.8,
          emotion: 'neutral'
        }
      })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message || 'Failed to generate word audio');
    }

    const data = await response.json();
    return data.audio_url;
  }

  getDifficultyColor(difficulty: number): string {
    switch (difficulty) {
      case 1: return '#52c41a'; // green - easy
      case 2: return '#1890ff'; // blue - medium-easy
      case 3: return '#faad14'; // orange - medium
      case 4: return '#fa8c16'; // dark orange - medium-hard
      case 5: return '#f5222d'; // red - hard
      default: return '#d9d9d9'; // gray - unknown
    }
  }

  getDifficultyText(difficulty: number): string {
    switch (difficulty) {
      case 1: return 'Easy';
      case 2: return 'Medium-Easy';
      case 3: return 'Medium';
      case 4: return 'Medium-Hard';
      case 5: return 'Hard';
      default: return 'Unknown';
    }
  }

  formatPhonetic(phonetic?: string): string {
    if (!phonetic) return '';
    // Ensure phonetic is wrapped in forward slashes if not already
    if (!phonetic.startsWith('/') && !phonetic.startsWith('[')) {
      return `/${phonetic}/`;
    }
    return phonetic;
  }
}

export const vocabularyService = new VocabularyService();