import React, { useState, useEffect } from 'react';
import {
  Modal,
  Form,
  Input,
  Select,
  Button,
  Tag,
  Descriptions,
  Divider,
  message,
  Space,
  Progress,
  Alert
} from 'antd';
import {
  EditOutlined,
  SaveOutlined,
  CloseOutlined,
  CheckOutlined,
  InfoCircleOutlined
} from '@ant-design/icons';
import { sentenceAdminService } from '../../services/sentenceAdminService';
import type { SentenceData } from '../../services/sentenceAdminService';

const { Option } = Select;
const { TextArea } = Input;

interface SentenceDetailModalProps {
  sentenceId: number | null;
  visible: boolean;
  onClose: () => void;
  onUpdate: () => void;
}

const SentenceDetailModal: React.FC<SentenceDetailModalProps> = ({
  sentenceId,
  visible,
  onClose,
  onUpdate
}) => {
  const [sentence, setSentence] = useState<SentenceData | null>(null);
  const [loading, setLoading] = useState(false);
  const [editing, setEditing] = useState(false);
  const [form] = Form.useForm();

  useEffect(() => {
    if (visible && sentenceId) {
      fetchSentenceDetail();
    }
  }, [visible, sentenceId]);

  useEffect(() => {
    if (sentence && editing) {
      form.setFieldsValue({
        text: sentence.text,
        chinese_translation: sentence.chinese_translation,
        target_word: sentence.target_word,
        difficulty: sentence.difficulty
      });
    }
  }, [sentence, editing, form]);

  const fetchSentenceDetail = async () => {
    if (!sentenceId) return;
    
    try {
      setLoading(true);
      const data = await sentenceAdminService.getSentenceById(sentenceId);
      setSentence(data);
    } catch (error) {
      message.error('获取句子详情失败');
      console.error('Error fetching sentence detail:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSave = async (values: any) => {
    if (!sentenceId) return;

    try {
      setLoading(true);
      const updatedSentence = await sentenceAdminService.updateSentence(sentenceId, values);
      setSentence(updatedSentence);
      setEditing(false);
      message.success('更新成功');
      onUpdate();
    } catch (error) {
      message.error('更新失败');
      console.error('Error updating sentence:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleApprove = async () => {
    if (!sentenceId) return;

    try {
      await sentenceAdminService.approveSentences({
        sentence_ids: [sentenceId],
        approved_by: 'Admin'
      });
      message.success('句子已批准');
      fetchSentenceDetail();
      onUpdate();
    } catch (error) {
      message.error('批准失败');
    }
  };

  const handleReject = async () => {
    if (!sentenceId) return;

    Modal.confirm({
      title: '拒绝句子',
      content: (
        <div>
          <p>请输入拒绝原因：</p>
          <TextArea id="rejection-reason" placeholder="请输入拒绝原因..." rows={3} />
        </div>
      ),
      onOk: async () => {
        const reason = (document.getElementById('rejection-reason') as HTMLTextAreaElement)?.value;
        if (!reason.trim()) {
          message.error('请输入拒绝原因');
          return;
        }

        try {
          await sentenceAdminService.rejectSentences({
            sentence_ids: [sentenceId],
            rejection_reason: reason
          });
          message.success('句子已拒绝');
          fetchSentenceDetail();
          onUpdate();
        } catch (error) {
          message.error('拒绝失败');
        }
      }
    });
  };

  const getScoreColor = (score: number) => {
    if (score >= 0.8) return '#52c41a';
    if (score >= 0.6) return '#1890ff';
    if (score >= 0.4) return '#fa8c16';
    return '#f5222d';
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'approved': return 'success';
      case 'rejected': return 'error';
      case 'pending': return 'warning';
      default: return 'default';
    }
  };

  const getDifficultyColor = (difficulty: string) => {
    switch (difficulty) {
      case 'elementary': return 'green';
      case 'intermediate': return 'orange';
      case 'advanced': return 'red';
      default: return 'default';
    }
  };

  const renderEditForm = () => (
    <Form
      form={form}
      layout="vertical"
      onFinish={handleSave}
      initialValues={sentence || {}}
    >
      <Form.Item
        name="text"
        label="英文句子"
        rules={[{ required: true, message: '请输入英文句子' }]}
      >
        <TextArea rows={3} placeholder="请输入英文句子..." />
      </Form.Item>

      <Form.Item
        name="chinese_translation"
        label="中文翻译"
        rules={[{ required: true, message: '请输入中文翻译' }]}
      >
        <TextArea rows={2} placeholder="请输入中文翻译..." />
      </Form.Item>

      <Form.Item
        name="target_word"
        label="目标词汇"
        rules={[{ required: true, message: '请输入目标词汇' }]}
      >
        <Input placeholder="请输入目标词汇..." />
      </Form.Item>

      <Form.Item
        name="difficulty"
        label="难度等级"
        rules={[{ required: true, message: '请选择难度等级' }]}
      >
        <Select placeholder="请选择难度等级">
          <Option value="elementary">初级</Option>
          <Option value="intermediate">中级</Option>
          <Option value="advanced">高级</Option>
        </Select>
      </Form.Item>

      <Form.Item>
        <Space>
          <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={loading}>
            保存
          </Button>
          <Button onClick={() => setEditing(false)} icon={<CloseOutlined />}>
            取消
          </Button>
        </Space>
      </Form.Item>
    </Form>
  );

  const renderViewMode = () => (
    <div>
      <Descriptions column={1} bordered size="small">
        <Descriptions.Item label="英文句子">
          <div style={{ fontSize: '16px', fontWeight: 500, marginBottom: '8px' }}>
            {sentence?.text}
          </div>
        </Descriptions.Item>
        
        <Descriptions.Item label="中文翻译">
          <div style={{ fontSize: '14px', color: '#666', fontStyle: 'italic' }}>
            {sentence?.chinese_translation}
          </div>
        </Descriptions.Item>

        <Descriptions.Item label="目标词汇">
          <Tag color="blue" style={{ fontSize: '14px', padding: '4px 8px' }}>
            {sentence?.target_word}
          </Tag>
        </Descriptions.Item>

        <Descriptions.Item label="难度等级">
          <Tag color={getDifficultyColor(sentence?.difficulty || '')}>
            {sentence?.difficulty === 'elementary' ? '初级' : 
             sentence?.difficulty === 'intermediate' ? '中级' : '高级'}
          </Tag>
        </Descriptions.Item>

        <Descriptions.Item label="审核状态">
          <Tag color={getStatusColor(sentence?.approval_status || '')}>
            {sentence?.approval_status === 'pending' ? '待审核' : 
             sentence?.approval_status === 'approved' ? '已批准' : '已拒绝'}
          </Tag>
        </Descriptions.Item>

        <Descriptions.Item label="创建时间">
          {sentence?.created_at ? new Date(sentence.created_at).toLocaleString('zh-CN') : '-'}
        </Descriptions.Item>

        {sentence?.approved_at && (
          <Descriptions.Item label="批准时间">
            {new Date(sentence.approved_at).toLocaleString('zh-CN')}
          </Descriptions.Item>
        )}

        {sentence?.approved_by && (
          <Descriptions.Item label="批准人">
            {sentence.approved_by}
          </Descriptions.Item>
        )}

        {sentence?.rejection_reason && (
          <Descriptions.Item label="拒绝原因">
            <Alert message={sentence.rejection_reason} type="error" showIcon />
          </Descriptions.Item>
        )}
      </Descriptions>

      <Divider>质量评分</Divider>
      
      <div style={{ marginBottom: '16px' }}>
        <div style={{ marginBottom: '12px' }}>
          <span style={{ fontWeight: 500 }}>总体评分：</span>
          <Progress
            percent={Math.round((sentence?.overall_score || 0) * 100)}
            strokeColor={getScoreColor(sentence?.overall_score || 0)}
            style={{ width: '200px', display: 'inline-block', marginLeft: '8px' }}
          />
        </div>
        
        <div style={{ marginBottom: '12px' }}>
          <span style={{ fontWeight: 500 }}>语法评分：</span>
          <Progress
            percent={Math.round((sentence?.grammar_score || 0) * 100)}
            strokeColor={getScoreColor(sentence?.grammar_score || 0)}
            style={{ width: '200px', display: 'inline-block', marginLeft: '8px' }}
          />
        </div>
        
        <div style={{ marginBottom: '12px' }}>
          <span style={{ fontWeight: 500 }}>置信度：</span>
          <Progress
            percent={Math.round((sentence?.confidence || 0) * 100)}
            strokeColor={getScoreColor(sentence?.confidence || 0)}
            style={{ width: '200px', display: 'inline-block', marginLeft: '8px' }}
          />
        </div>
      </div>

      {sentence?.approval_status === 'pending' && (
        <div style={{ marginTop: '24px' }}>
          <Space>
            <Button type="primary" icon={<CheckOutlined />} onClick={handleApprove}>
              批准
            </Button>
            <Button danger icon={<CloseOutlined />} onClick={handleReject}>
              拒绝
            </Button>
            <Button icon={<EditOutlined />} onClick={() => setEditing(true)}>
              编辑
            </Button>
          </Space>
        </div>
      )}

      {sentence?.approval_status !== 'pending' && (
        <div style={{ marginTop: '24px' }}>
          <Button icon={<EditOutlined />} onClick={() => setEditing(true)}>
            编辑
          </Button>
        </div>
      )}
    </div>
  );

  return (
    <Modal
      title={
        <Space>
          <InfoCircleOutlined />
          {editing ? '编辑句子' : '句子详情'}
        </Space>
      }
      open={visible}
      onCancel={() => {
        setEditing(false);
        onClose();
      }}
      footer={null}
      width={800}
      loading={loading}
    >
      {sentence && (editing ? renderEditForm() : renderViewMode())}
    </Modal>
  );
};

export default SentenceDetailModal;