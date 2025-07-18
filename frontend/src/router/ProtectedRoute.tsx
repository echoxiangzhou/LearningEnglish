import React from 'react';
import { Navigate, useLocation } from 'react-router-dom';
import { useAppSelector } from '../store/hooks';
import { Spin } from 'antd';
import type { User } from '../services/authService';

interface ProtectedRouteProps {
  children: React.ReactNode;
  roles?: string[];
}

const ProtectedRoute: React.FC<ProtectedRouteProps> = ({ children, roles = [] }) => {
  const { isAuthenticated, user, isLoading } = useAppSelector(state => state.auth);
  const location = useLocation();

  // Show loading spinner while checking authentication
  if (isLoading) {
    return (
      <div style={{ 
        display: 'flex', 
        justifyContent: 'center', 
        alignItems: 'center', 
        minHeight: '100vh' 
      }}>
        <Spin size="large" />
      </div>
    );
  }

  // Redirect to login if not authenticated
  if (!isAuthenticated || !user) {
    return <Navigate to="/login" state={{ from: location }} replace />;
  }

  // Check role-based access for specific roles
  if (roles.length > 0 && !hasRequiredRole(user, roles)) {
    return <Navigate to="/dashboard" replace />;
  }

  // Redirect admin users away from learning routes and settings
  const isAdmin = user.role === 'admin' || user.role === 'teacher';
  const learningRoutes = ['/dictation', '/vocabulary', '/reading', '/analytics', '/achievements', '/settings'];
  const isLearningRoute = learningRoutes.some(route => location.pathname.startsWith(route));
  
  if (isAdmin && isLearningRoute) {
    return <Navigate to="/admin" replace />;
  }

  return <>{children}</>;
};

// Helper function to check if user has required role
function hasRequiredRole(user: User, requiredRoles: string[]): boolean {
  return requiredRoles.includes(user.role);
}

export default ProtectedRoute;