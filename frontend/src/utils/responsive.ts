/**
 * Responsive Design Utilities
 * 
 * Utilities for responsive design, mobile detection, and screen size management
 */

// Breakpoint definitions (matching Ant Design's breakpoints)
export const BREAKPOINTS = {
  xs: 480,   // Extra small devices
  sm: 576,   // Small devices
  md: 768,   // Medium devices
  lg: 992,   // Large devices
  xl: 1200,  // Extra large devices
  xxl: 1600, // Extra extra large devices
} as const;

export type BreakpointKey = keyof typeof BREAKPOINTS;

// Device type definitions
export type DeviceType = 'mobile' | 'tablet' | 'desktop';

// Screen orientation
export type ScreenOrientation = 'portrait' | 'landscape';

export interface ScreenInfo {
  width: number;
  height: number;
  deviceType: DeviceType;
  orientation: ScreenOrientation;
  breakpoint: BreakpointKey;
  isMobile: boolean;
  isTablet: boolean;
  isDesktop: boolean;
  isRetina: boolean;
  aspectRatio: number;
}

/**
 * Get current screen information
 */
export const getScreenInfo = (): ScreenInfo => {
  const width = window.innerWidth;
  const height = window.innerHeight;
  const deviceType = getDeviceType(width);
  const orientation = getOrientation(width, height);
  const breakpoint = getCurrentBreakpoint(width);
  const isRetina = window.devicePixelRatio > 1;
  const aspectRatio = width / height;

  return {
    width,
    height,
    deviceType,
    orientation,
    breakpoint,
    isMobile: deviceType === 'mobile',
    isTablet: deviceType === 'tablet',
    isDesktop: deviceType === 'desktop',
    isRetina,
    aspectRatio,
  };
};

/**
 * Determine device type based on screen width
 */
export const getDeviceType = (width: number): DeviceType => {
  if (width < BREAKPOINTS.sm) return 'mobile';
  if (width < BREAKPOINTS.lg) return 'tablet';
  return 'desktop';
};

/**
 * Get screen orientation
 */
export const getOrientation = (width: number, height: number): ScreenOrientation => {
  return width > height ? 'landscape' : 'portrait';
};

/**
 * Get current breakpoint
 */
export const getCurrentBreakpoint = (width: number): BreakpointKey => {
  if (width < BREAKPOINTS.xs) return 'xs';
  if (width < BREAKPOINTS.sm) return 'xs';
  if (width < BREAKPOINTS.md) return 'sm';
  if (width < BREAKPOINTS.lg) return 'md';
  if (width < BREAKPOINTS.xl) return 'lg';
  if (width < BREAKPOINTS.xxl) return 'xl';
  return 'xxl';
};

/**
 * Check if current screen width matches a breakpoint
 */
export const isBreakpoint = (breakpoint: BreakpointKey, width?: number): boolean => {
  const currentWidth = width || window.innerWidth;
  const targetWidth = BREAKPOINTS[breakpoint];
  
  switch (breakpoint) {
    case 'xs':
      return currentWidth < BREAKPOINTS.sm;
    case 'sm':
      return currentWidth >= BREAKPOINTS.sm && currentWidth < BREAKPOINTS.md;
    case 'md':
      return currentWidth >= BREAKPOINTS.md && currentWidth < BREAKPOINTS.lg;
    case 'lg':
      return currentWidth >= BREAKPOINTS.lg && currentWidth < BREAKPOINTS.xl;
    case 'xl':
      return currentWidth >= BREAKPOINTS.xl && currentWidth < BREAKPOINTS.xxl;
    case 'xxl':
      return currentWidth >= BREAKPOINTS.xxl;
    default:
      return false;
  }
};

/**
 * Check if screen width is at least the specified breakpoint
 */
export const isBreakpointUp = (breakpoint: BreakpointKey, width?: number): boolean => {
  const currentWidth = width || window.innerWidth;
  return currentWidth >= BREAKPOINTS[breakpoint];
};

/**
 * Check if screen width is below the specified breakpoint
 */
export const isBreakpointDown = (breakpoint: BreakpointKey, width?: number): boolean => {
  const currentWidth = width || window.innerWidth;
  return currentWidth < BREAKPOINTS[breakpoint];
};

/**
 * Mobile device detection using User Agent
 */
export const isMobileDevice = (): boolean => {
  const userAgent = navigator.userAgent.toLowerCase();
  const mobileKeywords = [
    'mobile', 'android', 'iphone', 'ipad', 'ipod', 'blackberry', 
    'windows phone', 'opera mini', 'kindle', 'silk', 'fennec'
  ];
  
  return mobileKeywords.some(keyword => userAgent.includes(keyword));
};

/**
 * Touch device detection
 */
export const isTouchDevice = (): boolean => {
  return 'ontouchstart' in window || navigator.maxTouchPoints > 0;
};

/**
 * Check if device is in standalone mode (PWA)
 */
export const isStandalone = (): boolean => {
  return window.matchMedia('(display-mode: standalone)').matches ||
         (window.navigator as any).standalone === true;
};

/**
 * Get optimal image size based on screen and device pixel ratio
 */
export const getOptimalImageSize = (
  baseWidth: number,
  baseHeight: number,
  maxWidth?: number,
  maxHeight?: number
): { width: number; height: number } => {
  const { width: screenWidth, isRetina } = getScreenInfo();
  const pixelRatio = isRetina ? 2 : 1;
  
  let optimalWidth = Math.min(baseWidth * pixelRatio, maxWidth || Infinity);
  let optimalHeight = Math.min(baseHeight * pixelRatio, maxHeight || Infinity);
  
  // Scale down for mobile devices
  if (screenWidth < BREAKPOINTS.md) {
    const scale = Math.min(screenWidth / baseWidth, 1);
    optimalWidth = Math.floor(optimalWidth * scale);
    optimalHeight = Math.floor(optimalHeight * scale);
  }
  
  return { width: optimalWidth, height: optimalHeight };
};

/**
 * Generate responsive column spans for Ant Design Grid
 */
export const getResponsiveColumns = (config: {
  xs?: number;
  sm?: number;
  md?: number;
  lg?: number;
  xl?: number;
  xxl?: number;
}) => {
  return {
    xs: config.xs || 24,
    sm: config.sm || config.xs || 24,
    md: config.md || config.sm || config.xs || 12,
    lg: config.lg || config.md || config.sm || 8,
    xl: config.xl || config.lg || config.md || 6,
    xxl: config.xxl || config.xl || config.lg || 6,
  };
};

/**
 * Safe area utilities for devices with notches
 */
export const getSafeAreaInsets = () => {
  const style = getComputedStyle(document.documentElement);
  
  return {
    top: parseInt(style.getPropertyValue('--safe-area-inset-top') || '0'),
    right: parseInt(style.getPropertyValue('--safe-area-inset-right') || '0'),
    bottom: parseInt(style.getPropertyValue('--safe-area-inset-bottom') || '0'),
    left: parseInt(style.getPropertyValue('--safe-area-inset-left') || '0'),
  };
};

/**
 * Viewport height utilities (handling mobile browser toolbars)
 */
export const getViewportHeight = (type: 'visual' | 'layout' | 'dynamic' = 'visual'): number => {
  switch (type) {
    case 'visual':
      return window.visualViewport?.height || window.innerHeight;
    case 'layout':
      return window.innerHeight;
    case 'dynamic':
      // Use CSS custom property for dynamic viewport height
      const dvh = parseInt(getComputedStyle(document.documentElement)
        .getPropertyValue('--dvh') || '0');
      return dvh || window.innerHeight;
    default:
      return window.innerHeight;
  }
};

/**
 * Font size scaling based on screen size
 */
export const getScaledFontSize = (baseFontSize: number, minScale = 0.8, maxScale = 1.2): number => {
  const { width, deviceType } = getScreenInfo();
  
  let scale = 1;
  
  if (deviceType === 'mobile') {
    // Slightly smaller fonts on mobile
    scale = 0.9;
  } else if (deviceType === 'desktop' && width > BREAKPOINTS.xl) {
    // Slightly larger fonts on large screens
    scale = 1.1;
  }
  
  return Math.round(baseFontSize * Math.max(minScale, Math.min(maxScale, scale)));
};

/**
 * Container width utilities
 */
export const getContainerWidth = (
  type: 'fluid' | 'fixed' | 'breakpoint' = 'breakpoint',
  maxWidth?: number
): string => {
  const { width } = getScreenInfo();
  
  switch (type) {
    case 'fluid':
      return '100%';
    case 'fixed':
      return `${maxWidth || 1200}px`;
    case 'breakpoint':
      if (width >= BREAKPOINTS.xxl) return '1200px';
      if (width >= BREAKPOINTS.xl) return '1140px';
      if (width >= BREAKPOINTS.lg) return '960px';
      if (width >= BREAKPOINTS.md) return '720px';
      if (width >= BREAKPOINTS.sm) return '540px';
      return '100%';
    default:
      return '100%';
  }
};

/**
 * Performance utilities for responsive images
 */
export const preloadResponsiveImage = (
  srcSet: string,
  sizes?: string
): Promise<void> => {
  return new Promise((resolve, reject) => {
    const link = document.createElement('link');
    link.rel = 'preload';
    link.as = 'image';
    link.href = srcSet.split(' ')[0]; // Use first image as fallback
    if (srcSet) link.setAttribute('imagesrcset', srcSet);
    if (sizes) link.setAttribute('imagesizes', sizes);
    
    link.onload = () => resolve();
    link.onerror = reject;
    
    document.head.appendChild(link);
  });
};

/**
 * Responsive utilities class
 */
export class ResponsiveUtils {
  private static listeners: Map<string, (info: ScreenInfo) => void> = new Map();
  private static currentInfo: ScreenInfo | null = null;
  
  /**
   * Initialize responsive utilities
   */
  public static initialize(): void {
    this.updateScreenInfo();
    
    window.addEventListener('resize', this.handleResize.bind(this));
    window.addEventListener('orientationchange', this.handleOrientationChange.bind(this));
    
    // Set CSS custom properties
    this.updateCSSProperties();
  }
  
  /**
   * Add listener for screen info changes
   */
  public static addListener(key: string, callback: (info: ScreenInfo) => void): void {
    this.listeners.set(key, callback);
    
    // Call immediately with current info
    if (this.currentInfo) {
      callback(this.currentInfo);
    }
  }
  
  /**
   * Remove listener
   */
  public static removeListener(key: string): void {
    this.listeners.delete(key);
  }
  
  /**
   * Get current screen info
   */
  public static getCurrentInfo(): ScreenInfo | null {
    return this.currentInfo;
  }
  
  private static handleResize(): void {
    this.updateScreenInfo();
    this.updateCSSProperties();
    this.notifyListeners();
  }
  
  private static handleOrientationChange(): void {
    // Delay to allow orientation change to complete
    setTimeout(() => {
      this.updateScreenInfo();
      this.updateCSSProperties();
      this.notifyListeners();
    }, 100);
  }
  
  private static updateScreenInfo(): void {
    this.currentInfo = getScreenInfo();
  }
  
  private static updateCSSProperties(): void {
    if (!this.currentInfo) return;
    
    const root = document.documentElement;
    
    // Update viewport dimensions
    root.style.setProperty('--vw', `${this.currentInfo.width}px`);
    root.style.setProperty('--vh', `${this.currentInfo.height}px`);
    root.style.setProperty('--dvh', `${getViewportHeight('dynamic')}px`);
    
    // Update device type classes
    root.classList.remove('mobile', 'tablet', 'desktop');
    root.classList.add(this.currentInfo.deviceType);
    
    // Update orientation classes
    root.classList.remove('portrait', 'landscape');
    root.classList.add(this.currentInfo.orientation);
    
    // Update breakpoint classes
    Object.keys(BREAKPOINTS).forEach(bp => {
      root.classList.remove(`breakpoint-${bp}`);
    });
    root.classList.add(`breakpoint-${this.currentInfo.breakpoint}`);
  }
  
  private static notifyListeners(): void {
    if (!this.currentInfo) return;
    
    this.listeners.forEach(callback => {
      callback(this.currentInfo!);
    });
  }
}

// Initialize on module load
if (typeof window !== 'undefined') {
  ResponsiveUtils.initialize();
}