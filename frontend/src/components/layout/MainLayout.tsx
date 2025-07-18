/**
 * Main Layout Component
 * 
 * Responsive layout wrapper with header, sidebar, and main content area
 */

import React, { useEffect } from 'react';
import { Layout, theme } from 'antd';
import { Outlet } from 'react-router-dom';
import Header from './Header';
import Sidebar from './Sidebar';
import NotificationContainer from './NotificationContainer';
import AccessibilityProvider from '../accessibility/AccessibilityProvider';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { setScreenSize, initializeUI } from '../../store/slices/uiSlice';
import './MainLayout.css';

const { Content } = Layout;

const MainLayout: React.FC = () => {
  const dispatch = useAppDispatch();
  const { 
    sidebarCollapsed, 
    sidebarVisible, 
    theme: currentTheme,
    deviceType,
    loading 
  } = useAppSelector((state) => state.ui);
  
  const { isAuthenticated } = useAppSelector((state) => state.auth);
  
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  // Initialize UI and handle window resize
  useEffect(() => {
    dispatch(initializeUI());

    const handleResize = () => {
      dispatch(setScreenSize({
        width: window.innerWidth,
        height: window.innerHeight,
      }));
    };

    handleResize(); // Initial call
    window.addEventListener('resize', handleResize);
    
    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, [dispatch]);

  // Apply theme class to body
  useEffect(() => {
    document.body.className = `theme-${currentTheme}`;
  }, [currentTheme]);

  if (!isAuthenticated) {
    // For non-authenticated users, render without layout
    return (
      <div className="auth-layout">
        <NotificationContainer />
        <Outlet />
      </div>
    );
  }

  return (
    <AccessibilityProvider>
      <Layout className={`main-layout ${deviceType}`} hasSider>
      {/* Sidebar Navigation */}
      {sidebarVisible && (
        <aside 
          id="sidebar"
          role="navigation"
          aria-label="主导航"
          tabIndex={-1}
        >
          <Sidebar 
            collapsed={sidebarCollapsed}
            className={deviceType === 'mobile' ? 'mobile-sidebar' : ''}
          />
        </aside>
      )}
      
      {/* Main Layout */}
      <Layout className="site-layout">
        {/* Header */}
        <header 
          id="main-navigation"
          role="banner"
          aria-label="页面标题和用户菜单"
          tabIndex={-1}
        >
          <Header />
        </header>
        
        {/* Main Content */}
        <Content
          id="main-content"
          role="main"
          aria-label="主要内容区域"
          tabIndex={-1}
          className="site-layout-content"
          style={{
            margin: deviceType === 'mobile' ? '16px' : '24px',
            padding: deviceType === 'mobile' ? '16px' : '24px',
            minHeight: 'calc(100vh - 112px)',
            background: colorBgContainer,
            borderRadius: borderRadiusLG,
            position: 'relative',
          }}
        >
          {/* Global Loading Overlay */}
          {loading.global && (
            <div 
              className="global-loading-overlay"
              role="status"
              aria-live="polite"
              aria-label="页面加载中"
            >
              <div className="loading-spinner">
                <div className="spinner" aria-hidden="true" />
                <p>Loading...</p>
              </div>
            </div>
          )}
          
          {/* Page Content */}
          <div className="page-content">
            <Outlet />
          </div>
        </Content>
      </Layout>
      
      {/* Notification Container */}
      <aside 
        role="status"
        aria-live="polite"
        aria-label="通知消息"
      >
        <NotificationContainer />
      </aside>
      </Layout>
    </AccessibilityProvider>
  );
};

export default MainLayout;