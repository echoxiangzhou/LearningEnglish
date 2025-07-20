import React, { useState, useEffect } from 'react';
import { Card, Select, Radio, Slider, Space, Typography, Button, Row, Col, Tag, Divider, Checkbox } from 'antd';
import { BookOutlined, SettingOutlined, PlayCircleOutlined, TagsOutlined, AppstoreOutlined } from '@ant-design/icons';
import type { DictationConfig, DictationMode, PracticeType } from '../../types/dictation';
import { vocabularyLibraryAdapter } from '../../services/vocabularyLibraryAdapter';
import type { VocabularyLibrary } from '../../services/vocabularyLibraryAdapter';
import { categoryService } from '../../services/categoryService';
import type { SentenceCategory } from '../../types/category';
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
    practice_type: 'sentence', // 默认句子练习
    library: 'elementary_all',
    mode: 'partial_blank',
    sentence_count: 5,
    difficulty_level: 3,
    show_chinese: true,
    auto_play: true,
    playback_speed: 1.0,
    categories: [],
    auto_play_new_sentence: true, // 默认开启自动播放新句子
    ...defaultConfig
  });
  
  const [availableCategories, setAvailableCategories] = useState<SentenceCategory[]>([]);
  const [loadingCategories, setLoadingCategories] = useState(false);
  const [availableLibraries, setAvailableLibraries] = useState<VocabularyLibrary[]>([]);
  const [loadingLibraries, setLoadingLibraries] = useState(false);

  useEffect(() => {
    fetchUserCategories();
    fetchVocabularyLibraries();
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

  const fetchVocabularyLibraries = async () => {
    try {
      setLoadingLibraries(true);
      // 获取用户被分配的词汇库
      const libraries = await vocabularyLibraryAdapter.getVocabularyLibraries();
      setAvailableLibraries(libraries);
    } catch (error) {
      console.error('Error fetching vocabulary libraries:', error);
      // 如果获取失败，使用后备词库
      const fallbackLibraries = vocabularyLibraryAdapter.getFallbackLibraries();
      setAvailableLibraries(fallbackLibraries);
    } finally {
      setLoadingLibraries(false);
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

  // 更新配置
  const updateConfig = (updates: Partial<DictationConfig>) => {
    const newConfig = { ...config, ...updates };
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
    onStartPractice(config);
  };

  // 获取选中的词库信息
  const selectedLibrary = availableLibraries.find(lib => lib.id === config.library);

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
      <div className="tile-container">
        {/* 练习类型瓦片 */}
        <Card className="tile-card" title={
          <span>
            <AppstoreOutlined style={{ color: '#1890ff', marginRight: 8 }} />
            练习类型
          </span>
        }>
          <Text type="secondary" style={{ display: 'block', marginBottom: 16 }}>
            选择您想要进行的练习类型
          </Text>
          <Radio.Group
            value={config.practice_type}
            onChange={(e) => {
              const practiceType = e.target.value as PracticeType;
              updateConfig({ 
                practice_type: practiceType,
                // 切换练习类型时重置相关配置
                categories: practiceType === 'sentence' ? config.categories : [],
                library: practiceType === 'word' ? config.library : 'elementary_all'
              });
            }}
            size="large"
            style={{ width: '100%' }}
          >
            <Row gutter={[16, 16]}>
              <Col xs={24} sm={12}>
                <Radio value="word" className="practice-type-radio">
                  <div style={{ marginLeft: 8 }}>
                    <div style={{ fontWeight: 'bold', fontSize: '16px' }}>单词练习</div>
                    <div style={{ color: '#666', fontSize: '14px', marginTop: 4 }}>
                      专注于单词听写，提高词汇掌握能力
                    </div>
                  </div>
                </Radio>
              </Col>
              <Col xs={24} sm={12}>
                <Radio value="sentence" className="practice-type-radio">
                  <div style={{ marginLeft: 8 }}>
                    <div style={{ fontWeight: 'bold', fontSize: '16px' }}>句子练习</div>
                    <div style={{ color: '#666', fontSize: '14px', marginTop: 4 }}>
                      通过完整句子听写，提高语感和语法理解
                    </div>
                  </div>
                </Radio>
              </Col>
            </Row>
          </Radio.Group>
        </Card>

        {/* 词库选择瓦片 - 仅在单词练习时显示 */}
        {config.practice_type === 'word' && (
          <Card className="tile-card" title="选择词库">
            <Text type="secondary" style={{ display: 'block', marginBottom: 16 }}>
              选择您想要练习的单词词库
            </Text>
            
            {loadingLibraries ? (
              <div style={{ textAlign: 'center', padding: '20px' }}>
                <Text type="secondary">加载词库中...</Text>
              </div>
            ) : availableLibraries.length === 0 ? (
              <div style={{ textAlign: 'center', padding: '20px', background: '#f5f5f5', borderRadius: '8px' }}>
                <BookOutlined style={{ fontSize: '24px', color: '#d9d9d9', marginBottom: '8px' }} />
                <div>
                  <Text type="secondary">暂无可用词库</Text>
                </div>
                <Text type="secondary" style={{ fontSize: '12px' }}>
                  管理员尚未为您分配词汇库
                </Text>
              </div>
            ) : (
              <>
                <Select
                  value={config.library}
                  onChange={(value) => updateConfig({ library: value })}
                  style={{ width: '100%' }}
                  size="large"
                  placeholder="请选择词库"
                >
                  {availableLibraries.map(library => (
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
              </>
            )}
          </Card>
        )}

        {/* 句子分类瓦片 - 仅在句子练习时显示 */}
        {config.practice_type === 'sentence' && (
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
                  <Row gutter={[16, 12]}>
                    {availableCategories.map(category => (
                      <Col xs={24} sm={12} md={8} lg={6} xl={4} key={category.id}>
                        <Card 
                          size="small" 
                          className={`category-card ${config.categories?.includes(category.id) ? 'selected' : ''}`}
                          style={{ 
                            cursor: 'pointer',
                            border: config.categories?.includes(category.id) ? '2px solid #1890ff' : '1px solid #f0f0f0'
                          }}
                          onClick={() => {
                            const currentCategories = config.categories || [];
                            const newCategories = currentCategories.includes(category.id)
                              ? currentCategories.filter(id => id !== category.id)
                              : [...currentCategories, category.id];
                            updateConfigWithCategories(newCategories);
                          }}
                        >
                          <div style={{ textAlign: 'center' }}>
                            <Checkbox value={category.id} style={{ marginBottom: 8 }}>
                              <Text strong style={{ fontSize: '13px' }}>{category.name}</Text>
                            </Checkbox>
                            <div>
                              <Tag 
                                color={
                                  category.difficulty === 'elementary' ? 'green' :
                                  category.difficulty === 'intermediate' ? 'orange' : 'red'
                                }
                                size="small"
                              >
                                {category.difficulty === 'elementary' ? '初级' :
                                 category.difficulty === 'intermediate' ? '中级' : '高级'}
                              </Tag>
                            </div>
                            <Text type="secondary" style={{ fontSize: '11px' }}>
                              {category.sentence_count} 个句子
                            </Text>
                          </div>
                        </Card>
                      </Col>
                    ))}
                  </Row>
                </Checkbox.Group>
                
                {config.categories && config.categories.length > 0 && (
                  <div style={{ marginTop: 16, padding: '12px', background: '#f6ffed', borderRadius: '6px', border: '1px solid #b7eb8f' }}>
                    <Text style={{ color: '#52c41a', fontSize: '13px' }}>
                      <TagsOutlined style={{ marginRight: 4 }} />
                      已选择 {config.categories.length} 个分类，
                      共 {availableCategories
                        .filter(cat => config.categories?.includes(cat.id))
                        .reduce((sum, cat) => sum + cat.sentence_count, 0)} 个句子可用于练习
                    </Text>
                  </div>
                )}
              </div>
            )}
          </Card>
        )}

        {/* 练习模式瓦片 - 仅在句子练习时显示 */}
        {config.practice_type === 'sentence' && (
        <Card className="tile-card" title="练习模式">
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
        )}

        {/* 练习设置瓦片 */}
        <Card className="tile-card" title={
          <span>
            <SettingOutlined style={{ marginRight: 8 }} />
            练习设置
          </span>
        }>
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
                  {getSelectedCategoriesTotal() > 0 && (
                    <Option value={getSelectedCategoriesTotal()}>
                      全部句子 ({getSelectedCategoriesTotal()}句)
                    </Option>
                  )}
                </Select>
                {getSelectedCategoriesTotal() > 0 && (
                  <Text type="secondary" style={{ fontSize: '12px', display: 'block', marginTop: 4 }}>
                    选中分类共有 {getSelectedCategoriesTotal()} 个句子可用于练习
                  </Text>
                )}
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
                    <label className="checkbox-label">
                      <input
                        type="checkbox"
                        checked={config.auto_play_new_sentence}
                        onChange={(e) => updateConfig({ auto_play_new_sentence: e.target.checked })}
                      />
                      <span>切换新句子时自动播放</span>
                    </label>
                  </Space>
                </div>
              </div>
            </Col>
          </Row>
        </Card>

        {/* 开始按钮瓦片 */}
        <Card className="tile-card">
          <div className="start-practice-section">
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
                {config.practice_type === 'word' ? '单词练习' : '句子练习'}：
                {config.practice_type === 'word' ? selectedLibrary?.name : 
                  config.categories && config.categories.length > 0 ? 
                    `${config.categories.length}个分类` : '所有分类'
                } • {config.sentence_count}个
                {config.practice_type === 'word' ? '单词' : '句子'} • 
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

export default LibrarySelector;