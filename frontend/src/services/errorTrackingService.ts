import { request } from '../utils/request';

export interface WordError {
  id: number;
  user_id: number;
  word_id?: number;
  sentence_id?: number;
  error_type: string;
  expected_text: string;
  actual_text: string;
  context?: string;
  practice_type: string;
  session_id?: string;
  error_count: number;
  first_error_date: string;
  last_error_date: string;
  is_resolved: boolean;
  resolved_date?: string;
}

export interface ErrorPattern {
  id: number;
  user_id: number;
  pattern_type: string;
  description?: string;
  rule_or_example?: string;
  frequency: number;
  identified_date: string;
  last_occurrence: string;
  practice_attempts: number;
  success_rate: number;
  is_improving: boolean;
}

export interface ErrorReview {
  id: number;
  user_id: number;
  word_error_id: number;
  review_date: string;
  was_correct: boolean;
  response_time?: number;
  confidence_level?: number;
  next_review_date?: string;
  review_interval_days: number;
}

export interface ErrorStatistics {
  total_errors: number;
  active_errors: number;
  resolved_errors: number;
  resolution_rate: number;
  error_types: Array<{
    type: string;
    count: number;
  }>;
  problematic_words: Array<{
    word: string;
    errors: number;
  }>;
  patterns: ErrorPattern[];
}

export interface RecordErrorRequest {
  expected_text: string;
  actual_text: string;
  practice_type: 'word_practice' | 'sentence_practice';
  word_id?: number;
  sentence_id?: number;
  context?: string;
  session_id?: string;
}

export interface UpdateReviewRequest {
  was_correct: boolean;
  response_time?: number;
  confidence_level?: number;
}

class ErrorTrackingService {
  /**
   * Record a word error during practice
   */
  async recordError(errorData: RecordErrorRequest): Promise<{ success: boolean; error_id: number; error: WordError }> {
    const response = await request.post('/api/errors/record', errorData);
    return response.data;
  }

  /**
   * Get user's word errors
   */
  async getUserErrors(params?: {
    practice_type?: string;
    include_resolved?: boolean;
  }): Promise<{ success: boolean; errors: WordError[] }> {
    const queryParams = new URLSearchParams();
    if (params?.practice_type) {
      queryParams.append('practice_type', params.practice_type);
    }
    if (params?.include_resolved !== undefined) {
      queryParams.append('include_resolved', params.include_resolved.toString());
    }

    const response = await request.get(`/api/errors/list?${queryParams.toString()}`);
    return response.data;
  }

  /**
   * Get comprehensive error statistics for user
   */
  async getErrorStatistics(): Promise<{ success: boolean; statistics: ErrorStatistics }> {
    const response = await request.get('/api/errors/statistics');
    return response.data;
  }

  /**
   * Mark an error as resolved
   */
  async resolveError(errorId: number): Promise<{ success: boolean; message: string }> {
    const response = await request.post(`/api/errors/${errorId}/resolve`);
    return response.data;
  }

  /**
   * Get words that need review
   */
  async getReviewWords(limit?: number): Promise<{ success: boolean; words_for_review: WordError[] }> {
    const queryParams = new URLSearchParams();
    if (limit) {
      queryParams.append('limit', limit.toString());
    }

    const response = await request.get(`/api/errors/review-words?${queryParams.toString()}`);
    return response.data;
  }

  /**
   * Create a review session for specific word errors
   */
  async createReviewSession(wordErrorIds: number[]): Promise<{ success: boolean; reviews: ErrorReview[] }> {
    const response = await request.post('/api/errors/create-review-session', {
      word_error_ids: wordErrorIds
    });
    return response.data;
  }

  /**
   * Update the result of a review session
   */
  async updateReviewResult(reviewId: number, reviewData: UpdateReviewRequest): Promise<{ success: boolean; review: ErrorReview }> {
    const response = await request.post(`/api/errors/review/${reviewId}/update`, reviewData);
    return response.data;
  }

  /**
   * Get user's error patterns
   */
  async getErrorPatterns(): Promise<{ success: boolean; patterns: ErrorPattern[] }> {
    const response = await request.get('/api/errors/patterns');
    return response.data;
  }

  /**
   * Export user's error data
   */
  async exportUserErrors(params?: {
    include_resolved?: boolean;
    format?: 'json' | 'csv';
  }): Promise<any> {
    const queryParams = new URLSearchParams();
    if (params?.include_resolved !== undefined) {
      queryParams.append('include_resolved', params.include_resolved.toString());
    }
    if (params?.format) {
      queryParams.append('format', params.format);
    }

    const response = await request.get(`/api/errors/export?${queryParams.toString()}`, {
      responseType: params?.format === 'csv' ? 'blob' : 'json'
    });

    if (params?.format === 'csv') {
      // Handle CSV download
      const blob = new Blob([response.data], { type: 'text/csv' });
      const url = window.URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = 'word_errors.csv';
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);
      return { success: true };
    }

    return response.data;
  }

  /**
   * Get error type description
   */
  getErrorTypeDescription(errorType: string): string {
    const descriptions: Record<string, string> = {
      'spelling': 'Spelling error',
      'pronunciation': 'Pronunciation error',
      'missing_word': 'Missing word',
      'extra_word': 'Extra word',
      'word_order': 'Word order error',
      'capitalization': 'Capitalization error',
      'punctuation': 'Punctuation error'
    };
    return descriptions[errorType] || errorType;
  }

  /**
   * Get error severity based on error count and frequency
   */
  getErrorSeverity(error: WordError): 'low' | 'medium' | 'high' {
    if (error.error_count >= 5) return 'high';
    if (error.error_count >= 3) return 'medium';
    return 'low';
  }

  /**
   * Calculate learning progress for errors
   */
  calculateErrorProgress(errors: WordError[]): {
    totalErrors: number;
    resolvedErrors: number;
    recentErrors: number;
    progressPercentage: number;
  } {
    const totalErrors = errors.length;
    const resolvedErrors = errors.filter(e => e.is_resolved).length;
    const oneWeekAgo = new Date();
    oneWeekAgo.setDate(oneWeekAgo.getDate() - 7);
    const recentErrors = errors.filter(e => 
      new Date(e.last_error_date) > oneWeekAgo && !e.is_resolved
    ).length;
    
    const progressPercentage = totalErrors > 0 ? (resolvedErrors / totalErrors) * 100 : 100;

    return {
      totalErrors,
      resolvedErrors,
      recentErrors,
      progressPercentage
    };
  }
}

export const errorTrackingService = new ErrorTrackingService();