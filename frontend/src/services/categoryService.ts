import type { SentenceCategory, CreateCategoryRequest, UpdateCategoryRequest, UserCategoryAssignment, AssignCategoryRequest } from '../types/category';

class CategoryService {
  private baseUrl = '/api/admin/sentences/categories';

  private getAuthHeaders(): Record<string, string> {
    const token = localStorage.getItem('access_token');
    return {
      'Content-Type': 'application/json',
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };
  }

  async getCategories(): Promise<SentenceCategory[]> {
    const response = await fetch(this.baseUrl, {
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to fetch categories');
    }
    return response.json();
  }

  async getCategoryById(id: number): Promise<SentenceCategory> {
    const response = await fetch(`${this.baseUrl}/${id}`, {
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to fetch category');
    }
    return response.json();
  }

  async createCategory(data: CreateCategoryRequest): Promise<SentenceCategory> {
    const response = await fetch(this.baseUrl, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify(data),
    });
    if (!response.ok) {
      throw new Error('Failed to create category');
    }
    return response.json();
  }

  async updateCategory(data: UpdateCategoryRequest): Promise<SentenceCategory> {
    const response = await fetch(`${this.baseUrl}/${data.id}`, {
      method: 'PUT',
      headers: this.getAuthHeaders(),
      body: JSON.stringify(data),
    });
    if (!response.ok) {
      throw new Error('Failed to update category');
    }
    return response.json();
  }

  async deleteCategory(id: number): Promise<void> {
    const response = await fetch(`${this.baseUrl}/${id}`, {
      method: 'DELETE',
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to delete category');
    }
  }

  async getUserCategories(userId: number): Promise<SentenceCategory[]> {
    const response = await fetch(`/api/users/${userId}/categories`);
    if (!response.ok) {
      throw new Error('Failed to fetch user categories');
    }
    return response.json();
  }

  async getCurrentUserCategories(): Promise<SentenceCategory[]> {
    const response = await fetch('/api/users/me/categories', {
      headers: this.getAuthHeaders(),
    });
    if (!response.ok) {
      throw new Error('Failed to fetch current user categories');
    }
    return response.json();
  }

  async assignCategoriesToUsers(data: AssignCategoryRequest): Promise<{ success: boolean; message: string }> {
    const response = await fetch(`${this.baseUrl}/assign`, {
      method: 'POST',
      headers: this.getAuthHeaders(),
      body: JSON.stringify(data),
    });
    
    const result = await response.json();
    
    if (!response.ok) {
      console.error('Assignment failed:', result);
      throw new Error(result.error || result.message || 'Failed to assign categories');
    }
    
    return result;
  }

  async getUserCategoryAssignments(userId?: number): Promise<UserCategoryAssignment[]> {
    const url = userId ? `/api/admin/user-categories?user_id=${userId}` : '/api/admin/user-categories';
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error('Failed to fetch user category assignments');
    }
    return response.json();
  }

  async removeUserCategoryAssignment(userId: number, categoryId: number): Promise<void> {
    const response = await fetch(`/api/admin/user-categories/${userId}/${categoryId}`, {
      method: 'DELETE',
    });
    if (!response.ok) {
      throw new Error('Failed to remove category assignment');
    }
  }
}

export const categoryService = new CategoryService();