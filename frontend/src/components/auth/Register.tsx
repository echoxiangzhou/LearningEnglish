import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { Form, Input, Button, Card, Alert, Select, Divider, Checkbox, Radio, Space } from 'antd';
import { UserOutlined, LockOutlined, MailOutlined, PhoneOutlined, EyeInvisibleOutlined, EyeTwoTone } from '@ant-design/icons';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { registerAsync, clearError } from '../../store/slices/authSlice';
import type { RegisterData } from '../../services/authService';
import './Register.css';

const { Option } = Select;

const Register: React.FC = () => {
  const [form] = Form.useForm();
  const [acceptTerms, setAcceptTerms] = useState(false);
  const [contactType, setContactType] = useState<'email' | 'phone'>('email');
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  
  const { isLoading, error, isAuthenticated } = useAppSelector(state => state.auth);
  
  // Redirect if already authenticated
  useEffect(() => {
    if (isAuthenticated) {
      navigate('/dashboard', { replace: true });
    }
  }, [isAuthenticated, navigate]);

  // Clear error when component unmounts
  useEffect(() => {
    return () => {
      if (error) {
        dispatch(clearError());
      }
    };
  }, [dispatch, error]);

  const handleSubmit = async (values: RegisterData) => {
    if (!acceptTerms) {
      return;
    }

    try {
      // 设置默认角色为学生
      const registerData = {
        ...values,
        role: 'student' as const
      };
      
      const result = await dispatch(registerAsync(registerData)).unwrap();
      
      // 根据注册方式决定跳转页面
      if (contactType === 'email') {
        navigate('/verify-email', {
          state: {
            email: values.email,
            fromRegistration: true
          }
        });
      } else {
        // 手机号注册，跳转到短信验证页面
        navigate('/verify-phone', {
          state: {
            phone: values.phone,
            fromRegistration: true
          }
        });
      }
    } catch (error) {
      // Error is handled by Redux state
      console.error('Registration error:', error);
    }
  };

  const handleFormFailed = (errorInfo: any) => {
    console.error('Form validation failed:', errorInfo);
  };

  const validatePassword = (_: any, value: string) => {
    if (!value || value.length < 6) {
      return Promise.reject(new Error('密码长度至少为6个字符'));
    }
    if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(value)) {
      return Promise.reject(new Error('密码必须包含大小写字母和数字'));
    }
    return Promise.resolve();
  };

  const validateConfirmPassword = (_: any, value: string) => {
    if (!value || form.getFieldValue('password') === value) {
      return Promise.resolve();
    }
    return Promise.reject(new Error('两次输入的密码不一致'));
  };

  return (
    <div className="register-container">
      <Card className="register-card" title="Smart English Learning">
        <div className="register-header">
          <h2>创建账户 Create Account</h2>
          <p>加入我们开始您的英语学习之旅</p>
        </div>

        {error && (
          <Alert
            message="注册失败"
            description={error}
            type="error"
            showIcon
            closable
            onClose={() => dispatch(clearError())}
            className="register-error"
          />
        )}

        <Form
          form={form}
          name="register"
          onFinish={handleSubmit}
          onFinishFailed={handleFormFailed}
          autoComplete="off"
          layout="vertical"
          size="large"
        >
          <div className="form-row">
            <Form.Item
              label="姓名"
              name="first_name"
              rules={[
                { required: true, message: '请输入您的姓名' },
                { min: 2, message: '姓名长度至少为2个字符' }
              ]}
            >
              <Input
                prefix={<UserOutlined />}
                placeholder="请输入姓名"
                autoComplete="given-name"
                disabled={isLoading}
              />
            </Form.Item>

            <Form.Item
              label="用户名"
              name="username"
              rules={[
                { required: true, message: '请输入用户名' },
                { min: 3, message: '用户名长度至少为3个字符' },
                { pattern: /^[a-zA-Z0-9_]+$/, message: '用户名只能包含字母、数字和下划线' }
              ]}
            >
              <Input
                prefix={<UserOutlined />}
                placeholder="请输入用户名"
                autoComplete="username"
                disabled={isLoading}
              />
            </Form.Item>
          </div>

          <Form.Item label="联系方式">
            <Radio.Group 
              value={contactType} 
              onChange={(e) => {
                setContactType(e.target.value);
                // 清除另一种联系方式的值
                if (e.target.value === 'email') {
                  form.setFieldValue('phone', undefined);
                } else {
                  form.setFieldValue('email', undefined);
                }
              }}
              disabled={isLoading}
            >
              <Space direction="vertical">
                <Radio value="email">邮箱地址</Radio>
                <Radio value="phone">手机号码</Radio>
              </Space>
            </Radio.Group>
          </Form.Item>

          {contactType === 'email' ? (
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
                placeholder="请输入邮箱地址"
                autoComplete="email"
                disabled={isLoading}
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
                prefix={<PhoneOutlined />}
                placeholder="请输入手机号码"
                autoComplete="tel"
                disabled={isLoading}
              />
            </Form.Item>
          )}

          <Form.Item
            label="密码"
            name="password"
            rules={[
              { required: true, message: '请输入密码' },
              { validator: validatePassword }
            ]}
          >
            <Input.Password
              prefix={<LockOutlined />}
              placeholder="请输入密码"
              autoComplete="new-password"
              iconRender={(visible) => (visible ? <EyeTwoTone /> : <EyeInvisibleOutlined />)}
              disabled={isLoading}
            />
          </Form.Item>

          <Form.Item
            label="确认密码"
            name="confirm_password"
            rules={[
              { required: true, message: '请确认密码' },
              { validator: validateConfirmPassword }
            ]}
          >
            <Input.Password
              prefix={<LockOutlined />}
              placeholder="请再次输入密码"
              autoComplete="new-password"
              iconRender={(visible) => (visible ? <EyeTwoTone /> : <EyeInvisibleOutlined />)}
              disabled={isLoading}
            />
          </Form.Item>

          <div className="password-requirements">
            <p>密码要求：</p>
            <ul>
              <li>至少6个字符</li>
              <li>包含大小写字母</li>
              <li>包含数字</li>
            </ul>
          </div>

          <Form.Item>
            <Checkbox
              checked={acceptTerms}
              onChange={(e) => setAcceptTerms(e.target.checked)}
              disabled={isLoading}
            >
              我同意
              <Link to="/terms" target="_blank" className="terms-link">
                服务条款
              </Link>
              和
              <Link to="/privacy" target="_blank" className="privacy-link">
                隐私政策
              </Link>
            </Checkbox>
          </Form.Item>

          <Form.Item>
            <Button
              type="primary"
              htmlType="submit"
              loading={isLoading}
              disabled={!acceptTerms}
              className="register-button"
              block
            >
              {isLoading ? '注册中...' : '创建账户'}
            </Button>
          </Form.Item>
        </Form>

        <Divider>或</Divider>

        <div className="login-prompt">
          <span>已有账户？</span>
          <Link to="/login" className="login-link">
            立即登录
          </Link>
        </div>
      </Card>
    </div>
  );
};

export default Register;