import React, { useState, useEffect } from 'react';
import type { ContentImport } from '../../types/import';
import { importService } from '../../services/importService';
import FileUpload from './FileUpload';
import ImportList from './ImportList';
import ImportDetail from './ImportDetail';

interface ImportManagerProps {
  className?: string;
}

const ImportManager: React.FC<ImportManagerProps> = ({ className }) => {
  const [imports, setImports] = useState<ContentImport[]>([]);
  const [selectedImport, setSelectedImport] = useState<ContentImport | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [statusFilter, setStatusFilter] = useState<string>('');
  const [refreshKey, setRefreshKey] = useState(0);

  const loadImports = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await importService.getImports(currentPage, 20, statusFilter);
      setImports(response.imports);
      setTotalPages(response.pagination.pages);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load imports');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadImports();
  }, [currentPage, statusFilter, refreshKey]);

  const handleUploadSuccess = (newImport: ContentImport) => {
    setImports(prev => [newImport, ...prev]);
    setRefreshKey(prev => prev + 1);
  };

  const handleProcessImport = async (importId: number) => {
    try {
      await importService.processImport(importId);
      setRefreshKey(prev => prev + 1);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Processing failed');
    }
  };

  const handleApproveImport = async (importId: number, notes?: string) => {
    try {
      await importService.approveImport(importId, notes);
      setRefreshKey(prev => prev + 1);
      if (selectedImport?.id === importId) {
        setSelectedImport(null);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Approval failed');
    }
  };

  const handleRejectImport = async (importId: number, notes: string) => {
    try {
      await importService.rejectImport(importId, notes);
      setRefreshKey(prev => prev + 1);
      if (selectedImport?.id === importId) {
        setSelectedImport(null);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Rejection failed');
    }
  };

  const handleSelectImport = async (importItem: ContentImport) => {
    try {
      const response = await importService.getImportDetails(importItem.id);
      setSelectedImport(response.import);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load import details');
    }
  };

  return (
    <div className={`import-manager ${className || ''}`}>
      <div className="import-manager-header">
        <h2>Content Import Manager</h2>
        {error && (
          <div className="error-alert">
            <span className="error-icon">⚠️</span>
            {error}
            <button 
              className="error-close"
              onClick={() => setError(null)}
            >
              ×
            </button>
          </div>
        )}
      </div>

      <div className="import-manager-content">
        {!selectedImport ? (
          <>
            <FileUpload onUploadSuccess={handleUploadSuccess} />
            
            <div className="import-filters">
              <select 
                value={statusFilter} 
                onChange={(e) => setStatusFilter(e.target.value)}
                className="status-filter"
              >
                <option value="">All Status</option>
                <option value="uploaded">Uploaded</option>
                <option value="processing">Processing</option>
                <option value="reviewing">Needs Review</option>
                <option value="completed">Completed</option>
                <option value="failed">Failed</option>
              </select>
              
              <button 
                onClick={() => setRefreshKey(prev => prev + 1)}
                className="refresh-button"
              >
                🔄 Refresh
              </button>
            </div>

            <ImportList
              imports={imports}
              loading={loading}
              onSelectImport={handleSelectImport}
              onProcessImport={handleProcessImport}
              currentPage={currentPage}
              totalPages={totalPages}
              onPageChange={setCurrentPage}
            />
          </>
        ) : (
          <ImportDetail
            import={selectedImport}
            onBack={() => setSelectedImport(null)}
            onApprove={handleApproveImport}
            onReject={handleRejectImport}
          />
        )}
      </div>
    </div>
  );
};

export default ImportManager;