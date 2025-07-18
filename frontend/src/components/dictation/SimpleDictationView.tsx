import React, { useState, useCallback } from 'react';
import type { DictationSession } from '../../types/dictation';
import './SimpleDictationView.css';

interface SimpleDictationViewProps {
  session: DictationSession;
  onWordSubmit: (position: number, value: string) => void;
  onAudioPlay?: () => void;
  onHintRequest: (position: number, hintType: 'letter' | 'phonetic' | 'definition' | 'full') => void;
  progress: number; // 0-100
  className?: string;
}

const SimpleDictationView: React.FC<SimpleDictationViewProps> = ({
  session,
  onWordSubmit,
  onHintRequest,
  progress,
  className = ''
}) => {
  const [inputs, setInputs] = useState<{ [key: number]: string }>({});
  const [, setActiveInput] = useState<number | null>(null);

  const { session_data } = session;
  const words = session_data.words || [];
  const chineseTranslation = session_data.chinese_translation || '';

  const handleInputChange = useCallback((position: number, value: string) => {
    setInputs(prev => ({ ...prev, [position]: value }));
  }, []);

  const handleInputSubmit = useCallback((position: number) => {
    const value = inputs[position] || '';
    if (value.trim()) {
      onWordSubmit(position, value.trim());
    }
  }, [inputs, onWordSubmit]);

  const handleKeyPress = useCallback((e: React.KeyboardEvent, position: number) => {
    if (e.key === 'Enter') {
      handleInputSubmit(position);
    } else if (e.key === 'Tab') {
      e.preventDefault();
      // 找到下一个空白位置
      const blankPositions = words.filter(w => w.is_blank).map(w => w.position).sort();
      const currentIndex = blankPositions.indexOf(position);
      if (currentIndex < blankPositions.length - 1) {
        setActiveInput(blankPositions[currentIndex + 1]);
      }
    }
  }, [words, handleInputSubmit]);

  const renderWord = (word: any, index: number) => {
    if (!word.is_blank) {
      return (
        <span key={index} className="word">
          {word.word}
        </span>
      );
    }

    const isCorrect = word.is_correct;
    const userInput = inputs[word.position] || word.user_input || '';
    
    return (
      <span key={index} className="blank-container">
        <input
          type="text"
          value={userInput}
          onChange={(e) => handleInputChange(word.position, e.target.value)}
          onKeyDown={(e) => handleKeyPress(e, word.position)}
          onFocus={() => setActiveInput(word.position)}
          onBlur={() => setActiveInput(null)}
          className={`blank-input ${isCorrect === true ? 'correct' : isCorrect === false ? 'incorrect' : ''}`}
          disabled={isCorrect === true}
          placeholder=""
          autoComplete="off"
        />
        {isCorrect === false && (
          <button 
            className="hint-btn"
            onClick={() => onHintRequest(word.position, 'letter')}
            title="获取提示"
          >
            💡
          </button>
        )}
      </span>
    );
  };

  return (
    <div className={`simple-dictation-view ${className}`}>
      {/* 顶部进度条 */}
      <div className="progress-bar">
        <div 
          className="progress-fill" 
          style={{ width: `${progress}%` }}
        />
      </div>

      {/* 主要内容区域 */}
      <div className="content-area">
        {/* 中文翻译 */}
        <div className="chinese-translation">
          {chineseTranslation}
        </div>

        {/* 英文句子 */}
        <div className="english-sentence">
          {words.map((word, index) => (
            <React.Fragment key={word.position}>
              {renderWord(word, index)}
              {index < words.length - 1 && ' '}
            </React.Fragment>
          ))}
        </div>
      </div>

      {/* 底部操作提示 */}
      <div className="operation-hints">
        <div className="hint-item">
          <span className="key">Ctrl</span>
          <span className="separator">+</span>
          <span className="action">播放音频</span>
        </div>
        <div className="hint-item">
          <span className="key">Ctrl</span>
          <span className="key">M</span>
          <span className="action">暂停</span>
        </div>
        <div className="hint-item">
          <span className="key">Ctrl</span>
          <span className="key">N</span>
          <span className="action">生词</span>
        </div>
        <div className="hint-item">
          <span className="key">Enter</span>
          <span className="action">提交</span>
        </div>
        <div className="hint-item">
          <span className="key">Ctrl</span>
          <span className="separator">+</span>
          <span className="action">显示答案</span>
        </div>
      </div>

      {/* 左右箭头 */}
      <button className="nav-arrow nav-left" onClick={() => {}}>
        ◀
      </button>
      <button className="nav-arrow nav-right" onClick={() => {}}>
        ▶
      </button>
    </div>
  );
};

export default SimpleDictationView;