/**
 * Reading Progress Dashboard Component
 * 
 * Displays comprehensive reading analytics including reading speed,
 * comprehension scores, streak tracking, and performance trends.
 */

import React, { useState, useEffect, useCallback } from 'react';
import {
  ReadingAnalyticsOverview,
  ReadingProgressTimeline,
  ReadingRecommendations,
  readingAnalyticsService
} from '../../services/readingAnalyticsService';
import './ReadingProgressDashboard.css';

interface ReadingProgressDashboardProps {
  userId?: number;
  onError?: (error: string) => void;
}

interface DashboardState {
  overview: ReadingAnalyticsOverview | null;
  timeline: ReadingProgressTimeline | null;
  recommendations: ReadingRecommendations | null;
  loading: boolean;
  error: string | null;
  selectedPeriod: number;
  lastUpdated: Date | null;
}

const ReadingProgressDashboard: React.FC<ReadingProgressDashboardProps> = ({
  userId,
  onError
}) => {
  const [state, setState] = useState<DashboardState>({
    overview: null,
    timeline: null,
    recommendations: null,
    loading: true,
    error: null,
    selectedPeriod: 30,
    lastUpdated: null
  });

  /**
   * Load all dashboard data
   */
  const loadDashboardData = useCallback(async () => {
    try {
      setState(prev => ({ ...prev, loading: true, error: null }));

      // Load all analytics data in parallel
      const [overviewData, timelineData, recommendationsData] = await Promise.all([
        readingAnalyticsService.getCachedOverview(state.selectedPeriod),
        readingAnalyticsService.getProgressTimeline(state.selectedPeriod),
        readingAnalyticsService.getRecommendations()
      ]);

      setState(prev => ({
        ...prev,
        overview: overviewData,
        timeline: timelineData,
        recommendations: recommendationsData,
        loading: false,
        lastUpdated: new Date()
      }));

    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : 'Failed to load reading analytics';
      setState(prev => ({
        ...prev,
        error: errorMessage,
        loading: false
      }));
      
      onError?.(errorMessage);
    }
  }, [state.selectedPeriod, onError]);

  /**
   * Refresh dashboard data
   */
  const refreshDashboard = useCallback(async () => {
    readingAnalyticsService.clearCache();
    await loadDashboardData();
  }, [loadDashboardData]);

  /**
   * Handle period change
   */
  const handlePeriodChange = useCallback((newPeriod: number) => {
    setState(prev => ({ ...prev, selectedPeriod: newPeriod }));
  }, []);

  /**
   * Initial data load
   */
  useEffect(() => {
    loadDashboardData();
  }, [loadDashboardData]);

  /**
   * Reload when period changes
   */
  useEffect(() => {
    if (state.selectedPeriod) {
      loadDashboardData();
    }
  }, [state.selectedPeriod, loadDashboardData]);

  if (state.loading && !state.overview) {
    return (
      <div className="reading-progress-dashboard">
        <div className="dashboard-header">
          <h1>Reading Progress Dashboard</h1>
        </div>
        <div className="loading-spinner">
          <div className="spinner"></div>
          <p>Loading your reading analytics...</p>
        </div>
      </div>
    );
  }

  if (state.error && !state.overview) {
    return (
      <div className="reading-progress-dashboard">
        <div className="dashboard-header">
          <h1>Reading Progress Dashboard</h1>
        </div>
        <div className="error-message">
          <p>Failed to load reading analytics: {state.error}</p>
          <button onClick={loadDashboardData} className="retry-button">
            Retry
          </button>
        </div>
      </div>
    );
  }

  if (!state.overview) {
    return (
      <div className="reading-progress-dashboard">
        <div className="dashboard-header">
          <h1>Reading Progress Dashboard</h1>
        </div>
        <div className="no-data-message">
          <p>No reading data available. Start reading articles to see your progress!</p>
        </div>
      </div>
    );
  }

  const { overview, timeline, recommendations, loading, selectedPeriod, lastUpdated } = state;
  const stats = readingAnalyticsService.formatStats(overview.overview);
  const metrics = readingAnalyticsService.calculatePerformanceMetrics(overview.overview);

  return (
    <div className="reading-progress-dashboard">
      {/* Dashboard Header */}
      <div className="dashboard-header">
        <div className="header-content">
          <h1>Reading Progress Dashboard</h1>
          <div className="header-controls">
            <div className="period-selector">
              <label>Time Period:</label>
              <select 
                value={selectedPeriod} 
                onChange={(e) => handlePeriodChange(Number(e.target.value))}
                disabled={loading}
              >
                <option value={7}>Last 7 Days</option>
                <option value={30}>Last 30 Days</option>
                <option value={90}>Last 90 Days</option>
              </select>
            </div>
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
                Updated: {lastUpdated.toLocaleTimeString()}
              </span>
            )}
          </div>
        </div>
      </div>

      <div className="dashboard-content">
        {/* Key Metrics Overview */}
        <section className="metrics-overview">
          <div className="metrics-grid">
            <div className="metric-card">
              <div className="metric-icon">📚</div>
              <div className="metric-info">
                <h3>Articles Read</h3>
                <p className="metric-value">{overview.overview.total_articles_read}</p>
                <span className="metric-label">in {selectedPeriod} days</span>
              </div>
            </div>

            <div className="metric-card">
              <div className="metric-icon">⏱️</div>
              <div className="metric-info">
                <h3>Reading Time</h3>
                <p className="metric-value">{stats.totalTimeFormatted}</p>
                <span className="metric-label">total time spent</span>
              </div>
            </div>

            <div className="metric-card">
              <div className="metric-icon">🎯</div>
              <div className="metric-info">
                <h3>Comprehension</h3>
                <p className="metric-value">{stats.comprehensionFormatted}</p>
                <span className="metric-label">{metrics.comprehensionLevel}</span>
              </div>
            </div>

            <div className="metric-card">
              <div className="metric-icon">⚡</div>
              <div className="metric-info">
                <h3>Reading Speed</h3>
                <p className="metric-value">{stats.averageSpeedFormatted}</p>
                <span className="metric-label">{metrics.readingSpeedCategory}</span>
              </div>
            </div>

            <div className="metric-card">
              <div className="metric-icon">🔥</div>
              <div className="metric-info">
                <h3>Streak</h3>
                <p className="metric-value">{overview.overview.reading_streak}</p>
                <span className="metric-label">consecutive days</span>
              </div>
            </div>

            <div className="metric-card">
              <div className="metric-icon">📊</div>
              <div className="metric-info">
                <h3>Efficiency</h3>
                <p className="metric-value">{metrics.readingEfficiency}</p>
                <span className="metric-label">effective WPM</span>
              </div>
            </div>
          </div>
        </section>

        {/* Recommendations */}
        {recommendations && recommendations.recommendations.length > 0 && (
          <section className="recommendations-section">
            <h2>Personalized Recommendations</h2>
            <div className="recommendations-grid">
              {recommendations.recommendations.map((rec, index) => (
                <div key={index} className={`recommendation-card priority-${rec.priority}`}>
                  <div className="rec-icon">{rec.icon}</div>
                  <div className="rec-content">
                    <h4>{rec.title}</h4>
                    <p>{rec.description}</p>
                    <button className="rec-action-btn">{rec.action}</button>
                  </div>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* Reading Timeline Chart */}
        {timeline && (
          <section className="timeline-section">
            <h2>Reading Activity Timeline</h2>
            <div className="timeline-chart">
              <div className="chart-header">
                <div className="chart-legend">
                  <span className="legend-item">
                    <span className="legend-color reading-time"></span>
                    Reading Time (minutes)
                  </span>
                  <span className="legend-item">
                    <span className="legend-color comprehension"></span>
                    Comprehension Score (%)
                  </span>
                </div>
              </div>
              <div className="chart-container">
                {timeline.timeline.map((day, index) => {
                  const maxTime = Math.max(...timeline.timeline.map(d => d.reading_time));
                  const timeHeight = maxTime > 0 ? (day.reading_time / maxTime) * 100 : 0;
                  const comprehensionHeight = day.average_comprehension;
                  
                  return (
                    <div key={index} className="chart-day" title={`${day.date}: ${Math.round(day.reading_time / 60)}min, ${day.average_comprehension}% comprehension`}>
                      <div className="chart-bars">
                        <div 
                          className="time-bar" 
                          style={{ height: `${timeHeight}%` }}
                        ></div>
                        <div 
                          className="comprehension-bar" 
                          style={{ height: `${comprehensionHeight}%` }}
                        ></div>
                      </div>
                      <div className="day-label">
                        {new Date(day.date).toLocaleDateString('en-US', { 
                          month: 'short', 
                          day: 'numeric' 
                        })}
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          </section>
        )}

        {/* Difficulty Breakdown */}
        <section className="difficulty-section">
          <h2>Performance by Difficulty Level</h2>
          <div className="difficulty-grid">
            {overview.difficulty_breakdown.map((diff, index) => (
              <div key={index} className="difficulty-card">
                <div className="difficulty-header">
                  <h4>Level {diff.difficulty}</h4>
                  <div className="difficulty-stars">
                    {Array.from({ length: 5 }, (_, i) => (
                      <span 
                        key={i} 
                        className={`star ${i < diff.difficulty ? 'filled' : ''}`}
                      >
                        ⭐
                      </span>
                    ))}
                  </div>
                </div>
                <div className="difficulty-stats">
                  <div className="stat">
                    <span className="stat-label">Sessions:</span>
                    <span className="stat-value">{diff.sessions}</span>
                  </div>
                  <div className="stat">
                    <span className="stat-label">Avg Score:</span>
                    <span className="stat-value">{Math.round(diff.average_score)}%</span>
                  </div>
                  <div className="stat">
                    <span className="stat-label">Completion:</span>
                    <span className="stat-value">{Math.round(diff.average_completion)}%</span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* Achievements */}
        {overview.achievements.length > 0 && (
          <section className="achievements-section">
            <h2>Recent Achievements</h2>
            <div className="achievements-grid">
              {overview.achievements.map((achievement, index) => (
                <div key={index} className="achievement-card">
                  <div className="achievement-icon">{achievement.icon}</div>
                  <div className="achievement-info">
                    <h4>{achievement.title}</h4>
                    <p>{achievement.description}</p>
                    <span className="achievement-date">
                      {new Date(achievement.earned_at).toLocaleDateString()}
                    </span>
                  </div>
                </div>
              ))}
            </div>
          </section>
        )}

        {/* Improvement Areas */}
        {metrics.improvementAreas.length > 0 && (
          <section className="improvement-section">
            <h2>Areas for Improvement</h2>
            <div className="improvement-list">
              {metrics.improvementAreas.map((area, index) => (
                <div key={index} className="improvement-item">
                  <span className="improvement-icon">🎯</span>
                  <span className="improvement-text">{area}</span>
                </div>
              ))}
            </div>
          </section>
        )}
      </div>

      {/* Loading Overlay */}
      {loading && overview && (
        <div className="loading-overlay">
          <div className="spinner"></div>
          <p>Updating analytics...</p>
        </div>
      )}
    </div>
  );
};

export default ReadingProgressDashboard;