/**
 * useLoading Hook
 * 
 * Custom hook for managing loading states across components
 */

import { useState, useCallback, useRef } from 'react';
import { errorService } from '../services/errorService';

interface LoadingState {
  [key: string]: boolean;
}

interface UseLoadingOptions {
  initialState?: LoadingState;
  onError?: (error: any, context?: string) => void;
}

export const useLoading = (options: UseLoadingOptions = {}) => {
  const { initialState = {}, onError } = options;
  const [loadingStates, setLoadingStates] = useState<LoadingState>(initialState);
  const abortControllersRef = useRef<Map<string, AbortController>>(new Map());

  // Set loading state for a specific key
  const setLoading = useCallback((key: string, isLoading: boolean) => {
    setLoadingStates(prev => ({
      ...prev,
      [key]: isLoading,
    }));

    // Clean up abort controller when loading stops
    if (!isLoading) {
      const controller = abortControllersRef.current.get(key);
      if (controller) {
        controller.abort();
        abortControllersRef.current.delete(key);
      }
    }
  }, []);

  // Get loading state for a specific key
  const isLoading = useCallback((key: string): boolean => {
    return loadingStates[key] || false;
  }, [loadingStates]);

  // Check if any loading state is active
  const isAnyLoading = useCallback((): boolean => {
    return Object.values(loadingStates).some(Boolean);
  }, [loadingStates]);

  // Get all active loading keys
  const getLoadingKeys = useCallback((): string[] => {
    return Object.keys(loadingStates).filter(key => loadingStates[key]);
  }, [loadingStates]);

  // Wrap an async operation with loading state management
  const withLoading = useCallback(async <T>(
    key: string,
    operation: (abortSignal?: AbortSignal) => Promise<T>,
    context?: string
  ): Promise<T | null> => {
    try {
      setLoading(key, true);

      // Create abort controller for this operation
      const abortController = new AbortController();
      abortControllersRef.current.set(key, abortController);

      const result = await operation(abortController.signal);
      return result;
    } catch (error) {
      // Don't handle abort errors as actual errors
      if (error instanceof Error && error.name === 'AbortError') {
        return null;
      }

      // Handle the error
      if (onError) {
        onError(error, context);
      } else {
        errorService.handleError(error, context || `Loading operation: ${key}`);
      }
      return null;
    } finally {
      setLoading(key, false);
    }
  }, [setLoading, onError]);

  // Cancel a specific loading operation
  const cancelLoading = useCallback((key: string) => {
    const controller = abortControllersRef.current.get(key);
    if (controller) {
      controller.abort();
      abortControllersRef.current.delete(key);
    }
    setLoading(key, false);
  }, [setLoading]);

  // Cancel all loading operations
  const cancelAllLoading = useCallback(() => {
    abortControllersRef.current.forEach(controller => {
      controller.abort();
    });
    abortControllersRef.current.clear();
    setLoadingStates({});
  }, []);

  // Reset all loading states
  const resetLoading = useCallback(() => {
    cancelAllLoading();
    setLoadingStates(initialState);
  }, [cancelAllLoading, initialState]);

  return {
    loadingStates,
    setLoading,
    isLoading,
    isAnyLoading,
    getLoadingKeys,
    withLoading,
    cancelLoading,
    cancelAllLoading,
    resetLoading,
  };
};

// Hook for managing a single loading state
export const useSingleLoading = (initialLoading = false) => {
  const [isLoading, setIsLoading] = useState(initialLoading);
  const abortControllerRef = useRef<AbortController | null>(null);

  const withLoading = useCallback(async <T>(
    operation: (abortSignal?: AbortSignal) => Promise<T>,
    context?: string
  ): Promise<T | null> => {
    try {
      setIsLoading(true);

      // Create abort controller
      const abortController = new AbortController();
      abortControllerRef.current = abortController;

      const result = await operation(abortController.signal);
      return result;
    } catch (error) {
      // Don't handle abort errors as actual errors
      if (error instanceof Error && error.name === 'AbortError') {
        return null;
      }

      errorService.handleError(error, context || 'Loading operation');
      return null;
    } finally {
      setIsLoading(false);
      abortControllerRef.current = null;
    }
  }, []);

  const cancel = useCallback(() => {
    if (abortControllerRef.current) {
      abortControllerRef.current.abort();
      abortControllerRef.current = null;
    }
    setIsLoading(false);
  }, []);

  return {
    isLoading,
    setIsLoading,
    withLoading,
    cancel,
  };
};

// Hook for managing progress loading
export const useProgressLoading = () => {
  const [progress, setProgress] = useState(0);
  const [message, setMessage] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const startProgress = useCallback((initialMessage = '开始处理...') => {
    setIsLoading(true);
    setProgress(0);
    setMessage(initialMessage);
  }, []);

  const updateProgress = useCallback((newProgress: number, newMessage?: string) => {
    setProgress(Math.min(100, Math.max(0, newProgress)));
    if (newMessage !== undefined) {
      setMessage(newMessage);
    }
  }, []);

  const completeProgress = useCallback((completionMessage = '完成') => {
    setProgress(100);
    setMessage(completionMessage);
    
    // Auto-hide after completion
    setTimeout(() => {
      setIsLoading(false);
      setProgress(0);
      setMessage('');
    }, 1000);
  }, []);

  const cancelProgress = useCallback(() => {
    setIsLoading(false);
    setProgress(0);
    setMessage('');
  }, []);

  return {
    isLoading,
    progress,
    message,
    startProgress,
    updateProgress,
    completeProgress,
    cancelProgress,
  };
};

// Hook for managing multiple async operations with loading states
export const useAsyncOperations = () => {
  const [operations, setOperations] = useState<Record<string, {
    loading: boolean;
    error: any;
    data: any;
  }>>({});

  const executeOperation = useCallback(async <T>(
    key: string,
    operation: () => Promise<T>,
    context?: string
  ): Promise<T | null> => {
    try {
      setOperations(prev => ({
        ...prev,
        [key]: { loading: true, error: null, data: null },
      }));

      const result = await operation();
      
      setOperations(prev => ({
        ...prev,
        [key]: { loading: false, error: null, data: result },
      }));

      return result;
    } catch (error) {
      setOperations(prev => ({
        ...prev,
        [key]: { loading: false, error, data: null },
      }));

      errorService.handleError(error, context || `Async operation: ${key}`);
      return null;
    }
  }, []);

  const getOperationState = useCallback((key: string) => {
    return operations[key] || { loading: false, error: null, data: null };
  }, [operations]);

  const clearOperation = useCallback((key: string) => {
    setOperations(prev => {
      const newState = { ...prev };
      delete newState[key];
      return newState;
    });
  }, []);

  const clearAllOperations = useCallback(() => {
    setOperations({});
  }, []);

  return {
    operations,
    executeOperation,
    getOperationState,
    clearOperation,
    clearAllOperations,
  };
};