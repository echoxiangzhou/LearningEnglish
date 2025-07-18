/**
 * Accessibility Utilities
 * 
 * Utilities for improving accessibility across the application
 */

// Keyboard navigation constants
export const KEYBOARD_KEYS = {
  ENTER: 'Enter',
  SPACE: ' ',
  ESCAPE: 'Escape',
  TAB: 'Tab',
  ARROW_UP: 'ArrowUp',
  ARROW_DOWN: 'ArrowDown',
  ARROW_LEFT: 'ArrowLeft',
  ARROW_RIGHT: 'ArrowRight',
  HOME: 'Home',
  END: 'End',
  PAGE_UP: 'PageUp',
  PAGE_DOWN: 'PageDown',
} as const;

// ARIA labels and descriptions
export const ARIA_LABELS = {
  // Navigation
  MAIN_NAVIGATION: '主导航',
  BREADCRUMB_NAVIGATION: '面包屑导航',
  USER_MENU: '用户菜单',
  SIDEBAR_TOGGLE: '切换侧边栏',
  
  // Learning modules
  DICTATION_PRACTICE: '听写练习',
  VOCABULARY_LEARNING: '词汇学习',
  READING_COMPREHENSION: '阅读理解',
  
  // Audio controls
  PLAY_AUDIO: '播放音频',
  PAUSE_AUDIO: '暂停音频',
  AUDIO_SPEED: '调整播放速度',
  AUDIO_VOLUME: '调整音量',
  
  // Form elements
  REQUIRED_FIELD: '必填字段',
  PASSWORD_FIELD: '密码字段',
  EMAIL_FIELD: '邮箱地址字段',
  
  // Interactive elements
  BUTTON: '按钮',
  LINK: '链接',
  MENU_ITEM: '菜单项',
  TAB: '标签页',
  
  // Status and feedback
  LOADING: '正在加载',
  ERROR: '错误',
  SUCCESS: '成功',
  WARNING: '警告',
  INFO: '信息',
} as const;

// Focus management utilities
export class FocusManager {
  private static instance: FocusManager;
  private focusStack: HTMLElement[] = [];
  private returnFocus: HTMLElement | null = null;

  public static getInstance(): FocusManager {
    if (!FocusManager.instance) {
      FocusManager.instance = new FocusManager();
    }
    return FocusManager.instance;
  }

  /**
   * Save current focus and set focus to new element
   */
  public setFocus(element: HTMLElement, saveReturn = true): void {
    if (saveReturn && document.activeElement instanceof HTMLElement) {
      this.returnFocus = document.activeElement;
    }
    
    element.focus();
    this.focusStack.push(element);
  }

  /**
   * Return focus to previously focused element
   */
  public returnToPrevious(): void {
    if (this.returnFocus) {
      this.returnFocus.focus();
      this.returnFocus = null;
    }
  }

  /**
   * Trap focus within a container element
   */
  public trapFocus(container: HTMLElement): () => void {
    const focusableElements = this.getFocusableElements(container);
    if (focusableElements.length === 0) return () => {};

    const firstElement = focusableElements[0];
    const lastElement = focusableElements[focusableElements.length - 1];

    const handleKeyDown = (event: KeyboardEvent) => {
      if (event.key !== KEYBOARD_KEYS.TAB) return;

      if (event.shiftKey) {
        // Shift + Tab
        if (document.activeElement === firstElement) {
          event.preventDefault();
          lastElement.focus();
        }
      } else {
        // Tab
        if (document.activeElement === lastElement) {
          event.preventDefault();
          firstElement.focus();
        }
      }
    };

    container.addEventListener('keydown', handleKeyDown);
    firstElement.focus();

    // Return cleanup function
    return () => {
      container.removeEventListener('keydown', handleKeyDown);
    };
  }

  /**
   * Get all focusable elements within a container
   */
  public getFocusableElements(container: HTMLElement): HTMLElement[] {
    const focusableSelectors = [
      'button:not([disabled])',
      'input:not([disabled])',
      'select:not([disabled])',
      'textarea:not([disabled])',
      'a[href]',
      'area[href]',
      '[tabindex]:not([tabindex="-1"])',
      '[contenteditable="true"]',
    ].join(',');

    const elements = container.querySelectorAll(focusableSelectors);
    return Array.from(elements) as HTMLElement[];
  }

  /**
   * Check if element is visible and focusable
   */
  public isFocusable(element: HTMLElement): boolean {
    const style = window.getComputedStyle(element);
    return (
      style.display !== 'none' &&
      style.visibility !== 'hidden' &&
      !element.hasAttribute('disabled') &&
      element.tabIndex !== -1
    );
  }
}

// Screen reader utilities
export class ScreenReaderUtils {
  private static liveRegion: HTMLElement | null = null;

  /**
   * Initialize screen reader utilities
   */
  public static initialize(): void {
    this.createLiveRegion();
  }

  /**
   * Announce message to screen readers
   */
  public static announce(message: string, priority: 'polite' | 'assertive' = 'polite'): void {
    if (!this.liveRegion) {
      this.createLiveRegion();
    }

    if (this.liveRegion) {
      this.liveRegion.setAttribute('aria-live', priority);
      this.liveRegion.textContent = message;

      // Clear after announcement
      setTimeout(() => {
        if (this.liveRegion) {
          this.liveRegion.textContent = '';
        }
      }, 1000);
    }
  }

  /**
   * Create invisible live region for announcements
   */
  private static createLiveRegion(): void {
    this.liveRegion = document.createElement('div');
    this.liveRegion.setAttribute('aria-live', 'polite');
    this.liveRegion.setAttribute('aria-atomic', 'true');
    this.liveRegion.className = 'sr-only';
    this.liveRegion.style.cssText = `
      position: absolute !important;
      width: 1px !important;
      height: 1px !important;
      padding: 0 !important;
      margin: -1px !important;
      overflow: hidden !important;
      clip: rect(0, 0, 0, 0) !important;
      white-space: nowrap !important;
      border: 0 !important;
    `;
    document.body.appendChild(this.liveRegion);
  }
}

// Keyboard navigation utilities
export class KeyboardNavigationManager {
  /**
   * Handle arrow key navigation for a list of elements
   */
  public static handleListNavigation(
    event: KeyboardEvent,
    elements: HTMLElement[],
    currentIndex: number,
    onIndexChange: (newIndex: number) => void,
    orientation: 'horizontal' | 'vertical' = 'vertical'
  ): void {
    let newIndex = currentIndex;

    if (orientation === 'vertical') {
      if (event.key === KEYBOARD_KEYS.ARROW_UP) {
        newIndex = currentIndex > 0 ? currentIndex - 1 : elements.length - 1;
        event.preventDefault();
      } else if (event.key === KEYBOARD_KEYS.ARROW_DOWN) {
        newIndex = currentIndex < elements.length - 1 ? currentIndex + 1 : 0;
        event.preventDefault();
      }
    } else {
      if (event.key === KEYBOARD_KEYS.ARROW_LEFT) {
        newIndex = currentIndex > 0 ? currentIndex - 1 : elements.length - 1;
        event.preventDefault();
      } else if (event.key === KEYBOARD_KEYS.ARROW_RIGHT) {
        newIndex = currentIndex < elements.length - 1 ? currentIndex + 1 : 0;
        event.preventDefault();
      }
    }

    if (event.key === KEYBOARD_KEYS.HOME) {
      newIndex = 0;
      event.preventDefault();
    } else if (event.key === KEYBOARD_KEYS.END) {
      newIndex = elements.length - 1;
      event.preventDefault();
    }

    if (newIndex !== currentIndex) {
      onIndexChange(newIndex);
      elements[newIndex]?.focus();
    }
  }

  /**
   * Handle menu navigation
   */
  public static handleMenuNavigation(
    event: KeyboardEvent,
    menuItems: HTMLElement[],
    currentIndex: number,
    onSelect: (index: number) => void,
    onClose: () => void
  ): void {
    switch (event.key) {
      case KEYBOARD_KEYS.ESCAPE:
        onClose();
        event.preventDefault();
        break;
      case KEYBOARD_KEYS.ENTER:
      case KEYBOARD_KEYS.SPACE:
        onSelect(currentIndex);
        event.preventDefault();
        break;
      default:
        this.handleListNavigation(event, menuItems, currentIndex, (newIndex) => {
          menuItems[newIndex]?.focus();
        });
    }
  }
}

// Color contrast utilities
export class ColorContrastUtils {
  /**
   * Calculate relative luminance of a color
   */
  public static getRelativeLuminance(rgb: [number, number, number]): number {
    const [r, g, b] = rgb.map(c => {
      c = c / 255;
      return c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4);
    });
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /**
   * Calculate contrast ratio between two colors
   */
  public static getContrastRatio(color1: [number, number, number], color2: [number, number, number]): number {
    const lum1 = this.getRelativeLuminance(color1);
    const lum2 = this.getRelativeLuminance(color2);
    const lighter = Math.max(lum1, lum2);
    const darker = Math.min(lum1, lum2);
    return (lighter + 0.05) / (darker + 0.05);
  }

  /**
   * Check if color combination meets WCAG AA standards
   */
  public static meetsWCAGAA(foreground: [number, number, number], background: [number, number, number]): boolean {
    const ratio = this.getContrastRatio(foreground, background);
    return ratio >= 4.5; // WCAG AA requirement for normal text
  }

  /**
   * Check if color combination meets WCAG AAA standards
   */
  public static meetsWCAGAAA(foreground: [number, number, number], background: [number, number, number]): boolean {
    const ratio = this.getContrastRatio(foreground, background);
    return ratio >= 7; // WCAG AAA requirement for normal text
  }
}

// Initialize screen reader utilities when module loads
ScreenReaderUtils.initialize();