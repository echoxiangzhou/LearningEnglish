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

const API_BASE = '/api';

class DictationService {
  private getAuthHeaders() {
    const token = localStorage.getItem('token');
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
      grade_level: this.getGradeLevelFromLibrary(config.library).toString(),
      difficulty: config.difficulty_level.toString(),
      focus_problem_words: 'true'
    });

    const response = await fetch(`${API_BASE}/dictation/practice-sentences?${params}`, {
      headers: this.getAuthHeaders()
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to fetch practice sentences');
    }

    const data = await response.json();
    
    // 为每个句子添加中文翻译（这里模拟，实际应该从后端获取）
    return data.sentences.map((sentence: any) => ({
      ...sentence,
      chinese_translation: this.generateChineseTranslation(sentence.text)
    }));
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
    
    // 添加中文翻译到会话数据
    if (data.session?.session_data) {
      data.session.session_data.chinese_translation = 
        this.generateChineseTranslation(data.session.session_data.sentence_text);
    }

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
    
    // 添加中文翻译
    if (data.session?.session_data) {
      data.session.session_data.chinese_translation = 
        this.generateChineseTranslation(data.session.session_data.sentence_text);
    }

    return data.session;
  }

  // 提交单词
  async submitWord(sessionId: number, position: number, userInput: string): Promise<{
    success: boolean;
    is_correct: boolean;
    feedback?: string;
    progress?: DictationProgress;
  }> {
    const response = await fetch(`${API_BASE}/dictation/submit-word`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify({
        session_id: sessionId,
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
      case 1:
      case 2: return 'easy';
      case 3: return 'medium';
      case 4:
      case 5: return 'hard';
      default: return 'medium';
    }
  }

  private getBlankPercentage(mode: string): number {
    switch (mode) {
      case 'full_blank': return 1.0;
      case 'partial_blank': return 0.6;
      case 'key_words_only': return 0.3;
      default: return 0.6;
    }
  }

  // 生成中文翻译（这里是模拟数据，实际应该从后端获取）
  private generateChineseTranslation(englishText: string): string {
    const translations: { [key: string]: string } = {
      'The cat is sleeping on the sofa.': '猫咪正在沙发上睡觉。',
      'I like to read books in the library.': '我喜欢在图书馆里看书。',
      'She goes to school by bus every day.': '她每天坐公交车上学。',
      'We are playing football in the park.': '我们在公园里踢足球。',
      'My mother is cooking dinner in the kitchen.': '我妈妈正在厨房里做晚饭。',
      'The weather is very nice today.': '今天天气很好。',
      'He wants to become a doctor when he grows up.': '他长大后想成为一名医生。',
      'The students are listening to the teacher carefully.': '学生们正在认真听老师讲课。'
    };

    // 如果有预定义的翻译，使用预定义的
    if (translations[englishText]) {
      return translations[englishText];
    }

    // 否则生成简单的提示翻译
    const words = englishText.toLowerCase().split(' ');
    const keyWords = words.filter(word => 
      !['the', 'is', 'are', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for', 'of', 'with'].includes(word.replace(/[.,!?]/g, ''))
    );
    
    return `包含关键词：${keyWords.slice(0, 3).join(', ')} 等的英语句子`;
  }

  // 计算进度
  calculateProgress(session: DictationSession): DictationProgress {
    const { session_data } = session;
    const totalWords = session_data.total_words;
    const completedWords = session_data.completed_words;
    const correctWords = session_data.words.filter(word => word.is_correct).length;
    
    return {
      totalWords,
      completedWords,
      correctWords,
      hintsUsed: session.hints_used,
      audioPlays: session.audio_plays,
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