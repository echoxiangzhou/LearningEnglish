/**
 * Enhanced Dictation Service with Error Tracking
 * 
 * Extends the original dictation service to include error tracking functionality
 * while maintaining backward compatibility
 */

import { dictationService } from './dictationService';
import { errorTrackingService } from './errorTrackingService';
import type { DictationConfig, DictationSession } from '../types/dictation';

export class EnhancedDictationService {
  
  // 代理原始dictationService的所有方法
  getWordLibraries() {
    return dictationService.getWordLibraries();
  }

  async getPracticeSentences(config: DictationConfig) {
    return dictationService.getPracticeSentences(config);
  }

  async createSession(sentenceId: number, config: DictationConfig) {
    return dictationService.createSession(sentenceId, config);
  }

  async getSessionState(sessionId: number) {
    return dictationService.getSessionState(sessionId);
  }

  calculateProgress(session: DictationSession) {
    return dictationService.calculateProgress(session);
  }

  async getHint(sessionId: number, position: number, hintType: 'letter' | 'phonetic' | 'definition' | 'full') {
    return dictationService.getHint(sessionId, position, hintType);
  }

  async recordPlayback(sessionId: number, duration: number) {
    return dictationService.recordPlayback(sessionId, duration);
  }

  // 增强的提交单词方法 - 添加错误追踪
  async submitWord(sessionId: number, position: number, userInput: string) {
    // 先调用原始的提交方法
    const result = await dictationService.submitWord(sessionId, position, userInput);
    
    // 如果答案错误，记录到错误追踪系统
    if (result.success && !result.is_correct) {
      try {
        // 获取会话信息以获得正确答案
        const session = await this.getSessionState(sessionId);
        if (session && session.words && session.words[position]) {
          const expectedWord = session.words[position].word;
          
          // 记录错误到错误追踪系统
          await errorTrackingService.recordError({
            expected_text: expectedWord,
            actual_text: userInput,
            practice_type: 'dictation_practice',
            word_id: session.words[position].word_id || undefined,
            sentence_id: session.sentence_id,
            context: session.sentence || `听写练习 - 第${position + 1}个单词`
          });
        }
      } catch (error) {
        console.warn('记录错误到错题库失败:', error);
        // 不阻止原有流程，只是警告
      }
    }
    
    return result;
  }

  // 新增：获取用户的听写错误历史
  async getUserDictationErrors(limit: number = 20) {
    return errorTrackingService.getUserErrors('dictation_practice', limit);
  }

  // 新增：获取错误模式分析
  async getErrorPatterns() {
    return errorTrackingService.getErrorPatterns();
  }

  // 新增：标记错误为已解决
  async markErrorAsResolved(errorId: number) {
    return errorTrackingService.markErrorAsResolved(errorId);
  }

  // 新增：获取需要复习的错误单词
  async getWordsForReview(limit: number = 10) {
    return errorTrackingService.getWordsForReview(limit);
  }
}

// 创建增强的听写服务实例
export const enhancedDictationService = new EnhancedDictationService();

// 为了向后兼容，也导出为默认dictationService
export default enhancedDictationService;