export interface ContentImport {
  id: number;
  user_id: number;
  filename: string;
  original_filename: string;
  file_size: number;
  file_type: string;
  content_type?: string;
  status: 'uploaded' | 'processing' | 'completed' | 'failed' | 'reviewing';
  processing_progress: number;
  error_message?: string;
  review_notes?: string;
  is_approved: boolean;
  approved_by?: number;
  approved_at?: string;
  items_created: number;
  created_at: string;
  updated_at: string;
  extracted_text?: string;
  processed_data?: any;
}

export interface ImportListResponse {
  imports: ContentImport[];
  pagination: {
    page: number;
    pages: number;
    per_page: number;
    total: number;
    has_next: boolean;
    has_prev: boolean;
  };
}

export interface ProcessingResult {
  success: boolean;
  text: string;
  pages: Array<{
    page_number: number;
    text: string;
    [key: string]: any;
  }>;
  method_used: string;
  content_type: string;
  quality_score: number;
  error?: string;
  metadata?: Record<string, any>;
  structured_data?: any;
}

export interface VocabularyItem {
  word: string;
  definition: string;
  source_line?: string;
  additional_info?: Record<string, any>;
}

export interface SentenceItem {
  text: string;
  order: number;
  word_count: number;
  difficulty_estimate: number;
}

export interface ArticleItem {
  title: string;
  paragraphs: string[];
  paragraph_count: number;
  estimated_reading_time: number;
  difficulty_estimate: number;
}