import React, { useState, useEffect } from 'react';
import {
  Modal, Form, Select, Switch, DatePicker, message, Space, Alert, Typography
} from 'antd';
import { UserOutlined, BookOutlined, CalendarOutlined } from '@ant-design/icons';
import { vocabularyManagementService } from '../../services/vocabularyManagementService';
import { userService } from '../../services/userService';
import type { LibraryAssignmentWithDetails } from '../../services/vocabularyManagementService';
import dayjs from 'dayjs';

const { Option } = Select;
const { RangePicker } = DatePicker;
const { Text } = Typography;

interface AssignmentModalProps {
  visible: boolean;
  assignment?: LibraryAssignmentWithDetails | null;
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

const AssignmentModal: React.FC<AssignmentModalProps> = ({
  visible,
  assignment,
  onOk,
  onCancel
}) => {
  const [form] = Form.useForm();
  const [loading, setLoading] = useState(false);
  const [users, setUsers] = useState<User[]>([]);
  const [libraries, setLibraries] = useState<Library[]>([]);
  const [loadingUsers, setLoadingUsers] = useState(false);
  const [loadingLibraries, setLoadingLibraries] = useState(false);

  const isEdit = !!assignment;

  useEffect(() => {
    if (visible) {
      fetchUsers();
      fetchLibraries();
      
      if (isEdit && assignment) {
        // Populate form with existing assignment data
        form.setFieldsValue({
          user_id: assignment.user_id,
          library_id: assignment.library.library_id,
          is_required: assignment.is_required,
          date_range: assignment.start_date && assignment.end_date ? [
            dayjs(assignment.start_date),
            dayjs(assignment.end_date)
          ] : null
        });
      } else {
        form.resetFields();
      }
    }
  }, [visible, assignment, isEdit, form]);

  const fetchUsers = async () => {
    try {
      setLoadingUsers(true);
      const response = await userService.getUsers();
      // Filter to show only students and teachers for assignment
      const filteredUsers = response.users.filter(user => 
        ['student', 'teacher'].includes(user.role)
      );
      setUsers(filteredUsers);
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
    console.log('AssignmentModal: handleOk called!');
    try {
      console.log('AssignmentModal: Starting form validation...');
      console.log('AssignmentModal: Current form field values before validation:', form.getFieldsValue());
      
      const values = await form.validateFields();
      console.log('AssignmentModal: Form validation passed. Values:', values);
      setLoading(true);

      if (isEdit && assignment) {
        // Update existing assignment
        const updateData = {
          is_required: values.is_required || false,
          start_date: values.date_range?.[0]?.format('YYYY-MM-DD'),
          end_date: values.date_range?.[1]?.format('YYYY-MM-DD')
        };
        console.log('AssignmentModal: Updating assignment with data:', updateData);
        await vocabularyManagementService.updateAssignment(assignment.id, updateData);
        message.success('更新分配成功');
      } else {
        // Create new assignment
        const assignmentOptions = {
          is_required: values.is_required || false,
          start_date: values.date_range?.[0]?.format('YYYY-MM-DD'),
          end_date: values.date_range?.[1]?.format('YYYY-MM-DD')
        };
        console.log('AssignmentModal: Creating new assignment with:', {
          library_id: values.library_id,
          user_id: values.user_id,
          options: assignmentOptions
        });
        
        const result = await vocabularyManagementService.assignLibraryToUser(
          values.library_id,
          values.user_id,
          assignmentOptions
        );
        console.log('AssignmentModal: Assignment created successfully:', result);
        message.success('创建分配成功');
      }

      onOk();
    } catch (error) {
      console.error('AssignmentModal: Error in handleOk:', error);
      if (error instanceof Error) {
        message.error(isEdit ? '更新分配失败: ' + error.message : '创建分配失败: ' + error.message);
      } else {
        message.error(isEdit ? '更新分配失败' : '创建分配失败');
      }
    } finally {
      setLoading(false);
    }
  };

  const handleCancel = () => {
    form.resetFields();
    onCancel();
  };

  const selectedLibrary = libraries.find(lib => lib.id === form.getFieldValue('library_id'));
  const selectedUser = users.find(user => user.id === form.getFieldValue('user_id'));

  return (
    <Modal
      title={
        <Space>
          {isEdit ? <BookOutlined /> : <UserOutlined />}
          {isEdit ? '编辑词库分配' : '新增词库分配'}
        </Space>
      }
      open={visible}
      onOk={handleOk}
      onCancel={handleCancel}
      confirmLoading={loading}
      width={600}
      okText={isEdit ? '更新' : '创建'}
      cancelText="取消"
    >
      <Form
        form={form}
        layout="vertical"
        requiredMark={false}
        onFinish={handleOk}
        onFinishFailed={(errorInfo) => {
          console.error('AssignmentModal: Form validation failed:', errorInfo);
        }}
      >
        <Form.Item
          name="user_id"
          label="选择用户"
          rules={[{ required: true, message: '请选择用户' }]}
        >
          <Select
            placeholder="请选择要分配的用户"
            loading={loadingUsers}
            disabled={isEdit} // Don't allow changing user in edit mode
            showSearch
            filterOption={(input, option) =>
              option?.children?.toString().toLowerCase().includes(input.toLowerCase())
            }
          >
            {users.map(user => (
              <Option key={user.id} value={user.id}>
                <Space>
                  <UserOutlined />
                  <div>
                    <div>{user.username}</div>
                    <Text type="secondary" style={{ fontSize: '12px' }}>
                      {user.email} • {user.role === 'student' ? '学生' : '教师'}
                    </Text>
                  </div>
                </Space>
              </Option>
            ))}
          </Select>
        </Form.Item>

        <Form.Item
          name="library_id"
          label="选择词库"
          rules={[{ required: !isEdit, message: '请选择词库' }]}
        >
          <Select
            placeholder="请选择要分配的词库"
            loading={loadingLibraries}
            disabled={isEdit} // Don't allow changing library in edit mode
            showSearch
            filterOption={(input, option) =>
              option?.children?.toString().toLowerCase().includes(input.toLowerCase())
            }
          >
            {libraries.map(library => (
              <Option key={library.id} value={library.id}>
                <Space>
                  <BookOutlined />
                  <div>
                    <div>{library.name}</div>
                    <Text type="secondary" style={{ fontSize: '12px' }}>
                      {library.word_count} 个单词 • {library.grade_level ? `${library.grade_level}年级` : '通用'}
                    </Text>
                  </div>
                </Space>
              </Option>
            ))}
          </Select>
        </Form.Item>

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

        {/* Preview information */}
        {(selectedUser || selectedLibrary) && (
          <Alert
            message="分配预览"
            description={
              <div style={{ marginTop: 8 }}>
                {selectedUser && (
                  <div>
                    <Text strong>用户：</Text>
                    <Text>{selectedUser.username} ({selectedUser.email})</Text>
                  </div>
                )}
                {selectedLibrary && (
                  <div>
                    <Text strong>词库：</Text>
                    <Text>{selectedLibrary.name} ({selectedLibrary.word_count} 个单词)</Text>
                  </div>
                )}
                <div>
                  <Text strong>类型：</Text>
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

        {isEdit && (
          <Alert
            message="编辑说明"
            description="编辑模式下不能修改用户和词库，只能修改分配类型和有效期限。"
            type="warning"
            style={{ marginTop: 16 }}
          />
        )}
      </Form>
    </Modal>
  );
};

export default AssignmentModal;