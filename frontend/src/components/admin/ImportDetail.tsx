import React, { useState } from 'react';
import type { ContentImport, VocabularyItem, SentenceItem, ArticleItem } from '../../types/import';
import { importService } from '../../services/importService';

interface ImportDetailProps {
  import: ContentImport;
  onBack: () => void;
  onApprove: (importId: number, notes?: string) => void;
  onReject: (importId: number, notes: string) => void;
}

const ImportDetail: React.FC<ImportDetailProps> = ({
  import: importData,
  onBack,
  onApprove,
  onReject
}) => {
  const [reviewNotes, setReviewNotes] = useState('');
  const [showRawText, setShowRawText] = useState(false);

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const renderStructuredContent = () => {
    if (!importData.processed_data) {
      return (
        <div className="no-structured-data">
          <p>No structured data available</p>
        </div>
      );
    }

    switch (importData.content_type) {
      case 'vocabulary':
        return renderVocabularyData(importData.processed_data);
      case 'sentences':
        return renderSentenceData(importData.processed_data);
      case 'article':
        return renderArticleData(importData.processed_data);
      default:
        return (
          <div className="unknown-content-type">
            <h4>Unknown Content Type</h4>
            <pre>{JSON.stringify(importData.processed_data, null, 2)}</pre>
          </div>
        );
    }
  };

  const renderVocabularyData = (data: VocabularyItem[]) => (
    <div className="vocabulary-preview">
      <h4>Vocabulary Words ({data.length} items)</h4>
      <div className="vocabulary-list">
        {data.slice(0, 20).map((item, index) => (
          <div key={index} className="vocabulary-item">
            <div className="word">{item.word}</div>
            <div className="definition">{item.definition}</div>
            {item.additional_info && Object.keys(item.additional_info).length > 0 && (
              <div className="additional-info">
                {Object.entries(item.additional_info).map(([key, value]) => (
                  <span key={key} className="info-tag">
                    {key}: {String(value)}
                  </span>
                ))}
              </div>
            )}
          </div>
        ))}
        {data.length > 20 && (
          <div className="more-items">
            ...and {data.length - 20} more items
          </div>
        )}
      </div>
    </div>
  );

  const renderSentenceData = (data: SentenceItem[]) => (
    <div className="sentence-preview">
      <h4>Sentences ({data.length} items)</h4>
      <div className="sentence-list">
        {data.slice(0, 10).map((item, index) => (
          <div key={index} className="sentence-item">
            <div className="sentence-text">{item.text}</div>
            <div className="sentence-meta">
              <span className="word-count">{item.word_count} words</span>
              <span className="difficulty">Difficulty: {item.difficulty_estimate}</span>
            </div>
          </div>
        ))}
        {data.length > 10 && (
          <div className="more-items">
            ...and {data.length - 10} more sentences
          </div>
        )}
      </div>
    </div>
  );

  const renderArticleData = (data: ArticleItem) => (
    <div className="article-preview">
      <h4>Article</h4>
      <div className="article-meta">
        <span className="reading-time">
          Est. reading time: {data.estimated_reading_time} min
        </span>
        <span className="difficulty">
          Difficulty: {data.difficulty_estimate}
        </span>
        <span className="paragraph-count">
          {data.paragraph_count} paragraphs
        </span>
      </div>
      
      {data.title && (
        <div className="article-title">
          <h5>{data.title}</h5>
        </div>
      )}
      
      <div className="article-content">
        {data.paragraphs.slice(0, 3).map((paragraph, index) => (
          <p key={index} className="article-paragraph">
            {paragraph}
          </p>
        ))}
        {data.paragraphs.length > 3 && (
          <div className="more-paragraphs">
            ...and {data.paragraphs.length - 3} more paragraphs
          </div>
        )}
      </div>
    </div>
  );


  return (
    <div className="import-detail">
      <div className="detail-header">
        <button className="back-button" onClick={onBack}>
          ← Back to List
        </button>
        <h2>Import Details</h2>
      </div>

      <div className="import-summary">
        <div className="summary-grid">
          <div className="summary-item">
            <label>File Name:</label>
            <span>{importData.original_filename}</span>
          </div>
          
          <div className="summary-item">
            <label>File Type:</label>
            <span>{importData.file_type.toUpperCase()}</span>
          </div>
          
          <div className="summary-item">
            <label>File Size:</label>
            <span>{importService.formatFileSize(importData.file_size)}</span>
          </div>
          
          <div className="summary-item">
            <label>Content Type:</label>
            <span>{importData.content_type || 'Unknown'}</span>
          </div>
          
          <div className="summary-item">
            <label>Status:</label>
            <span className={`status-badge status-${importData.status}`}>
              {importService.getStatusText(importData.status)}
            </span>
          </div>
          
          <div className="summary-item">
            <label>Uploaded:</label>
            <span>{formatDate(importData.created_at)}</span>
          </div>
          
          {importData.processing_progress > 0 && (
            <div className="summary-item">
              <label>Progress:</label>
              <div className="progress-container">
                <div className="progress-bar">
                  <div 
                    className="progress-fill" 
                    style={{ width: `${importData.processing_progress}%` }}
                  />
                </div>
                <span>{importData.processing_progress}%</span>
              </div>
            </div>
          )}
        </div>

        {importData.error_message && (
          <div className="error-section">
            <h4>Error Details</h4>
            <div className="error-message">{importData.error_message}</div>
          </div>
        )}
      </div>

      {importData.extracted_text && (
        <div className="content-section">
          <div className="content-header">
            <h3>Extracted Content</h3>
            <div className="content-controls">
              <button
                className={`view-toggle ${!showRawText ? 'active' : ''}`}
                onClick={() => setShowRawText(false)}
              >
                Structured View
              </button>
              <button
                className={`view-toggle ${showRawText ? 'active' : ''}`}
                onClick={() => setShowRawText(true)}
              >
                Raw Text
              </button>
            </div>
          </div>

          {showRawText ? (
            <div className="raw-text-view">
              <pre className="raw-text">{importData.extracted_text}</pre>
            </div>
          ) : (
            <div className="structured-view">
              {renderStructuredContent()}
            </div>
          )}
        </div>
      )}

      {importData.status === 'reviewing' && (
        <div className="review-section">
          <h3>Review & Approve</h3>
          
          <div className="review-form">
            <div className="review-notes">
              <label htmlFor="review-notes">Review Notes (Optional):</label>
              <textarea
                id="review-notes"
                value={reviewNotes}
                onChange={(e) => setReviewNotes(e.target.value)}
                placeholder="Add any notes about this import..."
                rows={4}
              />
            </div>

            <div className="review-actions">
              <button
                className="approve-button"
                onClick={() => onApprove(importData.id, reviewNotes)}
              >
                ✅ Approve & Publish
              </button>
              
              <button
                className="reject-button"
                onClick={() => {
                  if (reviewNotes.trim()) {
                    onReject(importData.id, reviewNotes);
                  } else {
                    alert('Please provide rejection notes');
                  }
                }}
              >
                ❌ Reject
              </button>
            </div>
          </div>
        </div>
      )}

      {importData.review_notes && (
        <div className="existing-notes">
          <h4>Previous Review Notes</h4>
          <div className="notes-content">{importData.review_notes}</div>
          {importData.approved_at && (
            <div className="review-timestamp">
              Reviewed on {formatDate(importData.approved_at)}
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default ImportDetail;