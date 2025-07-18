import { authService } from './authService';

const API_BASE = '/api/vocabulary-management';

export interface VocabularyWord {
  id: number;
  word: string;
  phonetic?: string;
  pronunciation?: string;
  definition: string;
  chinese_meaning: string;
  part_of_speech?: string;
  grade_level: number;
  difficulty: number;
  difficulty_level?: 'easy' | 'medium' | 'hard';
  difficulty_text: string;
  audio_url?: string;
  image_url?: string;
  example_sentence?: string;
  example_chinese?: string;
  is_core_vocabulary: boolean;
  created_at: string;
  updated_at: string;
  // Extended fields
  etymology?: string;
  synonyms?: string[];
  antonyms?: string[];
  related_words?: string[];
  irregular_forms?: Record<string, string>;
  usage_notes?: string;
  common_mistakes?: string;
  source?: string;
  categories?: any[];
}

export interface VocabularyLibraryAPI {
  id: number;
  library_id: string;
  name: string;
  description: string;
  library_type: string;
  grade_level?: number;
  total_words: number;
  core_words: number;
  difficulty_min: number;
  difficulty_max: number;
  categories: string[];
  tags: string[];
  is_active: boolean;
  is_public: boolean;
  is_system_library: boolean;
  version: string;
  created_at: string;
  updated_at: string;
  words?: VocabularyWord[];
}

export interface CreateWordRequest {
  word: string;
  phonetic?: string;
  pronunciation?: string;
  definition?: string;
  chinese_meaning: string;
  part_of_speech?: string;
  grade_level?: number;
  difficulty?: number;
  difficulty_level?: 'easy' | 'medium' | 'hard';
  audio_url?: string;
  image_url?: string;
  example_sentence?: string;
  example_chinese?: string;
  usage_notes?: string;
  source?: string;
  is_core_vocabulary?: boolean;
  synonyms?: string[];
  antonyms?: string[];
  related_words?: string[];
  irregular_forms?: Record<string, string>;
}

export interface WordsResponse {
  success: boolean;
  words: VocabularyWord[];
  pagination: {
    page: number;
    per_page: number;
    total: number;
    pages: number;
    has_next: boolean;
    has_prev: boolean;
  };
  library: VocabularyLibraryAPI;
}

export interface LibrariesResponse {
  success: boolean;
  libraries: Array<{
    id: string;
    name: string;
    description: string;
    grade_level?: number;
    word_count: number;
    categories: string[];
  }>;
}

export interface StatisticsResponse {
  success: boolean;
  statistics: {
    total_words: number;
    total_libraries: number;
    words_by_grade?: Record<string, number>;
    words_by_difficulty?: Record<string, number>;
    libraries_by_type?: Record<string, number>;
    assigned_libraries?: number;
  };
}

export interface ProcessedWord {
  word: string;
  original_word: string;
  chinese_meaning: string;
  phonetic?: string;
  definition?: string;
  audio_url?: string;
  audio_generated?: boolean;
  exists: boolean;
}

export interface ImportPreviewResponse {
  success: boolean;
  preview_mode: boolean;
  processed_words: ProcessedWord[];
  failed_words: Array<{ word: string; error: string }>;
  total_words: number;
  successful_words: number;
  failed_count: number;
  library_name: string;
  voice_used?: string;
}

export interface ImportConfirmResponse {
  success: boolean;
  imported_count: number;
  total_words: number;
  library_id: string;
  library_name: string;
}

export interface VoiceOption {
  id: string;
  name: string;
  language: string;
  gender: 'male' | 'female';
}

class VocabularyManagementService {
  private getHeaders() {
    const token = authService.getToken();
    if (!token) {
      throw new Error('No authentication token found. Please login first.');
    }
    return {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    };
  }

  // Library Management
  async getLibraries(): Promise<LibrariesResponse> {
    try {
      const headers = this.getHeaders();
      
      const response = await fetch(`${API_BASE}/libraries`, {
        headers
      });
      
      if (!response.ok) {
        const errorText = await response.text();
        let error;
        try {
          error = JSON.parse(errorText);
        } catch {
          error = { error: errorText };
        }
        throw new Error(error.error || `HTTP ${response.status}: Failed to fetch libraries`);
      }

      const result = await response.json();
      return result;
    } catch (err) {
      console.error('Error in getLibraries:', err);
      throw err;
    }
  }

  async getLibraryWords(
    libraryId: string,
    options: {
      page?: number;
      per_page?: number;
      search?: string;
      difficulty?: number;
      grade_level?: number;
      part_of_speech?: string;
    } = {}
  ): Promise<WordsResponse> {
    const params = new URLSearchParams();
    
    if (options.page) params.append('page', options.page.toString());
    if (options.per_page) params.append('per_page', options.per_page.toString());
    if (options.search) params.append('search', options.search);
    if (options.difficulty) params.append('difficulty', options.difficulty.toString());
    if (options.grade_level) params.append('grade_level', options.grade_level.toString());
    if (options.part_of_speech) params.append('part_of_speech', options.part_of_speech);

    const url = `${API_BASE}/libraries/${libraryId}/words${params.toString() ? '?' + params.toString() : ''}`;
    
    const response = await fetch(url, {
      headers: this.getHeaders()
    });

    if (!response.ok) {
      let error;
      try {
        error = await response.json();
      } catch {
        error = { error: `HTTP ${response.status}: ${response.statusText}` };
      }
      throw new Error(error.error || 'Failed to fetch library words');
    }

    return response.json();
  }

  // Word Management
  async createWord(wordData: CreateWordRequest): Promise<{ success: boolean; message: string; word: VocabularyWord }> {
    const response = await fetch(`${API_BASE}/words`, {
      method: 'POST',
      headers: this.getHeaders(),
      body: JSON.stringify(wordData)
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to create word');
    }

    return response.json();
  }

  async updateWord(wordId: number, wordData: Partial<CreateWordRequest>): Promise<{ success: boolean; message: string; word: VocabularyWord }> {
    const response = await fetch(`${API_BASE}/words/${wordId}`, {
      method: 'PUT',
      headers: this.getHeaders(),
      body: JSON.stringify(wordData)
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to update word');
    }

    return response.json();
  }

  async deleteWord(wordId: number): Promise<{ success: boolean; message: string }> {
    const response = await fetch(`${API_BASE}/words/${wordId}`, {
      method: 'DELETE',
      headers: this.getHeaders()
    });

    if (!response.ok) {
      let error;
      try {
        error = await response.json();
      } catch {
        error = { error: `HTTP ${response.status}: ${response.statusText}` };
      }
      throw new Error(error.error || 'Failed to delete word');
    }

    return response.json();
  }

  // Library-Word Relationships
  async addWordToLibrary(libraryId: string, wordId: number): Promise<{ success: boolean; message: string }> {
    const response = await fetch(`${API_BASE}/libraries/${libraryId}/words/${wordId}`, {
      method: 'POST',
      headers: this.getHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to add word to library');
    }

    return response.json();
  }

  async removeWordFromLibrary(libraryId: string, wordId: number): Promise<{ success: boolean; message: string }> {
    const response = await fetch(`${API_BASE}/libraries/${libraryId}/words/${wordId}`, {
      method: 'DELETE',
      headers: this.getHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to remove word from library');
    }

    return response.json();
  }

  // Statistics
  async getStatistics(): Promise<StatisticsResponse> {
    const response = await fetch(`${API_BASE}/statistics`, {
      headers: this.getHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to fetch statistics');
    }

    return response.json();
  }

  // Library Assignment (Admin/Teacher only)
  async assignLibraryToUser(
    libraryId: string, 
    userId: number, 
    options: {
      is_required?: boolean;
      start_date?: string;
      end_date?: string;
    } = {}
  ): Promise<{ success: boolean; message: string; assignment: any }> {
    const response = await fetch(`${API_BASE}/libraries/${libraryId}/assign`, {
      method: 'POST',
      headers: this.getHeaders(),
      body: JSON.stringify({
        user_id: userId,
        ...options
      })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to assign library');
    }

    return response.json();
  }

  // Import with Audio Generation
  async importVocabularyWithAudio(
    file: File,
    libraryName: string,
    apiKey: string,
    translationModel: string = 'google/gemini-2.0-flash-001',
    voice: string = 'af_bella',
    generateAudio: boolean = true,
    appendMode: boolean = false,
    onProgress?: (progress: number) => void
  ): Promise<ImportPreviewResponse> {
    const formData = new FormData();
    formData.append('file', file);
    formData.append('library_name', libraryName);
    formData.append('api_key', apiKey);
    formData.append('translation_model', translationModel);
    formData.append('voice', voice);
    formData.append('generate_audio', generateAudio.toString());
    formData.append('append_mode', appendMode.toString());

    const response = await fetch(`${API_BASE}/import-with-audio`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${authService.getToken()}`
      },
      body: formData
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Import failed');
    }

    return response.json();
  }

  async confirmImport(
    libraryName: string,
    processedWords: ProcessedWord[],
    appendMode: boolean = false
  ): Promise<ImportConfirmResponse> {
    const response = await fetch(`${API_BASE}/confirm-import`, {
      method: 'POST',
      headers: this.getHeaders(),
      body: JSON.stringify({
        library_name: libraryName,
        processed_words: processedWords,
        append_mode: appendMode
      })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Import confirmation failed');
    }

    return response.json();
  }

  // Get available Kokoro voices
  getKokoroVoices(): VoiceOption[] {
    return [
      { id: 'af_bella', name: 'Bella (American Female)', language: 'en-US', gender: 'female' },
      { id: 'af_sarah', name: 'Sarah (American Female)', language: 'en-US', gender: 'female' },
      { id: 'af_sky', name: 'Sky (American Female)', language: 'en-US', gender: 'female' },
      { id: 'am_adam', name: 'Adam (American Male)', language: 'en-US', gender: 'male' },
      { id: 'am_michael', name: 'Michael (American Male)', language: 'en-US', gender: 'male' },
      { id: 'bf_emma', name: 'Emma (British Female)', language: 'en-GB', gender: 'female' },
      { id: 'bf_isabella', name: 'Isabella (British Female)', language: 'en-GB', gender: 'female' },
      { id: 'bm_george', name: 'George (British Male)', language: 'en-GB', gender: 'male' },
      { id: 'bm_lewis', name: 'Lewis (British Male)', language: 'en-GB', gender: 'male' }
    ];
  }

  // Utility methods
  getDifficultyColor(difficulty: number): string {
    switch (difficulty) {
      case 1: return 'green';
      case 2: return 'blue';
      case 3: return 'orange';
      case 4: return 'red';
      case 5: return 'purple';
      default: return 'default';
    }
  }

  getPartOfSpeechColor(partOfSpeech: string): string {
    switch (partOfSpeech?.toLowerCase()) {
      case 'noun': return 'blue';
      case 'verb': return 'green';
      case 'adjective': return 'orange';
      case 'adverb': return 'purple';
      default: return 'default';
    }
  }

  formatGradeLevel(gradeLevel: number): string {
    if (gradeLevel <= 6) {
      return `小学${gradeLevel}年级`;
    } else if (gradeLevel <= 9) {
      return `初中${gradeLevel - 6}年级`;
    } else {
      return `${gradeLevel}年级`;
    }
  }

  // Retranslation functionality
  async retranslateLibraryWords(
    libraryId: string,
    apiKey: string,
    translationModel: string = 'google/gemini-2.0-flash-001',
    forceRetranslate: boolean = false
  ): Promise<{ 
    success: boolean; 
    message: string; 
    translated_count: number; 
    total_words: number; 
    library_name: string; 
    failed_words?: string[]; 
    failed_count?: number;
  }> {
    const response = await fetch(`${API_BASE}/libraries/${libraryId}/retranslate`, {
      method: 'POST',
      headers: this.getHeaders(),
      body: JSON.stringify({
        api_key: apiKey,
        translation_model: translationModel,
        force_retranslate: forceRetranslate
      })
    });

    if (!response.ok) {
      let error;
      try {
        error = await response.json();
      } catch {
        error = { error: `HTTP ${response.status}: ${response.statusText}` };
      }
      throw new Error(error.error || 'Failed to retranslate words');
    }

    return response.json();
  }

  // Update library information
  async updateLibraryInfo(
    libraryId: string,
    updateData: {
      name?: string;
      grade_level?: number;
      description?: string;
      update_words_grade?: boolean;
      generate_phonetics?: boolean;
      api_key?: string;
    }
  ): Promise<{
    success: boolean;
    message: string;
    updated_words?: number;
    phonetics_generated?: number;
  }> {
    const response = await fetch(`${API_BASE}/libraries/${libraryId}/update-info`, {
      method: 'PUT',
      headers: this.getHeaders(),
      body: JSON.stringify(updateData)
    });

    if (!response.ok) {
      let error;
      try {
        error = await response.json();
      } catch {
        error = { error: `HTTP ${response.status}: ${response.statusText}` };
      }
      throw new Error(error.error || 'Failed to update library information');
    }

    return response.json();
  }

  async getUntranslatedWordsCount(libraryId: string): Promise<{
    success: boolean;
    library_id: string;
    library_name: string;
    untranslated_count: number;
    total_count: number;
    translated_count: number;
  }> {
    const response = await fetch(`${API_BASE}/libraries/${libraryId}/untranslated-count`, {
      headers: this.getHeaders()
    });

    if (!response.ok) {
      let error;
      try {
        error = await response.json();
      } catch {
        error = { error: `HTTP ${response.status}: ${response.statusText}` };
      }
      throw new Error(error.error || 'Failed to get untranslated count');
    }

    return response.json();
  }
}

export const vocabularyManagementService = new VocabularyManagementService();