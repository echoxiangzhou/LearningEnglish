/**
 * Accessibility Provider Component
 * 
 * Provides accessibility context and utilities to the entire application
 */

import React, { createContext, useContext, useEffect, useState } from 'react';
import { ScreenReaderUtils } from '../../utils/accessibility';
import SkipLinks from './SkipLinks';

interface AccessibilitySettings {
  reducedMotion: boolean;
  highContrast: boolean;
  fontSize: 'small' | 'medium' | 'large';
  screenReaderOptimized: boolean;
  keyboardNavigationEnabled: boolean;
}

interface AccessibilityContextType {
  settings: AccessibilitySettings;
  updateSettings: (newSettings: Partial<AccessibilitySettings>) => void;
  announce: (message: string, priority?: 'polite' | 'assertive') => void;
}

const AccessibilityContext = createContext<AccessibilityContextType | undefined>(undefined);

interface AccessibilityProviderProps {
  children: React.ReactNode;
}

export const AccessibilityProvider: React.FC<AccessibilityProviderProps> = ({ children }) => {
  const [settings, setSettings] = useState<AccessibilitySettings>({
    reducedMotion: false,
    highContrast: false,
    fontSize: 'medium',
    screenReaderOptimized: false,
    keyboardNavigationEnabled: true,
  });

  // Detect user preferences on mount
  useEffect(() => {
    const detectPreferences = () => {
      const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
      const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
      const prefersHighContrast = window.matchMedia('(prefers-contrast: high)').matches;

      setSettings(prev => ({
        ...prev,
        reducedMotion: prefersReducedMotion,
        highContrast: prefersHighContrast,
      }));

      // Apply CSS classes based on preferences
      document.documentElement.classList.toggle('reduced-motion', prefersReducedMotion);
      document.documentElement.classList.toggle('high-contrast', prefersHighContrast);
    };

    detectPreferences();

    // Listen for preference changes
    const darkModeQuery = window.matchMedia('(prefers-color-scheme: dark)');
    const motionQuery = window.matchMedia('(prefers-reduced-motion: reduce)');
    const contrastQuery = window.matchMedia('(prefers-contrast: high)');

    const handleDarkModeChange = () => detectPreferences();
    const handleMotionChange = () => detectPreferences();
    const handleContrastChange = () => detectPreferences();

    darkModeQuery.addEventListener('change', handleDarkModeChange);
    motionQuery.addEventListener('change', handleMotionChange);
    contrastQuery.addEventListener('change', handleContrastChange);

    return () => {
      darkModeQuery.removeEventListener('change', handleDarkModeChange);
      motionQuery.removeEventListener('change', handleMotionChange);
      contrastQuery.removeEventListener('change', handleContrastChange);
    };
  }, []);

  // Apply font size changes
  useEffect(() => {
    const root = document.documentElement;
    root.classList.remove('font-small', 'font-medium', 'font-large');
    root.classList.add(`font-${settings.fontSize}`);
  }, [settings.fontSize]);

  // Apply other accessibility settings
  useEffect(() => {
    const root = document.documentElement;
    
    root.classList.toggle('screen-reader-optimized', settings.screenReaderOptimized);
    root.classList.toggle('keyboard-navigation-enabled', settings.keyboardNavigationEnabled);
  }, [settings.screenReaderOptimized, settings.keyboardNavigationEnabled]);

  const updateSettings = (newSettings: Partial<AccessibilitySettings>) => {
    setSettings(prev => ({ ...prev, ...newSettings }));
  };

  const announce = (message: string, priority: 'polite' | 'assertive' = 'polite') => {
    ScreenReaderUtils.announce(message, priority);
  };

  // Add global keyboard event listeners
  useEffect(() => {
    if (!settings.keyboardNavigationEnabled) return;

    const handleGlobalKeyDown = (event: KeyboardEvent) => {
      // Handle global shortcuts
      if (event.altKey) {
        switch (event.key) {
          case '1':
            // Skip to main content
            event.preventDefault();
            const mainContent = document.getElementById('main-content');
            if (mainContent) {
              mainContent.focus();
              mainContent.scrollIntoView({ behavior: 'smooth' });
            }
            break;
          case '2':
            // Skip to navigation
            event.preventDefault();
            const navigation = document.getElementById('main-navigation');
            if (navigation) {
              navigation.focus();
              navigation.scrollIntoView({ behavior: 'smooth' });
            }
            break;
          case '3':
            // Skip to sidebar
            event.preventDefault();
            const sidebar = document.getElementById('sidebar');
            if (sidebar) {
              sidebar.focus();
              sidebar.scrollIntoView({ behavior: 'smooth' });
            }
            break;
        }
      }

      // Handle Escape key globally
      if (event.key === 'Escape') {
        // Close any open modals or dropdowns
        const openModals = document.querySelectorAll('[role="dialog"][aria-hidden="false"]');
        openModals.forEach(modal => {
          const closeButton = modal.querySelector('[aria-label="Close"], [data-dismiss="modal"]');
          if (closeButton instanceof HTMLElement) {
            closeButton.click();
          }
        });
      }
    };

    document.addEventListener('keydown', handleGlobalKeyDown);
    return () => document.removeEventListener('keydown', handleGlobalKeyDown);
  }, [settings.keyboardNavigationEnabled]);

  const contextValue: AccessibilityContextType = {
    settings,
    updateSettings,
    announce,
  };

  return (
    <AccessibilityContext.Provider value={contextValue}>
      <SkipLinks />
      {children}
    </AccessibilityContext.Provider>
  );
};

export const useAccessibilityContext = () => {
  const context = useContext(AccessibilityContext);
  if (context === undefined) {
    throw new Error('useAccessibilityContext must be used within an AccessibilityProvider');
  }
  return context;
};

export default AccessibilityProvider;