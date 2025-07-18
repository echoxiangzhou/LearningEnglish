import React, { useState } from 'react';
import { Row, Col, Card, Tabs, Button, Space, Typography, Alert } from 'antd';
import { 
  BookOutlined, 
  BarChartOutlined, 
  UserOutlined,
  SettingOutlined,
  SyncOutlined
} from '@ant-design/icons';
import VocabularyManager from './VocabularyManager';
import VocabularyAnalytics from './VocabularyAnalytics';
// VocabularyBridgeService removed - using vocabularyManagementService directly
import { vocabularyManagementService } from '../../services/vocabularyManagementService';
import type { VocabularyWord } from '../../services/vocabularyManagementService';
import './IntegratedVocabularyPanel.css';

const { TabPane } = Tabs;
const { Title } = Typography;

interface IntegratedVocabularyPanelProps {
  className?: string;
}

const IntegratedVocabularyPanel: React.FC<IntegratedVocabularyPanelProps> = ({ className }) => {
  const [activeTab, setActiveTab] = useState('management');
  const [selectedWord, setSelectedWord] = useState<VocabularyWord | null>(null);
  const [syncLoading, setSyncLoading] = useState(false);

  const handleWordSelect = (word: VocabularyWord) => {
    setSelectedWord(word);
    if (activeTab === 'management') {
      setActiveTab('analytics');
    }
  };

  const handleSyncAll = async () => {
    try {
      setSyncLoading(true);
      // 这里可以实现全量同步逻辑
      // 例如：同步所有词库到用户系统
      console.log('开始同步词汇数据到用户学习系统...');
      
      // 模拟同步过程
      await new Promise(resolve => setTimeout(resolve, 2000));
      
      console.log('词汇数据同步完成');
    } catch (error) {
      console.error('同步失败:', error);
    } finally {
      setSyncLoading(false);
    }
  };

  return (
    <div className={`integrated-vocabulary-panel ${className}`}>
      <Card 
        title={
          <Space>
            <BookOutlined />
            <Title level={3} style={{ margin: 0 }}>词汇管理中心</Title>
          </Space>
        }
        extra={
          <Space>
            <Button 
              type="primary" 
              icon={<SyncOutlined />}
              loading={syncLoading}
              onClick={handleSyncAll}
            >
              同步到学习系统
            </Button>
          </Space>
        }
        className="panel-header"
      >
        <Alert
          message="词汇管理与学习分析"
          description="管理员可以在此管理词汇库，查看学习统计，并将数据同步到用户学习系统。左侧管理词汇，右侧查看分析。"
          type="info"
          showIcon
          closable
          style={{ marginBottom: '16px' }}
        />
      </Card>

      <Row gutter={[16, 16]} style={{ marginTop: '16px' }}>
        {/* 左侧：词汇管理 */}
        <Col xs={24} lg={selectedWord ? 14 : 24}>
          <Card
            title={
              <Space>
                <SettingOutlined />
                <span>词汇管理</span>
              </Space>
            }
            className="management-panel"
          >
            <VocabularyManager 
              onWordSelect={handleWordSelect}
              compact={!!selectedWord}
            />
          </Card>
        </Col>

        {/* 右侧：学习分析（当选中单词时显示） */}
        {selectedWord && (
          <Col xs={24} lg={10}>
            <Card
              title={
                <Space>
                  <BarChartOutlined />
                  <span>学习分析</span>
                </Space>
              }
              extra={
                <Button 
                  type="text" 
                  size="small"
                  onClick={() => setSelectedWord(null)}
                >
                  关闭
                </Button>
              }
              className="analytics-panel"
            >
              <VocabularyAnalytics 
                selectedWord={selectedWord}
                onClose={() => setSelectedWord(null)}
              />
            </Card>
          </Col>
        )}
      </Row>

      {/* 底部：操作指南 */}
      <Card 
        title="操作指南" 
        size="small" 
        style={{ marginTop: '16px' }}
        className="help-panel"
      >
        <Row gutter={[16, 8]}>
          <Col xs={24} sm={8}>
            <div className="help-item">
              <BookOutlined className="help-icon" />
              <div>
                <div className="help-title">词汇管理</div>
                <div className="help-desc">添加、编辑、删除词汇，批量导入词库</div>
              </div>
            </div>
          </Col>
          <Col xs={24} sm={8}>
            <div className="help-item">
              <BarChartOutlined className="help-icon" />
              <div>
                <div className="help-title">学习分析</div>
                <div className="help-desc">查看单词学习统计，掌握率分析</div>
              </div>
            </div>
          </Col>
          <Col xs={24} sm={8}>
            <div className="help-item">
              <SyncOutlined className="help-icon" />
              <div>
                <div className="help-title">数据同步</div>
                <div className="help-desc">将管理的词汇同步到用户学习系统</div>
              </div>
            </div>
          </Col>
        </Row>
      </Card>
    </div>
  );
};

export default IntegratedVocabularyPanel;