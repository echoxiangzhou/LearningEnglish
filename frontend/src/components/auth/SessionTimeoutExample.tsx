/**
 * Session Timeout Integration Example
 * 
 * Shows how to integrate session timeout functionality into existing components
 */

import React from 'react';
import { Space, Divider } from 'antd';
import { SessionStatusIndicator } from './SessionStatusIndicator';

interface HeaderIntegrationExampleProps {
  existingHeaderContent?: React.ReactNode;
}

export const HeaderIntegrationExample: React.FC<HeaderIntegrationExampleProps> = ({
  existingHeaderContent
}) => {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
      {/* Existing header content */}
      {existingHeaderContent}
      
      {/* Session status indicator */}
      <Divider type="vertical" />
      <SessionStatusIndicator 
        showTimeRemaining={true}
        showIcon={true}
        className="compact"
      />
    </div>
  );
};

// Alternative integration for sidebar
export const SidebarIntegrationExample: React.FC = () => {
  return (
    <div style={{ 
      padding: '8px 12px', 
      borderTop: '1px solid #f0f0f0',
      marginTop: 'auto'
    }}>
      <SessionStatusIndicator 
        showTimeRemaining={true}
        showIcon={true}
      />
    </div>
  );
};

// Integration for user dropdown menu
export const UserMenuIntegrationExample: React.FC = () => {
  return (
    <div style={{
      padding: '8px 12px',
      borderBottom: '1px solid #f0f0f0',
      marginBottom: '4px'
    }}>
      <div style={{ fontSize: '12px', color: '#666', marginBottom: '4px' }}>
        会话状态
      </div>
      <SessionStatusIndicator 
        showTimeRemaining={true}
        showIcon={false}
      />
    </div>
  );
};