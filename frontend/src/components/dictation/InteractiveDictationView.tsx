import React, { useState, useEffect, useCallback, useRef } from 'react';
import { Button, Space, Progress, message } from 'antd';
import { 
  PlayCircleOutlined, 
  PauseCircleOutlined,
  RedoOutlined,
  RightOutlined,
  LeftOutlined,
  CheckCircleOutlined,
  CloseCircleOutlined
} from '@ant-design/icons';
import type { DictationSession, WordAttempt } from '../../types/dictation';
import { soundFeedbackService } from '../../services/soundFeedbackService';
import './InteractiveDictationView.css';

interface InteractiveDictationViewProps {
  session: DictationSession;
  audioUrl: string;
  audioDuration: number;
  onWordSubmit: (position: number, value: string) => Promise<{ is_correct: boolean; feedback?: string }>;
  onAudioPlay: () => void;
  onHintRequest: (position: number, hintType: 'letter' | 'phonetic' | 'definition' | 'full') => void;
  onComplete: () => void;
  onNext: () => void;
  onPrevious?: () => void;
  autoPlay?: boolean; // 是否自动播放新句子
  playbackSpeed?: number; // 播放速度
  className?: string;
}

type ViewState = 'chinese' | 'listening' | 'practicing' | 'reviewing';

const InteractiveDictationView: React.FC<InteractiveDictationViewProps> = ({
  session,
  audioUrl,
  audioDuration,
  onWordSubmit,
  onAudioPlay,
  onHintRequest,
  onComplete,
  onNext,
  onPrevious,
  autoPlay = true,
  playbackSpeed = 1.0,
  className = ''
}) => {
  const [viewState, setViewState] = useState<ViewState>('chinese');
  const [currentWordIndex, setCurrentWordIndex] = useState(0);
  const [userInputs, setUserInputs] = useState<{ [key: number]: string }>({});
  const [wordStatuses, setWordStatuses] = useState<{ [key: number]: 'correct' | 'incorrect' | 'pending' }>({});
  const [isPlaying, setIsPlaying] = useState(false);
  const [showPhonetic, setShowPhonetic] = useState(false);
  const audioRef = useRef<HTMLAudioElement>(null);
  const inputRef = useRef<HTMLInputElement>(null);

  const { session_data, words } = session;
  const chineseTranslation = session_data?.chinese_translation || '我通常六点起床';
  const blankedWords = words?.filter(w => w.is_blanked) || [];
  const currentWord = blankedWords[currentWordIndex];

  // Initialize sound service
  useEffect(() => {
    soundFeedbackService.initialize();
  }, []);

  // 开始听写
  const startDictation = useCallback(() => {
    setViewState('listening');
    // 自动播放音频
    setTimeout(() => {
      handlePlayAudio();
    }, 500);
  }, []);

  // 播放音频
  const handlePlayAudio = useCallback(() => {
    if (audioRef.current) {
      if (isPlaying) {
        audioRef.current.pause();
        setIsPlaying(false);
      } else {
        audioRef.current.play();
        setIsPlaying(true);
        onAudioPlay();
      }
    }
  }, [isPlaying, onAudioPlay]);

  // 处理输入变化
  const handleInputChange = useCallback((value: string) => {
    soundFeedbackService.playKeyboardSound();
    setUserInputs(prev => ({
      ...prev,
      [currentWord.position]: value
    }));
  }, [currentWord]);

  // 提交单词
  const handleSubmitWord = useCallback(async () => {
    const userInput = userInputs[currentWord.position] || '';
    if (!userInput.trim()) {
      message.warning('请输入单词');
      return;
    }

    const result = await onWordSubmit(currentWord.position, userInput.trim());
    
    if (result.is_correct) {
      soundFeedbackService.playSuccessSound();
      setWordStatuses(prev => ({
        ...prev,
        [currentWord.position]: 'correct'
      }));
      
      // 移动到下一个单词
      if (currentWordIndex < blankedWords.length - 1) {
        setCurrentWordIndex(prev => prev + 1);
        // 清空下一个输入框
        setTimeout(() => {
          inputRef.current?.focus();
        }, 100);
      } else {
        // 完成所有单词
        setViewState('reviewing');
        soundFeedbackService.playCompletionSound();
        onComplete();
      }
    } else {
      soundFeedbackService.playErrorSound();
      setWordStatuses(prev => ({
        ...prev,
        [currentWord.position]: 'incorrect'
      }));
      message.error(result.feedback || '答案错误，请再试一次');
    }
  }, [currentWord, userInputs, currentWordIndex, blankedWords, onWordSubmit, onComplete]);

  // 监听键盘事件
  const handleKeyPress = useCallback((e: React.KeyboardEvent) => {
    if (e.key === 'Enter') {
      e.preventDefault();
      handleSubmitWord();
    } else if (e.ctrlKey && e.key === ' ') {
      e.preventDefault();
      handlePlayAudio();
    }
  }, [handleSubmitWord, handlePlayAudio]);

  // 开始练习
  const startPractice = useCallback(() => {
    setViewState('practicing');
    setTimeout(() => {
      inputRef.current?.focus();
    }, 100);
  }, []);

  // 渲染中文提示页面
  const renderChineseView = () => (
    <div className="chinese-view">
      <div className="chinese-sentence-large">
        {chineseTranslation}
      </div>
      <Button 
        type="primary" 
        size="large" 
        onClick={startDictation}
        icon={<PlayCircleOutlined />}
      >
        开始听写
      </Button>
    </div>
  );

  // 渲染听音频页面
  const renderListeningView = () => (
    <div className="listening-view">
      <div className="chinese-sentence-medium">
        {chineseTranslation}
      </div>
      <div className="audio-controls">
        <Button 
          type="primary" 
          shape="circle" 
          size="large"
          icon={isPlaying ? <PauseCircleOutlined /> : <PlayCircleOutlined />}
          onClick={handlePlayAudio}
        />
        <div className="audio-hint">请仔细听句子的发音</div>
      </div>
      <audio 
        ref={audioRef} 
        src={audioUrl}
        onEnded={() => setIsPlaying(false)}
      />
      <Button 
        type="primary" 
        onClick={startPractice}
        style={{ marginTop: 20 }}
      >
        开始输入
      </Button>
    </div>
  );

  // 渲染练习页面
  const renderPracticingView = () => (
    <div className="practicing-view">
      <div className="chinese-hint">
        {chineseTranslation}
      </div>
      
      <div className="sentence-display">
        {words?.map((word, index) => {
          if (!word.is_blanked) {
            return (
              <span key={index} className="word-fixed">
                {word.original}
              </span>
            );
          }

          const status = wordStatuses[word.position];
          const isCurrentWord = word.position === currentWord?.position;
          const userInput = userInputs[word.position] || '';

          return (
            <span 
              key={index} 
              className={`word-blank ${isCurrentWord ? 'current' : ''} ${status || ''}`}
            >
              {isCurrentWord ? (
                <input
                  ref={inputRef}
                  type="text"
                  value={userInput}
                  onChange={(e) => handleInputChange(e.target.value)}
                  onKeyPress={handleKeyPress}
                  className="word-input"
                  placeholder="_____"
                  autoComplete="off"
                  spellCheck={false}
                />
              ) : (
                <span className="word-display">
                  {userInput || '_____'}
                  {status === 'correct' && <CheckCircleOutlined className="status-icon" />}
                  {status === 'incorrect' && <CloseCircleOutlined className="status-icon" />}
                </span>
              )}
            </span>
          );
        })}
      </div>

      {showPhonetic && currentWord && (
        <div className="phonetic-hint">
          音标：{getPhonetic(currentWord.original)}
        </div>
      )}

      <div className="practice-controls">
        <Space>
          <Button onClick={handlePlayAudio} icon={<PlayCircleOutlined />}>
            重听 (Ctrl+空格)
          </Button>
          <Button onClick={() => setShowPhonetic(!showPhonetic)}>
            {showPhonetic ? '隐藏' : '显示'}音标
          </Button>
          <Button onClick={() => onHintRequest(currentWord.position, 'letter')}>
            提示
          </Button>
        </Space>
      </div>

      <Progress 
        percent={Math.round((currentWordIndex / blankedWords.length) * 100)} 
        strokeColor="#52c41a"
      />
    </div>
  );

  // 渲染复习页面
  const renderReviewingView = () => (
    <div className="reviewing-view">
      <h2>练习完成！</h2>
      <div className="complete-sentence">
        {words?.map((word, index) => (
          <span key={index} className="word-review">
            <span className="word-english">{word.original}</span>
            <span className="word-phonetic">{getPhonetic(word.original)}</span>
            <span className="word-chinese">{getChineseTranslation(word.original)}</span>
          </span>
        ))}
      </div>
      
      <div className="chinese-complete">
        {chineseTranslation}
      </div>

      <div className="review-actions">
        <Space>
          {onPrevious && (
            <Button icon={<LeftOutlined />} onClick={onPrevious}>
              上一题
            </Button>
          )}
          <Button icon={<RedoOutlined />} onClick={() => window.location.reload()}>
            再来一次
          </Button>
          <Button type="primary" icon={<RightOutlined />} onClick={onNext}>
            下一题
          </Button>
        </Space>
      </div>
    </div>
  );

  // 获取音标（临时实现）
  const getPhonetic = (word: string) => {
    const phonetics: { [key: string]: string } = {
      'I': '/aɪ/',
      'usually': '/ˈjuːʒuəli/',
      'get': '/get/',
      'up': '/ʌp/',
      'at': '/æt/',
      'six': '/sɪks/'
    };
    return phonetics[word] || '';
  };

  // 获取中文翻译（临时实现）
  const getChineseTranslation = (word: string) => {
    const translations: { [key: string]: string } = {
      'I': '我',
      'usually': '通常',
      'get': '起床',
      'up': '起床',
      'at': '在',
      'six': '六点'
    };
    return translations[word] || '';
  };

  return (
    <div className={`interactive-dictation-view ${className}`}>
      {viewState === 'chinese' && renderChineseView()}
      {viewState === 'listening' && renderListeningView()}
      {viewState === 'practicing' && renderPracticingView()}
      {viewState === 'reviewing' && renderReviewingView()}
    </div>
  );
};

export default InteractiveDictationView;