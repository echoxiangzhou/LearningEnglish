/**
 * User Service
 * Handles API calls for user management functionality
 */

const API_BASE = '/api';

export interface User {
  id: number;
  username: string;
  email: string;
  first_name?: string;
  last_name?: string;
  role: 'student' | 'teacher' | 'admin';
  is_active: boolean;
  created_at: string;
  updated_at?: string;
  last_login?: string;
  profile?: {
    avatar?: string;
    phone?: string;
    grade?: string;
  };
}

export interface CreateUserRequest {
  username: string;
  email: string;
  password: string;
  first_name?: string;
  last_name?: string;
  role: 'student' | 'teacher' | 'admin';
  is_active?: boolean;
}

export interface UpdateUserRequest {
  username?: string;
  email?: string;
  first_name?: string;
  last_name?: string;
  role?: 'student' | 'teacher' | 'admin';
  is_active?: boolean;
}

export interface UserListResponse {
  users: User[];
  total: number;
  page: number;
  per_page: number;
}

export interface UserQuery {
  page?: number;
  per_page?: number;
  role?: string;
  is_active?: boolean;
  search?: string;
}

class UserService {
  private baseUrl = `${API_BASE}/users`;

  /**
   * Get all users with optional filtering
   */
  async getUsers(query: UserQuery = {}): Promise<UserListResponse> {
    const params = new URLSearchParams();
    
    if (query.page) params.append('page', query.page.toString());
    if (query.per_page) params.append('per_page', query.per_page.toString());
    if (query.role) params.append('role', query.role);
    if (query.is_active !== undefined) params.append('is_active', query.is_active.toString());
    if (query.search) params.append('search', query.search);

    const url = `${this.baseUrl}${params.toString() ? '?' + params.toString() : ''}`;
    
    try {
      const response = await fetch(url, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
        },
      });

      if (!response.ok) {
        throw new Error(`Failed to fetch users: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error('Error fetching users:', error);
      throw error;
    }
  }

  /**
   * Get a specific user by ID
   */
  async getUserById(id: number): Promise<User> {
    try {
      const response = await fetch(`${this.baseUrl}/${id}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
        },
      });

      if (!response.ok) {
        throw new Error(`Failed to fetch user: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error('Error fetching user:', error);
      throw error;
    }
  }

  /**
   * Create a new user
   */
  async createUser(userData: CreateUserRequest): Promise<User> {
    try {
      const response = await fetch(this.baseUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
        },
        body: JSON.stringify(userData),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || 'Failed to create user');
      }

      return await response.json();
    } catch (error) {
      console.error('Error creating user:', error);
      throw error;
    }
  }

  /**
   * Update an existing user
   */
  async updateUser(id: number, userData: UpdateUserRequest): Promise<User> {
    try {
      const response = await fetch(`${this.baseUrl}/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
        },
        body: JSON.stringify(userData),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || 'Failed to update user');
      }

      return await response.json();
    } catch (error) {
      console.error('Error updating user:', error);
      throw error;
    }
  }

  /**
   * Delete a user
   */
  async deleteUser(id: number): Promise<{ success: boolean; message: string }> {
    try {
      const response = await fetch(`${this.baseUrl}/${id}`, {
        method: 'DELETE',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
        },
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || 'Failed to delete user');
      }

      return await response.json();
    } catch (error) {
      console.error('Error deleting user:', error);
      throw error;
    }
  }

  /**
   * Toggle user active status
   */
  async toggleUserStatus(id: number, isActive: boolean): Promise<User> {
    try {
      const response = await fetch(`${this.baseUrl}/${id}/status`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
        },
        body: JSON.stringify({ is_active: isActive }),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || 'Failed to update user status');
      }

      return await response.json();
    } catch (error) {
      console.error('Error updating user status:', error);
      throw error;
    }
  }

  /**
   * Reset user password (admin only)
   */
  async resetUserPassword(id: number, newPassword: string): Promise<{ success: boolean; message: string }> {
    try {
      const response = await fetch(`${this.baseUrl}/${id}/reset-password`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
        },
        body: JSON.stringify({ new_password: newPassword }),
      });

      if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || 'Failed to reset password');
      }

      return await response.json();
    } catch (error) {
      console.error('Error resetting password:', error);
      throw error;
    }
  }

  /**
   * Get users assigned to a specific category
   */
  async getUsersAssignedToCategory(categoryId: number): Promise<User[]> {
    try {
      const response = await fetch(`${this.baseUrl}/category/${categoryId}/assigned`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
        },
      });

      if (!response.ok) {
        throw new Error(`Failed to fetch assigned users: ${response.statusText}`);
      }

      return await response.json();
    } catch (error) {
      console.error('Error fetching assigned users:', error);
      // Return empty array for development
      return [];
    }
  }

  /**
   * Get simple user list for dropdowns/assignments (id, username, email only)
   */
  async getSimpleUserList(): Promise<Array<{id: number; username: string; email: string; first_name?: string}>> {
    try {
      const response = await this.getUsers({ per_page: 1000 }); // Get all users
      return response.users.map(user => ({
        id: user.id,
        username: user.username,
        email: user.email,
        first_name: user.first_name
      }));
    } catch (error) {
      console.error('Error fetching simple user list:', error);
      // Return mock data for development
      return this.getMockSimpleUsers();
    }
  }

  /**
   * Mock data for development when API is not available
   */
  private getMockUsers(query: UserQuery = {}): UserListResponse {
    const mockUsers: User[] = [
      {
        id: 1,
        username: 'admin',
        email: 'admin@example.com',
        first_name: '系统管理员',
        role: 'admin',
        is_active: true,
        created_at: '2024-01-01T00:00:00Z',
        last_login: '2024-01-09T10:30:00Z'
      },
      {
        id: 2,
        username: 'teacher_wang',
        email: 'wang.teacher@example.com',
        first_name: '王老师',
        last_name: '王',
        role: 'teacher',
        is_active: true,
        created_at: '2024-01-02T00:00:00Z',
        last_login: '2024-01-09T09:15:00Z'
      },
      {
        id: 3,
        username: 'student_zhang',
        email: 'zhang.student@example.com',
        first_name: '张三',
        last_name: '张',
        role: 'student',
        is_active: true,
        created_at: '2024-01-03T00:00:00Z',
        last_login: '2024-01-09T08:45:00Z'
      },
      {
        id: 4,
        username: 'student_li',
        email: 'li.student@example.com',
        first_name: '李四',
        last_name: '李',
        role: 'student',
        is_active: true,
        created_at: '2024-01-04T00:00:00Z',
        last_login: '2024-01-09T07:20:00Z'
      },
      {
        id: 5,
        username: 'student_wang',
        email: 'wang.student@example.com',
        first_name: '王五',
        last_name: '王',
        role: 'student',
        is_active: false,
        created_at: '2024-01-05T00:00:00Z',
        last_login: '2024-01-08T16:20:00Z'
      },
      {
        id: 6,
        username: 'teacher_liu',
        email: 'liu.teacher@example.com',
        first_name: '刘老师',
        last_name: '刘',
        role: 'teacher',
        is_active: true,
        created_at: '2024-01-06T00:00:00Z',
        last_login: '2024-01-09T06:10:00Z'
      }
    ];

    // Apply filters
    let filteredUsers = mockUsers;
    
    if (query.role) {
      filteredUsers = filteredUsers.filter(user => user.role === query.role);
    }
    
    if (query.is_active !== undefined) {
      filteredUsers = filteredUsers.filter(user => user.is_active === query.is_active);
    }
    
    if (query.search) {
      const searchLower = query.search.toLowerCase();
      filteredUsers = filteredUsers.filter(user => 
        user.username.toLowerCase().includes(searchLower) ||
        user.email.toLowerCase().includes(searchLower) ||
        (user.first_name && user.first_name.toLowerCase().includes(searchLower))
      );
    }

    const page = query.page || 1;
    const perPage = query.per_page || 10;
    const startIndex = (page - 1) * perPage;
    const endIndex = startIndex + perPage;

    return {
      users: filteredUsers.slice(startIndex, endIndex),
      total: filteredUsers.length,
      page,
      per_page: perPage
    };
  }

  /**
   * Mock simple user list for development
   */
  private getMockSimpleUsers(): Array<{id: number; username: string; email: string; first_name?: string}> {
    return [
      { id: 1, username: 'admin', email: 'admin@example.com', first_name: '系统管理员' },
      { id: 2, username: 'teacher_wang', email: 'wang.teacher@example.com', first_name: '王老师' },
      { id: 3, username: 'student_zhang', email: 'zhang.student@example.com', first_name: '张三' },
      { id: 4, username: 'student_li', email: 'li.student@example.com', first_name: '李四' },
      { id: 5, username: 'student_wang', email: 'wang.student@example.com', first_name: '王五' },
      { id: 6, username: 'teacher_liu', email: 'liu.teacher@example.com', first_name: '刘老师' }
    ];
  }
}

export const userService = new UserService();
export default userService;