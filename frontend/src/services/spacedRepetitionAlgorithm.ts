import type {
  SpacedRepetitionCard,
  ReviewResponse,
  SpacedRepetitionSettings,
  LearningStep,
  PerformanceMetrics,
} from '../types/spacedRepetition';
import { ResponseQuality, MasteryLevel } from '../types/spacedRepetition';

/**
 * SM-2 Spaced Repetition Algorithm Implementation
 * Based on the SuperMemo SM-2 algorithm with enhancements for language learning
 */
export class SM2Algorithm {
  private settings: SpacedRepetitionSettings;

  constructor(settings?: Partial<SpacedRepetitionSettings>) {
    this.settings = {
      newCardsPerDay: 20,
      maxReviewsPerDay: 100,
      graduatingInterval: 1,
      easyInterval: 4,
      startingEase: 2.5,
      easyBonus: 1.3,
      intervalModifier: 1.0,
      maximumInterval: 36500, // ~100 years
      hardInterval: 1.2,
      lapseSteps: [1, 10], // 1 minute, 10 minutes
      leechThreshold: 8,
      buryRelated: false,
      timezoneOffset: 0,
      ...settings,
    };
  }

  /**
   * Calculate the next review date and ease factor based on SM-2 algorithm
   */
  calculateNextReview(
    card: SpacedRepetitionCard,
    response: ReviewResponse
  ): {
    interval: number;
    easeFactor: number;
    masteryLevel: MasteryLevel;
    dueDate: Date;
    repetition: number;
  } {
    const { quality, responseTime, isCorrect } = response;
    let { easeFactor, interval, repetition } = card;

    // Adjust quality based on response time (performance-based adjustment)
    const adjustedQuality = this.adjustQualityForPerformance(quality, responseTime, card);

    // SM-2 Algorithm Core Logic
    if (adjustedQuality >= ResponseQuality.CORRECT_DIFFICULT) {
      // Correct response
      if (repetition === 0) {
        interval = 1;
      } else if (repetition === 1) {
        interval = 6;
      } else {
        interval = Math.round(interval * easeFactor);
      }
      repetition += 1;
    } else {
      // Incorrect response - reset repetition and use lapse steps
      repetition = 0;
      interval = this.settings.lapseSteps[0] / (24 * 60); // Convert minutes to days
    }

    // Update ease factor based on quality
    easeFactor = this.calculateNewEaseFactor(easeFactor, adjustedQuality);

    // Apply interval modifier and constraints
    interval = Math.round(interval * this.settings.intervalModifier);
    interval = Math.max(1, Math.min(interval, this.settings.maximumInterval));

    // Calculate due date
    const dueDate = new Date();
    dueDate.setDate(dueDate.getDate() + interval);

    // Determine mastery level
    const masteryLevel = this.determineMasteryLevel(card, response, repetition, interval);

    return {
      interval,
      easeFactor,
      masteryLevel,
      dueDate,
      repetition,
    };
  }

  /**
   * Adjust quality rating based on response time performance
   */
  private adjustQualityForPerformance(
    quality: ResponseQuality,
    responseTime: number,
    card: SpacedRepetitionCard
  ): ResponseQuality {
    const averageTime = card.averageResponseTime || 3000; // Default 3 seconds
    const timeRatio = responseTime / averageTime;

    // If response was much faster than average, potentially increase quality
    if (timeRatio < 0.5 && quality === ResponseQuality.CORRECT_HESITANT) {
      return ResponseQuality.CORRECT_EASY;
    }

    // If response was much slower than average, potentially decrease quality
    if (timeRatio > 2.0 && quality === ResponseQuality.CORRECT_EASY) {
      return ResponseQuality.CORRECT_HESITANT;
    }

    if (timeRatio > 3.0 && quality === ResponseQuality.CORRECT_HESITANT) {
      return ResponseQuality.CORRECT_DIFFICULT;
    }

    return quality;
  }

  /**
   * Calculate new ease factor using SM-2 formula
   */
  private calculateNewEaseFactor(currentEase: number, quality: ResponseQuality): number {
    const newEase = currentEase + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    
    // Ensure ease factor stays within reasonable bounds
    return Math.max(1.3, Math.min(2.5, newEase));
  }

  /**
   * Determine mastery level based on performance and intervals
   */
  private determineMasteryLevel(
    card: SpacedRepetitionCard,
    response: ReviewResponse,
    repetition: number,
    interval: number
  ): MasteryLevel {
    const { isCorrect } = response;
    const { consecutiveCorrect, totalReviews, accuracyRate } = card;

    if (!isCorrect) {
      // Failed review
      if (card.masteryLevel === MasteryLevel.MATURE || card.masteryLevel === MasteryLevel.MASTERED) {
        return MasteryLevel.FORGOTTEN;
      }
      return MasteryLevel.LEARNING;
    }

    // Successful review progression
    if (repetition === 0) {
      return MasteryLevel.NEW;
    } else if (repetition < 3) {
      return MasteryLevel.LEARNING;
    } else if (interval < 21) {
      return MasteryLevel.YOUNG;
    } else if (interval < 90) {
      return MasteryLevel.MATURE;
    } else if (accuracyRate > 90 && consecutiveCorrect > 10) {
      return MasteryLevel.MASTERED;
    } else {
      return MasteryLevel.MATURE;
    }
  }

  /**
   * Calculate performance metrics for a card
   */
  calculatePerformanceMetrics(card: SpacedRepetitionCard, recentResponses: ReviewResponse[]): PerformanceMetrics {
    if (recentResponses.length === 0) {
      return {
        responseTime: 0,
        accuracy: 0,
        consistency: 0,
        improvement: 0,
        retention: 0,
        efficiency: 0,
      };
    }

    const responseTimes = recentResponses.map(r => r.responseTime);
    const accuracies = recentResponses.map(r => r.isCorrect ? 1 : 0);

    // Average response time
    const responseTime = responseTimes.reduce((sum, time) => sum + time, 0) / responseTimes.length;

    // Accuracy rate
    const accuracy = (accuracies.reduce((sum, acc) => sum + acc, 0) / accuracies.length) * 100;

    // Consistency (lower standard deviation is better)
    const avgTime = responseTime;
    const variance = responseTimes.reduce((sum, time) => sum + Math.pow(time - avgTime, 2), 0) / responseTimes.length;
    const consistency = Math.max(0, 100 - Math.sqrt(variance) / avgTime * 100);

    // Improvement rate (comparing first half vs second half of recent responses)
    const midPoint = Math.floor(recentResponses.length / 2);
    const firstHalf = recentResponses.slice(0, midPoint);
    const secondHalf = recentResponses.slice(midPoint);
    
    const firstHalfAccuracy = firstHalf.length > 0 
      ? firstHalf.filter(r => r.isCorrect).length / firstHalf.length * 100 
      : 0;
    const secondHalfAccuracy = secondHalf.length > 0 
      ? secondHalf.filter(r => r.isCorrect).length / secondHalf.length * 100 
      : 0;
    
    const improvement = secondHalfAccuracy - firstHalfAccuracy;

    // Retention rate (based on interval success)
    const retention = Math.min(100, (card.consecutiveCorrect / Math.max(1, card.totalReviews)) * 100);

    // Efficiency (reviews per minute)
    const avgTimeInMinutes = responseTime / (1000 * 60);
    const efficiency = avgTimeInMinutes > 0 ? 1 / avgTimeInMinutes : 0;

    return {
      responseTime,
      accuracy,
      consistency,
      improvement,
      retention,
      efficiency,
    };
  }

  /**
   * Optimize interval based on user performance patterns
   */
  optimizeInterval(
    baseInterval: number,
    card: SpacedRepetitionCard,
    performanceMetrics: PerformanceMetrics
  ): number {
    let modifier = 1.0;

    // Adjust based on accuracy
    if (performanceMetrics.accuracy > 95) {
      modifier *= 1.2; // Increase interval for very high accuracy
    } else if (performanceMetrics.accuracy < 70) {
      modifier *= 0.8; // Decrease interval for low accuracy
    }

    // Adjust based on consistency
    if (performanceMetrics.consistency > 80) {
      modifier *= 1.1; // Reward consistency
    } else if (performanceMetrics.consistency < 50) {
      modifier *= 0.9; // Penalize inconsistency
    }

    // Adjust based on retention
    if (performanceMetrics.retention > 90) {
      modifier *= 1.15; // Strong retention allows longer intervals
    } else if (performanceMetrics.retention < 60) {
      modifier *= 0.7; // Poor retention needs shorter intervals
    }

    const optimizedInterval = Math.round(baseInterval * modifier);
    return Math.max(1, Math.min(optimizedInterval, this.settings.maximumInterval));
  }

  /**
   * Determine if a card should be considered a "leech" (difficult to remember)
   */
  isLeech(card: SpacedRepetitionCard): boolean {
    const recentFailures = this.countRecentFailures(card);
    const failureRate = card.totalReviews > 0 ? (card.totalReviews - card.consecutiveCorrect) / card.totalReviews : 0;
    
    return recentFailures >= this.settings.leechThreshold || failureRate > 0.5;
  }

  /**
   * Count recent failures for leech detection
   */
  private countRecentFailures(card: SpacedRepetitionCard): number {
    // This would typically query recent review history
    // For now, we'll estimate based on current stats
    return Math.max(0, card.totalReviews - card.consecutiveCorrect);
  }

  /**
   * Calculate the optimal daily review distribution
   */
  calculateOptimalDistribution(
    totalDue: number,
    maxReviews: number,
    userPerformancePattern: PerformanceMetrics
  ): { morning: number; afternoon: number; evening: number } {
    const baseDistribution = { morning: 0.4, afternoon: 0.4, evening: 0.2 };
    
    // Adjust based on user performance patterns
    if (userPerformancePattern.efficiency > 1.5) {
      // High efficiency users can handle more reviews
      baseDistribution.morning += 0.1;
      baseDistribution.afternoon += 0.1;
      baseDistribution.evening -= 0.2;
    }

    const reviewsToDistribute = Math.min(totalDue, maxReviews);
    
    return {
      morning: Math.round(reviewsToDistribute * baseDistribution.morning),
      afternoon: Math.round(reviewsToDistribute * baseDistribution.afternoon),
      evening: Math.round(reviewsToDistribute * baseDistribution.evening),
    };
  }

  /**
   * Get learning steps for new or failed cards
   */
  getLearningSteps(): LearningStep[] {
    return [
      { stepNumber: 1, interval: 1, isGraduating: false }, // 1 minute
      { stepNumber: 2, interval: 10, isGraduating: false }, // 10 minutes
      { stepNumber: 3, interval: this.settings.graduatingInterval, isGraduating: true }, // Graduating interval
    ];
  }

  /**
   * Calculate fuzzing factor to distribute reviews
   */
  calculateFuzzedInterval(interval: number): number {
    if (interval < 3) return interval;
    
    // Add randomness to prevent review bunching
    const fuzzRange = Math.max(1, Math.floor(interval * 0.05));
    const fuzz = Math.floor(Math.random() * (fuzzRange * 2 + 1)) - fuzzRange;
    
    return Math.max(1, interval + fuzz);
  }

  /**
   * Update algorithm settings
   */
  updateSettings(newSettings: Partial<SpacedRepetitionSettings>): void {
    this.settings = { ...this.settings, ...newSettings };
  }

  /**
   * Get current algorithm settings
   */
  getSettings(): SpacedRepetitionSettings {
    return { ...this.settings };
  }
}