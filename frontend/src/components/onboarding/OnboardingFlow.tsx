import React, { useState, useEffect } from 'react';
import { Card, Result, Button, Spin, Alert } from 'antd';
import { CheckCircleOutlined, UserOutlined } from '@ant-design/icons';
import LibrarySelector from './LibrarySelector';
import './OnboardingFlow.css';

interface OnboardingFlowProps {
  onComplete: () => void;
  onSkip?: () => void;
}

interface OnboardingStatus {
  has_completed_onboarding: boolean;
  onboarding_completed_at: string | null;
  user: any;
}

const OnboardingFlow: React.FC<OnboardingFlowProps> = ({ onComplete, onSkip }) => {
  const [loading, setLoading] = useState(false);
  const [checking, setChecking] = useState(true);
  const [error, setError] = useState<string>('');
  const [completed, setCompleted] = useState(false);
  const [onboardingStatus, setOnboardingStatus] = useState<OnboardingStatus | null>(null);

  useEffect(() => {
    checkOnboardingStatus();
  }, []);

  const checkOnboardingStatus = async () => {
    try {
      const token = localStorage.getItem('access_token');
      const response = await fetch('/api/onboarding/status', {
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        }
      });

      if (!response.ok) {
        throw new Error('Failed to check onboarding status');
      }

      const data = await response.json();
      setOnboardingStatus(data);
      
      // If user has already completed onboarding, skip the flow
      if (data.has_completed_onboarding) {
        onComplete();
        return;
      }
    } catch (err) {
      console.error('Error checking onboarding status:', err);
      setError(err instanceof Error ? err.message : 'Failed to check onboarding status');
    } finally {
      setChecking(false);
    }
  };

  const handleLibrarySelection = async (selections: {
    vocabulary_libraries: number[];
    sentence_categories: string[];
    reading_libraries: string[];
  }) => {
    setLoading(true);
    setError('');

    try {
      const token = localStorage.getItem('access_token');
      const response = await fetch('/api/onboarding/complete', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${token}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(selections)
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.error || 'Failed to complete onboarding');
      }

      const data = await response.json();
      console.log('Onboarding completed:', data);
      
      setCompleted(true);
      
      // Wait a moment to show success message, then complete
      setTimeout(() => {
        onComplete();
      }, 2000);

    } catch (err) {
      console.error('Error completing onboarding:', err);
      setError(err instanceof Error ? err.message : 'Failed to complete onboarding');
    } finally {
      setLoading(false);
    }
  };

  const handleSkip = () => {
    if (onSkip) {
      onSkip();
    } else {
      onComplete();
    }
  };

  if (checking) {
    return (
      <div className="onboarding-checking">
        <Spin size="large" />
        <p>Checking your account setup...</p>
      </div>
    );
  }

  if (completed) {
    return (
      <div className="onboarding-completed">
        <Result
          icon={<CheckCircleOutlined style={{ color: '#52c41a' }} />}
          title="Welcome to Smart English Learning!"
          subTitle="Your learning libraries have been set up successfully. You can now start your learning journey."
          extra={
            <Button type="primary" onClick={onComplete}>
              Start Learning
            </Button>
          }
        />
      </div>
    );
  }

  return (
    <div className="onboarding-flow">
      <Card className="onboarding-card">
        {error && (
          <Alert
            message="Setup Error"
            description={error}
            type="error"
            showIcon
            closable
            onClose={() => setError('')}
            style={{ marginBottom: 24 }}
          />
        )}

        <LibrarySelector
          onComplete={handleLibrarySelection}
          loading={loading}
        />

        <div className="onboarding-actions">
          <Button 
            type="text" 
            onClick={handleSkip}
            disabled={loading}
          >
            Skip for now
          </Button>
        </div>
      </Card>
    </div>
  );
};

export default OnboardingFlow;