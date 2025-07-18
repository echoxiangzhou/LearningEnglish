/**
 * useAccessibility Hook
 * 
 * React hook for accessibility features
 */

import { useEffect, useRef, useCallback } from 'react';
import { 
  FocusManager, 
  ScreenReaderUtils, 
  KeyboardNavigationManager,
  KEYBOARD_KEYS,
  ARIA_LABELS 
} from '../utils/accessibility';

interface UseAccessibilityOptions {
  announceOnMount?: string;
  trapFocus?: boolean;
  returnFocusOnUnmount?: boolean;
  skipLinks?: boolean;
}

export const useAccessibility = (options: UseAccessibilityOptions = {}) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const focusManager = FocusManager.getInstance();
  const cleanupRef = useRef<(() => void) | null>(null);

  // Announce message when component mounts
  useEffect(() => {
    if (options.announceOnMount) {
      ScreenReaderUtils.announce(options.announceOnMount);
    }
  }, [options.announceOnMount]);

  // Handle focus trapping
  useEffect(() => {
    if (options.trapFocus && containerRef.current) {
      cleanupRef.current = focusManager.trapFocus(containerRef.current);
    }

    return () => {
      if (cleanupRef.current) {
        cleanupRef.current();
      }
      if (options.returnFocusOnUnmount) {
        focusManager.returnToPrevious();
      }
    };
  }, [options.trapFocus, options.returnFocusOnUnmount]);

  const announce = useCallback((message: string, priority: 'polite' | 'assertive' = 'polite') => {
    ScreenReaderUtils.announce(message, priority);
  }, []);

  const setFocus = useCallback((element: HTMLElement, saveReturn = true) => {
    focusManager.setFocus(element, saveReturn);
  }, []);

  const returnFocus = useCallback(() => {
    focusManager.returnToPrevious();
  }, []);

  return {
    containerRef,
    announce,
    setFocus,
    returnFocus,
    focusManager,
  };
};

// Hook for keyboard navigation
export const useKeyboardNavigation = (
  items: HTMLElement[],
  orientation: 'horizontal' | 'vertical' = 'vertical'
) => {
  const currentIndexRef = useRef(0);

  const handleKeyDown = useCallback((event: KeyboardEvent) => {
    KeyboardNavigationManager.handleListNavigation(
      event,
      items,
      currentIndexRef.current,
      (newIndex) => {
        currentIndexRef.current = newIndex;
      },
      orientation
    );
  }, [items, orientation]);

  const setCurrentIndex = useCallback((index: number) => {
    currentIndexRef.current = Math.max(0, Math.min(index, items.length - 1));
  }, [items.length]);

  return {
    currentIndex: currentIndexRef.current,
    setCurrentIndex,
    handleKeyDown,
  };
};

// Hook for menu navigation
export const useMenuNavigation = () => {
  const menuRef = useRef<HTMLDivElement>(null);
  const currentIndexRef = useRef(0);
  const isOpenRef = useRef(false);

  const open = useCallback(() => {
    isOpenRef.current = true;
    currentIndexRef.current = 0;
  }, []);

  const close = useCallback(() => {
    isOpenRef.current = false;
  }, []);

  const handleKeyDown = useCallback((
    event: KeyboardEvent,
    menuItems: HTMLElement[],
    onSelect: (index: number) => void
  ) => {
    if (!isOpenRef.current) return;

    KeyboardNavigationManager.handleMenuNavigation(
      event,
      menuItems,
      currentIndexRef.current,
      onSelect,
      close
    );
  }, [close]);

  return {
    menuRef,
    isOpen: isOpenRef.current,
    currentIndex: currentIndexRef.current,
    open,
    close,
    handleKeyDown,
  };
};

// Hook for skip links
export const useSkipLinks = () => {
  useEffect(() => {
    const skipLinks = document.querySelectorAll('.skip-link') as NodeListOf<HTMLAnchorElement>;
    
    skipLinks.forEach(link => {
      const handleClick = (event: MouseEvent) => {
        event.preventDefault();
        const targetId = link.getAttribute('href')?.substring(1);
        if (targetId) {
          const target = document.getElementById(targetId);
          if (target) {
            target.focus();
            target.scrollIntoView({ behavior: 'smooth' });
          }
        }
      };

      link.addEventListener('click', handleClick);
      
      // Cleanup
      return () => {
        link.removeEventListener('click', handleClick);
      };
    });
  }, []);
};

// Hook for managing ARIA states
export const useAriaState = (initialState: Record<string, any> = {}) => {
  const ariaStateRef = useRef(initialState);

  const setAriaState = useCallback((updates: Record<string, any>) => {
    ariaStateRef.current = { ...ariaStateRef.current, ...updates };
  }, []);

  const getAriaProps = useCallback(() => {
    const props: Record<string, any> = {};
    
    Object.entries(ariaStateRef.current).forEach(([key, value]) => {
      if (key.startsWith('aria-') || key === 'role') {
        props[key] = value;
      } else {
        props[`aria-${key}`] = value;
      }
    });

    return props;
  }, []);

  return {
    ariaState: ariaStateRef.current,
    setAriaState,
    getAriaProps,
  };
};

// Hook for form accessibility
export const useFormAccessibility = () => {
  const getFieldProps = useCallback((
    fieldName: string,
    options: {
      required?: boolean;
      invalid?: boolean;
      description?: string;
      errorMessage?: string;
    } = {}
  ) => {
    const props: Record<string, any> = {
      id: fieldName,
      name: fieldName,
    };

    if (options.required) {
      props['aria-required'] = true;
      props['required'] = true;
    }

    if (options.invalid) {
      props['aria-invalid'] = true;
    }

    if (options.description) {
      props['aria-describedby'] = `${fieldName}-description`;
    }

    if (options.errorMessage) {
      props['aria-describedby'] = `${fieldName}-error`;
    }

    return props;
  }, []);

  const getLabelProps = useCallback((fieldName: string) => ({
    htmlFor: fieldName,
  }), []);

  const getErrorProps = useCallback((fieldName: string) => ({
    id: `${fieldName}-error`,
    role: 'alert',
    'aria-live': 'assertive',
  }), []);

  const getDescriptionProps = useCallback((fieldName: string) => ({
    id: `${fieldName}-description`,
  }), []);

  return {
    getFieldProps,
    getLabelProps,
    getErrorProps,
    getDescriptionProps,
  };
};