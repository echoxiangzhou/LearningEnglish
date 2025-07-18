/**
 * Skip Links Component
 * 
 * Provides keyboard navigation shortcuts for screen readers and keyboard users
 */

import React from 'react';
import './SkipLinks.css';

const SkipLinks: React.FC = () => {
  return (
    <div className="skip-links">
      <a href="#main-content" className="skip-link">
        跳转到主要内容
      </a>
      <a href="#main-navigation" className="skip-link">
        跳转到主导航
      </a>
      <a href="#sidebar" className="skip-link">
        跳转到侧边栏
      </a>
      <a href="#user-menu" className="skip-link">
        跳转到用户菜单
      </a>
    </div>
  );
};

export default SkipLinks;