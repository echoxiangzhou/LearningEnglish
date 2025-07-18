import React, { useState, useEffect, useRef } from 'react';
import { Card, Button, Input, Space, Progress, message, Tooltip, Tag, Statistic, Row, Col } from 'antd';
import { 
  SoundOutlined, 
  RedoOutlined, 
  QuestionCircleOutlined,
  PauseOutlined,
  LoadingOutlined,
  LeftOutlined,
  RightOutlined,
  TrophyOutlined, 
  ClockCircleOutlined, 
  CheckCircleOutlined
} from '@ant-design/icons';
import type { DictationSession, DictationProgress } from '../../types/dictation';
import { ttsService } from '../../services/ttsService';
import { soundFeedbackService } from '../../services/soundFeedbackService';
import './ChineseTranslationView.css';

interface ChineseTranslationViewProps {
  session: DictationSession;
  audioUrl: string;
  audioDuration: number;
  onWordSubmit: (position: number, userInput: string) => Promise<{ is_correct: boolean; feedback: string }>;
  onAudioPlay: () => void;
  onHintRequest: (position: number, hintType: 'letter' | 'phonetic' | 'definition' | 'full') => void;
  onComplete: () => void;
  onNext: () => void;
  onPrevious: () => void;
  // 进度相关props
  currentSentenceIndex: number;
  totalSentences: number;
  sentenceProgress: DictationProgress;
  timeSpent: number;
  autoPlay?: boolean; // 是否自动播放新句子
  playbackSpeed?: number; // 播放速度
  className?: string;
}

const ChineseTranslationView: React.FC<ChineseTranslationViewProps> = ({
  session,
  audioUrl,
  onWordSubmit,
  onAudioPlay,
  onHintRequest,
  onComplete,
  onNext,
  onPrevious,
  currentSentenceIndex,
  totalSentences,
  sentenceProgress,
  timeSpent,
  autoPlay = true,
  playbackSpeed = 1.0,
  className = ''
}) => {
  const [wordInputs, setWordInputs] = useState<string[]>([]);
  const [currentWordIndex, setCurrentWordIndex] = useState(0);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [wordStates, setWordStates] = useState<('correct' | 'incorrect' | 'pending')[]>([]);
  const [feedback, setFeedback] = useState('');
  const [showHint, setShowHint] = useState(false);
  const [showResults, setShowResults] = useState(false);
  const [isAllCorrect, setIsAllCorrect] = useState(false);
  const [audioState, setAudioState] = useState({
    isPlaying: false,
    isLoading: false,
    currentTime: 0,
    duration: 0,
    error: null as string | null
  });
  
  // 组件挂载时确保音频状态正确
  useEffect(() => {
    // 确保没有残留的播放状态
    setAudioState({
      isPlaying: false,
      isLoading: false,
      currentTime: 0,
      duration: 0,
      error: null
    });
    ttsService.stopCurrentAudio();
    
    // 初始化音效服务
    soundFeedbackService.initialize();
  }, []);
  const inputRefs = useRef<any[]>([]);
  const audioRef = useRef<HTMLAudioElement>(null);
  const lastSentenceRef = useRef<string>(''); // 跟踪上一次播放的句子

  // 直接使用后端返回的中文翻译
  const chineseText = session.session_data.chinese_translation || '翻译不可用';
  // 注意：这里不应该使用默认值，应该完全依赖后端数据
  const englishText = session.session_data.sentence_text || '';
  
  // Use the backend's word parsing instead of frontend parsing to avoid mismatches
  const wordData = session.words || [];
  
  // Use tokens with punctuation if available, otherwise fall back to original words
  const tokensWithPunctuation = session.tokens_with_punctuation || [];
  const useTokensForDisplay = tokensWithPunctuation.length > 0;
  
  // Create words array from backend data (this is the authoritative source)
  const allWords = wordData.map(w => w.original || w.word || '');
  
  // Create a map for quick lookup of blanked positions
  // Check both is_blanked and is_blank due to interface inconsistency
  const blankedPositions = new Set(wordData.filter(w => w.is_blanked || w.is_blank).map(w => w.position));
  
  // Create input data only for blanked words
  const blankedWords = wordData.filter(w => w.is_blanked || w.is_blank).map(w => w.original || w.word || '');
  
  // Create a mapping from word position to blank index for proper input box assignment
  const positionToBlankedIndex = new Map();
  let blankedIndex = 0;
  allWords.forEach((_, wordIndex) => {
    if (blankedPositions.has(wordIndex)) {
      positionToBlankedIndex.set(wordIndex, blankedIndex);
      blankedIndex++;
    }
  });
  const progressPercentage = (session.completed_words / session.total_words) * 100;
  
  // 进度相关计算
  const overallProgress = totalSentences > 0 ? ((currentSentenceIndex) / totalSentences) * 100 : 0;
  const currentSentenceProgressPercent = sentenceProgress.totalWords > 0 
    ? (sentenceProgress.completedWords / sentenceProgress.totalWords) * 100 
    : 0;
  
  // 格式化时间显示
  const formatTime = (seconds: number): string => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  // 计算准确率
  const accuracy = sentenceProgress.totalWords > 0 
    ? Math.round((sentenceProgress.correctWords / sentenceProgress.totalWords) * 100)
    : 0;

  // 监听会话变化，重置组件状态
  useEffect(() => {
    // 当会话ID变化时，重置所有状态
    const sessionId = session.session_id || session.id;
    
    // 重置所有状态
    setShowResults(false);
    setIsAllCorrect(false);
    setFeedback('');
    setShowHint(false);
    setCurrentWordIndex(0);
    
    // 重置音频状态
    setAudioState({
      isPlaying: false,
      isLoading: false,
      currentTime: 0,
      duration: 0,
      error: null
    });
    
    // 停止当前正在播放的音频
    ttsService.stopCurrentAudio();
    
    // 重置上一次播放的句子引用，确保新句子会自动播放
    lastSentenceRef.current = '';
    
    // 初始化单词输入数组和状态 - 只为需要填空的单词创建输入框
    const initialInputs = new Array(blankedWords.length).fill('');
    const initialStates = new Array(blankedWords.length).fill('pending');
    setWordInputs(initialInputs);
    setWordStates(initialStates);
    
    // 聚焦到第一个输入框
    setTimeout(() => {
      if (inputRefs.current[0] && blankedWords.length > 0) {
        inputRefs.current[0].focus();
      }
    }, 100);
    
    console.log('Session changed, reset states:', {
      sessionId,
      blankedWordsLength: blankedWords.length,
      showResults: false,
      englishText: englishText
    });
  }, [session.session_id || session.id, blankedWords.length]);

  // 自动播放新句子
  useEffect(() => {
    if (autoPlay && englishText && englishText !== lastSentenceRef.current) {
      console.log('Auto-play triggered for new sentence:', englishText);
      // 延迟播放，确保组件完全加载
      const autoPlayTimer = setTimeout(() => {
        if (englishText && englishText !== lastSentenceRef.current) {
          console.log('Executing auto-play for:', englishText);
          lastSentenceRef.current = englishText;
          handleAutoPlay();
        }
      }, 500); // 增加延迟时间，确保组件完全加载

      return () => clearTimeout(autoPlayTimer);
    }
  }, [englishText, autoPlay, session.session_id || session.id]);

  // 清理音频资源
  useEffect(() => {
    return () => {
      ttsService.stopCurrentAudio();
      soundFeedbackService.cleanup();
    };
  }, []);

  // 全局键盘快捷键支持
  useEffect(() => {
    const handleGlobalKeyDown = (e: KeyboardEvent) => {
      // 如果正在输入框中，某些快捷键不应该触发
      const isInputFocused = document.activeElement?.tagName === 'INPUT';
      
      if (e.ctrlKey && e.key === 'ArrowLeft') {
        e.preventDefault();
        onPrevious();
      } else if (e.ctrlKey && e.key === 'ArrowRight') {
        e.preventDefault();
        handleNextClick();
      } else if (e.ctrlKey && e.key === ' ') {
        e.preventDefault();
        handlePlayAudio();
      } else if (e.ctrlKey && e.key === 'h' && isInputFocused) {
        e.preventDefault();
        // 获取当前聚焦的输入框索引
        const focusedInput = document.activeElement;
        const inputIndex = inputRefs.current.findIndex(ref => ref === focusedInput);
        if (inputIndex !== -1) {
          handleHint(inputIndex);
        }
      }
    };

    document.addEventListener('keydown', handleGlobalKeyDown);
    return () => {
      document.removeEventListener('keydown', handleGlobalKeyDown);
    };
  }, [onPrevious]);

  // 处理下一个按钮点击
  const handleNextClick = async () => {
    // 停止当前音频播放
    ttsService.stopCurrentAudio();
    setAudioState(prev => ({ ...prev, isPlaying: false }));
    
    // 调用原来的 onNext 回调
    onNext();
  };

  // 添加一个安全机制，定期检查音频状态
  useEffect(() => {
    const checkAudioState = () => {
      if (audioState.isPlaying && !ttsService.isPlaying()) {
        console.log('Audio state out of sync - resetting');
        setAudioState(prev => ({
          ...prev,
          isPlaying: false,
          currentTime: 0,
          isLoading: false
        }));
      }
    };

    const interval = setInterval(checkAudioState, 1000); // 每秒检查一次

    return () => clearInterval(interval);
  }, [audioState.isPlaying]);

  // 自动播放处理函数
  const handleAutoPlay = async () => {
    if (!englishText || audioState.isPlaying) {
      return;
    }

    try {
      setAudioState(prev => ({ 
        ...prev, 
        isLoading: true, 
        error: null 
      }));

      await ttsService.speakText(englishText, {
        speed: playbackSpeed,
        voice: 'af_bella',
        provider: 'kokoro',
        onStart: () => {
          // 播放开始时设置状态
          setAudioState(prev => ({
            ...prev,
            isPlaying: true,
            isLoading: false
          }));
        },
        onProgress: (currentTime: number, duration: number) => {
          setAudioState(prev => ({
            ...prev,
            currentTime,
            duration: duration || 0
          }));
        },
        onEnd: () => {
          console.log('Audio playback ended - setting isPlaying to false');
          setAudioState(prev => ({
            ...prev,
            isPlaying: false,
            currentTime: 0,
            isLoading: false
          }));
        },
        onError: (error: Error) => {
          setAudioState(prev => ({
            ...prev,
            isPlaying: false,
            isLoading: false,
            error: error.message
          }));
          console.warn('自动播放失败:', error.message);
        }
      });

      // 调用原来的音频播放回调
      onAudioPlay();

    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : '未知错误';
      setAudioState(prev => ({
        ...prev,
        isPlaying: false,
        isLoading: false,
        error: errorMessage
      }));
      console.warn('自动播放失败:', errorMessage);
    }
  };

  // 手动播放音频
  const handlePlayAudio = async () => {
    if (!englishText) {
      message.error('没有可播放的句子内容');
      return;
    }

    if (audioState.isPlaying) {
      // 如果正在播放，则停止
      ttsService.stopCurrentAudio();
      setAudioState(prev => ({ ...prev, isPlaying: false }));
      return;
    }

    try {
      setAudioState(prev => ({ 
        ...prev, 
        isLoading: true, 
        error: null 
      }));

      await ttsService.speakText(englishText, {
        speed: playbackSpeed,
        voice: 'af_bella',
        provider: 'kokoro',
        onStart: () => {
          // 播放开始时设置状态
          setAudioState(prev => ({
            ...prev,
            isPlaying: true,
            isLoading: false
          }));
        },
        onProgress: (currentTime: number, duration: number) => {
          setAudioState(prev => ({
            ...prev,
            currentTime,
            duration: duration || 0
          }));
        },
        onEnd: () => {
          console.log('Manual audio playback ended - setting isPlaying to false');
          setAudioState(prev => ({
            ...prev,
            isPlaying: false,
            currentTime: 0,
            isLoading: false
          }));
        },
        onError: (error: Error) => {
          setAudioState(prev => ({
            ...prev,
            isPlaying: false,
            isLoading: false,
            error: error.message
          }));
          message.error(`播放失败: ${error.message}`);
        }
      });

      // 同时调用原来的音频播放回调
      onAudioPlay();

    } catch (error) {
      const errorMessage = error instanceof Error ? error.message : '未知错误';
      setAudioState(prev => ({
        ...prev,
        isPlaying: false,
        isLoading: false,
        error: errorMessage
      }));
      message.error(`播放失败: ${errorMessage}`);
    }
  };

  const handleWordInputChange = (index: number, value: string) => {
    // 移除空格，因为空格用于跳转
    const cleanValue = value.replace(/\s/g, '');
    const newInputs = [...wordInputs];
    
    // 如果是新增字符（不是删除），播放键盘声音
    if (cleanValue.length > newInputs[index].length) {
      soundFeedbackService.playKeyboardSound();
    }
    
    newInputs[index] = cleanValue;
    setWordInputs(newInputs);
    
    // 如果用户开始修改一个错误的单词，重置其状态为pending
    if (wordStates[index] === 'incorrect') {
      const newStates = [...wordStates];
      newStates[index] = 'pending';
      setWordStates(newStates);
    }
  };

  const moveToNextWord = (currentIndex: number) => {
    const nextIndex = currentIndex + 1;
    if (nextIndex < blankedWords.length) {
      setCurrentWordIndex(nextIndex);
      setTimeout(() => {
        if (inputRefs.current[nextIndex]) {
          inputRefs.current[nextIndex].focus();
        }
      }, 100);
    }
  };

  const handleSubmitAllWords = async () => {
    // 防止重复提交
    if (isSubmitting) {
      console.log('Already submitting, ignoring duplicate submission');
      return;
    }

    // 检查是否所有单词都已输入
    const hasEmptyWords = wordInputs.some(input => !input.trim());
    if (hasEmptyWords) {
      message.warning('请完成所有单词的输入');
      return;
    }

    console.log('Starting submission...');
    setIsSubmitting(true);
    
    try {
      // 验证每个单词
      const newStates = [...wordStates];
      let allCorrect = true;
      
      for (let i = 0; i < blankedWords.length; i++) {
        const userInput = wordInputs[i].trim().toLowerCase();
        const correctWord = blankedWords[i].toLowerCase();
        
        if (userInput === correctWord) {
          newStates[i] = 'correct';
        } else {
          newStates[i] = 'incorrect';
          allCorrect = false;
        }
      }
      
      setWordStates(newStates);
      setIsAllCorrect(allCorrect);
      
      if (allCorrect) {
        message.success('答案全部正确！');
        setShowResults(true);
        // 播放成功音效
        soundFeedbackService.playSuccessSound();
        // 只调用完成回调，让父组件控制流程
        setTimeout(() => {
          onComplete();
        }, 2000);
      } else {
        // 保持在输入界面，不切换到结果界面
        message.error('部分答案不正确，请查看红色标记的单词');
        setShowResults(false);
        // 聚焦到第一个错误的输入框
        const firstErrorIndex = newStates.findIndex(state => state === 'incorrect');
        if (firstErrorIndex !== -1 && inputRefs.current[firstErrorIndex]) {
          setTimeout(() => {
            inputRefs.current[firstErrorIndex].focus();
          }, 100);
        }
      }
    } catch (error) {
      console.error('Submission error:', error);
      message.error('提交失败，请重试');
    } finally {
      console.log('Setting isSubmitting to false');
      setIsSubmitting(false);
    }
  };

  const handleKeyPress = (index: number) => (e: React.KeyboardEvent) => {
    if (e.key === ' ' && !e.ctrlKey) {
      e.preventDefault();
      // 空格键跳转到下一个单词
      moveToNextWord(index);
    } else if (e.key === 'Enter') {
      e.preventDefault();
      // Enter键提交所有单词
      handleSubmitAllWords();
    } else if (e.ctrlKey && e.key === ' ') {
      e.preventDefault();
      handlePlayAudio();
    } else if (e.ctrlKey && e.key === 'h') {
      e.preventDefault();
      handleHint(index);
    } else if (e.ctrlKey && e.key === 'n') {
      e.preventDefault();
      handleNextClick();
    }
  };

  const handleHint = (index: number) => {
    setShowHint(!showHint);
    if (!showHint) {
      onHintRequest(index, 'letter');
    }
  };

  const getWordTranslation = (word: string, index: number): string => {
    // 简单的单词翻译映射，实际应该从API获取
    const translations: { [key: string]: string } = {
      'I': '我',
      'usually': '通常',
      'get': 'get up (短语动词): 起床',
      'up': '(与 get 搭配)',
      'at': '在',
      'six': '六',
      'The': '这个',
      'cat': '猫',
      'is': '是',
      'sleeping': '睡觉',
      'on': '在',
      'the': '这个',
      'bed': '床'
    };
    return translations[word] || word;
  };

  const handleReset = () => {
    const initialInputs = new Array(blankedWords.length).fill('');
    const initialStates = new Array(blankedWords.length).fill('pending');
    setWordInputs(initialInputs);
    setWordStates(initialStates);
    setCurrentWordIndex(0);
    setFeedback('');
    setShowHint(false);
    setShowResults(false);
    setIsAllCorrect(false);
    if (inputRefs.current[0] && blankedWords.length > 0) {
      inputRefs.current[0].focus();
    }
  };

  return (
    <div className={`chinese-translation-view ${className}`}>
      <audio ref={audioRef} src={audioUrl} preload="metadata" />
      
      {/* 整合的进度卡片 */}
      <Card className="progress-card" bodyStyle={{ padding: '16px 24px' }}>
        {/* 主要进度信息 */}
        <div className="main-progress-section">
          <div className="progress-title">
            <Space>
              <TrophyOutlined className="progress-icon" />
              <span className="title-text">听写练习进度</span>
              <Tag color="blue" className="current-sentence-tag">
                第 {currentSentenceIndex + 1} / {totalSentences} 句
              </Tag>
            </Space>
          </div>
          
          {/* 整体进度条 */}
          <div className="overall-progress">
            <div className="progress-label">
              <span>整体进度</span>
              <span className="progress-percentage">
                {Math.round(overallProgress)}%
              </span>
            </div>
            <Progress 
              percent={overallProgress} 
              showInfo={false}
              strokeColor={{
                '0%': '#108ee9',
                '100%': '#87d068',
              }}
              className="overall-progress-bar"
            />
          </div>
        </div>

      </Card>
      
      <Card className="translation-card">
        <div className="translation-content">
          <div className="chinese-section">
            <h2 className="chinese-text">{chineseText}</h2>
          </div>

          <div className="english-section">
            {showResults ? (
              // 显示答案界面 - 显示所有单词及其状态
              <div className="word-results">
                {useTokensForDisplay ? (
                  tokensWithPunctuation.map((token, tokenIndex) => {
                    if (token.type === 'punctuation') {
                      return (
                        <span key={`result-punct-${tokenIndex}`} className="punctuation-result">
                          {token.text}
                        </span>
                      );
                    } else if (token.type === 'word') {
                      const wordPosition = token.word_position;
                      const isBlanked = blankedPositions.has(wordPosition);
                      const blankedIndex = isBlanked ? positionToBlankedIndex.get(wordPosition) : -1;
                      const wordState = isBlanked && blankedIndex >= 0 ? wordStates[blankedIndex] : 'correct';
                      
                      return (
                        <div key={`result-word-${tokenIndex}`} className="word-result">
                          <div className={`word-display ${wordState}`}>
                            {token.text}
                          </div>
                          <div className="word-translation">
                            {getWordTranslation(token.text, wordPosition)}
                          </div>
                        </div>
                      );
                    }
                    return null;
                  })
                ) : (
                  allWords.map((word, wordIndex) => {
                    const isBlanked = blankedPositions.has(wordIndex);
                    const blankedIndex = isBlanked ? positionToBlankedIndex.get(wordIndex) : -1;
                    const wordState = isBlanked && blankedIndex >= 0 ? wordStates[blankedIndex] : 'correct';
                    
                    return (
                      <div key={wordIndex} className="word-result">
                        <div className={`word-display ${wordState}`}>
                          {word}
                        </div>
                        <div className="word-translation">
                          {getWordTranslation(word, wordIndex)}
                        </div>
                      </div>
                    );
                  })
                )}
              </div>
            ) : (
              // 正常的输入界面 - 显示混合的单词和输入框
              <div className="word-blanks">
                {useTokensForDisplay ? (
                  // 使用包含标点符号的tokens
                  tokensWithPunctuation.map((token, tokenIndex) => {
                    if (token.type === 'punctuation') {
                      // 显示标点符号
                      return (
                        <span key={`punct-${tokenIndex}`} className="punctuation">
                          {token.text}
                        </span>
                      );
                    } else if (token.type === 'word') {
                      // 显示单词或输入框
                      const wordPosition = token.word_position;
                      const isBlanked = blankedPositions.has(wordPosition);
                      
                      return (
                        <React.Fragment key={`word-${tokenIndex}`}>
                          {isBlanked ? (
                            // 创建输入框给需要填空的单词
                            (() => {
                              const blankedIndex = positionToBlankedIndex.get(wordPosition);
                              if (blankedIndex === undefined) return null;
                              
                              return (
                                <div className="word-blank">
                                  <Input
                                    ref={(el) => {
                                      if (el) inputRefs.current[blankedIndex] = el;
                                    }}
                                    size="small"
                                    value={wordInputs[blankedIndex] || ''}
                                    onChange={(e) => handleWordInputChange(blankedIndex, e.target.value)}
                                    onKeyDown={handleKeyPress(blankedIndex)}
                                    placeholder=""
                                    className={`word-input ${wordStates[blankedIndex] || 'pending'}`}
                                    style={{ width: Math.max(token.text.length * 12 + 20, 60) }}
                                  />
                                </div>
                              );
                            })()
                          ) : (
                            // 显示不需要填空的单词
                            <span className="visible-word">{token.text}</span>
                          )}
                        </React.Fragment>
                      );
                    }
                    return null;
                  })
                ) : (
                  // 回退到原来的显示方式（不显示标点符号）
                  allWords.map((word, wordIndex) => {
                    const isBlanked = blankedPositions.has(wordIndex);
                    
                    return (
                      <React.Fragment key={wordIndex}>
                        {isBlanked ? (
                          // 创建输入框给需要填空的单词
                          (() => {
                            const blankedIndex = positionToBlankedIndex.get(wordIndex);
                            if (blankedIndex === undefined) return null;
                            
                            return (
                              <div className="word-blank">
                                <Input
                                  ref={(el) => {
                                    if (el) inputRefs.current[blankedIndex] = el;
                                  }}
                                  size="small"
                                  value={wordInputs[blankedIndex] || ''}
                                  onChange={(e) => handleWordInputChange(blankedIndex, e.target.value)}
                                  onKeyDown={handleKeyPress(blankedIndex)}
                                  placeholder=""
                                  className={`word-input ${wordStates[blankedIndex] || 'pending'}`}
                                  style={{ width: Math.max(word.length * 12 + 20, 60) }}
                                />
                              </div>
                            );
                          })()
                        ) : (
                          // 显示不需要填空的单词
                          <span className="visible-word">{word}</span>
                        )}
                        {wordIndex < allWords.length - 1 && ' '}
                      </React.Fragment>
                    );
                  })
                )}
              </div>
            )}
          </div>
            
          {feedback && (
            <div className={`feedback incorrect`}>
              {feedback}
            </div>
          )}

          {showHint && currentWordIndex < blankedWords.length && (
            <div className="hint-section">
              <div className="hint-content">
                <strong>提示:</strong> 第 {currentWordIndex + 1} 个单词以 "{blankedWords[currentWordIndex]?.[0]}" 开头
              </div>
            </div>
          )}
        </div>

        <div className="control-shortcuts">
          <div className="audio-control-row">
            <Button
              type="primary"
              icon={audioState.isLoading ? <LoadingOutlined /> : 
                    audioState.isPlaying ? <PauseOutlined /> : <SoundOutlined />}
              onClick={handlePlayAudio}
              loading={audioState.isLoading}
              className={`audio-button ${audioState.isPlaying ? 'playing' : ''}`}
            >
              {audioState.isLoading ? '加载中...' :
               audioState.isPlaying ? '停止播放' : '点击播放'}
            </Button>
            
            {playbackSpeed !== 1.0 && (
              <span style={{ marginLeft: '8px', fontSize: '12px', color: '#666' }}>
                {playbackSpeed}x 速度
              </span>
            )}
          </div>
          
          <div className="navigation-controls">
            <Button 
              icon={<LeftOutlined />} 
              onClick={onPrevious}
              size="large"
              className="nav-button nav-button-icon-only"
              type="default"
            />
            
            <div className="keyboard-shortcuts">
              <Space split={<span>|</span>} size="small">
                <span><kbd>Ctrl</kbd> + <kbd>Space</kbd> 播放发音</span>
                <span><kbd>Space</kbd> 下一个单词</span>
                <span><kbd>Enter</kbd> 提交验证</span>
                <span><kbd>Ctrl</kbd> + <kbd>H</kbd> 提示</span>
                <span><kbd>Ctrl</kbd> + <kbd>←</kbd> / <kbd>→</kbd> 切换句子</span>
              </Space>
            </div>
            
            <Button 
              icon={<RightOutlined />} 
              onClick={handleNextClick}
              size="large"
              className="nav-button nav-button-icon-only"
              type="default"
            />
          </div>
        </div>
      </Card>
    </div>
  );
};

export default ChineseTranslationView;