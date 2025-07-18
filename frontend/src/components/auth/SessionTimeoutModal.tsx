/**
 * Session Timeout Warning Modal
 * 
 * Shows a warning modal when user session is about to expire
 */

import React, { useState, useEffect } from 'react';
import './SessionTimeoutModal.css';

interface SessionTimeoutModalProps {
  isOpen: boolean;
  timeRemaining: number; // in milliseconds
  onExtendSession: () => void;
  onLogout: () => void;
}

export const SessionTimeoutModal: React.FC<SessionTimeoutModalProps> = ({
  isOpen,
  timeRemaining,
  onExtendSession,
  onLogout
}) => {
  const [countdown, setCountdown] = useState<number>(0);

  useEffect(() => {
    if (isOpen) {
      setCountdown(Math.ceil(timeRemaining / 1000));
      
      const interval = setInterval(() => {
        setCountdown(prev => {
          const next = prev - 1;
          if (next <= 0) {
            clearInterval(interval);
            onLogout();
            return 0;
          }
          return next;
        });
      }, 1000);

      return () => clearInterval(interval);
    }
  }, [isOpen, timeRemaining, onLogout]);

  const formatTime = (seconds: number): string => {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };

  if (!isOpen) return null;

  return (
    <div className="session-timeout-overlay">
      <div className="session-timeout-modal">
        <div className="session-timeout-icon">
          <svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path
              d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM12 20C7.59 20 4 16.41 4 12C4 7.59 7.59 4 12 4C16.41 4 20 7.59 20 12C20 16.41 16.41 20 12 20ZM12.5 7H11V13L16.25 16.15L17 14.92L12.5 12.25V7Z"
              fill="#f56565"
            />
          </svg>
        </div>
        
        <div className="session-timeout-content">
          <h2 className="session-timeout-title">会话即将过期</h2>
          <p className="session-timeout-message">
            您的登录会话将在 <strong>{formatTime(countdown)}</strong> 后过期。
            <br />
            如需继续使用，请点击"继续会话"按钮。
          </p>
          
          <div className="session-timeout-countdown">
            <div className="countdown-circle">
              <span className="countdown-text">{formatTime(countdown)}</span>
            </div>
          </div>
        </div>

        <div className="session-timeout-actions">
          <button 
            className="btn-logout"
            onClick={onLogout}
            aria-label="立即登出"
          >
            立即登出
          </button>
          <button 
            className="btn-extend"
            onClick={onExtendSession}
            aria-label="继续会话"
          >
            继续会话
          </button>
        </div>
      </div>
    </div>
  );
};