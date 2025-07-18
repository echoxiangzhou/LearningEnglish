/**
 * Sidebar Component
 * 
 * Navigation sidebar with menu items for different learning modules
 */

import React, { useState, useEffect } from 'react';
import { Layout, Menu, Avatar, Typography, Progress, Badge } from 'antd';
import {
  DashboardOutlined,
  SoundOutlined,
  BookOutlined,
  ReadOutlined,
  BarChartOutlined,
  UserOutlined,
  SettingOutlined,
  TrophyOutlined,
  CalendarOutlined,
  FileTextOutlined,
  TeamOutlined,
  EditOutlined,
} from '@ant-design/icons';
import { Link, useLocation } from 'react-router-dom';
import { useAppSelector, useAppDispatch } from '../../store/hooks';
import { setCurrentModule } from '../../store/slices/learningSlice';
import { setBreadcrumbs } from '../../store/slices/uiSlice';
import './Sidebar.css';

const { Sider } = Layout;
const { Text } = Typography;

interface SidebarProps {
  collapsed: boolean;
  className?: string;
}

const Sidebar: React.FC<SidebarProps> = ({ collapsed, className = '' }) => {
  const location = useLocation();
  const dispatch = useAppDispatch();
  
  const { user } = useAppSelector((state) => state.auth);
  const { deviceType } = useAppSelector((state) => state.ui);
  const { progress, dailyGoals } = useAppSelector((state) => state.learning);

  const [selectedKey, setSelectedKey] = useState<string>('dashboard');

  // Check if user is admin/teacher - define before useEffect
  const isAdmin = user?.role === 'admin' || user?.role === 'teacher';

  // Calculate overall progress percentage
  const overallProgress = Math.round(
    (progress.overall.experiencePoints % 1000) / 10
  );

  // Calculate daily goal completion
  const dailyProgress = Math.round(
    ((dailyGoals.dictation.completed / Math.max(1, dailyGoals.dictation.target)) +
     (dailyGoals.vocabulary.completed / Math.max(1, dailyGoals.vocabulary.target)) +
     (dailyGoals.reading.completed / Math.max(1, dailyGoals.reading.target))) / 3 * 100
  );

  // Update selected key based on current route
  useEffect(() => {
    const path = location.pathname;
    if (path === '/' || path === '/dashboard') {
      setSelectedKey('dashboard');
      dispatch(setCurrentModule('dashboard'));
      dispatch(setBreadcrumbs([{ title: 'Dashboard' }]));
    } else if (path.startsWith('/dictation')) {
      setSelectedKey('dictation');
      dispatch(setCurrentModule('dictation'));
      dispatch(setBreadcrumbs([
        { title: 'Dashboard', path: '/' },
        { title: '听写练习' }
      ]));
    } else if (path.startsWith('/word-practice')) {
      setSelectedKey('word-practice');
      dispatch(setCurrentModule('word-practice'));
      dispatch(setBreadcrumbs([
        { title: 'Dashboard', path: '/' },
        { title: '单词练习' }
      ]));
    } else if (path.startsWith('/sentence-practice')) {
      setSelectedKey('sentence-practice');
      dispatch(setCurrentModule('sentence-practice'));
      dispatch(setBreadcrumbs([
        { title: 'Dashboard', path: '/' },
        { title: '句子练习' }
      ]));
    } else if (path.startsWith('/reading')) {
      setSelectedKey('reading');
      dispatch(setCurrentModule('reading'));
      dispatch(setBreadcrumbs([
        { title: 'Dashboard', path: '/' },
        { title: '阅读理解' }
      ]));
    } else if (path.startsWith('/analytics') && !isAdmin) {
      setSelectedKey('analytics');
      dispatch(setCurrentModule('analytics'));
      dispatch(setBreadcrumbs([
        { title: 'Dashboard', path: '/' },
        { title: '学习分析' }
      ]));
    } else if (path.startsWith('/profile')) {
      setSelectedKey('profile');
      dispatch(setBreadcrumbs([
        { title: 'Dashboard', path: '/' },
        { title: '个人资料' }
      ]));
    } else if (path.startsWith('/settings') && !isAdmin) {
      setSelectedKey('settings');
      dispatch(setBreadcrumbs([
        { title: 'Dashboard', path: '/' },
        { title: '设置' }
      ]));
    } else if (path.startsWith('/admin')) {
      setSelectedKey('admin-panel');
      dispatch(setBreadcrumbs([
        { title: 'Dashboard', path: '/' },
        { title: '管理面板' }
      ]));
    }
  }, [location.pathname, dispatch, isAdmin]);

  // Menu items configuration - different for admin vs student users
  
  const baseMenuItems = [
    {
      key: 'dashboard',
      icon: <DashboardOutlined />,
      label: <Link to="/dashboard">仪表板</Link>,
    },
  ];

  // Learning modules - only for students
  const learningMenuItems = isAdmin ? [] : [
    {
      type: 'divider' as const,
    },
    {
      key: 'learning',
      icon: <BookOutlined />,
      label: '学习模块',
      type: 'group' as const,
      children: [
        {
          key: 'dictation',
          icon: <SoundOutlined />,
          label: <Link to="/dictation">听写练习</Link>,
          extra: dailyGoals.dictation?.completed > 0 && (
            <Badge 
              count={dailyGoals.dictation.completed} 
              size="small" 
              showZero={false}
            />
          ),
        },
        {
          key: 'word-practice',
          icon: <EditOutlined />,
          label: <Link to="/word-practice">单词练习</Link>,
          extra: dailyGoals.vocabulary?.completed > 0 && (
            <Badge 
              count={dailyGoals.vocabulary.completed} 
              size="small" 
              showZero={false}
            />
          ),
        },
        {
          key: 'sentence-practice',
          icon: <FileTextOutlined />,
          label: <Link to="/sentence-practice">句子练习</Link>,
          extra: dailyGoals.dictation?.completed > 0 && (
            <Badge 
              count={dailyGoals.dictation.completed} 
              size="small" 
              showZero={false}
            />
          ),
        },
        {
          key: 'reading',
          icon: <ReadOutlined />,
          label: <Link to="/reading">阅读理解</Link>,
          extra: dailyGoals.reading?.completed > 0 && (
            <Badge 
              count={dailyGoals.reading.completed} 
              size="small" 
              showZero={false}
            />
          ),
        },
      ],
    },
    {
      type: 'divider' as const,
    },
    {
      key: 'analytics',
      icon: <BarChartOutlined />,
      label: <Link to="/analytics">学习分析</Link>,
    },
    {
      key: 'achievements',
      icon: <TrophyOutlined />,
      label: <Link to="/achievements">成就</Link>,
    },
  ];

  // Common menu items - different for admin vs student
  const commonMenuItems = [
    {
      type: 'divider' as const,
    },
    {
      key: 'profile',
      icon: <UserOutlined />,
      label: <Link to="/profile">个人资料</Link>,
    },
    // Settings only for students, not admins
    ...(isAdmin ? [] : [{
      key: 'settings',
      icon: <SettingOutlined />,
      label: <Link to="/settings">设置</Link>,
    }]),
  ];

  const menuItems = [...baseMenuItems, ...learningMenuItems, ...commonMenuItems];

  // Admin menu items (only for admin users)
  const adminMenuItems = isAdmin ? [
    {
      type: 'divider' as const,
    },
    {
      key: 'admin-panel',
      icon: <TeamOutlined />,
      label: <Link to="/admin">管理面板</Link>,
    },
  ] : [];

  const allMenuItems = [...menuItems, ...adminMenuItems];

  return (
    <Sider
      trigger={null}
      collapsible
      collapsed={collapsed}
      width={280}
      collapsedWidth={deviceType === 'mobile' ? 0 : 80}
      className={`sidebar ${className}`}
      style={{
        overflow: 'auto',
        height: '100vh',
        position: 'fixed',
        left: 0,
        top: 0,
        bottom: 0,
      }}
    >
      {/* Logo and App Title */}
      <div className="sidebar-logo">
        <div className="logo-wrapper">
          <BookOutlined className="logo-icon" />
          {!collapsed && (
            <div className="logo-text">
              <Text strong style={{ color: '#fff', fontSize: '16px' }}>
                Smart English
              </Text>
              <Text style={{ color: '#rgba(255,255,255,0.7)', fontSize: '12px' }}>
                Learning Platform
              </Text>
            </div>
          )}
        </div>
      </div>

      {/* User Info Section */}
      {!collapsed && (
        <div className="sidebar-user-info">
          <div className="user-avatar">
            <Avatar size={48} icon={<UserOutlined />} src={user?.avatar} />
          </div>
          <div className="user-details">
            <Text strong style={{ color: '#fff' }}>
              {user?.first_name || user?.username || 'User'}
            </Text>
            <Text style={{ color: 'rgba(255,255,255,0.7)', fontSize: '12px' }}>
              {isAdmin ? '管理员' : `Level ${progress.overall.level}`}
            </Text>
          </div>
          
          {/* Progress Bar - only for students */}
          {!isAdmin && (
            <>
              <div className="user-progress">
                <Progress
                  percent={overallProgress}
                  size="small"
                  showInfo={false}
                  strokeColor="#52c41a"
                />
                <Text style={{ color: 'rgba(255,255,255,0.7)', fontSize: '11px' }}>
                  {progress.overall.experiencePoints % 1000} / 1000 XP
                </Text>
              </div>

              {/* Daily Goals Progress */}
              <div className="daily-progress">
                <Text style={{ color: 'rgba(255,255,255,0.7)', fontSize: '11px' }}>
                  今日目标完成度
                </Text>
                <Progress
                  percent={dailyProgress}
                  size="small"
                  showInfo={true}
                  format={() => `${dailyProgress}%`}
                  strokeColor="#1890ff"
                />
              </div>
            </>
          )}
        </div>
      )}

      {/* Navigation Menu */}
      <Menu
        theme="dark"
        mode="inline"
        selectedKeys={[selectedKey]}
        items={allMenuItems}
        className="sidebar-menu"
      />

      {/* Footer Info */}
      {!collapsed && (
        <div className="sidebar-footer">
          <Text style={{ color: 'rgba(255,255,255,0.5)', fontSize: '11px' }}>
            © 2024 Smart English Learning
          </Text>
        </div>
      )}
    </Sider>
  );
};

export default Sidebar;