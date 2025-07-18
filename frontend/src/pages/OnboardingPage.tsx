import React from 'react';
import { useNavigate } from 'react-router-dom';
import { OnboardingFlow } from '../components/onboarding';

const OnboardingPage: React.FC = () => {
  const navigate = useNavigate();

  const handleComplete = () => {
    // Navigate to dashboard after successful onboarding
    navigate('/dashboard', { replace: true });
  };

  const handleSkip = () => {
    // Navigate to dashboard if user skips onboarding
    navigate('/dashboard', { replace: true });
  };

  return (
    <OnboardingFlow 
      onComplete={handleComplete} 
      onSkip={handleSkip} 
    />
  );
};

export default OnboardingPage;