/**
 * Reading Analytics Service
 * 
 * Service for fetching reading comprehension analytics and progress data
 * from the backend API endpoints.
 */

export interface ReadingOverview {
  total_sessions: number;
  total_articles_read: number;
  total_reading_time: number;
  average_comprehension_score: number;
  average_completion_percentage: number;
  reading_streak: number;
  words_read: number;
  average_reading_speed: number;
}

export interface DailyReadingData {
  date: string;
  sessions: number;
  total_time: number;
  average_score: number;
}

export interface DifficultyBreakdown {
  difficulty: number;
  sessions: number;
  average_score: number;
  average_completion: number;
}

export interface ReadingAchievement {
  id: string;
  title: string;
  description: string;
  icon: string;
  earned_at: string;
}

export interface ReadingAnalyticsOverview {
  overview: ReadingOverview;
  daily_reading: DailyReadingData[];
  difficulty_breakdown: DifficultyBreakdown[];
  achievements: ReadingAchievement[];
  period_days: number;
  generated_at: string;
}

export interface TimelineData {
  date: string;
  reading_time: number;
  sessions: number;
  completed_sessions: number;
  average_comprehension: number;
  articles_read: number;
}

export interface ReadingProgressTimeline {
  timeline: TimelineData[];
  period_days: number;
  generated_at: string;
}

export interface ReadingRecommendation {
  type: 'consistency' | 'comprehension' | 'challenge' | 'speed';
  priority: 'high' | 'medium' | 'low';
  title: string;
  description: string;
  action: string;
  icon: string;
}

export interface ReadingRecommendations {
  recommendations: ReadingRecommendation[];
  user_stats: ReadingOverview;
  generated_at: string;
}

class ReadingAnalyticsService {
  private baseUrl: string;
  private authToken: string | null = null;

  constructor(baseUrl: string = '/api/reading/analytics') {
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

    const data = await response.json();
    return data;
  }

  /**
   * Get comprehensive reading analytics overview
   */
  async getReadingOverview(days: number = 30): Promise<ReadingAnalyticsOverview> {
    return this.makeRequest<ReadingAnalyticsOverview>(`/overview?days=${days}`);
  }

  /**
   * Get reading progress timeline
   */
  async getProgressTimeline(days: number = 30): Promise<ReadingProgressTimeline> {
    return this.makeRequest<ReadingProgressTimeline>(`/progress?days=${days}`);
  }

  /**
   * Get personalized reading recommendations
   */
  async getRecommendations(): Promise<ReadingRecommendations> {
    return this.makeRequest<ReadingRecommendations>('/recommendations');
  }

  /**
   * Get reading analytics with error handling and retry logic
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
   * Get cached reading data with fallback to API
   */
  async getCachedOverview(days: number = 30): Promise<ReadingAnalyticsOverview> {
    const cacheKey = `reading_overview_${days}`;
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
      console.warn('Failed to load cached reading data:', error);
    }

    // Fetch fresh data
    const data = await this.getReadingOverview(days);
    
    try {
      localStorage.setItem(cacheKey, JSON.stringify({
        data,
        timestamp: Date.now()
      }));
    } catch (error) {
      console.warn('Failed to cache reading data:', error);
    }

    return data;
  }

  /**
   * Clear cached reading analytics data
   */
  clearCache(): void {
    const cacheKeys = [
      'reading_overview_30',
      'reading_overview_7',
      'reading_overview_90',
      'reading_progress_30',
      'reading_recommendations'
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
   * Calculate reading performance metrics
   */
  calculatePerformanceMetrics(overview: ReadingOverview) {
    return {
      readingEfficiency: this.calculateReadingEfficiency(overview),
      comprehensionLevel: this.getComprehensionLevel(overview.average_comprehension_score),
      readingSpeedCategory: this.getReadingSpeedCategory(overview.average_reading_speed),
      consistencyScore: this.calculateConsistencyScore(overview.reading_streak),
      improvementAreas: this.identifyImprovementAreas(overview),
    };
  }

  private calculateReadingEfficiency(overview: ReadingOverview): number {
    if (overview.total_reading_time === 0) return 0;
    
    // Words per minute efficiency
    const wordsPerMinute = overview.words_read / (overview.total_reading_time / 60);
    const comprehensionFactor = overview.average_comprehension_score / 100;
    
    return Math.round(wordsPerMinute * comprehensionFactor);
  }

  private getComprehensionLevel(score: number): string {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Good';
    if (score >= 70) return 'Fair';
    if (score >= 60) return 'Needs Improvement';
    return 'Struggling';
  }

  private getReadingSpeedCategory(wpm: number): string {
    if (wpm >= 300) return 'Very Fast';
    if (wpm >= 250) return 'Fast';
    if (wpm >= 200) return 'Average';
    if (wpm >= 150) return 'Slow';
    return 'Very Slow';
  }

  private calculateConsistencyScore(streak: number): number {
    // Convert streak to a 0-100 score
    return Math.min(100, Math.round((streak / 30) * 100));
  }

  private identifyImprovementAreas(overview: ReadingOverview): string[] {
    const areas: string[] = [];
    
    if (overview.average_comprehension_score < 70) {
      areas.push('Comprehension');
    }
    
    if (overview.average_reading_speed < 200) {
      areas.push('Reading Speed');
    }
    
    if (overview.reading_streak < 7) {
      areas.push('Consistency');
    }
    
    if (overview.average_completion_percentage < 80) {
      areas.push('Article Completion');
    }
    
    return areas;
  }

  /**
   * Format reading statistics for display
   */
  formatStats(overview: ReadingOverview) {
    return {
      totalTimeFormatted: this.formatReadingTime(overview.total_reading_time),
      averageSpeedFormatted: `${Math.round(overview.average_reading_speed)} WPM`,
      comprehensionFormatted: `${Math.round(overview.average_comprehension_score)}%`,
      completionFormatted: `${Math.round(overview.average_completion_percentage)}%`,
      streakFormatted: `${overview.reading_streak} day${overview.reading_streak !== 1 ? 's' : ''}`,
      wordsReadFormatted: this.formatNumber(overview.words_read)
    };
  }

  private formatReadingTime(seconds: number): string {
    if (seconds < 60) return `${seconds}s`;
    if (seconds < 3600) return `${Math.round(seconds / 60)}m`;
    
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.round((seconds % 3600) / 60);
    return `${hours}h ${minutes}m`;
  }

  private formatNumber(num: number): string {
    if (num >= 1000000) return `${(num / 1000000).toFixed(1)}M`;
    if (num >= 1000) return `${(num / 1000).toFixed(1)}K`;
    return num.toString();
  }
}

// Export singleton instance
export const readingAnalyticsService = new ReadingAnalyticsService();
export default readingAnalyticsService;