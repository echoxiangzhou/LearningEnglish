import React, { useState } from 'react';
import { Button, Card, Typography, message } from 'antd';
import ChineseTranslationView from '../components/dictation/ChineseTranslationView';
import type { DictationSession } from '../types/dictation';

const { Title, Paragraph } = Typography;

const ChineseTranslationDemo: React.FC = () => {
  const [currentIndex, setCurrentIndex] = useState(0);
  
  // 示例句子数据
  const sampleSentences = [
    {
      chinese: '我通常六点起床',
      english: 'I usually get up at six',
      audio: '/api/dictation/audio/1?speed=1.0'
    },
    {
      chinese: '她每天都去学校',
      english: 'She goes to school every day',
      audio: '/api/dictation/audio/2?speed=1.0'
    },
    {
      chinese: '我们喜欢在公园里玩',
      english: 'We like to play in the park',
      audio: '/api/dictation/audio/3?speed=1.0'
    },
    {
      chinese: '他正在做作业',
      english: 'He is doing his homework',
      audio: '/api/dictation/audio/4?speed=1.0'
    }
  ];

  const currentSentence = sampleSentences[currentIndex];

  // 创建模拟的 session 对象
  const mockSession: DictationSession = {
    session_id: 1,
    sentence_id: currentIndex + 1,
    session_data: {
      sentence_text: currentSentence.english,
      chinese_translation: currentSentence.chinese,
      sentence_difficulty: 'medium'
    },
    words: [],
    blanked_words: 1,
    total_words: currentSentence.english.split(' ').length,
    completed_words: 0,
    playback_speed: 1.0,
    play_count: 0,
    is_completed: false,
    accuracy_score: 0,
    hints_used: 0,
    progress: 0
  };

  const handleWordSubmit = async (position: number, userInput: string) => {
    // 模拟验证用户输入
    const normalizedInput = userInput.toLowerCase().trim();
    const normalizedCorrect = currentSentence.english.toLowerCase().trim();
    
    const isCorrect = normalizedInput === normalizedCorrect;
    
    return {
      is_correct: isCorrect,
      feedback: isCorrect ? '答案正确！' : '答案不正确，请重试'
    };
  };

  const handleAudioPlay = () => {
    message.info('播放音频功能需要后端支持');
  };

  const handleHintRequest = (position: number, hintType: string) => {
    const hints = {
      'letter': currentSentence.english.charAt(0),
      'phonetic': '[示例音标]',
      'definition': '这是一个日常用语',
      'full': currentSentence.english
    };
    
    message.info(`提示 (${hintType}): ${hints[hintType as keyof typeof hints]}`);
  };

  const handleComplete = () => {
    message.success('恭喜完成！');
  };

  const handleNext = () => {
    if (currentIndex < sampleSentences.length - 1) {
      setCurrentIndex(currentIndex + 1);
      message.info(`切换到句子 ${currentIndex + 2}`);
    } else {
      message.info('已经是最后一个句子了');
    }
  };

  const handlePrevious = () => {
    if (currentIndex > 0) {
      setCurrentIndex(currentIndex - 1);
      message.info(`切换到句子 ${currentIndex}`);
    } else {
      message.info('已经是第一个句子了');
    }
  };

  const handleReset = () => {
    setCurrentIndex(0);
    message.info('重置到第一个句子');
  };

  return (
    <div style={{ padding: '20px', maxWidth: '1000px', margin: '0 auto' }}>
      <Card style={{ marginBottom: '20px' }}>
        <Title level={2}>中英翻译练习演示</Title>
        <Paragraph>
          这是一个中英翻译练习的演示页面。页面显示中文句子，用户需要输入对应的英文翻译。
        </Paragraph>
        <Paragraph>
          <strong>功能特点：</strong>
          <ul>
            <li>显示中文句子，用户输入英文翻译</li>
            <li>支持音频播放功能</li>
            <li>提供提示系统</li>
            <li>键盘快捷键支持</li>
            <li>实时反馈和进度跟踪</li>
          </ul>
        </Paragraph>
        <div style={{ marginTop: '16px' }}>
          <Button 
            onClick={handlePrevious} 
            disabled={currentIndex === 0}
            style={{ marginRight: '8px' }}
          >
            上一句
          </Button>
          <Button 
            onClick={handleNext} 
            disabled={currentIndex === sampleSentences.length - 1}
            style={{ marginRight: '8px' }}
          >
            下一句
          </Button>
          <Button onClick={handleReset}>
            重置
          </Button>
          <span style={{ marginLeft: '16px', color: '#666' }}>
            当前句子: {currentIndex + 1} / {sampleSentences.length}
          </span>
        </div>
      </Card>

      <ChineseTranslationView
        session={mockSession}
        audioUrl={currentSentence.audio}
        audioDuration={3}
        onWordSubmit={handleWordSubmit}
        onAudioPlay={handleAudioPlay}
        onHintRequest={handleHintRequest}
        onComplete={handleComplete}
        onNext={handleNext}
      />
    </div>
  );
};

export default ChineseTranslationDemo;