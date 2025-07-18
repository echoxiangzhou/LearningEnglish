/**
 * Analytics Service
 * 
 * Service for fetching vocabulary learning analytics and progress data
 * from the backend API endpoints.
 */

import {
  ProgressDashboard,
  VocabularyOverview,
  ProgressTimeline,
  MasteryDistribution,
  CategoryPerformance,
  RecentActivity,
  UserAchievements,
  StreakAnalytics,
  PerformanceTrends,
  ProgressReport,
  SessionAnalytics,
  WordProgress,
  LearningRecommendation,
  AnalyticsApiResponse
} from '../types/analytics';

class AnalyticsService {
  private baseUrl: string;
  private authToken: string | null = null;

  constructor(baseUrl: string = '/api/analytics') {
    this.baseUrl = baseUrl;
  }

  /**
   * Set authentication token for API requests
   */
  setAuthToken(token: string): void {
    this.authToken = token;
  }

  /**
   * Get request headers with authentication
   */
  private getHeaders(): Record<string, string> {
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
    };

    if (this.authToken) {
      headers['Authorization'] = `Bearer ${this.authToken}`;
    }

    return headers;
  }

  /**
   * Make authenticated API request
   */
  private async makeRequest<T>(endpoint: string, options?: RequestInit): Promise<T> {
    const url = `${this.baseUrl}${endpoint}`;
    
    const response = await fetch(url, {
      ...options,
      headers: {
        ...this.getHeaders(),
        ...options?.headers,
      },
    });

    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}));
      throw new Error(errorData.error || `HTTP ${response.status}: ${response.statusText}`);
    }

    const data: AnalyticsApiResponse<T> = await response.json();
    
    if (!data.success) {
      throw new Error(data.error || 'API request failed');
    }

    return data.data;
  }

  /**
   * Get comprehensive progress dashboard
   */
  async getProgressDashboard(): Promise<ProgressDashboard> {
    return this.makeRequest<ProgressDashboard>('/dashboard');
  }

  /**
   * Get basic vocabulary overview statistics
   */
  async getVocabularyOverview(): Promise<VocabularyOverview> {
    return this.makeRequest<VocabularyOverview>('/overview');
  }

  /**
   * Get progress timeline for a specific period
   */
  async getProgressTimeline(days: 7 | 14 | 30 | 60 | 90 = 30): Promise<ProgressTimeline> {
    return this.makeRequest<ProgressTimeline>(`/progress-timeline?days=${days}`);
  }

  /**
   * Get mastery level distribution
   */
  async getMasteryDistribution(): Promise<MasteryDistribution> {
    return this.makeRequest<MasteryDistribution>('/mastery-distribution');
  }

  /**
   * Get performance breakdown by vocabulary categories
   */
  async getCategoryPerformance(): Promise<CategoryPerformance[]> {
    return this.makeRequest<CategoryPerformance[]>('/category-performance');
  }

  /**
   * Get recent learning activity
   */
  async getRecentActivity(days: 1 | 3 | 7 | 14 | 30 = 7): Promise<RecentActivity> {
    return this.makeRequest<RecentActivity>(`/recent-activity?days=${days}`);
  }

  /**
   * Get user achievements and progress
   */
  async getUserAchievements(): Promise<UserAchievements> {
    return this.makeRequest<UserAchievements>('/achievements');
  }

  /**
   * Get detailed streak analytics
   */
  async getStreakAnalytics(): Promise<StreakAnalytics> {
    return this.makeRequest<StreakAnalytics>('/streak-analytics');
  }

  /**
   * Get performance trends over time
   */
  async getPerformanceTrends(): Promise<PerformanceTrends> {
    return this.makeRequest<PerformanceTrends>('/performance-trends');
  }

  /**
   * Generate comprehensive progress report
   */
  async generateProgressReport(type: 'weekly' | 'monthly' = 'weekly'): Promise<ProgressReport> {
    return this.makeRequest<ProgressReport>(`/progress-report?type=${type}`);
  }

  /**
   * Get personalized learning recommendations
   */
  async getLearningRecommendations(): Promise<{ recommendations: LearningRecommendation[]; generated_at: string }> {
    return this.makeRequest<{ recommendations: LearningRecommendation[]; generated_at: string }>('/learning-recommendations');
  }

  /**
   * Get analytics for vocabulary sessions
   */
  async getSessionAnalytics(days: number = 30): Promise<SessionAnalytics> {
    return this.makeRequest<SessionAnalytics>(`/session-analytics?days=${days}`);
  }

  /**
   * Get detailed progress for a specific word
   */
  async getWordProgress(wordId: number): Promise<WordProgress> {
    return this.makeRequest<WordProgress>(`/word-progress/${wordId}`);
  }

  /**
   * Export user's vocabulary learning data
   */
  async exportUserData(format: 'json' | 'csv' = 'json'): Promise<any> {
    return this.makeRequest<any>(`/export-data?format=${format}`);
  }

  /**
   * Get analytics data with error handling and retry logic
   */
  async getAnalyticsWithRetry<T>(
    fetchFunction: () => Promise<T>,
    maxRetries: number = 3,
    delay: number = 1000
  ): Promise<T> {
    let lastError: Error;

    for (let attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        return await fetchFunction();
      } catch (error) {
        lastError = error as Error;
        
        if (attempt === maxRetries) {
          throw lastError;
        }

        // Wait before retrying
        await new Promise(resolve => setTimeout(resolve, delay * attempt));
      }
    }

    throw lastError!;
  }

  /**
   * Get cached dashboard data with fallback to API
   */
  async getCachedDashboard(): Promise<ProgressDashboard> {
    const cacheKey = 'vocabulary_dashboard';
    const cacheTimeout = 5 * 60 * 1000; // 5 minutes

    try {
      const cached = localStorage.getItem(cacheKey);
      if (cached) {
        const { data, timestamp } = JSON.parse(cached);
        const age = Date.now() - timestamp;
        
        if (age < cacheTimeout) {
          return data;
        }
      }
    } catch (error) {
      console.warn('Failed to load cached dashboard:', error);
    }

    // Fetch fresh data
    const data = await this.getProgressDashboard();
    
    try {
      localStorage.setItem(cacheKey, JSON.stringify({
        data,
        timestamp: Date.now()
      }));
    } catch (error) {
      console.warn('Failed to cache dashboard data:', error);
    }

    return data;
  }

  /**
   * Clear cached analytics data
   */
  clearCache(): void {
    const cacheKeys = [
      'vocabulary_dashboard',
      'vocabulary_overview',
      'mastery_distribution',
      'streak_analytics'
    ];

    cacheKeys.forEach(key => {
      try {
        localStorage.removeItem(key);
      } catch (error) {
        console.warn(`Failed to clear cache for ${key}:`, error);
      }
    });
  }

  /**
   * Subscribe to real-time analytics updates (if WebSocket available)
   */
  subscribeToUpdates(callback: (data: any) => void): () => void {
    // This would implement WebSocket connection for real-time updates
    // For now, return a no-op unsubscribe function
    return () => {};
  }

  /**
   * Calculate derived analytics metrics
   */
  calculateDerivedMetrics(dashboard: ProgressDashboard) {
    const { overview, mastery_distribution, streak_data } = dashboard;
    
    return {
      learningVelocity: this.calculateLearningVelocity(dashboard),
      masteryProgression: this.calculateMasteryProgression(mastery_distribution),
      consistencyScore: this.calculateConsistencyScore(streak_data),
      improvementTrend: this.calculateImprovementTrend(dashboard),
      nextMilestone: this.calculateNextMilestone(overview, streak_data),
    };
  }

  private calculateLearningVelocity(dashboard: ProgressDashboard): number {
    const { overview, progress_timeline } = dashboard;
    const recentTests = progress_timeline.timeline
      .slice(-7)
      .reduce((sum, day) => sum + day.test_count, 0);
    
    return recentTests / 7; // Average tests per day
  }

  private calculateMasteryProgression(distribution: MasteryDistribution): number {
    const weights = { new: 0, learning: 25, familiar: 50, proficient: 75, mastered: 100 };
    const totalWords = distribution.total_words;
    
    if (totalWords === 0) return 0;
    
    let weightedSum = 0;
    Object.entries(distribution.distribution).forEach(([level, count]) => {
      weightedSum += (weights[level as keyof typeof weights] || 0) * count;
    });
    
    return Math.round(weightedSum / totalWords);
  }

  private calculateConsistencyScore(streakData: StreakAnalytics): number {
    const activeDays = streakData.streak_history.filter(day => day.has_activity).length;
    const totalDays = streakData.streak_history.length;
    
    return Math.round((activeDays / totalDays) * 100);
  }

  private calculateImprovementTrend(dashboard: ProgressDashboard): 'improving' | 'stable' | 'declining' {
    const trends = dashboard.performance_trends.improvement_indicators;
    
    if (trends.accuracy_trend) {
      if (trends.accuracy_trend.change_percentage > 5) return 'improving';
      if (trends.accuracy_trend.change_percentage < -5) return 'declining';
    }
    
    return 'stable';
  }

  private calculateNextMilestone(overview: VocabularyOverview, streakData: StreakAnalytics): {
    type: string;
    target: number;
    current: number;
    description: string;
  } {
    const streakMilestones = [7, 14, 30, 60, 100];
    const masteryMilestones = [10, 25, 50, 100, 250];
    
    // Find next streak milestone
    const nextStreakMilestone = streakMilestones.find(m => m > streakData.current_streak);
    
    // Find next mastery milestone
    const nextMasteryMilestone = masteryMilestones.find(m => m > overview.mastered_words);
    
    // Return the closer milestone
    if (nextStreakMilestone && nextMasteryMilestone) {
      const streakDays = nextStreakMilestone - streakData.current_streak;
      const masteryWords = nextMasteryMilestone - overview.mastered_words;
      
      if (streakDays <= masteryWords) {
        return {
          type: 'streak',
          target: nextStreakMilestone,
          current: streakData.current_streak,
          description: `Reach ${nextStreakMilestone} day learning streak`
        };
      } else {
        return {
          type: 'mastery',
          target: nextMasteryMilestone,
          current: overview.mastered_words,
          description: `Master ${nextMasteryMilestone} words`
        };
      }
    }
    
    if (nextStreakMilestone) {
      return {
        type: 'streak',
        target: nextStreakMilestone,
        current: streakData.current_streak,
        description: `Reach ${nextStreakMilestone} day learning streak`
      };
    }
    
    if (nextMasteryMilestone) {
      return {
        type: 'mastery',
        target: nextMasteryMilestone,
        current: overview.mastered_words,
        description: `Master ${nextMasteryMilestone} words`
      };
    }
    
    return {
      type: 'continue',
      target: 0,
      current: 0,
      description: 'Keep up the great work!'
    };
  }
}

// Export singleton instance
export const analyticsService = new AnalyticsService();
export default analyticsService;