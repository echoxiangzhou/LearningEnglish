import React, { useState } from 'react';
import { Card, Button, Typography, Space, Alert, Descriptions } from 'antd';
import { ImportOutlined } from '@ant-design/icons';

const { Title, Paragraph, Text } = Typography;

const VocabularyImportDemo: React.FC = () => {
  const [showChanges, setShowChanges] = useState(false);

  return (
    <div style={{ padding: '24px', maxWidth: '1000px', margin: '0 auto' }}>
      <Card style={{ marginBottom: '24px' }}>
        <Space direction="vertical" size="large" style={{ width: '100%' }}>
          <div style={{ textAlign: 'center' }}>
            <ImportOutlined style={{ fontSize: '48px', color: '#1890ff', marginBottom: '16px' }} />
            <Title level={2}>词汇导入功能优化</Title>
            <Paragraph>
              词库导入界面已更新，现在支持手动输入词库分类名称，同时新增翻译模型选择功能，
              用户可以自定义选择OpenRouter中的翻译模型进行单词翻译。
            </Paragraph>
          </div>

          <Alert
            message="功能更新完成"
            description="词库导入界面已更新，现在支持手动输入词库分类名称和自定义选择OpenRouter翻译模型。"
            type="success"
            showIcon
          />

          <Button 
            type="primary" 
            onClick={() => setShowChanges(!showChanges)}
            style={{ marginTop: '16px' }}
          >
            {showChanges ? '隐藏' : '查看'} 具体改进内容
          </Button>
        </Space>
      </Card>

      {showChanges && (
        <>
          <Card title="🔄 主要更新内容" style={{ marginBottom: '24px' }}>
            <Descriptions bordered column={1}>
              <Descriptions.Item label="词库分类">
                将下拉选择器改为手动输入框，支持自定义分类名称
              </Descriptions.Item>
              <Descriptions.Item label="翻译模型">
                新增翻译模型选择字段，支持自定义OpenRouter模型
              </Descriptions.Item>
              <Descriptions.Item label="用户体验">
                提供默认推荐模型，同时允许用户灵活选择
              </Descriptions.Item>
              <Descriptions.Item label="灵活性">
                支持输入任意词库分类名称和翻译模型
              </Descriptions.Item>
              <Descriptions.Item label="兼容性">
                向后兼容现有的API接口和数据结构
              </Descriptions.Item>
            </Descriptions>
          </Card>

          <Card title="💡 推荐的翻译模型" style={{ marginBottom: '24px' }}>
            <div style={{ marginBottom: '16px', padding: '12px', background: '#f5f5f5', borderRadius: '6px' }}>
              <Space size="large">
                <span><span style={{ color: '#52c41a', fontWeight: 'bold' }}>●</span> 推荐模型</span>
                <span><span style={{ color: '#fa8c16', fontWeight: 'bold' }}>●</span> 备选模型</span>
                <span><span style={{ color: '#eb2f96', fontWeight: 'bold' }}>●</span> 经济模型</span>
              </Space>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(350px, 1fr))', gap: '16px' }}>
              <Card size="small" style={{ border: '2px solid #b7eb8f' }}>
                <Space direction="vertical" size="small" style={{ width: '100%' }}>
                  <Text strong style={{ color: '#52c41a' }}>
                    google/gemini-flash-1.5 (推荐)
                  </Text>
                  <Text type="secondary" style={{ fontSize: '12px' }}>
                    速度快、质量高、性价比优秀的翻译模型
                  </Text>
                </Space>
              </Card>
              
              <Card size="small" style={{ border: '2px solid #b7eb8f' }}>
                <Space direction="vertical" size="small" style={{ width: '100%' }}>
                  <Text strong style={{ color: '#52c41a' }}>
                    google/gemini-2.0-flash-exp
                  </Text>
                  <Text type="secondary" style={{ fontSize: '12px' }}>
                    最新实验版本，翻译质量更优
                  </Text>
                </Space>
              </Card>

              <Card size="small" style={{ border: '2px solid #ffd591' }}>
                <Space direction="vertical" size="small" style={{ width: '100%' }}>
                  <Text strong style={{ color: '#fa8c16' }}>
                    anthropic/claude-3-haiku
                  </Text>
                  <Text type="secondary" style={{ fontSize: '12px' }}>
                    Claude模型，理解能力强
                  </Text>
                </Space>
              </Card>

              <Card size="small" style={{ border: '2px solid #ffadd2' }}>
                <Space direction="vertical" size="small" style={{ width: '100%' }}>
                  <Text strong style={{ color: '#eb2f96' }}>
                    meta-llama/llama-3.2-3b-instruct
                  </Text>
                  <Text type="secondary" style={{ fontSize: '12px' }}>
                    开源模型，成本较低
                  </Text>
                </Space>
              </Card>
            </div>
          </Card>

          <Card title="✨ 新增功能特性">
            <Space direction="vertical" size="middle" style={{ width: '100%' }}>
              <div>
                <Text strong>📝 自定义分类：</Text>
                <Text> 支持手动输入任意词库分类名称，更加灵活</Text>
              </div>
              
              <div>
                <Text strong>🤖 翻译模型选择：</Text>
                <Text> 新增翻译模型字段，支持选择不同的OpenRouter模型</Text>
              </div>
              
              <div>
                <Text strong>🎯 默认推荐：</Text>
                <Text> 提供推荐的翻译模型作为默认值，同时支持自定义</Text>
              </div>
              
              <div>
                <Text strong>🔧 API兼容：</Text>
                <Text> 向后兼容现有API接口，新增翻译模型参数传递</Text>
              </div>
              
              <div>
                <Text strong>💡 用户引导：</Text>
                <Text> 提供输入示例和模型推荐，帮助用户更好地使用功能</Text>
              </div>
            </Space>
          </Card>
        </>
      )}

      <Card style={{ marginTop: '24px' }}>
        <Alert
          message="开发者说明"
          description={
            <div>
              <p>修改文件：<code>frontend/src/components/admin/VocabularyImportModal.tsx</code> 和 <code>frontend/src/services/vocabularyManagementService.ts</code></p>
              <p>主要改动：</p>
              <ul style={{ marginTop: '8px', paddingLeft: '20px' }}>
                <li>将词库分类下拉选择器改回手动输入框</li>
                <li>新增翻译模型选择字段，支持自定义OpenRouter模型</li>
                <li>更新API服务方法，增加翻译模型参数传递</li>
                <li>优化界面布局和用户交互体验</li>
                <li>提供默认推荐模型和输入示例</li>
              </ul>
            </div>
          }
          type="info"
          showIcon
        />
      </Card>
    </div>
  );
};

export default VocabularyImportDemo;