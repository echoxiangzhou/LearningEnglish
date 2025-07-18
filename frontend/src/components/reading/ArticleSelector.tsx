import React, { useState, useEffect } from 'react';
import {
  Card,
  List,
  Button,
  Space,
  Tag,
  Typography,
  Input,
  Select,
  Row,
  Col,
  Avatar,
  Skeleton,
  Empty,
  Pagination,
  Tooltip,
  Badge,
  Rate,
  Progress
} from 'antd';
import {
  BookOutlined,
  ClockCircleOutlined,
  FileTextOutlined,
  UserOutlined,
  SearchOutlined,
  FilterOutlined,
  StarOutlined,
  ReadOutlined,
  RightOutlined
} from '@ant-design/icons';
import './ArticleSelector.css';

const { Title, Text, Paragraph } = Typography;
const { Option } = Select;

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
  is_published: boolean;
  created_at: string;
  user_progress?: {
    completion_percentage: number;
    comprehension_score: number;
    last_read: string;
  };
}

interface ArticleSelectorProps {
  onSelectArticle: (article: Article) => void;
  selectedArticleId?: number;
  showUserProgress?: boolean;
}

const ArticleSelector: React.FC<ArticleSelectorProps> = ({
  onSelectArticle,
  selectedArticleId,
  showUserProgress = false
}) => {
  // State management
  const [articles, setArticles] = useState<Article[]>([]);
  const [loading, setLoading] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [filters, setFilters] = useState({
    grade_level: null as number | null,
    difficulty: null as number | null,
    topic: '',
    completed: null as boolean | null
  });
  const [pagination, setPagination] = useState({
    current: 1,
    pageSize: 12,
    total: 0
  });
  const [metadata, setMetadata] = useState({
    grade_levels: [] as number[],
    difficulties: [] as number[],
    topics: [] as string[]
  });
  const [recommendations, setRecommendations] = useState<Article[]>([]);

  // Load articles on component mount and when filters change
  useEffect(() => {
    loadArticles();
  }, [pagination.current, searchTerm, filters]);

  useEffect(() => {
    loadMetadata();
    if (showUserProgress) {
      loadRecommendations();
    }
  }, []);

  const loadArticles = async () => {
    setLoading(true);
    try {
      const params = new URLSearchParams({
        page: pagination.current.toString(),
        per_page: pagination.pageSize.toString(),
        published_only: 'true',
        ...(searchTerm && { search: searchTerm }),
        ...(filters.grade_level && { grade_level: filters.grade_level.toString() }),
        ...(filters.difficulty && { difficulty: filters.difficulty.toString() }),
        ...(filters.topic && { topic: filters.topic })
      });

      const response = await fetch(`/api/articles?${params}`);
      const data = await response.json();

      if (response.ok) {
        setArticles(data.articles);
        setPagination(prev => ({
          ...prev,
          total: data.pagination.total
        }));
      }
    } catch (error) {
      console.error('Error loading articles:', error);
    } finally {
      setLoading(false);
    }
  };

  const loadMetadata = async () => {
    try {
      const response = await fetch('/api/articles/metadata');
      const data = await response.json();

      if (response.ok) {
        setMetadata(data);
      }
    } catch (error) {
      console.error('Error loading metadata:', error);
    }
  };

  const loadRecommendations = async () => {
    try {
      const response = await fetch('/api/articles/recommendations', {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
      });
      const data = await response.json();

      if (response.ok) {
        setRecommendations(data.articles || []);
      }
    } catch (error) {
      console.error('Error loading recommendations:', error);
    }
  };

  const handlePageChange = (page: number) => {
    setPagination(prev => ({ ...prev, current: page }));
  };

  const handleFilterChange = (key: string, value: any) => {
    setFilters(prev => ({ ...prev, [key]: value }));
    setPagination(prev => ({ ...prev, current: 1 }));
  };

  const getDifficultyColor = (difficulty: number): string => {
    const colors = ['green', 'blue', 'orange', 'red', 'purple'];
    return colors[difficulty - 1] || 'default';
  };

  const getDifficultyText = (difficulty: number): string => {
    const texts = ['Very Easy', 'Easy', 'Medium', 'Hard', 'Very Hard'];
    return texts[difficulty - 1] || 'Unknown';
  };

  const formatLastRead = (dateString: string): string => {
    const date = new Date(dateString);
    const now = new Date();
    const diffTime = Math.abs(now.getTime() - date.getTime());
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    
    if (diffDays === 1) return 'Yesterday';
    if (diffDays < 7) return `${diffDays} days ago`;
    if (diffDays < 30) return `${Math.ceil(diffDays / 7)} weeks ago`;
    return `${Math.ceil(diffDays / 30)} months ago`;
  };

  const renderArticleCard = (article: Article) => (
    <Card
      key={article.id}
      className={`article-card ${selectedArticleId === article.id ? 'selected' : ''}`}
      hoverable
      onClick={() => onSelectArticle(article)}
      actions={[
        <Button
          type="link"
          icon={<ReadOutlined />}
          onClick={(e) => {
            e.stopPropagation();
            onSelectArticle(article);
          }}
        >
          Read
        </Button>
      ]}
    >
      <Card.Meta
        avatar={
          <Avatar
            size={48}
            icon={<BookOutlined />}
            style={{
              backgroundColor: getDifficultyColor(article.difficulty),
              fontSize: '20px'
            }}
          />
        }
        title={
          <div className="article-title">
            <Text strong ellipsis>
              {article.title}
            </Text>
            {article.user_progress && (
              <Badge
                count={`${Math.round(article.user_progress.completion_percentage)}%`}
                style={{
                  backgroundColor: article.user_progress.completion_percentage === 100 ? '#52c41a' : '#1890ff'
                }}
              />
            )}
          </div>
        }
        description={
          <div className="article-description">
            {article.summary && (
              <Paragraph
                ellipsis={{ rows: 2, tooltip: article.summary }}
                style={{ marginBottom: 8 }}
              >
                {article.summary}
              </Paragraph>
            )}
            
            <Space wrap size="small">
              <Tag color={getDifficultyColor(article.difficulty)}>
                {getDifficultyText(article.difficulty)}
              </Tag>
              <Text type="secondary">
                <BookOutlined /> Grade {article.grade_level}
              </Text>
              <Text type="secondary">
                <FileTextOutlined /> {article.word_count} words
              </Text>
              <Text type="secondary">
                <ClockCircleOutlined /> {article.estimated_reading_time} min
              </Text>
            </Space>

            {article.author && (
              <div style={{ marginTop: 8 }}>
                <Text type="secondary">
                  <UserOutlined /> {article.author}
                </Text>
              </div>
            )}

            {article.topic && (
              <div style={{ marginTop: 8 }}>
                <Tag color="blue">{article.topic}</Tag>
              </div>
            )}

            {article.tags && article.tags.length > 0 && (
              <div style={{ marginTop: 8 }}>
                {article.tags.slice(0, 3).map((tag, index) => (
                  <Tag key={index} size="small">{tag}</Tag>
                ))}
                {article.tags.length > 3 && (
                  <Text type="secondary">+{article.tags.length - 3} more</Text>
                )}
              </div>
            )}

            {article.user_progress && (
              <div style={{ marginTop: 12 }}>
                <div style={{ marginBottom: 4 }}>
                  <Text type="secondary">Progress:</Text>
                  <Progress
                    percent={article.user_progress.completion_percentage}
                    size="small"
                    showInfo={false}
                  />
                </div>
                {article.user_progress.comprehension_score && (
                  <div style={{ marginBottom: 4 }}>
                    <Text type="secondary">Score: </Text>
                    <Rate
                      disabled
                      allowHalf
                      value={article.user_progress.comprehension_score / 20}
                      style={{ fontSize: 12 }}
                    />
                  </div>
                )}
                <Text type="secondary" style={{ fontSize: 11 }}>
                  Last read: {formatLastRead(article.user_progress.last_read)}
                </Text>
              </div>
            )}
          </div>
        }
      />
    </Card>
  );

  const renderRecommendations = () => {
    if (!showUserProgress || recommendations.length === 0) return null;

    return (
      <Card
        title={
          <Space>
            <StarOutlined style={{ color: '#faad14' }} />
            Recommended for You
          </Space>
        }
        className="recommendations-card"
        style={{ marginBottom: 24 }}
      >
        <Row gutter={[16, 16]}>
          {recommendations.slice(0, 4).map(article => (
            <Col key={article.id} span={6}>
              {renderArticleCard(article)}
            </Col>
          ))}
        </Row>
      </Card>
    );
  };

  return (
    <div className="article-selector">
      {/* Header */}
      <div className="selector-header">
        <Title level={2}>
          <BookOutlined /> Reading Library
        </Title>
        <Text type="secondary">
          Choose an article to start reading
        </Text>
      </div>

      {/* Recommendations Section */}
      {renderRecommendations()}

      {/* Filters */}
      <Card className="filters-card">
        <Row gutter={16} align="middle">
          <Col span={8}>
            <Input
              placeholder="Search articles..."
              prefix={<SearchOutlined />}
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              allowClear
            />
          </Col>
          <Col span={4}>
            <Select
              placeholder="Grade Level"
              allowClear
              value={filters.grade_level}
              onChange={(value) => handleFilterChange('grade_level', value)}
              style={{ width: '100%' }}
            >
              {metadata.grade_levels.map(level => (
                <Option key={level} value={level}>Grade {level}</Option>
              ))}
            </Select>
          </Col>
          <Col span={4}>
            <Select
              placeholder="Difficulty"
              allowClear
              value={filters.difficulty}
              onChange={(value) => handleFilterChange('difficulty', value)}
              style={{ width: '100%' }}
            >
              {metadata.difficulties.map(diff => (
                <Option key={diff} value={diff}>
                  Level {diff} - {getDifficultyText(diff)}
                </Option>
              ))}
            </Select>
          </Col>
          <Col span={4}>
            <Select
              placeholder="Topic"
              allowClear
              value={filters.topic}
              onChange={(value) => handleFilterChange('topic', value)}
              style={{ width: '100%' }}
            >
              {metadata.topics.map(topic => (
                <Option key={topic} value={topic}>{topic}</Option>
              ))}
            </Select>
          </Col>
          <Col span={4}>
            {showUserProgress && (
              <Select
                placeholder="Progress"
                allowClear
                value={filters.completed}
                onChange={(value) => handleFilterChange('completed', value)}
                style={{ width: '100%' }}
              >
                <Option value={true}>Completed</Option>
                <Option value={false}>In Progress</Option>
              </Select>
            )}
          </Col>
        </Row>
      </Card>

      {/* Articles Grid */}
      <div className="articles-grid">
        {loading ? (
          <Row gutter={[16, 16]}>
            {Array.from({ length: 8 }).map((_, index) => (
              <Col key={index} span={6}>
                <Card>
                  <Skeleton loading active avatar paragraph={{ rows: 4 }} />
                </Card>
              </Col>
            ))}
          </Row>
        ) : articles.length > 0 ? (
          <>
            <Row gutter={[16, 16]}>
              {articles.map(article => (
                <Col key={article.id} span={6}>
                  {renderArticleCard(article)}
                </Col>
              ))}
            </Row>
            
            {/* Pagination */}
            <div className="pagination-container">
              <Pagination
                current={pagination.current}
                pageSize={pagination.pageSize}
                total={pagination.total}
                onChange={handlePageChange}
                showSizeChanger={false}
                showQuickJumper
                showTotal={(total, range) => 
                  `${range[0]}-${range[1]} of ${total} articles`
                }
              />
            </div>
          </>
        ) : (
          <Empty
            image={Empty.PRESENTED_IMAGE_SIMPLE}
            description="No articles found"
            style={{ padding: '60px 0' }}
          />
        )}
      </div>
    </div>
  );
};

export default ArticleSelector;