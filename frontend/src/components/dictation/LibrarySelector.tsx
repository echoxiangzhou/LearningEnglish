import React, { useState } from 'react';
import { Card, Select, Radio, Slider, Space, Typography, Button, Row, Col, Tag, Divider } from 'antd';
import { BookOutlined, SettingOutlined, PlayCircleOutlined } from '@ant-design/icons';
import { WordLibrary, DictationConfig, DictationMode, WORD_LIBRARIES } from '../../types/dictation';
import './LibrarySelector.css';

const { Title, Text } = Typography;
const { Option } = Select;

interface LibrarySelectorProps {
  onConfigChange: (config: DictationConfig) => void;
  onStartPractice: (config: DictationConfig) => void;
  defaultConfig?: Partial<DictationConfig>;
  className?: string;
}

const LibrarySelector: React.FC<LibrarySelectorProps> = ({
  onConfigChange,
  onStartPractice,
  defaultConfig,
  className = ''
}) => {
  const [config, setConfig] = useState<DictationConfig>({
    library: 'elementary_all',
    mode: 'partial_blank',
    sentence_count: 5,
    difficulty_level: 3,
    show_chinese: true,
    auto_play: true,
    playback_speed: 1.0,
    ...defaultConfig
  });

  // 更新配置
  const updateConfig = (updates: Partial<DictationConfig>) => {
    const newConfig = { ...config, ...updates };
    setConfig(newConfig);
    onConfigChange(newConfig);
  };

  // 开始练习
  const handleStartPractice = () => {
    onStartPractice(config);
  };

  // 获取选中的词库信息
  const selectedLibrary = WORD_LIBRARIES.find(lib => lib.id === config.library);

  // 模式选项
  const modeOptions = [
    {
      value: 'full_blank' as DictationMode,
      label: '全部挖空',
      description: '所有单词都需要填写'
    },
    {
      value: 'partial_blank' as DictationMode,
      label: '部分挖空',
      description: '挖空60%的单词'
    },
    {
      value: 'key_words_only' as DictationMode,
      label: '关键词',
      description: '只挖空关键单词'
    }
  ];

  // 难度级别描述
  const getDifficultyLabel = (level: number): string => {
    switch (level) {
      case 1: return '很简单';
      case 2: return '简单';
      case 3: return '中等';
      case 4: return '困难';
      case 5: return '很困难';
      default: return '中等';
    }
  };

  // 速度描述
  const getSpeedLabel = (speed: number): string => {
    if (speed <= 0.5) return '很慢';
    if (speed <= 0.75) return '较慢';
    if (speed <= 1.0) return '正常';
    if (speed <= 1.25) return '较快';
    if (speed <= 1.5) return '快速';
    return '很快';
  };

  return (
    <div className={`library-selector ${className}`}>
      <Card className="selector-card">
        <div className="selector-header">
          <Title level={3}>
            <BookOutlined style={{ color: '#1890ff', marginRight: 8 }} />
            听写练习设置
          </Title>
          <Text type="secondary">
            选择词库和练习方式，开始您的英语听写练习
          </Text>
        </div>

        <div className="selector-content">
          {/* 词库选择 */}
          <div className="config-section">
            <Title level={4}>选择词库</Title>
            <Select
              value={config.library}
              onChange={(value) => updateConfig({ library: value })}
              style={{ width: '100%' }}
              size="large"
            >
              {WORD_LIBRARIES.map(library => (
                <Option key={library.id} value={library.id}>
                  <div className="library-option">
                    <div className="library-name">{library.name}</div>
                    <div className="library-info">
                      <Text type="secondary" style={{ fontSize: '12px' }}>
                        {library.description} • {library.word_count}个单词
                      </Text>
                    </div>
                  </div>
                </Option>
              ))}
            </Select>
            
            {selectedLibrary && (
              <div className="library-details">
                <Space wrap>
                  <Tag color="blue">
                    年级：{selectedLibrary.grade_level || '通用'}
                  </Tag>
                  <Tag color="green">
                    单词数：{selectedLibrary.word_count}
                  </Tag>
                  {selectedLibrary.categories.map(category => (
                    <Tag key={category} color="default">
                      {category}
                    </Tag>
                  ))}
                </Space>
              </div>
            )}
          </div>

          <Divider />

          {/* 练习模式 */}
          <div className="config-section">
            <Title level={4}>练习模式</Title>
            <Radio.Group
              value={config.mode}
              onChange={(e) => updateConfig({ mode: e.target.value })}
              className="mode-radio-group"
            >
              <Space direction="vertical" size="middle">
                {modeOptions.map(option => (
                  <Radio key={option.value} value={option.value} className="mode-radio">
                    <div className="mode-content">
                      <div className="mode-label">{option.label}</div>
                      <div className="mode-description">
                        <Text type="secondary">{option.description}</Text>
                      </div>
                    </div>
                  </Radio>
                ))}
              </Space>
            </Radio.Group>
          </div>

          <Divider />

          {/* 练习设置 */}
          <div className="config-section">
            <Title level={4}>
              <SettingOutlined style={{ marginRight: 8 }} />
              练习设置
            </Title>
            
            <Row gutter={[24, 16]}>
              <Col xs={24} sm={12}>
                <div className="setting-item">
                  <Text strong>句子数量</Text>
                  <Select
                    value={config.sentence_count}
                    onChange={(value) => updateConfig({ sentence_count: value })}
                    style={{ width: '100%', marginTop: 8 }}
                  >
                    <Option value={3}>3句 (快速练习)</Option>
                    <Option value={5}>5句 (标准练习)</Option>
                    <Option value={10}>10句 (强化练习)</Option>
                    <Option value={15}>15句 (深度练习)</Option>
                  </Select>
                </div>
              </Col>
              
              <Col xs={24} sm={12}>
                <div className="setting-item">
                  <Text strong>难度级别</Text>
                  <div style={{ marginTop: 8 }}>
                    <Slider
                      value={config.difficulty_level}
                      onChange={(value) => updateConfig({ difficulty_level: value })}
                      min={1}
                      max={5}
                      marks={{
                        1: '1',
                        2: '2',
                        3: '3',
                        4: '4',
                        5: '5'
                      }}
                      tooltip={{
                        formatter: (value) => getDifficultyLabel(value || 3)
                      }}
                    />
                    <Text type="secondary" style={{ fontSize: '12px' }}>
                      当前：{getDifficultyLabel(config.difficulty_level)}
                    </Text>
                  </div>
                </div>
              </Col>
              
              <Col xs={24} sm={12}>
                <div className="setting-item">
                  <Text strong>播放速度</Text>
                  <div style={{ marginTop: 8 }}>
                    <Slider
                      value={config.playback_speed}
                      onChange={(value) => updateConfig({ playback_speed: value })}
                      min={0.5}
                      max={2.0}
                      step={0.25}
                      marks={{
                        0.5: '0.5x',
                        1.0: '1.0x',
                        1.5: '1.5x',
                        2.0: '2.0x'
                      }}
                      tooltip={{
                        formatter: (value) => `${value}x ${getSpeedLabel(value || 1.0)}`
                      }}
                    />
                    <Text type="secondary" style={{ fontSize: '12px' }}>
                      当前：{config.playback_speed}x {getSpeedLabel(config.playback_speed)}
                    </Text>
                  </div>
                </div>
              </Col>
              
              <Col xs={24} sm={12}>
                <div className="setting-item">
                  <Text strong>其他选项</Text>
                  <div style={{ marginTop: 8 }}>
                    <Space direction="vertical">
                      <label className="checkbox-label">
                        <input
                          type="checkbox"
                          checked={config.show_chinese}
                          onChange={(e) => updateConfig({ show_chinese: e.target.checked })}
                        />
                        <span>显示中文翻译</span>
                      </label>
                      <label className="checkbox-label">
                        <input
                          type="checkbox"
                          checked={config.auto_play}
                          onChange={(e) => updateConfig({ auto_play: e.target.checked })}
                        />
                        <span>自动播放音频</span>
                      </label>
                    </Space>
                  </div>
                </div>
              </Col>
            </Row>
          </div>
        </div>

        {/* 开始按钮 */}
        <div className="selector-footer">
          <Button
            type="primary"
            size="large"
            icon={<PlayCircleOutlined />}
            onClick={handleStartPractice}
            className="start-button"
            block
          >
            开始听写练习
          </Button>
          
          <div className="config-summary">
            <Text type="secondary" style={{ fontSize: '12px' }}>
              将练习：{selectedLibrary?.name} • {config.sentence_count}个句子 • 
              {modeOptions.find(m => m.value === config.mode)?.label} • 
              难度{config.difficulty_level}级
            </Text>
          </div>
        </div>
      </Card>
    </div>
  );
};

export default LibrarySelector;