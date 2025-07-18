/**
 * Mastery Overview Component
 * 
 * Displays high-level vocabulary mastery statistics including
 * total words, mastery distribution, and key performance metrics.
 */

import React from 'react';
import type { VocabularyOverview } from '../../types/analytics';
import './MasteryOverview.css';

interface MasteryOverviewProps {
  overview: VocabularyOverview;
}

const MasteryOverview: React.FC<MasteryOverviewProps> = ({ overview }) => {
  const {
    total_words,
    mastery_distribution,
    due_for_review,
    average_success_rate,
    recent_accuracy,
    total_tests,
    mastered_words,
    learning_words
  } = overview;

  /**
   * Calculate mastery percentage
   */
  const masteryPercentage = total_words > 0 
    ? Math.round((mastered_words / total_words) * 100) 
    : 0;

  /**
   * Calculate learning progress percentage
   */
  const learningPercentage = total_words > 0 
    ? Math.round(((mastered_words + learning_words) / total_words) * 100) 
    : 0;

  /**
   * Get performance indicator
   */
  const getPerformanceIndicator = (accuracy: number) => {
    if (accuracy >= 90) return { label: 'Excellent', class: 'excellent' };
    if (accuracy >= 80) return { label: 'Good', class: 'good' };
    if (accuracy >= 70) return { label: 'Fair', class: 'fair' };
    return { label: 'Needs Improvement', class: 'needs-improvement' };
  };

  const performanceIndicator = getPerformanceIndicator(average_success_rate);
  const recentPerformanceIndicator = getPerformanceIndicator(recent_accuracy);

  return (
    <div className="mastery-overview">
      <h2>Your Learning Overview</h2>
      
      {/* Primary Stats Grid */}
      <div className="primary-stats">
        <div className="stat-card total-words">
          <div className="stat-icon">📚</div>
          <div className="stat-content">
            <div className="stat-number">{total_words.toLocaleString()}</div>
            <div className="stat-label">Total Words</div>
          </div>
        </div>

        <div className="stat-card mastered-words">
          <div className="stat-icon">🏆</div>
          <div className="stat-content">
            <div className="stat-number">{mastered_words}</div>
            <div className="stat-label">Mastered</div>
            <div className="stat-percentage">{masteryPercentage}%</div>
          </div>
        </div>

        <div className="stat-card due-review">
          <div className="stat-icon">⏰</div>
          <div className="stat-content">
            <div className="stat-number">{due_for_review}</div>
            <div className="stat-label">Due for Review</div>
          </div>
        </div>

        <div className="stat-card total-tests">
          <div className="stat-icon">✅</div>
          <div className="stat-content">
            <div className="stat-number">{total_tests.toLocaleString()}</div>
            <div className="stat-label">Total Tests</div>
          </div>
        </div>
      </div>

      {/* Progress Bars */}
      <div className="progress-section">
        <div className="progress-item">
          <div className="progress-header">
            <span className="progress-label">Mastery Progress</span>
            <span className="progress-percentage">{masteryPercentage}%</span>
          </div>
          <div className="progress-bar">
            <div 
              className="progress-fill mastery-fill"
              style={{ width: `${masteryPercentage}%` }}
            />
          </div>
          <div className="progress-detail">
            {mastered_words} of {total_words} words mastered
          </div>
        </div>

        <div className="progress-item">
          <div className="progress-header">
            <span className="progress-label">Learning Progress</span>
            <span className="progress-percentage">{learningPercentage}%</span>
          </div>
          <div className="progress-bar">
            <div 
              className="progress-fill learning-fill"
              style={{ width: `${learningPercentage}%` }}
            />
          </div>
          <div className="progress-detail">
            {mastered_words + learning_words} of {total_words} words in progress
          </div>
        </div>
      </div>

      {/* Performance Metrics */}
      <div className="performance-metrics">
        <div className="metric-card overall-performance">
          <div className="metric-header">
            <h4>Overall Performance</h4>
            <span className={`performance-badge ${performanceIndicator.class}`}>
              {performanceIndicator.label}
            </span>
          </div>
          <div className="metric-value">
            {average_success_rate.toFixed(1)}%
          </div>
          <div className="metric-label">Average Success Rate</div>
        </div>

        <div className="metric-card recent-performance">
          <div className="metric-header">
            <h4>Recent Performance</h4>
            <span className={`performance-badge ${recentPerformanceIndicator.class}`}>
              {recentPerformanceIndicator.label}
            </span>
          </div>
          <div className="metric-value">
            {recent_accuracy.toFixed(1)}%
          </div>
          <div className="metric-label">Last 7 Days Accuracy</div>
        </div>
      </div>

      {/* Mastery Distribution */}
      <div className="mastery-distribution">
        <h4>Learning Stages</h4>
        <div className="distribution-grid">
          <div className="distribution-item new">
            <div className="distribution-count">{mastery_distribution.new}</div>
            <div className="distribution-label">New</div>
          </div>
          
          <div className="distribution-item learning">
            <div className="distribution-count">{mastery_distribution.learning}</div>
            <div className="distribution-label">Learning</div>
          </div>
          
          <div className="distribution-item familiar">
            <div className="distribution-count">{mastery_distribution.familiar}</div>
            <div className="distribution-label">Familiar</div>
          </div>
          
          <div className="distribution-item proficient">
            <div className="distribution-count">{mastery_distribution.proficient}</div>
            <div className="distribution-label">Proficient</div>
          </div>
          
          <div className="distribution-item mastered">
            <div className="distribution-count">{mastery_distribution.mastered}</div>
            <div className="distribution-label">Mastered</div>
          </div>
        </div>
      </div>

      {/* Quick Actions */}
      <div className="quick-actions">
        <h4>Quick Actions</h4>
        <div className="action-buttons">
          {due_for_review > 0 && (
            <button className="action-button review-button">
              <span className="button-icon">📖</span>
              Review {due_for_review} Words
            </button>
          )}
          
          <button className="action-button practice-button">
            <span className="button-icon">🎯</span>
            Start Practice
          </button>
          
          <button className="action-button browse-button">
            <span className="button-icon">🔍</span>
            Browse Vocabulary
          </button>
        </div>
      </div>
    </div>
  );
};

export default MasteryOverview;