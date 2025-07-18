// Reading Module Components
export { default as ReadingModule } from './ReadingModule';
export { default as ReadingInterface } from './ReadingInterface';
export { default as ArticleSelector } from './ArticleSelector';
export { default as AudioReader } from './AudioReader';
export { default as ReadingProgressDashboard } from './ReadingProgressDashboard';
export { default as RecommendationDashboard } from './RecommendationDashboard';
export { default as ArticleRecommendations } from './ArticleRecommendations';

// Types (for external use)
export interface Article {
  id: number;
  title: string;
  content: string;
  summary?: string;
  author?: string;
  topic?: string;
  grade_level: number;
  difficulty: number;
  word_count: number;
  estimated_reading_time: number;
  tags: string[];
  questions?: Question[];
}

export interface Question {
  id: number;
  question_text: string;
  question_type: 'multiple_choice' | 'true_false' | 'short_answer';
  options?: string[];
  correct_answer: string;
  explanation?: string;
  difficulty: number;
  order_index: number;
}

export interface ReadingSession {
  id: number;
  start_time: string;
  reading_duration: number;
  completion_percentage: number;
  comprehension_score?: number;
  bookmarks: any[];
}