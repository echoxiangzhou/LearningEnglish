/**
 * useResponsive Hook
 * 
 * React hook for responsive design and mobile optimization
 */

import { useState, useEffect, useCallback, useMemo } from 'react';
import { 
  getScreenInfo, 
  ResponsiveUtils, 
  isBreakpoint, 
  isBreakpointUp, 
  isBreakpointDown,
  isMobileDevice,
  isTouchDevice,
  type ScreenInfo,
  type BreakpointKey,
  type DeviceType 
} from '../utils/responsive';

/**
 * Main responsive hook
 */
export const useResponsive = () => {
  const [screenInfo, setScreenInfo] = useState<ScreenInfo>(() => getScreenInfo());

  useEffect(() => {
    const handleScreenChange = (info: ScreenInfo) => {
      setScreenInfo(info);
    };

    ResponsiveUtils.addListener('useResponsive', handleScreenChange);

    return () => {
      ResponsiveUtils.removeListener('useResponsive');
    };
  }, []);

  const helpers = useMemo(() => ({
    // Breakpoint checks
    isXs: isBreakpoint('xs', screenInfo.width),
    isSm: isBreakpoint('sm', screenInfo.width),
    isMd: isBreakpoint('md', screenInfo.width),
    isLg: isBreakpoint('lg', screenInfo.width),
    isXl: isBreakpoint('xl', screenInfo.width),
    isXxl: isBreakpoint('xxl', screenInfo.width),

    // Breakpoint up checks
    isSmUp: isBreakpointUp('sm', screenInfo.width),
    isMdUp: isBreakpointUp('md', screenInfo.width),
    isLgUp: isBreakpointUp('lg', screenInfo.width),
    isXlUp: isBreakpointUp('xl', screenInfo.width),
    isXxlUp: isBreakpointUp('xxl', screenInfo.width),

    // Breakpoint down checks
    isXsDown: isBreakpointDown('sm', screenInfo.width),
    isSmDown: isBreakpointDown('md', screenInfo.width),
    isMdDown: isBreakpointDown('lg', screenInfo.width),
    isLgDown: isBreakpointDown('xl', screenInfo.width),
    isXlDown: isBreakpointDown('xxl', screenInfo.width),

    // Device detection
    isMobileDevice: isMobileDevice(),
    isTouchDevice: isTouchDevice(),
  }), [screenInfo.width]);

  return {
    ...screenInfo,
    ...helpers,
  };
};

/**
 * Hook for breakpoint-specific values
 */
export const useBreakpointValue = <T>(values: Partial<Record<BreakpointKey, T>>, defaultValue: T): T => {
  const { breakpoint } = useResponsive();

  return useMemo(() => {
    // Try current breakpoint first
    if (values[breakpoint] !== undefined) {
      return values[breakpoint]!;
    }

    // Fall back to smaller breakpoints
    const breakpointOrder: BreakpointKey[] = ['xxl', 'xl', 'lg', 'md', 'sm', 'xs'];
    const currentIndex = breakpointOrder.indexOf(breakpoint);

    for (let i = currentIndex + 1; i < breakpointOrder.length; i++) {
      const bp = breakpointOrder[i];
      if (values[bp] !== undefined) {
        return values[bp]!;
      }
    }

    return defaultValue;
  }, [values, breakpoint, defaultValue]);
};

/**
 * Hook for device-specific values
 */
export const useDeviceValue = <T>(values: Partial<Record<DeviceType, T>>, defaultValue: T): T => {
  const { deviceType } = useResponsive();

  return useMemo(() => {
    return values[deviceType] ?? defaultValue;
  }, [values, deviceType, defaultValue]);
};

/**
 * Hook for orientation-specific behavior
 */
export const useOrientation = () => {
  const { orientation, width, height } = useResponsive();

  const isPortrait = orientation === 'portrait';
  const isLandscape = orientation === 'landscape';

  return {
    orientation,
    isPortrait,
    isLandscape,
    width,
    height,
    aspectRatio: width / height,
  };
};

/**
 * Hook for mobile-specific behavior
 */
export const useMobile = () => {
  const responsive = useResponsive();

  const isMobile = responsive.isMobile || responsive.isXsDown;
  const isTablet = responsive.isTablet;
  const isDesktop = responsive.isDesktop;
  const isTouchDevice = responsive.isTouchDevice;

  return {
    isMobile,
    isTablet,
    isDesktop,
    isTouchDevice,
    isPortrait: responsive.orientation === 'portrait',
    isLandscape: responsive.orientation === 'landscape',
    screenWidth: responsive.width,
    screenHeight: responsive.height,
  };
};

/**
 * Hook for responsive grid columns
 */
export const useResponsiveColumns = (config: {
  xs?: number;
  sm?: number;
  md?: number;
  lg?: number;
  xl?: number;
  xxl?: number;
}) => {
  const { breakpoint } = useResponsive();

  return useMemo(() => {
    const breakpointOrder: BreakpointKey[] = ['xs', 'sm', 'md', 'lg', 'xl', 'xxl'];
    const currentIndex = breakpointOrder.indexOf(breakpoint);

    // Find the appropriate column value
    for (let i = currentIndex; i >= 0; i--) {
      const bp = breakpointOrder[i];
      if (config[bp] !== undefined) {
        return config[bp]!;
      }
    }

    return 24; // Default full width
  }, [config, breakpoint]);
};

/**
 * Hook for responsive font sizes
 */
export const useResponsiveFontSize = (baseFontSize: number) => {
  const { deviceType, width } = useResponsive();

  return useMemo(() => {
    let scale = 1;

    if (deviceType === 'mobile') {
      scale = 0.9;
    } else if (deviceType === 'desktop' && width > 1200) {
      scale = 1.1;
    }

    return Math.round(baseFontSize * scale);
  }, [baseFontSize, deviceType, width]);
};

/**
 * Hook for responsive spacing
 */
export const useResponsiveSpacing = (baseSpacing: number) => {
  const { deviceType } = useResponsive();

  return useMemo(() => {
    switch (deviceType) {
      case 'mobile':
        return Math.round(baseSpacing * 0.75);
      case 'tablet':
        return baseSpacing;
      case 'desktop':
        return Math.round(baseSpacing * 1.25);
      default:
        return baseSpacing;
    }
  }, [baseSpacing, deviceType]);
};

/**
 * Hook for viewport dimensions with safe area
 */
export const useViewport = () => {
  const [dimensions, setDimensions] = useState(() => ({
    width: window.innerWidth,
    height: window.innerHeight,
    visualHeight: window.visualViewport?.height || window.innerHeight,
  }));

  useEffect(() => {
    const updateDimensions = () => {
      setDimensions({
        width: window.innerWidth,
        height: window.innerHeight,
        visualHeight: window.visualViewport?.height || window.innerHeight,
      });
    };

    window.addEventListener('resize', updateDimensions);
    window.visualViewport?.addEventListener('resize', updateDimensions);

    return () => {
      window.removeEventListener('resize', updateDimensions);
      window.visualViewport?.removeEventListener('resize', updateDimensions);
    };
  }, []);

  return dimensions;
};

/**
 * Hook for responsive component visibility
 */
export const useResponsiveVisibility = (config: {
  hideOn?: BreakpointKey[];
  showOn?: BreakpointKey[];
  hideOnMobile?: boolean;
  hideOnTablet?: boolean;
  hideOnDesktop?: boolean;
}) => {
  const { breakpoint, deviceType } = useResponsive();

  return useMemo(() => {
    const { hideOn, showOn, hideOnMobile, hideOnTablet, hideOnDesktop } = config;

    // Check device-specific hiding
    if (hideOnMobile && deviceType === 'mobile') return false;
    if (hideOnTablet && deviceType === 'tablet') return false;
    if (hideOnDesktop && deviceType === 'desktop') return false;

    // Check breakpoint-specific hiding
    if (hideOn && hideOn.includes(breakpoint)) return false;
    if (showOn && !showOn.includes(breakpoint)) return false;

    return true;
  }, [breakpoint, deviceType, config]);
};

/**
 * Hook for responsive media queries
 */
export const useMediaQuery = (query: string): boolean => {
  const [matches, setMatches] = useState(() => {
    if (typeof window !== 'undefined') {
      return window.matchMedia(query).matches;
    }
    return false;
  });

  useEffect(() => {
    if (typeof window === 'undefined') return;

    const mediaQuery = window.matchMedia(query);
    const handler = (event: MediaQueryListEvent) => {
      setMatches(event.matches);
    };

    mediaQuery.addEventListener('change', handler);
    setMatches(mediaQuery.matches);

    return () => {
      mediaQuery.removeEventListener('change', handler);
    };
  }, [query]);

  return matches;
};

/**
 * Hook for responsive container queries
 */
export const useContainerQuery = (
  containerRef: React.RefObject<HTMLElement>,
  query: string
): boolean => {
  const [matches, setMatches] = useState(false);

  useEffect(() => {
    if (!containerRef.current || typeof ResizeObserver === 'undefined') {
      return;
    }

    const element = containerRef.current;
    let resizeObserver: ResizeObserver;

    const checkQuery = () => {
      if (!element) return;

      const { width, height } = element.getBoundingClientRect();
      
      // Simple container query parsing
      const widthMatch = query.match(/\(width\s*([<>]=?)\s*(\d+)px\)/);
      const heightMatch = query.match(/\(height\s*([<>]=?)\s*(\d+)px\)/);

      let result = true;

      if (widthMatch) {
        const [, operator, value] = widthMatch;
        const targetWidth = parseInt(value);
        
        switch (operator) {
          case '>':
            result = result && width > targetWidth;
            break;
          case '>=':
            result = result && width >= targetWidth;
            break;
          case '<':
            result = result && width < targetWidth;
            break;
          case '<=':
            result = result && width <= targetWidth;
            break;
        }
      }

      if (heightMatch) {
        const [, operator, value] = heightMatch;
        const targetHeight = parseInt(value);
        
        switch (operator) {
          case '>':
            result = result && height > targetHeight;
            break;
          case '>=':
            result = result && height >= targetHeight;
            break;
          case '<':
            result = result && height < targetHeight;
            break;
          case '<=':
            result = result && height <= targetHeight;
            break;
        }
      }

      setMatches(result);
    };

    resizeObserver = new ResizeObserver(checkQuery);
    resizeObserver.observe(element);
    checkQuery(); // Initial check

    return () => {
      if (resizeObserver) {
        resizeObserver.disconnect();
      }
    };
  }, [containerRef, query]);

  return matches;
};