import React, { useState, useEffect } from 'react';
import { Card, Select, Radio, Slider, Space, Typography, Button, Row, Col, Tag, Checkbox, message } from 'antd';
import { BookOutlined, SettingOutlined, PlayCircleOutlined, EditOutlined, LoadingOutlined } from '@ant-design/icons';
import type { DictationConfig, DictationMode } from '../../types/dictation';
import { vocabularyLibraryAdapter } from '../../services/vocabularyLibraryAdapter';
import type { VocabularyLibrary } from '../../services/vocabularyLibraryAdapter';
import './LibrarySelector.css';

const { Title, Text } = Typography;
const { Option } = Select;

interface WordPracticeSelectorProps {
  onConfigChange: (config: DictationConfig) => void;
  onStartPractice: (config: DictationConfig) => void;
  defaultConfig?: Partial<DictationConfig>;
  className?: string;
}

const WordPracticeSelector: React.FC<WordPracticeSelectorProps> = ({
  onConfigChange,
  onStartPractice,
  defaultConfig,
  className = ''
}) => {
  const [config, setConfig] = useState<DictationConfig>({
    practice_type: 'word', // 固定为单词练习
    library: '',
    mode: 'partial_blank',
    sentence_count: 10,
    difficulty_level: 3,
    show_chinese: true,
    auto_play: true,
    playback_speed: 1.0,
    categories: [],
    auto_play_new_sentence: true,
    ...defaultConfig
  });

  // 动态加载的词库列表
  const [vocabularyLibraries, setVocabularyLibraries] = useState<VocabularyLibrary[]>([]);
  const [librariesLoading, setLibrariesLoading] = useState(true);

  // 模式选项
  const modeOptions = [
    {
      value: 'full_blank',
      label: '完全空白',
      description: '听音频填写完整单词'
    },
    {
      value: 'partial_blank',
      label: '部分提示',
      description: '显示首字母，填写剩余部分'
    },
    {
      value: 'key_words_only',
      label: '关键词汇',
      description: '只显示重要单词空白'
    }
  ] as const;

  // 获取选中的词库信息
  const selectedLibrary = vocabularyLibraries.find(lib => lib.id === config.library);

  // 加载词库列表
  useEffect(() => {
    const loadVocabularyLibraries = async () => {
      try {
        setLibrariesLoading(true);
        const libraries = await vocabularyLibraryAdapter.getVocabularyLibraries();
        
        if (libraries && libraries.length > 0) {
          setVocabularyLibraries(libraries);
          
          // 如果没有选中的词库，默认选择第一个
          if (!config.library && libraries.length > 0) {
            updateConfig({ library: libraries[0].id });
          }
        } else {
          message.warning('未找到可用的词库');
        }
      } catch (error) {
        console.error('Failed to load vocabulary libraries:', error);
        message.error('加载词库失败，已使用默认词库');
        
        // 如果加载失败，使用适配器的后备词库
        const fallbackLibraries = vocabularyLibraryAdapter.getFallbackLibraries();
        setVocabularyLibraries(fallbackLibraries);
        if (!config.library && fallbackLibraries.length > 0) {
          updateConfig({ library: fallbackLibraries[0].id });
        }
      } finally {
        setLibrariesLoading(false);
      }
    };

    loadVocabularyLibraries();
  }, []);

  // 更新配置
  const updateConfig = (updates: Partial<DictationConfig>) => {
    const newConfig = { 
      ...config, 
      ...updates,
      practice_type: 'word' // 确保始终为单词练习
    };
    setConfig(newConfig);
    onConfigChange(newConfig);
  };

  // 开始练习
  const handleStartPractice = () => {
    const finalConfig = {
      ...config,
      practice_type: 'word' as const // 确保为单词练习
    };
    onStartPractice(finalConfig);
  };

  return (
    <div className={`library-selector ${className}`}>
      <div className="tile-container">
        {/* 页面标题 */}
        <Card className="tile-card title-card">
          <div style={{ textAlign: 'center', padding: '20px 0' }}>
            <EditOutlined style={{ fontSize: '48px', color: '#1890ff', marginBottom: '16px' }} />
            <Title level={2} style={{ margin: 0, color: '#1890ff' }}>单词练习</Title>
            <Text type="secondary" style={{ fontSize: '16px' }}>
              专注于单词听写，提高词汇掌握能力
            </Text>
          </div>
        </Card>

        {/* 词库选择瓦片 */}
        <Card className="tile-card" title={
          <span>
            <BookOutlined style={{ color: '#1890ff', marginRight: 8 }} />
            选择词库
          </span>
        }>
          <Text type="secondary" style={{ display: 'block', marginBottom: 16 }}>
            选择您想要练习的单词词库
          </Text>
          <Select
            value={config.library}
            onChange={(value) => updateConfig({ library: value })}
            style={{ width: '100%' }}
            size="large"
            loading={librariesLoading}
            placeholder={librariesLoading ? "正在加载词库..." : "请选择词库"}
            notFoundContent={librariesLoading ? <LoadingOutlined spin /> : "暂无词库"}
          >
            {vocabularyLibraries.map(library => (
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
                  年级：{selectedLibrary.grade_level ? `${selectedLibrary.grade_level}年级` : '通用'}
                </Tag>
                <Tag color="green">
                  单词数：{selectedLibrary.word_count}
                </Tag>
              </Space>
              {selectedLibrary.categories && selectedLibrary.categories.length > 0 && (
                <div style={{ marginTop: 8 }}>
                  <Text type="secondary" style={{ fontSize: '12px' }}>
                    包含分类：{selectedLibrary.categories.join('、')}
                  </Text>
                </div>
              )}
            </div>
          )}
        </Card>

        {/* 练习模式瓦片 */}
        <Card className="tile-card" title="练习模式">
          <Text type="secondary" style={{ display: 'block', marginBottom: 16 }}>
            选择适合的练习难度模式
          </Text>
          <Radio.Group
            value={config.mode}
            onChange={(e) => updateConfig({ mode: e.target.value })}
            className="mode-radio-group"
          >
            <Row gutter={[16, 16]}>
              {modeOptions.map(option => (
                <Col xs={24} sm={8} key={option.value}>
                  <Radio value={option.value} className="mode-radio">
                    <div className="mode-content">
                      <div className="mode-label">{option.label}</div>
                      <div className="mode-description">
                        <Text type="secondary">{option.description}</Text>
                      </div>
                    </div>
                  </Radio>
                </Col>
              ))}
            </Row>
          </Radio.Group>
        </Card>

        {/* 练习设置瓦片 */}
        <Card className="tile-card" title={
          <span>
            <SettingOutlined style={{ marginRight: 8 }} />
            练习设置
          </span>
        }>
          <Space direction="vertical" style={{ width: '100%' }} size="large">
            {/* 单词数量 */}
            <div>
              <Text strong>练习单词数量：{config.sentence_count}</Text>
              <Slider
                min={5}
                max={50}
                step={5}
                value={config.sentence_count}
                onChange={(value) => updateConfig({ sentence_count: value })}
                marks={{
                  5: '5',
                  15: '15',
                  25: '25',
                  35: '35',
                  50: '50'
                }}
                style={{ marginTop: 8 }}
              />
            </div>

            {/* 难度级别 */}
            <div>
              <Text strong>难度级别：{config.difficulty_level}</Text>
              <Slider
                min={1}
                max={5}
                value={config.difficulty_level}
                onChange={(value) => updateConfig({ difficulty_level: value })}
                marks={{
                  1: '简单',
                  2: '较易',
                  3: '中等',
                  4: '较难',
                  5: '困难'
                }}
                style={{ marginTop: 8 }}
              />
            </div>

            {/* 播放速度 */}
            <div>
              <Text strong>播放速度：{config.playback_speed}x</Text>
              <Slider
                min={0.5}
                max={1.5}
                step={0.1}
                value={config.playback_speed}
                onChange={(value) => updateConfig({ playback_speed: value })}
                marks={{
                  0.5: '0.5x',
                  0.8: '0.8x',
                  1.0: '1.0x',
                  1.2: '1.2x',
                  1.5: '1.5x'
                }}
                style={{ marginTop: 8 }}
              />
            </div>

            {/* 其他选项 */}
            <Space direction="vertical">
              <Checkbox
                checked={config.show_chinese}
                onChange={(e) => updateConfig({ show_chinese: e.target.checked })}
              >
                显示中文含义
              </Checkbox>
              <Checkbox
                checked={config.auto_play}
                onChange={(e) => updateConfig({ auto_play: e.target.checked })}
              >
                自动播放音频
              </Checkbox>
              <Checkbox
                checked={config.auto_play_new_sentence}
                onChange={(e) => updateConfig({ auto_play_new_sentence: e.target.checked })}
              >
                切换到新单词时自动播放
              </Checkbox>
            </Space>
          </Space>
        </Card>

        {/* 开始练习按钮 */}
        <Card className="tile-card start-practice-card">
          <div className="start-practice-content">
            <Button
              type="primary"
              size="large"
              icon={<PlayCircleOutlined />}
              onClick={handleStartPractice}
              className="start-practice-button"
              disabled={!config.library || librariesLoading}
              loading={librariesLoading}
            >
              {librariesLoading ? '加载中...' : '开始单词练习'}
            </Button>
            
            <div className="config-summary">
              <Text type="secondary" style={{ fontSize: '12px' }}>
                单词练习：{selectedLibrary?.name || '请选择词库'} • {config.sentence_count}个单词 • 
                {modeOptions.find(m => m.value === config.mode)?.label} • 
                难度{config.difficulty_level}级
              </Text>
            </div>
          </div>
        </Card>
      </div>
    </div>
  );
};

export default WordPracticeSelector;