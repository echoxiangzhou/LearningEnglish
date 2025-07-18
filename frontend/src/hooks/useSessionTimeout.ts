/**
 * Session Timeout Hook
 * 
 * Manages user session timeout with activity tracking and automatic logout
 */

import { useEffect, useRef, useCallback, useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import type { RootState } from '../store/store';
import { logoutAsync } from '../store/slices/authSlice';

interface SessionTimeoutConfig {
  timeoutMinutes?: number;
  warningMinutes?: number;
  onWarning?: () => void;
  onTimeout?: () => void;
  onExtend?: () => void;
}

interface SessionTimeoutReturn {
  timeUntilTimeout: number;
  isWarningActive: boolean;
  extendSession: () => void;
  resetTimeout: () => void;
}

const DEFAULT_TIMEOUT_MINUTES = 30;
const DEFAULT_WARNING_MINUTES = 5;

export const useSessionTimeout = (config: SessionTimeoutConfig = {}): SessionTimeoutReturn => {
  const {
    timeoutMinutes = DEFAULT_TIMEOUT_MINUTES,
    warningMinutes = DEFAULT_WARNING_MINUTES,
    onWarning,
    onTimeout,
    onExtend
  } = config;

  const dispatch = useDispatch();
  const isAuthenticated = useSelector((state: RootState) => state.auth.isAuthenticated);
  
  const timeoutRef = useRef<NodeJS.Timeout | null>(null);
  const warningTimeoutRef = useRef<NodeJS.Timeout | null>(null);
  const lastActivityRef = useRef<number>(Date.now());
  
  const [isWarningActive, setIsWarningActive] = useState<boolean>(false);
  const [timeUntilTimeout, setTimeUntilTimeout] = useState<number>(timeoutMinutes * 60 * 1000);

  // Activity events to track
  const activityEvents = [
    'mousedown',
    'mousemove',
    'keypress',
    'scroll',
    'touchstart',
    'click'
  ];

  const clearTimeouts = useCallback(() => {
    if (timeoutRef.current) {
      clearTimeout(timeoutRef.current);
      timeoutRef.current = null;
    }
    if (warningTimeoutRef.current) {
      clearTimeout(warningTimeoutRef.current);
      warningTimeoutRef.current = null;
    }
  }, []);

  const handleTimeout = useCallback(async () => {
    console.log('Session timeout - logging out user');
    setIsWarningActive(false);
    
    // Call custom timeout handler if provided
    if (onTimeout) {
      onTimeout();
    }
    
    // Dispatch logout action
    try {
      await dispatch(logoutAsync()).unwrap();
    } catch (error) {
      console.error('Error during timeout logout:', error);
    }
  }, [dispatch, onTimeout]);

  const handleWarning = useCallback(() => {
    console.log('Session timeout warning triggered');
    setIsWarningActive(true);
    
    if (onWarning) {
      onWarning();
    }
  }, [onWarning]);

  const resetTimeout = useCallback(() => {
    if (!isAuthenticated) return;

    clearTimeouts();
    lastActivityRef.current = Date.now();
    setIsWarningActive(false);
    setTimeUntilTimeout(timeoutMinutes * 60 * 1000);

    // Set warning timeout
    const warningTime = (timeoutMinutes - warningMinutes) * 60 * 1000;
    if (warningTime > 0) {
      warningTimeoutRef.current = setTimeout(handleWarning, warningTime);
    }

    // Set session timeout
    timeoutRef.current = setTimeout(handleTimeout, timeoutMinutes * 60 * 1000);
  }, [isAuthenticated, timeoutMinutes, warningMinutes, handleWarning, handleTimeout, clearTimeouts]);

  const extendSession = useCallback(() => {
    console.log('Session extended by user');
    resetTimeout();
    
    if (onExtend) {
      onExtend();
    }
  }, [resetTimeout, onExtend]);

  const handleActivity = useCallback(() => {
    const now = Date.now();
    const timeSinceLastActivity = now - lastActivityRef.current;
    
    // Only reset if enough time has passed to avoid excessive resets
    if (timeSinceLastActivity > 1000) { // 1 second throttle
      resetTimeout();
    }
  }, [resetTimeout]);

  // Set up activity listeners
  useEffect(() => {
    if (!isAuthenticated) {
      clearTimeouts();
      return;
    }

    // Add activity event listeners
    activityEvents.forEach(event => {
      document.addEventListener(event, handleActivity, true);
    });

    // Initialize timeout
    resetTimeout();

    return () => {
      // Remove event listeners
      activityEvents.forEach(event => {
        document.removeEventListener(event, handleActivity, true);
      });
      clearTimeouts();
    };
  }, [isAuthenticated, handleActivity, resetTimeout, clearTimeouts]);

  // Update time until timeout every second
  useEffect(() => {
    if (!isAuthenticated) return;

    const interval = setInterval(() => {
      const now = Date.now();
      const elapsed = now - lastActivityRef.current;
      const remaining = Math.max(0, timeoutMinutes * 60 * 1000 - elapsed);
      setTimeUntilTimeout(remaining);
    }, 1000);

    return () => clearInterval(interval);
  }, [isAuthenticated, timeoutMinutes]);

  return {
    timeUntilTimeout,
    isWarningActive,
    extendSession,
    resetTimeout
  };
};