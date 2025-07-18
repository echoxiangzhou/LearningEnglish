import React, { useState, useRef, useEffect } from 'react';
import { Card, Button, Slider, Space, Typography, Select, Tooltip, Progress } from 'antd';
import { 
  PlayCircleOutlined, 
  PauseCircleOutlined, 
  ReloadOutlined,
  SoundOutlined,
  ForwardOutlined,
  BackwardOutlined 
} from '@ant-design/icons';
import './AudioControls.css';

const { Text } = Typography;
const { Option } = Select;

interface AudioControlsProps {
  audioUrl: string;
  duration: number;
  onPlaybackSpeedChange: (speed: number) => void;
  onPlaybackComplete?: () => void;
  onPlaybackProgress?: (currentTime: number, percentage: number) => void;
  className?: string;
  autoPlay?: boolean;
  defaultSpeed?: number;
}

const AudioControls: React.FC<AudioControlsProps> = ({
  audioUrl,
  duration,
  onPlaybackSpeedChange,
  onPlaybackComplete,
  onPlaybackProgress,
  className = '',
  autoPlay = false,
  defaultSpeed = 1.0
}) => {
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [playbackSpeed, setPlaybackSpeed] = useState(defaultSpeed);
  const [volume, setVolume] = useState(70);
  const [isLoading, setIsLoading] = useState(false);
  const [hasError, setHasError] = useState(false);
  
  const audioRef = useRef<HTMLAudioElement>(null);
  const progressTimer = useRef<NodeJS.Timeout | null>(null);

  // 初始化音频
  useEffect(() => {
    if (audioRef.current && audioUrl) {
      const audio = audioRef.current;
      
      setIsLoading(true);
      setHasError(false);
      
      audio.src = audioUrl;
      audio.playbackRate = playbackSpeed;
      audio.volume = volume / 100;
      
      const handleCanPlay = () => {
        setIsLoading(false);
        if (autoPlay) {
          handlePlay();
        }
      };
      
      const handleError = () => {
        setIsLoading(false);
        setHasError(true);
      };
      
      const handleEnded = () => {
        setIsPlaying(false);
        setCurrentTime(0);
        onPlaybackComplete?.();
        if (progressTimer.current) {
          clearInterval(progressTimer.current);
        }
      };
      
      audio.addEventListener('canplay', handleCanPlay);
      audio.addEventListener('error', handleError);
      audio.addEventListener('ended', handleEnded);
      
      return () => {
        audio.removeEventListener('canplay', handleCanPlay);
        audio.removeEventListener('error', handleError);
        audio.removeEventListener('ended', handleEnded);
        if (progressTimer.current) {
          clearInterval(progressTimer.current);
        }
      };
    }
  }, [audioUrl, autoPlay]);

  // 更新播放速度
  useEffect(() => {
    if (audioRef.current) {
      audioRef.current.playbackRate = playbackSpeed;
    }
  }, [playbackSpeed]);

  // 更新音量
  useEffect(() => {
    if (audioRef.current) {
      audioRef.current.volume = volume / 100;
    }
  }, [volume]);

  // 播放控制
  const handlePlay = async () => {
    if (!audioRef.current || hasError) return;
    
    try {
      setIsLoading(true);
      await audioRef.current.play();
      setIsPlaying(true);
      setIsLoading(false);
      
      // 开始进度更新
      if (progressTimer.current) {
        clearInterval(progressTimer.current);
      }
      
      progressTimer.current = setInterval(() => {
        if (audioRef.current && !audioRef.current.paused) {
          const current = audioRef.current.currentTime;
          setCurrentTime(current);
          
          const percentage = duration > 0 ? (current / duration) * 100 : 0;
          onPlaybackProgress?.(current, percentage);
        }
      }, 100);
      
    } catch (error) {
      console.error('播放失败:', error);
      setIsLoading(false);
      setHasError(true);
    }
  };

  const handlePause = () => {
    if (audioRef.current) {
      audioRef.current.pause();
      setIsPlaying(false);
      
      if (progressTimer.current) {
        clearInterval(progressTimer.current);
      }
    }
  };

  const handleRestart = () => {
    if (audioRef.current) {
      audioRef.current.currentTime = 0;
      setCurrentTime(0);
      if (isPlaying) {
        handlePlay();
      }
    }
  };

  // 快进/快退
  const handleSeek = (seconds: number) => {
    if (audioRef.current) {
      const newTime = Math.max(0, Math.min(duration, audioRef.current.currentTime + seconds));
      audioRef.current.currentTime = newTime;
      setCurrentTime(newTime);
    }
  };


  // 速度控制
  const handleSpeedChange = (speed: number) => {
    setPlaybackSpeed(speed);
    onPlaybackSpeedChange(speed);
  };

  // 格式化时间
  const formatTime = (time: number): string => {
    const minutes = Math.floor(time / 60);
    const seconds = Math.floor(time % 60);
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  };

  // 计算进度百分比
  const progressPercentage = duration > 0 ? (currentTime / duration) * 100 : 0;

  const speedOptions = [
    { value: 0.5, label: '0.5x 慢速' },
    { value: 0.75, label: '0.75x 较慢' },
    { value: 1.0, label: '1.0x 正常' },
    { value: 1.25, label: '1.25x 较快' },
    { value: 1.5, label: '1.5x 快速' },
    { value: 2.0, label: '2.0x 很快' }
  ];

  return (
    <Card className={`audio-controls ${className}`} size="small">
      <audio ref={audioRef} preload="auto" />
      
      <div className="audio-controls-header">
        <Space>
          <SoundOutlined style={{ fontSize: '16px', color: '#1890ff' }} />
          <Text strong>音频播放</Text>
          {hasError && (
            <Text type="danger" style={{ fontSize: '12px' }}>
              音频加载失败
            </Text>
          )}
        </Space>
      </div>

      {/* 进度条 */}
      <div className="progress-section">
        <div className="time-display">
          <Text type="secondary">{formatTime(currentTime)}</Text>
          <Text type="secondary">{formatTime(duration)}</Text>
        </div>
        <Progress
          percent={progressPercentage}
          showInfo={false}
          strokeColor="#1890ff"
          trailColor="#f0f0f0"
          strokeWidth={8}
          className="progress-bar"
        />
      </div>

      {/* 主控制区域 */}
      <div className="main-controls">
        <Space size="middle">
          {/* 快退按钮 */}
          <Tooltip title="快退10秒">
            <Button
              type="text"
              icon={<BackwardOutlined />}
              onClick={() => handleSeek(-10)}
              disabled={!audioUrl || hasError}
              size="large"
            />
          </Tooltip>

          {/* 重新开始 */}
          <Tooltip title="重新开始">
            <Button
              type="text"
              icon={<ReloadOutlined />}
              onClick={handleRestart}
              disabled={!audioUrl || hasError}
              size="large"
            />
          </Tooltip>

          {/* 播放/暂停 */}
          <Button
            type="primary"
            shape="circle"
            size="large"
            icon={isPlaying ? <PauseCircleOutlined /> : <PlayCircleOutlined />}
            onClick={isPlaying ? handlePause : handlePlay}
            loading={isLoading}
            disabled={!audioUrl || hasError}
            className="play-button"
          />

          {/* 快进按钮 */}
          <Tooltip title="快进10秒">
            <Button
              type="text"
              icon={<ForwardOutlined />}
              onClick={() => handleSeek(10)}
              disabled={!audioUrl || hasError}
              size="large"
            />
          </Tooltip>
        </Space>
      </div>

      {/* 设置控制区域 */}
      <div className="settings-controls">
        <div className="speed-control">
          <Text type="secondary" style={{ fontSize: '12px' }}>播放速度:</Text>
          <Select
            value={playbackSpeed}
            onChange={handleSpeedChange}
            size="small"
            style={{ width: 100 }}
            disabled={!audioUrl || hasError}
          >
            {speedOptions.map(option => (
              <Option key={option.value} value={option.value}>
                {option.label}
              </Option>
            ))}
          </Select>
        </div>

        <div className="volume-control">
          <Text type="secondary" style={{ fontSize: '12px' }}>音量:</Text>
          <Slider
            value={volume}
            onChange={setVolume}
            min={0}
            max={100}
            style={{ width: 80 }}
            disabled={!audioUrl || hasError}
          />
          <Text type="secondary" style={{ fontSize: '12px', minWidth: '30px' }}>
            {volume}%
          </Text>
        </div>
      </div>
    </Card>
  );
};

export default AudioControls;