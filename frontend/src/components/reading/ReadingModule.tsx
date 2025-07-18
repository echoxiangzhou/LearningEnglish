import React, { useState, useEffect } from 'react';
import { Card, Button, Space, message, Modal, Result } from 'antd';
import { ArrowLeftOutlined, BookOutlined, TrophyOutlined } from '@ant-design/icons';
import ArticleSelector from './ArticleSelector';
import ReadingInterface from './ReadingInterface';
import './ReadingModule.css';

// Define types
interface Article {
  id: number;
  title: string;
  content: string;
  summary?: string;
  author?: string;
  topic?: string;
  grade_level: number;
  difficulty: number;
  word_count: number;
  estimated_reading_time: number;
  tags: string[];
  questions?: Question[];
}

interface Question {
  id: number;
  question_text: string;
  question_type: 'multiple_choice' | 'true_false' | 'short_answer';
  options?: string[];
  correct_answer: string;
  explanation?: string;
  difficulty: number;
  order_index: number;
}

interface ReadingSession {
  id: number;
  start_time: string;
  reading_duration: number;
  completion_percentage: number;
  comprehension_score?: number;
  bookmarks: any[];
}

interface ReadingModuleProps {
  showUserProgress?: boolean;
}

const ReadingModule: React.FC<ReadingModuleProps> = ({ 
  showUserProgress = true 
}) => {
  // State management
  const [currentView, setCurrentView] = useState<'selector' | 'reading' | 'questions' | 'complete'>('selector');
  const [selectedArticle, setSelectedArticle] = useState<Article | null>(null);
  const [readingSession, setReadingSession] = useState<ReadingSession | null>(null);
  const [sessionStats, setSessionStats] = useState({
    wordsRead: 0,
    readingSpeed: 0,
    comprehensionScore: 0,
    timeSpent: 0
  });
  const [completionModalVisible, setCompletionModalVisible] = useState(false);

  // Handle article selection
  const handleSelectArticle = async (article: Article) => {
    try {
      // Load full article with questions
      const response = await fetch(`/api/articles/${article.id}`);
      const fullArticle = await response.json();

      if (response.ok) {
        setSelectedArticle(fullArticle);
        setCurrentView('reading');
      } else {
        message.error('Failed to load article');
      }
    } catch (error) {
      message.error('Error loading article');
      console.error('Error loading article:', error);
    }
  };

  // Handle word lookup tracking
  const handleWordLookup = async (word: string, context: string, position: number) => {
    if (!readingSession || !selectedArticle) return;

    try {
      await fetch('/api/reading/word-lookups', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        },
        body: JSON.stringify({
          reading_session_id: readingSession.id,
          word,
          context_sentence: context,
          article_position: position
        })
      });
    } catch (error) {
      console.error('Error tracking word lookup:', error);
    }
  };

  // Handle reading completion
  const handleReadingComplete = async (session: ReadingSession) => {
    setReadingSession(session);
    
    if (selectedArticle?.questions && selectedArticle.questions.length > 0) {
      setCurrentView('questions');
    } else {
      await completeReadingSession(session);
    }
  };

  // Complete reading session and show results
  const completeReadingSession = async (session: ReadingSession) => {
    if (!selectedArticle) return;

    try {
      // Calculate statistics
      const wordsRead = selectedArticle.word_count;
      const timeSpentMinutes = session.reading_duration / 60;
      const readingSpeed = Math.round(wordsRead / timeSpentMinutes);

      setSessionStats({
        wordsRead,
        readingSpeed,
        comprehensionScore: session.comprehension_score || 0,
        timeSpent: session.reading_duration
      });

      setCurrentView('complete');
      setCompletionModalVisible(true);

    } catch (error) {
      console.error('Error completing reading session:', error);
      message.error('Error saving reading progress');
    }
  };

  // Handle back to selector
  const handleBackToSelector = () => {
    setCurrentView('selector');
    setSelectedArticle(null);
    setReadingSession(null);
    setSessionStats({
      wordsRead: 0,
      readingSpeed: 0,
      comprehensionScore: 0,
      timeSpent: 0
    });
  };

  // Handle start new reading
  const handleStartNewReading = () => {
    setCompletionModalVisible(false);
    handleBackToSelector();
  };

  // Format time display
  const formatTime = (seconds: number): string => {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  // Render current view
  const renderCurrentView = () => {
    switch (currentView) {
      case 'selector':
        return (
          <ArticleSelector
            onSelectArticle={handleSelectArticle}
            showUserProgress={showUserProgress}
          />
        );

      case 'reading':
        if (!selectedArticle) return null;
        return (
          <div className="reading-view">
            <div className="reading-header">
              <Button
                icon={<ArrowLeftOutlined />}
                onClick={handleBackToSelector}
                style={{ marginBottom: 16 }}
              >
                Back to Library
              </Button>
            </div>
            <ReadingInterface
              article={selectedArticle}
              onReadingComplete={handleReadingComplete}
              onWordLookup={handleWordLookup}
            />
          </div>
        );

      case 'questions':
        // This would render the comprehension questions component
        // For now, we'll redirect to complete
        setTimeout(() => {
          if (readingSession) {
            completeReadingSession(readingSession);
          }
        }, 1000);
        return (
          <Card style={{ textAlign: 'center', margin: '50px auto', maxWidth: 600 }}>
            <h3>Loading Comprehension Questions...</h3>
            <p>Preparing questions for {selectedArticle?.title}</p>
          </Card>
        );

      case 'complete':
        return (
          <Result
            icon={<TrophyOutlined style={{ color: '#52c41a' }} />}
            title="Reading Complete!"
            subTitle={`Great job reading "${selectedArticle?.title}"`}
            extra={[
              <div key="stats" className="completion-stats">
                <Card title="Reading Statistics" style={{ marginBottom: 24 }}>
                  <div className="stats-grid">
                    <div className="stat-item">
                      <div className="stat-value">{sessionStats.wordsRead}</div>
                      <div className="stat-label">Words Read</div>
                    </div>
                    <div className="stat-item">
                      <div className="stat-value">{formatTime(sessionStats.timeSpent)}</div>
                      <div className="stat-label">Time Spent</div>
                    </div>
                    <div className="stat-item">
                      <div className="stat-value">{sessionStats.readingSpeed}</div>
                      <div className="stat-label">Words/Minute</div>
                    </div>
                    {sessionStats.comprehensionScore > 0 && (
                      <div className="stat-item">
                        <div className="stat-value">{sessionStats.comprehensionScore}%</div>
                        <div className="stat-label">Comprehension</div>
                      </div>
                    )}
                  </div>
                </Card>
                <Space>
                  <Button type="primary" onClick={handleStartNewReading}>
                    Read Another Article
                  </Button>
                  <Button onClick={handleBackToSelector}>
                    Back to Library
                  </Button>
                </Space>
              </div>
            ]}
          />
        );

      default:
        return null;
    }
  };

  return (
    <div className="reading-module">
      {renderCurrentView()}

      {/* Completion Modal */}
      <Modal
        title="Reading Session Complete!"
        open={completionModalVisible}
        onCancel={() => setCompletionModalVisible(false)}
        footer={[
          <Button key="library" onClick={handleBackToSelector}>
            Back to Library
          </Button>,
          <Button key="new" type="primary" onClick={handleStartNewReading}>
            Read Another Article
          </Button>
        ]}
        width={600}
        centered
      >
        <div className="modal-completion-content">
          <div className="completion-message">
            <TrophyOutlined style={{ fontSize: 48, color: '#52c41a', marginBottom: 16 }} />
            <h3>Excellent Work!</h3>
            <p>You've successfully completed reading "{selectedArticle?.title}"</p>
          </div>

          <div className="completion-stats-modal">
            <div className="stats-row">
              <div className="stat-card">
                <div className="stat-number">{sessionStats.wordsRead}</div>
                <div className="stat-text">Words Read</div>
              </div>
              <div className="stat-card">
                <div className="stat-number">{formatTime(sessionStats.timeSpent)}</div>
                <div className="stat-text">Reading Time</div>
              </div>
            </div>
            <div className="stats-row">
              <div className="stat-card">
                <div className="stat-number">{sessionStats.readingSpeed}</div>
                <div className="stat-text">WPM</div>
              </div>
              {sessionStats.comprehensionScore > 0 && (
                <div className="stat-card">
                  <div className="stat-number">{sessionStats.comprehensionScore}%</div>
                  <div className="stat-text">Score</div>
                </div>
              )}
            </div>
          </div>

          <div className="completion-encouragement">
            <p>Keep up the great work! Regular reading improves vocabulary, comprehension, and critical thinking skills.</p>
          </div>
        </div>
      </Modal>
    </div>
  );
};

export default ReadingModule;