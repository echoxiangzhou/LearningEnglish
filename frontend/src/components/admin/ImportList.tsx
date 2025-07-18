import React from 'react';
import type { ContentImport } from '../../types/import';
import { importService } from '../../services/importService';

interface ImportListProps {
  imports: ContentImport[];
  loading: boolean;
  onSelectImport: (importData: ContentImport) => void;
  onProcessImport: (importId: number) => void;
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
}

const ImportList: React.FC<ImportListProps> = ({
  imports,
  loading,
  onSelectImport,
  onProcessImport,
  currentPage,
  totalPages,
  onPageChange
}) => {
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const getActionButton = (importItem: ContentImport) => {
    switch (importItem.status) {
      case 'uploaded':
        return (
          <button
            className="action-button process-button"
            onClick={(e) => {
              e.stopPropagation();
              onProcessImport(importItem.id);
            }}
          >
            Process
          </button>
        );
      case 'processing':
        return (
          <div className="processing-indicator">
            <div className="progress-bar">
              <div 
                className="progress-fill" 
                style={{ width: `${importItem.processing_progress}%` }}
              />
            </div>
            <span className="progress-text">{importItem.processing_progress}%</span>
          </div>
        );
      case 'reviewing':
        return (
          <button
            className="action-button review-button"
            onClick={(e) => {
              e.stopPropagation();
              onSelectImport(importItem);
            }}
          >
            Review
          </button>
        );
      case 'completed':
        return (
          <div className="completion-info">
            <span className="success-icon">✅</span>
            {importItem.items_created} items created
          </div>
        );
      case 'failed':
        return (
          <button
            className="action-button retry-button"
            onClick={(e) => {
              e.stopPropagation();
              onProcessImport(importItem.id);
            }}
          >
            Retry
          </button>
        );
      default:
        return null;
    }
  };

  if (loading) {
    return (
      <div className="import-list-loading">
        <div className="loading-spinner">⏳</div>
        <p>Loading imports...</p>
      </div>
    );
  }

  if (imports.length === 0) {
    return (
      <div className="import-list-empty">
        <div className="empty-icon">📁</div>
        <h3>No imports found</h3>
        <p>Upload a file to get started</p>
      </div>
    );
  }

  return (
    <div className="import-list">
      <h3>Import History</h3>
      
      <div className="import-table">
        <div className="table-header">
          <div className="header-cell">File</div>
          <div className="header-cell">Type</div>
          <div className="header-cell">Status</div>
          <div className="header-cell">Size</div>
          <div className="header-cell">Uploaded</div>
          <div className="header-cell">Action</div>
        </div>
        
        {imports.map((importItem) => (
          <div 
            key={importItem.id}
            className={`table-row ${importItem.status}`}
            onClick={() => onSelectImport(importItem)}
          >
            <div className="cell file-cell">
              <div className="file-icon">
                {importItem.file_type === 'pdf' && '📄'}
                {importItem.file_type === 'txt' && '📝'}
                {(importItem.file_type === 'csv' || importItem.file_type === 'xlsx') && '📊'}
              </div>
              <div className="file-info">
                <div className="filename" title={importItem.original_filename}>
                  {importItem.original_filename}
                </div>
                {importItem.content_type && (
                  <div className="content-type">
                    {importItem.content_type}
                  </div>
                )}
              </div>
            </div>
            
            <div className="cell">
              <span className="file-type">{importItem.file_type.toUpperCase()}</span>
            </div>
            
            <div className="cell">
              <span className={`status-badge status-${importItem.status}`}>
                {importService.getStatusText(importItem.status)}
              </span>
            </div>
            
            <div className="cell">
              {importService.formatFileSize(importItem.file_size)}
            </div>
            
            <div className="cell">
              {formatDate(importItem.created_at)}
            </div>
            
            <div className="cell action-cell">
              {getActionButton(importItem)}
            </div>
          </div>
        ))}
      </div>

      {totalPages > 1 && (
        <div className="pagination">
          <button
            className="page-button"
            disabled={currentPage === 1}
            onClick={() => onPageChange(currentPage - 1)}
          >
            Previous
          </button>
          
          <span className="page-info">
            Page {currentPage} of {totalPages}
          </span>
          
          <button
            className="page-button"
            disabled={currentPage === totalPages}
            onClick={() => onPageChange(currentPage + 1)}
          >
            Next
          </button>
        </div>
      )}
    </div>
  );
};

export default ImportList;