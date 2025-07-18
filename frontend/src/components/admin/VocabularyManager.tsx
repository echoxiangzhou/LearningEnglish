import React, { useState, useEffect } from 'react';
import { 
  Card, 
  Table, 
  Button, 
  Modal, 
  Form, 
  Input, 
  Select, 
  message, 
  Space, 
  Tag, 
  Popconfirm,
  Row,
  Col,
  Statistic,
  Typography,
  Divider
} from 'antd';
import { 
  BookOutlined, 
  PlusOutlined, 
  EditOutlined, 
  DeleteOutlined,
  ImportOutlined,
  ExportOutlined,
  FileTextOutlined,
  SoundOutlined,
  TranslationOutlined
} from '@ant-design/icons';
import { vocabularyManagementService } from '../../services/vocabularyManagementService';
import type { VocabularyWord, CreateWordRequest } from '../../services/vocabularyManagementService';
import type { WordLibrary } from '../../types/dictation';
import VocabularyImportModal from './VocabularyImportModal';
import VocabularyAnalytics from './VocabularyAnalytics';
import RetranslateModal from './RetranslateModal';
import LibraryEditModal from './LibraryEditModal';
import './VocabularyManager.css';

const { Title, Text } = Typography;
const { Option } = Select;
const { TextArea } = Input;

// Removed interface definition - using the one from vocabularyManagementService

interface VocabularyManagerState {
  libraries: WordLibrary[];
  selectedLibrary: string | null;
  words: VocabularyWord[];
  pagination: {
    current: number;
    pageSize: number;
    total: number;
  } | null;
  loading: boolean;
  modalVisible: boolean;
  editingWord: VocabularyWord | null;
  form: any;
  enhancedImportModalVisible: boolean;
  appendImportModalVisible: boolean;
  retranslateModalVisible: boolean;
  libraryEditModalVisible: boolean;
  selectedWordForAnalysis: VocabularyWord | null;
  showAnalytics: boolean;
}

interface VocabularyManagerProps {
  onWordSelect?: (word: VocabularyWord) => void;
  compact?: boolean;
}

const VocabularyManager: React.FC<VocabularyManagerProps> = ({ 
  onWordSelect,
  compact = false 
}) => {
  const [state, setState] = useState<VocabularyManagerState>({
    libraries: [],
    selectedLibrary: null,
    words: [],
    pagination: null,
    loading: false,
    modalVisible: false,
    editingWord: null,
    form: null,
    enhancedImportModalVisible: false,
    appendImportModalVisible: false,
    retranslateModalVisible: false,
    libraryEditModalVisible: false,
    selectedWordForAnalysis: null,
    showAnalytics: false
  });

  const [form] = Form.useForm();

  useEffect(() => {
    loadLibraries();
  }, []);

  // 加载词库列表
  const loadLibraries = async () => {
    try {
      setState(prev => ({ ...prev, loading: true }));
      const response = await vocabularyManagementService.getLibraries();
      setState(prev => ({ 
        ...prev, 
        libraries: response.libraries,
        loading: false 
      }));
      
      // 默认选择第一个词库
      if (response.libraries.length > 0) {
        handleLibrarySelect(response.libraries[0].id);
      }
    } catch (error: any) {
      console.error('Failed to load libraries:', error);
      
      let errorMessage = `加载词库失败: ${error.message || '未知错误'}`;
      
      // Check different types of errors
      if (error.message && error.message.includes('authentication')) {
        errorMessage = '请先登录后再访问词库管理功能';
      } else if (error.message && error.message.includes('Failed to fetch')) {
        errorMessage = '无法连接到服务器，请检查后端服务是否启动 (端口:5001)';
      } else if (error.message && error.message.includes('404')) {
        errorMessage = 'API端点不存在，请检查后端路由配置';
      } else if (error.message && error.message.includes('403')) {
        errorMessage = '没有权限访问此功能，请检查用户角色';
      }
      
      message.error(errorMessage);
      setState(prev => ({ ...prev, loading: false }));
    }
  };

  // 选择词库
  const handleLibrarySelect = async (libraryId: string, page: number = 1, pageSize: number = 50) => {
    setState(prev => ({ ...prev, selectedLibrary: libraryId, loading: true }));
    
    try {
      const response = await vocabularyManagementService.getLibraryWords(libraryId, {
        page: page,
        per_page: pageSize
      });
      setState(prev => ({ 
        ...prev, 
        words: response.words,
        pagination: {
          current: response.pagination.page,
          pageSize: response.pagination.per_page,
          total: response.pagination.total
        }
      }));
    } catch (error) {
      console.error('Failed to load library words:', error);
      message.error('加载词库单词失败');
    } finally {
      setState(prev => ({ ...prev, loading: false }));
    }
  };

  // 处理分页变化
  const handlePaginationChange = (page: number, pageSize?: number) => {
    if (state.selectedLibrary) {
      handleLibrarySelect(state.selectedLibrary, page, pageSize || state.pagination?.pageSize || 50);
    }
  };

  // 打开编辑/新增模态框
  const handleOpenModal = (word?: VocabularyWord) => {
    setState(prev => ({ 
      ...prev, 
      modalVisible: true, 
      editingWord: word || null 
    }));
    
    if (word) {
      form.setFieldsValue(word);
    } else {
      form.resetFields();
    }
  };

  // 关闭模态框
  const handleCloseModal = () => {
    setState(prev => ({ 
      ...prev, 
      modalVisible: false, 
      editingWord: null 
    }));
    form.resetFields();
  };

  // 保存单词
  const handleSaveWord = async (values: any) => {
    try {
      setState(prev => ({ ...prev, loading: true }));
      
      const wordData: CreateWordRequest = {
        word: values.word,
        phonetic: values.phonetic,
        pronunciation: values.pronunciation,
        definition: values.definition,
        chinese_meaning: values.chinese_meaning,
        part_of_speech: values.part_of_speech,
        grade_level: values.grade_level,
        difficulty: values.difficulty,
        difficulty_level: values.difficulty_level,
        audio_url: values.audio_url,
        image_url: values.image_url,
        example_sentence: values.example_sentence,
        example_chinese: values.example_chinese,
        usage_notes: values.usage_notes,
        source: values.source || 'manual',
        is_core_vocabulary: values.is_core_vocabulary || false
      };
      
      if (state.editingWord) {
        await vocabularyManagementService.updateWord(state.editingWord.id, wordData);
        message.success('单词更新成功');
      } else {
        await vocabularyManagementService.createWord(wordData);
        message.success('单词添加成功');
      }
      
      handleCloseModal();
      
      // 重新加载词库，保持当前页面
      if (state.selectedLibrary) {
        const currentPage = state.pagination?.current || 1;
        const currentPageSize = state.pagination?.pageSize || 50;
        await handleLibrarySelect(state.selectedLibrary, currentPage, currentPageSize);
      }
    } catch (error) {
      console.error('Failed to save word:', error);
      message.error(`保存失败: ${error instanceof Error ? error.message : '未知错误'}`);
    } finally {
      setState(prev => ({ ...prev, loading: false }));
    }
  };

  // 删除单词
  const handleDeleteWord = async (wordId: number) => {
    try {
      setState(prev => ({ ...prev, loading: true }));
      
      console.log('开始删除单词，ID:', wordId);
      const result = await vocabularyManagementService.deleteWord(wordId);
      console.log('删除结果:', result);
      
      message.success('单词删除成功');
      
      // 重新加载词库数据，保持当前页面
      if (state.selectedLibrary) {
        // 强制重新加载
        setState(prev => ({ ...prev, words: [] }));
        const currentPage = state.pagination?.current || 1;
        const currentPageSize = state.pagination?.pageSize || 50;
        await handleLibrarySelect(state.selectedLibrary, currentPage, currentPageSize);
      }
    } catch (error) {
      console.error('删除单词失败:', error);
      message.error(`删除失败: ${error instanceof Error ? error.message : '未知错误'}`);
    } finally {
      setState(prev => ({ ...prev, loading: false }));
    }
  };


  // 增强版导入词库 (带语音生成)
  const handleEnhancedImportLibrary = () => {
    setState(prev => ({ ...prev, enhancedImportModalVisible: true }));
  };

  // 追加导入词库
  const handleAppendImportLibrary = () => {
    setState(prev => ({ ...prev, appendImportModalVisible: true }));
  };


  // 导出词库
  const handleExportLibrary = () => {
    if (!state.selectedLibrary) {
      message.warning('请先选择词库');
      return;
    }
    message.info('词库导出功能开发中');
  };

  // 重新翻译词库
  const handleRetranslateLibrary = () => {
    if (!state.selectedLibrary) {
      message.warning('请先选择词库');
      return;
    }
    setState(prev => ({ ...prev, retranslateModalVisible: true }));
  };

  // 编辑词库信息
  const handleEditLibrary = () => {
    if (!state.selectedLibrary) {
      message.warning('请先选择词库');
      return;
    }
    setState(prev => ({ ...prev, libraryEditModalVisible: true }));
  };

  // 表格列定义
  const columns = [
    {
      title: '单词',
      dataIndex: 'word',
      key: 'word',
      render: (text: string, record: VocabularyWord) => (
        <Space>
          <Text strong>{text}</Text>
          {record.audio_url && <SoundOutlined style={{ color: '#1890ff' }} />}
        </Space>
      )
    },
    {
      title: '音标',
      dataIndex: 'phonetic',
      key: 'phonetic',
      render: (text: string) => text && <Text type="secondary">{text}</Text>
    },
    {
      title: '中文意思',
      dataIndex: 'chinese_meaning',
      key: 'chinese_meaning'
    },
    {
      title: '年级',
      dataIndex: 'grade_level',
      key: 'grade_level',
      render: (level: number) => <Tag color="blue">{level}年级</Tag>
    },
    {
      title: '难度',
      dataIndex: 'difficulty_text',
      key: 'difficulty_text',
      render: (text: string, record: VocabularyWord) => {
        const color = vocabularyManagementService.getDifficultyColor(record.difficulty);
        return <Tag color={color}>{text}</Tag>;
      }
    },
    {
      title: '词性',
      dataIndex: 'part_of_speech',
      key: 'part_of_speech',
      render: (partOfSpeech: string) => {
        if (!partOfSpeech) return null;
        const color = vocabularyManagementService.getPartOfSpeechColor(partOfSpeech);
        return <Tag color={color}>{partOfSpeech}</Tag>;
      }
    },
    {
      title: '操作',
      key: 'actions',
      render: (text: any, record: VocabularyWord) => (
        <Space>
          <Button 
            type="link" 
            icon={<EditOutlined />} 
            onClick={() => handleOpenModal(record)}
          >
            编辑
          </Button>
          <Popconfirm
            title="确定要删除这个单词吗？"
            onConfirm={() => handleDeleteWord(record.id)}
            okText="确定"
            cancelText="取消"
          >
            <Button type="link" danger icon={<DeleteOutlined />}>
              删除
            </Button>
          </Popconfirm>
        </Space>
      )
    }
  ];

  const selectedLibraryInfo = state.libraries.find(lib => lib.id === state.selectedLibrary);

  return (
    <div className="vocabulary-manager">
      <Card>
        <div className="vocabulary-header">
          <Title level={3}>
            <BookOutlined style={{ color: '#1890ff', marginRight: 8 }} />
            词库管理
          </Title>
          <Text type="secondary">管理系统中的词汇库，添加、编辑和组织学习单词</Text>
        </div>

        <Divider />

        {/* 词库选择和统计 */}
        <Row gutter={[16, 16]} style={{ marginBottom: 24 }}>
          <Col xs={24} sm={8}>
            <Card size="small" title="选择词库">
              <Select
                value={state.selectedLibrary}
                onChange={handleLibrarySelect}
                style={{ width: '100%' }}
                placeholder="请选择词库"
                optionFilterProp="children"
                showSearch
                filterOption={(input, option) =>
                  (option?.children as unknown as string).toLowerCase().includes(input.toLowerCase())
                }
              >
                <Select.OptGroup label="小学阶段">
                  {state.libraries
                    .filter(lib => lib.id.startsWith('elementary') || (lib.id.startsWith('grade_') && (lib.grade_level || 0) <= 6))
                    .map(library => (
                      <Option key={library.id} value={library.id}>
                        {library.name} ({library.word_count || 0}词)
                      </Option>
                    ))
                  }
                </Select.OptGroup>
                <Select.OptGroup label="初中阶段">
                  {state.libraries
                    .filter(lib => lib.id.startsWith('middle') || (lib.id.startsWith('grade_') && (lib.grade_level || 0) >= 7))
                    .map(library => (
                      <Option key={library.id} value={library.id}>
                        {library.name} ({library.word_count || 0}词)
                      </Option>
                    ))
                  }
                </Select.OptGroup>
                <Select.OptGroup label="主题分类">
                  {state.libraries
                    .filter(lib => !lib.id.includes('grade_') && !lib.id.includes('elementary') && !lib.id.includes('middle'))
                    .map(library => (
                      <Option key={library.id} value={library.id}>
                        {library.name} ({library.word_count || 0}词)
                      </Option>
                    ))
                  }
                </Select.OptGroup>
              </Select>
            </Card>
          </Col>
          
          <Col xs={24} sm={16}>
            <Row gutter={16}>
              <Col xs={12} sm={6}>
                <Statistic
                  title="词库总数"
                  value={state.libraries.length}
                  prefix={<BookOutlined />}
                  valueStyle={{ color: '#1890ff' }}
                />
              </Col>
              <Col xs={12} sm={6}>
                <Statistic
                  title="当前词库单词数"
                  value={selectedLibraryInfo?.word_count || 0}
                  prefix={<FileTextOutlined />}
                  valueStyle={{ color: '#52c41a' }}
                />
              </Col>
              <Col xs={12} sm={6}>
                <Statistic
                  title="当前显示单词"
                  value={state.words.length}
                  suffix={`/ ${state.pagination?.total || 0}`}
                  valueStyle={{ color: '#faad14' }}
                />
              </Col>
              <Col xs={12} sm={6}>
                <Statistic
                  title="年级范围"
                  value={selectedLibraryInfo?.grade_level || '-'}
                  suffix="年级"
                  valueStyle={{ color: '#722ed1' }}
                />
              </Col>
            </Row>
          </Col>
        </Row>

        {/* 操作按钮 */}
        <div style={{ marginBottom: 16 }}>
          <Space>
            <Button 
              type="primary" 
              icon={<PlusOutlined />}
              onClick={() => handleOpenModal()}
              disabled={!state.selectedLibrary}
            >
              添加单词
            </Button>
            <Button 
              icon={<EditOutlined />}
              onClick={handleEditLibrary}
              disabled={!state.selectedLibrary}
            >
              编辑词库信息
            </Button>
            <Button 
              icon={<ImportOutlined />}
              onClick={handleEnhancedImportLibrary}
              type="primary"
              ghost
            >
              导入词库
            </Button>
            <Button 
              icon={<ImportOutlined />}
              onClick={handleAppendImportLibrary}
              style={{ color: '#52c41a', borderColor: '#52c41a' }}
            >
              追加导入
            </Button>
            <Button 
              icon={<ExportOutlined />}
              onClick={handleExportLibrary}
              disabled={!state.selectedLibrary}
            >
              导出词库
            </Button>
            <Button 
              icon={<TranslationOutlined />}
              onClick={handleRetranslateLibrary}
              disabled={!state.selectedLibrary}
              type="dashed"
            >
              重新翻译
            </Button>
          </Space>
        </div>

        {/* 单词列表 */}
        <Table
          columns={columns}
          dataSource={state.words}
          rowKey="id"
          loading={state.loading}
          pagination={{
            current: state.pagination?.current || 1,
            pageSize: state.pagination?.pageSize || 50,
            total: state.pagination?.total || 0,
            showSizeChanger: true,
            showQuickJumper: true,
            showTotal: (total, range) => `第 ${range?.[0]}-${range?.[1]} 项，共 ${total} 个单词`,
            pageSizeOptions: ['10', '20', '50', '100'],
            onChange: handlePaginationChange,
            onShowSizeChange: handlePaginationChange
          }}
        />

        {/* 编辑/新增单词模态框 */}
        <Modal
          title={state.editingWord ? '编辑单词' : '添加单词'}
          open={state.modalVisible}
          onCancel={handleCloseModal}
          footer={null}
          width={600}
        >
          <Form
            form={form}
            layout="vertical"
            onFinish={handleSaveWord}
          >
            <Row gutter={16}>
              <Col span={12}>
                <Form.Item
                  name="word"
                  label="单词"
                  rules={[{ required: true, message: '请输入单词' }]}
                >
                  <Input placeholder="输入英文单词" />
                </Form.Item>
              </Col>
              <Col span={12}>
                <Form.Item
                  name="pronunciation"
                  label="音标"
                >
                  <Input placeholder="输入音标" />
                </Form.Item>
              </Col>
            </Row>

            <Row gutter={16}>
              <Col span={12}>
                <Form.Item
                  name="chinese_meaning"
                  label="中文意思"
                  rules={[{ required: true, message: '请输入中文意思' }]}
                >
                  <Input placeholder="输入中文意思" />
                </Form.Item>
              </Col>
              <Col span={12}>
                <Form.Item
                  name="category"
                  label="分类"
                  rules={[{ required: true, message: '请选择分类' }]}
                >
                  <Select placeholder="选择分类">
                    <Option value="动物">动物</Option>
                    <Option value="水果">水果</Option>
                    <Option value="学习用品">学习用品</Option>
                    <Option value="颜色">颜色</Option>
                    <Option value="数字">数字</Option>
                    <Option value="家庭">家庭</Option>
                    <Option value="运动">运动</Option>
                    <Option value="食物">食物</Option>
                  </Select>
                </Form.Item>
              </Col>
            </Row>

            <Row gutter={16}>
              <Col span={8}>
                <Form.Item
                  name="grade_level"
                  label="年级"
                  rules={[{ required: true, message: '请选择年级' }]}
                >
                  <Select placeholder="选择年级">
                    {[1, 2, 3, 4, 5, 6, 7, 8, 9].map(grade => (
                      <Option key={grade} value={grade}>{grade}年级</Option>
                    ))}
                  </Select>
                </Form.Item>
              </Col>
              <Col span={8}>
                <Form.Item
                  name="difficulty"
                  label="难度"
                  rules={[{ required: true, message: '请选择难度' }]}
                >
                  <Select placeholder="选择难度">
                    <Option value="easy">简单</Option>
                    <Option value="medium">中等</Option>
                    <Option value="hard">困难</Option>
                  </Select>
                </Form.Item>
              </Col>
              <Col span={8}>
                <Form.Item
                  name="audio_url"
                  label="音频URL"
                >
                  <Input placeholder="输入音频文件URL" />
                </Form.Item>
              </Col>
            </Row>

            <Form.Item
              name="definition"
              label="英文释义"
            >
              <TextArea rows={2} placeholder="输入英文释义" />
            </Form.Item>

            <Form.Item
              name="example_sentence"
              label="例句"
            >
              <TextArea rows={2} placeholder="输入例句" />
            </Form.Item>

            <div style={{ textAlign: 'right' }}>
              <Space>
                <Button onClick={handleCloseModal}>取消</Button>
                <Button type="primary" htmlType="submit" loading={state.loading}>
                  {state.editingWord ? '更新' : '添加'}
                </Button>
              </Space>
            </div>
          </Form>
        </Modal>

        {/* 导入词库模态框 */}
        <VocabularyImportModal
          visible={state.enhancedImportModalVisible}
          onCancel={() => setState(prev => ({ ...prev, enhancedImportModalVisible: false }))}
          onSuccess={async () => {
            setState(prev => ({ ...prev, enhancedImportModalVisible: false }));
            await loadLibraries();
            message.success('词库导入成功！');
          }}
        />

        {/* 追加导入词库模态框 */}
        <VocabularyImportModal
          visible={state.appendImportModalVisible}
          onCancel={() => setState(prev => ({ ...prev, appendImportModalVisible: false }))}
          onSuccess={async () => {
            setState(prev => ({ ...prev, appendImportModalVisible: false }));
            // 重新加载词库列表和当前词库单词
            await loadLibraries();
            if (state.selectedLibrary) {
              const currentPage = state.pagination?.current || 1;
              const currentPageSize = state.pagination?.pageSize || 50;
              await handleLibrarySelect(state.selectedLibrary, currentPage, currentPageSize);
            }
            message.success('词汇追加导入成功！');
          }}
          selectedLibrary={selectedLibraryInfo ? {
            id: selectedLibraryInfo.id,
            name: selectedLibraryInfo.name
          } : null}
          availableLibraries={state.libraries}
        />

        {/* 重新翻译模态框 */}
        {state.selectedLibrary && (
          <RetranslateModal
            visible={state.retranslateModalVisible}
            onCancel={() => setState(prev => ({ ...prev, retranslateModalVisible: false }))}
            onSuccess={async () => {
              setState(prev => ({ ...prev, retranslateModalVisible: false }));
              // 重新加载当前词库的单词，保持当前页面
              if (state.selectedLibrary) {
                const currentPage = state.pagination?.current || 1;
                const currentPageSize = state.pagination?.pageSize || 50;
                await handleLibrarySelect(state.selectedLibrary, currentPage, currentPageSize);
              }
              message.success('词库翻译完成！');
            }}
            libraryId={state.selectedLibrary}
            libraryName={selectedLibraryInfo?.name || ''}
          />
        )}

        {/* 编辑词库信息模态框 */}
        {state.selectedLibrary && (
          <LibraryEditModal
            visible={state.libraryEditModalVisible}
            onCancel={() => setState(prev => ({ ...prev, libraryEditModalVisible: false }))}
            onSuccess={async () => {
              setState(prev => ({ ...prev, libraryEditModalVisible: false }));
              // 重新加载词库列表和当前词库
              await loadLibraries();
              if (state.selectedLibrary) {
                const currentPage = state.pagination?.current || 1;
                const currentPageSize = state.pagination?.pageSize || 50;
                await handleLibrarySelect(state.selectedLibrary, currentPage, currentPageSize);
              }
              message.success('词库信息更新成功！');
            }}
            libraryId={state.selectedLibrary}
            libraryInfo={selectedLibraryInfo}
          />
        )}
      </Card>
    </div>
  );
};

export default VocabularyManager;