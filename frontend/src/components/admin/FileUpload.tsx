import React, { useState, useRef } from 'react';
import { ContentImport } from '../../types/import';
import { importService } from '../../services/importService';

interface FileUploadProps {
  onUploadSuccess: (importData: ContentImport) => void;
}

const FileUpload: React.FC<FileUploadProps> = ({ onUploadSuccess }) => {
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [dragOver, setDragOver] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const allowedTypes = ['application/pdf', 'text/plain', 'text/csv', 
                       'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                       'application/vnd.ms-excel'];
  const maxSize = 50 * 1024 * 1024; // 50MB

  const validateFile = (file: File): string | null => {
    if (!allowedTypes.includes(file.type)) {
      return 'File type not supported. Please upload PDF, TXT, CSV, or Excel files.';
    }
    
    if (file.size > maxSize) {
      return 'File too large. Maximum size is 50MB.';
    }
    
    return null;
  };

  const handleFileUpload = async (file: File) => {
    const validationError = validateFile(file);
    if (validationError) {
      setError(validationError);
      return;
    }

    setUploading(true);
    setError(null);

    try {
      const response = await importService.uploadFile(file);
      onUploadSuccess(response.import);
      
      // Reset file input
      if (fileInputRef.current) {
        fileInputRef.current.value = '';
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Upload failed');
    } finally {
      setUploading(false);
    }
  };

  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) {
      handleFileUpload(file);
    }
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setDragOver(false);
    
    const files = Array.from(e.dataTransfer.files);
    if (files.length > 0) {
      handleFileUpload(files[0]);
    }
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    setDragOver(true);
  };

  const handleDragLeave = (e: React.DragEvent) => {
    e.preventDefault();
    setDragOver(false);
  };

  return (
    <div className="file-upload-section">
      <h3>Upload Content File</h3>
      
      <div 
        className={`upload-area ${dragOver ? 'drag-over' : ''} ${uploading ? 'uploading' : ''}`}
        onDrop={handleDrop}
        onDragOver={handleDragOver}
        onDragLeave={handleDragLeave}
        onClick={() => fileInputRef.current?.click()}
      >
        <input
          ref={fileInputRef}
          type="file"
          accept=".pdf,.txt,.csv,.xlsx,.xls"
          onChange={handleFileSelect}
          style={{ display: 'none' }}
          disabled={uploading}
        />
        
        <div className="upload-content">
          {uploading ? (
            <>
              <div className="upload-spinner">⏳</div>
              <p>Uploading file...</p>
            </>
          ) : (
            <>
              <div className="upload-icon">📁</div>
              <p>
                <strong>Click to browse</strong> or drag and drop files here
              </p>
              <p className="upload-hint">
                Supported formats: PDF, TXT, CSV, Excel (max 50MB)
              </p>
            </>
          )}
        </div>
      </div>

      {error && (
        <div className="upload-error">
          <span className="error-icon">❌</span>
          {error}
        </div>
      )}

      <div className="upload-info">
        <h4>Supported Content Types:</h4>
        <ul>
          <li><strong>PDF Files:</strong> Vocabulary lists, articles, or sentence collections</li>
          <li><strong>Text Files:</strong> Plain text content for processing</li>
          <li><strong>CSV/Excel:</strong> Structured vocabulary data (word, definition, etc.)</li>
        </ul>
      </div>
    </div>
  );
};

export default FileUpload;