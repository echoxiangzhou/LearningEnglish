/**
 * Header Component
 * 
 * Top navigation bar with user menu, theme toggle, and breadcrumbs
 */

import React from 'react';
import { 
  Layout, 
  Button, 
  Space, 
  Dropdown, 
  Avatar, 
  Typography, 
  Breadcrumb,
  Switch,
  Badge,
  Tooltip
} from 'antd';
import {
  MenuFoldOutlined,
  MenuUnfoldOutlined,
  UserOutlined,
  SettingOutlined,
  LogoutOutlined,
  BellOutlined,
  SunOutlined,
  MoonOutlined,
  GlobalOutlined,
  HomeOutlined
} from '@ant-design/icons';
import { Link, useNavigate } from 'react-router-dom';
import { useAppDispatch, useAppSelector } from '../../store/hooks';
import { toggleSidebar, setTheme, setLanguage } from '../../store/slices/uiSlice';
import { logoutAsync } from '../../store/slices/authSlice';
import './Header.css';

const { Header: AntHeader } = Layout;
const { Text } = Typography;

const Header: React.FC = () => {
  const dispatch = useAppDispatch();
  const navigate = useNavigate();
  
  const { 
    sidebarCollapsed, 
    theme: currentTheme, 
    language, 
    breadcrumbs,
    deviceType,
    notifications
  } = useAppSelector((state) => state.ui);
  
  const { user } = useAppSelector((state) => state.auth);

  const handleLogout = () => {
    dispatch(logoutAsync()).then(() => {
      navigate('/login');
    });
  };

  const handleThemeToggle = () => {
    dispatch(setTheme(currentTheme === 'light' ? 'dark' : 'light'));
  };

  const handleLanguageChange = (newLanguage: 'en' | 'zh' | 'zh-CN') => {
    dispatch(setLanguage(newLanguage));
  };

  // User dropdown menu
  const userMenuItems = [
    {
      key: 'profile',
      icon: <UserOutlined />,
      label: <Link to="/profile">个人资料</Link>,
    },
    {
      key: 'settings',
      icon: <SettingOutlined />,
      label: <Link to="/settings">设置</Link>,
    },
    {
      type: 'divider' as const,
    },
    {
      key: 'logout',
      icon: <LogoutOutlined />,
      label: <span onClick={handleLogout}>退出登录</span>,
      danger: true,
    },
  ];

  // Language dropdown menu
  const languageMenuItems = [
    {
      key: 'zh-CN',
      label: <span onClick={() => handleLanguageChange('zh-CN')}>简体中文</span>,
    },
    {
      key: 'en',
      label: <span onClick={() => handleLanguageChange('en')}>English</span>,
    },
    {
      key: 'zh',
      label: <span onClick={() => handleLanguageChange('zh')}>繁體中文</span>,
    },
  ];

  // Generate breadcrumb items
  const breadcrumbItems = breadcrumbs.map((item, index) => ({
    key: index,
    title: item.path ? (
      <Link to={item.path}>
        {index === 0 ? <><HomeOutlined /> {item.title}</> : item.title}
      </Link>
    ) : (
      index === 0 ? <><HomeOutlined /> {item.title}</> : item.title
    ),
  }));

  return (
    <AntHeader className="site-layout-header">
      <div className="header-left">
        {/* Sidebar Toggle */}
        <Button
          type="text"
          icon={sidebarCollapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
          onClick={() => dispatch(toggleSidebar())}
          className="sidebar-toggle"
        />
        
        {/* Breadcrumbs */}
        {deviceType !== 'mobile' && (
          <Breadcrumb 
            items={breadcrumbItems}
            className="header-breadcrumb"
          />
        )}
      </div>

      <div className="header-right">
        <Space size="middle">
          {/* Theme Toggle */}
          <Tooltip title={currentTheme === 'light' ? '切换到暗色主题' : '切换到亮色主题'}>
            <Button
              type="text"
              icon={currentTheme === 'light' ? <MoonOutlined /> : <SunOutlined />}
              onClick={handleThemeToggle}
              className="theme-toggle"
            />
          </Tooltip>

          {/* Language Selector */}
          <Dropdown
            menu={{ items: languageMenuItems }}
            placement="bottomRight"
            trigger={['click']}
          >
            <Button type="text" icon={<GlobalOutlined />} className="language-selector">
              {language === 'zh-CN' ? '中文' : language === 'en' ? 'EN' : '繁中'}
            </Button>
          </Dropdown>

          {/* Notifications */}
          <Tooltip title="通知">
            <Badge count={notifications.length} size="small">
              <Button
                type="text"
                icon={<BellOutlined />}
                className="notification-button"
                onClick={() => navigate('/notifications')}
              />
            </Badge>
          </Tooltip>

          {/* User Menu */}
          <Dropdown
            menu={{ items: userMenuItems }}
            placement="bottomRight"
            trigger={['click']}
          >
            <Space className="user-menu-trigger">
              <Avatar 
                size="small" 
                icon={<UserOutlined />}
                src={user?.avatar}
              />
              {deviceType !== 'mobile' && (
                <Text className="username">
                  {user?.first_name || user?.username || 'User'}
                </Text>
              )}
            </Space>
          </Dropdown>
        </Space>
      </div>
    </AntHeader>
  );
};

export default Header;