/**
 * Session Status Indicator
 * 
 * Shows remaining session time and status in the UI
 */

import React, { useState, useEffect } from 'react';
import { useSelector } from 'react-redux';
import { RootState } from '../../store/store';
import './SessionStatusIndicator.css';

interface SessionStatusIndicatorProps {
  showTimeRemaining?: boolean;
  showIcon?: boolean;
  className?: string;
}

export const SessionStatusIndicator: React.FC<SessionStatusIndicatorProps> = ({
  showTimeRemaining = true,
  showIcon = true,
  className = ''
}) => {
  const isAuthenticated = useSelector((state: RootState) => state.auth.isAuthenticated);
  const [timeRemaining, setTimeRemaining] = useState<number>(0);
  const [lastActivity, setLastActivity] = useState<number>(Date.now());

  // Default session timeout (should match the provider settings)
  const SESSION_TIMEOUT_MS = 30 * 60 * 1000; // 30 minutes
  const WARNING_THRESHOLD_MS = 5 * 60 * 1000; // 5 minutes

  useEffect(() => {
    if (!isAuthenticated) return;

    const updateTimer = () => {
      const now = Date.now();
      const elapsed = now - lastActivity;
      const remaining = Math.max(0, SESSION_TIMEOUT_MS - elapsed);
      setTimeRemaining(remaining);
    };

    // Update immediately
    updateTimer();

    // Update every second
    const interval = setInterval(updateTimer, 1000);

    return () => clearInterval(interval);
  }, [isAuthenticated, lastActivity]);

  // Track user activity to update last activity time
  useEffect(() => {
    if (!isAuthenticated) return;

    const handleActivity = () => {
      setLastActivity(Date.now());
    };

    const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart', 'click'];
    
    events.forEach(event => {
      document.addEventListener(event, handleActivity, true);
    });

    return () => {
      events.forEach(event => {
        document.removeEventListener(event, handleActivity, true);
      });
    };
  }, [isAuthenticated]);

  if (!isAuthenticated) return null;

  const formatTime = (ms: number): string => {
    const totalSeconds = Math.floor(ms / 1000);
    const minutes = Math.floor(totalSeconds / 60);
    const seconds = totalSeconds % 60;
    return `${minutes}:${seconds.toString().padStart(2, '0')}`;
  };

  const getStatusColor = (): string => {
    if (timeRemaining <= WARNING_THRESHOLD_MS) return 'warning';
    if (timeRemaining <= WARNING_THRESHOLD_MS * 2) return 'caution';
    return 'normal';
  };

  const statusColor = getStatusColor();

  return (
    <div className={`session-status-indicator ${statusColor} ${className}`}>
      {showIcon && (
        <div className="session-status-icon">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM12 20C7.59 20 4 16.41 4 12C4 7.59 7.59 4 12 4C16.41 4 20 7.59 20 12C20 16.41 16.41 20 12 20ZM12.5 7H11V13L16.25 16.15L17 14.92L12.5 12.25V7Z" />
          </svg>
        </div>
      )}
      
      {showTimeRemaining && (
        <span className="session-time-remaining" title="剩余会话时间">
          {formatTime(timeRemaining)}
        </span>
      )}
    </div>
  );
};