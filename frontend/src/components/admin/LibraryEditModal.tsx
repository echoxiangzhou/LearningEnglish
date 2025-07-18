import React, { useState, useEffect } from 'react';
import {
  Modal,
  Form,
  Input,
  Select,
  Button,
  Switch,
  Progress,
  Alert,
  Space,
  Typography,
  Divider,
  Row,
  Col,
  Statistic,
  message
} from 'antd';
import {
  EditOutlined,
  SoundOutlined,
  CheckCircleOutlined,
  ExclamationCircleOutlined,
  KeyOutlined
} from '@ant-design/icons';
import { vocabularyManagementService } from '../../services/vocabularyManagementService';
import type { WordLibrary } from '../../types/dictation';
import './LibraryEditModal.css';

const { Title, Text } = Typography;
const { Option } = Select;

interface LibraryEditModalProps {
  visible: boolean;
  onCancel: () => void;
  onSuccess: () => void;
  libraryId: string;
  libraryInfo?: WordLibrary | null;
}

interface EditState {
  step: 'edit' | 'processing' | 'completed';
  loading: boolean;
  progress: number;
  updatedCount: number;
  phoneticsGenerated: number;
  apiKey: string;
}

const LibraryEditModal: React.FC<LibraryEditModalProps> = ({
  visible,
  onCancel,
  onSuccess,
  libraryId,
  libraryInfo
}) => {
  const [form] = Form.useForm();
  const [state, setState] = useState<EditState>({
    step: 'edit',
    loading: false,
    progress: 0,
    updatedCount: 0,
    phoneticsGenerated: 0,
    apiKey: ''
  });

  // Initialize form with current library data
  useEffect(() => {
    if (visible && libraryInfo) {
      form.setFieldsValue({
        name: libraryInfo.name,
        grade_level: libraryInfo.grade_level,
        description: libraryInfo.description
      });
    }
  }, [visible, libraryInfo, form]);

  // Handle form submission
  const handleSubmit = async (values: any) => {
    try {
      setState(prev => ({ ...prev, step: 'processing', loading: true, progress: 0 }));

      // Start progress simulation
      const progressInterval = setInterval(() => {
        setState(prev => ({
          ...prev,
          progress: Math.min(prev.progress + Math.random() * 10, 85)
        }));
      }, 500);

      // Call API to update library information
      const response = await vocabularyManagementService.updateLibraryInfo(libraryId, {
        name: values.name,
        grade_level: values.grade_level,
        description: values.description,
        update_words_grade: values.update_words_grade,
        generate_phonetics: values.generate_phonetics,
        api_key: values.generate_phonetics ? state.apiKey : undefined
      });

      clearInterval(progressInterval);

      setState(prev => ({
        ...prev,
        step: 'completed',
        loading: false,
        progress: 100,
        updatedCount: response.updated_words || 0,
        phoneticsGenerated: response.phonetics_generated || 0
      }));

    } catch (error: any) {
      setState(prev => ({ 
        ...prev, 
        loading: false, 
        step: 'edit',
        progress: 0 
      }));
      message.error(error.message || '更新失败，请重试');
    }
  };

  // Reset modal
  const handleReset = () => {
    setState({
      step: 'edit',
      loading: false,
      progress: 0,
      updatedCount: 0,
      phoneticsGenerated: 0,
      apiKey: ''
    });
    form.resetFields();
  };

  // Handle modal close
  const handleClose = () => {
    if (state.loading) {
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

  const renderEditStep = () => (
    <Form form={form} layout="vertical" onFinish={handleSubmit}>
      <Alert
        message="编辑词库信息"
        description="修改词库的基本信息，可选择同时更新词库内所有单词的年级和生成音标。"
        type="info"
        showIcon
        style={{ marginBottom: 16 }}
      />

      <Form.Item
        name="name"
        label="词库名称"
        rules={[{ required: true, message: '请输入词库名称' }]}
      >
        <Input placeholder="输入词库名称" />
      </Form.Item>

      <Form.Item
        name="grade_level"
        label="年级级别"
        rules={[{ required: true, message: '请选择年级级别' }]}
      >
        <Select placeholder="选择年级级别">
          {[1, 2, 3, 4, 5, 6, 7, 8, 9].map(grade => (
            <Option key={grade} value={grade}>{grade}年级</Option>
          ))}
        </Select>
      </Form.Item>

      <Form.Item
        name="description"
        label="词库描述"
      >
        <Input.TextArea rows={3} placeholder="输入词库描述（可选）" />
      </Form.Item>

      <Divider />

      <Form.Item
        name="update_words_grade"
        label="同时更新单词年级"
        valuePropName="checked"
        extra="开启后，词库内所有单词的年级将更新为新设置的年级级别"
      >
        <Switch checkedChildren="开启" unCheckedChildren="关闭" />
      </Form.Item>

      <Form.Item
        name="generate_phonetics"
        label="生成音标"
        valuePropName="checked"
        extra="为词库内没有音标的单词自动生成音标（需要API密钥）"
      >
        <Switch 
          checkedChildren="开启" 
          unCheckedChildren="关闭"
          onChange={(checked) => {
            if (checked) {
              // 显示API密钥输入
              form.setFieldsValue({ show_api_key: true });
            }
          }}
        />
      </Form.Item>

      <Form.Item
        noStyle
        shouldUpdate={(prevValues, currentValues) =>
          prevValues.generate_phonetics !== currentValues.generate_phonetics
        }
      >
        {({ getFieldValue }) =>
          getFieldValue('generate_phonetics') ? (
            <Form.Item
              label="OpenRouter API Key"
              extra="用于自动生成音标的API密钥"
              required
            >
              <Input.Password 
                placeholder="输入您的OpenRouter API密钥" 
                prefix={<KeyOutlined />}
                value={state.apiKey}
                onChange={(e) => setState(prev => ({ ...prev, apiKey: e.target.value }))}
              />
            </Form.Item>
          ) : null
        }
      </Form.Item>

      <div style={{ textAlign: 'right' }}>
        <Space>
          <Button onClick={handleClose}>取消</Button>
          <Button 
            type="primary" 
            htmlType="submit" 
            loading={state.loading}
            disabled={form.getFieldValue('generate_phonetics') && !state.apiKey}
          >
            确认更新
          </Button>
        </Space>
      </div>
    </Form>
  );

  const renderProcessingStep = () => (
    <div className="processing-container">
      <EditOutlined style={{ fontSize: 48, color: '#1890ff', marginBottom: 16 }} />
      <Title level={4}>正在更新词库信息</Title>
      <Text type="secondary">
        正在更新词库信息
        {form.getFieldValue('update_words_grade') && '并批量更新单词年级'}
        {form.getFieldValue('generate_phonetics') && '和生成音标'}
        ，请稍候...
      </Text>
      
      <Progress
        percent={Math.round(state.progress)}
        status="active"
        strokeColor={{
          '0%': '#108ee9',
          '100%': '#87d068',
        }}
        style={{ marginTop: 20 }}
      />
      
      <div style={{ marginTop: 16 }}>
        <Text>预计剩余时间: {Math.max(0, Math.round((100 - state.progress) / 10))} 秒</Text>
      </div>
    </div>
  );

  const renderCompletedStep = () => (
    <div className="completed-container">
      <CheckCircleOutlined style={{ fontSize: 48, color: '#52c41a', marginBottom: 16 }} />
      <Title level={4}>更新完成</Title>
      
      <Row gutter={16} style={{ marginTop: 20 }}>
        <Col span={12}>
          <Statistic
            title="更新的单词数"
            value={state.updatedCount}
            valueStyle={{ color: '#52c41a' }}
          />
        </Col>
        <Col span={12}>
          <Statistic
            title="生成的音标数"
            value={state.phoneticsGenerated}
            valueStyle={{ color: '#1890ff' }}
          />
        </Col>
      </Row>

      <div style={{ textAlign: 'right', marginTop: 24 }}>
        <Button type="primary" onClick={onSuccess}>
          完成
        </Button>
      </div>
    </div>
  );

  const getModalTitle = () => {
    switch (state.step) {
      case 'edit': return '编辑词库信息';
      case 'processing': return '更新中';
      case 'completed': return '更新完成';
      default: return '编辑词库信息';
    }
  };

  return (
    <Modal
      title={getModalTitle()}
      open={visible}
      onCancel={handleClose}
      footer={null}
      width={600}
      destroyOnClose
      maskClosable={!state.loading}
      className="library-edit-modal"
    >
      {state.step === 'edit' && renderEditStep()}
      {state.step === 'processing' && renderProcessingStep()}
      {state.step === 'completed' && renderCompletedStep()}
    </Modal>
  );
};

export default LibraryEditModal;