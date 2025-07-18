import React, { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { Form, Input, Button, Card, Alert, Typography, Space, Statistic } from 'antd';
import { PhoneOutlined, SafetyOutlined } from '@ant-design/icons';
import './PhoneVerification.css';

const { Title, Text } = Typography;
const { Countdown } = Statistic;

const PhoneVerification: React.FC = () => {
  const [form] = Form.useForm();
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [canResend, setCanResend] = useState(false);
  const location = useLocation();
  const navigate = useNavigate();
  
  const phone = location.state?.phone;
  const fromRegistration = location.state?.fromRegistration;
  
  useEffect(() => {
    if (!phone) {
      navigate('/login');
    }
  }, [phone, navigate]);

  const handleVerify = async (values: { code: string }) => {
    try {
      setLoading(true);
      setError(null);
      
      // TODO: 实现手机验证API调用
      const response = await fetch('/api/auth/verify-phone', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          phone: phone,
          code: values.code
        }),
      });

      if (response.ok) {
        setSuccess('手机号验证成功！');
        setTimeout(() => {
          navigate('/login', {
            state: {
              phone: phone,
              message: '验证成功，请登录您的账户'
            }
          });
        }, 2000);
      } else {
        const data = await response.json();
        setError(data.error || '验证失败，请重试');
      }
    } catch (error) {
      setError('网络错误，请检查您的网络连接');
    } finally {
      setLoading(false);
    }
  };

  const handleResendCode = async () => {
    try {
      setLoading(true);
      setError(null);
      
      // TODO: 实现重发验证码API调用
      const response = await fetch('/api/auth/resend-phone-code', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ phone: phone }),
      });

      if (response.ok) {
        setSuccess('验证码已重新发送');
        setCanResend(false);
        // 60秒后允许再次发送
        setTimeout(() => setCanResend(true), 60000);
      } else {
        const data = await response.json();
        setError(data.error || '发送失败，请重试');
      }
    } catch (error) {
      setError('网络错误，请检查您的网络连接');
    } finally {
      setLoading(false);
    }
  };

  const maskedPhone = phone ? phone.replace(/(\d{3})\d{4}(\d{4})/, '$1****$2') : '';

  return (
    <div className="phone-verification-container">
      <Card className="verification-card" title="Smart English Learning">
        <div className="verification-header">
          <SafetyOutlined className="verification-icon" />
          <Title level={2}>手机号验证</Title>
          <Text type="secondary">
            我们已向 <Text strong>{maskedPhone}</Text> 发送了6位验证码
          </Text>
        </div>

        {error && (
          <Alert
            message="验证失败"
            description={error}
            type="error"
            showIcon
            closable
            onClose={() => setError(null)}
            style={{ marginBottom: 24 }}
          />
        )}

        {success && (
          <Alert
            message="验证成功"
            description={success}
            type="success"
            showIcon
            style={{ marginBottom: 24 }}
          />
        )}

        <Form
          form={form}
          name="phoneVerification"
          onFinish={handleVerify}
          layout="vertical"
          size="large"
        >
          <Form.Item
            label="验证码"
            name="code"
            rules={[
              { required: true, message: '请输入验证码' },
              { len: 6, message: '验证码为6位数字' },
              { pattern: /^\d{6}$/, message: '验证码只能包含数字' }
            ]}
          >
            <Input
              prefix={<PhoneOutlined />}
              placeholder="请输入6位验证码"
              maxLength={6}
              disabled={loading}
              autoComplete="one-time-code"
            />
          </Form.Item>

          <Form.Item>
            <Button
              type="primary"
              htmlType="submit"
              loading={loading}
              block
              size="large"
            >
              验证
            </Button>
          </Form.Item>
        </Form>

        <div className="verification-actions">
          <Space direction="vertical" style={{ width: '100%' }}>
            <div className="resend-section">
              <Text type="secondary">没有收到验证码？</Text>
              {canResend ? (
                <Button
                  type="link"
                  onClick={handleResendCode}
                  loading={loading}
                  style={{ padding: 0 }}
                >
                  重新发送
                </Button>
              ) : (
                <Countdown
                  value={Date.now() + 60000}
                  format="ss"
                  suffix="秒后可重发"
                  onFinish={() => setCanResend(true)}
                />
              )}
            </div>
            
            <Button
              type="text"
              onClick={() => navigate('/register')}
              disabled={loading}
            >
              返回注册
            </Button>
          </Space>
        </div>

        <div className="verification-tips">
          <Title level={5}>验证提示：</Title>
          <ul>
            <li>验证码有效期为10分钟</li>
            <li>请检查短信是否被拦截</li>
            <li>如长时间未收到，请联系客服</li>
          </ul>
        </div>
      </Card>
    </div>
  );
};

export default PhoneVerification;