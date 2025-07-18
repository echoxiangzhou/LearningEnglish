import React, { useEffect, useState } from 'react';
import { Outlet, useLocation, useNavigate } from 'react-router-dom';
import { Card, Tabs, Row, Col, Statistic, Spin, Alert } from 'antd';
import { UserOutlined, FileTextOutlined, BarChartOutlined, BookOutlined } from '@ant-design/icons';
import { useAppSelector } from '../store/hooks';
import { adminAnalyticsService, AdminDashboardStats } from '../services/adminAnalyticsService';
import VocabularyManager from '../components/admin/VocabularyManager';
import IntegratedVocabularyPanel from '../components/admin/IntegratedVocabularyPanel';
import SentenceManager from '../components/admin/SentenceManager';
import CategoryManager from '../components/admin/CategoryManager';
import UserManager from '../components/admin/UserManager';
import SoundConfigManager from '../components/admin/SoundConfigManager';
import UserRoleDebug from '../components/debug/UserRoleDebug';
import './AdminPanel.css';

const { TabPane } = Tabs;

const AdminPanel: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState('vocabulary');
  
  // Real data state
  const [systemStats, setSystemStats] = useState<AdminDashboardStats | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  
  // Get auth info
  const { user, token } = useAppSelector(state => state.auth);
  
  // Check for tab parameter in URL
  useEffect(() => {
    const urlParams = new URLSearchParams(location.search);
    const tabParam = urlParams.get('tab');
    if (tabParam) {
      setActiveTab(tabParam);
    }
  }, [location.search]);

  // Load real statistics data
  useEffect(() => {
    loadSystemStats();
  }, [token]);

  const loadSystemStats = async () => {
    if (!token) {
      setLoading(false);
      return;
    }

    setLoading(true);
    setError(null);

    try {
      // Set auth token for API calls
      adminAnalyticsService.setAuthToken(token);
      
      // Get real statistics
      const stats = await adminAnalyticsService.getAdminDashboardStats();
      console.log('AdminPanel loaded stats:', stats);
      setSystemStats(stats);
    } catch (err) {
      console.error('Failed to load system stats:', err);
      setError('无法加载系统统计数据');
    } finally {
      setLoading(false);
    }
  };

  // If we're at nested routes, render the outlet
  if (location.pathname !== '/admin') {
    return <Outlet />;
  }

  const handleTabChange = (key: string) => {
    setActiveTab(key);
    // Update URL without tab parameter for cleaner URLs
    navigate('/admin', { replace: true });
  };

  // Render loading state
  if (loading) {
    return (
      <div className="admin-container">
        <Card title="管理面板" className="admin-header">
          <div style={{ textAlign: 'center', padding: '40px' }}>
            <Spin size="large" tip="加载统计数据..." />
          </div>
        </Card>
      </div>
    );
  }

  // Render error state
  if (error) {
    return (
      <div className="admin-container">
        <Card title="管理面板" className="admin-header">
          <Alert
            message="数据加载失败"
            description={error}
            type="error"
            showIcon
            action={
              <button onClick={loadSystemStats}>重试</button>
            }
          />
        </Card>
      </div>
    );
  }

  return (
    <div className="admin-container">
      <Card title="管理面板" className="admin-header">
        <Row gutter={[16, 16]}>
          <Col xs={12} sm={6}>
            <Statistic
              title="总用户数"
              value={systemStats?.totalUsers || 0}
              prefix={<UserOutlined />}
              valueStyle={{ color: '#1890ff' }}
            />
          </Col>
          <Col xs={12} sm={6}>
            <Statistic
              title="词汇总数"
              value={systemStats?.totalVocabulary || 0}
              prefix={<BookOutlined />}
              valueStyle={{ color: '#52c41a' }}
            />
          </Col>
          <Col xs={12} sm={6}>
            <Statistic
              title="周活跃用户"
              value={systemStats?.activeUsers || 0}
              prefix={<BarChartOutlined />}
              valueStyle={{ color: '#faad14' }}
            />
          </Col>
          <Col xs={12} sm={6}>
            <Statistic
              title="系统健康度"
              value={systemStats?.systemHealth || 0}
              suffix="%"
              valueStyle={{ color: systemStats?.systemHealth && systemStats.systemHealth >= 95 ? '#52c41a' : '#faad14' }}
            />
          </Col>
        </Row>
      </Card>

      <Tabs activeKey={activeTab} onChange={handleTabChange} className="admin-tabs">
        <TabPane tab="词库管理" key="vocabulary">
          <IntegratedVocabularyPanel />
        </TabPane>
        
        <TabPane tab="句子管理" key="sentences">
          <SentenceManager />
        </TabPane>
        
        <TabPane tab="句子分类管理" key="categories">
          <CategoryManager />
        </TabPane>
        
        <TabPane tab="用户管理" key="users">
          <UserManager />
        </TabPane>
        
        <TabPane tab="声音设置" key="sound">
          <SoundConfigManager />
        </TabPane>
        
        <TabPane tab="数据统计" key="analytics">
          <Card>
            <div style={{ textAlign: 'center', padding: '40px' }}>
              <BarChartOutlined style={{ fontSize: '48px', color: '#d9d9d9' }} />
              <h3>数据统计功能开发中</h3>
              <p>学习数据分析、使用情况报告等功能即将上线</p>
            </div>
          </Card>
        </TabPane>
        
        <TabPane tab="调试信息" key="debug">
          <UserRoleDebug />
        </TabPane>
      </Tabs>
    </div>
  );
};

export default AdminPanel;