import React, { useState, useEffect } from 'react';
import {
  Card, Table, Button, Tag, Space, Input, Select, DatePicker,
  message, Modal, Form, Switch, Tabs, Statistic, Row, Col,
  Tooltip, Popconfirm, Typography, Alert, Badge
} from 'antd';
import {
  UserOutlined, BookOutlined, SearchOutlined, PlusOutlined,
  SettingOutlined, DeleteOutlined, EditOutlined, TeamOutlined,
  CalendarOutlined, CheckCircleOutlined, CloseCircleOutlined
} from '@ant-design/icons';
import { vocabularyManagementService } from '../../services/vocabularyManagementService';
import type { LibraryAssignmentWithDetails, LibraryAssignment } from '../../services/vocabularyManagementService';
import AssignmentModal from './AssignmentModal';
import BulkAssignmentModal from './BulkAssignmentModal';
import dayjs from 'dayjs';
import './LibraryAssignmentManager.css';

const { Search } = Input;
const { Option } = Select;
const { RangePicker } = DatePicker;
const { Title, Text } = Typography;
const { TabPane } = Tabs;

interface LibraryAssignmentManagerProps {
  className?: string;
}

const LibraryAssignmentManager: React.FC<LibraryAssignmentManagerProps> = ({ className }) => {
  const [assignments, setAssignments] = useState<LibraryAssignmentWithDetails[]>([]);
  const [loading, setLoading] = useState(false);
  const [pagination, setPagination] = useState({
    current: 1,
    pageSize: 10,
    total: 0
  });
  
  // Filters
  const [filters, setFilters] = useState({
    user_id: undefined as number | undefined,
    library_id: undefined as string | undefined,
    is_required: undefined as boolean | undefined,
    search: ''
  });

  // Statistics
  const [summary, setSummary] = useState<any>(null);

  // Modal states
  const [assignmentModalVisible, setAssignmentModalVisible] = useState(false);
  const [bulkModalVisible, setBulkModalVisible] = useState(false);
  const [editingAssignment, setEditingAssignment] = useState<LibraryAssignmentWithDetails | null>(null);

  // Current tab
  const [activeTab, setActiveTab] = useState('assignments');

  useEffect(() => {
    if (activeTab === 'assignments') {
      fetchAssignments();
    } else if (activeTab === 'summary') {
      fetchSummary();
    }
  }, [activeTab, pagination.current, pagination.pageSize, filters]);

  const fetchAssignments = async () => {
    try {
      setLoading(true);
      const response = await vocabularyManagementService.getAllAssignments({
        page: pagination.current,
        per_page: pagination.pageSize,
        user_id: filters.user_id,
        library_id: filters.library_id,
        is_required: filters.is_required
      });

      setAssignments(response.assignments);
      setPagination(prev => ({
        ...prev,
        total: response.pagination.total
      }));
    } catch (error) {
      message.error('获取分配记录失败: ' + (error as Error).message);
    } finally {
      setLoading(false);
    }
  };

  const fetchSummary = async () => {
    try {
      const response = await vocabularyManagementService.getAssignmentSummary();
      setSummary(response.summary);
    } catch (error) {
      message.error('获取统计信息失败: ' + (error as Error).message);
    }
  };

  const handleTableChange = (paginationInfo: any) => {
    setPagination({
      current: paginationInfo.current,
      pageSize: paginationInfo.pageSize,
      total: pagination.total
    });
  };

  const handleFilterChange = (key: keyof typeof filters, value: any) => {
    setFilters(prev => ({
      ...prev,
      [key]: value
    }));
    setPagination(prev => ({ ...prev, current: 1 }));
  };

  const handleEditAssignment = (assignment: LibraryAssignmentWithDetails) => {
    setEditingAssignment(assignment);
    setAssignmentModalVisible(true);
  };

  const handleDeleteAssignment = async (assignmentId: number) => {
    try {
      await vocabularyManagementService.removeAssignment(assignmentId);
      message.success('删除分配成功');
      fetchAssignments();
    } catch (error) {
      message.error('删除分配失败: ' + (error as Error).message);
    }
  };

  const handleAssignmentModalOk = () => {
    console.log('LibraryAssignmentManager: handleAssignmentModalOk called');
    setAssignmentModalVisible(false);
    setEditingAssignment(null);
    fetchAssignments();
  };

  const handleBulkModalOk = () => {
    setBulkModalVisible(false);
    fetchAssignments();
  };

  const columns = [
    {
      title: '用户',
      key: 'user',
      render: (_: any, record: LibraryAssignmentWithDetails) => (
        <Space>
          <UserOutlined />
          <div>
            <div style={{ fontWeight: 'bold' }}>{record.user.username}</div>
            <Text type="secondary" style={{ fontSize: '12px' }}>
              {record.user.email}
            </Text>
          </div>
        </Space>
      ),
      width: 200
    },
    {
      title: '词库',
      key: 'library',
      render: (_: any, record: LibraryAssignmentWithDetails) => (
        <Space>
          <BookOutlined />
          <div>
            <div style={{ fontWeight: 'bold' }}>{record.library.name}</div>
            <Text type="secondary" style={{ fontSize: '12px' }}>
              {record.library.word_count} 个单词
            </Text>
          </div>
        </Space>
      ),
      width: 250
    },
    {
      title: '类型',
      dataIndex: 'is_required',
      key: 'is_required',
      render: (isRequired: boolean) => (
        <Tag color={isRequired ? 'red' : 'blue'}>
          {isRequired ? '必修' : '选修'}
        </Tag>
      ),
      width: 80
    },
    {
      title: '进度',
      key: 'progress',
      render: (_: any, record: LibraryAssignmentWithDetails) => {
        const progress = record.library.word_count > 0 
          ? Math.round((record.words_completed / record.library.word_count) * 100)
          : 0;
        return (
          <div>
            <div>{record.words_completed} / {record.library.word_count}</div>
            <Text type="secondary" style={{ fontSize: '12px' }}>
              {progress}% 完成
            </Text>
          </div>
        );
      },
      width: 120
    },
    {
      title: '分配时间',
      dataIndex: 'created_at',
      key: 'created_at',
      render: (date: string) => (
        <div>
          <CalendarOutlined style={{ marginRight: 4 }} />
          {dayjs(date).format('YYYY-MM-DD')}
        </div>
      ),
      width: 120
    },
    {
      title: '最后访问',
      dataIndex: 'last_accessed',
      key: 'last_accessed',
      render: (date: string | null) => (
        <Text type={date ? 'default' : 'secondary'}>
          {date ? dayjs(date).format('YYYY-MM-DD') : '从未访问'}
        </Text>
      ),
      width: 120
    },
    {
      title: '操作',
      key: 'actions',
      render: (_: any, record: LibraryAssignmentWithDetails) => (
        <Space>
          <Tooltip title="编辑分配">
            <Button
              icon={<EditOutlined />}
              size="small"
              onClick={() => handleEditAssignment(record)}
            />
          </Tooltip>
          <Popconfirm
            title="确定要删除这个分配吗？"
            onConfirm={() => handleDeleteAssignment(record.id)}
            okText="确定"
            cancelText="取消"
          >
            <Tooltip title="删除分配">
              <Button
                icon={<DeleteOutlined />}
                size="small"
                danger
              />
            </Tooltip>
          </Popconfirm>
        </Space>
      ),
      width: 100,
      fixed: 'right' as const
    }
  ];

  return (
    <div className={`library-assignment-manager ${className || ''}`}>
      <Card>
        <div className="header-section">
          <div className="title-section">
            <TeamOutlined style={{ fontSize: '24px', color: '#1890ff', marginRight: '12px' }} />
            <Title level={3} style={{ margin: 0 }}>词库分配管理</Title>
          </div>
          <Space>
            <Button
              type="primary"
              icon={<PlusOutlined />}
              onClick={() => setAssignmentModalVisible(true)}
            >
              新增分配
            </Button>
            <Button
              icon={<TeamOutlined />}
              onClick={() => setBulkModalVisible(true)}
            >
              批量分配
            </Button>
          </Space>
        </div>

        <Tabs activeKey={activeTab} onChange={setActiveTab}>
          <TabPane tab="分配管理" key="assignments">
            <div className="filters-section">
              <Row gutter={[16, 16]}>
                <Col xs={24} sm={12} md={6}>
                  <Input
                    placeholder="搜索用户或词库"
                    prefix={<SearchOutlined />}
                    value={filters.search}
                    onChange={(e) => handleFilterChange('search', e.target.value)}
                    allowClear
                  />
                </Col>
                <Col xs={24} sm={12} md={6}>
                  <Select
                    placeholder="分配类型"
                    value={filters.is_required}
                    onChange={(value) => handleFilterChange('is_required', value)}
                    allowClear
                    style={{ width: '100%' }}
                  >
                    <Option value={true}>必修</Option>
                    <Option value={false}>选修</Option>
                  </Select>
                </Col>
              </Row>
            </div>

            <Table
              columns={columns}
              dataSource={assignments}
              rowKey="id"
              loading={loading}
              pagination={{
                current: pagination.current,
                pageSize: pagination.pageSize,
                total: pagination.total,
                showSizeChanger: true,
                showQuickJumper: true,
                showTotal: (total, range) => 
                  `第 ${range[0]}-${range[1]} 条，共 ${total} 条记录`
              }}
              onChange={handleTableChange}
              scroll={{ x: 1200 }}
            />
          </TabPane>

          <TabPane tab="统计概览" key="summary">
            {summary && (
              <div className="summary-section">
                <Row gutter={[24, 24]}>
                  <Col xs={24} sm={12} md={6}>
                    <Card>
                      <Statistic
                        title="总分配数"
                        value={summary.total_assignments}
                        prefix={<TeamOutlined />}
                        valueStyle={{ color: '#1890ff' }}
                      />
                    </Card>
                  </Col>
                  <Col xs={24} sm={12} md={6}>
                    <Card>
                      <Statistic
                        title="必修分配"
                        value={summary.required_assignments}
                        prefix={<CheckCircleOutlined />}
                        valueStyle={{ color: '#f5222d' }}
                      />
                    </Card>
                  </Col>
                  <Col xs={24} sm={12} md={6}>
                    <Card>
                      <Statistic
                        title="选修分配"
                        value={summary.optional_assignments}
                        prefix={<CloseCircleOutlined />}
                        valueStyle={{ color: '#52c41a' }}
                      />
                    </Card>
                  </Col>
                  <Col xs={24} sm={12} md={6}>
                    <Card>
                      <Statistic
                        title="已分配用户"
                        value={summary.users_with_assignments}
                        prefix={<UserOutlined />}
                        valueStyle={{ color: '#722ed1' }}
                      />
                    </Card>
                  </Col>
                  <Col xs={24} sm={12} md={6}>
                    <Card>
                      <Statistic
                        title="已分配词库"
                        value={summary.libraries_with_assignments}
                        prefix={<BookOutlined />}
                        valueStyle={{ color: '#fa541c' }}
                      />
                    </Card>
                  </Col>
                  <Col xs={24} sm={12} md={6}>
                    <Card>
                      <Statistic
                        title="近期分配"
                        value={summary.recent_assignments}
                        prefix={<CalendarOutlined />}
                        suffix="(7天)"
                        valueStyle={{ color: '#13c2c2' }}
                      />
                    </Card>
                  </Col>
                </Row>

                <Card title="热门分配词库" style={{ marginTop: '24px' }}>
                  {summary.top_assigned_libraries.length > 0 ? (
                    <div className="top-libraries">
                      {summary.top_assigned_libraries.map((library: any, index: number) => (
                        <div key={library.library_id} className="library-item">
                          <Badge count={index + 1} style={{ backgroundColor: '#1890ff' }}>
                            <div className="library-info">
                              <div className="library-name">{library.name}</div>
                              <Text type="secondary">{library.assignment_count} 次分配</Text>
                            </div>
                          </Badge>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <Alert message="暂无分配记录" type="info" />
                  )}
                </Card>
              </div>
            )}
          </TabPane>
        </Tabs>
      </Card>

      <AssignmentModal
        visible={assignmentModalVisible}
        assignment={editingAssignment}
        onOk={handleAssignmentModalOk}
        onCancel={() => {
          setAssignmentModalVisible(false);
          setEditingAssignment(null);
        }}
      />

      <BulkAssignmentModal
        visible={bulkModalVisible}
        onOk={handleBulkModalOk}
        onCancel={() => setBulkModalVisible(false)}
      />
    </div>
  );
};

export default LibraryAssignmentManager;