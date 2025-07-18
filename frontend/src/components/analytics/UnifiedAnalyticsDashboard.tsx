/**
 * Unified Analytics Dashboard Component
 * 
 * Comprehensive dashboard that displays analytics across all learning modules
 * (dictation, vocabulary, reading) with real-time updates, achievements,
 * and personalized recommendations.
 */

import React, { useState, useEffect, useCallback } from 'react';
import { 
  Chart as ChartJS, 
  CategoryScale, 
  LinearScale, 
  PointElement, 
  LineElement, 
  BarElement,
  Title, 
  Tooltip, 
  Legend,
  ArcElement,
  Filler
} from 'chart.js';
import { Line, Bar, Doughnut } from 'react-chartjs-2';
import './UnifiedAnalyticsDashboard.css';

// Register Chart.js components
ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  Filler
);

interface AnalyticsOverview {
  total_sessions: number;
  total_time_hours: number;
  average_accuracy: number;
  current_streak: number;
  longest_streak: number;
  recent_sessions: number;
  total_achievements: number;
  last_activity: string | null;
}

interface ModulePerformance {
  [key: string]: {
    session_count: number;
    average_accuracy: number;
    total_time_minutes: number;
    average_session_time: number;
  };
}

interface TimelineData {
  date: string;
  total_sessions: number;
  total_time_minutes: number;
  overall_accuracy: number;
  modules: {
    [key: string]: {
      sessions: number;
      accuracy: number;
      time_minutes: number;
    };
  };
}

interface Achievement {
  id: number;
  achievement_type: string;
  badge_name: string;
  badge_description: string;
  badge_icon: string;
  unlocked_at: string;
  points_awarded: number;
  tier: string;
}

interface Recommendation {
  id: number;
  recommendation_type: string;
  title: string;
  description: string;
  action_url: string;
  priority: string;
  estimated_time_minutes: number;
  module_type?: string;
}

interface ErrorAnalysis {
  error_breakdown: {
    [module: string]: {
      [error_type: string]: {
        unique_errors: number;
        total_frequency: number;
      };
    };
  };
  systematic_errors: Array<{
    id: number;
    error_type: string;
    word_or_concept: string;
    frequency: number;
    module_type: string;
  }>;
  needs_attention: number;
}

interface UnifiedDashboardData {
  overview: AnalyticsOverview;
  module_performance: ModulePerformance;
  progress_timeline: TimelineData[];
  achievements: {
    total_achievements: number;
    recent_achievements: Achievement[];
    by_type: { [key: string]: Achievement[] };
    total_points: number;
  };
  recommendations: Recommendation[];
  error_analysis: ErrorAnalysis;
  streak_data: {
    current_streak: number;
    longest_streak: number;
    activity_calendar: Array<{
      date: string;
      sessions: number;
      has_activity: boolean;
    }>;
    last_activity_date: string | null;
  };
  performance_trends: {
    weekly_data: Array<{
      week_start: string;
      sessions: number;
      accuracy: number;
      time_hours: number;
    }>;
    accuracy_trend: number;
    trend_direction: string;
  };
  generated_at: string;
}

interface UnifiedAnalyticsDashboardProps {
  userId?: number;
  refreshInterval?: number;
  onError?: (error: string) => void;
}

const UnifiedAnalyticsDashboard: React.FC<UnifiedAnalyticsDashboardProps> = ({
  userId,
  refreshInterval = 300000, // 5 minutes
  onError
}) => {
  const [dashboardData, setDashboardData] = useState<UnifiedDashboardData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [lastUpdated, setLastUpdated] = useState<Date | null>(null);
  const [selectedTimeframe, setSelectedTimeframe] = useState<'7d' | '30d' | '90d'>('30d');

  /**
   * Load dashboard data from API
   */
  const loadDashboardData = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const response = await fetch('/api/unified-analytics/dashboard', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const result = await response.json();
      
      if (result.success) {
        setDashboardData(result.data);
        setLastUpdated(new Date());
      } else {
        throw new Error(result.error || 'Failed to load dashboard data');
      }
    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Failed to load dashboard';
      setError(errorMessage);
      onError?.(errorMessage);
    } finally {
      setLoading(false);
    }
  }, [onError]);

  /**
   * Handle recommendation action
   */
  const handleRecommendationClick = useCallback(async (recommendation: Recommendation) => {
    try {
      // Track the click
      await fetch(`/api/unified-analytics/recommendations/${recommendation.id}/click`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
      });

      // Navigate to the recommendation URL
      if (recommendation.action_url) {
        window.location.href = recommendation.action_url;
      }
    } catch (error) {
      console.error('Failed to track recommendation click:', error);
    }
  }, []);

  /**
   * Clear analytics cache
   */
  const clearCache = useCallback(async () => {
    try {
      await fetch('/api/unified-analytics/cache/clear', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
      });
      
      // Reload data
      loadDashboardData();
    } catch (error) {
      console.error('Failed to clear cache:', error);
    }
  }, [loadDashboardData]);

  /**
   * Initial data load
   */
  useEffect(() => {
    loadDashboardData();
  }, [loadDashboardData]);

  /**
   * Auto-refresh setup
   */
  useEffect(() => {
    if (refreshInterval > 0) {
      const interval = setInterval(loadDashboardData, refreshInterval);
      return () => clearInterval(interval);
    }
  }, [loadDashboardData, refreshInterval]);

  /**
   * Render loading state
   */
  if (loading && !dashboardData) {
    return (
      <div className="unified-analytics-dashboard">
        <div className="dashboard-header">
          <h1>Learning Analytics Dashboard</h1>
        </div>
        <div className="loading-container">
          <div className="loading-spinner"></div>
          <p>Loading your learning analytics...</p>
        </div>
      </div>
    );
  }

  /**
   * Render error state
   */
  if (error && !dashboardData) {
    return (
      <div className="unified-analytics-dashboard">
        <div className="dashboard-header">
          <h1>Learning Analytics Dashboard</h1>
        </div>
        <div className="error-container">
          <div className="error-message">
            <h3>Unable to load dashboard</h3>
            <p>{error}</p>
            <button onClick={loadDashboardData} className="retry-button">
              Try Again
            </button>
          </div>
        </div>
      </div>
    );
  }

  if (!dashboardData) {
    return (
      <div className="unified-analytics-dashboard">
        <div className="dashboard-header">
          <h1>Learning Analytics Dashboard</h1>
        </div>
        <div className="no-data-container">
          <p>No analytics data available. Start learning to see your progress!</p>
        </div>
      </div>
    );
  }

  // Prepare chart data
  const timelineChartData = {
    labels: dashboardData.progress_timeline.map(item => 
      new Date(item.date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
    ),
    datasets: [
      {
        label: 'Sessions',
        data: dashboardData.progress_timeline.map(item => item.total_sessions),
        borderColor: 'rgb(59, 130, 246)',
        backgroundColor: 'rgba(59, 130, 246, 0.1)',
        fill: true,
        yAxisID: 'y'
      },
      {
        label: 'Accuracy %',
        data: dashboardData.progress_timeline.map(item => item.overall_accuracy),
        borderColor: 'rgb(16, 185, 129)',
        backgroundColor: 'rgba(16, 185, 129, 0.1)',
        fill: false,
        yAxisID: 'y1'
      }
    ]
  };

  const modulePerformanceData = {
    labels: Object.keys(dashboardData.module_performance),
    datasets: [
      {
        label: 'Average Accuracy',
        data: Object.values(dashboardData.module_performance).map(module => module.average_accuracy),
        backgroundColor: ['rgba(59, 130, 246, 0.6)', 'rgba(16, 185, 129, 0.6)', 'rgba(245, 158, 11, 0.6)'],
        borderColor: ['rgb(59, 130, 246)', 'rgb(16, 185, 129)', 'rgb(245, 158, 11)'],
        borderWidth: 1
      }
    ]
  };

  const achievementsByType = dashboardData.achievements.by_type;
  const achievementTypeData = {
    labels: Object.keys(achievementsByType),
    datasets: [
      {
        data: Object.values(achievementsByType).map(achievements => achievements.length),
        backgroundColor: [
          'rgba(239, 68, 68, 0.6)',
          'rgba(59, 130, 246, 0.6)',
          'rgba(16, 185, 129, 0.6)',
          'rgba(245, 158, 11, 0.6)',
          'rgba(139, 92, 246, 0.6)',
          'rgba(236, 72, 153, 0.6)'
        ],
        borderWidth: 1
      }
    ]
  };

  return (
    <div className="unified-analytics-dashboard">
      {/* Dashboard Header */}
      <div className="dashboard-header">
        <div className="header-content">
          <h1>Learning Analytics Dashboard</h1>
          <div className="header-actions">
            <button 
              className="refresh-button"
              onClick={loadDashboardData}
              disabled={loading}
              title="Refresh dashboard"
            >
              <span className={`refresh-icon ${loading ? 'spinning' : ''}`}>🔄</span>
              Refresh
            </button>
            <button 
              className="cache-clear-button"
              onClick={clearCache}
              title="Clear cache and reload"
            >
              🗑️ Clear Cache
            </button>
            {lastUpdated && (
              <span className="last-updated">
                Updated: {lastUpdated.toLocaleTimeString()}
              </span>
            )}
          </div>
        </div>
      </div>

      {/* Overview Cards */}
      <div className="overview-section">
        <div className="overview-cards">
          <div className="overview-card">
            <div className="card-icon">📚</div>
            <div className="card-content">
              <h3>Total Sessions</h3>
              <div className="card-value">{dashboardData.overview.total_sessions}</div>
              <div className="card-subtitle">
                {dashboardData.overview.recent_sessions} this week
              </div>
            </div>
          </div>

          <div className="overview-card">
            <div className="card-icon">⏱️</div>
            <div className="card-content">
              <h3>Time Studied</h3>
              <div className="card-value">{dashboardData.overview.total_time_hours}h</div>
              <div className="card-subtitle">Total learning time</div>
            </div>
          </div>

          <div className="overview-card">
            <div className="card-icon">🎯</div>
            <div className="card-content">
              <h3>Average Accuracy</h3>
              <div className="card-value">{dashboardData.overview.average_accuracy}%</div>
              <div className="card-subtitle">Across all modules</div>
            </div>
          </div>

          <div className="overview-card">
            <div className="card-icon">🔥</div>
            <div className="card-content">
              <h3>Current Streak</h3>
              <div className="card-value">{dashboardData.overview.current_streak}</div>
              <div className="card-subtitle">
                Best: {dashboardData.overview.longest_streak} days
              </div>
            </div>
          </div>

          <div className="overview-card">
            <div className="card-icon">🏆</div>
            <div className="card-content">
              <h3>Achievements</h3>
              <div className="card-value">{dashboardData.achievements.total_achievements}</div>
              <div className="card-subtitle">
                {dashboardData.achievements.total_points} points earned
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Recommendations */}
      {dashboardData.recommendations.length > 0 && (
        <div className="recommendations-section">
          <h2>Recommended for You</h2>
          <div className="recommendations-grid">
            {dashboardData.recommendations.map(recommendation => (
              <div 
                key={recommendation.id} 
                className={`recommendation-card priority-${recommendation.priority}`}
                onClick={() => handleRecommendationClick(recommendation)}
              >
                <div className="recommendation-header">
                  <h4>{recommendation.title}</h4>
                  <span className={`priority-badge ${recommendation.priority}`}>
                    {recommendation.priority}
                  </span>
                </div>
                <p>{recommendation.description}</p>
                <div className="recommendation-footer">
                  {recommendation.module_type && (
                    <span className="module-tag">{recommendation.module_type}</span>
                  )}
                  <span className="time-estimate">
                    ~{recommendation.estimated_time_minutes} min
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Charts Section */}
      <div className="charts-section">
        <div className="charts-grid">
          {/* Progress Timeline */}
          <div className="chart-container large">
            <h3>Progress Timeline</h3>
            <div className="chart-wrapper">
              <Line 
                data={timelineChartData}
                options={{
                  responsive: true,
                  interaction: {
                    mode: 'index' as const,
                    intersect: false,
                  },
                  scales: {
                    x: {
                      display: true,
                      title: {
                        display: true,
                        text: 'Date'
                      }
                    },
                    y: {
                      type: 'linear' as const,
                      display: true,
                      position: 'left' as const,
                      title: {
                        display: true,
                        text: 'Sessions'
                      }
                    },
                    y1: {
                      type: 'linear' as const,
                      display: true,
                      position: 'right' as const,
                      title: {
                        display: true,
                        text: 'Accuracy %'
                      },
                      grid: {
                        drawOnChartArea: false,
                      },
                    },
                  },
                }}
              />
            </div>
          </div>

          {/* Module Performance */}
          <div className="chart-container">
            <h3>Module Performance</h3>
            <div className="chart-wrapper">
              <Bar 
                data={modulePerformanceData}
                options={{
                  responsive: true,
                  plugins: {
                    legend: {
                      display: false
                    }
                  },
                  scales: {
                    y: {
                      beginAtZero: true,
                      max: 100,
                      title: {
                        display: true,
                        text: 'Accuracy %'
                      }
                    }
                  }
                }}
              />
            </div>
          </div>

          {/* Achievement Distribution */}
          <div className="chart-container">
            <h3>Achievements by Type</h3>
            <div className="chart-wrapper">
              <Doughnut 
                data={achievementTypeData}
                options={{
                  responsive: true,
                  plugins: {
                    legend: {
                      position: 'bottom' as const
                    }
                  }
                }}
              />
            </div>
          </div>
        </div>
      </div>

      {/* Recent Achievements */}
      {dashboardData.achievements.recent_achievements.length > 0 && (
        <div className="recent-achievements-section">
          <h2>Recent Achievements</h2>
          <div className="achievements-grid">
            {dashboardData.achievements.recent_achievements.map(achievement => (
              <div key={achievement.id} className={`achievement-card tier-${achievement.tier}`}>
                <div className="achievement-icon">{achievement.badge_icon}</div>
                <div className="achievement-content">
                  <h4>{achievement.badge_name}</h4>
                  <p>{achievement.badge_description}</p>
                  <div className="achievement-meta">
                    <span className="points">+{achievement.points_awarded} pts</span>
                    <span className="date">
                      {new Date(achievement.unlocked_at).toLocaleDateString()}
                    </span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Error Analysis */}
      {dashboardData.error_analysis.needs_attention > 0 && (
        <div className="error-analysis-section">
          <h2>Learning Areas for Improvement</h2>
          {dashboardData.error_analysis.systematic_errors.length > 0 && (
            <div className="systematic-errors">
              <h3>Patterns Requiring Attention</h3>
              <div className="errors-list">
                {dashboardData.error_analysis.systematic_errors.map(error => (
                  <div key={error.id} className="error-item">
                    <div className="error-content">
                      <strong>{error.word_or_concept}</strong>
                      <span className="error-type">{error.error_type}</span>
                      <span className="error-frequency">{error.frequency} times</span>
                    </div>
                    <div className="error-module">
                      {error.module_type}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}
        </div>
      )}

      {/* Performance Trends */}
      <div className="trends-section">
        <h2>Performance Trends</h2>
        <div className="trend-indicator">
          <span className={`trend-direction ${dashboardData.performance_trends.trend_direction}`}>
            {dashboardData.performance_trends.trend_direction === 'improving' ? '📈' : 
             dashboardData.performance_trends.trend_direction === 'declining' ? '📉' : '➡️'}
            {dashboardData.performance_trends.trend_direction} 
            ({dashboardData.performance_trends.accuracy_trend > 0 ? '+' : ''}{dashboardData.performance_trends.accuracy_trend}%)
          </span>
        </div>
      </div>

      {/* Loading Overlay */}
      {loading && dashboardData && (
        <div className="loading-overlay">
          <div className="loading-spinner"></div>
          <p>Updating dashboard...</p>
        </div>
      )}
    </div>
  );
};

export default UnifiedAnalyticsDashboard;