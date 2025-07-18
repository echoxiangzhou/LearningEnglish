import React, { useState, useEffect } from 'react';
import {
  Card,
  Button,
  Modal,
  Form,
  Input,
  Select,
  Switch,
  message,
  Tag,
  Space,
  Popconfirm,
  Transfer,
  Empty
} from 'antd';
import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  UserOutlined,
  BookOutlined,
  SettingOutlined
} from '@ant-design/icons';
import { categoryService } from '../../services/categoryService';
import { userService } from '../../services/userService';
import type { SentenceCategory, CreateCategoryRequest, UpdateCategoryRequest } from '../../types/category';
import './CategoryManager.css';

const { Option } = Select;
const { TextArea } = Input;

interface CategoryManagerProps {}

interface UserInfo {
  id: number;
  username: string;
  email: string;
  first_name?: string;
}

const CategoryManager: React.FC<CategoryManagerProps> = () => {
  const [categories, setCategories] = useState<SentenceCategory[]>([]);
  const [loading, setLoading] = useState(false);
  const [createModalVisible, setCreateModalVisible] = useState(false);
  const [editModalVisible, setEditModalVisible] = useState(false);
  const [assignModalVisible, setAssignModalVisible] = useState(false);
  const [selectedCategory, setSelectedCategory] = useState<SentenceCategory | null>(null);
  const [users, setUsers] = useState<UserInfo[]>([]);
  const [assignedUsers, setAssignedUsers] = useState<number[]>([]);
  const [createForm] = Form.useForm();
  const [editForm] = Form.useForm();

  useEffect(() => {
    fetchCategories();
    fetchUsers();
  }, []);

  const fetchCategories = async () => {
    try {
      setLoading(true);
      const data = await categoryService.getCategories();
      setCategories(data);
    } catch (error) {
      message.error('获取分类失败');
      console.error('Error fetching categories:', error);
    } finally {
      setLoading(false);
    }
  };

  const fetchUsers = async () => {
    try {
      const users = await userService.getSimpleUserList();
      setUsers(users);
    } catch (error) {
      console.error('Error fetching users:', error);
      message.error('获取用户列表失败');
    }
  };

  const handleCreateCategory = async (values: CreateCategoryRequest) => {
    try {
      await categoryService.createCategory(values);
      message.success('创建分类成功');
      setCreateModalVisible(false);
      createForm.resetFields();
      fetchCategories();
    } catch (error) {
      message.error('创建分类失败');
    }
  };

  const handleEditCategory = async (values: UpdateCategoryRequest) => {
    if (!selectedCategory) return;

    try {
      await categoryService.updateCategory({
        ...values,
        id: selectedCategory.id
      });
      message.success('更新分类成功');
      setEditModalVisible(false);
      setSelectedCategory(null);
      editForm.resetFields();
      fetchCategories();
    } catch (error) {
      message.error('更新分类失败');
    }
  };

  const handleDeleteCategory = async (id: number) => {
    try {
      await categoryService.deleteCategory(id);
      message.success('删除分类成功');
      fetchCategories();
    } catch (error) {
      message.error('删除分类失败');
    }
  };

  const handleAssignCategories = async () => {
    if (!selectedCategory) {
      message.error('请选择要分配的分类');
      return;
    }

    // 验证是否选择了用户
    if (assignedUsers.length === 0) {
      message.warning('请至少选择一个用户进行分配');
      return;
    }

    try {
      setLoading(true);
      
      const result = await categoryService.assignCategoriesToUsers({
        user_ids: assignedUsers,
        category_ids: [selectedCategory.id],
        assigned_by: 'Admin' // 实际应用中应该从用户上下文获取
      });
      
      message.success('分配分类成功');
      setAssignModalVisible(false);
      setSelectedCategory(null);
      setAssignedUsers([]);
    } catch (error) {
      console.error('Category assignment error:', error);
      const errorMessage = error instanceof Error ? error.message : '分配分类失败';
      message.error(errorMessage);
    } finally {
      setLoading(false);
    }
  };

  const openEditModal = (category: SentenceCategory) => {
    setSelectedCategory(category);
    editForm.setFieldsValue(category);
    setEditModalVisible(true);
  };

  const openAssignModal = async (category: SentenceCategory) => {
    setSelectedCategory(category);
    setAssignModalVisible(true);
    
    try {
      // 获取已分配的用户
      const assignedUsers = await userService.getUsersAssignedToCategory(category.id);
      setAssignedUsers(assignedUsers.map(user => user.id));
    } catch (error) {
      console.error('Error fetching assigned users:', error);
      message.error('获取已分配用户失败');
      setAssignedUsers([]);
    }
  };

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'elementary': return 'green';
      case 'intermediate': return 'orange';
      case 'advanced': return 'red';
      default: return 'default';
    }
  };

  const getDifficultyText = (difficulty: string) => {
    switch (difficulty) {
      case 'elementary': return '初级';
      case 'intermediate': return '中级';
      case 'advanced': return '高级';
      default: return difficulty;
    }
  };

  const transferDataSource = users.map(user => ({
    key: user.id.toString(),
    title: (
      <div className="user-item">
        <div className="user-info">
          <div className="user-name">{user.first_name || user.username}</div>
          <div className="user-email">{user.email}</div>
        </div>
      </div>
    ),
  }));

  return (
    <div className="category-manager">
      <div className="category-manager-header">
        <h2 className="category-manager-title">分类管理</h2>
        <Button 
          type="primary" 
          icon={<PlusOutlined />}
          onClick={() => setCreateModalVisible(true)}
        >
          创建分类
        </Button>
      </div>

      {categories.length === 0 ? (
        <div className="empty-categories">
          <BookOutlined className="empty-icon" />
          <h3>暂无分类</h3>
          <p>点击"创建分类"按钮开始创建您的第一个句子分类</p>
        </div>
      ) : (
        <div className="category-cards">
          {categories.map(category => (
            <Card 
              key={category.id}
              className="category-card"
              size="small"
            >
              <div className="category-card-header">
                <h4 className="category-name">{category.name}</h4>
                <Tag 
                  className={`category-status ${category.is_active ? 'status-active' : 'status-inactive'}`}
                >
                  {category.is_active ? '启用' : '禁用'}
                </Tag>
              </div>
              
              {category.description && (
                <p className="category-description">{category.description}</p>
              )}
              
              <div className="category-meta">
                <Tag 
                  color={getDifficultyColor(category.difficulty)}
                  className="category-difficulty"
                >
                  {getDifficultyText(category.difficulty)}
                </Tag>
                <span className="category-sentence-count">
                  {category.sentence_count} 个句子
                </span>
              </div>
              
              <div className="category-actions">
                <Button 
                  size="small"
                  icon={<EditOutlined />}
                  className="category-action-btn"
                  onClick={() => openEditModal(category)}
                >
                  编辑
                </Button>
                <Button 
                  size="small"
                  icon={<UserOutlined />}
                  className="category-action-btn"
                  onClick={() => openAssignModal(category)}
                >
                  分配用户
                </Button>
                <Popconfirm
                  title="确定要删除这个分类吗？"
                  description="删除后将无法恢复，相关句子将失去分类信息。"
                  onConfirm={() => handleDeleteCategory(category.id)}
                  okText="确定"
                  cancelText="取消"
                >
                  <Button 
                    size="small"
                    danger
                    icon={<DeleteOutlined />}
                    className="category-action-btn"
                  >
                    删除
                  </Button>
                </Popconfirm>
              </div>
            </Card>
          ))}
        </div>
      )}

      {/* 创建分类Modal */}
      <Modal
        title="创建分类"
        open={createModalVisible}
        onCancel={() => {
          setCreateModalVisible(false);
          createForm.resetFields();
        }}
        footer={null}
        width={500}
      >
        <Form
          form={createForm}
          layout="vertical"
          onFinish={handleCreateCategory}
          className="create-category-form"
        >
          <Form.Item
            name="name"
            label="分类名称"
            rules={[{ required: true, message: '请输入分类名称' }]}
          >
            <Input placeholder="请输入分类名称" />
          </Form.Item>

          <Form.Item
            name="description"
            label="分类描述"
          >
            <TextArea 
              rows={3} 
              placeholder="请输入分类描述（可选）"
            />
          </Form.Item>

          <Form.Item
            name="difficulty"
            label="难度等级"
            rules={[{ required: true, message: '请选择难度等级' }]}
          >
            <Select placeholder="请选择难度等级">
              <Option value="elementary">初级</Option>
              <Option value="intermediate">中级</Option>
              <Option value="advanced">高级</Option>
            </Select>
          </Form.Item>

          <Form.Item
            name="is_active"
            label="启用状态"
            valuePropName="checked"
            initialValue={true}
          >
            <Switch checkedChildren="启用" unCheckedChildren="禁用" />
          </Form.Item>

          <div className="category-form-actions">
            <Button onClick={() => {
              setCreateModalVisible(false);
              createForm.resetFields();
            }}>
              取消
            </Button>
            <Button type="primary" htmlType="submit">
              创建
            </Button>
          </div>
        </Form>
      </Modal>

      {/* 编辑分类Modal */}
      <Modal
        title="编辑分类"
        open={editModalVisible}
        onCancel={() => {
          setEditModalVisible(false);
          setSelectedCategory(null);
          editForm.resetFields();
        }}
        footer={null}
        width={500}
      >
        <Form
          form={editForm}
          layout="vertical"
          onFinish={handleEditCategory}
          className="create-category-form"
        >
          <Form.Item
            name="name"
            label="分类名称"
            rules={[{ required: true, message: '请输入分类名称' }]}
          >
            <Input placeholder="请输入分类名称" />
          </Form.Item>

          <Form.Item
            name="description"
            label="分类描述"
          >
            <TextArea 
              rows={3} 
              placeholder="请输入分类描述（可选）"
            />
          </Form.Item>

          <Form.Item
            name="difficulty"
            label="难度等级"
            rules={[{ required: true, message: '请选择难度等级' }]}
          >
            <Select placeholder="请选择难度等级">
              <Option value="elementary">初级</Option>
              <Option value="intermediate">中级</Option>
              <Option value="advanced">高级</Option>
            </Select>
          </Form.Item>

          <Form.Item
            name="is_active"
            label="启用状态"
            valuePropName="checked"
          >
            <Switch checkedChildren="启用" unCheckedChildren="禁用" />
          </Form.Item>

          <div className="category-form-actions">
            <Button onClick={() => {
              setEditModalVisible(false);
              setSelectedCategory(null);
              editForm.resetFields();
            }}>
              取消
            </Button>
            <Button type="primary" htmlType="submit">
              保存
            </Button>
          </div>
        </Form>
      </Modal>

      {/* 分配用户Modal */}
      <Modal
        title={`分配分类：${selectedCategory?.name}`}
        open={assignModalVisible}
        footer={null}
        onCancel={() => {
          setAssignModalVisible(false);
          setSelectedCategory(null);
          setAssignedUsers([]);
        }}
        width={700}
        className="assign-modal"
      >
        <p>选择要分配此分类的用户：</p>
        <Transfer
          dataSource={transferDataSource}
          targetKeys={assignedUsers.map(id => id.toString())}
          onChange={(targetKeys) => {
            setAssignedUsers(targetKeys.map(key => parseInt(key as string)));
          }}
          render={item => item.title}
          titles={['所有用户', '已分配用户']}
          listStyle={{
            width: 300,
            height: 400,
          }}
        />
        <div style={{ marginTop: 16, display: 'flex', justifyContent: 'flex-end', gap: 8 }}>
          <Button onClick={() => {
            setAssignModalVisible(false);
            setSelectedCategory(null);
            setAssignedUsers([]);
          }}>
            取消
          </Button>
          <Button 
            type="primary" 
            loading={loading}
            onClick={handleAssignCategories}
          >
            确定
          </Button>
        </div>
      </Modal>
    </div>
  );
};

export default CategoryManager;