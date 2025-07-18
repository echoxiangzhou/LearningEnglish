import React from 'react';
import { Outlet, useLocation } from 'react-router-dom';
import ReadingModule from '../components/reading/ReadingModule';

const ReadingModulePage: React.FC = () => {
  const location = useLocation();
  
  // If we're at the base reading route, show the main component
  if (location.pathname === '/reading') {
    return <ReadingModule />;
  }
  
  // Otherwise, render nested routes
  return <Outlet />;
};

export default ReadingModulePage;