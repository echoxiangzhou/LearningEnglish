/**
 * Error Handling Service
 * 
 * Centralized error handling, logging, and user notification system
 */

import { message, notification } from 'antd';
import { AxiosError } from 'axios';

export interface AppError {
  id: string;
  type: 'network' | 'validation' | 'authentication' | 'authorization' | 'server' | 'client' | 'unknown';
  message: string;
  details?: any;
  timestamp: string;
  userId?: string;
  url?: string;
  userAgent?: string;
  stack?: string;
}

export interface ErrorHandlerOptions {
  showNotification?: boolean;
  logToConsole?: boolean;
  logToService?: boolean;
  notificationType?: 'message' | 'notification';
  severity?: 'low' | 'medium' | 'high' | 'critical';
}

class ErrorService {
  private errorQueue: AppError[] = [];
  private maxQueueSize = 100;
  private retryAttempts = new Map<string, number>();
  private maxRetries = 3;

  /**
   * Handle different types of errors with appropriate user feedback
   */
  public handleError(
    error: Error | AxiosError | any,
    context?: string,
    options: ErrorHandlerOptions = {}
  ): AppError {
    const {
      showNotification = true,
      logToConsole = true,
      logToService = true,
      notificationType = 'notification',
      severity = 'medium'
    } = options;

    const appError = this.createAppError(error, context);

    // Log error
    if (logToConsole) {
      this.logToConsole(appError, severity);
    }

    if (logToService) {
      this.logToService(appError);
    }

    // Show user notification
    if (showNotification) {
      this.showUserNotification(appError, notificationType);
    }

    // Add to error queue
    this.addToQueue(appError);

    return appError;
  }

  /**
   * Handle API errors specifically
   */
  public handleApiError(
    error: AxiosError,
    context?: string,
    options: ErrorHandlerOptions = {}
  ): AppError {
    const appError = this.createApiError(error, context);
    
    // Special handling for different HTTP status codes
    switch (error.response?.status) {
      case 401:
        this.handleUnauthorizedError(appError);
        break;
      case 403:
        this.handleForbiddenError(appError);
        break;
      case 404:
        this.handleNotFoundError(appError);
        break;
      case 429:
        this.handleRateLimitError(appError);
        break;
      case 500:
      case 502:
      case 503:
      case 504:
        this.handleServerError(appError, error.response?.status);
        break;
      default:
        this.handleError(appError, context, options);
    }

    return appError;
  }

  /**
   * Handle validation errors
   */
  public handleValidationError(
    errors: Record<string, string[]>,
    context?: string
  ): AppError {
    const errorMessages = Object.entries(errors)
      .map(([field, messages]) => `${field}: ${messages.join(', ')}`)
      .join('; ');

    const appError = this.createAppError(
      new Error(`验证失败: ${errorMessages}`),
      context
    );
    appError.type = 'validation';
    appError.details = errors;

    // Show validation errors as messages
    Object.entries(errors).forEach(([field, messages]) => {
      messages.forEach(msg => {
        message.error(`${field}: ${msg}`);
      });
    });

    this.logToConsole(appError, 'low');
    this.addToQueue(appError);

    return appError;
  }

  /**
   * Handle network errors
   */
  public handleNetworkError(error: Error, context?: string): AppError {
    const appError = this.createAppError(error, context);
    appError.type = 'network';

    notification.error({
      message: '网络连接错误',
      description: '请检查您的网络连接并重试',
      duration: 5,
    });

    this.logToConsole(appError, 'high');
    this.addToQueue(appError);

    return appError;
  }

  /**
   * Get error statistics
   */
  public getErrorStats(): {
    total: number;
    byType: Record<string, number>;
    recentErrors: AppError[];
  } {
    const byType = this.errorQueue.reduce((acc, error) => {
      acc[error.type] = (acc[error.type] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);

    const recentErrors = this.errorQueue
      .slice(-10)
      .sort((a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime());

    return {
      total: this.errorQueue.length,
      byType,
      recentErrors,
    };
  }

  /**
   * Clear error queue
   */
  public clearErrorQueue(): void {
    this.errorQueue = [];
    this.retryAttempts.clear();
  }

  /**
   * Retry failed operation
   */
  public async retryOperation<T>(
    operation: () => Promise<T>,
    errorId: string,
    maxRetries: number = this.maxRetries
  ): Promise<T> {
    const attempts = this.retryAttempts.get(errorId) || 0;
    
    if (attempts >= maxRetries) {
      throw new Error(`操作失败，已达到最大重试次数 (${maxRetries})`);
    }

    try {
      const result = await operation();
      this.retryAttempts.delete(errorId);
      return result;
    } catch (error) {
      this.retryAttempts.set(errorId, attempts + 1);
      
      // Exponential backoff
      const delay = Math.pow(2, attempts) * 1000;
      await new Promise(resolve => setTimeout(resolve, delay));
      
      return this.retryOperation(operation, errorId, maxRetries);
    }
  }

  // Private methods

  private createAppError(error: Error | any, context?: string): AppError {
    return {
      id: this.generateErrorId(),
      type: this.determineErrorType(error),
      message: this.extractErrorMessage(error),
      details: error,
      timestamp: new Date().toISOString(),
      userId: this.getCurrentUserId(),
      url: window.location.href,
      userAgent: navigator.userAgent,
      stack: error?.stack,
    };
  }

  private createApiError(error: AxiosError, context?: string): AppError {
    const appError = this.createAppError(error, context);
    appError.type = 'network';
    
    if (error.response) {
      appError.details = {
        status: error.response.status,
        statusText: error.response.statusText,
        data: error.response.data,
        headers: error.response.headers,
      };
    }

    return appError;
  }

  private determineErrorType(error: any): AppError['type'] {
    if (error?.name === 'ValidationError') return 'validation';
    if (error?.response?.status === 401) return 'authentication';
    if (error?.response?.status === 403) return 'authorization';
    if (error?.response?.status >= 500) return 'server';
    if (error?.response?.status >= 400) return 'client';
    if (error?.code === 'NETWORK_ERROR') return 'network';
    return 'unknown';
  }

  private extractErrorMessage(error: any): string {
    if (typeof error === 'string') return error;
    if (error?.response?.data?.message) return error.response.data.message;
    if (error?.response?.data?.error) return error.response.data.error;
    if (error?.message) return error.message;
    return '发生了未知错误';
  }

  private generateErrorId(): string {
    return `error_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  }

  private getCurrentUserId(): string | undefined {
    // Get from Redux store or local storage
    try {
      const userJson = localStorage.getItem('user');
      if (userJson) {
        const user = JSON.parse(userJson);
        return user.id?.toString();
      }
    } catch {
      // Ignore parsing errors
    }
    return undefined;
  }

  private logToConsole(error: AppError, severity: string): void {
    const logMethod = severity === 'critical' || severity === 'high' ? 'error' : 'warn';
    
    console.group(`🚨 ${severity.toUpperCase()} Error - ${error.id}`);
    console[logMethod]('Message:', error.message);
    console[logMethod]('Type:', error.type);
    console[logMethod]('Timestamp:', error.timestamp);
    console[logMethod]('URL:', error.url);
    if (error.userId) console[logMethod]('User ID:', error.userId);
    if (error.stack) console[logMethod]('Stack:', error.stack);
    if (error.details) console[logMethod]('Details:', error.details);
    console.groupEnd();
  }

  private async logToService(error: AppError): Promise<void> {
    // In a real app, send to your error tracking service
    try {
      // Example: await errorTrackingAPI.logError(error);
    } catch (loggingError) {
      console.warn('Failed to log error to service:', loggingError);
    }
  }

  private showUserNotification(error: AppError, type: 'message' | 'notification'): void {
    const userMessage = this.getUserFriendlyMessage(error);

    if (type === 'message') {
      message.error(userMessage);
    } else {
      notification.error({
        message: '操作失败',
        description: userMessage,
        duration: 5,
      });
    }
  }

  private getUserFriendlyMessage(error: AppError): string {
    switch (error.type) {
      case 'network':
        return '网络连接失败，请检查您的网络设置';
      case 'authentication':
        return '身份验证失败，请重新登录';
      case 'authorization':
        return '您没有权限执行此操作';
      case 'validation':
        return '输入数据不符合要求，请检查后重试';
      case 'server':
        return '服务器暂时无法处理请求，请稍后重试';
      default:
        return error.message || '操作失败，请重试';
    }
  }

  private addToQueue(error: AppError): void {
    this.errorQueue.push(error);
    
    // Keep queue size manageable
    if (this.errorQueue.length > this.maxQueueSize) {
      this.errorQueue = this.errorQueue.slice(-this.maxQueueSize);
    }
  }

  private handleUnauthorizedError(error: AppError): void {
    notification.error({
      message: '身份验证失败',
      description: '您的登录状态已过期，请重新登录',
      duration: 0,
      key: 'auth-error',
    });

    // Redirect to login after a delay
    setTimeout(() => {
      window.location.href = '/login';
    }, 2000);
  }

  private handleForbiddenError(error: AppError): void {
    notification.error({
      message: '访问被拒绝',
      description: '您没有权限访问此资源',
      duration: 5,
    });
  }

  private handleNotFoundError(error: AppError): void {
    message.error('请求的资源不存在');
  }

  private handleRateLimitError(error: AppError): void {
    notification.warning({
      message: '请求过于频繁',
      description: '请稍后再试',
      duration: 3,
    });
  }

  private handleServerError(error: AppError, status?: number): void {
    notification.error({
      message: '服务器错误',
      description: `服务器暂时无法处理请求 (${status})，请稍后重试`,
      duration: 5,
    });
  }
}

// Export singleton instance
export const errorService = new ErrorService();

// Utility functions
export const withErrorHandling = async <T>(
  operation: () => Promise<T>,
  context?: string,
  options?: ErrorHandlerOptions
): Promise<T | null> => {
  try {
    return await operation();
  } catch (error) {
    errorService.handleError(error, context, options);
    return null;
  }
};

export const createErrorHandler = (
  context: string,
  options?: ErrorHandlerOptions
) => {
  return (error: any) => errorService.handleError(error, context, options);
};