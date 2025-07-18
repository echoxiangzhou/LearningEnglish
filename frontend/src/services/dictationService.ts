import type {
  DictationSentence,
  DictationSession,
  DictationSettings,
  HintInfo,
  DictationProgress,
  WordLibrary,
  DictationConfig
} from '../types/dictation';
import { WORD_LIBRARIES } from '../types/dictation';
import { authService } from './authService';

const API_BASE = '/api';

class DictationService {
  private getAuthHeaders() {
    const token = authService.getToken();
    if (!token) {
      throw new Error('No authentication token found. Please login first.');
    }
    return {
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    };
  }

  // 获取可用的词库
  getWordLibraries(): WordLibrary[] {
    return WORD_LIBRARIES;
  }

  // 获取练习句子
  async getPracticeSentences(config: DictationConfig): Promise<DictationSentence[]> {
    const params = new URLSearchParams({
      count: config.sentence_count.toString(),
      difficulty: config.difficulty_level.toString(),
      practice_type: config.practice_type,
      focus_problem_words: 'true'
    });

    // 如果是单词练习，添加词库参数
    if (config.practice_type === 'word') {
      params.append('grade_level', this.getGradeLevelFromLibrary(config.library).toString());
      params.append('library', config.library);
    }

    // 如果是句子练习且选择了分类，添加分类参数
    if (config.practice_type === 'sentence' && config.categories && config.categories.length > 0) {
      config.categories.forEach(categoryId => {
        params.append('categories', categoryId.toString());
      });
    }

    const response = await fetch(`${API_BASE}/dictation/practice-sentences?${params}`, {
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to fetch practice sentences');
    }

    const data = await response.json();
    
    // 直接返回后端数据，包含真实的中文翻译
    return data.sentences;
  }

  // 创建听写会话
  async createSession(sentenceId: number, config: DictationConfig): Promise<{
    session: DictationSession;
    audio: { url: string; duration: number };
  }> {
    const requestData = {
      sentence_id: sentenceId,
      difficulty: this.mapDifficultyToBackend(config.difficulty_level),
      blank_percentage: this.getBlankPercentage(config.mode)
    };

    const response = await fetch(`${API_BASE}/dictation/session`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify(requestData)
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to create session');
    }

    const data = await response.json();
    
    // 直接使用后端返回的数据，不覆盖中文翻译
    return {
      session: data.session,
      audio: data.audio
    };
  }

  // 获取会话状态
  async getSessionState(sessionId: number): Promise<DictationSession> {
    const response = await fetch(`${API_BASE}/dictation/session/${sessionId}`, {
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to get session state');
    }

    const data = await response.json();
    
    // 直接返回后端数据，不覆盖中文翻译
    return data.session;
  }

  // 提交单词
  async submitWord(sessionId: number | undefined, position: number, userInput: string): Promise<{
    success: boolean;
    is_correct: boolean;
    feedback?: string;
    progress?: DictationProgress;
  }> {
    // 使用 session_id 或 id
    const actualSessionId = sessionId || 0;
    
    const response = await fetch(`${API_BASE}/dictation/submit-word`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify({
        session_id: actualSessionId,
        position: position,
        user_input: userInput
      })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to submit word');
    }

    return response.json();
  }

  // 获取提示
  async getHint(sessionId: number, position: number, hintType: 'letter' | 'phonetic' | 'definition' | 'full'): Promise<HintInfo> {
    const response = await fetch(`${API_BASE}/dictation/hint`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify({
        session_id: sessionId,
        position: position,
        hint_type: hintType
      })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to get hint');
    }

    const data = await response.json();
    return {
      type: hintType,
      content: data.hint,
      cost: data.cost || 0
    };
  }

  // 更新播放速度
  async updatePlaybackSpeed(sessionId: number, speed: number): Promise<{ url: string; duration: number }> {
    const response = await fetch(`${API_BASE}/dictation/playback-speed`, {
      method: 'PUT',
      headers: this.getAuthHeaders(),
      body: JSON.stringify({
        session_id: sessionId,
        speed: speed
      })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to update playback speed');
    }

    const data = await response.json();
    return data.audio;
  }

  // 记录音频播放
  async recordPlayback(sessionId: number, duration: number): Promise<void> {
    await fetch(`${API_BASE}/dictation/record-playback`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify({
        session_id: sessionId,
        duration: duration
      })
    });
  }

  // 获取用户设置
  async getSettings(): Promise<DictationSettings> {
    const response = await fetch(`${API_BASE}/dictation/settings`, {
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to get settings');
    }

    const data = await response.json();
    return data.settings;
  }

  // 更新用户设置
  async updateSettings(settings: Partial<DictationSettings>): Promise<DictationSettings> {
    const response = await fetch(`${API_BASE}/dictation/settings`, {
      method: 'PUT',
      headers: this.getAuthHeaders(),
      body: JSON.stringify(settings)
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to update settings');
    }

    const data = await response.json();
    return data.settings;
  }

  // 获取统计信息
  async getStatistics(): Promise<any> {
    const response = await fetch(`${API_BASE}/dictation/statistics`, {
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to get statistics');
    }

    const data = await response.json();
    return data.statistics;
  }

  // 工具方法
  private getGradeLevelFromLibrary(libraryId: string): number {
    const library = WORD_LIBRARIES.find(lib => lib.id === libraryId);
    return library?.grade_level || 6;
  }

  private mapDifficultyToBackend(level: number): string {
    switch (level) {
      case 1: return 'beginner';
      case 2: return 'elementary';
      case 3: return 'intermediate';
      case 4:
      case 5: return 'advanced';
      default: return 'elementary';
    }
  }

  private getBlankPercentage(mode: string): number {
    switch (mode) {
      case 'full_blank': return 1.0;  // 100% for true full blank mode
      case 'partial_blank': return 0.6;
      case 'key_words_only': return 0.3;
      default: return 0.6;
    }
  }

  // 已废弃：现在直接使用后端返回的真实中文翻译
  // private generateChineseTranslation(englishText: string): string {
  //   // 此方法已不再使用，所有翻译都从数据库获取
  //   return `包含关键词：${englishText.split(' ').slice(0, 3).join(', ')} 等的英语句子`;
  // }

  // 计算进度
  calculateProgress(session: DictationSession): DictationProgress {
    const totalWords = session.total_words || 0;
    const completedWords = session.completed_words || 0;
    const correctWords = session.words ? session.words.filter(word => word.is_correct).length : 0;
    
    return {
      totalWords,
      completedWords,
      correctWords,
      hintsUsed: session.hints_used || 0,
      audioPlays: session.play_count || 0,
      timeSpent: session.start_time ? 
        Math.floor((Date.now() - new Date(session.start_time).getTime()) / 1000) : 0,
      accuracy: totalWords > 0 ? Math.round((correctWords / totalWords) * 100) : 0
    };
  }

  // 格式化时间
  formatTime(seconds: number): string {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
  }
}

export const dictationService = new DictationService();