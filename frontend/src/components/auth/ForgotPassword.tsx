import React, { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Form, Input, Button, Card, Alert, Result } from 'antd';
import { MailOutlined, ArrowLeftOutlined } from '@ant-design/icons';
import { authService } from '../../services/authService';
import './ForgotPassword.css';

const ForgotPassword: React.FC = () => {
  const [form] = Form.useForm();
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [isSuccess, setIsSuccess] = useState(false);
  const [email, setEmail] = useState('');

  const handleSubmit = async (values: { email: string }) => {
    setIsLoading(true);
    setError(null);
    
    try {
      await authService.requestPasswordReset({ email: values.email });
      setEmail(values.email);
      setIsSuccess(true);
    } catch (error) {
      setError(error instanceof Error ? error.message : '发送重置邮件失败');
    } finally {
      setIsLoading(false);
    }
  };

  const handleFormFailed = (errorInfo: any) => {
    console.error('Form validation failed:', errorInfo);
  };

  const handleResend = async () => {
    if (!email) return;
    
    setIsLoading(true);
    setError(null);
    
    try {
      await authService.requestPasswordReset({ email });
      setError(null);
    } catch (error) {
      setError(error instanceof Error ? error.message : '重新发送邮件失败');
    } finally {
      setIsLoading(false);
    }
  };

  if (isSuccess) {
    return (
      <div className="forgot-password-container">
        <Card className="forgot-password-card">
          <Result
            status="success"
            title="邮件已发送"
            subTitle={`我们已向 ${email} 发送了密码重置邮件。请检查您的邮箱（包括垃圾邮件文件夹）并点击邮件中的链接重置密码。`}
            extra={[
              <Button key="resend" onClick={handleResend} loading={isLoading}>
                重新发送邮件
              </Button>,
              <Link to="/login" key="login">
                <Button type="primary">返回登录</Button>
              </Link>
            ]}
          />
          {error && (
            <Alert
              message="重新发送失败"
              description={error}
              type="error"
              showIcon
              closable
              onClose={() => setError(null)}
              className="resend-error"
            />
          )}
        </Card>
      </div>
    );
  }

  return (
    <div className="forgot-password-container">
      <Card className="forgot-password-card">
        <div className="forgot-password-header">
          <Link to="/login" className="back-link">
            <ArrowLeftOutlined /> 返回登录
          </Link>
          <h2>重置密码 Reset Password</h2>
          <p>请输入您的邮箱地址，我们将发送重置链接给您</p>
        </div>

        {error && (
          <Alert
            message="发送失败"
            description={error}
            type="error"
            showIcon
            closable
            onClose={() => setError(null)}
            className="forgot-password-error"
          />
        )}

        <Form
          form={form}
          name="forgotPassword"
          onFinish={handleSubmit}
          onFinishFailed={handleFormFailed}
          autoComplete="off"
          layout="vertical"
          size="large"
        >
          <Form.Item
            label="邮箱地址"
            name="email"
            rules={[
              { required: true, message: '请输入您的邮箱地址' },
              { type: 'email', message: '请输入有效的邮箱地址' }
            ]}
          >
            <Input
              prefix={<MailOutlined />}
              placeholder="请输入注册时使用的邮箱地址"
              autoComplete="email"
              disabled={isLoading}
            />
          </Form.Item>

          <Form.Item>
            <Button
              type="primary"
              htmlType="submit"
              loading={isLoading}
              className="reset-button"
              block
            >
              {isLoading ? '发送中...' : '发送重置邮件'}
            </Button>
          </Form.Item>
        </Form>

        <div className="help-text">
          <p>
            <strong>注意事项：</strong>
          </p>
          <ul>
            <li>请使用您注册时的邮箱地址</li>
            <li>邮件可能需要几分钟时间到达</li>
            <li>请检查垃圾邮件文件夹</li>
            <li>重置链接有效期为24小时</li>
          </ul>
        </div>

        <div className="login-prompt">
          <span>想起密码了？</span>
          <Link to="/login" className="login-link">
            返回登录
          </Link>
        </div>
      </Card>
    </div>
  );
};

export default ForgotPassword;