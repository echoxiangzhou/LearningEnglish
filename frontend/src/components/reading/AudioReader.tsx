import React, { useState, useEffect, useRef, useCallback } from 'react';
import {
  Button,
  Slider,
  Space,
  Typography,
  Tooltip,
  message,
  Spin,
  Progress,
  Card,
  Select,
  Switch
} from 'antd';
import {
  PlayCircleOutlined,
  PauseCircleOutlined,
  StopOutlined,
  ReloadOutlined,
  SoundOutlined,
  ForwardOutlined,
  BackwardOutlined,
  SettingOutlined
} from '@ant-design/icons';
import './AudioReader.css';

const { Text, Title } = Typography;
const { Option } = Select;

// Define types for audio data and timestamps
interface WordTimestamp {
  word: string;
  start: number;
  end: number;
  confidence?: number;
}

interface SentenceTimestamp {
  sentence: string;
  start: number;
  end: number;
  words: WordTimestamp[];
}

interface AudioData {
  audio_url?: string;
  audio_base64?: string;
  duration: number;
  timestamps: {
    sentences: SentenceTimestamp[];
    words: WordTimestamp[];
  };
}

interface AudioReaderProps {
  content: string;
  onWordHighlight?: (word: string, startTime: number, endTime: number) => void;
  onSentenceHighlight?: (sentence: string, startTime: number, endTime: number) => void;
  onPlaybackStateChange?: (isPlaying: boolean, currentTime: number) => void;
  voice?: string;
  provider?: string;
  autoPlay?: boolean;
  showControls?: boolean;
  highlightMode?: 'word' | 'sentence' | 'both';
}

const AudioReader: React.FC<AudioReaderProps> = ({
  content,
  onWordHighlight,
  onSentenceHighlight,
  onPlaybackStateChange,
  voice = 'af_bella',
  provider = 'kokoro',
  autoPlay = false,
  showControls = true,
  highlightMode = 'both'
}) => {
  // State management
  const [isPlaying, setIsPlaying] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [audioData, setAudioData] = useState<AudioData | null>(null);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(0);
  const [volume, setVolume] = useState(1.0);
  const [playbackRate, setPlaybackRate] = useState(1.0);
  const [currentWordIndex, setCurrentWordIndex] = useState(-1);
  const [currentSentenceIndex, setCurrentSentenceIndex] = useState(-1);
  const [showSettings, setShowSettings] = useState(false);
  const [autoScroll, setAutoScroll] = useState(true);
  const [selectedVoice, setSelectedVoice] = useState(voice);
  const [selectedProvider, setSelectedProvider] = useState(provider);

  // Refs
  const audioRef = useRef<HTMLAudioElement>(null);
  const timeUpdateIntervalRef = useRef<NodeJS.Timeout | null>(null);
  const contentRef = useRef<HTMLDivElement>(null);

  // Available voices and providers
  const voices = {
    kokoro: [
      { id: 'af_bella', name: 'Bella (American Female)' },
      { id: 'af_sarah', name: 'Sarah (American Female)' },
      { id: 'af_sky', name: 'Sky (American Female)' },
      { id: 'am_adam', name: 'Adam (American Male)' },
      { id: 'am_michael', name: 'Michael (American Male)' },
      { id: 'bf_emma', name: 'Emma (British Female)' },
      { id: 'bf_isabella', name: 'Isabella (British Female)' },
      { id: 'bm_george', name: 'George (British Male)' },
      { id: 'bm_lewis', name: 'Lewis (British Male)' }
    ],
    minimax: [
      { id: 'presenter_female', name: 'Presenter (Female)' },
      { id: 'presenter_male', name: 'Presenter (Male)' }
    ]
  };

  // Generate audio with timestamps
  const generateAudio = useCallback(async () => {
    if (!content.trim()) {
      message.error('No content to read');
      return;
    }

    setIsLoading(true);
    try {
      const response = await fetch('/api/tts/generate-with-timestamps', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('access_token')}`
        },
        body: JSON.stringify({
          text: content,
          voice: selectedVoice,
          speed: playbackRate
        })
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const data = await response.json();
      
      if (data.error) {
        throw new Error(data.error);
      }

      // Set audio data
      setAudioData(data);
      
      // Create audio element if audio URL or base64 is provided
      if (data.audio_url || data.audio_base64) {
        const audioSrc = data.audio_url || `data:audio/mp3;base64,${data.audio_base64}`;
        
        if (audioRef.current) {
          audioRef.current.src = audioSrc;
          audioRef.current.load();
        }
      }

      message.success('Audio generated successfully');
      
      if (autoPlay) {
        setTimeout(() => {
          handlePlay();
        }, 500);
      }

    } catch (error) {
      console.error('Error generating audio:', error);
      message.error(`Failed to generate audio: ${error instanceof Error ? error.message : 'Unknown error'}`);
    } finally {
      setIsLoading(false);
    }
  }, [content, selectedVoice, playbackRate, autoPlay]);

  // Audio playback controls
  const handlePlay = () => {
    if (audioRef.current) {
      audioRef.current.play();
      setIsPlaying(true);
      startTimeUpdates();
    }
  };

  const handlePause = () => {
    if (audioRef.current) {
      audioRef.current.pause();
      setIsPlaying(false);
      stopTimeUpdates();
    }
  };

  const handleStop = () => {
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current.currentTime = 0;
      setIsPlaying(false);
      setCurrentTime(0);
      setCurrentWordIndex(-1);
      setCurrentSentenceIndex(-1);
      stopTimeUpdates();
    }
  };

  const handleSeek = (time: number) => {
    if (audioRef.current) {
      audioRef.current.currentTime = time;
      setCurrentTime(time);
      updateHighlights(time);
    }
  };

  const handleVolumeChange = (value: number) => {
    setVolume(value);
    if (audioRef.current) {
      audioRef.current.volume = value;
    }
  };

  const handlePlaybackRateChange = (rate: number) => {
    setPlaybackRate(rate);
    if (audioRef.current) {
      audioRef.current.playbackRate = rate;
    }
  };

  // Time update handling
  const startTimeUpdates = () => {
    if (timeUpdateIntervalRef.current) {
      clearInterval(timeUpdateIntervalRef.current);
    }
    
    timeUpdateIntervalRef.current = setInterval(() => {
      if (audioRef.current && !audioRef.current.paused) {
        const currentTime = audioRef.current.currentTime;
        setCurrentTime(currentTime);
        updateHighlights(currentTime);
        
        if (onPlaybackStateChange) {
          onPlaybackStateChange(true, currentTime);
        }
      }
    }, 100); // Update every 100ms for smooth highlighting
  };

  const stopTimeUpdates = () => {
    if (timeUpdateIntervalRef.current) {
      clearInterval(timeUpdateIntervalRef.current);
      timeUpdateIntervalRef.current = null;
    }
  };

  // Update highlighting based on current time
  const updateHighlights = (time: number) => {
    if (!audioData?.timestamps) return;

    // Update word highlighting
    if (highlightMode === 'word' || highlightMode === 'both') {
      const words = audioData.timestamps.words || [];
      const currentWord = words.findIndex(word => 
        time >= word.start && time <= word.end
      );
      
      if (currentWord !== currentWordIndex && currentWord >= 0) {
        setCurrentWordIndex(currentWord);
        const word = words[currentWord];
        
        if (onWordHighlight) {
          onWordHighlight(word.word, word.start, word.end);
        }
        
        // Auto-scroll to current word
        if (autoScroll) {
          scrollToHighlight('word', currentWord);
        }
      }
    }

    // Update sentence highlighting
    if (highlightMode === 'sentence' || highlightMode === 'both') {
      const sentences = audioData.timestamps.sentences || [];
      const currentSentence = sentences.findIndex(sentence => 
        time >= sentence.start && time <= sentence.end
      );
      
      if (currentSentence !== currentSentenceIndex && currentSentence >= 0) {
        setCurrentSentenceIndex(currentSentence);
        const sentence = sentences[currentSentence];
        
        if (onSentenceHighlight) {
          onSentenceHighlight(sentence.sentence, sentence.start, sentence.end);
        }
        
        // Auto-scroll to current sentence
        if (autoScroll && highlightMode === 'sentence') {
          scrollToHighlight('sentence', currentSentence);
        }
      }
    }
  };

  // Auto-scroll to highlighted content
  const scrollToHighlight = (type: 'word' | 'sentence', index: number) => {
    if (!contentRef.current) return;

    const selector = type === 'word' 
      ? `.audio-word-${index}` 
      : `.audio-sentence-${index}`;
    
    const element = contentRef.current.querySelector(selector);
    if (element) {
      element.scrollIntoView({
        behavior: 'smooth',
        block: 'center',
        inline: 'nearest'
      });
    }
  };

  // Navigate to specific sentence
  const navigateToSentence = (sentenceIndex: number) => {
    if (!audioData?.timestamps.sentences[sentenceIndex]) return;

    const sentence = audioData.timestamps.sentences[sentenceIndex];
    handleSeek(sentence.start);
    
    if (!isPlaying) {
      handlePlay();
    }
  };

  // Navigate to specific word
  const navigateToWord = (wordIndex: number) => {
    if (!audioData?.timestamps.words[wordIndex]) return;

    const word = audioData.timestamps.words[wordIndex];
    handleSeek(word.start);
    
    if (!isPlaying) {
      handlePlay();
    }
  };

  // Skip forward/backward by sentences
  const skipToNextSentence = () => {
    if (currentSentenceIndex < (audioData?.timestamps.sentences.length || 0) - 1) {
      navigateToSentence(currentSentenceIndex + 1);
    }
  };

  const skipToPreviousSentence = () => {
    if (currentSentenceIndex > 0) {
      navigateToSentence(currentSentenceIndex - 1);
    }
  };

  // Format time display
  const formatTime = (seconds: number): string => {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = Math.floor(seconds % 60);
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  // Render content with highlighting
  const renderContent = () => {
    if (!content) return null;

    if (!audioData?.timestamps) {
      return <div className="audio-content-static">{content}</div>;
    }

    const words = audioData.timestamps.words || [];
    const sentences = audioData.timestamps.sentences || [];
    
    // Split content into words and sentences for highlighting
    let result: JSX.Element[] = [];
    let wordIndex = 0;
    
    // For now, render a simple word-by-word highlighting
    const contentWords = content.split(/(\s+)/);
    
    contentWords.forEach((segment, index) => {
      if (/^\s+$/.test(segment)) {
        // Whitespace
        result.push(<span key={`space-${index}`}>{segment}</span>);
      } else {
        // Word
        const isCurrentWord = wordIndex === currentWordIndex;
        const wordData = words[wordIndex];
        
        result.push(
          <span
            key={`word-${wordIndex}`}
            className={`audio-word audio-word-${wordIndex} ${isCurrentWord ? 'audio-word-current' : ''}`}
            onClick={() => wordData && navigateToWord(wordIndex)}
            data-start={wordData?.start}
            data-end={wordData?.end}
          >
            {segment}
          </span>
        );
        wordIndex++;
      }
    });
    
    return <div className="audio-content-highlighted">{result}</div>;
  };

  // Initialize audio element
  useEffect(() => {
    const audio = audioRef.current;
    if (!audio) return;

    const handleLoadedMetadata = () => {
      setDuration(audio.duration);
    };

    const handleEnded = () => {
      setIsPlaying(false);
      setCurrentTime(0);
      setCurrentWordIndex(-1);
      setCurrentSentenceIndex(-1);
      stopTimeUpdates();
    };

    const handleError = (e: any) => {
      console.error('Audio error:', e);
      message.error('Audio playback error');
      setIsPlaying(false);
      stopTimeUpdates();
    };

    audio.addEventListener('loadedmetadata', handleLoadedMetadata);
    audio.addEventListener('ended', handleEnded);
    audio.addEventListener('error', handleError);

    // Set initial volume
    audio.volume = volume;

    return () => {
      audio.removeEventListener('loadedmetadata', handleLoadedMetadata);
      audio.removeEventListener('ended', handleEnded);
      audio.removeEventListener('error', handleError);
      stopTimeUpdates();
    };
  }, [volume]);

  // Auto-generate audio when content changes
  useEffect(() => {
    if (content) {
      generateAudio();
    }
  }, [generateAudio, content]);

  // Cleanup
  useEffect(() => {
    return () => {
      stopTimeUpdates();
    };
  }, []);

  return (
    <div className="audio-reader">
      <audio ref={audioRef} preload="metadata" />
      
      {showControls && (
        <Card className="audio-controls" size="small">
          <Space direction="vertical" style={{ width: '100%' }}>
            {/* Main Controls */}
            <div className="audio-controls-main">
              <Space>
                <Button
                  type="primary"
                  icon={isPlaying ? <PauseCircleOutlined /> : <PlayCircleOutlined />}
                  onClick={isPlaying ? handlePause : handlePlay}
                  disabled={!audioData || isLoading}
                  size="large"
                >
                  {isPlaying ? 'Pause' : 'Play'}
                </Button>
                
                <Button
                  icon={<StopOutlined />}
                  onClick={handleStop}
                  disabled={!audioData || isLoading}
                >
                  Stop
                </Button>
                
                <Button
                  icon={<ReloadOutlined />}
                  onClick={generateAudio}
                  loading={isLoading}
                >
                  Regenerate
                </Button>
                
                <Button
                  icon={<BackwardOutlined />}
                  onClick={skipToPreviousSentence}
                  disabled={!audioData || currentSentenceIndex <= 0}
                  title="Previous Sentence"
                />
                
                <Button
                  icon={<ForwardOutlined />}
                  onClick={skipToNextSentence}
                  disabled={!audioData || currentSentenceIndex >= (audioData?.timestamps.sentences.length || 0) - 1}
                  title="Next Sentence"
                />
                
                <Button
                  icon={<SettingOutlined />}
                  onClick={() => setShowSettings(!showSettings)}
                  type={showSettings ? 'primary' : 'default'}
                >
                  Settings
                </Button>
              </Space>
            </div>

            {/* Progress Bar */}
            <div className="audio-progress">
              <Space style={{ width: '100%' }} direction="vertical">
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                  <Text style={{ minWidth: '40px' }}>{formatTime(currentTime)}</Text>
                  <Slider
                    style={{ flex: 1 }}
                    min={0}
                    max={duration || 100}
                    value={currentTime}
                    onChange={handleSeek}
                    disabled={!audioData}
                    tooltip={{ formatter: (value) => formatTime(value || 0) }}
                  />
                  <Text style={{ minWidth: '40px' }}>{formatTime(duration)}</Text>
                </div>
                
                {audioData && (
                  <div className="audio-progress-info">
                    <Space>
                      <Text type="secondary">
                        Word: {currentWordIndex + 1} / {audioData.timestamps.words?.length || 0}
                      </Text>
                      <Text type="secondary">
                        Sentence: {currentSentenceIndex + 1} / {audioData.timestamps.sentences?.length || 0}
                      </Text>
                    </Space>
                  </div>
                )}
              </Space>
            </div>

            {/* Settings Panel */}
            {showSettings && (
              <div className="audio-settings">
                <Space direction="vertical" style={{ width: '100%' }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <SoundOutlined />
                    <Slider
                      style={{ flex: 1 }}
                      min={0}
                      max={1}
                      step={0.1}
                      value={volume}
                      onChange={handleVolumeChange}
                      tooltip={{ formatter: (value) => `${Math.round((value || 0) * 100)}%` }}
                    />
                    <SoundOutlined />
                    <Text style={{ minWidth: '40px' }}>{Math.round(volume * 100)}%</Text>
                  </div>
                  
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <Text>Speed:</Text>
                    <Select
                      value={playbackRate}
                      onChange={handlePlaybackRateChange}
                      style={{ width: 100 }}
                    >
                      <Option value={0.5}>0.5x</Option>
                      <Option value={0.75}>0.75x</Option>
                      <Option value={1.0}>1x</Option>
                      <Option value={1.25}>1.25x</Option>
                      <Option value={1.5}>1.5x</Option>
                    </Select>
                  </div>
                  
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <Text>Voice:</Text>
                    <Select
                      value={selectedVoice}
                      onChange={setSelectedVoice}
                      style={{ width: 200 }}
                    >
                      {voices[selectedProvider as keyof typeof voices]?.map(voice => (
                        <Option key={voice.id} value={voice.id}>
                          {voice.name}
                        </Option>
                      ))}
                    </Select>
                  </div>
                  
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <Text>Auto-scroll:</Text>
                    <Switch
                      checked={autoScroll}
                      onChange={setAutoScroll}
                    />
                  </div>
                </Space>
              </div>
            )}
          </Space>
        </Card>
      )}

      {/* Content with highlighting */}
      <div
        ref={contentRef}
        className="audio-content-container"
      >
        {isLoading ? (
          <div className="audio-loading">
            <Spin size="large" />
            <Text>Generating audio with timestamps...</Text>
          </div>
        ) : (
          renderContent()
        )}
      </div>
    </div>
  );
};

export default AudioReader;