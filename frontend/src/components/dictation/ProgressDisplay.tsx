import React from 'react';
import { Card, Progress, Statistic, Space, Tag, Row, Col, Typography } from 'antd';
import { 
  CheckCircleOutlined, 
  ClockCircleOutlined, 
  SoundOutlined, 
  BulbOutlined,
  TrophyOutlined,
  AimOutlined
} from '@ant-design/icons';
import type { DictationProgress } from '../../types/dictation';
import './ProgressDisplay.css';

const { Text, Title } = Typography;

interface ProgressDisplayProps {
  progress: DictationProgress;
  className?: string;
  showDetails?: boolean;
}

const ProgressDisplay: React.FC<ProgressDisplayProps> = ({
  progress,
  className = '',
  showDetails = true
}) => {
  const {
    totalWords,
    completedWords,
    correctWords,
    hintsUsed,
    audioPlays,
    timeSpent,
    accuracy
  } = progress;

  // 计算完成百分比
  const completionPercentage = totalWords > 0 ? Math.round((completedWords / totalWords) * 100) : 0;
  
  // 计算正确率
  const correctPercentage = completedWords > 0 ? Math.round((correctWords / completedWords) * 100) : 0;
  
  // 格式化时间
  const formatTime = (seconds: number): string => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}分${secs}秒`;
  };

  // 获取准确率颜色
  const getAccuracyColor = (accuracy: number): string => {
    if (accuracy >= 90) return '#52c41a';
    if (accuracy >= 70) return '#faad14';
    if (accuracy >= 50) return '#fa8c16';
    return '#ff4d4f';
  };

  // 获取进度状态
  const getProgressStatus = (percentage: number) => {
    if (percentage === 100) return 'success';
    if (percentage >= 70) return 'active';
    return 'normal';
  };

  return (
    <div className={`progress-display ${className}`}>
      {/* 主要进度显示 */}
      <Card className="main-progress-card" size="small">
        <div className="progress-header">
          <Title level={4} style={{ margin: 0 }}>
            <AimOutlined style={{ color: '#1890ff', marginRight: 8 }} />
            练习进度
          </Title>
        </div>
        
        <div className="progress-main">
          <Progress
            type="circle"
            percent={completionPercentage}
            size={120}
            status={getProgressStatus(completionPercentage)}
            format={() => (
              <div className="progress-center">
                <div className="completion-text">{completionPercentage}%</div>
                <div className="completion-label">完成</div>
              </div>
            )}
          />
          
          <div className="progress-stats">
            <Space direction="vertical" size="small" style={{ width: '100%' }}>
              <div className="stat-item">
                <Text type="secondary">进度：</Text>
                <Text strong>{completedWords} / {totalWords} 个单词</Text>
              </div>
              
              <div className="stat-item">
                <Text type="secondary">正确：</Text>
                <Text strong style={{ color: getAccuracyColor(correctPercentage) }}>
                  {correctWords} 个 ({correctPercentage}%)
                </Text>
              </div>
              
              <div className="stat-item">
                <Text type="secondary">用时：</Text>
                <Text strong>{formatTime(timeSpent)}</Text>
              </div>
            </Space>
          </div>
        </div>
      </Card>

      {/* 详细统计 */}
      {showDetails && (
        <Card className="details-card" size="small" title="详细统计">
          <Row gutter={[16, 16]}>
            <Col xs={12} sm={6}>
              <Statistic
                title="总体准确率"
                value={accuracy}
                suffix="%"
                valueStyle={{ color: getAccuracyColor(accuracy) }}
                prefix={<TrophyOutlined />}
              />
            </Col>
            
            <Col xs={12} sm={6}>
              <Statistic
                title="音频播放"
                value={audioPlays}
                suffix="次"
                prefix={<SoundOutlined />}
                valueStyle={{ color: '#1890ff' }}
              />
            </Col>
            
            <Col xs={12} sm={6}>
              <Statistic
                title="使用提示"
                value={hintsUsed}
                suffix="次"
                prefix={<BulbOutlined />}
                valueStyle={{ color: '#faad14' }}
              />
            </Col>
            
            <Col xs={12} sm={6}>
              <Statistic
                title="练习时长"
                value={formatTime(timeSpent)}
                prefix={<ClockCircleOutlined />}
                valueStyle={{ color: '#722ed1' }}
              />
            </Col>
          </Row>
          
          {/* 成就标签 */}
          <div className="achievement-tags">
            <Space wrap>
              {accuracy >= 100 && (
                <Tag color="gold" icon={<TrophyOutlined />}>
                  完美表现
                </Tag>
              )}
              {accuracy >= 90 && (
                <Tag color="green" icon={<CheckCircleOutlined />}>
                  优秀
                </Tag>
              )}
              {hintsUsed === 0 && completedWords > 0 && (
                <Tag color="blue">
                  无提示完成
                </Tag>
              )}
              {audioPlays <= 2 && completedWords > 0 && (
                <Tag color="purple">
                  听力达人
                </Tag>
              )}
              {timeSpent < totalWords * 10 && completedWords === totalWords && (
                <Tag color="orange">
                  速度之星
                </Tag>
              )}
            </Space>
          </div>
        </Card>
      )}
      
      {/* 正确率进度条 */}
      <Card className="accuracy-card" size="small">
        <div className="accuracy-header">
          <Text strong>正确率分析</Text>
        </div>
        
        <div className="accuracy-progress">
          <div className="accuracy-item">
            <Text type="secondary">已完成单词正确率：</Text>
            <Progress
              percent={correctPercentage}
              strokeColor={getAccuracyColor(correctPercentage)}
              size="small"
              format={(percent) => `${correctWords}/${completedWords} (${percent}%)`}
            />
          </div>
          
          <div className="accuracy-item">
            <Text type="secondary">总体完成度：</Text>
            <Progress
              percent={completionPercentage}
              strokeColor={completionPercentage === 100 ? '#52c41a' : '#1890ff'}
              size="small"
              format={(percent) => `${completedWords}/${totalWords} (${percent}%)`}
            />
          </div>
        </div>
      </Card>
    </div>
  );
};

export default ProgressDisplay;