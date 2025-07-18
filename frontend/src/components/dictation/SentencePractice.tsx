import React, { useState, useCallback, useEffect, useRef } from 'react';
import { message, Modal, Button, Space, Card } from 'antd';
import SentencePracticeSelector from './SentencePracticeSelector';
import SimpleDictationView from './SimpleDictationView';
import InteractiveDictationView from './InteractiveDictationView';
import ChineseTranslationView from './ChineseTranslationView';
import ProgressDisplay from './ProgressDisplay';
import type { 
  DictationConfig, 
  DictationSession, 
  DictationSentence, 
  DictationProgress
} from '../../types/dictation';
import { enhancedDictationService } from '../../services/enhancedDictationService';
import './DictationPractice.css';

type PracticeState = 'setup' | 'practicing' | 'completed';

interface SentencePracticeProps {
  className?: string;
  onExit?: () => void;
}

const SentencePractice: React.FC<SentencePracticeProps> = ({
  className = '',
  onExit
}) => {
  const [state, setState] = useState<PracticeState>('setup');
  const [config, setConfig] = useState<DictationConfig | null>(null);
  const [sentences, setSentences] = useState<DictationSentence[]>([]);
  const [currentSentenceIndex, setCurrentSentenceIndex] = useState(0);
  const [session, setSession] = useState<DictationSession | null>(null);
  const [, setAudioUrl] = useState<string>('');
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
  const [isLoading, setIsLoading] = useState(false);
  const [useInteractiveView] = useState(true);
  const [useChineseTranslationView] = useState(true);
  
  // 时间跟踪
  const [startTime, setStartTime] = useState<number>(0);
  const [timeSpent, setTimeSpent] = useState<number>(0);
  const timeIntervalRef = useRef<NodeJS.Timeout | null>(null);
  
  // 函数引用，用于键盘事件
  const handlePreviousSentenceRef = useRef<(() => void) | null>(null);
  const handleNextSentenceRef = useRef<(() => void) | null>(null);

  // 时间跟踪副作用
  useEffect(() => {
    if (state === 'practicing' && startTime > 0) {
      timeIntervalRef.current = setInterval(() => {
        setTimeSpent(Math.floor((Date.now() - startTime) / 1000));
      }, 1000);
    } else {
      if (timeIntervalRef.current) {
        clearInterval(timeIntervalRef.current);
        timeIntervalRef.current = null;
      }
    }

    return () => {
      if (timeIntervalRef.current) {
        clearInterval(timeIntervalRef.current);
      }
    };
  }, [state, startTime]);

  // 键盘快捷键支持
  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      if (state !== 'practicing') return;
      
      if (event.ctrlKey && event.key === 'ArrowLeft') {
        event.preventDefault();
        handlePreviousSentenceRef.current?.();
      } else if (event.ctrlKey && event.key === 'ArrowRight') {
        event.preventDefault();
        handleNextSentenceRef.current?.();
      }
    };

    document.addEventListener('keydown', handleKeyDown);
    return () => {
      document.removeEventListener('keydown', handleKeyDown);
    };
  }, [state]);

  // 处理配置变化
  const handleConfigChange = useCallback((newConfig: DictationConfig) => {
    // 确保始终为句子练习
    const sentenceConfig = { ...newConfig, practice_type: 'sentence' as const };
    setConfig(sentenceConfig);
  }, []);

  // 开始练习
  const handleStartPractice = useCallback(async (practiceConfig: DictationConfig) => {
    try {
      setIsLoading(true);
      
      // 确保是句子练习类型
      const sentenceConfig = { ...practiceConfig, practice_type: 'sentence' as const };
      
      // 获取练习句子
      const practiceMessages = await enhancedDictationService.getPracticeSentences(sentenceConfig);
      setSentences(practiceMessages);
      
      if (practiceMessages.length === 0) {
        message.error('没有找到合适的练习句子，请调整设置');
        return;
      }

      // 创建第一个会话
      const firstSentence = practiceMessages[0];
      const { session: newSession, audio } = await enhancedDictationService.createSession(
        firstSentence.id,
        sentenceConfig
      );
      
      setSession(newSession);
      setAudioUrl(audio.url);
      setAudioDuration(audio.duration);
      setCurrentSentenceIndex(0);
      setState('practicing');
      
      // 初始化时间跟踪
      const now = Date.now();
      setStartTime(now);
      setTimeSpent(0);
      
      // 初始化进度
      const initialProgress = enhancedDictationService.calculateProgress(newSession);
      setProgress(initialProgress);
      
      message.success('句子练习开始！请听音频并填写空白处');
      
    } catch (error) {
      console.error('开始练习失败:', error);
      message.error('开始练习失败，请重试');
    } finally {
      setIsLoading(false);
    }
  }, []);

  // 提交单词 - 使用增强的服务（包含错误追踪）
  const handleWordSubmit = useCallback(async (position: number, userInput: string) => {
    if (!session) return { is_correct: false, feedback: '会话无效' };

    try {
      const result = await enhancedDictationService.submitWord(session.session_id || session.id, position, userInput);
      
      if (result.success) {
        // 更新会话状态
        const updatedSession = await enhancedDictationService.getSessionState(session.session_id || session.id || 0);
        setSession(updatedSession);
        
        // 更新进度
        const newProgress = enhancedDictationService.calculateProgress(updatedSession);
        setProgress(newProgress);
        
        // 检查是否完成当前句子
        const isSessionCompleted = updatedSession.is_completed;
        if (isSessionCompleted) {
          await handleSentenceCompleted();
        }
        
        return {
          is_correct: result.is_correct,
          feedback: result.feedback
        };
      }
      
      return {
        is_correct: false,
        feedback: '提交失败'
      };
    } catch (error) {
      console.error('提交单词失败:', error);
      return {
        is_correct: false,
        feedback: '提交失败，请重试'
      };
    }
  }, [session]);

  // 句子完成处理
  const handleSentenceCompleted = useCallback(async () => {
    const nextIndex = currentSentenceIndex + 1;
    
    if (nextIndex < sentences.length) {
      // 还有下一个句子
      Modal.confirm({
        title: '当前句子练习已完成！',
        content: '是否继续练习下一个句子？',
        okText: '继续',
        cancelText: '查看结果',
        onOk: async () => {
          try {
            const nextSentence = sentences[nextIndex];
            const { session: newSession, audio } = await enhancedDictationService.createSession(
              nextSentence.id,
              config!
            );
            
            setSession(newSession);
            setAudioUrl(audio.url);
            setAudioDuration(audio.duration);
            setCurrentSentenceIndex(nextIndex);
            
            // 更新进度
            const newProgress = enhancedDictationService.calculateProgress(newSession);
            setProgress(newProgress);
            
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
      message.success('恭喜！您已完成所有句子练习！');
      setState('completed');
    }
  }, [currentSentenceIndex, sentences, config]);

  // 处理下一题
  const handleNextSentence = useCallback(async () => {
    const nextIndex = currentSentenceIndex + 1;
    
    if (nextIndex < sentences.length) {
      try {
        setIsLoading(true);
        const nextSentence = sentences[nextIndex];
        const { session: newSession, audio } = await enhancedDictationService.createSession(
          nextSentence.id,
          config!
        );
        
        setSession(newSession);
        setAudioUrl(audio.url);
        setAudioDuration(audio.duration);
        setCurrentSentenceIndex(nextIndex);
        
        // 更新进度
        const newProgress = enhancedDictationService.calculateProgress(newSession);
        setProgress(newProgress);
        
        message.success(`开始第 ${nextIndex + 1} 个句子`);
      } catch (error) {
        console.error('创建下一个会话失败:', error);
        message.error('无法继续下一题，请重试');
      } finally {
        setIsLoading(false);
      }
    } else {
      message.success('恭喜！您已完成所有句子练习！');
      setState('completed');
    }
  }, [currentSentenceIndex, sentences, config]);

  // 更新 ref
  useEffect(() => {
    handleNextSentenceRef.current = handleNextSentence;
  }, [handleNextSentence]);

  // 处理上一个句子
  const handlePreviousSentence = useCallback(async () => {
    const prevIndex = currentSentenceIndex - 1;
    
    if (prevIndex >= 0) {
      try {
        setIsLoading(true);
        const prevSentence = sentences[prevIndex];
        const { session: newSession, audio } = await enhancedDictationService.createSession(
          prevSentence.id,
          config!
        );
        
        setSession(newSession);
        setAudioUrl(audio.url);
        setAudioDuration(audio.duration);
        setCurrentSentenceIndex(prevIndex);
        
        // 更新进度
        const newProgress = enhancedDictationService.calculateProgress(newSession);
        setProgress(newProgress);
        
        message.success(`切换到第 ${prevIndex + 1} 个句子`);
      } catch (error) {
        console.error('切换到上一个句子失败:', error);
        message.error('切换失败，请重试');
      } finally {
        setIsLoading(false);
      }
    } else {
      message.info('已经是第一个句子了');
    }
  }, [currentSentenceIndex, sentences, config]);

  // 更新 ref
  useEffect(() => {
    handlePreviousSentenceRef.current = handlePreviousSentence;
  }, [handlePreviousSentence]);

  // 获取提示
  const handleHintRequest = useCallback(async (
    position: number, 
    hintType: 'letter' | 'phonetic' | 'definition' | 'full'
  ) => {
    if (!session) return;

    try {
      await enhancedDictationService.getHint(session.session_id || session.id || 0, position, hintType);
      
      // 更新会话状态（提示计数）
      const updatedSession = await enhancedDictationService.getSessionState(session.session_id || session.id || 0);
      setSession(updatedSession);
      
      const newProgress = enhancedDictationService.calculateProgress(updatedSession);
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
      await enhancedDictationService.recordPlayback(session.session_id || session.id || 0, audioDuration);
      
      // 更新播放次数
      const updatedSession = await enhancedDictationService.getSessionState(session.session_id || session.id || 0);
      setSession(updatedSession);
      
      const newProgress = enhancedDictationService.calculateProgress(updatedSession);
      setProgress(newProgress);
      
    } catch (error) {
      console.error('记录播放失败:', error);
    }
  }, [session, audioDuration]);

  // 渲染设置页面
  const renderSetup = () => (
    <SentencePracticeSelector
      onConfigChange={handleConfigChange}
      onStartPractice={handleStartPractice}
      className="practice-setup"
    />
  );

  // 渲染练习页面
  const renderPracticing = () => {
    if (!session) return null;
    
    const practiceContent = () => {
      if (useChineseTranslationView) {
        return (
          <ChineseTranslationView
            session={session}
            audioUrl={`/api/dictation/audio/${session.sentence_id}?speed=${session.playback_speed}`}
            audioDuration={audioDuration}
            onWordSubmit={handleWordSubmit}
            onAudioPlay={handleAudioPlay}
            onHintRequest={handleHintRequest}
            onComplete={() => {
              message.success('本句练习完成！');
              handleSentenceCompleted();
            }}
            onNext={handleNextSentence}
            onPrevious={handlePreviousSentence}
            currentSentenceIndex={currentSentenceIndex}
            totalSentences={sentences.length}
            sentenceProgress={progress}
            timeSpent={timeSpent}
            autoPlay={config?.auto_play_new_sentence ?? true}
            playbackSpeed={session.playback_speed}
            className="dictation-view"
          />
        );
      }
    
      if (useInteractiveView) {
        return (
          <InteractiveDictationView
            session={session}
            audioUrl={`/api/dictation/audio/${session.sentence_id}?speed=${session.playback_speed}`}
            audioDuration={audioDuration}
            onWordSubmit={handleWordSubmit}
            onAudioPlay={handleAudioPlay}
            onHintRequest={handleHintRequest}
            onComplete={() => {
              message.success('本句练习完成！');
              handleSentenceCompleted();
            }}
            onNext={handleNextSentence}
            autoPlay={config?.auto_play_new_sentence ?? true}
            playbackSpeed={session.playback_speed}
            className="dictation-view"
          />
        );
      }
      
      return (
        <SimpleDictationView
          session={session}
          onWordSubmit={handleWordSubmit}
          onAudioPlay={handleAudioPlay}
          onHintRequest={handleHintRequest}
          progress={progress.totalWords > 0 ? (progress.completedWords / progress.totalWords) * 100 : 0}
          className="dictation-view"
        />
      );
    };

    return (
      <div className="practicing-container">
        {practiceContent()}
      </div>
    );
  };

  // 渲染完成页面
  const renderCompleted = () => (
    <div className="practice-completed">
      <Card className="completion-card">
        <div className="completion-content">
          <h2>🎉 句子练习完成！</h2>
          <p>恭喜您完成了所有句子练习</p>
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
    <div className={`dictation-practice sentence-practice ${className}`}>
      {state === 'setup' && renderSetup()}
      {state === 'practicing' && renderPracticing()}
      {state === 'completed' && renderCompleted()}
    </div>
  );
};

export default SentencePractice;