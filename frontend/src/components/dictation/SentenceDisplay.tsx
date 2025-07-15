import React, { useState, useEffect, useRef } from 'react';
import { Card, Input, Button, Tag, Space, Tooltip, message } from 'antd';
import { SoundOutlined, BulbOutlined, CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';
import { DictationSession, WordInput, HintInfo } from '../../types/dictation';
import { dictationService } from '../../services/dictationService';
import './SentenceDisplay.css';

interface SentenceDisplayProps {
  session: DictationSession;
  onWordSubmit: (position: number, value: string) => void;
  onAudioPlay: () => void;
  onHintRequest: (position: number, hintType: 'letter' | 'phonetic' | 'definition' | 'full') => void;
  showChinese?: boolean;
  isAudioPlaying?: boolean;
  className?: string;
}

const SentenceDisplay: React.FC<SentenceDisplayProps> = ({
  session,
  onWordSubmit,
  onAudioPlay,
  onHintRequest,
  showChinese = true,
  isAudioPlaying = false,
  className = ''
}) => {
  const [wordInputs, setWordInputs] = useState<Map<number, WordInput>>(new Map());
  const [hints, setHints] = useState<Map<number, HintInfo>>(new Map());
  const [focusedPosition, setFocusedPosition] = useState<number | null>(null);
  const inputRefs = useRef<Map<number, HTMLInputElement>>(new Map());

  const { session_data } = session;
  const words = session_data.words || [];
  const chineseTranslation = session_data.chinese_translation || '';

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
      setFocusedPosition(position);
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

    return (
      <span key={index} className={`word-input-container ${status}`}>
        <div className="input-wrapper">
          <Input
            ref={(el) => {
              if (el) {
                inputRefs.current.set(word.position, el.input!);
              }
            }}
            value={input?.value || ''}
            onChange={(e) => handleInputChange(word.position, e.target.value)}
            onKeyDown={(e) => handleKeyPress(e, word.position)}
            onFocus={() => setFocusedPosition(word.position)}
            onBlur={() => setFocusedPosition(null)}
            placeholder={`___`}
            className={`word-input ${status}`}
            size="small"
            disabled={isCorrect}
            status={status === 'error' ? 'error' : undefined}
          />
          
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
            <Button
              type="text"
              icon={<SoundOutlined />}
              onClick={onAudioPlay}
              loading={isAudioPlaying}
              className="audio-button"
              size="small"
            >
              播放音频
            </Button>
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