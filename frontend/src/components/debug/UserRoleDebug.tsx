import React from 'react';
import { Card, Typography, Tag } from 'antd';
import { useAppSelector } from '../../store/hooks';

const { Title, Text } = Typography;

const UserRoleDebug: React.FC = () => {
  const { user, isAuthenticated } = useAppSelector(state => state.auth);

  return (
    <Card title="用户角色调试信息" style={{ margin: '20px' }}>
      <Title level={4}>认证状态</Title>
      <Text>已认证: {isAuthenticated ? <Tag color="green">是</Tag> : <Tag color="red">否</Tag>}</Text>
      
      <Title level={4} style={{ marginTop: 20 }}>用户信息</Title>
      {user ? (
        <div>
          <p><Text strong>用户ID:</Text> {user.id}</p>
          <p><Text strong>用户名:</Text> {user.username}</p>
          <p><Text strong>邮箱:</Text> {user.email}</p>
          <p><Text strong>角色:</Text> <Tag color="blue">{user.role}</Tag></p>
          <p><Text strong>创建时间:</Text> {user.created_at}</p>
          <p><Text strong>是否为管理员:</Text> {user.role === 'admin' || user.role === 'teacher' ? <Tag color="green">是</Tag> : <Tag color="red">否</Tag>}</p>
        </div>
      ) : (
        <Text>无用户信息</Text>
      )}
    </Card>
  );
};

export default UserRoleDebug;