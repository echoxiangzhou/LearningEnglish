/**
 * Error Boundary Component
 * 
 * Catches JavaScript errors anywhere in the child component tree and displays a fallback UI
 */

import React, { Component, ReactNode } from 'react';
import { Result, Button, Typography, Card } from 'antd';
import { ExclamationCircleOutlined, ReloadOutlined, HomeOutlined } from '@ant-design/icons';
import './ErrorBoundary.css';

const { Paragraph, Text } = Typography;

interface Props {
  children: ReactNode;
  fallback?: ReactNode;
  onError?: (error: Error, errorInfo: React.ErrorInfo) => void;
}

interface State {
  hasError: boolean;
  error: Error | null;
  errorInfo: React.ErrorInfo | null;
  errorId: string;
}

class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      hasError: false,
      error: null,
      errorInfo: null,
      errorId: '',
    };
  }

  static getDerivedStateFromError(error: Error): Partial<State> {
    // Update state so the next render will show the fallback UI
    return {
      hasError: true,
      error,
      errorId: Date.now().toString(36),
    };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    this.setState({
      error,
      errorInfo,
    });

    // Log error to external service
    this.logErrorToService(error, errorInfo);

    // Call custom error handler if provided
    if (this.props.onError) {
      this.props.onError(error, errorInfo);
    }
  }

  private logErrorToService = (error: Error, errorInfo: React.ErrorInfo) => {
    // In a real app, you would send this to your error tracking service
    console.group('🚨 Error Boundary Caught an Error');
    console.error('Error:', error);
    console.error('Error Info:', errorInfo);
    console.error('Component Stack:', errorInfo.componentStack);
    console.groupEnd();

    // Example: Send to error tracking service
    // errorTrackingService.logError(error, {
    //   componentStack: errorInfo.componentStack,
    //   userId: getCurrentUserId(),
    //   timestamp: new Date().toISOString(),
    //   userAgent: navigator.userAgent,
    //   url: window.location.href,
    // });
  };

  private handleReload = () => {
    window.location.reload();
  };

  private handleGoHome = () => {
    window.location.href = '/dashboard';
  };

  private handleRetry = () => {
    this.setState({
      hasError: false,
      error: null,
      errorInfo: null,
      errorId: '',
    });
  };

  private copyErrorDetails = () => {
    const { error, errorInfo, errorId } = this.state;
    const errorDetails = `
错误ID: ${errorId}
时间: ${new Date().toISOString()}
错误信息: ${error?.message}
错误堆栈: ${error?.stack}
组件堆栈: ${errorInfo?.componentStack}
用户代理: ${navigator.userAgent}
页面地址: ${window.location.href}
    `.trim();

    navigator.clipboard.writeText(errorDetails).then(() => {
      alert('错误详情已复制到剪贴板');
    }).catch(() => {
      console.error('Failed to copy error details');
    });
  };

  render() {
    if (this.state.hasError) {
      // Custom fallback UI
      if (this.props.fallback) {
        return this.props.fallback;
      }

      // Default error UI
      return (
        <div className="error-boundary-container">
          <Card className="error-boundary-card">
            <Result
              status="error"
              icon={<ExclamationCircleOutlined />}
              title="页面出现错误"
              subTitle="抱歉，页面遇到了意外错误。我们已经记录了这个问题，请尝试刷新页面或返回首页。"
              extra={[
                <Button 
                  type="primary" 
                  icon={<ReloadOutlined />} 
                  onClick={this.handleRetry}
                  key="retry"
                >
                  重试
                </Button>,
                <Button 
                  icon={<ReloadOutlined />} 
                  onClick={this.handleReload}
                  key="reload"
                >
                  刷新页面
                </Button>,
                <Button 
                  icon={<HomeOutlined />} 
                  onClick={this.handleGoHome}
                  key="home"
                >
                  返回首页
                </Button>,
              ]}
            />
            
            {/* Error Details (for development/debugging) */}
            {import.meta.env.DEV && this.state.error && (
              <Card 
                title="错误详情 (开发模式)" 
                className="error-details-card"
                size="small"
                extra={
                  <Button size="small" onClick={this.copyErrorDetails}>
                    复制错误信息
                  </Button>
                }
              >
                <div className="error-details">
                  <Paragraph>
                    <Text strong>错误ID:</Text> {this.state.errorId}
                  </Paragraph>
                  <Paragraph>
                    <Text strong>错误信息:</Text>
                    <Text code>{this.state.error.message}</Text>
                  </Paragraph>
                  {this.state.error.stack && (
                    <Paragraph>
                      <Text strong>错误堆栈:</Text>
                      <pre className="error-stack">
                        {this.state.error.stack}
                      </pre>
                    </Paragraph>
                  )}
                  {this.state.errorInfo?.componentStack && (
                    <Paragraph>
                      <Text strong>组件堆栈:</Text>
                      <pre className="error-stack">
                        {this.state.errorInfo.componentStack}
                      </pre>
                    </Paragraph>
                  )}
                </div>
              </Card>
            )}
          </Card>
        </div>
      );
    }

    return this.props.children;
  }
}

export default ErrorBoundary;