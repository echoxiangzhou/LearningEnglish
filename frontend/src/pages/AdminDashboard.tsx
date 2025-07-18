import React, { useEffect, useState } from 'react';
import { Card, Row, Col, Statistic, Typography, Button, List, Avatar, Progress, Alert, Spin } from 'antd';
import { 
  UserOutlined, 
  FileTextOutlined, 
  BarChartOutlined,
  TeamOutlined,
  CheckCircleOutlined,
  ClockCircleOutlined,
  ExclamationCircleOutlined,
  RightOutlined,
  SettingOutlined,
  DatabaseOutlined,
  ReloadOutlined
} from '@ant-design/icons';
import { useNavigate } from 'react-router-dom';
import { useAppSelector } from '../store/hooks';
import { adminAnalyticsService, AdminDashboardStats, RecentActivity, PendingTask } from '../services/adminAnalyticsService';

const { Title, Text } = Typography;

const AdminDashboard: React.FC = () => {
  const navigate = useNavigate();
  const { user, token, isAuthenticated } = useAppSelector(state => state.auth);
  
  // Real dashboard data state
  const [systemStats, setSystemStats] = useState<AdminDashboardStats | null>(null);
  const [recentActivities, setRecentActivities] = useState<RecentActivity[]>([]);
  const [pendingTasks, setPendingTasks] = useState<PendingTask[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Load real data on component mount
  useEffect(() => {
    loadDashboardData();
  }, [token]);

  const loadDashboardData = async () => {
    if (!token) return;
    
    setLoading(true);
    setError(null);
    
    try {
      // Set auth token for API calls
      adminAnalyticsService.setAuthToken(token);
      
      // Load all dashboard data
      const [stats, activities, tasks] = await Promise.all([
        adminAnalyticsService.getAdminDashboardStats(),
        adminAnalyticsService.getRecentActivities(),
        adminAnalyticsService.getPendingTasks()
      ]);
      
      console.log('Dashboard stats received:', stats);
      console.log('Activities received:', activities);
      console.log('Tasks received:', tasks);
      
      setSystemStats(stats);
      setRecentActivities(activities);
      setPendingTasks(tasks);
    } catch (err) {
      console.error('Failed to load dashboard data:', err);
      setError('无法加载仪表盘数据，请稍后重试');
    } finally {
      setLoading(false);
    }
  };

  const handleRefresh = () => {
    loadDashboardData();
  };

  const quickActions = [
    {
      title: '内容管理',
      description: '管理PDF导入和内容生成',
      icon: <FileTextOutlined />,
      color: '#1890ff',
      action: () => navigate('/admin?tab=content')
    },
    {
      title: '句子审核',
      description: '审核AI生成的练习句子',
      icon: <CheckCircleOutlined />,
      color: '#52c41a',
      action: () => navigate('/admin?tab=sentences'),
      badge: systemStats?.pendingSentences
    },
    {
      title: '用户管理',
      description: '管理用户账户和权限',
      icon: <TeamOutlined />,
      color: '#722ed1',
      action: () => navigate('/admin?tab=users')
    },
    {
      title: '系统设置',
      description: '配置系统参数和设置',
      icon: <SettingOutlined />,
      color: '#fa8c16',
      action: () => navigate('/admin?tab=settings')
    }
  ];

  // Show loading state
  if (loading) {
    return (
      <div className="dashboard" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '400px' }}>
        <Spin size="large" tip="加载仪表盘数据..." />
      </div>
    );
  }

  // Show error state
  if (error) {
    return (
      <div className="dashboard">
        <Alert
          message="数据加载失败"
          description={error}
          type="error"
          showIcon
          action={
            <Button size="small" danger onClick={handleRefresh}>
              重试
            </Button>
          }
        />
      </div>
    );
  }

  // Show placeholder if no data
  if (!systemStats) {
    return (
      <div className="dashboard">
        <Alert
          message="暂无数据"
          description="仪表盘数据暂时不可用"
          type="warning"
          showIcon
        />
      </div>
    );
  }

  return (
    <div className="dashboard">
      <div className="dashboard-header">
        <div className="welcome-section">
          <Avatar size={64} style={{ backgroundColor: '#722ed1' }}>
            {user?.first_name?.charAt(0) || user?.username?.charAt(0) || 'A'}
          </Avatar>
          <div className="welcome-text">
            <Title level={2}>
              管理面板，{user?.first_name || user?.username}
            </Title>
            <Text type="secondary">
              系统管理和监控中心
            </Text>
          </div>
        </div>
        <Button 
          icon={<ReloadOutlined />}
          onClick={handleRefresh}
          loading={loading}
        >
          刷新数据
        </Button>
      </div>

      {/* System Health Alert */}
      {systemStats.systemHealth < 95 && (
        <Alert
          message="系统健康度提醒"
          description="系统健康度低于95%，建议检查系统状态"
          type="warning"
          showIcon
          closable
          style={{ marginBottom: 24 }}
        />
      )}

      {/* System Statistics */}
      <Row gutter={[24, 24]} className="stats-row">
        <Col xs={12} sm={6}>
          <Card>
            <Statistic
              title="总用户数"
              value={systemStats.totalUsers}
              prefix={<UserOutlined />}
              valueStyle={{ color: '#1890ff' }}
            />
            <Text type="secondary" style={{ fontSize: '12px' }}>
              周活跃用户: {systemStats.activeUsers}
            </Text>
          </Card>
        </Col>
        <Col xs={12} sm={6}>
          <Card>
            <Statistic
              title="词汇总数"
              value={systemStats.totalVocabulary}
              prefix={<FileTextOutlined />}
              valueStyle={{ color: '#52c41a' }}
            />
            <Text type="secondary" style={{ fontSize: '12px' }}>
              待审核: {systemStats.pendingSentences}
            </Text>
          </Card>
        </Col>
        <Col xs={12} sm={6}>
          <Card>
            <Statistic
              title="系统健康度"
              value={systemStats.systemHealth}
              suffix="%"
              prefix={<BarChartOutlined />}
              valueStyle={{ 
                color: systemStats.systemHealth >= 95 ? '#52c41a' : '#faad14'
              }}
            />
          </Card>
        </Col>
        <Col xs={12} sm={6}>
          <Card>
            <Statistic
              title="存储使用"
              value={systemStats.storageUsed}
              suffix="%"
              prefix={<DatabaseOutlined />}
              valueStyle={{ color: '#722ed1' }}
            />
          </Card>
        </Col>
      </Row>

      {/* Quick Actions */}
      <Row gutter={[24, 24]} className="modules-row">
        <Col span={24}>
          <Title level={3}>快速操作</Title>
        </Col>
        {quickActions.map((action, index) => (
          <Col xs={24} sm={12} lg={6} key={index}>
            <Card
              className="module-card"
              hoverable
              onClick={action.action}
            >
              <div className="module-header">
                <div 
                  className="module-icon" 
                  style={{ backgroundColor: action.color }}
                >
                  {action.icon}
                </div>
                <div className="module-info">
                  <Title level={4}>{action.title}</Title>
                  <Text type="secondary">{action.description}</Text>
                </div>
              </div>
              
              {action.badge && (
                <div style={{ marginTop: 16 }}>
                  <Alert
                    message={`${action.badge} 项待处理`}
                    type="warning"
                    showIcon
                  />
                </div>
              )}
              
              <Button 
                type="primary" 
                block 
                icon={<RightOutlined />}
                style={{ 
                  backgroundColor: action.color, 
                  borderColor: action.color,
                  marginTop: 16 
                }}
              >
                进入管理
              </Button>
            </Card>
          </Col>
        ))}
      </Row>

      {/* Pending Tasks and Recent Activities */}
      <Row gutter={[24, 24]}>
        <Col xs={24} lg={12}>
          <Card title="待处理任务" extra={<Button type="link">查看全部</Button>}>
            <List
              dataSource={pendingTasks}
              renderItem={(task) => (
                <List.Item
                  actions={[
                    <Button 
                      type="link" 
                      size="small" 
                      onClick={task.action}
                    >
                      处理
                    </Button>
                  ]}
                >
                  <List.Item.Meta
                    avatar={
                      <Avatar 
                        style={{ 
                          backgroundColor: task.priority === 'high' ? '#f5222d' : 
                                          task.priority === 'medium' ? '#faad14' : '#52c41a'
                        }}
                      >
                        {task.count}
                      </Avatar>
                    }
                    title={task.title}
                    description={`${task.count} 项待处理 - ${
                      task.priority === 'high' ? '高优先级' :
                      task.priority === 'medium' ? '中优先级' : '低优先级'
                    }`}
                  />
                </List.Item>
              )}
            />
          </Card>
        </Col>
        
        <Col xs={24} lg={12}>
          <Card title="最近活动" extra={<Button type="link">查看更多</Button>}>
            <List
              dataSource={recentActivities}
              renderItem={(activity) => (
                <List.Item>
                  <List.Item.Meta
                    avatar={
                      <Avatar 
                        style={{ backgroundColor: 
                          activity.type === 'user' ? '#1890ff' :
                          activity.type === 'content' ? '#52c41a' :
                          activity.type === 'system' ? '#722ed1' : '#faad14'
                        }}
                      >
                        {activity.type === 'user' ? <UserOutlined /> :
                         activity.type === 'content' ? <FileTextOutlined /> :
                         activity.type === 'system' ? <SettingOutlined /> : <ClockCircleOutlined />}
                      </Avatar>
                    }
                    title={activity.action}
                    description={`${activity.user} - ${activity.time}`}
                  />
                </List.Item>
              )}
            />
          </Card>
        </Col>
      </Row>

      {/* System Status */}
      <Row gutter={[24, 24]} style={{ marginTop: 24 }}>
        <Col span={24}>
          <Card title="系统状态">
            <Row gutter={[16, 16]}>
              <Col xs={24} sm={8}>
                <div>
                  <Text>CPU使用率</Text>
                  <Progress percent={35} status="active" />
                </div>
              </Col>
              <Col xs={24} sm={8}>
                <div>
                  <Text>内存使用率</Text>
                  <Progress percent={67} status="active" />
                </div>
              </Col>
              <Col xs={24} sm={8}>
                <div>
                  <Text>磁盘使用率</Text>
                  <Progress percent={systemStats.storageUsed} />
                </div>
              </Col>
            </Row>
          </Card>
        </Col>
      </Row>
    </div>
  );
};

export default AdminDashboard;