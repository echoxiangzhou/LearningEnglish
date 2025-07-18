/**
 * Progress Dashboard Component
 * 
 * Main dashboard component for displaying comprehensive vocabulary learning
 * analytics including progress tracking, achievements, and performance metrics.
 */

import React, { useState, useEffect, useCallback } from 'react';
import {
  ProgressDashboard as ProgressDashboardType,
  DashboardProps,
  LearningRecommendation
} from '../../types/analytics';
import { analyticsService } from '../../services/analyticsService';
import MasteryOverview from './MasteryOverview';
import ProgressTimeline from './ProgressTimeline';
import MasteryDistributionChart from './MasteryDistributionChart';
import CategoryPerformanceList from './CategoryPerformanceList';
import RecentActivityFeed from './RecentActivityFeed';
import AchievementDisplay from './AchievementDisplay';
import StreakCalendar from './StreakCalendar';
import PerformanceTrendsChart from './PerformanceTrendsChart';
import RecommendationCards from './RecommendationCards';
import LoadingSpinner from '../common/LoadingSpinner';
import ErrorMessage from '../common/ErrorMessage';
import './ProgressDashboard.css';

interface ProgressDashboardState {
  dashboard: ProgressDashboardType | null;
  recommendations: LearningRecommendation[];
  loading: boolean;
  error: string | null;
  lastUpdated: Date | null;
}

const ProgressDashboard: React.FC<DashboardProps> = ({
  userId,
  refreshInterval = 300000, // 5 minutes
  onError
}) => {
  const [state, setState] = useState<ProgressDashboardState>({
    dashboard: null,
    recommendations: [],
    loading: true,
    error: null,
    lastUpdated: null
  });

  /**
   * Load dashboard data from API
   */
  const loadDashboardData = useCallback(async () => {
    try {
      setState(prev => ({ ...prev, loading: true, error: null }));

      // Load dashboard and recommendations in parallel
      const [dashboardData, recommendationsData] = await Promise.all([
        analyticsService.getCachedDashboard(),
        analyticsService.getLearningRecommendations()
      ]);

      setState(prev => ({
        ...prev,
        dashboard: dashboardData,
        recommendations: recommendationsData.recommendations,
        loading: false,
        lastUpdated: new Date()
      }));

    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Failed to load dashboard';
      setState(prev => ({
        ...prev,
        error: errorMessage,
        loading: false
      }));
      
      onError?.(errorMessage);
    }
  }, [onError]);

  /**
   * Refresh dashboard data
   */
  const refreshDashboard = useCallback(async () => {
    analyticsService.clearCache();
    await loadDashboardData();
  }, [loadDashboardData]);

  /**
   * Initial data load
   */
  useEffect(() => {
    loadDashboardData();
  }, [loadDashboardData]);

  /**
   * Set up automatic refresh
   */
  useEffect(() => {
    if (refreshInterval > 0) {
      const interval = setInterval(loadDashboardData, refreshInterval);
      return () => clearInterval(interval);
    }
  }, [loadDashboardData, refreshInterval]);

  /**
   * Handle recommendation action
   */
  const handleRecommendationAction = useCallback(async (recommendation: LearningRecommendation) => {
    try {
      // Implement specific actions based on recommendation type
      switch (recommendation.type) {
        case 'review':
          // Navigate to review page or start review session
          console.log('Starting review session');
          break;
        case 'streak':
          // Navigate to vocabulary practice
          console.log('Starting vocabulary practice');
          break;
        case 'accuracy':
          // Navigate to specific difficulty level practice
          console.log('Starting accuracy improvement practice');
          break;
        case 'expansion':
          // Navigate to vocabulary browser
          console.log('Opening vocabulary browser');
          break;
        default:
          console.log(`Unknown recommendation type: ${recommendation.type}`);
      }
    } catch (error) {
      console.error('Failed to execute recommendation action:', error);
    }
  }, []);

  if (state.loading && !state.dashboard) {
    return (
      <div className="progress-dashboard">
        <div className="dashboard-header">
          <h1>Learning Progress Dashboard</h1>
        </div>
        <LoadingSpinner message="Loading your progress data..." />
      </div>
    );
  }

  if (state.error && !state.dashboard) {
    return (
      <div className="progress-dashboard">
        <div className="dashboard-header">
          <h1>Learning Progress Dashboard</h1>
        </div>
        <ErrorMessage 
          message={state.error} 
          onRetry={loadDashboardData}
          retryLabel="Reload Dashboard"
        />
      </div>
    );
  }

  if (!state.dashboard) {
    return (
      <div className="progress-dashboard">
        <div className="dashboard-header">
          <h1>Learning Progress Dashboard</h1>
        </div>
        <div className="no-data-message">
          <p>No progress data available. Start learning to see your analytics!</p>
        </div>
      </div>
    );
  }

  const { dashboard, recommendations, loading, lastUpdated } = state;

  return (
    <div className="progress-dashboard">
      {/* Dashboard Header */}
      <div className="dashboard-header">
        <div className="header-content">
          <h1>Learning Progress Dashboard</h1>
          <div className="header-actions">
            <button 
              className="refresh-button"
              onClick={refreshDashboard}
              disabled={loading}
              title="Refresh dashboard data"
            >
              <span className={`refresh-icon ${loading ? 'spinning' : ''}`}>🔄</span>
              Refresh
            </button>
            {lastUpdated && (
              <span className="last-updated">
                Last updated: {lastUpdated.toLocaleTimeString()}
              </span>
            )}
          </div>
        </div>
      </div>

      {/* Main Dashboard Content */}
      <div className="dashboard-content">
        {/* Overview Section */}
        <section className="dashboard-section overview-section">
          <MasteryOverview overview={dashboard.overview} />
        </section>

        {/* Recommendations Section */}
        {recommendations.length > 0 && (
          <section className="dashboard-section recommendations-section">
            <h2>Recommended Actions</h2>
            <RecommendationCards 
              recommendations={recommendations}
              onActionClick={handleRecommendationAction}
            />
          </section>
        )}

        {/* Progress Charts Section */}
        <section className="dashboard-section charts-section">
          <div className="charts-grid">
            <div className="chart-container">
              <h3>Progress Timeline</h3>
              <ProgressTimeline timelineData={dashboard.progress_timeline} />
            </div>
            
            <div className="chart-container">
              <h3>Mastery Distribution</h3>
              <MasteryDistributionChart distribution={dashboard.mastery_distribution} />
            </div>
          </div>
        </section>

        {/* Streak and Performance Section */}
        <section className="dashboard-section performance-section">
          <div className="performance-grid">
            <div className="streak-container">
              <h3>Learning Streak</h3>
              <StreakCalendar 
                streakData={dashboard.streak_data}
                onDayClick={(date) => console.log('Day clicked:', date)}
              />
            </div>
            
            <div className="trends-container">
              <h3>Performance Trends</h3>
              <PerformanceTrendsChart trends={dashboard.performance_trends} />
            </div>
          </div>
        </section>

        {/* Category Performance Section */}
        <section className="dashboard-section categories-section">
          <h3>Category Performance</h3>
          <CategoryPerformanceList categories={dashboard.category_performance} />
        </section>

        {/* Achievements Section */}
        <section className="dashboard-section achievements-section">
          <h3>Achievements</h3>
          <AchievementDisplay achievements={dashboard.achievements} />
        </section>

        {/* Recent Activity Section */}
        <section className="dashboard-section activity-section">
          <h3>Recent Activity</h3>
          <RecentActivityFeed activity={dashboard.recent_activity} />
        </section>
      </div>

      {/* Loading Overlay */}
      {loading && dashboard && (
        <div className="loading-overlay">
          <LoadingSpinner message="Updating dashboard..." />
        </div>
      )}
    </div>
  );
};

export default ProgressDashboard;