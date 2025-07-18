/**
 * Analytics and Progress Tracking Types
 * 
 * TypeScript interfaces for vocabulary learning analytics,
 * progress tracking, and dashboard visualization.
 */

export interface VocabularyOverview {
  total_words: number;
  mastery_distribution: {
    new: number;
    learning: number;
    familiar: number;
    proficient: number;
    mastered: number;
  };
  due_for_review: number;
  average_success_rate: number;
  recent_accuracy: number;
  total_tests: number;
  mastered_words: number;
  learning_words: number;
}

export interface TimelineDataPoint {
  date: string;
  test_count: number;
  accuracy: number;
  new_words: number;
}

export interface ProgressTimeline {
  timeline: TimelineDataPoint[];
  period_days: number;
  total_tests: number;
  average_accuracy: number;
}

export interface MasteryDistribution {
  distribution: {
    new: number;
    learning: number;
    familiar: number;
    proficient: number;
    mastered: number;
  };
  percentages: {
    new: number;
    learning: number;
    familiar: number;
    proficient: number;
    mastered: number;
  };
  total_words: number;
  weekly_changes: {
    new: number;
    learning: number;
    familiar: number;
    proficient: number;
    mastered: number;
  };
  mastery_score: number;
}

export interface CategoryPerformance {
  category_id: number;
  category_name: string;
  total_words: number;
  mastered_words: number;
  average_success_rate: number;
  mastery_percentage: number;
}

export interface TestTypeBreakdown {
  test_type: string;
  count: number;
  accuracy: number;
}

export interface RecentActivity {
  recent_tests: VocabularyTestResult[];
  recent_sessions: VocabularySession[];
  test_type_breakdown: TestTypeBreakdown[];
  total_recent_tests: number;
  total_recent_sessions: number;
}

export interface VocabularyTestResult {
  id: number;
  user_id: number;
  word_id: number;
  test_type: string;
  is_correct: boolean;
  response_time: number;
  quality_score: number;
  user_answer: string;
  correct_answer: string;
  created_at: string;
  session_id: string;
}

export interface VocabularySession {
  id: number;
  user_id: number;
  session_type: string;
  words_studied: number;
  correct_answers: number;
  total_time: number;
  accuracy: number;
  started_at: string;
  ended_at: string | null;
  is_completed: boolean;
  target_words: number;
  difficulty_level: number;
}

export interface Achievement {
  id: number;
  achievement_type: string;
  achievement_name: string;
  achievement_description: string;
  value: number;
  level: number;
  earned_at: string;
  is_displayed: boolean;
}

export interface PotentialAchievement {
  type: string;
  name: string;
  description: string;
  current_progress: number;
  target: number;
  progress_percentage: number;
}

export interface UserAchievements {
  current_achievements: Achievement[];
  recent_achievements: Achievement[];
  potential_achievements: PotentialAchievement[];
  total_achievements: number;
}

export interface StreakHistoryDay {
  date: string;
  has_activity: boolean;
  activity_count: number;
}

export interface StreakAnalytics {
  current_streak: number;
  longest_streak: number;
  streak_history: StreakHistoryDay[];
  streak_goal: number;
}

export interface MonthlyPerformance {
  month: string;
  month_name: string;
  total_tests: number;
  accuracy: number;
  avg_response_time: number;
}

export interface ResponseTimeDataPoint {
  date: string;
  avg_response_time: number;
}

export interface ImprovementIndicator {
  change_percentage: number;
  direction: 'improving' | 'declining' | 'stable' | 'faster' | 'slower';
}

export interface PerformanceTrends {
  monthly_performance: MonthlyPerformance[];
  response_time_trend: ResponseTimeDataPoint[];
  improvement_indicators: {
    accuracy_trend?: ImprovementIndicator;
    speed_trend?: ImprovementIndicator;
  };
}

export interface LearningRecommendation {
  type: 'review' | 'streak' | 'accuracy' | 'expansion';
  priority: 'high' | 'medium' | 'low';
  title: string;
  description: string;
  action: string;
}

export interface ProgressDashboard {
  overview: VocabularyOverview;
  progress_timeline: ProgressTimeline;
  mastery_distribution: MasteryDistribution;
  category_performance: CategoryPerformance[];
  recent_activity: RecentActivity;
  achievements: UserAchievements;
  streak_data: StreakAnalytics;
  performance_trends: PerformanceTrends;
  generated_at: string;
}

export interface PeriodSummary {
  total_tests: number;
  correct_tests: number;
  accuracy: number;
  active_days: number;
  words_reviewed: number;
  words_updated: number;
}

export interface ProgressReport {
  report_type: 'weekly' | 'monthly';
  period_days: number;
  period_start: string;
  period_end: string;
  period_summary: PeriodSummary;
  dashboard_data: ProgressDashboard;
  recommendations: LearningRecommendation[];
  generated_at: string;
}

export interface SessionAnalytics {
  period_days: number;
  summary: {
    total_sessions: number;
    completed_sessions: number;
    completion_rate: number;
    total_words_studied: number;
    total_time_seconds: number;
    avg_words_per_session: number;
    avg_time_per_session: number;
    avg_accuracy: number;
  };
  session_types: Record<string, {
    count: number;
    total_words: number;
    avg_accuracy: number;
    avg_words_per_session: number;
  }>;
  recent_sessions: VocabularySession[];
}

export interface WordProgress {
  word_id: number;
  user_vocabulary: any; // This would be the UserVocabulary interface
  progress_metrics: {
    total_attempts: number;
    correct_attempts: number;
    accuracy: number;
    recent_accuracy: number;
    mastery_level: string;
    next_review: string | null;
    learning_days: number;
  };
  test_history: VocabularyTestResult[];
}

export interface AnalyticsApiResponse<T> {
  success: boolean;
  data: T;
  error?: string;
}

// Chart data interfaces for visualization libraries
export interface ChartDataPoint {
  x: string | number;
  y: number;
  label?: string;
}

export interface PieChartData {
  label: string;
  value: number;
  color?: string;
}

export interface LineChartData {
  label: string;
  data: ChartDataPoint[];
  color?: string;
}

export interface BarChartData {
  label: string;
  value: number;
  color?: string;
}

// Component prop interfaces
export interface DashboardProps {
  userId?: number;
  refreshInterval?: number;
  onError?: (error: string) => void;
}

export interface ChartComponentProps {
  data: any;
  title?: string;
  height?: number;
  width?: number;
  showLegend?: boolean;
  onDataPointClick?: (dataPoint: any) => void;
}

export interface ProgressIndicatorProps {
  current: number;
  target: number;
  label: string;
  color?: string;
  showPercentage?: boolean;
}

export interface StreakCalendarProps {
  streakHistory: StreakHistoryDay[];
  currentStreak: number;
  onDayClick?: (date: string) => void;
}

export interface AchievementBadgeProps {
  achievement: Achievement;
  size?: 'small' | 'medium' | 'large';
  onClick?: () => void;
}

export interface RecommendationCardProps {
  recommendation: LearningRecommendation;
  onActionClick?: () => void;
}