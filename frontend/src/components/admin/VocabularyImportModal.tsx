import React, { useState, useEffect } from 'react';
import {
  Modal,
  Form,
  Input,
  Select,
  Button,
  Upload,
  Switch,
  Progress,
  Alert,
  Space,
  Typography,
  Divider,
  Table,
  Tag,
  Row,
  Col,
  Card,
  Statistic,
  message
} from 'antd';
import {
  InboxOutlined,
  SoundOutlined,
  PlayCircleOutlined,
  KeyOutlined,
  CheckCircleOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons';
import { vocabularyManagementService } from '../../services/vocabularyManagementService';
import type { ProcessedWord, ImportPreviewResponse, VoiceOption } from '../../services/vocabularyManagementService';
import './VocabularyImportModal.css';

const { Title, Text } = Typography;
const { Option } = Select;
const { Dragger } = Upload;

interface VocabularyImportModalProps {
  visible: boolean;
  onCancel: () => void;
  onSuccess: () => void;
  selectedLibrary?: {
    id: string;
    name: string;
  } | null;
  availableLibraries?: Array<{
    id: string;
    name: string;
    word_count: number;
  }>;
}

interface ImportState {
  step: 'upload' | 'processing' | 'preview' | 'confirming';
  file: File | null;
  libraryName: string;
  appendMode: boolean;
  apiKey: string;
  translationModel: string;
  selectedVoice: string;
  generateAudio: boolean;
  processing: boolean;
  progress: number;
  previewData: ImportPreviewResponse | null;
  confirming: boolean;
}

const VocabularyImportModal: React.FC<VocabularyImportModalProps> = ({
  visible,
  onCancel,
  onSuccess,
  selectedLibrary,
  availableLibraries = []
}) => {
  const [form] = Form.useForm();
  const [state, setState] = useState<ImportState>({
    step: 'upload',
    file: null,
    libraryName: selectedLibrary?.name || '',
    appendMode: !!selectedLibrary || availableLibraries.length > 0,
    apiKey: '',
    translationModel: 'google/gemini-2.0-flash-001',
    selectedVoice: 'af_bella',
    generateAudio: true,
    processing: false,
    progress: 0,
    previewData: null,
    confirming: false
  });

  const voices = vocabularyManagementService.getKokoroVoices();


  // Handle file upload
  const handleFileUpload = (file: File) => {
    const isValidType = file.type === 'text/csv' ||
                       file.type === 'text/plain' ||
                       file.type === 'application/pdf' ||
                       file.name.endsWith('.md') ||
                       file.name.endsWith('.csv') ||
                       file.name.endsWith('.txt');

    if (!isValidType) {
      message.error('只支持 CSV、TXT、Markdown 或 PDF 文件！');
      return false;
    }

    const isLt10M = file.size / 1024 / 1024 < 10;
    if (!isLt10M) {
      message.error('文件大小不能超过 10MB！');
      return false;
    }

    setState(prev => ({ ...prev, file }));
    return false; // Prevent automatic upload
  };

  // Start import process
  const handleStartImport = async () => {
    try {
      const values = await form.validateFields();
      
      if (!state.file) {
        message.error('请选择要上传的文件');
        return;
      }

      setState(prev => ({ 
        ...prev, 
        step: 'processing',
        processing: true,
        progress: 0,
        libraryName: values.library_name,
        appendMode: values.append_mode || state.appendMode,
        apiKey: values.api_key,
        translationModel: values.translation_model,
        selectedVoice: values.voice,
        generateAudio: values.generate_audio
      }));

      // Simulate progress during processing
      const progressInterval = setInterval(() => {
        setState(prev => ({
          ...prev,
          progress: Math.min(prev.progress + Math.random() * 15, 85)
        }));
      }, 500);

      const response = await vocabularyManagementService.importVocabularyWithAudio(
        state.file,
        values.library_name,
        values.api_key,
        values.translation_model,
        values.voice,
        values.generate_audio,
        state.appendMode
      );

      clearInterval(progressInterval);

      setState(prev => ({
        ...prev,
        step: 'preview',
        processing: false,
        progress: 100,
        previewData: response
      }));

    } catch (error: any) {
      setState(prev => ({ 
        ...prev, 
        processing: false, 
        step: 'upload',
        progress: 0 
      }));
      message.error(error.message || '导入失败，请检查文件格式和API密钥');
    }
  };

  // Confirm import
  const handleConfirmImport = async () => {
    if (!state.previewData) return;

    try {
      setState(prev => ({ ...prev, confirming: true }));

      const response = await vocabularyManagementService.confirmImport(
        state.previewData.library_name,
        state.previewData.processed_words,
        state.appendMode
      );

      message.success(`成功导入 ${response.imported_count} 个单词到词库 "${response.library_name}"`);
      
      handleReset();
      onSuccess();

    } catch (error: any) {
      message.error(error.message || '确认导入失败');
    } finally {
      setState(prev => ({ ...prev, confirming: false }));
    }
  };

  // Play audio preview
  const playAudio = (audioUrl: string) => {
    if (!audioUrl) return;
    
    const audio = new Audio(audioUrl.startsWith('http') ? audioUrl : `/api${audioUrl}`);
    audio.play().catch(err => {
      console.error('Audio play failed:', err);
      message.warning('音频播放失败');
    });
  };

  // Reset modal
  const handleReset = () => {
    setState({
      step: 'upload',
      file: null,
      libraryName: selectedLibrary?.name || '',
      appendMode: !!selectedLibrary || availableLibraries.length > 0,
      apiKey: '',
      translationModel: 'google/gemini-2.0-flash-001',
      selectedVoice: 'af_bella',
      generateAudio: true,
      processing: false,
      progress: 0,
      previewData: null,
      confirming: false
    });
    form.resetFields();
  };

  // Handle modal close
  const handleClose = () => {
    if (state.processing || state.confirming) {
      Modal.confirm({
        title: '确认取消',
        content: '正在处理中，确定要取消吗？',
        onOk: () => {
          handleReset();
          onCancel();
        }
      });
    } else {
      handleReset();
      onCancel();
    }
  };

  // Preview table columns
  const previewColumns = [
    {
      title: '单词',
      dataIndex: 'original_word',
      key: 'word',
      render: (text: string, record: ProcessedWord) => (
        <Space>
          <Text strong style={{ color: record.exists ? '#1890ff' : '#52c41a' }}>
            {text}
          </Text>
          {record.exists && <Tag color="blue">已存在</Tag>}
        </Space>
      )
    },
    {
      title: '中文意思',
      dataIndex: 'chinese_meaning',
      key: 'chinese_meaning'
    },
    {
      title: '发音',
      key: 'audio',
      render: (_, record: ProcessedWord) => (
        <Space>
          {record.audio_url ? (
            <Button
              type="link"
              icon={<SoundOutlined />}
              onClick={() => playAudio(record.audio_url!)}
            >
              播放
            </Button>
          ) : (
            <Text type="secondary">无音频</Text>
          )}
          {record.audio_generated && (
            <Tag color="green" icon={<CheckCircleOutlined />}>
              已生成
            </Tag>
          )}
        </Space>
      )
    }
  ];

  const renderUploadStep = () => (
    <Form form={form} layout="vertical" className="vocabulary-import-form" initialValues={{
      library_name: selectedLibrary?.name || state.libraryName,
      append_mode: state.appendMode,
      translation_model: state.translationModel,
      voice: state.selectedVoice,
      generate_audio: state.generateAudio
    }}>
      {state.appendMode && (
        <Alert
          message="追加导入模式"
          description={selectedLibrary ? 
            `将向现有词库 "${selectedLibrary.name}" 中追加新的单词和短语。` :
            "将向选择的现有词库中追加新的单词和短语。请从下方下拉菜单选择目标词库。"
          }
          type="info"
          showIcon
          style={{ marginBottom: 16 }}
        />
      )}
      
      <Form.Item
        name="append_mode"
        label="导入模式"
        valuePropName="checked"
        extra={state.appendMode ? "追加模式：向现有词库添加新单词" : "新建模式：创建新的词库分类"}
      >
        <Switch 
          checkedChildren="追加到现有词库" 
          unCheckedChildren="创建新词库"
          onChange={(checked) => setState(prev => ({ ...prev, appendMode: checked }))}
        />
      </Form.Item>

      <Form.Item
        name="library_name"
        label={state.appendMode ? "目标词库" : "词库分类"}
        rules={[{ required: true, message: state.appendMode ? '请选择目标词库' : '请输入词库分类名称' }]}
        extra={state.appendMode ? "选择要追加单词的目标词库" : "输入词库分类名称，词汇将被导入到对应分类中"}
      >
        {state.appendMode ? (
          <Select
            placeholder="请选择目标词库"
            showSearch
            filterOption={(input, option) =>
              (option?.children as unknown as string).toLowerCase().includes(input.toLowerCase())
            }
          >
            {availableLibraries.map(library => (
              <Option key={library.id} value={library.name}>
                {library.name} ({library.word_count}词)
              </Option>
            ))}
          </Select>
        ) : (
          <Input
            placeholder="请输入词库分类名称（如：小学一年级单词、初中英语词汇等）"
            allowClear
          />
        )}
      </Form.Item>

      <Form.Item
        name="api_key"
        label="OpenRouter API Key"
        rules={[{ required: true, message: '请输入OpenRouter API密钥' }]}
        extra="用于自动翻译单词的中文意思"
      >
        <Input.Password 
          placeholder="输入您的OpenRouter API密钥" 
          prefix={<KeyOutlined />}
        />
      </Form.Item>

      <Form.Item
        name="translation_model"
        label="翻译模型"
        rules={[{ required: true, message: '请输入翻译模型名称' }]}
        initialValue="google/gemini-2.0-flash-001"
        extra="选择用于翻译的OpenRouter模型，推荐使用 google/gemini-2.0-flash-001"
      >
        <Input
          placeholder="输入OpenRouter模型名称（如：google/gemini-2.0-flash-001）"
          allowClear
        />
      </Form.Item>

      <Row gutter={16}>
        <Col span={12}>
          <Form.Item
            name="generate_audio"
            label="生成语音"
            valuePropName="checked"
            initialValue={true}
          >
            <Switch checkedChildren="开启" unCheckedChildren="关闭" />
          </Form.Item>
        </Col>
        <Col span={12}>
          <Form.Item
            name="voice"
            label="语音选择"
            initialValue="af_bella"
          >
            <Select placeholder="选择语音">
              {voices.map(voice => (
                <Option key={voice.id} value={voice.id}>
                  {voice.name}
                </Option>
              ))}
            </Select>
          </Form.Item>
        </Col>
      </Row>

      <Form.Item
        label="上传文件"
        required
        extra="支持 CSV、TXT、Markdown 或 PDF 格式。支持单词和多词短语，每个词条使用逗号或换行分隔。例如：apple, red apple, go to school, beautiful"
      >
        <Dragger
          beforeUpload={handleFileUpload}
          showUploadList={false}
          accept=".csv,.txt,.md,.pdf"
        >
          <p className="ant-upload-drag-icon">
            <InboxOutlined />
          </p>
          <p className="ant-upload-text">
            {state.file ? `已选择: ${state.file.name}` : '点击或拖拽文件到此区域上传'}
          </p>
          <p className="ant-upload-hint">
            支持单个文件上传，文件大小不超过10MB。支持单词和短语导入，自动翻译和生成语音。
          </p>
        </Dragger>
      </Form.Item>
    </Form>
  );

  const renderProcessingStep = () => (
    <div className="processing-container">
      <div style={{ textAlign: 'center', marginBottom: 24 }}>
        <PlayCircleOutlined style={{ fontSize: 48, color: '#1890ff' }} />
        <Title level={4}>正在处理词库导入</Title>
        <Text type="secondary">
          正在提取单词、翻译中文意思
          {state.generateAudio && '并生成语音文件'}
          ，请稍候...
        </Text>
      </div>
      
      <Progress
        percent={Math.round(state.progress)}
        status="active"
        strokeColor={{
          '0%': '#108ee9',
          '100%': '#87d068',
        }}
      />
      
      <div style={{ textAlign: 'center', marginTop: 16 }}>
        <Text>预计剩余时间: {Math.max(0, Math.round((100 - state.progress) / 10))} 秒</Text>
      </div>
    </div>
  );

  const renderPreviewStep = () => {
    if (!state.previewData) return null;

    return (
      <div className="preview-container">
        <Alert
          message="导入预览"
          description="请检查导入的单词信息，确认无误后点击「确认导入」保存到数据库。"
          type="info"
          showIcon
          style={{ marginBottom: 16 }}
        />

        <Row gutter={16} style={{ marginBottom: 16 }}>
          <Col span={6}>
            <Card>
              <Statistic
                title="总单词数"
                value={state.previewData.total_words}
                valueStyle={{ color: '#1890ff' }}
              />
            </Card>
          </Col>
          <Col span={6}>
            <Card>
              <Statistic
                title="成功处理"
                value={state.previewData.successful_words}
                valueStyle={{ color: '#52c41a' }}
              />
            </Card>
          </Col>
          <Col span={6}>
            <Card>
              <Statistic
                title="处理失败"
                value={state.previewData.failed_count}
                valueStyle={{ color: '#ff4d4f' }}
              />
            </Card>
          </Col>
          <Col span={6}>
            <Card>
              <Statistic
                title="已生成音频"
                value={state.previewData.processed_words.filter(w => w.audio_generated).length}
                valueStyle={{ color: '#722ed1' }}
              />
            </Card>
          </Col>
        </Row>

        {state.previewData.failed_count > 0 && (
          <Alert
            message={`有 ${state.previewData.failed_count} 个单词处理失败`}
            description={
              <div>
                失败的单词: {state.previewData.failed_words.map(f => f.word).join(', ')}
              </div>
            }
            type="warning"
            style={{ marginBottom: 16 }}
          />
        )}

        <Table
          columns={previewColumns}
          dataSource={state.previewData.processed_words}
          rowKey="word"
          pagination={{
            pageSize: 10,
            showSizeChanger: true,
            showTotal: (total) => `共 ${total} 个单词`
          }}
          scroll={{ y: 400 }}
        />
      </div>
    );
  };

  const getModalTitle = () => {
    const baseTitle = state.appendMode ? '追加导入词汇' : '导入词汇';
    switch (state.step) {
      case 'upload': return `${baseTitle} - 输入分类和文件`;
      case 'processing': return `${baseTitle} - 处理中`;
      case 'preview': return `${baseTitle} - 预览确认`;
      default: return baseTitle;
    }
  };

  const getFooterButtons = () => {
    switch (state.step) {
      case 'upload':
        return [
          <Button key="cancel" onClick={handleClose}>
            取消
          </Button>,
          <Button 
            key="import" 
            type="primary" 
            onClick={handleStartImport}
            disabled={!state.file}
          >
            开始导入
          </Button>
        ];
      
      case 'processing':
        return [
          <Button key="cancel" onClick={handleClose} disabled={state.processing}>
            取消
          </Button>
        ];
      
      case 'preview':
        return [
          <Button key="back" onClick={() => setState(prev => ({ ...prev, step: 'upload' }))}>
            返回修改
          </Button>,
          <Button 
            key="confirm" 
            type="primary" 
            onClick={handleConfirmImport}
            loading={state.confirming}
            disabled={!state.previewData?.processed_words.length}
          >
            确认导入
          </Button>
        ];
      
      default:
        return [];
    }
  };

  return (
    <Modal
      title={getModalTitle()}
      open={visible}
      onCancel={handleClose}
      footer={getFooterButtons()}
      width={800}
      destroyOnClose
      maskClosable={false}
    >
      {state.step === 'upload' && renderUploadStep()}
      {state.step === 'processing' && renderProcessingStep()}
      {state.step === 'preview' && renderPreviewStep()}
    </Modal>
  );
};

export default VocabularyImportModal;