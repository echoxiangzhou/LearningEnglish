import React from 'react';
import { Card, Form, Switch, Select, Slider, Button, Divider, message } from 'antd';
import './Settings.css';

const { Option } = Select;

const Settings: React.FC = () => {
  const [form] = Form.useForm();

  const handleSave = (values: any) => {
    console.log('Settings saved:', values);
    message.success('设置已保存');
  };

  return (
    <div className="settings-container">
      <Card title="系统设置" className="settings-card">
        <Form
          form={form}
          layout="vertical"
          onFinish={handleSave}
          initialValues={{
            language: 'zh-CN',
            theme: 'light',
            notifications: true,
            soundEffects: true,
            autoSave: true,
            difficulty: 3,
            playbackSpeed: 1,
          }}
        >
          <h3>界面设置</h3>
          <Form.Item label="语言" name="language">
            <Select>
              <Option value="zh-CN">中文</Option>
              <Option value="en-US">English</Option>
            </Select>
          </Form.Item>

          <Form.Item label="主题" name="theme">
            <Select>
              <Option value="light">浅色主题</Option>
              <Option value="dark">深色主题</Option>
              <Option value="auto">跟随系统</Option>
            </Select>
          </Form.Item>

          <Divider />

          <h3>学习设置</h3>
          <Form.Item label="默认难度等级" name="difficulty">
            <Slider
              min={1}
              max={5}
              marks={{
                1: '初级',
                2: '中低',
                3: '中级',
                4: '中高',
                5: '高级'
              }}
            />
          </Form.Item>

          <Form.Item label="默认播放速度" name="playbackSpeed">
            <Select>
              <Option value={0.5}>0.5x</Option>
              <Option value={0.75}>0.75x</Option>
              <Option value={1}>1x</Option>
              <Option value={1.25}>1.25x</Option>
              <Option value={1.5}>1.5x</Option>
            </Select>
          </Form.Item>

          <Divider />

          <h3>通知设置</h3>
          <Form.Item label="推送通知" name="notifications" valuePropName="checked">
            <Switch />
          </Form.Item>

          <Form.Item label="音效" name="soundEffects" valuePropName="checked">
            <Switch />
          </Form.Item>

          <Form.Item label="自动保存进度" name="autoSave" valuePropName="checked">
            <Switch />
          </Form.Item>

          <Form.Item>
            <Button type="primary" htmlType="submit" size="large">
              保存设置
            </Button>
          </Form.Item>
        </Form>
      </Card>
    </div>
  );
};

export default Settings;