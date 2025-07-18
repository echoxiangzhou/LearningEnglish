/**
 * DEPRECATED: vocabularyService.ts
 * 
 * This service has been deprecated as part of the application refactoring.
 * The vocabulary learning module has been replaced with:
 * 
 * 1. Word Practice Module: /src/services/wordPracticeService.ts
 *    - Individual word dictation practice
 *    - Error tracking for words
 * 
 * 2. Sentence Practice Module: /src/services/sentencePracticeService.ts
 *    - Complete sentence dictation
 *    - Context-aware error tracking
 * 
 * 3. Error Tracking Service: /src/services/errorTrackingService.ts
 *    - Comprehensive error collection and analysis
 *    - Spaced repetition for error correction
 * 
 * Migration Guide:
 * - Replace vocabulary quiz features with word practice
 * - Replace spaced repetition with error-driven review
 * - Use sentence practice for comprehensive learning
 */

import { errorTrackingService } from './errorTrackingService';

console.warn('⚠️ vocabularyService.ts is deprecated. Vocabulary functionality has been integrated into dictation practice.');

// Provide migration helpers
export const migrationHelpers = {
  errorTracking: errorTrackingService,
  
  // Helper function for migration
  getMigrationInfo() {
    return {
      message: 'Vocabulary functionality has been integrated into dictation practice',
      newModules: [
        'dictationService - integrated word and sentence practice',
        'errorTrackingService - for error analysis and review'
      ]
    };
  }
};

// Legacy compatibility layer (empty implementations to prevent errors)
export const vocabularyService = {
  // Deprecated methods - use dictation practice instead
  getWords: () => {
    console.warn('getWords() is deprecated. Use dictation practice instead.');
    return Promise.resolve({ words: [], total: 0 });
  },
  
  // Deprecated methods - use errorTrackingService instead
  recordError: (error: any) => {
    console.warn('recordError() is deprecated. Use errorTrackingService.recordError() instead.');
    return Promise.resolve();
  },
  
  // General migration guidance
  _migrationInfo: migrationHelpers.getMigrationInfo()
};

export default vocabularyService;