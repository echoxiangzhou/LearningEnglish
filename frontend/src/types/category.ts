export interface SentenceCategory {
  id: number;
  name: string;
  description?: string;
  difficulty: 'elementary' | 'intermediate' | 'advanced';
  is_active: boolean;
  sentence_count: number;
  created_at: string;
  updated_at: string;
}

export interface CreateCategoryRequest {
  name: string;
  description?: string;
  difficulty: 'elementary' | 'intermediate' | 'advanced';
  is_active?: boolean;
}

export interface UpdateCategoryRequest extends Partial<CreateCategoryRequest> {
  id: number;
}

export interface UserCategoryAssignment {
  id: number;
  user_id: number;
  category_id: number;
  assigned_at: string;
  assigned_by: string;
}

export interface AssignCategoryRequest {
  user_ids: number[];
  category_ids: number[];
  assigned_by: string;
}