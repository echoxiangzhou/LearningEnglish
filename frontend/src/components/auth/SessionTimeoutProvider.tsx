/**
 * Session Timeout Provider
 * 
 * Provides session timeout functionality to the entire application
 */

import React, { useState, useCallback } from 'react';
import { useDispatch } from 'react-redux';
import { useSessionTimeout } from '../../hooks/useSessionTimeout';
import { SessionTimeoutModal } from './SessionTimeoutModal';
import { logoutAsync } from '../../store/slices/authSlice';

interface SessionTimeoutProviderProps {
  children: React.ReactNode;
  timeoutMinutes?: number;
  warningMinutes?: number;
}

export const SessionTimeoutProvider: React.FC<SessionTimeoutProviderProps> = ({
  children,
  timeoutMinutes = 30,
  warningMinutes = 5
}) => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const dispatch = useDispatch();

  const handleWarning = useCallback(() => {
    console.log('Session timeout warning - showing modal');
    setIsModalOpen(true);
  }, []);

  const handleTimeout = useCallback(() => {
    console.log('Session timeout - modal will trigger logout');
    setIsModalOpen(false);
  }, []);

  const handleExtend = useCallback(() => {
    console.log('Session extended by user');
    setIsModalOpen(false);
  }, []);

  const {
    timeUntilTimeout,
    isWarningActive,
    extendSession
  } = useSessionTimeout({
    timeoutMinutes,
    warningMinutes,
    onWarning: handleWarning,
    onTimeout: handleTimeout,
    onExtend: handleExtend
  });

  const handleExtendSession = useCallback(() => {
    extendSession();
    setIsModalOpen(false);
  }, [extendSession]);

  const handleLogout = useCallback(async () => {
    setIsModalOpen(false);
    try {
      await dispatch(logoutAsync()).unwrap();
    } catch (error) {
      console.error('Error during manual logout:', error);
    }
  }, [dispatch]);

  // Show warning time (typically the last 5 minutes)
  const warningTimeRemaining = timeUntilTimeout;

  return (
    <>
      {children}
      
      <SessionTimeoutModal
        isOpen={isModalOpen && isWarningActive}
        timeRemaining={warningTimeRemaining}
        onExtendSession={handleExtendSession}
        onLogout={handleLogout}
      />
    </>
  );
};