import React, { useState, useEffect } from 'react';
import {
  Card,
  Table,
  Tag,
  Progress,
  Statistic,
  Row,
  Col,
  Typography,
  Tooltip,
  Select,
  Button,
  Space,
  Modal,
  List,
  Alert,
  Divider
} from 'antd';
import {
  BarChartOutlined,
  TrophyOutlined,
  FireOutlined,
  BookOutlined,
  UserOutlined,
  ExclamationCircleOutlined,
  InfoCircleOutlined,
  CheckCircleOutlined
} from '@ant-design/icons';
// VocabularyBridgeService removed - using vocabularyManagementService directly
import { vocabularyManagementService } from '../../services/vocabularyManagementService';
import type { VocabularyWord } from '../../services/vocabularyManagementService';

const { Title, Text } = Typography;
const { Option } = Select;

interface VocabularyAnalyticsProps {
  selectedWord?: VocabularyWord;
  onClose?: () => void;
}

interface WordStats {
  totalLearners: number;
  masteryRate: number;
  averageDifficulty: number;
  commonMistakes: string[];
  learningProgress: {
    new: number;
    learning: number;
    reviewing: number;
    mastered: number;
  };
}

const VocabularyAnalytics: React.FC<VocabularyAnalyticsProps> = ({
  selectedWord,
  onClose
}) => {
  const [stats, setStats] = useState<WordStats | null>(null);
  const [loading, setLoading] = useState(false);
  const [showDetailModal, setShowDetailModal] = useState(false);

  useEffect(() => {
    if (selectedWord) {
      loadWordStats(selectedWord.id);
    }
  }, [selectedWord]);

  const loadWordStats = async (wordId: number) => {
    try {
      setLoading(true);
      // TODO: Replace with new analytics service
      // const wordStats = await VocabularyBridgeService.getWordLearningStats(wordId);
      const wordStats = null; // Temporarily disabled
      
      // 模拟学习进度数据
      const learningProgress = {
        new: Math.floor(wordStats.totalLearners * 0.3),
        learning: Math.floor(wordStats.totalLearners * 0.4),
        reviewing: Math.floor(wordStats.totalLearners * 0.2),
        mastered: Math.floor(wordStats.totalLearners * 0.1)
      };

      setStats({
        ...wordStats,
        learningProgress
      });
    } catch (error) {
      console.error('Failed to load word stats:', error);
    } finally {
      setLoading(false);
    }
  };

  const getMasteryColor = (rate: number) => {
    if (rate >= 0.8) return '#52c41a';
    if (rate >= 0.6) return '#faad14';
    return '#ff4d4f';
  };

  const renderLearningProgress = () => {
    if (!stats) return null;

    const progressData = [
      { status: '新学习', count: stats.learningProgress.new, color: '#1890ff' },
      { status: '学习中', count: stats.learningProgress.learning, color: '#faad14' },
      { status: '复习中', count: stats.learningProgress.reviewing, color: '#722ed1' },
      { status: '已掌握', count: stats.learningProgress.mastered, color: '#52c41a' }
    ];

    return (
      <Card title="学习进度分布" size="small">
        <Row gutter={[8, 8]}>
          {progressData.map((item, index) => (
            <Col key={index} span={6}>
              <Card size="small" className="text-center">
                <Statistic
                  title={item.status}
                  value={item.count}
                  valueStyle={{ color: item.color, fontSize: '18px' }}
                />
              </Card>
            </Col>
          ))}
        </Row>
        
        <Divider />
        
        <div style={{ textAlign: 'center' }}>
          <Progress
            type="circle"
            percent={Math.round((stats.learningProgress.mastered / stats.totalLearners) * 100)}
            format={percent => `${percent}%\n掌握率`}
            strokeColor={getMasteryColor(stats.masteryRate)}
          />
        </div>
      </Card>
    );
  };

  const renderCommonMistakes = () => {
    if (!stats || !stats.commonMistakes.length) {
      return (
        <Alert
          message="暂无常见错误数据"
          type="info"
          showIcon
        />
      );
    }

    return (
      <List
        size="small"
        dataSource={stats.commonMistakes}
        renderItem={(mistake, index) => (
          <List.Item>
            <Space>
              <ExclamationCircleOutlined style={{ color: '#ff4d4f' }} />
              <Text>{mistake}</Text>
            </Space>
          </List.Item>
        )}
      />
    );
  };

  if (!selectedWord) {
    return (
      <Card>
        <div style={{ textAlign: 'center', padding: '40px' }}>
          <BookOutlined style={{ fontSize: '48px', color: '#d9d9d9' }} />
          <Title level={4} type="secondary">选择一个单词查看学习分析</Title>
          <Text type="secondary">
            在词汇管理列表中点击单词来查看详细的学习统计数据
          </Text>
        </div>
      </Card>
    );
  }

  return (
    <div>
      <Card
        title={
          <Space>
            <BookOutlined />
            <span>单词学习分析: {selectedWord.word}</span>
            {onClose && (
              <Button type="text" onClick={onClose} size="small">
                关闭
              </Button>
            )}
          </Space>
        }
        extra={
          <Button onClick={() => setShowDetailModal(true)}>
            查看详情
          </Button>
        }
        loading={loading}
      >
        {stats && (
          <>
            {/* 概览统计 */}
            <Row gutter={[16, 16]} style={{ marginBottom: '24px' }}>
              <Col xs={12} sm={6}>
                <Card size="small">
                  <Statistic
                    title="学习人数"
                    value={stats.totalLearners}
                    prefix={<UserOutlined />}
                    valueStyle={{ color: '#1890ff' }}
                  />
                </Card>
              </Col>
              <Col xs={12} sm={6}>
                <Card size="small">
                  <Statistic
                    title="掌握率"
                    value={Math.round(stats.masteryRate * 100)}
                    suffix="%"
                    prefix={<TrophyOutlined />}
                    valueStyle={{ color: getMasteryColor(stats.masteryRate) }}
                  />
                </Card>
              </Col>
              <Col xs={12} sm={6}>
                <Card size="small">
                  <Statistic
                    title="平均难度"
                    value={stats.averageDifficulty.toFixed(1)}
                    prefix={<BarChartOutlined />}
                    valueStyle={{ color: '#722ed1' }}
                  />
                </Card>
              </Col>
              <Col xs={12} sm={6}>
                <Card size="small">
                  <Statistic
                    title="设定难度"
                    value={selectedWord.difficulty}
                    prefix={<FireOutlined />}
                    valueStyle={{ color: '#fa8c16' }}
                  />
                </Card>
              </Col>
            </Row>

            {/* 学习进度分布 */}
            <Row gutter={[16, 16]}>
              <Col xs={24} lg={14}>
                {renderLearningProgress()}
              </Col>
              <Col xs={24} lg={10}>
                <Card title="常见学习问题" size="small">
                  {renderCommonMistakes()}
                </Card>
              </Col>
            </Row>

            {/* 单词基本信息 */}
            <Card title="单词信息" size="small" style={{ marginTop: '16px' }}>
              <Row gutter={[16, 8]}>
                <Col span={8}>
                  <Text strong>单词:</Text> {selectedWord.word}
                </Col>
                <Col span={8}>
                  <Text strong>音标:</Text> {selectedWord.phonetic || '未设置'}
                </Col>
                <Col span={8}>
                  <Text strong>词性:</Text> {selectedWord.part_of_speech || '未设置'}
                </Col>
                <Col span={8}>
                  <Text strong>年级:</Text> {selectedWord.grade_level}年级
                </Col>
                <Col span={8}>
                  <Text strong>难度:</Text> 
                  <Tag color={selectedWord.difficulty <= 3 ? 'green' : selectedWord.difficulty <= 6 ? 'orange' : 'red'}>
                    {selectedWord.difficulty_text}
                  </Tag>
                </Col>
                <Col span={8}>
                  <Text strong>核心词汇:</Text> 
                  <Tag color={selectedWord.is_core_vocabulary ? 'blue' : 'default'}>
                    {selectedWord.is_core_vocabulary ? '是' : '否'}
                  </Tag>
                </Col>
                <Col span={24}>
                  <Text strong>中文释义:</Text> {selectedWord.chinese_meaning}
                </Col>
                {selectedWord.example_sentence && (
                  <Col span={24}>
                    <Text strong>例句:</Text> {selectedWord.example_sentence}
                  </Col>
                )}
              </Row>
            </Card>
          </>
        )}
      </Card>

      {/* 详情模态框 */}
      <Modal
        title={`单词详细分析: ${selectedWord.word}`}
        open={showDetailModal}
        onCancel={() => setShowDetailModal(false)}
        footer={null}
        width={800}
      >
        <div>
          <Alert
            message="学习建议"
            description={
              stats && stats.masteryRate < 0.6 
                ? "该单词掌握率较低，建议增加练习频度或调整教学方法。"
                : "该单词学习效果良好，可以适当增加难度或扩展相关词汇。"
            }
            type={stats && stats.masteryRate < 0.6 ? 'warning' : 'success'}
            showIcon
            style={{ marginBottom: '16px' }}
          />
          
          {stats && (
            <div>
              <Title level={5}>学习数据详情</Title>
              <List size="small">
                <List.Item>
                  <Text strong>总学习人数:</Text> {stats.totalLearners}人
                </List.Item>
                <List.Item>
                  <Text strong>完全掌握:</Text> {stats.learningProgress.mastered}人 
                  ({Math.round((stats.learningProgress.mastered / stats.totalLearners) * 100)}%)
                </List.Item>
                <List.Item>
                  <Text strong>正在学习:</Text> {stats.learningProgress.learning}人
                </List.Item>
                <List.Item>
                  <Text strong>需要复习:</Text> {stats.learningProgress.reviewing}人
                </List.Item>
                <List.Item>
                  <Text strong>平均学习难度评价:</Text> {stats.averageDifficulty.toFixed(2)}/10
                </List.Item>
              </List>
            </div>
          )}
        </div>
      </Modal>
    </div>
  );
};

export default VocabularyAnalytics;