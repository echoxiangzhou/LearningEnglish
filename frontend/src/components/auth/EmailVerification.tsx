import React, { useState, useEffect } from 'react';
import { Card, Input, Button, Result, Typography, Space, Alert, Spin } from 'antd';
import { CheckCircleOutlined, MailOutlined, RedoOutlined } from '@ant-design/icons';
import { useLocation, useNavigate } from 'react-router-dom';
import { authService } from '../../services/authService';
import './EmailVerification.css';

const { Title, Text, Paragraph } = Typography;

interface LocationState {
  email?: string;
  fromRegistration?: boolean;
}

const EmailVerification: React.FC = () => {
  const [verificationCode, setVerificationCode] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [isResending, setIsResending] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [countdown, setCountdown] = useState(0);
  
  const location = useLocation();
  const navigate = useNavigate();
  const state = location.state as LocationState;
  const email = state?.email || '';
  const fromRegistration = state?.fromRegistration || false;

  // Countdown for resend button
  useEffect(() => {
    if (countdown > 0) {
      const timer = setTimeout(() => setCountdown(countdown - 1), 1000);
      return () => clearTimeout(timer);
    }
  }, [countdown]);

  // Redirect if no email provided
  useEffect(() => {
    if (!email) {
      navigate('/register', { replace: true });
    }
  }, [email, navigate]);

  const handleVerify = async () => {
    if (!verificationCode.trim()) {
      setError('请输入验证码');
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      await authService.verifyEmail(email, verificationCode.trim());
      setSuccess(true);
      
      // Auto redirect to login after 3 seconds
      setTimeout(() => {
        navigate('/login', { 
          state: { 
            message: '邮箱验证成功，请登录您的账户',
            email: email 
          } 
        });
      }, 3000);
    } catch (error: any) {
      setError(error.message || '验证失败，请检查验证码是否正确');
    } finally {
      setIsLoading(false);
    }
  };

  const handleResendCode = async () => {
    setIsResending(true);
    setError(null);

    try {
      await authService.resendVerificationCode(email);
      setCountdown(60); // 60 seconds countdown
    } catch (error: any) {
      setError(error.message || '发送验证码失败，请稍后再试');
    } finally {
      setIsResending(false);
    }
  };

  const handleBackToRegister = () => {
    navigate('/register');
  };

  if (success) {
    return (
      <div className="email-verification-container">
        <Card className="verification-card">
          <Result
            status="success"
            icon={<CheckCircleOutlined style={{ color: '#52c41a' }} />}
            title="邮箱验证成功！"
            subTitle={
              <Space direction="vertical" align="center">
                <Text>您的邮箱已成功验证</Text>
                <Text type="secondary">正在跳转到登录页面...</Text>
              </Space>
            }
          />
        </Card>
      </div>
    );
  }

  return (
    <div className="email-verification-container">
      <Card className="verification-card">
        <div className="verification-header">
          <MailOutlined className="verification-icon" />
          <Title level={2}>验证您的邮箱</Title>
          <Paragraph type="secondary">
            我们已向 <Text strong>{email}</Text> 发送了一封包含验证码的邮件。
            请检查您的邮箱（包括垃圾邮件文件夹）并输入6位验证码。
          </Paragraph>
        </div>

        {error && (
          <Alert
            message={error}
            type="error"
            showIcon
            closable
            onClose={() => setError(null)}
            style={{ marginBottom: 24 }}
          />
        )}

        <Space direction="vertical" size="large" style={{ width: '100%' }}>
          <div>
            <Text strong>验证码</Text>
            <Input
              size="large"
              placeholder="请输入6位验证码"
              value={verificationCode}
              onChange={(e) => setVerificationCode(e.target.value.replace(/\D/g, '').slice(0, 6))}
              maxLength={6}
              style={{ 
                textAlign: 'center', 
                fontSize: '18px',
                letterSpacing: '4px',
                marginTop: 8
              }}
              onPressEnter={handleVerify}
            />
          </div>

          <Button
            type="primary"
            size="large"
            block
            onClick={handleVerify}
            loading={isLoading}
            disabled={verificationCode.length !== 6}
          >
            验证邮箱
          </Button>

          <div className="verification-actions">
            <Space split={<span>|</span>}>
              <Button
                type="link"
                icon={<RedoOutlined />}
                onClick={handleResendCode}
                loading={isResending}
                disabled={countdown > 0}
              >
                {countdown > 0 ? `重新发送 (${countdown}s)` : '重新发送验证码'}
              </Button>
              
              <Button
                type="link"
                onClick={handleBackToRegister}
              >
                返回注册
              </Button>
            </Space>
          </div>
        </Space>

        <div className="verification-tips">
          <Title level={5}>没有收到邮件？</Title>
          <ul>
            <li>请检查您的垃圾邮件文件夹</li>
            <li>确认邮箱地址是否正确</li>
            <li>等待1-2分钟，有时邮件会有延迟</li>
            <li>点击"重新发送验证码"再试一次</li>
          </ul>
        </div>
      </Card>
    </div>
  );
};

export default EmailVerification;