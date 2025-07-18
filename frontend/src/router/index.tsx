import React from 'react';
import { createBrowserRouter, Navigate } from 'react-router-dom';
import { Login, Register, ForgotPassword } from '../components/auth';
import EmailVerification from '../components/auth/EmailVerification';
import PhoneVerification from '../components/auth/PhoneVerification';
import MainLayout from '../components/layout/MainLayout';
import ErrorBoundary from '../components/error/ErrorBoundary';
import Dashboard from '../pages/Dashboard';
import DictationModule from '../pages/DictationModule';
import WordPracticeModule from '../pages/WordPracticeModule';
import SentencePracticeModule from '../pages/SentencePracticeModule';
import ReadingModule from '../pages/ReadingModule';
import Profile from '../pages/Profile';
import Settings from '../pages/Settings';
import AdminPanel from '../pages/AdminPanel';
import OnboardingPage from '../pages/OnboardingPage';
import ProtectedRoute from './ProtectedRoute';
import AuthLayout from './AuthLayout';

export const router = createBrowserRouter([
  {
    path: '/',
    element: <Navigate to="/dashboard" replace />,
  },
  {
    path: '/login',
    element: (
      <ErrorBoundary>
        <AuthLayout><Login /></AuthLayout>
      </ErrorBoundary>
    ),
  },
  {
    path: '/register',
    element: (
      <ErrorBoundary>
        <AuthLayout><Register /></AuthLayout>
      </ErrorBoundary>
    ),
  },
  {
    path: '/forgot-password',
    element: (
      <ErrorBoundary>
        <AuthLayout><ForgotPassword /></AuthLayout>
      </ErrorBoundary>
    ),
  },
  {
    path: '/verify-email',
    element: (
      <ErrorBoundary>
        <AuthLayout><EmailVerification /></AuthLayout>
      </ErrorBoundary>
    ),
  },
  {
    path: '/verify-phone',
    element: (
      <ErrorBoundary>
        <AuthLayout><PhoneVerification /></AuthLayout>
      </ErrorBoundary>
    ),
  },
  {
    path: '/onboarding',
    element: (
      <ErrorBoundary>
        <ProtectedRoute>
          <OnboardingPage />
        </ProtectedRoute>
      </ErrorBoundary>
    ),
  },
  {
    path: '/',
    element: (
      <ErrorBoundary>
        <ProtectedRoute><MainLayout /></ProtectedRoute>
      </ErrorBoundary>
    ),
    children: [
      {
        path: 'dashboard',
        element: <Dashboard />,
      },
      {
        path: 'dictation',
        element: <DictationModule />,
      },
      {
        path: 'word-practice',
        element: <WordPracticeModule />,
      },
      {
        path: 'sentence-practice',
        element: <SentencePracticeModule />,
      },
      {
        path: 'reading',
        element: <ReadingModule />,
        children: [
          {
            path: 'articles',
            element: <div>Reading Articles</div>,
          },
          {
            path: 'comprehension',
            element: <div>Reading Comprehension</div>,
          },
        ],
      },
      {
        path: 'profile',
        element: <Profile />,
      },
      {
        path: 'settings',
        element: <Settings />,
      },
      {
        path: 'admin',
        element: <ProtectedRoute roles={['admin', 'teacher']}><AdminPanel /></ProtectedRoute>,
        children: [
          {
            path: 'users',
            element: <div>User Management</div>,
          },
          {
            path: 'content',
            element: <div>Content Management</div>,
          },
          {
            path: 'analytics',
            element: <div>Analytics Dashboard</div>,
          },
        ],
      },
    ],
  },
  {
    path: '*',
    element: <div>404 - Page Not Found</div>,
  },
]);

export default router;