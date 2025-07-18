/**
 * Practice Progress Header Component
 * 
 * 显示听写练习的整体进度信息
 */

import React from 'react';
import { Progress, Card, Space, Tag, Statistic, Row, Col } from 'antd';
import { 
  TrophyOutlined, 
  ClockCircleOutlined, 
  CheckCircleOutlined,
  SoundOutlined 
} from '@ant-design/icons';
import type { DictationProgress } from '../../types/dictation';
import './PracticeProgressHeader.css';

interface PracticeProgressHeaderProps {
  currentSentenceIndex: number;
  totalSentences: number;
  sentenceProgress: DictationProgress;
  timeSpent: number; // 已花费时间（秒）
  className?: string;
}

export const PracticeProgressHeader: React.FC<PracticeProgressHeaderProps> = ({
  currentSentenceIndex,
  totalSentences,
  sentenceProgress,
  timeSpent,
  className = ''
}) => {
  // 计算整体进度百分比
  const overallProgress = totalSentences > 0 ? ((currentSentenceIndex) / totalSentences) * 100 : 0;
  
  // 当前句子的进度百分比
  const currentSentenceProgressPercent = sentenceProgress.totalWords > 0 
    ? (sentenceProgress.completedWords / sentenceProgress.totalWords) * 100 
    : 0;
  
  // 格式化时间显示
  const formatTime = (seconds: number): string => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  // 计算准确率
  const accuracy = sentenceProgress.totalWords > 0 
    ? Math.round((sentenceProgress.correctWords / sentenceProgress.totalWords) * 100)
    : 0;

  return (
    <div className={`practice-progress-header ${className}`}>
      <Card className="progress-card" bodyStyle={{ padding: '16px 24px' }}>
        {/* 主要进度信息 */}
        <div className="main-progress-section">
          <div className="progress-title">
            <Space>
              <TrophyOutlined className="progress-icon" />
              <span className="title-text">听写练习进度</span>
              <Tag color="blue" className="current-sentence-tag">
                第 {currentSentenceIndex + 1} / {totalSentences} 句
              </Tag>
            </Space>
          </div>
          
          {/* 整体进度条 */}
          <div className="overall-progress">
            <div className="progress-label">
              <span>整体进度</span>
              <span className="progress-percentage">
                {Math.round(overallProgress)}%
              </span>
            </div>
            <Progress 
              percent={overallProgress} 
              showInfo={false}
              strokeColor={{
                '0%': '#108ee9',
                '100%': '#87d068',
              }}
              className="overall-progress-bar"
            />
          </div>
          
          {/* 当前句子进度条 */}
          <div className="current-sentence-progress">
            <div className="progress-label">
              <span>当前句子</span>
              <span className="progress-percentage">
                {Math.round(currentSentenceProgressPercent)}%
              </span>
            </div>
            <Progress 
              percent={currentSentenceProgressPercent} 
              showInfo={false}
              strokeColor="#52c41a"
              className="sentence-progress-bar"
            />
          </div>
        </div>

        {/* 统计信息 */}
        <Row gutter={24} className="stats-section">
          <Col span={6}>
            <Statistic
              title="已完成单词"
              value={sentenceProgress.completedWords}
              suffix={`/ ${sentenceProgress.totalWords}`}
              prefix={<CheckCircleOutlined style={{ color: '#52c41a' }} />}
              valueStyle={{ fontSize: '16px' }}
            />
          </Col>
          <Col span={6}>
            <Statistic
              title="准确率"
              value={accuracy}
              suffix="%"
              prefix={<TrophyOutlined style={{ color: '#faad14' }} />}
              valueStyle={{ 
                fontSize: '16px', 
                color: accuracy >= 80 ? '#52c41a' : accuracy >= 60 ? '#faad14' : '#ff4d4f' 
              }}
            />
          </Col>
          <Col span={6}>
            <Statistic
              title="用时"
              value={formatTime(timeSpent)}
              prefix={<ClockCircleOutlined style={{ color: '#1890ff' }} />}
              valueStyle={{ fontSize: '16px' }}
            />
          </Col>
          <Col span={6}>
            <Statistic
              title="播放次数"
              value={sentenceProgress.audioPlays}
              prefix={<SoundOutlined style={{ color: '#722ed1' }} />}
              valueStyle={{ fontSize: '16px' }}
            />
          </Col>
        </Row>

        {/* 额外信息 */}
        <div className="additional-info">
          <Space>
            {sentenceProgress.hintsUsed > 0 && (
              <Tag color="orange">
                使用提示 {sentenceProgress.hintsUsed} 次
              </Tag>
            )}
            {accuracy >= 90 && (
              <Tag color="green">
                表现优秀！
              </Tag>
            )}
            {sentenceProgress.audioPlays > 3 && (
              <Tag color="purple">
                多次播放
              </Tag>
            )}
          </Space>
        </div>
      </Card>
    </div>
  );
};