import React, { useState, useEffect, useRef, useCallback } from 'react';
import {
  Card,
  Button,
  Space,
  Typography,
  Modal,
  Tooltip,
  message,
  Slider,
  Drawer,
  List,
  Tag,
  Progress,
  Spin,
  Row,
  Col,
  Affix,
  BackTop
} from 'antd';
import {
  PlayCircleOutlined,
  PauseCircleOutlined,
  TagOutlined,
  HighlightOutlined,
  FontSizeOutlined,
  SoundOutlined,
  EyeOutlined,
  ClockCircleOutlined,
  FileTextOutlined,
  SettingOutlined,
  BookOutlined
} from '@ant-design/icons';
import AudioReader from './AudioReader';
import './ReadingInterface.css';

const { Title, Text, Paragraph } = Typography;

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
}

interface WordDefinition {
  word: string;
  phonetic?: string;
  definition: string;
  part_of_speech?: string;
  example?: string;
}

interface Bookmark {
  position: number;
  title: string;
  created_at: string;
}

interface ReadingSession {
  id: number;
  start_time: string;
  reading_duration: number;
  completion_percentage: number;
  bookmarks: Bookmark[];
}

interface ReadingInterfaceProps {
  article: Article;
  onReadingComplete?: (session: ReadingSession) => void;
  onWordLookup?: (word: string, context: string, position: number) => void;
}

const ReadingInterface: React.FC<ReadingInterfaceProps> = ({
  article,
  onReadingComplete,
  onWordLookup
}) => {
  // State management
  const [fontSize, setFontSize] = useState(16);
  const [lineHeight, setLineHeight] = useState(1.6);
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentWord, setCurrentWord] = useState('');
  const [highlightedWord, setHighlightedWord] = useState('');
  const [selectedText, setSelectedText] = useState('');
  const [definitionModalVisible, setDefinitionModalVisible] = useState(false);
  const [settingsDrawerVisible, setSettingsDrawerVisible] = useState(false);
  const [bookmarksDrawerVisible, setBookmarksDrawerVisible] = useState(false);
  const [wordDefinition, setWordDefinition] = useState<WordDefinition | null>(null);
  const [loading, setLoading] = useState(false);
  const [readingProgress, setReadingProgress] = useState(0);
  const [readingTime, setReadingTime] = useState(0);
  const [bookmarks, setBookmarks] = useState<Bookmark[]>([]);
  const [sessionId, setSessionId] = useState<number | null>(null);
  const [audioMode, setAudioMode] = useState(false);
  const [currentHighlightedWord, setCurrentHighlightedWord] = useState('');
  const [currentHighlightedSentence, setCurrentHighlightedSentence] = useState('');

  // Refs
  const contentRef = useRef<HTMLDivElement>(null);
  const startTimeRef = useRef<Date>(new Date());
  const progressIntervalRef = useRef<NodeJS.Timeout | null>(null);

  // Initialize reading session
  useEffect(() => {
    initializeReadingSession();
    startProgressTracking();

    return () => {
      if (progressIntervalRef.current) {
        clearInterval(progressIntervalRef.current);
      }
      endReadingSession();
    };
  }, [article.id]);

  const initializeReadingSession = async () => {
    try {
      const response = await fetch('/api/reading/sessions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        },
        body: JSON.stringify({
          article_id: article.id
        })
      });

      if (response.ok) {
        const data = await response.json();
        setSessionId(data.session_id);
        setBookmarks(data.bookmarks || []);
      }
    } catch (error) {
      console.error('Error initializing reading session:', error);
    }
  };

  const startProgressTracking = () => {
    progressIntervalRef.current = setInterval(() => {
      updateReadingProgress();
      setReadingTime(prev => prev + 1);
    }, 1000);
  };

  const updateReadingProgress = () => {
    if (!contentRef.current) return;

    const element = contentRef.current;
    const scrollTop = element.scrollTop;
    const scrollHeight = element.scrollHeight;
    const clientHeight = element.clientHeight;
    
    const progress = Math.min(
      Math.round((scrollTop / (scrollHeight - clientHeight)) * 100),
      100
    );
    
    setReadingProgress(progress);
  };

  const endReadingSession = async () => {
    if (!sessionId) return;

    try {
      await fetch(`/api/reading/sessions/${sessionId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        },
        body: JSON.stringify({
          reading_duration: readingTime,
          completion_percentage: readingProgress,
          status: 'completed'
        })
      });
    } catch (error) {
      console.error('Error ending reading session:', error);
    }
  };

  const handleWordClick = useCallback(async (event: React.MouseEvent) => {
    const target = event.target as HTMLElement;
    const word = target.textContent?.trim();
    
    if (!word || word.length < 2) return;

    // Clean word (remove punctuation)
    const cleanWord = word.replace(/[^\w]/g, '').toLowerCase();
    
    if (!cleanWord) return;

    setLoading(true);
    setCurrentWord(cleanWord);
    setHighlightedWord(cleanWord);

    try {
      // Get word definition
      const response = await fetch(`/api/dictionary/definition/${cleanWord}`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
      });
      const data = await response.json();

      if (response.ok && data.success) {
        setWordDefinition(data.data);
        setDefinitionModalVisible(true);

        // Track word lookup
        if (onWordLookup) {
          const position = getWordPosition(target);
          const context = getContextSentence(target);
          onWordLookup(cleanWord, context, position);
        }
      } else {
        message.warning('Definition not found for this word');
      }
    } catch (error) {
      message.error('Error fetching word definition');
    } finally {
      setLoading(false);
    }
  }, [onWordLookup]);

  const getWordPosition = (element: HTMLElement): number => {
    if (!contentRef.current) return 0;

    const range = document.createRange();
    range.setStart(contentRef.current, 0);
    range.setEnd(element, 0);
    
    return range.toString().length;
  };

  const getContextSentence = (element: HTMLElement): string => {
    const text = element.parentElement?.textContent || '';
    const sentences = text.split(/[.!?]+/);
    
    // Find the sentence containing the clicked word
    for (const sentence of sentences) {
      if (sentence.includes(element.textContent || '')) {
        return sentence.trim();
      }
    }
    
    return text.substring(0, 100) + '...';
  };

  const handleAddBookmark = async () => {
    if (!sessionId) return;

    const position = readingProgress;
    const title = `Bookmark at ${position}%`;

    try {
      const response = await fetch(`/api/reading/sessions/${sessionId}/bookmarks`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        },
        body: JSON.stringify({
          position,
          title
        })
      });

      if (response.ok) {
        const newBookmark = await response.json();
        setBookmarks(prev => [...prev, newBookmark]);
        message.success('Bookmark added successfully');
      }
    } catch (error) {
      message.error('Error adding bookmark');
    }
  };

  const handleGoToBookmark = (bookmark: Bookmark) => {
    if (!contentRef.current) return;

    const element = contentRef.current;
    const targetPosition = (bookmark.position / 100) * element.scrollHeight;
    
    element.scrollTo({
      top: targetPosition,
      behavior: 'smooth'
    });
    
    setBookmarksDrawerVisible(false);
  };

  const handleTextSelection = () => {
    const selection = window.getSelection();
    if (selection && selection.toString().trim()) {
      setSelectedText(selection.toString().trim());
    }
  };

  const handleHighlightText = () => {
    if (!selectedText) return;

    // Create highlight annotation
    const selection = window.getSelection();
    if (selection && selection.rangeCount > 0) {
      const range = selection.getRangeAt(0);
      const span = document.createElement('span');
      span.className = 'highlighted-text';
      span.style.backgroundColor = '#fff3cd';
      span.style.padding = '2px 4px';
      span.style.borderRadius = '3px';
      
      try {
        range.surroundContents(span);
        selection.removeAllRanges();
        message.success('Text highlighted');
      } catch (error) {
        message.warning('Cannot highlight this selection');
      }
    }
    
    setSelectedText('');
  };

  const formatTime = (seconds: number): string => {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  // Audio reading callback functions
  const handleWordHighlight = useCallback((word: string, startTime: number, endTime: number) => {
    setCurrentHighlightedWord(word);
    
    // Track word lookup for analytics
    if (onWordLookup && sessionId) {
      onWordLookup(word, currentHighlightedSentence, Math.round(startTime * 1000));
    }
  }, [onWordLookup, sessionId, currentHighlightedSentence]);

  const handleSentenceHighlight = useCallback((sentence: string, startTime: number, endTime: number) => {
    setCurrentHighlightedSentence(sentence);
  }, []);

  const handleAudioPlaybackChange = useCallback((isPlaying: boolean, currentTime: number) => {
    setIsPlaying(isPlaying);
    
    // Update reading progress based on audio time
    if (article.estimated_reading_time > 0) {
      const estimatedTotalSeconds = article.estimated_reading_time * 60;
      const progress = Math.min((currentTime / estimatedTotalSeconds) * 100, 100);
      setReadingProgress(Math.round(progress));
    }
  }, [article.estimated_reading_time]);

  const renderContent = () => {
    if (!article.content) return null;

    // Split content into clickable words
    const words = article.content.split(/(\s+)/);
    
    return words.map((word, index) => {
      if (/^\s+$/.test(word)) {
        return word; // Return whitespace as-is
      }
      
      return (
        <span
          key={index}
          className={`clickable-word ${highlightedWord && word.toLowerCase().includes(highlightedWord) ? 'highlighted' : ''}`}
          onClick={handleWordClick}
        >
          {word}
        </span>
      );
    });
  };

  return (
    <div className="reading-interface">
      {/* Header */}
      <Card className="reading-header">
        <Row justify="space-between" align="middle">
          <Col span={16}>
            <Title level={3} style={{ margin: 0 }}>
              {article.title}
            </Title>
            <Space>
              {article.author && (
                <Text type="secondary">By {article.author}</Text>
              )}
              <Text type="secondary">
                <FileTextOutlined /> {article.word_count} words
              </Text>
              <Text type="secondary">
                <ClockCircleOutlined /> {article.estimated_reading_time} min
              </Text>
              <Text type="secondary">
                Grade {article.grade_level} | Difficulty {article.difficulty}
              </Text>
            </Space>
          </Col>
          <Col span={8}>
            <Space style={{ float: 'right' }}>
              <Tooltip title="Reading Time">
                <Text>{formatTime(readingTime)}</Text>
              </Tooltip>
              <Progress
                type="circle"
                size={40}
                percent={readingProgress}
                showInfo={false}
              />
            </Space>
          </Col>
        </Row>
      </Card>

      {/* Main Content */}
      <div className="reading-content-container">
        <Row gutter={24}>
          <Col span={18}>
            <Card className="reading-content-card">
              {/* Toolbar */}
              <Affix offsetTop={80}>
                <div className="reading-toolbar">
                  <Space>
                    <Tooltip title={audioMode ? "Switch to Reading Mode" : "Switch to Audio Mode"}>
                      <Button
                        icon={<SoundOutlined />}
                        onClick={() => setAudioMode(!audioMode)}
                        type={audioMode ? 'primary' : 'default'}
                      >
                        {audioMode ? 'Audio' : 'Read'}
                      </Button>
                    </Tooltip>
                    <Tooltip title="Add Bookmark">
                      <Button
                        icon={<TagOutlined />}
                        onClick={handleAddBookmark}
                      />
                    </Tooltip>
                    <Tooltip title="Highlight Selection">
                      <Button
                        icon={<HighlightOutlined />}
                        onClick={handleHighlightText}
                        disabled={!selectedText}
                      />
                    </Tooltip>
                    <Tooltip title="Font Settings">
                      <Button
                        icon={<FontSizeOutlined />}
                        onClick={() => setSettingsDrawerVisible(true)}
                      />
                    </Tooltip>
                    <Tooltip title="Bookmarks">
                      <Button
                        icon={<BookOutlined />}
                        onClick={() => setBookmarksDrawerVisible(true)}
                      />
                    </Tooltip>
                  </Space>
                </div>
              </Affix>

              {/* Article Content */}
              <div
                ref={contentRef}
                className="article-content"
                style={{
                  fontSize: `${fontSize}px`,
                  lineHeight: lineHeight
                }}
                onMouseUp={handleTextSelection}
                onScroll={!audioMode ? updateReadingProgress : undefined}
              >
                <Spin spinning={loading}>
                  {article.summary && (
                    <div className="article-summary">
                      <Title level={5}>Summary</Title>
                      <Paragraph>{article.summary}</Paragraph>
                    </div>
                  )}
                  
                  <div className="article-text">
                    {audioMode ? (
                      <AudioReader
                        content={article.content}
                        onWordHighlight={handleWordHighlight}
                        onSentenceHighlight={handleSentenceHighlight}
                        onPlaybackStateChange={handleAudioPlaybackChange}
                        voice="af_bella"
                        provider="kokoro"
                        autoPlay={false}
                        showControls={true}
                        highlightMode="both"
                      />
                    ) : (
                      renderContent()
                    )}
                  </div>
                </Spin>
              </div>
            </Card>
          </Col>

          <Col span={6}>
            <Card title={audioMode ? "Audio Progress" : "Reading Progress"} size="small">
              <Space direction="vertical" style={{ width: '100%' }}>
                <div>
                  <Text>Progress: {readingProgress}%</Text>
                  <Progress percent={readingProgress} size="small" />
                </div>
                <div>
                  <Text>{audioMode ? "Listening Time" : "Reading Time"}: {formatTime(readingTime)}</Text>
                </div>
                <div>
                  <Text>Estimated Remaining: {formatTime(
                    Math.max(0, (article.estimated_reading_time * 60) - readingTime)
                  )}</Text>
                </div>
                {audioMode && currentHighlightedWord && (
                  <div>
                    <Text type="secondary">Current Word: </Text>
                    <Text strong>{currentHighlightedWord}</Text>
                  </div>
                )}
                {audioMode && (
                  <div>
                    <Text type="secondary">Mode: </Text>
                    <Text>Audio Reading with Sync Highlighting</Text>
                  </div>
                )}
              </Space>
            </Card>

            {article.tags && article.tags.length > 0 && (
              <Card title="Tags" size="small" style={{ marginTop: 16 }}>
                <Space wrap>
                  {article.tags.map((tag, index) => (
                    <Tag key={index} color="blue">{tag}</Tag>
                  ))}
                </Space>
              </Card>
            )}
          </Col>
        </Row>
      </div>

      {/* Word Definition Modal */}
      <Modal
        title={
          <Space>
            <SoundOutlined />
            {wordDefinition?.word}
            {wordDefinition?.phonetic && (
              <Text type="secondary">{wordDefinition.phonetic}</Text>
            )}
          </Space>
        }
        open={definitionModalVisible}
        onCancel={() => setDefinitionModalVisible(false)}
        footer={[
          <Button key="close" onClick={() => setDefinitionModalVisible(false)}>
            Close
          </Button>
        ]}
      >
        {wordDefinition && (
          <div>
            {wordDefinition.part_of_speech && (
              <Tag color="blue">{wordDefinition.part_of_speech}</Tag>
            )}
            <Paragraph style={{ marginTop: 16 }}>
              <strong>Definition:</strong> {wordDefinition.definition}
            </Paragraph>
            {wordDefinition.example && (
              <Paragraph>
                <strong>Example:</strong> <em>{wordDefinition.example}</em>
              </Paragraph>
            )}
          </div>
        )}
      </Modal>

      {/* Settings Drawer */}
      <Drawer
        title="Reading Settings"
        placement="right"
        onClose={() => setSettingsDrawerVisible(false)}
        open={settingsDrawerVisible}
        width={320}
      >
        <Space direction="vertical" style={{ width: '100%' }}>
          <div>
            <Text strong>Font Size: {fontSize}px</Text>
            <Slider
              min={12}
              max={24}
              value={fontSize}
              onChange={setFontSize}
              marks={{
                12: '12px',
                16: '16px',
                20: '20px',
                24: '24px'
              }}
            />
          </div>
          
          <div>
            <Text strong>Line Height: {lineHeight}</Text>
            <Slider
              min={1.2}
              max={2.0}
              step={0.1}
              value={lineHeight}
              onChange={setLineHeight}
              marks={{
                1.2: '1.2',
                1.6: '1.6',
                2.0: '2.0'
              }}
            />
          </div>
        </Space>
      </Drawer>

      {/* Bookmarks Drawer */}
      <Drawer
        title="Bookmarks"
        placement="right"
        onClose={() => setBookmarksDrawerVisible(false)}
        open={bookmarksDrawerVisible}
        width={320}
      >
        <List
          dataSource={bookmarks}
          renderItem={(bookmark) => (
            <List.Item
              actions={[
                <Button
                  type="link"
                  icon={<EyeOutlined />}
                  onClick={() => handleGoToBookmark(bookmark)}
                >
                  Go to
                </Button>
              ]}
            >
              <List.Item.Meta
                title={bookmark.title}
                description={`Position: ${bookmark.position}%`}
              />
            </List.Item>
          )}
          locale={{ emptyText: 'No bookmarks yet' }}
        />
      </Drawer>

      <BackTop />
    </div>
  );
};

export default ReadingInterface;