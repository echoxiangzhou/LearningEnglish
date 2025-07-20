import React, { useState, useEffect } from 'react';
import { Card, Row, Col, Button, Progress, Statistic, Typography, Avatar, Spin, Alert } from 'antd';
import { 
  BookOutlined, 
  SoundOutlined, 
  ReadOutlined, 
  TrophyOutlined,
  ClockCircleOutlined,
  RightOutlined,
  FireOutlined
} from '@ant-design/icons';
import { useNavigate } from 'react-router-dom';
import { useAppSelector } from '../store/hooks';
import AdminDashboard from './AdminDashboard';
import './Dashboard.css';

const { Title, Text } = Typography;

interface DashboardData {
  overview: {
    total_sessions: number;
    total_time_spent: number;
    average_accuracy: number;
    current_streak: number;
    longest_streak: number;
    words_learned: number;
    today_stats: {
      study_time: number;
      items_practiced: number;
      accuracy: number;
    };
    module_stats: {
      dictation: { sessions: number; accuracy: number };
      vocabulary: { sessions: number; accuracy: number };
      reading: { sessions: number; accuracy: number };
    };
  };
  module_performance: Array<{
    module_type: string;
    module_name: string;
    total_sessions: number;
    average_accuracy: number;
    total_time_minutes: number;
    recent_sessions: number;
    progress_percentage: number;
  }>;
  achievements: {
    current_achievements: any[];
    potential_achievements: any[];
  };
}

const Dashboard: React.FC = () => {
  const navigate = useNavigate();
  const { user } = useAppSelector(state => state.auth);
  const [dashboardData, setDashboardData] = useState<DashboardData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Check if user is admin/teacher and show different dashboard
  const isAdmin = user?.role === 'admin' || user?.role === 'teacher';
  
  if (isAdmin) {
    return <AdminDashboard />;
  }

  // Fetch dashboard data
  useEffect(() => {
    const fetchDashboardData = async () => {
      try {
        setLoading(true);
        const response = await fetch('/api/analytics/dashboard', {
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('access_token')}`,
            'Content-Type': 'application/json',
          },
        });

        if (!response.ok) {
          throw new Error('Failed to fetch dashboard data');
        }

        const result = await response.json();
        if (result.success) {
          setDashboardData(result.data);
        } else {
          throw new Error(result.error || 'Failed to load dashboard data');
        }
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unknown error occurred');
      } finally {
        setLoading(false);
      }
    };

    if (user && !isAdmin) {
      fetchDashboardData();
    }
  }, [user, isAdmin]);

  if (loading) {
    return (
      <div className="dashboard" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '50vh' }}>
        <Spin size="large" />
      </div>
    );
  }

  if (error) {
    return (
      <div className="dashboard">
        <Alert
          message="加载失败"
          description={error}
          type="error"
          showIcon
          action={
            <Button size="small" onClick={() => window.location.reload()}>
              重新加载
            </Button>
          }
        />
      </div>
    );
  }

  if (!dashboardData) {
    return (
      <div className="dashboard">
        <Alert
          message="暂无数据"
          description="开始学习来查看您的学习统计！"
          type="info"
          showIcon
        />
      </div>
    );
  }

  // Create learning modules from real data
  const moduleIcons = {
    dictation: <SoundOutlined />,
    vocabulary: <BookOutlined />,
    reading: <ReadOutlined />
  };
  
  const moduleColors = {
    dictation: '#1890ff',
    vocabulary: '#52c41a',
    reading: '#722ed1'
  };
  
  const modulePaths = {
    dictation: '/dictation',
    vocabulary: '/vocabulary',
    reading: '/reading'
  };
  
  const moduleDescriptions = {
    dictation: '智能听写训练，提高听力和拼写能力',
    vocabulary: '记忆单词卡片，智能复习系统',
    reading: '英文文章阅读，理解能力提升'
  };

  // Create learning modules from real data or default modules if no data
  const learningModules = dashboardData.module_performance && dashboardData.module_performance.length > 0 
    ? dashboardData.module_performance.map(module => ({
        title: module.module_name,
        description: moduleDescriptions[module.module_type as keyof typeof moduleDescriptions] || '',
        icon: moduleIcons[module.module_type as keyof typeof moduleIcons] || <BookOutlined />,
        color: moduleColors[module.module_type as keyof typeof moduleColors] || '#1890ff',
        path: modulePaths[module.module_type as keyof typeof modulePaths] || '/dictation',
        progress: Math.round(module.progress_percentage),
        totalSessions: module.total_sessions,
        recentActivity: module.recent_sessions > 0 ? '最近有活动' : '暂无近期活动'
      }))
    : [
        {
          title: '听写练习',
          description: '智能听写训练，提高听力和拼写能力',
          icon: <SoundOutlined />,
          color: '#1890ff',
          path: '/dictation',
          progress: 0,
          totalSessions: 0,
          recentActivity: '开始您的第一次练习'
        },
        {
          title: '词汇学习',
          description: '记忆单词卡片，智能复习系统',
          icon: <BookOutlined />,
          color: '#52c41a',
          path: '/vocabulary',
          progress: 0,
          totalSessions: 0,
          recentActivity: '开始您的第一次练习'
        },
        {
          title: '阅读理解',
          description: '英文文章阅读，理解能力提升',
          icon: <ReadOutlined />,
          color: '#722ed1',
          path: '/reading',
          progress: 0,
          totalSessions: 0,
          recentActivity: '开始您的第一次练习'
        }
      ];

  // Map achievements from real data
  const achievements = [
    ...(dashboardData.achievements?.current_achievements || []).map(ach => ({
      title: ach.badge_name,
      icon: ach.badge_icon || '🏆',
      earned: true
    })),
    ...(dashboardData.achievements?.potential_achievements || []).map(ach => ({
      title: ach.name,
      icon: ach.type === 'streak' ? '🔥' : ach.type === 'accuracy' ? '🎯' : '📚',
      earned: false
    }))
  ];

  // If no achievements, show placeholder achievements
  if (achievements.length === 0) {
    achievements.push(
      { title: '第一次练习', icon: '🎯', earned: false },
      { title: '连续学习3天', icon: '🔥', earned: false },
      { title: '正确率达到80%', icon: '⭐', earned: false },
      { title: '完成10次练习', icon: '💪', earned: false }
    );
  }

  const todayStats = {
    studyTime: dashboardData.overview?.today_stats?.study_time || 0,
    wordsLearned: dashboardData.overview?.today_stats?.items_practiced || 0,
    accuracy: dashboardData.overview?.today_stats?.accuracy || 0,
    streak: dashboardData.overview?.current_streak || 0
  };

  return (
    <div className="dashboard">
      <div className="dashboard-header">
        <div className="welcome-section">
          <Avatar size={64} style={{ backgroundColor: '#1890ff' }}>
            {user?.first_name?.charAt(0) || user?.username?.charAt(0) || 'U'}
          </Avatar>
          <div className="welcome-text">
            <Title level={2}>
              欢迎回来，{user?.first_name || user?.username}！
            </Title>
            <Text type="secondary">
              继续您的英语学习之旅
            </Text>
          </div>
        </div>
      </div>

      <Row gutter={[24, 24]} className="stats-row">
        <Col xs={12} sm={6}>
          <Card>
            <Statistic
              title="今日学习时间"
              value={todayStats.studyTime}
              suffix="分钟"
              prefix={<ClockCircleOutlined />}
              valueStyle={{ color: '#1890ff' }}
            />
          </Card>
        </Col>
        <Col xs={12} sm={6}>
          <Card>
            <Statistic
              title="今日新单词"
              value={todayStats.wordsLearned}
              suffix="个"
              prefix={<BookOutlined />}
              valueStyle={{ color: '#52c41a' }}
            />
          </Card>
        </Col>
        <Col xs={12} sm={6}>
          <Card>
            <Statistic
              title="今日正确率"
              value={todayStats.accuracy}
              suffix="%"
              prefix={<TrophyOutlined />}
              valueStyle={{ color: '#faad14' }}
            />
          </Card>
        </Col>
        <Col xs={12} sm={6}>
          <Card>
            <Statistic
              title="连续学习"
              value={todayStats.streak}
              suffix="天"
              prefix={<FireOutlined />}
              valueStyle={{ color: '#f5222d' }}
            />
          </Card>
        </Col>
      </Row>

      <Row gutter={[24, 24]} className="modules-row">
        <Col span={24}>
          <Title level={3}>学习模块</Title>
        </Col>
        {learningModules.map((module, index) => (
          <Col xs={24} sm={12} lg={8} key={index}>
            <Card
              className="module-card"
              hoverable
              onClick={() => navigate(module.path)}
            >
              <div className="module-header">
                <div 
                  className="module-icon" 
                  style={{ backgroundColor: module.color }}
                >
                  {module.icon}
                </div>
                <div className="module-info">
                  <Title level={4}>{module.title}</Title>
                  <Text type="secondary">{module.description}</Text>
                </div>
              </div>
              
              <div className="module-progress">
                <div className="progress-info">
                  <Text>学习进度</Text>
                  <Text strong>{module.progress}%</Text>
                </div>
                <Progress 
                  percent={module.progress} 
                  strokeColor={module.color}
                  showInfo={false}
                />
              </div>
              
              <div className="module-stats">
                <Text type="secondary">
                  总练习: {module.totalSessions} 次
                </Text>
                <Text type="secondary">
                  最近活动: {module.recentActivity}
                </Text>
              </div>
              
              <Button 
                type="primary" 
                block 
                icon={<RightOutlined />}
                style={{ backgroundColor: module.color, borderColor: module.color }}
              >
                开始学习
              </Button>
            </Card>
          </Col>
        ))}
      </Row>

      <Row gutter={[24, 24]} className="achievements-row">
        <Col span={24}>
          <Title level={3}>成就徽章</Title>
        </Col>
        <Col span={24}>
          <Card>
            <Row gutter={[16, 16]}>
              {achievements.map((achievement, index) => (
                <Col xs={12} sm={6} key={index}>
                  <div className={`achievement-item ${achievement.earned ? 'earned' : ''}`}>
                    <div className="achievement-icon">{achievement.icon}</div>
                    <Text className="achievement-title">{achievement.title}</Text>
                  </div>
                </Col>
              ))}
            </Row>
          </Card>
        </Col>
      </Row>

      <Row gutter={[24, 24]} className="quick-actions-row">
        <Col span={24}>
          <Title level={3}>快速开始</Title>
        </Col>
        <Col xs={24} sm={12}>
          <Card>
            <Title level={4}>今日目标</Title>
            <div className="goal-item">
              <Text>完成听写练习</Text>
              <Progress 
                percent={Math.min(100, Math.round(((dashboardData.overview?.module_stats?.dictation?.sessions || 0) / 5) * 100))} 
                size="small" 
              />
            </div>
            <div className="goal-item">
              <Text>学习新单词</Text>
              <Progress 
                percent={Math.min(100, Math.round(((dashboardData.overview?.today_stats?.items_practiced || 0) / 20) * 100))} 
                size="small" 
              />
            </div>
            <div className="goal-item">
              <Text>阅读文章</Text>
              <Progress 
                percent={Math.min(100, Math.round(((dashboardData.overview?.module_stats?.reading?.sessions || 0) / 3) * 100))} 
                size="small" 
              />
            </div>
          </Card>
        </Col>
        <Col xs={24} sm={12}>
          <Card>
            <Title level={4}>学习建议</Title>
            {(dashboardData.overview?.average_accuracy || 0) < 70 && (
              <div className="recommendation-item">
                <Text strong>提高正确率练习</Text>
                <Text type="secondary">当前正确率{dashboardData.overview?.average_accuracy || 0}%，建议加强基础练习</Text>
                <Button size="small" type="link" onClick={() => navigate('/dictation')}>开始练习</Button>
              </div>
            )}
            {(dashboardData.overview?.current_streak || 0) === 0 && (
              <div className="recommendation-item">
                <Text strong>开始学习连击</Text>
                <Text type="secondary">建立每日学习习惯</Text>
                <Button size="small" type="link" onClick={() => navigate('/dictation')}>今天开始</Button>
              </div>
            )}
            {(dashboardData.overview?.current_streak || 0) > 0 && (dashboardData.overview?.current_streak || 0) < 7 && (
              <div className="recommendation-item">
                <Text strong>保持学习连击</Text>
                <Text type="secondary">已连续{dashboardData.overview?.current_streak || 0}天，继续保持！</Text>
                <Button size="small" type="link" onClick={() => navigate('/dictation')}>继续练习</Button>
              </div>
            )}
            {(dashboardData.overview?.today_stats?.study_time || 0) === 0 && (
              <div className="recommendation-item">
                <Text strong>开始今日学习</Text>
                <Text type="secondary">今天还没有学习记录</Text>
                <Button size="small" type="link" onClick={() => navigate('/dictation')}>开始学习</Button>
              </div>
            )}
            {/* Default recommendation if no specific recommendations apply */}
            {!((dashboardData.overview?.average_accuracy || 0) < 70) && 
             !((dashboardData.overview?.current_streak || 0) === 0) && 
             !((dashboardData.overview?.current_streak || 0) > 0 && (dashboardData.overview?.current_streak || 0) < 7) && 
             !((dashboardData.overview?.today_stats?.study_time || 0) === 0) && (
              <div className="recommendation-item">
                <Text strong>继续保持优秀表现</Text>
                <Text type="secondary">您的学习状态良好，继续加油！</Text>
                <Button size="small" type="link" onClick={() => navigate('/dictation')}>继续学习</Button>
              </div>
            )}
          </Card>
        </Col>
      </Row>
    </div>
  );
};

export default Dashboard;