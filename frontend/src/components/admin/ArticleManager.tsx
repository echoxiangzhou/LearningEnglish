import React, { useState, useEffect } from 'react';
import {
  Table,
  Button,
  Space,
  Modal,
  Form,
  Input,
  InputNumber,
  Select,
  Switch,
  Tag,
  message,
  Popconfirm,
  Card,
  Row,
  Col,
  Pagination,
  Upload,
  Divider,
  Typography,
  Tooltip,
  Badge
} from 'antd';
import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  EyeOutlined,
  UploadOutlined,
  SearchOutlined,
  FileTextOutlined,
  BookOutlined,
  ClockCircleOutlined,
  UserOutlined
} from '@ant-design/icons';
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';
import './ArticleManager.css';

const { TextArea } = Input;
const { Option } = Select;
const { Title, Text } = Typography;

// Define types
interface Article {
  id: number;
  title: string;
  content: string;
  summary?: string;
  author?: string;
  source?: string;
  topic?: string;
  grade_level: number;
  difficulty: number;
  word_count: number;
  estimated_reading_time: number;
  image_url?: string;
  is_published: boolean;
  tags: string[];
  created_at: string;
  questions?: Question[];
}

interface Question {
  id?: number;
  question_text: string;
  question_type: 'multiple_choice' | 'true_false' | 'short_answer';
  options?: string[];
  correct_answer: string;
  explanation?: string;
  difficulty: number;
  order_index: number;
}

interface Pagination {
  page: number;
  pages: number;
  per_page: number;
  total: number;
  has_next: boolean;
  has_prev: boolean;
}

interface ArticleManagerProps {
  onArticleSelect?: (article: Article) => void;
}

const ArticleManager: React.FC<ArticleManagerProps> = ({ onArticleSelect }) => {
  // State management
  const [articles, setArticles] = useState<Article[]>([]);
  const [loading, setLoading] = useState(false);
  const [modalVisible, setModalVisible] = useState(false);
  const [questionModalVisible, setQuestionModalVisible] = useState(false);
  const [previewModalVisible, setPreviewModalVisible] = useState(false);
  const [editingArticle, setEditingArticle] = useState<Article | null>(null);
  const [previewArticle, setPreviewArticle] = useState<Article | null>(null);
  const [pagination, setPagination] = useState<Pagination>({
    page: 1,
    pages: 1,
    per_page: 10,
    total: 0,
    has_next: false,
    has_prev: false
  });
  const [searchTerm, setSearchTerm] = useState('');
  const [filters, setFilters] = useState({
    grade_level: null as number | null,
    difficulty: null as number | null,
    topic: '',
    published_only: false
  });
  const [metadata, setMetadata] = useState({
    grade_levels: [] as number[],
    difficulties: [] as number[],
    topics: [] as string[],
    total_articles: 0
  });

  const [form] = Form.useForm();
  const [questionForm] = Form.useForm();

  // Quill editor configuration
  const quillModules = {
    toolbar: [
      [{ 'header': [1, 2, 3, false] }],
      ['bold', 'italic', 'underline', 'strike'],
      [{ 'list': 'ordered'}, { 'list': 'bullet' }],
      [{ 'script': 'sub'}, { 'script': 'super' }],
      [{ 'indent': '-1'}, { 'indent': '+1' }],
      [{ 'direction': 'rtl' }],
      [{ 'size': ['small', false, 'large', 'huge'] }],
      [{ 'color': [] }, { 'background': [] }],
      [{ 'font': [] }],
      [{ 'align': [] }],
      ['clean'],
      ['link', 'image']
    ]
  };

  // Load articles on component mount and when filters change
  useEffect(() => {
    loadArticles();
    loadMetadata();
  }, [pagination.page, searchTerm, filters]);

  const loadArticles = async () => {
    setLoading(true);
    try {
      const params = new URLSearchParams({
        page: pagination.page.toString(),
        per_page: pagination.per_page.toString(),
        ...(searchTerm && { search: searchTerm }),
        ...(filters.grade_level && { grade_level: filters.grade_level.toString() }),
        ...(filters.difficulty && { difficulty: filters.difficulty.toString() }),
        ...(filters.topic && { topic: filters.topic }),
        published_only: filters.published_only.toString()
      });

      const response = await fetch(`/api/articles?${params}`);
      const data = await response.json();

      if (response.ok) {
        setArticles(data.articles);
        setPagination(data.pagination);
      } else {
        message.error('Failed to load articles');
      }
    } catch (error) {
      message.error('Error loading articles');
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

  const handleCreateArticle = () => {
    setEditingArticle(null);
    form.resetFields();
    setModalVisible(true);
  };

  const handleEditArticle = (article: Article) => {
    setEditingArticle(article);
    form.setFieldsValue({
      ...article,
      tags: article.tags || []
    });
    setModalVisible(true);
  };

  const handlePreviewArticle = async (article: Article) => {
    try {
      const response = await fetch(`/api/articles/${article.id}`);
      const data = await response.json();

      if (response.ok) {
        setPreviewArticle(data);
        setPreviewModalVisible(true);
      } else {
        message.error('Failed to load article details');
      }
    } catch (error) {
      message.error('Error loading article details');
    }
  };

  const handleDeleteArticle = async (articleId: number) => {
    try {
      const response = await fetch(`/api/articles/${articleId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        }
      });

      if (response.ok) {
        message.success('Article deleted successfully');
        loadArticles();
      } else {
        message.error('Failed to delete article');
      }
    } catch (error) {
      message.error('Error deleting article');
    }
  };

  const handleSubmitArticle = async (values: any) => {
    try {
      const method = editingArticle ? 'PUT' : 'POST';
      const url = editingArticle ? `/api/articles/${editingArticle.id}` : '/api/articles';

      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        },
        body: JSON.stringify(values)
      });

      if (response.ok) {
        message.success(`Article ${editingArticle ? 'updated' : 'created'} successfully`);
        setModalVisible(false);
        loadArticles();
      } else {
        const errorData = await response.json();
        message.error(errorData.error || 'Failed to save article');
      }
    } catch (error) {
      message.error('Error saving article');
    }
  };

  const handleBulkUpload = (info: any) => {
    if (info.file.status === 'done') {
      message.success(`${info.file.name} file uploaded successfully`);
      loadArticles();
    } else if (info.file.status === 'error') {
      message.error(`${info.file.name} file upload failed`);
    }
  };

  const columns = [
    {
      title: 'Title',
      dataIndex: 'title',
      key: 'title',
      ellipsis: true,
      render: (text: string, record: Article) => (
        <div>
          <Text strong>{text}</Text>
          {record.summary && (
            <div style={{ fontSize: '12px', color: '#666', marginTop: '4px' }}>
              {record.summary.substring(0, 100)}...
            </div>
          )}
        </div>
      )
    },
    {
      title: 'Info',
      key: 'info',
      width: 200,
      render: (record: Article) => (
        <Space direction="vertical" size="small">
          <div>
            <BookOutlined /> Grade {record.grade_level} | Difficulty {record.difficulty}
          </div>
          <div>
            <FileTextOutlined /> {record.word_count} words
          </div>
          <div>
            <ClockCircleOutlined /> {record.estimated_reading_time} min
          </div>
          {record.author && (
            <div>
              <UserOutlined /> {record.author}
            </div>
          )}
        </Space>
      )
    },
    {
      title: 'Topic & Tags',
      key: 'topic',
      width: 200,
      render: (record: Article) => (
        <Space direction="vertical" size="small">
          {record.topic && (
            <Tag color="blue">{record.topic}</Tag>
          )}
          <div>
            {record.tags.map((tag, index) => (
              <Tag key={index} size="small">{tag}</Tag>
            ))}
          </div>
        </Space>
      )
    },
    {
      title: 'Status',
      dataIndex: 'is_published',
      key: 'status',
      width: 100,
      render: (published: boolean) => (
        <Badge
          status={published ? 'success' : 'default'}
          text={published ? 'Published' : 'Draft'}
        />
      )
    },
    {
      title: 'Actions',
      key: 'actions',
      width: 200,
      render: (record: Article) => (
        <Space>
          <Tooltip title="Preview">
            <Button
              type="link"
              icon={<EyeOutlined />}
              onClick={() => handlePreviewArticle(record)}
            />
          </Tooltip>
          <Tooltip title="Edit">
            <Button
              type="link"
              icon={<EditOutlined />}
              onClick={() => handleEditArticle(record)}
            />
          </Tooltip>
          <Tooltip title="Delete">
            <Popconfirm
              title="Are you sure you want to delete this article?"
              onConfirm={() => handleDeleteArticle(record.id)}
              okText="Yes"
              cancelText="No"
            >
              <Button
                type="link"
                danger
                icon={<DeleteOutlined />}
              />
            </Popconfirm>
          </Tooltip>
        </Space>
      )
    }
  ];

  return (
    <div className="article-manager">
      <Card>
        <div className="article-manager-header">
          <Title level={2}>Article Management</Title>
          <Space>
            <Upload
              name="file"
              action="/api/articles/upload"
              headers={{
                authorization: `Bearer ${localStorage.getItem('access_token')}`
              }}
              onChange={handleBulkUpload}
              showUploadList={false}
            >
              <Button icon={<UploadOutlined />}>
                Bulk Upload
              </Button>
            </Upload>
            <Button
              type="primary"
              icon={<PlusOutlined />}
              onClick={handleCreateArticle}
            >
              Create Article
            </Button>
          </Space>
        </div>

        {/* Filters */}
        <Row gutter={16} style={{ marginBottom: 16 }}>
          <Col span={6}>
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
              onChange={(value) => setFilters({...filters, grade_level: value})}
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
              onChange={(value) => setFilters({...filters, difficulty: value})}
            >
              {metadata.difficulties.map(diff => (
                <Option key={diff} value={diff}>Level {diff}</Option>
              ))}
            </Select>
          </Col>
          <Col span={4}>
            <Select
              placeholder="Topic"
              allowClear
              value={filters.topic}
              onChange={(value) => setFilters({...filters, topic: value})}
            >
              {metadata.topics.map(topic => (
                <Option key={topic} value={topic}>{topic}</Option>
              ))}
            </Select>
          </Col>
          <Col span={6}>
            <Space>
              <Switch
                checked={filters.published_only}
                onChange={(checked) => setFilters({...filters, published_only: checked})}
              />
              <Text>Published only</Text>
            </Space>
          </Col>
        </Row>

        {/* Articles Table */}
        <Table
          columns={columns}
          dataSource={articles}
          rowKey="id"
          loading={loading}
          pagination={false}
          onRow={(record) => ({
            onDoubleClick: () => onArticleSelect && onArticleSelect(record)
          })}
        />

        {/* Pagination */}
        <div style={{ marginTop: 16, textAlign: 'center' }}>
          <Pagination
            current={pagination.page}
            total={pagination.total}
            pageSize={pagination.per_page}
            onChange={(page) => setPagination({...pagination, page})}
            showSizeChanger={false}
            showQuickJumper
            showTotal={(total, range) => 
              `${range[0]}-${range[1]} of ${total} articles`
            }
          />
        </div>
      </Card>

      {/* Create/Edit Article Modal */}
      <Modal
        title={editingArticle ? 'Edit Article' : 'Create Article'}
        open={modalVisible}
        onCancel={() => setModalVisible(false)}
        footer={null}
        width={1000}
        className="article-modal"
      >
        <Form
          form={form}
          layout="vertical"
          onFinish={handleSubmitArticle}
          initialValues={{
            grade_level: 1,
            difficulty: 1,
            is_published: false,
            tags: []
          }}
        >
          <Row gutter={16}>
            <Col span={16}>
              <Form.Item
                name="title"
                label="Title"
                rules={[{ required: true, message: 'Please input article title!' }]}
              >
                <Input placeholder="Article title" />
              </Form.Item>
            </Col>
            <Col span={8}>
              <Form.Item
                name="is_published"
                label="Published"
                valuePropName="checked"
              >
                <Switch />
              </Form.Item>
            </Col>
          </Row>

          <Form.Item
            name="summary"
            label="Summary"
          >
            <TextArea
              rows={3}
              placeholder="Brief summary of the article"
              maxLength={500}
              showCount
            />
          </Form.Item>

          <Form.Item
            name="content"
            label="Content"
            rules={[{ required: true, message: 'Please input article content!' }]}
          >
            <ReactQuill
              theme="snow"
              modules={quillModules}
              style={{ height: '300px', marginBottom: '50px' }}
            />
          </Form.Item>

          <Row gutter={16}>
            <Col span={6}>
              <Form.Item
                name="author"
                label="Author"
              >
                <Input placeholder="Author name" />
              </Form.Item>
            </Col>
            <Col span={6}>
              <Form.Item
                name="source"
                label="Source"
              >
                <Input placeholder="Source" />
              </Form.Item>
            </Col>
            <Col span={6}>
              <Form.Item
                name="topic"
                label="Topic"
              >
                <Input placeholder="Topic" />
              </Form.Item>
            </Col>
            <Col span={6}>
              <Form.Item
                name="image_url"
                label="Image URL"
              >
                <Input placeholder="Image URL" />
              </Form.Item>
            </Col>
          </Row>

          <Row gutter={16}>
            <Col span={8}>
              <Form.Item
                name="grade_level"
                label="Grade Level"
                rules={[{ required: true, message: 'Please select grade level!' }]}
              >
                <InputNumber min={1} max={12} style={{ width: '100%' }} />
              </Form.Item>
            </Col>
            <Col span={8}>
              <Form.Item
                name="difficulty"
                label="Difficulty"
                rules={[{ required: true, message: 'Please select difficulty!' }]}
              >
                <InputNumber min={1} max={5} style={{ width: '100%' }} />
              </Form.Item>
            </Col>
            <Col span={8}>
              <Form.Item
                name="word_count"
                label="Word Count"
                tooltip="Leave empty to auto-calculate"
              >
                <InputNumber min={0} style={{ width: '100%' }} />
              </Form.Item>
            </Col>
          </Row>

          <Form.Item
            name="tags"
            label="Tags"
          >
            <Select
              mode="tags"
              style={{ width: '100%' }}
              placeholder="Add tags"
              tokenSeparators={[',']}
            />
          </Form.Item>

          <Form.Item>
            <Space>
              <Button type="primary" htmlType="submit">
                {editingArticle ? 'Update' : 'Create'} Article
              </Button>
              <Button onClick={() => setModalVisible(false)}>
                Cancel
              </Button>
            </Space>
          </Form.Item>
        </Form>
      </Modal>

      {/* Preview Modal */}
      <Modal
        title="Article Preview"
        open={previewModalVisible}
        onCancel={() => setPreviewModalVisible(false)}
        footer={[
          <Button key="close" onClick={() => setPreviewModalVisible(false)}>
            Close
          </Button>
        ]}
        width={800}
      >
        {previewArticle && (
          <div className="article-preview">
            <Title level={3}>{previewArticle.title}</Title>
            
            <div className="article-meta">
              <Space wrap>
                <Text type="secondary">By {previewArticle.author}</Text>
                <Divider type="vertical" />
                <Text type="secondary">Grade {previewArticle.grade_level}</Text>
                <Divider type="vertical" />
                <Text type="secondary">Difficulty {previewArticle.difficulty}</Text>
                <Divider type="vertical" />
                <Text type="secondary">{previewArticle.word_count} words</Text>
                <Divider type="vertical" />
                <Text type="secondary">{previewArticle.estimated_reading_time} min read</Text>
              </Space>
            </div>

            {previewArticle.summary && (
              <div className="article-summary">
                <Title level={5}>Summary</Title>
                <Text>{previewArticle.summary}</Text>
              </div>
            )}

            <div className="article-content">
              <div dangerouslySetInnerHTML={{ __html: previewArticle.content }} />
            </div>

            {previewArticle.tags && previewArticle.tags.length > 0 && (
              <div className="article-tags">
                <Title level={5}>Tags</Title>
                <Space wrap>
                  {previewArticle.tags.map((tag, index) => (
                    <Tag key={index}>{tag}</Tag>
                  ))}
                </Space>
              </div>
            )}

            {previewArticle.questions && previewArticle.questions.length > 0 && (
              <div className="article-questions">
                <Title level={5}>Comprehension Questions</Title>
                {previewArticle.questions.map((question, index) => (
                  <Card key={index} size="small" style={{ marginBottom: 8 }}>
                    <Text strong>{index + 1}. {question.question_text}</Text>
                    {question.question_type === 'multiple_choice' && question.options && (
                      <div style={{ marginTop: 8 }}>
                        {question.options.map((option, optIndex) => (
                          <div key={optIndex}>
                            {String.fromCharCode(65 + optIndex)}. {option}
                          </div>
                        ))}
                      </div>
                    )}
                    <Text type="secondary" style={{ fontSize: '12px' }}>
                      Answer: {question.correct_answer}
                    </Text>
                  </Card>
                ))}
              </div>
            )}
          </div>
        )}
      </Modal>
    </div>
  );
};

export default ArticleManager;