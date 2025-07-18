/**
 * Authentication debugging utilities
 */

import { authService } from '../services/authService';

export const debugAuth = () => {
  console.group('🔍 Authentication Debug Info');
  
  // Check token existence
  const token = authService.getToken();
  const refreshToken = authService.getRefreshToken();
  const user = authService.getCurrentUser();
  const isAuthenticated = authService.isAuthenticated();
  
  console.log('📋 Authentication Status:');
  console.log('  - Is Authenticated:', isAuthenticated);
  console.log('  - Has Access Token:', !!token);
  console.log('  - Has Refresh Token:', !!refreshToken);
  console.log('  - Has User Data:', !!user);
  
  if (token) {
    console.log('🎫 Token Info:');
    console.log('  - Token (first 20 chars):', token.substring(0, 20) + '...');
    console.log('  - Token Length:', token.length);
    
    // Try to decode JWT payload (without verification)
    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      console.log('  - Token Payload:', payload);
      console.log('  - Expires At:', new Date(payload.exp * 1000).toLocaleString());
      console.log('  - Is Expired:', Date.now() / 1000 > payload.exp);
    } catch (e) {
      console.log('  - Token decode error:', e);
    }
  }
  
  if (user) {
    console.log('👤 User Info:', user);
  }
  
  // Check localStorage directly
  console.log('💾 Local Storage:');
  console.log('  - access_token:', localStorage.getItem('access_token') ? 'exists' : 'missing');
  console.log('  - refresh_token:', localStorage.getItem('refresh_token') ? 'exists' : 'missing');
  console.log('  - user:', localStorage.getItem('user') ? 'exists' : 'missing');
  
  console.groupEnd();
};

export const testDictationAPI = async () => {
  console.group('🧪 Testing Dictation API');
  
  try {
    const token = authService.getToken();
    if (!token) {
      console.error('❌ No token available');
      return;
    }
    
    const response = await fetch('/api/dictation/practice-sentences?count=1&grade_level=6&difficulty=3&focus_problem_words=true', {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    });
    
    console.log('📡 API Response:');
    console.log('  - Status:', response.status);
    console.log('  - Status Text:', response.statusText);
    console.log('  - Headers:', Object.fromEntries(response.headers.entries()));
    
    const responseText = await response.text();
    console.log('  - Response Body:', responseText);
    
    if (response.ok) {
      console.log('✅ API call successful');
      try {
        const data = JSON.parse(responseText);
        console.log('  - Parsed Data:', data);
      } catch (e) {
        console.log('  - Could not parse JSON');
      }
    } else {
      console.log('❌ API call failed');
    }
    
  } catch (error) {
    console.error('💥 API Test Error:', error);
  }
  
  console.groupEnd();
};

// Add to window for easy debugging
if (typeof window !== 'undefined') {
  (window as any).debugAuth = debugAuth;
  (window as any).testDictationAPI = testDictationAPI;
}