import { ContentImport, ImportListResponse } from '../types/import';

const API_BASE = '/api/content';

class ImportService {
  async uploadFile(file: File): Promise<{ import: ContentImport; message: string }> {
    const formData = new FormData();
    formData.append('file', file);

    const response = await fetch(`${API_BASE}/upload`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      },
      body: formData
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Upload failed');
    }

    return response.json();
  }

  async getImports(page = 1, perPage = 20, status?: string): Promise<ImportListResponse> {
    const params = new URLSearchParams({
      page: page.toString(),
      per_page: perPage.toString()
    });

    if (status) {
      params.append('status', status);
    }

    const response = await fetch(`${API_BASE}/imports?${params}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      }
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to fetch imports');
    }

    return response.json();
  }

  async getImportDetails(importId: number): Promise<{ import: ContentImport }> {
    const response = await fetch(`${API_BASE}/imports/${importId}`, {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`
      }
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Failed to fetch import details');
    }

    return response.json();
  }

  async processImport(importId: number): Promise<{ message: string; import: ContentImport }> {
    const response = await fetch(`${API_BASE}/imports/${importId}/process`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`,
        'Content-Type': 'application/json'
      }
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Processing failed');
    }

    return response.json();
  }

  async approveImport(importId: number, notes?: string): Promise<{ 
    message: string; 
    items_created: number;
    import: ContentImport;
  }> {
    const response = await fetch(`${API_BASE}/imports/${importId}/approve`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ notes })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Approval failed');
    }

    return response.json();
  }

  async rejectImport(importId: number, notes: string): Promise<{ 
    message: string;
    import: ContentImport;
  }> {
    const response = await fetch(`${API_BASE}/imports/${importId}/reject`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('token')}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ notes })
    });

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.error || 'Rejection failed');
    }

    return response.json();
  }

  getStatusColor(status: string): string {
    switch (status) {
      case 'uploaded': return 'blue';
      case 'processing': return 'yellow';
      case 'reviewing': return 'orange';
      case 'completed': return 'green';
      case 'failed': return 'red';
      default: return 'gray';
    }
  }

  getStatusText(status: string): string {
    switch (status) {
      case 'uploaded': return 'Uploaded';
      case 'processing': return 'Processing';
      case 'reviewing': return 'Needs Review';
      case 'completed': return 'Completed';
      case 'failed': return 'Failed';
      default: return 'Unknown';
    }
  }

  formatFileSize(bytes: number): string {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  }
}

export const importService = new ImportService();