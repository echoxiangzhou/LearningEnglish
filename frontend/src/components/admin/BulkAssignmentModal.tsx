import React, { useState, useEffect } from 'react';
import {
  Modal, Form, Select, Switch, DatePicker, message, Space, Alert, 
  Typography, Card, Row, Col, Tag, Divider, Checkbox, Button
} from 'antd';
import { 
  UserOutlined, BookOutlined, TeamOutlined, CheckCircleOutlined,
  UsergroupAddOutlined, AppstoreOutlined
} from '@ant-design/icons';
import { vocabularyManagementService } from '../../services/vocabularyManagementService';
import { userService } from '../../services/userService';
import dayjs from 'dayjs';

const { Option } = Select;
const { RangePicker } = DatePicker;
const { Text, Title } = Typography;

interface BulkAssignmentModalProps {
  visible: boolean;
  onOk: () => void;
  onCancel: () => void;
}

interface User {
  id: number;
  username: string;
  email: string;
  role: string;
}

interface Library {
  id: string;
  name: string;
  description: string;
  word_count: number;
  grade_level: number;
}

const BulkAssignmentModal: React.FC<BulkAssignmentModalProps> = ({
  visible,
  onOk,
  onCancel
}) => {
  const [form] = Form.useForm();
  const [loading, setLoading] = useState(false);
  const [users, setUsers] = useState<User[]>([]);
  const [libraries, setLibraries] = useState<Library[]>([]);
  const [loadingUsers, setLoadingUsers] = useState(false);
  const [loadingLibraries, setLoadingLibraries] = useState(false);
  
  const [selectedUsers, setSelectedUsers] = useState<number[]>([]);
  const [selectedLibraries, setSelectedLibraries] = useState<string[]>([]);
  const [selectAllUsers, setSelectAllUsers] = useState(false);
  const [selectAllLibraries, setSelectAllLibraries] = useState(false);

  useEffect(() => {
    if (visible) {
      fetchUsers();
      fetchLibraries();
      form.resetFields();
      setSelectedUsers([]);
      setSelectedLibraries([]);
      setSelectAllUsers(false);
      setSelectAllLibraries(false);
    }
  }, [visible, form]);

  const fetchUsers = async () => {
    try {
      setLoadingUsers(true);
      const response = await userService.getUsers();
      // Filter to show only students for bulk assignment
      const students = response.users.filter(user => user.role === 'student');
      setUsers(students);
    } catch (error) {
      message.error('获取用户列表失败: ' + (error as Error).message);
    } finally {
      setLoadingUsers(false);
    }
  };

  const fetchLibraries = async () => {
    try {
      setLoadingLibraries(true);
      const response = await vocabularyManagementService.getLibraries();
      if (response.success) {
        setLibraries(response.libraries);
      }
    } catch (error) {
      message.error('获取词库列表失败: ' + (error as Error).message);
    } finally {
      setLoadingLibraries(false);
    }
  };

  const handleOk = async () => {
    try {
      const values = await form.validateFields();
      
      if (selectedUsers.length === 0) {
        message.error('请至少选择一个用户');
        return;
      }
      
      if (selectedLibraries.length === 0) {
        message.error('请至少选择一个词库');
        return;
      }

      setLoading(true);

      const bulkData = {
        user_ids: selectedUsers,
        library_ids: selectedLibraries,
        is_required: values.is_required || false,
        start_date: values.date_range?.[0]?.format('YYYY-MM-DD'),
        end_date: values.date_range?.[1]?.format('YYYY-MM-DD')
      };

      const response = await vocabularyManagementService.bulkAssignLibraries(bulkData);
      
      message.success(
        `批量分配完成：创建了 ${response.created_count} 个分配，跳过了 ${response.skipped_count} 个重复分配`
      );

      onOk();
    } catch (error) {
      message.error('批量分配失败: ' + (error as Error).message);
    } finally {
      setLoading(false);
    }
  };

  const handleCancel = () => {
    form.resetFields();
    setSelectedUsers([]);
    setSelectedLibraries([]);
    onCancel();
  };

  const handleUserSelectAll = (checked: boolean) => {
    setSelectAllUsers(checked);
    if (checked) {
      setSelectedUsers(users.map(user => user.id));
    } else {
      setSelectedUsers([]);
    }
  };

  const handleLibrarySelectAll = (checked: boolean) => {
    setSelectAllLibraries(checked);
    if (checked) {
      setSelectedLibraries(libraries.map(library => library.id));
    } else {
      setSelectedLibraries([]);
    }
  };

  const handleUserChange = (userIds: number[]) => {
    setSelectedUsers(userIds);
    setSelectAllUsers(userIds.length === users.length);
  };

  const handleLibraryChange = (libraryIds: string[]) => {
    setSelectedLibraries(libraryIds);
    setSelectAllLibraries(libraryIds.length === libraries.length);
  };

  const getTotalAssignments = () => {
    return selectedUsers.length * selectedLibraries.length;
  };

  return (
    <Modal
      title={
        <Space>
          <TeamOutlined />
          批量分配词库
        </Space>
      }
      open={visible}
      onOk={handleOk}
      onCancel={handleCancel}
      confirmLoading={loading}
      width={800}
      okText="批量分配"
      cancelText="取消"
    >
      <Form
        form={form}
        layout="vertical"
        requiredMark={false}
      >
        <Row gutter={[16, 16]}>
          {/* 用户选择 */}
          <Col xs={24} lg={12}>
            <Card 
              title={
                <Space>
                  <UserOutlined />
                  选择用户
                  <Tag color="blue">{selectedUsers.length} 个已选</Tag>
                </Space>
              }
              size="small"
              extra={
                <Checkbox
                  checked={selectAllUsers}
                  onChange={(e) => handleUserSelectAll(e.target.checked)}
                >
                  全选
                </Checkbox>
              }
            >
              <div style={{ maxHeight: '300px', overflowY: 'auto' }}>
                <Checkbox.Group
                  value={selectedUsers}
                  onChange={handleUserChange}
                  style={{ width: '100%' }}
                >
                  <Space direction="vertical" style={{ width: '100%' }}>
                    {users.map(user => (
                      <Checkbox key={user.id} value={user.id} style={{ width: '100%' }}>
                        <div style={{ display: 'flex', alignItems: 'center', width: '100%' }}>
                          <UserOutlined style={{ marginRight: 8 }} />
                          <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 'bold' }}>{user.username}</div>
                            <Text type="secondary" style={{ fontSize: '12px' }}>
                              {user.email}
                            </Text>
                          </div>
                        </div>
                      </Checkbox>
                    ))}
                  </Space>
                </Checkbox.Group>
              </div>
              {loadingUsers && (
                <div style={{ textAlign: 'center', padding: '20px' }}>
                  加载用户中...
                </div>
              )}
            </Card>
          </Col>

          {/* 词库选择 */}
          <Col xs={24} lg={12}>
            <Card 
              title={
                <Space>
                  <BookOutlined />
                  选择词库
                  <Tag color="green">{selectedLibraries.length} 个已选</Tag>
                </Space>
              }
              size="small"
              extra={
                <Checkbox
                  checked={selectAllLibraries}
                  onChange={(e) => handleLibrarySelectAll(e.target.checked)}
                >
                  全选
                </Checkbox>
              }
            >
              <div style={{ maxHeight: '300px', overflowY: 'auto' }}>
                <Checkbox.Group
                  value={selectedLibraries}
                  onChange={handleLibraryChange}
                  style={{ width: '100%' }}
                >
                  <Space direction="vertical" style={{ width: '100%' }}>
                    {libraries.map(library => (
                      <Checkbox key={library.id} value={library.id} style={{ width: '100%' }}>
                        <div style={{ display: 'flex', alignItems: 'center', width: '100%' }}>
                          <BookOutlined style={{ marginRight: 8 }} />
                          <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 'bold' }}>{library.name}</div>
                            <Text type="secondary" style={{ fontSize: '12px' }}>
                              {library.word_count} 个单词 • {library.grade_level}年级
                            </Text>
                          </div>
                        </div>
                      </Checkbox>
                    ))}
                  </Space>
                </Checkbox.Group>
              </div>
              {loadingLibraries && (
                <div style={{ textAlign: 'center', padding: '20px' }}>
                  加载词库中...
                </div>
              )}
            </Card>
          </Col>
        </Row>

        <Divider />

        {/* 分配设置 */}
        <Row gutter={[16, 16]}>
          <Col xs={24} sm={12}>
            <Form.Item
              name="is_required"
              label="分配类型"
              tooltip="必修分配要求学生必须完成，选修分配可由学生自主选择"
            >
              <Switch
                checkedChildren="必修"
                unCheckedChildren="选修"
                defaultChecked={false}
              />
            </Form.Item>
          </Col>

          <Col xs={24} sm={12}>
            <Form.Item
              name="date_range"
              label="有效期限"
              tooltip="可选择分配的开始和结束日期，留空表示永久有效"
            >
              <RangePicker
                style={{ width: '100%' }}
                placeholder={['开始日期', '结束日期']}
                format="YYYY-MM-DD"
              />
            </Form.Item>
          </Col>
        </Row>

        {/* 分配预览 */}
        {(selectedUsers.length > 0 || selectedLibraries.length > 0) && (
          <Alert
            message={
              <Space>
                <AppstoreOutlined />
                批量分配预览
              </Space>
            }
            description={
              <div style={{ marginTop: 8 }}>
                <Row gutter={[16, 8]}>
                  <Col span={8}>
                    <Text strong>选择用户：</Text>
                    <Text>{selectedUsers.length} 个学生</Text>
                  </Col>
                  <Col span={8}>
                    <Text strong>选择词库：</Text>
                    <Text>{selectedLibraries.length} 个词库</Text>
                  </Col>
                  <Col span={8}>
                    <Text strong>总分配数：</Text>
                    <Text style={{ color: '#1890ff', fontWeight: 'bold' }}>
                      {getTotalAssignments()} 个分配
                    </Text>
                  </Col>
                </Row>
                <div style={{ marginTop: 8 }}>
                  <Text strong>分配类型：</Text>
                  <Text>{form.getFieldValue('is_required') ? '必修' : '选修'}</Text>
                </div>
                {form.getFieldValue('date_range') && (
                  <div>
                    <Text strong>有效期：</Text>
                    <Text>
                      {form.getFieldValue('date_range')[0]?.format('YYYY-MM-DD')} 至{' '}
                      {form.getFieldValue('date_range')[1]?.format('YYYY-MM-DD')}
                    </Text>
                  </div>
                )}
              </div>
            }
            type="info"
            style={{ marginTop: 16 }}
          />
        )}

        {getTotalAssignments() > 100 && (
          <Alert
            message="注意"
            description={`将创建 ${getTotalAssignments()} 个分配记录，操作可能需要较长时间，请耐心等待。`}
            type="warning"
            style={{ marginTop: 16 }}
          />
        )}
      </Form>
    </Modal>
  );
};

export default BulkAssignmentModal;