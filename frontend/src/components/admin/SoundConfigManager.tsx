import React, { useState, useEffect } from 'react';
import { 
  Card, 
  Form, 
  Switch, 
  Slider, 
  Button, 
  Space, 
  message, 
  Typography, 
  Divider,
  Input,
  Modal,
  Tooltip,
  Select
} from 'antd';
import { 
  SoundOutlined, 
  PlayCircleOutlined, 
  ReloadOutlined, 
  QuestionCircleOutlined,
  SaveOutlined,
  UndoOutlined
} from '@ant-design/icons';
import { soundConfigService, type SoundConfig, type SoundEffects } from '../../services/soundConfigService';
import { soundFeedbackService } from '../../services/soundFeedbackService';
import './SoundConfigManager.css';

const { Title, Text, Paragraph } = Typography;

interface SoundConfigManagerProps {
  className?: string;
}

const SoundConfigManager: React.FC<SoundConfigManagerProps> = ({ className = '' }) => {
  const [form] = Form.useForm();
  const [loading, setLoading] = useState(false);
  const [config, setConfig] = useState<SoundConfig | null>(null);
  const [soundEffects, setSoundEffects] = useState<SoundEffects | null>(null);
  const [hasChanges, setHasChanges] = useState(false);

  useEffect(() => {
    loadSoundConfig();
  }, []);

  const loadSoundConfig = async () => {
    try {
      setLoading(true);
      const [soundConfig, effects] = await Promise.all([
        soundConfigService.getSoundConfig(),
        soundConfigService.getSoundEffects()
      ]);
      setConfig(soundConfig);
      setSoundEffects(effects);
      form.setFieldsValue(soundConfig);
      setHasChanges(false);
    } catch (error) {
      message.error('Failed to load sound configuration');
      console.error('Error loading sound config:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleSave = async () => {
    try {
      setLoading(true);
      const values = await form.validateFields();
      const updatedConfig = await soundConfigService.updateSoundConfig(values);
      setConfig(updatedConfig);
      setHasChanges(false);
      
      // Reload sound service configuration
      await soundFeedbackService.reloadSoundConfig();
      
      message.success('Sound configuration saved successfully');
    } catch (error) {
      message.error('Failed to save sound configuration');
      console.error('Error saving sound config:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleReset = () => {
    Modal.confirm({
      title: 'Reset Sound Configuration',
      content: 'Are you sure you want to reset all sound settings to default values?',
      okText: 'Reset',
      okType: 'danger',
      cancelText: 'Cancel',
      onOk: async () => {
        try {
          setLoading(true);
          const defaultConfig = await soundConfigService.resetSoundConfig();
          setConfig(defaultConfig);
          form.setFieldsValue(defaultConfig);
          setHasChanges(false);
          
          // Reload sound service configuration
          await soundFeedbackService.reloadSoundConfig();
          
          message.success('Sound configuration reset to defaults');
        } catch (error) {
          message.error('Failed to reset sound configuration');
          console.error('Error resetting sound config:', error);
        } finally {
          setLoading(false);
        }
      }
    });
  };

  const handleTestSound = async (soundType: 'keyboard' | 'success' | 'error' | 'completion') => {
    try {
      await soundFeedbackService.initialize();
      
      switch (soundType) {
        case 'keyboard':
          await soundFeedbackService.playKeyboardSound();
          break;
        case 'success':
          await soundFeedbackService.playSuccessSound();
          break;
        case 'error':
          await soundFeedbackService.playErrorSound();
          break;
        case 'completion':
          await soundFeedbackService.playCompletionSound();
          break;
      }
    } catch (error) {
      message.error('Failed to play test sound');
      console.error('Error testing sound:', error);
    }
  };

  const handlePreviewSound = async (soundType: 'keyboard' | 'success' | 'error' | 'completion', soundId: string) => {
    try {
      if (!soundEffects) return;
      
      const soundEffect = soundEffects[soundType].find(s => s.id === soundId);
      if (!soundEffect) return;
      
      const soundPath = soundConfigService.getSoundEffectPath(soundType, soundEffect.file);
      const audio = new Audio(soundPath);
      
      // Set volume based on current form values
      const masterVolume = form.getFieldValue('master_volume') || 0.8;
      const typeVolume = form.getFieldValue(`${soundType}_sound_volume`) || 0.5;
      audio.volume = Math.max(0, Math.min(1, masterVolume * typeVolume));
      
      await audio.play();
    } catch (error) {
      message.error('Failed to preview sound');
      console.error('Error previewing sound:', error);
    }
  };

  const onFormChange = () => {
    setHasChanges(true);
  };

  const soundTypes = [
    {
      key: 'keyboard',
      title: 'Keyboard Feedback',
      description: 'Sound played when typing in input fields',
      enabledField: 'keyboard_sound_enabled',
      volumeField: 'keyboard_sound_volume',
      fileField: 'keyboard_sound_file'
    },
    {
      key: 'success',
      title: 'Success Sound',
      description: 'Sound played when answer is correct',
      enabledField: 'success_sound_enabled',
      volumeField: 'success_sound_volume',
      fileField: 'success_sound_file'
    },
    {
      key: 'error',
      title: 'Error Sound',
      description: 'Sound played when answer is incorrect',
      enabledField: 'error_sound_enabled',
      volumeField: 'error_sound_volume',
      fileField: 'error_sound_file'
    },
    {
      key: 'completion',
      title: 'Completion Sound',
      description: 'Sound played when session is completed',
      enabledField: 'completion_sound_enabled',
      volumeField: 'completion_sound_volume',
      fileField: 'completion_sound_file'
    }
  ] as const;

  return (
    <div className={`sound-config-manager ${className}`}>
      <Card
        title={
          <Space>
            <SoundOutlined />
            <Title level={4} style={{ margin: 0 }}>Sound Configuration</Title>
          </Space>
        }
        extra={
          <Space>
            <Button
              icon={<ReloadOutlined />}
              onClick={loadSoundConfig}
              disabled={loading}
            >
              Reload
            </Button>
            <Button
              icon={<UndoOutlined />}
              onClick={handleReset}
              disabled={loading}
            >
              Reset to Defaults
            </Button>
            <Button
              type="primary"
              icon={<SaveOutlined />}
              onClick={handleSave}
              loading={loading}
              disabled={!hasChanges}
            >
              Save Changes
            </Button>
          </Space>
        }
        loading={loading}
      >
        <Form
          form={form}
          layout="vertical"
          onValuesChange={onFormChange}
          initialValues={config}
        >
          {/* Global Settings */}
          <Card type="inner" title="Global Settings" className="mb-4">
            <Form.Item
              name="sounds_enabled"
              label={
                <Space>
                  <Text>Enable Sound Effects</Text>
                  <Tooltip title="Master switch for all sound effects">
                    <QuestionCircleOutlined />
                  </Tooltip>
                </Space>
              }
              valuePropName="checked"
            >
              <Switch />
            </Form.Item>
            
            <Form.Item
              name="master_volume"
              label={
                <Space>
                  <Text>Master Volume</Text>
                  <Tooltip title="Global volume level for all sounds">
                    <QuestionCircleOutlined />
                  </Tooltip>
                </Space>
              }
            >
              <Slider
                min={0}
                max={1}
                step={0.1}
                marks={{ 0: '0%', 0.5: '50%', 1: '100%' }}
                tooltip={{ formatter: (value) => `${Math.round((value || 0) * 100)}%` }}
              />
            </Form.Item>
          </Card>

          {/* Individual Sound Settings */}
          {soundTypes.map((soundType) => (
            <Card
              key={soundType.key}
              type="inner"
              title={soundType.title}
              className="mb-4"
              extra={
                <Button
                  icon={<PlayCircleOutlined />}
                  onClick={() => handleTestSound(soundType.key)}
                  size="small"
                >
                  Test Sound
                </Button>
              }
            >
              <Paragraph type="secondary" className="mb-3">
                {soundType.description}
              </Paragraph>

              <Form.Item
                name={soundType.enabledField}
                label="Enable Sound"
                valuePropName="checked"
              >
                <Switch />
              </Form.Item>

              <Form.Item
                name={soundType.volumeField}
                label="Volume Level"
              >
                <Slider
                  min={0}
                  max={1}
                  step={0.1}
                  marks={{ 0: '0%', 0.5: '50%', 1: '100%' }}
                  tooltip={{ formatter: (value) => `${Math.round((value || 0) * 100)}%` }}
                />
              </Form.Item>

              <Form.Item
                name={soundType.fileField}
                label="Sound Effect"
              >
                <Select
                  placeholder="Select sound effect"
                  onChange={(value) => handlePreviewSound(soundType.key, value)}
                  optionLabelProp="label"
                >
                  {soundEffects?.[soundType.key]?.map((effect) => (
                    <Select.Option 
                      key={effect.id} 
                      value={effect.id}
                      label={effect.name}
                    >
                      <div>
                        <div style={{ fontWeight: 'bold' }}>{effect.name}</div>
                        <div style={{ fontSize: '12px', color: '#666' }}>{effect.description}</div>
                      </div>
                    </Select.Option>
                  ))}
                </Select>
              </Form.Item>
            </Card>
          ))}

          {/* Additional Settings */}
          <Card type="inner" title="Additional Settings">
            <Form.Item
              name="notes"
              label="Admin Notes"
            >
              <Input.TextArea
                rows={3}
                placeholder="Optional notes about sound configuration..."
              />
            </Form.Item>
          </Card>
        </Form>
      </Card>
    </div>
  );
};

export default SoundConfigManager;