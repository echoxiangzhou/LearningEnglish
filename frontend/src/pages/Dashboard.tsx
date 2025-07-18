import React from 'react';
import { Card, Row, Col, Button, Progress, Statistic, Typography, Avatar } from 'antd';
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

const Dashboard: React.FC = () => {
  const navigate = useNavigate();
  const { user } = useAppSelector(state => state.auth);

  // Check if user is admin/teacher and show different dashboard
  const isAdmin = user?.role === 'admin' || user?.role === 'teacher';
  
  if (isAdmin) {
    return <AdminDashboard />;
  }

  const learningModules = [
    {
      title: '听写练习',
      description: '智能听写训练，提高听力和拼写能力',
      icon: <SoundOutlined />,
      color: '#1890ff',
      path: '/dictation',
      progress: 65,
      totalSessions: 24,
      recentActivity: '2小时前'
    },
    {
      title: '词汇学习',
      description: '记忆单词卡片，智能复习系统',
      icon: <BookOutlined />,
      color: '#52c41a',
      path: '/vocabulary',
      progress: 78,
      totalSessions: 31,
      recentActivity: '1天前'
    },
    {
      title: '阅读理解',
      description: '英文文章阅读，理解能力提升',
      icon: <ReadOutlined />,
      color: '#722ed1',
      path: '/reading',
      progress: 45,
      totalSessions: 18,
      recentActivity: '3天前'
    }
  ];

  const achievements = [
    { title: '连续学习7天', icon: '🔥', earned: true },
    { title: '完成100个听写', icon: '🎯', earned: true },
    { title: '掌握500个单词', icon: '📚', earned: false },
    { title: '阅读理解达人', icon: '📖', earned: false }
  ];

  const todayStats = {
    studyTime: 45,
    wordsLearned: 12,
    accuracy: 89,
    streak: 7
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
              <Progress percent={80} size="small" />
            </div>
            <div className="goal-item">
              <Text>学习新单词</Text>
              <Progress percent={60} size="small" />
            </div>
            <div className="goal-item">
              <Text>阅读文章</Text>
              <Progress percent={30} size="small" />
            </div>
          </Card>
        </Col>
        <Col xs={24} sm={12}>
          <Card>
            <Title level={4}>推荐练习</Title>
            <div className="recommendation-item">
              <Text strong>中级听写练习</Text>
              <Text type="secondary">适合您当前水平</Text>
              <Button size="small" type="link">开始练习</Button>
            </div>
            <div className="recommendation-item">
              <Text strong>高频词汇复习</Text>
              <Text type="secondary">巩固已学单词</Text>
              <Button size="small" type="link">开始复习</Button>
            </div>
            <div className="recommendation-item">
              <Text strong>科普文章阅读</Text>
              <Text type="secondary">提高理解能力</Text>
              <Button size="small" type="link">开始阅读</Button>
            </div>
          </Card>
        </Col>
      </Row>
    </div>
  );
};

export default Dashboard;