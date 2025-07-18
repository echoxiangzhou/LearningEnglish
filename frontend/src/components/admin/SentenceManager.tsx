import React, { useState, useEffect } from 'react';
import {
  Table,
  Button,
  Input,
  Select,
  Form,
  Tag,
  message,
  Modal,
  Checkbox,
  Space,
  Statistic,
  Card,
  Pagination,
  Empty,
  Tooltip,
  Popconfirm
} from 'antd';
import {
  SearchOutlined,
  EyeOutlined,
  EditOutlined,
  DeleteOutlined,
  CheckOutlined,
  CloseOutlined,
  DownloadOutlined,
  FileTextOutlined
} from '@ant-design/icons';
import { sentenceAdminService } from '../../services/sentenceAdminService';
import type { SentenceData, SentenceSearchParams, SentenceStatistics } from '../../services/sentenceAdminService';
import { categoryService } from '../../services/categoryService';
import type { SentenceCategory } from '../../types/category';
import SentenceDetailModal from './SentenceDetailModal';
import './SentenceManager.css';

const { Option } = Select;
const { TextArea } = Input;

interface SentenceManagerProps {}

const SentenceManager: React.FC<SentenceManagerProps> = () => {
  const [sentences, setSentences] = useState<SentenceData[]>([]);
  const [statistics, setStatistics] = useState<SentenceStatistics | null>(null);
  const [categories, setCategories] = useState<SentenceCategory[]>([]);
  const [loading, setLoading] = useState(false);
  const [selectedRowKeys, setSelectedRowKeys] = useState<number[]>([]);
  const [searchParams, setSearchParams] = useState<SentenceSearchParams>({
    page: 1,
    per_page: 20
  });
  const [total, setTotal] = useState(0);
  const [rejectionModalVisible, setRejectionModalVisible] = useState(false);
  const [rejectionReason, setRejectionReason] = useState('');
  const [detailModalVisible, setDetailModalVisible] = useState(false);
  const [selectedSentenceId, setSelectedSentenceId] = useState<number | null>(null);
  const [form] = Form.useForm();

  useEffect(() => {
    fetchSentences();
    fetchStatistics();
    fetchCategories();
  }, [searchParams]);

  const fetchCategories = async () => {
    try {
      const data = await categoryService.getCategories();
      setCategories(data.filter(cat => cat.is_active));
    } catch (error) {
      console.error('Error fetching categories:', error);
    }
  };

  const fetchSentences = async () => {
    try {
      setLoading(true);
      const response = await sentenceAdminService.searchSentences(searchParams);
      setSentences(response.sentences);
      setTotal(response.total);
    } catch (error) {
      message.error('获取句子数据失败');
      console.error('Error fetching sentences:', error);
    } finally {
      setLoading(false);
    }
  };

  const fetchStatistics = async () => {
    try {
      const stats = await sentenceAdminService.getStatistics();
      setStatistics(stats);
    } catch (error) {
      console.error('Error fetching statistics:', error);
    }
  };

  const handleSearch = (values: any) => {
    setSearchParams({
      ...values,
      page: 1,
      per_page: 20
    });
  };

  const handleReset = () => {
    form.resetFields();
    setSearchParams({
      page: 1,
      per_page: 20
    });
  };

  const handleApprove = async (sentenceIds: number[]) => {
    try {
      await sentenceAdminService.approveSentences({
        sentence_ids: sentenceIds,
        approved_by: 'Admin' // 实际应用中应该从用户上下文获取
      });
      message.success(`成功批准 ${sentenceIds.length} 个句子`);
      setSelectedRowKeys([]);
      fetchSentences();
      fetchStatistics();
    } catch (error) {
      message.error('批准句子失败');
    }
  };

  const handleReject = async () => {
    if (!rejectionReason.trim()) {
      message.error('请输入拒绝原因');
      return;
    }

    try {
      await sentenceAdminService.rejectSentences({
        sentence_ids: selectedRowKeys,
        rejection_reason: rejectionReason
      });
      message.success(`成功拒绝 ${selectedRowKeys.length} 个句子`);
      setSelectedRowKeys([]);
      setRejectionModalVisible(false);
      setRejectionReason('');
      fetchSentences();
      fetchStatistics();
    } catch (error) {
      message.error('拒绝句子失败');
    }
  };

  const handleDelete = async (id: number) => {
    try {
      await sentenceAdminService.deleteSentence(id);
      message.success('删除成功');
      fetchSentences();
      fetchStatistics();
    } catch (error) {
      message.error('删除失败');
    }
  };

  const handleExport = async () => {
    try {
      const data = await sentenceAdminService.exportSentences('csv');
      const blob = new Blob([data], { type: 'text/csv' });
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `sentences_${new Date().toISOString().split('T')[0]}.csv`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(url);
      document.body.removeChild(a);
      message.success('导出成功');
    } catch (error) {
      message.error('导出失败');
    }
  };

  const getScoreColor = (score: number) => {
    if (score >= 0.8) return 'score-excellent';
    if (score >= 0.6) return 'score-good';
    if (score >= 0.4) return 'score-average';
    return 'score-poor';
  };

  const columns = [
    {
      title: '句子内容',
      dataIndex: 'text',
      key: 'text',
      className: 'sentence-text-cell',
      render: (text: string, record: SentenceData) => (
        <div>
          <div className="sentence-text">{text}</div>
          <div className="sentence-translation">{record.chinese_translation}</div>
        </div>
      ),
    },
    {
      title: '目标词汇',
      dataIndex: 'target_word',
      key: 'target_word',
      width: 120,
      render: (word: string) => (
        <Tag className="target-word-tag">{word}</Tag>
      ),
    },
    {
      title: '分类',
      dataIndex: 'source_category',
      key: 'source_category',
      width: 120,
      render: (sourceCategory: string) => (
        sourceCategory ? (
          <Tag color="blue">{sourceCategory}</Tag>
        ) : (
          <Tag color="default">未分类</Tag>
        )
      ),
    },
    {
      title: '难度',
      dataIndex: 'difficulty',
      key: 'difficulty',
      width: 100,
      render: (difficulty: string) => (
        <Tag className={`difficulty-tag difficulty-${difficulty}`}>
          {difficulty === 'elementary' ? '初级' : 
           difficulty === 'intermediate' ? '中级' : '高级'}
        </Tag>
      ),
    },
    {
      title: '状态',
      dataIndex: 'approval_status',
      key: 'approval_status',
      width: 100,
      render: (status: string) => (
        <Tag className={`status-tag status-${status}`}>
          {status === 'pending' ? '待审核' : 
           status === 'approved' ? '已批准' : '已拒绝'}
        </Tag>
      ),
    },
    {
      title: '质量评分',
      key: 'scores',
      width: 120,
      className: 'score-cell',
      render: (record: SentenceData) => (
        <Tooltip title={`语法: ${(record.grammar_score * 100).toFixed(0)}% | 置信度: ${(record.confidence * 100).toFixed(0)}%`}>
          <div className={`score-value ${getScoreColor(record.overall_score)}`}>
            {(record.overall_score * 100).toFixed(0)}%
          </div>
        </Tooltip>
      ),
    },
    {
      title: '操作',
      key: 'actions',
      width: 200,
      render: (record: SentenceData) => (
        <div className="sentence-actions">
          <Button 
            size="small" 
            icon={<EyeOutlined />} 
            className="action-button action-view"
            onClick={() => {
              setSelectedSentenceId(record.id);
              setDetailModalVisible(true);
            }}
          >
            查看
          </Button>
          <Button 
            size="small" 
            icon={<EditOutlined />} 
            className="action-button action-edit"
            onClick={() => {
              setSelectedSentenceId(record.id);
              setDetailModalVisible(true);
            }}
          >
            编辑
          </Button>
          <Popconfirm
            title="确定要删除这个句子吗？"
            onConfirm={() => handleDelete(record.id)}
            okText="确定"
            cancelText="取消"
          >
            <Button 
              size="small" 
              icon={<DeleteOutlined />} 
              className="action-button action-delete"
            >
              删除
            </Button>
          </Popconfirm>
        </div>
      ),
    },
  ];

  const rowSelection = {
    selectedRowKeys,
    onChange: (keys: React.Key[]) => {
      setSelectedRowKeys(keys as number[]);
    },
  };

  return (
    <div className="sentence-manager">
      <div className="sentence-manager-header">
        <h2 className="sentence-manager-title">句子管理</h2>
        <Button 
          icon={<DownloadOutlined />} 
          onClick={handleExport}
        >
          导出数据
        </Button>
      </div>

      {statistics && (
        <div className="statistics-cards">
          <Card>
            <Statistic 
              title="总句子数" 
              value={statistics.total_sentences}
              prefix={<FileTextOutlined />}
            />
          </Card>
          <Card>
            <Statistic 
              title="待审核" 
              value={statistics.approval_status?.pending || 0}
              valueStyle={{ color: '#fa8c16' }}
            />
          </Card>
          <Card>
            <Statistic 
              title="已批准" 
              value={statistics.approval_status?.approved || 0}
              valueStyle={{ color: '#52c41a' }}
            />
          </Card>
          <Card>
            <Statistic 
              title="已拒绝" 
              value={statistics.approval_status?.rejected || 0}
              valueStyle={{ color: '#f5222d' }}
            />
          </Card>
          <Card>
            <Statistic 
              title="平均质量" 
              value={`${((statistics.quality_metrics?.average_overall_score || 0) * 100).toFixed(0)}%`}
              valueStyle={{ color: '#1890ff' }}
            />
          </Card>
        </div>
      )}

      <Form
        form={form}
        onFinish={handleSearch}
        className="sentence-search-form"
        layout="inline"
      >
        <div className="sentence-search-row">
          <Form.Item name="search">
            <Input
              placeholder="搜索句子内容"
              prefix={<SearchOutlined />}
              style={{ width: 250 }}
            />
          </Form.Item>
          
          <Form.Item name="target_word">
            <Input
              placeholder="目标词汇"
              style={{ width: 150 }}
            />
          </Form.Item>

          <Form.Item name="difficulty">
            <Select placeholder="难度等级" style={{ width: 120 }} allowClear>
              <Option value="elementary">初级</Option>
              <Option value="intermediate">中级</Option>
              <Option value="advanced">高级</Option>
            </Select>
          </Form.Item>

          <Form.Item name="approval_status">
            <Select placeholder="审核状态" style={{ width: 120 }} allowClear>
              <Option value="pending">待审核</Option>
              <Option value="approved">已批准</Option>
              <Option value="rejected">已拒绝</Option>
            </Select>
          </Form.Item>

          <Form.Item name="category_id">
            <Select placeholder="句子分类" style={{ width: 150 }} allowClear>
              {categories.map(category => (
                <Option key={category.id} value={category.id}>
                  {category.name}
                </Option>
              ))}
            </Select>
          </Form.Item>

          <Form.Item>
            <Space>
              <Button type="primary" htmlType="submit" icon={<SearchOutlined />}>
                搜索
              </Button>
              <Button onClick={handleReset}>
                重置
              </Button>
            </Space>
          </Form.Item>
        </div>
      </Form>

      {selectedRowKeys.length > 0 && (
        <div className="batch-actions">
          <span className="batch-info">已选择 {selectedRowKeys.length} 个句子</span>
          <Button
            type="primary"
            icon={<CheckOutlined />}
            onClick={() => handleApprove(selectedRowKeys)}
          >
            批量批准
          </Button>
          <Button
            danger
            icon={<CloseOutlined />}
            onClick={() => setRejectionModalVisible(true)}
          >
            批量拒绝
          </Button>
        </div>
      )}

      <div className="sentence-table">
        <Table
          columns={columns}
          dataSource={sentences}
          rowKey="id"
          loading={loading}
          rowSelection={rowSelection}
          pagination={false}
          locale={{
            emptyText: (
              <div className="empty-state">
                <FileTextOutlined className="empty-icon" />
                <div>暂无句子数据</div>
              </div>
            )
          }}
        />
      </div>

      {total > 0 && (
        <div className="pagination-container">
          <Pagination
            current={searchParams.page || 1}
            pageSize={searchParams.per_page || 20}
            total={total}
            showSizeChanger
            showQuickJumper
            showTotal={(total, range) => 
              `第 ${range[0]}-${range[1]} 条，共 ${total} 条`
            }
            onChange={(page, pageSize) => {
              setSearchParams(prev => ({
                ...prev,
                page,
                per_page: pageSize
              }));
            }}
          />
        </div>
      )}

      <Modal
        title="批量拒绝句子"
        open={rejectionModalVisible}
        onOk={handleReject}
        onCancel={() => {
          setRejectionModalVisible(false);
          setRejectionReason('');
        }}
        okText="确定拒绝"
        cancelText="取消"
      >
        <p>您即将拒绝 {selectedRowKeys.length} 个句子，请输入拒绝原因：</p>
        <TextArea
          value={rejectionReason}
          onChange={(e) => setRejectionReason(e.target.value)}
          placeholder="请输入拒绝原因..."
          rows={4}
        />
      </Modal>

      <SentenceDetailModal
        sentenceId={selectedSentenceId}
        visible={detailModalVisible}
        onClose={() => {
          setDetailModalVisible(false);
          setSelectedSentenceId(null);
        }}
        onUpdate={() => {
          fetchSentences();
          fetchStatistics();
        }}
      />
    </div>
  );
};

export default SentenceManager;