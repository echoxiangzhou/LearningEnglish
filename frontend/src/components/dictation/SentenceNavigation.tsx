import React from 'react';
import { Button, Space, Tooltip } from 'antd';
import { LeftOutlined, RightOutlined } from '@ant-design/icons';
import './SentenceNavigation.css';

interface SentenceNavigationProps {
  currentIndex: number;
  totalSentences: number;
  onPrevious: () => void;
  onNext: () => void;
  disabled?: boolean;
  className?: string;
}

const SentenceNavigation: React.FC<SentenceNavigationProps> = ({
  currentIndex,
  totalSentences,
  onPrevious,
  onNext,
  disabled = false,
  className = ''
}) => {
  const hasPrevious = currentIndex > 0;
  const hasNext = currentIndex < totalSentences - 1;

  return (
    <div className={`sentence-navigation ${className}`}>
      <Space size="large" className="navigation-controls">
        <Tooltip title="上一个句子 (Ctrl + ←)">
          <Button
            type="default"
            size="large"
            icon={<LeftOutlined />}
            onClick={onPrevious}
            disabled={disabled || !hasPrevious}
            className="nav-button prev-button"
          >
            上一个
          </Button>
        </Tooltip>

        <div className="sentence-indicator">
          <span className="current-sentence">{currentIndex + 1}</span>
          <span className="separator">/</span>
          <span className="total-sentences">{totalSentences}</span>
        </div>

        <Tooltip title="下一个句子 (Ctrl + →)">
          <Button
            type="default"
            size="large"
            icon={<RightOutlined />}
            onClick={onNext}
            disabled={disabled || !hasNext}
            className="nav-button next-button"
          >
            下一个
          </Button>
        </Tooltip>
      </Space>

      <div className="keyboard-shortcuts-hint">
        <Space split={<span>|</span>} size="small">
          <span><kbd>Ctrl</kbd> + <kbd>←</kbd> 上一个句子</span>
          <span><kbd>Ctrl</kbd> + <kbd>→</kbd> 下一个句子</span>
        </Space>
      </div>
    </div>
  );
};

export default SentenceNavigation;