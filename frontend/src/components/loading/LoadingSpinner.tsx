/**
 * Loading Spinner Component
 * 
 * Reusable loading indicator with different sizes and variants
 */

import React from 'react';
import { Spin, Typography } from 'antd';
import { LoadingOutlined } from '@ant-design/icons';
import './LoadingSpinner.css';

const { Text } = Typography;

interface LoadingSpinnerProps {
  size?: 'small' | 'default' | 'large';
  message?: string;
  variant?: 'default' | 'overlay' | 'inline' | 'fullscreen';
  spinning?: boolean;
  delay?: number;
  className?: string;
  children?: React.ReactNode;
}

const LoadingSpinner: React.FC<LoadingSpinnerProps> = ({
  size = 'default',
  message,
  variant = 'default',
  spinning = true,
  delay = 0,
  className = '',
  children,
}) => {
  const customIcon = <LoadingOutlined style={{ fontSize: getSizeValue(size) }} spin />;

  const spinnerElement = (
    <Spin
      indicator={customIcon}
      size={size}
      spinning={spinning}
      delay={delay}
      className={`loading-spinner ${variant} ${className}`}
    >
      {children}
    </Spin>
  );

  switch (variant) {
    case 'overlay':
      return (
        <div className="loading-overlay">
          <div className="loading-content">
            {spinnerElement}
            {message && (
              <Text className="loading-message" type="secondary">
                {message}
              </Text>
            )}
          </div>
        </div>
      );

    case 'fullscreen':
      return (
        <div className="loading-fullscreen">
          <div className="loading-content">
            {spinnerElement}
            {message && (
              <Text className="loading-message" type="secondary">
                {message}
              </Text>
            )}
          </div>
        </div>
      );

    case 'inline':
      return (
        <div className="loading-inline">
          {spinnerElement}
          {message && (
            <Text className="loading-message loading-message-inline" type="secondary">
              {message}
            </Text>
          )}
        </div>
      );

    default:
      return (
        <div className="loading-default">
          {spinnerElement}
          {message && (
            <Text className="loading-message" type="secondary">
              {message}
            </Text>
          )}
        </div>
      );
  }
};

function getSizeValue(size: 'small' | 'default' | 'large'): number {
  switch (size) {
    case 'small':
      return 16;
    case 'large':
      return 32;
    default:
      return 24;
  }
}

// Skeleton loading component for content placeholders
interface SkeletonLoaderProps {
  rows?: number;
  avatar?: boolean;
  title?: boolean;
  paragraph?: boolean;
  active?: boolean;
  className?: string;
}

export const SkeletonLoader: React.FC<SkeletonLoaderProps> = ({
  rows = 3,
  avatar = false,
  title = true,
  paragraph = true,
  active = true,
  className = '',
}) => {
  return (
    <div className={`skeleton-loader ${className}`}>
      <div className="skeleton-content">
        {avatar && <div className="skeleton-avatar" />}
        <div className="skeleton-text">
          {title && <div className="skeleton-title" />}
          {paragraph && (
            <div className="skeleton-paragraph">
              {Array.from({ length: rows }, (_, index) => (
                <div 
                  key={index} 
                  className={`skeleton-line ${active ? 'skeleton-animate' : ''}`}
                  style={{ 
                    width: index === rows - 1 ? '60%' : '100%' 
                  }}
                />
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

// Progress loading component
interface ProgressLoaderProps {
  progress: number;
  message?: string;
  showPercentage?: boolean;
  size?: 'small' | 'default' | 'large';
  className?: string;
}

export const ProgressLoader: React.FC<ProgressLoaderProps> = ({
  progress,
  message,
  showPercentage = true,
  size = 'default',
  className = '',
}) => {
  return (
    <div className={`progress-loader ${size} ${className}`}>
      <div className="progress-bar">
        <div 
          className="progress-fill" 
          style={{ width: `${Math.min(100, Math.max(0, progress))}%` }}
        />
      </div>
      <div className="progress-info">
        {message && (
          <Text className="progress-message" type="secondary">
            {message}
          </Text>
        )}
        {showPercentage && (
          <Text className="progress-percentage" type="secondary">
            {Math.round(progress)}%
          </Text>
        )}
      </div>
    </div>
  );
};

export default LoadingSpinner;