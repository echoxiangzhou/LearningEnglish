import React, { useState, useEffect } from 'react';
import {
  Modal,
  Form,
  Input,
  Switch,
  Button,
  Alert,
  Progress,
  Typography,
  Space,
  Statistic,
  Row,
  Col,
  Card,
  message
} from 'antd';
import {
  TranslationOutlined,
  KeyOutlined,
  CheckCircleOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons';
import { vocabularyManagementService } from '../../services/vocabularyManagementService';

const { Title, Text } = Typography;

interface RetranslateModalProps {
  visible: boolean;
  onCancel: () => void;
  onSuccess: () => void;
  libraryId: string;
  libraryName: string;
}

interface UntranslatedInfo {
  untranslated_count: number;
  total_count: number;
  translated_count: number;
}

interface RetranslateState {
  step: 'config' | 'processing' | 'completed';
  apiKey: string;
  translationModel: string;
  forceRetranslate: boolean;
  processing: boolean;
  progress: number;
  untranslatedInfo: UntranslatedInfo | null;
  result: any | null;
}

const RetranslateModal: React.FC<RetranslateModalProps> = ({
  visible,
  onCancel,
  onSuccess,
  libraryId,
  libraryName
}) => {
  const [form] = Form.useForm();
  const [state, setState] = useState<RetranslateState>({
    step: 'config',
    apiKey: '',
    translationModel: 'google/gemini-2.0-flash-001',
    forceRetranslate: false,
    processing: false,
    progress: 0,
    untranslatedInfo: null,
    result: null
  });

  // Load untranslated words count when modal opens
  useEffect(() => {
    if (visible && libraryId) {
      loadUntranslatedCount();
    }
  }, [visible, libraryId]);


  const loadUntranslatedCount = async () => {
    try {
      const response = await vocabularyManagementService.getUntranslatedWordsCount(libraryId);
      setState(prev => ({
        ...prev,
        untranslatedInfo: {
          untranslated_count: response.untranslated_count,
          total_count: response.total_count,
          translated_count: response.translated_count
        }
      }));
    } catch (error: any) {
      message.error(`获取未翻译单词数量失败: ${error.message}`);
    }
  };

  const handleStartRetranslate = async () => {
    try {
      const values = await form.validateFields();
      
      setState(prev => ({ 
        ...prev, 
        step: 'processing',
        processing: true,
        progress: 0,
        apiKey: values.api_key,
        translationModel: values.translation_model,
        forceRetranslate: values.force_retranslate
      }));

      // Simulate progress during processing
      const progressInterval = setInterval(() => {
        setState(prev => ({
          ...prev,
          progress: Math.min(prev.progress + Math.random() * 10, 90)
        }));
      }, 1000);

      const response = await vocabularyManagementService.retranslateLibraryWords(
        libraryId,
        values.api_key,
        values.translation_model,
        values.force_retranslate
      );

      clearInterval(progressInterval);

      setState(prev => ({
        ...prev,
        step: 'completed',
        processing: false,
        progress: 100,
        result: response
      }));

      message.success(`成功翻译 ${response.translated_count} 个单词！`);

    } catch (error: any) {
      setState(prev => ({ 
        ...prev, 
        processing: false, 
        step: 'config',
        progress: 0 
      }));
      message.error(`翻译失败: ${error.message}`);
    }
  };

  const handleReset = () => {
    setState({
      step: 'config',
      apiKey: '',
      translationModel: 'google/gemini-2.0-flash-001',
      forceRetranslate: false,
      processing: false,
      progress: 0,
      untranslatedInfo: null,
      result: null
    });
    form.resetFields();
  };

  const handleClose = () => {
    if (state.processing) {
      Modal.confirm({
        title: '确认取消',
        content: '正在翻译中，确定要取消吗？',
        onOk: () => {
          handleReset();
          onCancel();
        }
      });
    } else {
      if (state.result && state.result.translated_count > 0) {
        onSuccess();
      }
      handleReset();
      onCancel();
    }
  };

  const renderConfigStep = () => (
    <div>
      {state.untranslatedInfo && (
        <Alert
          message="词库翻译状态"
          description={
            <Row gutter={16} style={{ marginTop: 8 }}>
              <Col span={8}>
                <Statistic
                  title="总单词数"
                  value={state.untranslatedInfo.total_count}
                  valueStyle={{ color: '#1890ff' }}
                />
              </Col>
              <Col span={8}>
                <Statistic
                  title="已翻译"
                  value={state.untranslatedInfo.translated_count}
                  valueStyle={{ color: '#52c41a' }}
                />
              </Col>
              <Col span={8}>
                <Statistic
                  title="未翻译"
                  value={state.untranslatedInfo.untranslated_count}
                  valueStyle={{ color: '#faad14' }}
                />
              </Col>
            </Row>
          }
          type="info"
          style={{ marginBottom: 16 }}
        />
      )}

      <Form form={form} layout="vertical">
        <Form.Item
          name="api_key"
          label="OpenRouter API Key"
          rules={[{ required: true, message: '请输入API密钥' }]}
          extra="用于调用翻译模型"
        >
          <Input.Password 
            placeholder="输入您的OpenRouter API密钥" 
            prefix={<KeyOutlined />}
          />
        </Form.Item>

        <Form.Item
          name="translation_model"
          label="翻译模型"
          rules={[{ required: true, message: '请输入翻译模型' }]}
          initialValue="google/gemini-2.0-flash-001"
          extra="推荐使用 google/gemini-2.0-flash-001"
        >
          <Input
            placeholder="输入OpenRouter模型名称"
            allowClear
          />
        </Form.Item>

        <Form.Item
          name="force_retranslate"
          label="强制重新翻译"
          valuePropName="checked"
          initialValue={false}
          extra="开启后将重新翻译所有单词，包括已有翻译的单词"
        >
          <Switch 
            checkedChildren="强制翻译所有单词" 
            unCheckedChildren="仅翻译未翻译单词" 
          />
        </Form.Item>
      </Form>
    </div>
  );

  const renderProcessingStep = () => (
    <div style={{ textAlign: 'center', padding: '20px 0' }}>
      <TranslationOutlined style={{ fontSize: 48, color: '#1890ff', marginBottom: 16 }} />
      <Title level={4}>正在翻译单词</Title>
      <Text type="secondary">
        正在使用 {state.translationModel} 模型翻译词库中的单词，请稍候...
      </Text>
      
      <Progress
        percent={Math.round(state.progress)}
        status="active"
        strokeColor={{
          '0%': '#108ee9',
          '100%': '#87d068',
        }}
        style={{ marginTop: 24 }}
      />
      
      <div style={{ marginTop: 16 }}>
        <Text>预计剩余时间: {Math.max(0, Math.round((100 - state.progress) / 20))} 分钟</Text>
      </div>
    </div>
  );

  const renderCompletedStep = () => {
    if (!state.result) return null;

    return (
      <div>
        <Alert
          message="翻译完成"
          description={`成功翻译 ${state.result.translated_count} 个单词`}
          type="success"
          showIcon
          style={{ marginBottom: 16 }}
        />

        <Row gutter={16}>
          <Col span={12}>
            <Card>
              <Statistic
                title="翻译成功"
                value={state.result.translated_count}
                valueStyle={{ color: '#52c41a' }}
                prefix={<CheckCircleOutlined />}
              />
            </Card>
          </Col>
          <Col span={12}>
            <Card>
              <Statistic
                title="总处理数"
                value={state.result.total_words}
                valueStyle={{ color: '#1890ff' }}
              />
            </Card>
          </Col>
        </Row>

        {state.result.failed_words && state.result.failed_words.length > 0 && (
          <Alert
            message={`有 ${state.result.failed_count} 个单词翻译失败`}
            description={
              <div>
                失败的单词: {state.result.failed_words.join(', ')}
                {state.result.failed_count > 10 && '...'}
              </div>
            }
            type="warning"
            style={{ marginTop: 16 }}
          />
        )}
      </div>
    );
  };

  const getModalTitle = () => {
    switch (state.step) {
      case 'config': return `重新翻译词库 - ${libraryName}`;
      case 'processing': return `翻译进行中 - ${libraryName}`;
      case 'completed': return `翻译完成 - ${libraryName}`;
      default: return '重新翻译词库';
    }
  };

  const getFooterButtons = () => {
    switch (state.step) {
      case 'config':
        return [
          <Button key="cancel" onClick={handleClose}>
            取消
          </Button>,
          <Button 
            key="start" 
            type="primary" 
            onClick={handleStartRetranslate}
            disabled={!state.untranslatedInfo || 
              (!state.forceRetranslate && state.untranslatedInfo.untranslated_count === 0)}
          >
            开始翻译
          </Button>
        ];
      
      case 'processing':
        return [
          <Button key="cancel" onClick={handleClose} disabled={state.processing}>
            取消
          </Button>
        ];
      
      case 'completed':
        return [
          <Button key="close" type="primary" onClick={handleClose}>
            完成
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
      width={600}
      destroyOnClose
      maskClosable={false}
    >
      {state.step === 'config' && renderConfigStep()}
      {state.step === 'processing' && renderProcessingStep()}
      {state.step === 'completed' && renderCompletedStep()}
    </Modal>
  );
};

export default RetranslateModal;