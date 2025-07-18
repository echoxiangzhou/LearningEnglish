import React, { useState, useEffect } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { Form, Input, Button, Card, Alert, Checkbox, Divider, Radio, Space } from 'antd';
import { UserOutlined, LockOutlined, MailOutlined, PhoneOutlined, EyeInvisibleOutlined, EyeTwoTone } from '@ant-design/icons';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { loginAsync, clearError } from '../../store/slices/authSlice';
import { useAccessibility } from '../../hooks/useAccessibility';
import type { LoginCredentials } from '../../services/authService';
import './Login.css';

const Login: React.FC = () => {
  const [form] = Form.useForm();
  const [rememberMe, setRememberMe] = useState(false);
  const [loginType, setLoginType] = useState<'email' | 'phone'>('email');
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  const location = useLocation();
  const { containerRef, announce } = useAccessibility({
    announceOnMount: '登录页面已加载',
    trapFocus: true,
  });
  
  const { isLoading, error, isAuthenticated, loginAttempts } = useAppSelector(state => state.auth);
  const successMessage = location.state?.message;
  const emailFromVerification = location.state?.email;
  
  // Pre-fill contact info if coming from verification
  useEffect(() => {
    if (emailFromVerification) {
      form.setFieldValue('email', emailFromVerification);
      setLoginType('email');
    }
    // 如果有手机号信息，也可以预填充
    const phoneFromVerification = location.state?.phone;
    if (phoneFromVerification) {
      form.setFieldValue('phone', phoneFromVerification);
      setLoginType('phone');
    }
  }, [emailFromVerification, location.state?.phone, form]);
  
  // Get user data
  const { user } = useAppSelector(state => state.auth);
  
  // Redirect if already authenticated
  useEffect(() => {
    if (isAuthenticated && user) {
      // Check if user needs onboarding (new users or those who haven't completed it)
      const needsOnboarding = 
        (user.has_completed_onboarding === false || 
         user.has_completed_onboarding === undefined) &&
        user.role === 'student'; // Only redirect students to onboarding
      
      let destination;
      if (needsOnboarding) {
        destination = '/onboarding';
      } else {
        destination = location.state?.from?.pathname || '/dashboard';
      }
      
      navigate(destination, { replace: true });
    }
  }, [isAuthenticated, user, navigate, location]);

  // Clear error when component unmounts
  useEffect(() => {
    return () => {
      if (error) {
        dispatch(clearError());
      }
    };
  }, [dispatch, error]);

  const handleSubmit = async (values: LoginCredentials) => {
    try {
      announce('正在登录...', 'assertive');
      await dispatch(loginAsync(values)).unwrap();
      announce('登录成功', 'assertive');
      // Navigation is handled by the useEffect hook above
    } catch (error) {
      announce('登录失败，请检查您的登录信息', 'assertive');
      console.error('Login error:', error);
    }
  };

  const handleFormFailed = (errorInfo: any) => {
    console.error('Form validation failed:', errorInfo);
  };

  const isRateLimited = loginAttempts >= 5;

  return (
    <div className="login-container" ref={containerRef}>
      <Card 
        className="login-card" 
        title="Smart English Learning"
        role="main"
        aria-labelledby="login-title"
      >
        <div className="login-header">
          <h2 id="login-title">欢迎回来 Welcome Back</h2>
          <p>登录您的账户开始学习英语</p>
        </div>

        {successMessage && (
          <Alert
            message={successMessage}
            type="success"
            showIcon
            closable
            className="login-success"
            style={{ marginBottom: 24 }}
          />
        )}

        {error && (
          <Alert
            message="登录失败"
            description={error}
            type="error"
            showIcon
            closable
            onClose={() => dispatch(clearError())}
            className="login-error"
            role="alert"
            aria-live="assertive"
          />
        )}

        {isRateLimited && (
          <Alert
            message="登录次数过多"
            description="请稍后再试，或使用忘记密码功能重置密码"
            type="warning"
            showIcon
            className="login-warning"
          />
        )}

        <Form
          form={form}
          name="login"
          onFinish={handleSubmit}
          onFinishFailed={handleFormFailed}
          autoComplete="off"
          layout="vertical"
          size="large"
        >
          <Form.Item label="登录方式">
            <Radio.Group 
              value={loginType} 
              onChange={(e) => {
                setLoginType(e.target.value);
                // 清除另一种登录方式的值
                if (e.target.value === 'email') {
                  form.setFieldValue('phone', undefined);
                } else {
                  form.setFieldValue('email', undefined);
                }
              }}
              disabled={isLoading || isRateLimited}
            >
              <Radio value="email">邮箱登录</Radio>
              <Radio value="phone">手机登录</Radio>
            </Radio.Group>
          </Form.Item>

          {loginType === 'email' ? (
            <Form.Item
              label="邮箱地址"
              name="email"
              rules={[
                { required: true, message: '请输入您的邮箱地址' },
                { type: 'email', message: '请输入有效的邮箱地址' }
              ]}
            >
              <Input
                prefix={<MailOutlined aria-hidden="true" />}
                placeholder="请输入邮箱地址"
                autoComplete="email"
                disabled={isLoading || isRateLimited}
                aria-describedby={error ? 'email-error' : undefined}
                aria-invalid={!!error}
              />
            </Form.Item>
          ) : (
            <Form.Item
              label="手机号码"
              name="phone"
              rules={[
                { required: true, message: '请输入您的手机号码' },
                { pattern: /^1[3-9]\d{9}$/, message: '请输入有效的手机号码' }
              ]}
            >
              <Input
                prefix={<PhoneOutlined aria-hidden="true" />}
                placeholder="请输入手机号码"
                autoComplete="tel"
                disabled={isLoading || isRateLimited}
                aria-describedby={error ? 'phone-error' : undefined}
                aria-invalid={!!error}
              />
            </Form.Item>
          )}

          <Form.Item
            label="密码"
            name="password"
            rules={[
              { required: true, message: '请输入您的密码' },
              { min: 6, message: '密码长度至少为6个字符' }
            ]}
          >
            <Input.Password
              prefix={<LockOutlined aria-hidden="true" />}
              placeholder="请输入密码"
              autoComplete="current-password"
              iconRender={(visible) => (visible ? <EyeTwoTone /> : <EyeInvisibleOutlined />)}
              disabled={isLoading || isRateLimited}
              aria-describedby={error ? 'password-error' : undefined}
              aria-invalid={!!error}
            />
          </Form.Item>

          <Form.Item>
            <div className="login-options">
              <Checkbox
                checked={rememberMe}
                onChange={(e) => setRememberMe(e.target.checked)}
                disabled={isLoading || isRateLimited}
              >
                记住我
              </Checkbox>
              <Link to="/forgot-password" className="forgot-password-link">
                忘记密码？
              </Link>
            </div>
          </Form.Item>

          <Form.Item>
            <Button
              type="primary"
              htmlType="submit"
              loading={isLoading}
              disabled={isRateLimited}
              className="login-button"
              block
            >
              {isLoading ? '登录中...' : '登录'}
            </Button>
          </Form.Item>
        </Form>

        <Divider>或</Divider>

        <div className="register-prompt">
          <span>还没有账户？</span>
          <Link to="/register" className="register-link">
            立即注册
          </Link>
        </div>
      </Card>
    </div>
  );
};

export default Login;