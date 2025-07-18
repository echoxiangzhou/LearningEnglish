import React, { useState, useEffect } from 'react';
import { Card, Radio, Slider, Space, Typography, Button, Row, Col, Checkbox, Alert } from 'antd';
import { FileTextOutlined, SettingOutlined, PlayCircleOutlined, TagsOutlined } from '@ant-design/icons';
import type { DictationConfig, DictationMode } from '../../types/dictation';
import { categoryService } from '../../services/categoryService';
import type { SentenceCategory } from '../../types/category';
import './LibrarySelector.css';

const { Title, Text } = Typography;

interface SentencePracticeSelectorProps {
  onConfigChange: (config: DictationConfig) => void;
  onStartPractice: (config: DictationConfig) => void;
  defaultConfig?: Partial<DictationConfig>;
  className?: string;
}

const SentencePracticeSelector: React.FC<SentencePracticeSelectorProps> = ({
  onConfigChange,
  onStartPractice,
  defaultConfig,
  className = ''
}) => {
  const [config, setConfig] = useState<DictationConfig>({
    practice_type: 'sentence', // 固定为句子练习
    library: 'elementary_all',
    mode: 'partial_blank',
    sentence_count: 5,
    difficulty_level: 3,
    show_chinese: true,
    auto_play: true,
    playback_speed: 1.0,
    categories: [],
    auto_play_new_sentence: true,
    ...defaultConfig
  });
  
  const [availableCategories, setAvailableCategories] = useState<SentenceCategory[]>([]);
  const [loadingCategories, setLoadingCategories] = useState(false);

  useEffect(() => {
    fetchUserCategories();
  }, []);

  const fetchUserCategories = async () => {
    try {
      setLoadingCategories(true);
      // 获取当前用户被分配的分类
      const userCategories = await categoryService.getCurrentUserCategories();
      setAvailableCategories(userCategories.filter(cat => cat.is_active));
    } catch (error) {
      console.error('Error fetching user categories:', error);
      // 如果获取用户分类失败，尝试获取所有分类作为备选
      try {
        const allCategories = await categoryService.getCategories();
        setAvailableCategories(allCategories.filter(cat => cat.is_active));
      } catch (fallbackError) {
        console.error('Error fetching fallback categories:', fallbackError);
        setAvailableCategories([]);
      }
    } finally {
      setLoadingCategories(false);
    }
  };

  // 计算选中分类的总句子数
  const getSelectedCategoriesTotal = () => {
    if (!config.categories || config.categories.length === 0) {
      return 0;
    }
    return availableCategories
      .filter(cat => config.categories?.includes(cat.id))
      .reduce((sum, cat) => sum + cat.sentence_count, 0);
  };

  // 模式选项
  const modeOptions = [
    {
      value: 'full_blank',
      label: '完全空白',
      description: '听音频填写完整句子'
    },
    {
      value: 'partial_blank',
      label: '部分提示',
      description: '显示部分单词，填写空白处'
    },
    {
      value: 'key_words_only',
      label: '关键词汇',
      description: '只显示重要单词空白'
    }
  ] as const;

  // 更新配置
  const updateConfig = (updates: Partial<DictationConfig>) => {
    const newConfig = { 
      ...config, 
      ...updates,
      practice_type: 'sentence' // 确保始终为句子练习
    };
    setConfig(newConfig);
    onConfigChange(newConfig);
  };

  // 当分类选择发生变化时，自动更新句子数量为全部句子数
  const updateConfigWithCategories = (categories: number[]) => {
    const totalSentences = availableCategories
      .filter(cat => categories.includes(cat.id))
      .reduce((sum, cat) => sum + cat.sentence_count, 0);
    
    // 如果有选中的分类且总句子数大于0，自动设置为全部句子数
    const sentenceCount = totalSentences > 0 ? totalSentences : config.sentence_count;
    
    updateConfig({ 
      categories: categories,
      sentence_count: sentenceCount
    });
  };

  // 开始练习
  const handleStartPractice = () => {
    const finalConfig = {
      ...config,
      practice_type: 'sentence' as const // 确保为句子练习
    };
    onStartPractice(finalConfig);
  };

  return (
    <div className={`library-selector ${className}`}>
      <div className="tile-container">
        {/* 页面标题 */}
        <Card className="tile-card title-card">
          <div style={{ textAlign: 'center', padding: '20px 0' }}>
            <FileTextOutlined style={{ fontSize: '48px', color: '#1890ff', marginBottom: '16px' }} />
            <Title level={2} style={{ margin: 0, color: '#1890ff' }}>句子练习</Title>
            <Text type="secondary" style={{ fontSize: '16px' }}>
              通过完整句子听写，提高语感和语法理解
            </Text>
          </div>
        </Card>

        {/* 句子分类瓦片 */}
        <Card className="tile-card" title={
          <span>
            <TagsOutlined style={{ marginRight: 8, color: '#1890ff' }} />
            句子分类
          </span>
        }>
          <Text type="secondary" style={{ display: 'block', marginBottom: 16 }}>
            选择您想要练习的句子分类（可多选）
          </Text>
          
          {loadingCategories ? (
            <div style={{ textAlign: 'center', padding: '20px' }}>
              <Text type="secondary">加载分类中...</Text>
            </div>
          ) : availableCategories.length === 0 ? (
            <div style={{ textAlign: 'center', padding: '20px', background: '#f5f5f5', borderRadius: '8px' }}>
              <TagsOutlined style={{ fontSize: '24px', color: '#d9d9d9', marginBottom: '8px' }} />
              <div>
                <Text type="secondary">暂无可用分类</Text>
              </div>
              <Text type="secondary" style={{ fontSize: '12px' }}>
                管理员尚未为您分配句子分类
              </Text>
            </div>
          ) : (
            <div className="category-selection">
              <Checkbox.Group
                value={config.categories}
                onChange={(checkedValues) => updateConfigWithCategories(checkedValues as number[])}
                style={{ width: '100%' }}
              >
                <Row gutter={[16, 16]}>
                  {availableCategories.map(category => (
                    <Col xs={24} sm={12} md={8} key={category.id}>
                      <Card size="small" className="category-card">
                        <Checkbox value={category.id} style={{ width: '100%' }}>
                          <div className="category-content">
                            <div className="category-name">{category.name}</div>
                            <div className="category-info">
                              <Text type="secondary" style={{ fontSize: '12px' }}>
                                {category.description}
                              </Text>
                            </div>
                            <div className="category-stats">
                              <Space>
                                <Text type="secondary" style={{ fontSize: '11px' }}>
                                  {category.sentence_count} 个句子
                                </Text>
                                <Text type="secondary" style={{ fontSize: '11px' }}>
                                  难度 {category.difficulty_level}
                                </Text>
                              </Space>
                            </div>
                          </div>
                        </Checkbox>
                      </Card>
                    </Col>
                  ))}
                </Row>
              </Checkbox.Group>
              
              {config.categories && config.categories.length > 0 && (
                <Alert
                  message={`已选择 ${config.categories.length} 个分类，共 ${getSelectedCategoriesTotal()} 个句子`}
                  type="info"
                  showIcon
                  style={{ marginTop: 16 }}
                />
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
            {/* 句子数量 */}
            <div>
              <Text strong>练习句子数量：{config.sentence_count}</Text>
              <Slider
                min={1}
                max={Math.min(50, getSelectedCategoriesTotal() || 50)}
                step={1}
                value={config.sentence_count}
                onChange={(value) => updateConfig({ sentence_count: value })}
                marks={{
                  1: '1',
                  [Math.floor((Math.min(50, getSelectedCategoriesTotal() || 50)) / 4)]: Math.floor((Math.min(50, getSelectedCategoriesTotal() || 50)) / 4).toString(),
                  [Math.floor((Math.min(50, getSelectedCategoriesTotal() || 50)) / 2)]: Math.floor((Math.min(50, getSelectedCategoriesTotal() || 50)) / 2).toString(),
                  [Math.floor((Math.min(50, getSelectedCategoriesTotal() || 50)) * 3 / 4)]: Math.floor((Math.min(50, getSelectedCategoriesTotal() || 50)) * 3 / 4).toString(),
                  [Math.min(50, getSelectedCategoriesTotal() || 50)]: Math.min(50, getSelectedCategoriesTotal() || 50).toString()
                }}
                style={{ marginTop: 8 }}
              />
              {getSelectedCategoriesTotal() > 0 && (
                <Text type="secondary" style={{ fontSize: '12px' }}>
                  已选分类共有 {getSelectedCategoriesTotal()} 个句子
                </Text>
              )}
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
                显示中文翻译
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
                切换到新句子时自动播放
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
              disabled={availableCategories.length === 0}
            >
              开始句子练习
            </Button>
            
            <div className="config-summary">
              <Text type="secondary" style={{ fontSize: '12px' }}>
                句子练习：
                {config.categories && config.categories.length > 0 ? 
                  `${config.categories.length}个分类` : '所有分类'
                } • {config.sentence_count}个句子 • 
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

export default SentencePracticeSelector;