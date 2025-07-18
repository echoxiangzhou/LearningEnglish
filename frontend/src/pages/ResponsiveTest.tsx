/**
 * Responsive Test Page
 * 
 * A page to test responsive design features and mobile optimization
 */

import React from 'react';
import { Card, Row, Col, Button, Typography, Space, Tag, Alert } from 'antd';
import { MobileOutlined, TabletOutlined, DesktopOutlined } from '@ant-design/icons';
import { useResponsive, useMobile, useOrientation } from '../hooks/useResponsive';
import './ResponsiveTest.css';

const { Title, Text, Paragraph } = Typography;

const ResponsiveTest: React.FC = () => {
  const responsive = useResponsive();
  const mobile = useMobile();
  const orientation = useOrientation();

  return (
    <div className="responsive-test">
      <Title level={2}>响应式设计测试页面</Title>
      
      <Alert
        message="设备信息"
        description={`当前设备: ${responsive.deviceType} | 屏幕尺寸: ${responsive.width}x${responsive.height} | 断点: ${responsive.breakpoint}`}
        type="info"
        style={{ marginBottom: 24 }}
      />

      <Row gutter={[16, 16]}>
        {/* Device Detection */}
        <Col xs={24} md={12} lg={8}>
          <Card title="设备检测" className="test-card">
            <Space direction="vertical" style={{ width: '100%' }}>
              <div>
                <Tag color={responsive.isMobile ? 'green' : 'default'}>
                  <MobileOutlined /> 手机
                </Tag>
                <Tag color={responsive.isTablet ? 'green' : 'default'}>
                  <TabletOutlined /> 平板
                </Tag>
                <Tag color={responsive.isDesktop ? 'green' : 'default'}>
                  <DesktopOutlined /> 桌面
                </Tag>
              </div>
              
              <div>
                <Text strong>触摸设备: </Text>
                <Tag color={mobile.isTouchDevice ? 'green' : 'red'}>
                  {mobile.isTouchDevice ? '是' : '否'}
                </Tag>
              </div>
              
              <div>
                <Text strong>屏幕方向: </Text>
                <Tag color={orientation.isPortrait ? 'blue' : 'orange'}>
                  {orientation.orientation === 'portrait' ? '竖屏' : '横屏'}
                </Tag>
              </div>
            </Space>
          </Card>
        </Col>

        {/* Breakpoint Information */}
        <Col xs={24} md={12} lg={8}>
          <Card title="断点信息" className="test-card">
            <Space direction="vertical" style={{ width: '100%' }}>
              <div>
                <Text strong>当前断点: </Text>
                <Tag color="blue">{responsive.breakpoint}</Tag>
              </div>
              
              <div>
                <Text strong>断点检查:</Text>
                <div style={{ marginTop: 8 }}>
                  <Tag color={responsive.isXsDown ? 'red' : 'default'}>XS Down</Tag>
                  <Tag color={responsive.isSmUp ? 'green' : 'default'}>SM Up</Tag>
                  <Tag color={responsive.isMdUp ? 'green' : 'default'}>MD Up</Tag>
                  <Tag color={responsive.isLgUp ? 'green' : 'default'}>LG Up</Tag>
                </div>
              </div>
              
              <div>
                <Text strong>屏幕尺寸: </Text>
                <Text code>{responsive.width} x {responsive.height}</Text>
              </div>
            </Space>
          </Card>
        </Col>

        {/* Responsive Grid Test */}
        <Col xs={24} lg={8}>
          <Card title="响应式网格" className="test-card">
            <Row gutter={[8, 8]}>
              <Col xs={24} sm={12} md={8} lg={6}>
                <div className="grid-item">xs=24 sm=12 md=8 lg=6</div>
              </Col>
              <Col xs={24} sm={12} md={8} lg={6}>
                <div className="grid-item">xs=24 sm=12 md=8 lg=6</div>
              </Col>
              <Col xs={24} sm={12} md={8} lg={6}>
                <div className="grid-item">xs=24 sm=12 md=8 lg=6</div>
              </Col>
              <Col xs={24} sm={12} md={8} lg={6}>
                <div className="grid-item">xs=24 sm=12 md=8 lg=6</div>
              </Col>
            </Row>
          </Card>
        </Col>
      </Row>

      <Row gutter={[16, 16]} style={{ marginTop: 24 }}>
        {/* Responsive Visibility */}
        <Col xs={24} md={12}>
          <Card title="响应式可见性" className="test-card">
            <Space direction="vertical" style={{ width: '100%' }}>
              <div className="show-mobile hide-tablet hide-desktop">
                <Alert message="只在手机上显示" type="info" />
              </div>
              <div className="hide-mobile show-tablet hide-desktop">
                <Alert message="只在平板上显示" type="warning" />
              </div>
              <div className="hide-mobile hide-tablet show-desktop">
                <Alert message="只在桌面上显示" type="success" />
              </div>
              <div className="d-sm-none">
                <Alert message="SM断点以下隐藏" type="error" />
              </div>
              <div className="d-md-block d-sm-none">
                <Alert message="只在MD断点显示" type="info" />
              </div>
            </Space>
          </Card>
        </Col>

        {/* Touch Target Test */}
        <Col xs={24} md={12}>
          <Card title="触摸目标测试" className="test-card">
            <Space wrap>
              <Button size="small">小按钮</Button>
              <Button>正常按钮</Button>
              <Button size="large">大按钮</Button>
              <Button className="touch-target">触摸友好</Button>
            </Space>
            
            <Paragraph style={{ marginTop: 16 }}>
              <Text type="secondary">
                在移动设备上，所有交互元素应该至少44px见方以确保良好的触摸体验。
              </Text>
            </Paragraph>
          </Card>
        </Col>
      </Row>

      <Row gutter={[16, 16]} style={{ marginTop: 24 }}>
        {/* Typography Scale */}
        <Col span={24}>
          <Card title="响应式文字" className="test-card">
            <div className="text-xs">Extra Small Text (变化根据设备)</div>
            <div className="text-sm">Small Text (变化根据设备)</div>
            <div className="text-base">Base Text (变化根据设备)</div>
            <div className="text-lg">Large Text (变化根据设备)</div>
            <div className="text-xl">Extra Large Text (变化根据设备)</div>
            <div className="text-xxl">XXL Text (变化根据设备)</div>
          </Card>
        </Col>
      </Row>

      <Row gutter={[16, 16]} style={{ marginTop: 24 }}>
        {/* Aspect Ratio Test */}
        <Col xs={24} md={12} lg={8}>
          <Card title="宽高比测试" className="test-card">
            <div className="aspect-ratio aspect-16-9" style={{ background: '#f0f0f0', marginBottom: 16 }}>
              <div style={{ 
                display: 'flex', 
                alignItems: 'center', 
                justifyContent: 'center', 
                height: '100%',
                background: 'rgba(24, 144, 255, 0.1)' 
              }}>
                16:9 比例
              </div>
            </div>
          </Card>
        </Col>

        <Col xs={24} md={12} lg={8}>
          <Card title="方形比例" className="test-card">
            <div className="aspect-ratio aspect-1-1" style={{ background: '#f0f0f0', marginBottom: 16 }}>
              <div style={{ 
                display: 'flex', 
                alignItems: 'center', 
                justifyContent: 'center', 
                height: '100%',
                background: 'rgba(82, 196, 26, 0.1)' 
              }}>
                1:1 比例
              </div>
            </div>
          </Card>
        </Col>

        <Col xs={24} lg={8}>
          <Card title="4:3比例" className="test-card">
            <div className="aspect-ratio aspect-4-3" style={{ background: '#f0f0f0', marginBottom: 16 }}>
              <div style={{ 
                display: 'flex', 
                alignItems: 'center', 
                justifyContent: 'center', 
                height: '100%',
                background: 'rgba(250, 173, 20, 0.1)' 
              }}>
                4:3 比例
              </div>
            </div>
          </Card>
        </Col>
      </Row>

      {/* Debug Information */}
      <Card title="调试信息" style={{ marginTop: 24 }} className="test-card">
        <pre style={{ background: '#f5f5f5', padding: 16, borderRadius: 4, fontSize: 12 }}>
          {JSON.stringify({
            responsive: {
              width: responsive.width,
              height: responsive.height,
              deviceType: responsive.deviceType,
              breakpoint: responsive.breakpoint,
              orientation: responsive.orientation,
              isRetina: responsive.isRetina,
              aspectRatio: responsive.aspectRatio.toFixed(2),
            },
            mobile: {
              isMobile: mobile.isMobile,
              isTablet: mobile.isTablet,
              isDesktop: mobile.isDesktop,
              isTouchDevice: mobile.isTouchDevice,
            },
            userAgent: navigator.userAgent,
            pixelRatio: window.devicePixelRatio,
          }, null, 2)}
        </pre>
      </Card>
    </div>
  );
};

export default ResponsiveTest;