import React, { useState } from 'react';
import { Card, Form, Input, Button, Avatar, Upload, message, Tabs, Statistic, Row, Col } from 'antd';
import { UserOutlined, UploadOutlined, EditOutlined, SaveOutlined } from '@ant-design/icons';
import { useAppSelector } from '../store/hooks';
import { authService, ChangePasswordRequest } from '../services/authService';
import './Profile.css';

const { TabPane } = Tabs;

const Profile: React.FC = () => {
  const [form] = Form.useForm();
  const [passwordForm] = Form.useForm();
  const [isEditing, setIsEditing] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [isPasswordLoading, setIsPasswordLoading] = useState(false);
  const { user } = useAppSelector(state => state.auth);
  
  const isAdmin = user?.role === 'admin' || user?.role === 'teacher';

  const handleSave = async (values: any) => {
    setIsLoading(true);
    try {
      // API call to update user profile
      console.log('Updating profile:', values);
      message.success('个人信息更新成功');
      setIsEditing(false);
    } catch (error) {
      message.error('更新失败，请重试');
    } finally {
      setIsLoading(false);
    }
  };

  const handleAvatarChange = (info: any) => {
    if (info.file.status === 'done') {
      message.success('头像上传成功');
    } else if (info.file.status === 'error') {
      message.error('头像上传失败');
    }
  };

  const handlePasswordChange = async (values: any) => {
    setIsPasswordLoading(true);
    try {
      const passwordData: ChangePasswordRequest = {
        current_password: values.currentPassword,
        new_password: values.newPassword
      };
      
      await authService.changePassword(passwordData);
      message.success('密码更新成功');
      passwordForm.resetFields();
    } catch (error: any) {
      console.error('Password change error:', error);
      message.error(error.message || '密码更新失败，请重试');
    } finally {
      setIsPasswordLoading(false);
    }
  };

  const learningStats = {
    totalStudyTime: 1250,
    wordsLearned: 2340,
    dictationAccuracy: 87,
    readingArticles: 145,
    currentLevel: 'Intermediate',
    joinDate: '2024-01-15'
  };

  return (
    <div className="profile-container">
      <Card className="profile-header-card">
        <div className="profile-header">
          <div className="avatar-section">
            <Avatar size={120} icon={<UserOutlined />} className="profile-avatar" />
            <Upload
              name="avatar"
              showUploadList={false}
              beforeUpload={() => false}
              onChange={handleAvatarChange}
            >
              <Button icon={<UploadOutlined />} className="avatar-upload-btn">
                更换头像
              </Button>
            </Upload>
          </div>
          <div className="profile-info">
            <h2>{user?.first_name || user?.username}</h2>
            <p className="user-role">{user?.role === 'student' ? '学生' : '老师'}</p>
            <p className="user-email">{user?.email}</p>
            <p className="join-date">注册时间: {learningStats.joinDate}</p>
          </div>
        </div>
      </Card>

      <Tabs defaultActiveKey="info" className="profile-tabs">
        <TabPane tab="个人信息" key="info">
          <Card
            title="基本信息"
            extra={
              <Button
                type={isEditing ? 'primary' : 'default'}
                icon={isEditing ? <SaveOutlined /> : <EditOutlined />}
                onClick={() => {
                  if (isEditing) {
                    form.submit();
                  } else {
                    setIsEditing(true);
                  }
                }}
                loading={isLoading}
              >
                {isEditing ? '保存' : '编辑'}
              </Button>
            }
          >
            <Form
              form={form}
              layout="vertical"
              onFinish={handleSave}
              initialValues={{
                first_name: user?.first_name,
                last_name: user?.last_name,
                username: user?.username,
                email: user?.email,
              }}
            >
              <Row gutter={16}>
                <Col span={12}>
                  <Form.Item
                    label="姓名"
                    name="first_name"
                    rules={[{ required: true, message: '请输入姓名' }]}
                  >
                    <Input disabled={!isEditing} />
                  </Form.Item>
                </Col>
                <Col span={12}>
                  <Form.Item
                    label="姓氏"
                    name="last_name"
                  >
                    <Input disabled={!isEditing} />
                  </Form.Item>
                </Col>
              </Row>
              <Row gutter={16}>
                <Col span={12}>
                  <Form.Item
                    label="用户名"
                    name="username"
                    rules={[{ required: true, message: '请输入用户名' }]}
                  >
                    <Input disabled={!isEditing} />
                  </Form.Item>
                </Col>
                <Col span={12}>
                  <Form.Item
                    label="邮箱"
                    name="email"
                    rules={[
                      { required: true, message: '请输入邮箱' },
                      { type: 'email', message: '邮箱格式不正确' }
                    ]}
                  >
                    <Input disabled={!isEditing} />
                  </Form.Item>
                </Col>
              </Row>
            </Form>
          </Card>
        </TabPane>

        {/* Learning Statistics Tab - only for students */}
        {!isAdmin && (
          <TabPane tab="学习统计" key="stats">
            <Row gutter={[16, 16]}>
              <Col xs={24} sm={12} lg={6}>
                <Card>
                  <Statistic
                    title="总学习时间"
                    value={learningStats.totalStudyTime}
                    suffix="分钟"
                    valueStyle={{ color: '#1890ff' }}
                  />
                </Card>
              </Col>
              <Col xs={24} sm={12} lg={6}>
                <Card>
                  <Statistic
                    title="掌握单词"
                    value={learningStats.wordsLearned}
                    suffix="个"
                    valueStyle={{ color: '#52c41a' }}
                  />
                </Card>
              </Col>
              <Col xs={24} sm={12} lg={6}>
                <Card>
                  <Statistic
                    title="听写正确率"
                    value={learningStats.dictationAccuracy}
                    suffix="%"
                    valueStyle={{ color: '#faad14' }}
                  />
                </Card>
              </Col>
              <Col xs={24} sm={12} lg={6}>
                <Card>
                  <Statistic
                    title="阅读文章"
                    value={learningStats.readingArticles}
                    suffix="篇"
                    valueStyle={{ color: '#722ed1' }}
                  />
                </Card>
              </Col>
            </Row>

            <Card title="学习进度" style={{ marginTop: 16 }}>
              <div className="learning-level">
                <h3>当前等级: {learningStats.currentLevel}</h3>
                <p>您的英语水平正在稳步提升！继续保持良好的学习习惯。</p>
              </div>
            </Card>
          </TabPane>
        )}

        <TabPane tab="安全设置" key="security">
          <Card title="密码设置">
            <Form form={passwordForm} layout="vertical" onFinish={handlePasswordChange}>
              <Form.Item
                label="当前密码"
                name="currentPassword"
                rules={[{ required: true, message: '请输入当前密码' }]}
              >
                <Input.Password placeholder="请输入当前密码" />
              </Form.Item>
              <Form.Item
                label="新密码"
                name="newPassword"
                rules={[
                  { required: true, message: '请输入新密码' },
                  { min: 6, message: '密码长度至少6位' }
                ]}
              >
                <Input.Password placeholder="请输入新密码" />
              </Form.Item>
              <Form.Item
                label="确认新密码"
                name="confirmPassword"
                dependencies={['newPassword']}
                rules={[
                  { required: true, message: '请确认新密码' },
                  ({ getFieldValue }) => ({
                    validator(_, value) {
                      if (!value || getFieldValue('newPassword') === value) {
                        return Promise.resolve();
                      }
                      return Promise.reject(new Error('两次输入的密码不一致'));
                    },
                  }),
                ]}
              >
                <Input.Password placeholder="请再次输入新密码" />
              </Form.Item>
              <Form.Item>
                <Button 
                  type="primary" 
                  htmlType="submit" 
                  loading={isPasswordLoading}
                  disabled={isPasswordLoading}
                >
                  更新密码
                </Button>
              </Form.Item>
            </Form>
          </Card>
        </TabPane>
      </Tabs>
    </div>
  );
};

export default Profile;