export interface SentenceData {
  id: number;
  text: string;
  chinese_translation: string;
  target_word: string;
  difficulty: 'elementary' | 'intermediate' | 'advanced';
  approval_status: 'pending' | 'approved' | 'rejected';
  confidence: number;
  grammar_score: number;
  overall_score: number;
  category_id?: number;
  category_name?: string;
  created_at: string;
  approved_at?: string;
  approved_by?: string;
  rejection_reason?: string;
}

export interface SentenceSearchParams {
  search?: string;
  target_word?: string;
  difficulty?: string;
  approval_status?: string;
  category_id?: number;
  page?: number;
  per_page?: number;
}

export interface SentenceStatistics {
  total_sentences: number;
  approval_status: {
    pending: number;
    approved: number;
    rejected: number;
  };
  by_difficulty: {
    elementary: number;
    intermediate: number;
    advanced: number;
  };
  quality_metrics: {
    average_overall_score: number;
    average_grammar_score: number;
    average_readability_score: number;
    validated_count: number;
  };
  by_pattern?: {
    [key: string]: number;
  };
  top_target_words?: Array<{
    word: string;
    count: number;
  }>;
  recent_activity?: {
    generated_last_week: number;
  };
}

interface ApprovalRequest {
  sentence_ids: number[];
  approved_by: string;
}

interface RejectionRequest {
  sentence_ids: number[];
  rejection_reason: string;
}

class SentenceAdminService {
  private baseUrl = '/api/admin/sentences';

  private getAuthHeaders(): Record<string, string> {
    const token = localStorage.getItem('access_token');
    return {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };
  }

  async getPendingReview(): Promise<SentenceData[]> {
    const response = await fetch(`${this.baseUrl}/pending-review`, {
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to fetch pending sentences');
    }
    return response.json();
  }

  async searchSentences(params: SentenceSearchParams = {}): Promise<{
    sentences: SentenceData[];
    total: number;
    page: number;
    per_page: number;
  }> {
    const searchParams = new URLSearchParams();
    
    Object.entries(params).forEach(([key, value]) => {
      if (value !== undefined && value !== '') {
        searchParams.append(key, value.toString());
      }
    });

    const response = await fetch(`${this.baseUrl}/search?${searchParams}`, {
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to search sentences');
    }
    return response.json();
  }

  async getSentenceById(id: number): Promise<SentenceData> {
    const response = await fetch(`${this.baseUrl}/sentence/${id}`, {
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to fetch sentence');
    }
    return response.json();
  }

  async updateSentence(id: number, data: Partial<SentenceData>): Promise<SentenceData> {
    const response = await fetch(`${this.baseUrl}/sentence/${id}`, {
      method: 'PUT',
      headers: this.getAuthHeaders(),
      body: JSON.stringify(data),
    });
    if (!response.ok) {
      throw new Error('Failed to update sentence');
    }
    return response.json();
  }

  async deleteSentence(id: number): Promise<void> {
    const response = await fetch(`${this.baseUrl}/sentence/${id}`, {
      method: 'DELETE',
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to delete sentence');
    }
  }

  async approveSentences(data: ApprovalRequest): Promise<{ success: boolean; message: string }> {
    const response = await fetch(`${this.baseUrl}/approve`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify(data),
    });
    if (!response.ok) {
      throw new Error('Failed to approve sentences');
    }
    return response.json();
  }

  async rejectSentences(data: RejectionRequest): Promise<{ success: boolean; message: string }> {
    const response = await fetch(`${this.baseUrl}/reject`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify(data),
    });
    if (!response.ok) {
      throw new Error('Failed to reject sentences');
    }
    return response.json();
  }

  async getStatistics(): Promise<SentenceStatistics> {
    const response = await fetch(`${this.baseUrl}/statistics`, {
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to fetch statistics');
    }
    const data = await response.json();
    return data.statistics || data;
  }

  async exportSentences(format: 'csv' | 'json' = 'csv'): Promise<string> {
    const response = await fetch(`${this.baseUrl}/export?format=${format}`, {
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to export sentences');
    }
    return response.text();
  }
}

export const sentenceAdminService = new SentenceAdminService();
export type { SentenceData, SentenceSearchParams, SentenceStatistics };