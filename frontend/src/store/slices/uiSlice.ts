/**
 * UI Redux Slice
 * 
 * Manages application UI state including theme, layout, and navigation
 */

import { createSlice } from '@reduxjs/toolkit';
import type { PayloadAction } from '@reduxjs/toolkit';

export interface UIState {
  theme: 'light' | 'dark' | 'auto';
  language: 'en' | 'zh' | 'zh-CN';
  sidebarCollapsed: boolean;
  sidebarVisible: boolean;
  loading: {
    global: boolean;
    partial: { [key: string]: boolean };
  };
  notifications: Array<{
    id: string;
    type: 'success' | 'error' | 'warning' | 'info';
    title: string;
    message: string;
    duration?: number;
    timestamp: number;
  }>;
  modals: {
    [key: string]: {
      visible: boolean;
      data?: any;
    };
  };
  breadcrumbs: Array<{
    title: string;
    path?: string;
  }>;
  pageTitle: string;
  deviceType: 'mobile' | 'tablet' | 'desktop';
  screenSize: {
    width: number;
    height: number;
  };
}

const initialState: UIState = {
  theme: 'light',
  language: 'zh-CN',
  sidebarCollapsed: false,
  sidebarVisible: true,
  loading: {
    global: false,
    partial: {},
  },
  notifications: [],
  modals: {},
  breadcrumbs: [{ title: 'Dashboard' }],
  pageTitle: 'Smart English Learning',
  deviceType: 'desktop',
  screenSize: {
    width: window.innerWidth || 1200,
    height: window.innerHeight || 800,
  },
};

const uiSlice = createSlice({
  name: 'ui',
  initialState,
  reducers: {
    // Theme management
    setTheme: (state, action: PayloadAction<'light' | 'dark' | 'auto'>) => {
      state.theme = action.payload;
      localStorage.setItem('theme', action.payload);
    },
    
    // Language management
    setLanguage: (state, action: PayloadAction<'en' | 'zh' | 'zh-CN'>) => {
      state.language = action.payload;
      localStorage.setItem('language', action.payload);
    },
    
    // Sidebar management
    toggleSidebar: (state) => {
      state.sidebarCollapsed = !state.sidebarCollapsed;
      localStorage.setItem('sidebarCollapsed', JSON.stringify(state.sidebarCollapsed));
    },
    
    setSidebarCollapsed: (state, action: PayloadAction<boolean>) => {
      state.sidebarCollapsed = action.payload;
      localStorage.setItem('sidebarCollapsed', JSON.stringify(action.payload));
    },
    
    setSidebarVisible: (state, action: PayloadAction<boolean>) => {
      state.sidebarVisible = action.payload;
    },
    
    // Loading states
    setGlobalLoading: (state, action: PayloadAction<boolean>) => {
      state.loading.global = action.payload;
    },
    
    setPartialLoading: (state, action: PayloadAction<{ key: string; loading: boolean }>) => {
      const { key, loading } = action.payload;
      if (loading) {
        state.loading.partial[key] = true;
      } else {
        delete state.loading.partial[key];
      }
    },
    
    // Notification management
    addNotification: (state, action: PayloadAction<{
      type: 'success' | 'error' | 'warning' | 'info';
      title: string;
      message: string;
      duration?: number;
    }>) => {
      const notification = {
        id: `notification_${Date.now()}_${Math.random()}`,
        timestamp: Date.now(),
        duration: 4500,
        ...action.payload,
      };
      state.notifications.push(notification);
    },
    
    removeNotification: (state, action: PayloadAction<string>) => {
      state.notifications = state.notifications.filter(n => n.id !== action.payload);
    },
    
    clearNotifications: (state) => {
      state.notifications = [];
    },
    
    // Modal management
    showModal: (state, action: PayloadAction<{ key: string; data?: any }>) => {
      const { key, data } = action.payload;
      state.modals[key] = { visible: true, data };
    },
    
    hideModal: (state, action: PayloadAction<string>) => {
      const key = action.payload;
      if (state.modals[key]) {
        state.modals[key].visible = false;
        delete state.modals[key].data;
      }
    },
    
    // Navigation management
    setBreadcrumbs: (state, action: PayloadAction<Array<{ title: string; path?: string }>>) => {
      state.breadcrumbs = action.payload;
    },
    
    setPageTitle: (state, action: PayloadAction<string>) => {
      state.pageTitle = action.payload;
      document.title = `${action.payload} - Smart English Learning`;
    },
    
    // Device and screen management
    setDeviceType: (state, action: PayloadAction<'mobile' | 'tablet' | 'desktop'>) => {
      state.deviceType = action.payload;
    },
    
    setScreenSize: (state, action: PayloadAction<{ width: number; height: number }>) => {
      state.screenSize = action.payload;
      
      // Auto-determine device type based on screen width
      if (action.payload.width < 768) {
        state.deviceType = 'mobile';
        state.sidebarVisible = false;
      } else if (action.payload.width < 1024) {
        state.deviceType = 'tablet';
        state.sidebarCollapsed = true;
        state.sidebarVisible = true;
      } else {
        state.deviceType = 'desktop';
        state.sidebarVisible = true;
      }
    },
    
    // Initialize UI state from localStorage
    initializeUI: (state) => {
      try {
        const savedTheme = localStorage.getItem('theme') as 'light' | 'dark' | 'auto';
        if (savedTheme) {
          state.theme = savedTheme;
        }
        
        const savedLanguage = localStorage.getItem('language') as 'en' | 'zh' | 'zh-CN';
        if (savedLanguage) {
          state.language = savedLanguage;
        }
        
        const savedSidebarCollapsed = localStorage.getItem('sidebarCollapsed');
        if (savedSidebarCollapsed) {
          state.sidebarCollapsed = JSON.parse(savedSidebarCollapsed);
        }
      } catch (error) {
        console.warn('Error loading UI preferences from localStorage:', error);
      }
    },
  },
});

export const {
  setTheme,
  setLanguage,
  toggleSidebar,
  setSidebarCollapsed,
  setSidebarVisible,
  setGlobalLoading,
  setPartialLoading,
  addNotification,
  removeNotification,
  clearNotifications,
  showModal,
  hideModal,
  setBreadcrumbs,
  setPageTitle,
  setDeviceType,
  setScreenSize,
  initializeUI,
} = uiSlice.actions;

export default uiSlice.reducer;