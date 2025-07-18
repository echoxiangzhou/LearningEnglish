import React, { useState, useEffect, useRef } from 'react';
import { Card, Input, Button, Tag, Space, Tooltip, message, Progress } from 'antd';
import { SoundOutlined, BulbOutlined, CheckCircleOutlined, CloseCircleOutlined, PauseOutlined, LoadingOutlined } from '@ant-design/icons';
import type { DictationSession, WordInput, HintInfo } from '../../types/dictation';
import { ttsService } from '../../services/ttsService';
import './SentenceDisplay.css';

interface SentenceDisplayProps {
  session: DictationSession;
  onWordSubmit: (position: number, value: string) => void;
  onAudioPlay: () => void;
  onHintRequest: (position: number, hintType: 'letter' | 'phonetic' | 'definition' | 'full') => void;
  showChinese?: boolean;
  isAudioPlaying?: boolean;
  playbackSpeed?: number;
  autoPlay?: boolean; // 是否自动播放新句子
  className?: string;
}

const SentenceDisplay: React.FC<SentenceDisplayProps> = ({
  session,
  onWordSubmit,
  onAudioPlay,
  onHintRequest,
  showChinese = true,
  isAudioPlaying = false,
  playbackSpeed = 1.0,
  autoPlay = true,
  className = ''
}) => {
  const [wordInputs, setWordInputs] = useState<Map<number, WordInput>>(new Map());
  const [hints] = useState<Map<number, HintInfo>>(new Map());
  const [audioState, setAudioState] = useState({
    isPlaying: false,
    isLoading: false,
    currentTime: 0,
    duration: 0,
    error: null as string | null
  });
  const inputRefs = useRef<Map<number, HTMLInputElement>>(new Map());
  const lastSentenceRef = useRef<string>(''); // 跟踪上一次播放的句子

  const { session_data } = session;
  const words = session_data.words || [];
  const chineseTranslation = session_data.chinese_translation || '';
  const sentenceText = session_data.sentence_text || '';

  // 初始化输入状态
  useEffect(() => {
    const newInputs = new Map<number, WordInput>();
    words.forEach(word => {
      if (word.is_blank) {
        newInputs.set(word.position, {
          position: word.position,
          value: word.user_input || '',
          isCorrect: word.is_correct,
          showHint: false,
          hintLevel: 0
        });
      }
    });
    setWordInputs(newInputs);
  }, [words]);

  // 清理音频资源
  useEffect(() => {
    return () => {
      ttsService.stopCurrentAudio();
    };
  }, []);

  // 自动播放新句子
  useEffect(() => {
    if (autoPlay && sentenceText && sentenceText !== lastSentenceRef.current) {
      // 延迟播放，确保组件完全加载
      const autoPlayTimer = setTimeout(() => {
        if (sentenceText && sentenceText !== lastSentenceRef.current) {
          lastSentenceRef.current = sentenceText;
          handleAutoPlay();
        }
      }, 300);

      return () => clearTimeout(autoPlayTimer);
    }
  }, [sentenceText, autoPlay]);

  // 自动播放处理函数
  const handleAutoPlay = async () => {
    if (!sentenceText || audioState.isPlaying) {
      return;
    }

    try {
      setAudioState(prev => ({ 
        ...prev, 
        isLoading: true, 
        error: null 
      }));

      await ttsService.speakText(sentenceText, {
        speed: playbackSpeed,
        voice: 'af_bella',
        provider: 'kokoro',
        onProgress: (currentTime: number, duration: number) => {
          setAudioState(prev => ({
            ...prev,
            currentTime,
            duration: duration || 0
          }));
        },
        onEnd: () => {
          setAudioState(prev => ({
            ...prev,
            isPlaying: false,
            currentTime: 0
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

      setAudioState(prev => ({
        ...prev,
        isPlaying: true,
        isLoading: false
      }));

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

  // 处理输入变化
  const handleInputChange = (position: number, value: string) => {
    const currentInput = wordInputs.get(position);
    if (currentInput) {
      const newInput = { ...currentInput, value: value.trim() };
      setWordInputs(new Map(wordInputs.set(position, newInput)));
    }
  };

  // 处理回车提交
  const handleInputSubmit = (position: number) => {
    const input = wordInputs.get(position);
    if (input && input.value) {
      onWordSubmit(position, input.value);
    }
  };

  // 处理键盘事件
  const handleKeyPress = (e: React.KeyboardEvent, position: number) => {
    if (e.key === 'Enter') {
      handleInputSubmit(position);
    } else if (e.key === 'Tab') {
      e.preventDefault();
      // 跳转到下一个空白输入框
      const nextBlankPosition = findNextBlankPosition(position);
      if (nextBlankPosition !== null) {
        focusInput(nextBlankPosition);
      }
    }
  };

  // 查找下一个空白位置
  const findNextBlankPosition = (currentPosition: number): number | null => {
    const blankPositions = Array.from(wordInputs.keys()).sort((a, b) => a - b);
    const currentIndex = blankPositions.indexOf(currentPosition);
    if (currentIndex < blankPositions.length - 1) {
      return blankPositions[currentIndex + 1];
    }
    return null;
  };

  // 聚焦输入框
  const focusInput = (position: number) => {
    const input = inputRefs.current.get(position);
    if (input) {
      input.focus();
    }
  };

  // 处理提示请求
  const handleHintClick = async (position: number) => {
    const currentInput = wordInputs.get(position);
    if (!currentInput) return;

    const hintTypes: ('letter' | 'phonetic' | 'definition' | 'full')[] = 
      ['letter', 'phonetic', 'definition', 'full'];
    const nextHintType = hintTypes[currentInput.hintLevel % hintTypes.length];

    try {
      onHintRequest(position, nextHintType);
      
      // 更新提示级别
      const newInput = { 
        ...currentInput, 
        showHint: true, 
        hintLevel: currentInput.hintLevel + 1 
      };
      setWordInputs(new Map(wordInputs.set(position, newInput)));
    } catch (error) {
      message.error('获取提示失败');
    }
  };

  // 检查是否为标点符号
  const isPunctuation = (text: string): boolean => {
    const punctuationRegex = /^[^\w\s]$/;
    return punctuationRegex.test(text);
  };

  // 检查文本是否包含标点符号
  const containsPunctuation = (text: string): boolean => {
    const punctuationRegex = /[^\w\s]/g;
    return punctuationRegex.test(text);
  };

  // 分离单词和标点符号
  const separateWordAndPunctuation = (text: string): { word: string; punctuation: string } => {
    const match = text.match(/^(\w+)([^\w\s]*)$/);
    if (match) {
      return {
        word: match[1],
        punctuation: match[2]
      };
    }
    return { word: text, punctuation: '' };
  };

  // 处理TTS音频播放
  const handleTTSPlay = async () => {
    if (!sentenceText) {
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

      await ttsService.speakText(sentenceText, {
        speed: playbackSpeed,
        voice: 'af_bella', // 使用Kokoro的默认女声
        provider: 'kokoro',
        onProgress: (currentTime: number, duration: number) => {
          setAudioState(prev => ({
            ...prev,
            currentTime,
            duration: duration || 0
          }));
        },
        onEnd: () => {
          setAudioState(prev => ({
            ...prev,
            isPlaying: false,
            currentTime: 0
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

      setAudioState(prev => ({
        ...prev,
        isPlaying: true,
        isLoading: false
      }));

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

  // 获取输入框状态样式
  const getInputStatus = (position: number): 'default' | 'success' | 'error' => {
    const word = words.find(w => w.position === position);
    if (word?.is_correct === true) return 'success';
    if (word?.is_correct === false) return 'error';
    return 'default';
  };

  // 渲染单词或输入框
  const renderWordOrInput = (word: any, index: number) => {
    if (!word.is_blank) {
      // 对于非空白单词，检查是否包含标点符号并分别显示
      if (containsPunctuation(word.word)) {
        const { word: wordPart, punctuation } = separateWordAndPunctuation(word.word);
        return (
          <span key={index} className="word-display">
            <span className="word-text">{wordPart}</span>
            <span className="punctuation-display">{punctuation}</span>
          </span>
        );
      }
      
      return (
        <span key={index} className="word-display">
          {word.word}
        </span>
      );
    }

    const input = wordInputs.get(word.position);
    const hint = hints.get(word.position);
    const status = getInputStatus(word.position);
    const isCorrect = word.is_correct;

    // 检查原始单词是否包含标点符号
    const originalWord = word.original || word.word;
    const hasPunctuation = containsPunctuation(originalWord);
    const { word: wordPart, punctuation } = hasPunctuation ? 
      separateWordAndPunctuation(originalWord) : 
      { word: originalWord, punctuation: '' };

    return (
      <span key={index} className={`word-input-container ${status}`}>
        <div className="input-wrapper">
          <div className="input-with-punctuation">
            <Input
              ref={(el) => {
                if (el) {
                  inputRefs.current.set(word.position, el.input!);
                }
              }}
              value={input?.value || ''}
              onChange={(e) => handleInputChange(word.position, e.target.value)}
              onKeyDown={(e) => handleKeyPress(e, word.position)}
              onFocus={() => {}}
              onBlur={() => {}}
              placeholder={`___`}
              className={`word-input ${status}`}
              size="small"
              disabled={isCorrect}
              status={status === 'error' ? 'error' : undefined}
              style={{ display: 'inline-block', width: 'auto', minWidth: '60px' }}
            />
            
            {/* 自动显示标点符号 */}
            {punctuation && (
              <span className="auto-punctuation" title="标点符号会自动显示">
                {punctuation}
              </span>
            )}
          </div>
          
          {/* 正确/错误状态图标 */}
          {isCorrect === true && (
            <CheckCircleOutlined className="status-icon success" />
          )}
          {isCorrect === false && (
            <CloseCircleOutlined className="status-icon error" />
          )}
          
          {/* 提示按钮 */}
          {!isCorrect && (
            <Tooltip title="获取提示">
              <Button
                type="text"
                size="small"
                icon={<BulbOutlined />}
                onClick={() => handleHintClick(word.position)}
                className="hint-button"
              />
            </Tooltip>
          )}
        </div>
        
        {/* 显示提示内容 */}
        {hint && input?.showHint && (
          <div className="hint-display">
            <Tag color="blue">
              {hint.type}: {hint.content}
            </Tag>
          </div>
        )}
      </span>
    );
  };

  return (
    <div className={`sentence-display ${className}`}>
      {/* 中文翻译显示 */}
      {showChinese && chineseTranslation && (
        <Card className="chinese-translation" size="small">
          <div className="translation-header">
            <Tag color="green">中文翻译</Tag>
          </div>
          <div className="translation-text">
            {chineseTranslation}
          </div>
        </Card>
      )}

      {/* 英文句子显示 */}
      <Card className="english-sentence" size="small">
        <div className="sentence-header">
          <Space>
            <Tag color="blue">英文句子</Tag>
            <div className="audio-controls">
              <Button
                type="text"
                icon={audioState.isLoading ? <LoadingOutlined /> : 
                      audioState.isPlaying ? <PauseOutlined /> : <SoundOutlined />}
                onClick={handleTTSPlay}
                loading={audioState.isLoading}
                className={`audio-button ${audioState.isPlaying ? 'playing' : ''}`}
                size="small"
              >
                {audioState.isLoading ? '加载中...' :
                 audioState.isPlaying ? '停止播放' : '播放发音'}
              </Button>
              
              {audioState.duration > 0 && (
                <div className="audio-progress">
                  <Progress
                    percent={audioState.duration > 0 ? 
                      Math.round((audioState.currentTime / audioState.duration) * 100) : 0}
                    size="small"
                    showInfo={false}
                    strokeColor="#1890ff"
                  />
                  <span className="audio-time">
                    {Math.round(audioState.currentTime)}s / {Math.round(audioState.duration)}s
                  </span>
                </div>
              )}
              
              {playbackSpeed !== 1.0 && (
                <Tag color="orange" size="small">
                  {playbackSpeed}x 速度
                </Tag>
              )}
            </div>
          </Space>
        </div>
        
        <div className="sentence-content">
          {words.map((word, index) => (
            <React.Fragment key={word.position}>
              {renderWordOrInput(word, index)}
              {index < words.length - 1 && ' '}
            </React.Fragment>
          ))}
        </div>
      </Card>

      {/* 操作提示 */}
      <div className="operation-hints">
        <Space wrap>
          <Tag icon={<SoundOutlined />} color="blue">
            点击播放音频
          </Tag>
          <Tag icon={<BulbOutlined />} color="orange">
            点击灯泡获取提示
          </Tag>
          <Tag color="green">
            按回车提交单词
          </Tag>
          <Tag color="purple">
            按Tab跳到下一个空
          </Tag>
        </Space>
      </div>
    </div>
  );
};

export default SentenceDisplay;