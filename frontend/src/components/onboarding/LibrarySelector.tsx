import React, { useState, useEffect } from 'react';
import { Card, Button, Checkbox, List, Typography, Divider, Space, Tag, Alert, Spin } from 'antd';
import { BookOutlined, ReadOutlined, SoundOutlined, UserOutlined } from '@ant-design/icons';
import './LibrarySelector.css';

const { Title, Text, Paragraph } = Typography;

interface VocabularyLibrary {
  id: number;
  library_id: string;
  name: string;
  description: string;
  grade_level: number;
  total_words: number;
  difficulty_range: string;
  categories: string[];
  tags: string[];
}

interface SentenceCategory {
  id: string;
  name: string;
  description: string;
}

interface ReadingLibrary {
  id: string;
  topic: string;
  grade_level: number;
  name: string;
  description: string;
  article_count: number;
  average_difficulty: number;
}

interface LibraryData {
  vocabulary_libraries: Record<string, VocabularyLibrary[]>;
  sentence_categories: SentenceCategory[];
  reading_libraries: ReadingLibrary[];
}

interface LibrarySelectorProps {
  onComplete: (selections: {
    vocabulary_libraries: number[];
    sentence_categories: string[];
    reading_libraries: string[];
  }) => void;
  loading?: boolean;
}

const LibrarySelector: React.FC<LibrarySelectorProps> = ({ onComplete, loading = false }) => {
  const [libraryData, setLibraryData] = useState<LibraryData | null>(null);
  const [selectedVocab, setSelectedVocab] = useState<number[]>([]);
  const [selectedSentences, setSelectedSentences] = useState<string[]>([]);
  const [selectedReading, setSelectedReading] = useState<string[]>([]);
  const [dataLoading, setDataLoading] = useState(true);
  const [error, setError] = useState<string>('');

  useEffect(() => {
    fetchLibraryData();
  }, []);

  const fetchLibraryData = async () => {
    try {
      const token = localStorage.getItem('access_token');
      const response = await fetch('/api/onboarding/libraries', {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      });

      if (!response.ok) {
        throw new Error('Failed to fetch library data');
      }

      const data = await response.json();
      setLibraryData(data);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load libraries');
    } finally {
      setDataLoading(false);
    }
  };

  const handleVocabSelection = (libraryId: number, checked: boolean) => {
    if (checked) {
      setSelectedVocab([...selectedVocab, libraryId]);
    } else {
      setSelectedVocab(selectedVocab.filter(id => id !== libraryId));
    }
  };

  const handleSentenceSelection = (categoryId: string, checked: boolean) => {
    if (checked) {
      setSelectedSentences([...selectedSentences, categoryId]);
    } else {
      setSelectedSentences(selectedSentences.filter(id => id !== categoryId));
    }
  };

  const handleReadingSelection = (libraryId: string, checked: boolean) => {
    if (checked) {
      setSelectedReading([...selectedReading, libraryId]);
    } else {
      setSelectedReading(selectedReading.filter(id => id !== libraryId));
    }
  };

  const handleComplete = () => {
    if (selectedVocab.length === 0 && selectedSentences.length === 0 && selectedReading.length === 0) {
      setError('Please select at least one library to continue');
      return;
    }

    onComplete({
      vocabulary_libraries: selectedVocab,
      sentence_categories: selectedSentences,
      reading_libraries: selectedReading
    });
  };

  const renderVocabularyLibraries = () => {
    if (!libraryData?.vocabulary_libraries) return null;

    return Object.entries(libraryData.vocabulary_libraries).map(([type, libraries]) => (
      <div key={type} className="library-type-section">
        <Title level={4} className="library-type-title">
          <BookOutlined /> {type.replace('_', ' ').toUpperCase()} Libraries
        </Title>
        <List
          grid={{ gutter: 16, xs: 1, sm: 2, md: 2, lg: 3, xl: 3 }}
          dataSource={libraries}
          renderItem={(library) => (
            <List.Item>
              <Card
                size="small"
                className={selectedVocab.includes(library.id) ? 'library-card selected' : 'library-card'}
                onClick={() => handleVocabSelection(library.id, !selectedVocab.includes(library.id))}
              >
                <div className="library-card-header">
                  <Checkbox
                    checked={selectedVocab.includes(library.id)}
                    onChange={(e) => handleVocabSelection(library.id, e.target.checked)}
                    onClick={(e) => e.stopPropagation()}
                  />
                  <Title level={5} className="library-title">{library.name}</Title>
                </div>
                <Paragraph className="library-description">{library.description}</Paragraph>
                <div className="library-stats">
                  <Text type="secondary">Grade {library.grade_level}</Text>
                  <Text type="secondary">• {library.total_words} words</Text>
                  {library.difficulty_range && (
                    <Text type="secondary">• Difficulty: {library.difficulty_range}</Text>
                  )}
                </div>
                {library.categories && library.categories.length > 0 && (
                  <div className="library-tags">
                    {library.categories.slice(0, 3).map((category, index) => (
                      <Tag key={index} size="small">{category}</Tag>
                    ))}
                    {library.categories.length > 3 && (
                      <Tag size="small">+{library.categories.length - 3} more</Tag>
                    )}
                  </div>
                )}
              </Card>
            </List.Item>
          )}
        />
      </div>
    ));
  };

  const renderSentenceCategories = () => {
    if (!libraryData?.sentence_categories?.length) return null;

    return (
      <div className="library-type-section">
        <Title level={4} className="library-type-title">
          <SoundOutlined /> Sentence Practice Categories
        </Title>
        <List
          grid={{ gutter: 16, xs: 1, sm: 2, md: 3, lg: 4, xl: 4 }}
          dataSource={libraryData.sentence_categories}
          renderItem={(category) => (
            <List.Item>
              <Card
                size="small"
                className={selectedSentences.includes(category.id) ? 'library-card selected' : 'library-card'}
                onClick={() => handleSentenceSelection(category.id, !selectedSentences.includes(category.id))}
              >
                <div className="library-card-header">
                  <Checkbox
                    checked={selectedSentences.includes(category.id)}
                    onChange={(e) => handleSentenceSelection(category.id, e.target.checked)}
                    onClick={(e) => e.stopPropagation()}
                  />
                  <Title level={5} className="library-title">{category.name}</Title>
                </div>
                <Paragraph className="library-description">{category.description}</Paragraph>
              </Card>
            </List.Item>
          )}
        />
      </div>
    );
  };

  const renderReadingLibraries = () => {
    if (!libraryData?.reading_libraries?.length) return null;

    return (
      <div className="library-type-section">
        <Title level={4} className="library-type-title">
          <ReadOutlined /> Reading Comprehension Libraries
        </Title>
        <List
          grid={{ gutter: 16, xs: 1, sm: 2, md: 2, lg: 3, xl: 3 }}
          dataSource={libraryData.reading_libraries}
          renderItem={(library) => (
            <List.Item>
              <Card
                size="small"
                className={selectedReading.includes(library.id) ? 'library-card selected' : 'library-card'}
                onClick={() => handleReadingSelection(library.id, !selectedReading.includes(library.id))}
              >
                <div className="library-card-header">
                  <Checkbox
                    checked={selectedReading.includes(library.id)}
                    onChange={(e) => handleReadingSelection(library.id, e.target.checked)}
                    onClick={(e) => e.stopPropagation()}
                  />
                  <Title level={5} className="library-title">{library.name}</Title>
                </div>
                <Paragraph className="library-description">{library.description}</Paragraph>
                <div className="library-stats">
                  <Text type="secondary">Grade {library.grade_level}</Text>
                  <Text type="secondary">• {library.article_count} articles</Text>
                  {library.average_difficulty && (
                    <Text type="secondary">• Avg. Difficulty: {library.average_difficulty}/5</Text>
                  )}
                </div>
              </Card>
            </List.Item>
          )}
        />
      </div>
    );
  };

  if (dataLoading) {
    return (
      <div className="library-selector-loading">
        <Spin size="large" />
        <Title level={4}>Loading available libraries...</Title>
      </div>
    );
  }

  if (error) {
    return (
      <Alert
        message="Error Loading Libraries"
        description={error}
        type="error"
        showIcon
        action={
          <Button onClick={fetchLibraryData} type="primary" size="small">
            Retry
          </Button>
        }
      />
    );
  }

  return (
    <div className="library-selector">
      <div className="library-selector-header">
        <Title level={2}>
          <UserOutlined /> Choose Your Learning Libraries
        </Title>
        <Paragraph>
          Select the vocabulary, sentence practice, and reading materials that match your learning goals.
          You can always modify your selections later in your profile.
        </Paragraph>
      </div>

      {error && (
        <Alert
          message={error}
          type="error"
          showIcon
          closable
          onClose={() => setError('')}
          style={{ marginBottom: 24 }}
        />
      )}

      <div className="library-sections">
        {renderVocabularyLibraries()}
        <Divider />
        {renderSentenceCategories()}
        <Divider />
        {renderReadingLibraries()}
      </div>

      <div className="library-selector-footer">
        <div className="selection-summary">
          <Space>
            <Text strong>Selected:</Text>
            <Tag color="blue">{selectedVocab.length} Vocabulary</Tag>
            <Tag color="green">{selectedSentences.length} Sentences</Tag>
            <Tag color="orange">{selectedReading.length} Reading</Tag>
          </Space>
        </div>
        <Button
          type="primary"
          size="large"
          onClick={handleComplete}
          loading={loading}
          disabled={selectedVocab.length === 0 && selectedSentences.length === 0 && selectedReading.length === 0}
        >
          Complete Setup
        </Button>
      </div>
    </div>
  );
};

export default LibrarySelector;