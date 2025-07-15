import React, { useState, useEffect, useCallback } from 'react';
import { message, Modal, Button, Space, Card } from 'antd';
import { ArrowLeftOutlined, ReloadOutlined, SettingOutlined } from '@ant-design/icons';
import LibrarySelector from './LibrarySelector';
import SentenceDisplay from './SentenceDisplay';
import AudioControls from './AudioControls';
import ProgressDisplay from './ProgressDisplay';
import type { 
  DictationConfig, 
  DictationSession, 
  DictationSentence, 
  DictationProgress,
  HintInfo 
} from '../../types/dictation';
import { dictationService } from '../../services/dictationService';
import './DictationPractice.css';

type PracticeState = 'setup' | 'practicing' | 'completed';

interface DictationPracticeProps {
  className?: string;
  onExit?: () => void;
}

const DictationPractice: React.FC<DictationPracticeProps> = ({
  className = '',
  onExit
}) => {
  const [state, setState] = useState<PracticeState>('setup');
  const [config, setConfig] = useState<DictationConfig | null>(null);
  const [sentences, setSentences] = useState<DictationSentence[]>([]);
  const [currentSentenceIndex, setCurrentSentenceIndex] = useState(0);
  const [session, setSession] = useState<DictationSession | null>(null);
  const [audioUrl, setAudioUrl] = useState<string>('');
  const [audioDuration, setAudioDuration] = useState<number>(0);
  const [progress, setProgress] = useState<DictationProgress>({
    totalWords: 0,
    completedWords: 0,
    correctWords: 0,
    hintsUsed: 0,
    audioPlays: 0,
    timeSpent: 0,
    accuracy: 0
  });
  const [hints, setHints] = useState<Map<number, HintInfo>>(new Map());
  const [isLoading, setIsLoading] = useState(false);

  // 处理配置变化
  const handleConfigChange = useCallback((newConfig: DictationConfig) => {
    setConfig(newConfig);
  }, []);

  // 开始练习
  const handleStartPractice = useCallback(async (practiceConfig: DictationConfig) => {
    try {
      setIsLoading(true);
      
      // 获取练习句子
      const practiceMessages = await dictationService.getPracticeSentences(practiceConfig);
      setSentences(practiceMessages);
      
      if (practiceMessages.length === 0) {
        message.error('没有找到合适的练习句子，请调整设置');
        return;
      }

      // 创建第一个会话
      const firstSentence = practiceMessages[0];
      const { session: newSession, audio } = await dictationService.createSession(
        firstSentence.id,
        practiceConfig
      );
      
      setSession(newSession);
      setAudioUrl(audio.url);
      setAudioDuration(audio.duration);
      setCurrentSentenceIndex(0);
      setState('practicing');
      
      // 初始化进度
      const initialProgress = dictationService.calculateProgress(newSession);
      setProgress(initialProgress);
      
      message.success('练习开始！请听音频并填写空白处');
      
    } catch (error) {
      console.error('开始练习失败:', error);
      message.error('开始练习失败，请重试');
    } finally {
      setIsLoading(false);
    }
  }, []);

  // 提交单词
  const handleWordSubmit = useCallback(async (position: number, userInput: string) => {
    if (!session) return;

    try {
      const result = await dictationService.submitWord(session.id, position, userInput);
      
      if (result.success) {
        // 更新会话状态
        const updatedSession = await dictationService.getSessionState(session.id);
        setSession(updatedSession);
        
        // 更新进度
        const newProgress = dictationService.calculateProgress(updatedSession);
        setProgress(newProgress);
        
        // 显示反馈
        if (result.is_correct) {
          message.success('正确！');
        } else {
          message.error(`不正确，请再试一次。${result.feedback || ''}`);
        }
        
        // 检查是否完成当前句子
        const isSessionCompleted = updatedSession.status === 'completed';
        if (isSessionCompleted) {
          await handleSentenceCompleted();
        }
      }
    } catch (error) {
      console.error('提交单词失败:', error);
      message.error('提交失败，请重试');
    }
  }, [session]);

  // 句子完成处理
  const handleSentenceCompleted = useCallback(async () => {
    const nextIndex = currentSentenceIndex + 1;
    
    if (nextIndex < sentences.length) {
      // 还有下一个句子
      Modal.confirm({
        title: '当前句子已完成！',
        content: '是否继续练习下一个句子？',
        okText: '继续',
        cancelText: '查看结果',
        onOk: async () => {
          try {
            const nextSentence = sentences[nextIndex];
            const { session: newSession, audio } = await dictationService.createSession(
              nextSentence.id,
              config!
            );
            
            setSession(newSession);
            setAudioUrl(audio.url);
            setAudioDuration(audio.duration);
            setCurrentSentenceIndex(nextIndex);
            setHints(new Map()); // 清空提示
            
            message.success(`开始第 ${nextIndex + 1} 个句子`);
          } catch (error) {
            console.error('创建下一个会话失败:', error);
            message.error('无法继续，请重试');
          }
        },
        onCancel: () => {
          setState('completed');
        }
      });
    } else {
      // 所有句子都完成了
      message.success('恭喜！您已完成所有练习！');
      setState('completed');
    }
  }, [currentSentenceIndex, sentences, config]);

  // 获取提示
  const handleHintRequest = useCallback(async (
    position: number, 
    hintType: 'letter' | 'phonetic' | 'definition' | 'full'
  ) => {
    if (!session) return;

    try {
      const hint = await dictationService.getHint(session.id, position, hintType);
      setHints(prev => new Map(prev.set(position, hint)));
      
      // 更新会话状态（提示计数）
      const updatedSession = await dictationService.getSessionState(session.id);
      setSession(updatedSession);
      
      const newProgress = dictationService.calculateProgress(updatedSession);
      setProgress(newProgress);
      
    } catch (error) {
      console.error('获取提示失败:', error);
      message.error('获取提示失败');
    }
  }, [session]);

  // 音频播放
  const handleAudioPlay = useCallback(async () => {
    if (!session) return;

    try {
      await dictationService.recordPlayback(session.id, audioDuration);
      
      // 更新播放次数
      const updatedSession = await dictationService.getSessionState(session.id);
      setSession(updatedSession);
      
      const newProgress = dictationService.calculateProgress(updatedSession);
      setProgress(newProgress);
      
    } catch (error) {
      console.error('记录播放失败:', error);
    }
  }, [session, audioDuration]);

  // 播放速度改变
  const handlePlaybackSpeedChange = useCallback(async (speed: number) => {
    if (!session) return;

    try {
      const audio = await dictationService.updatePlaybackSpeed(session.id, speed);
      setAudioUrl(audio.url);
      setAudioDuration(audio.duration);
    } catch (error) {
      console.error('更新播放速度失败:', error);
      message.error('更新播放速度失败');
    }
  }, [session]);

  // 重新开始当前句子
  const handleRestartSentence = useCallback(async () => {
    if (!session || !config) return;

    Modal.confirm({
      title: '确认重新开始',
      content: '这将清除当前句子的所有进度，确定要重新开始吗？',
      okText: '确定',
      cancelText: '取消',
      onOk: async () => {
        try {
          setIsLoading(true);
          const currentSentence = sentences[currentSentenceIndex];
          const { session: newSession, audio } = await dictationService.createSession(
            currentSentence.id,
            config
          );
          
          setSession(newSession);
          setAudioUrl(audio.url);
          setAudioDuration(audio.duration);
          setHints(new Map());
          
          const newProgress = dictationService.calculateProgress(newSession);
          setProgress(newProgress);
          
          message.success('已重新开始当前句子');
        } catch (error) {
          console.error('重新开始失败:', error);
          message.error('重新开始失败');
        } finally {
          setIsLoading(false);
        }
      }
    });
  }, [session, config, sentences, currentSentenceIndex]);

  // 返回设置
  const handleBackToSetup = useCallback(() => {
    Modal.confirm({
      title: '确认返回设置',
      content: '这将丢失当前的练习进度，确定要返回吗？',
      okText: '确定',
      cancelText: '取消',
      onOk: () => {
        setState('setup');
        setSession(null);
        setSentences([]);
        setCurrentSentenceIndex(0);
        setHints(new Map());
      }
    });
  }, []);

  // 渲染设置页面
  const renderSetup = () => (
    <LibrarySelector
      onConfigChange={handleConfigChange}
      onStartPractice={handleStartPractice}
      className="practice-setup"
    />
  );

  // 渲染练习页面
  const renderPracticing = () => (
    <div className="practice-content">
      {/* 头部操作栏 */}
      <Card className="practice-header" size="small">
        <div className="header-content">
          <Space>
            <Button
              type="text"
              icon={<ArrowLeftOutlined />}
              onClick={handleBackToSetup}
              size="small"
            >
              返回设置
            </Button>
            <span className="sentence-counter">
              第 {currentSentenceIndex + 1} / {sentences.length} 句
            </span>
          </Space>
          
          <Space>
            <Button
              type="text"
              icon={<ReloadOutlined />}
              onClick={handleRestartSentence}
              loading={isLoading}
              size="small"
            >
              重新开始
            </Button>
          </Space>
        </div>
      </Card>

      {/* 进度显示 */}
      <ProgressDisplay progress={progress} showDetails={false} />

      {/* 句子显示 */}
      {session && (
        <SentenceDisplay
          session={session}
          onWordSubmit={handleWordSubmit}
          onAudioPlay={handleAudioPlay}
          onHintRequest={handleHintRequest}
          showChinese={config?.show_chinese}
        />
      )}

      {/* 音频控制 */}
      {audioUrl && (
        <AudioControls
          audioUrl={audioUrl}
          duration={audioDuration}
          onPlaybackSpeedChange={handlePlaybackSpeedChange}
          onPlaybackComplete={handleAudioPlay}
          autoPlay={config?.auto_play}
          defaultSpeed={config?.playback_speed}
        />
      )}
    </div>
  );

  // 渲染完成页面
  const renderCompleted = () => (
    <div className="practice-completed">
      <Card className="completion-card">
        <div className="completion-content">
          <h2>🎉 练习完成！</h2>
          <p>恭喜您完成了所有听写练习</p>
        </div>
        
        <ProgressDisplay progress={progress} showDetails={true} />
        
        <div className="completion-actions">
          <Space>
            <Button type="primary" onClick={() => setState('setup')}>
              重新练习
            </Button>
            {onExit && (
              <Button onClick={onExit}>
                退出练习
              </Button>
            )}
          </Space>
        </div>
      </Card>
    </div>
  );

  return (
    <div className={`dictation-practice ${className}`}>
      {state === 'setup' && renderSetup()}
      {state === 'practicing' && renderPracticing()}
      {state === 'completed' && renderCompleted()}
    </div>
  );
};

export default DictationPractice;