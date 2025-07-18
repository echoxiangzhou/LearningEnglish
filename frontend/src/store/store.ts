/**
 * Redux Store Configuration
 * 
 * Central state management for the Smart English Learning application
 */

import { configureStore } from '@reduxjs/toolkit';
import authSlice from './slices/authSlice';
import uiSlice from './slices/uiSlice';
import learningSlice from './slices/learningSlice';

export const store = configureStore({
  reducer: {
    auth: authSlice,
    ui: uiSlice,
    learning: learningSlice,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      serializableCheck: {
        ignoredActions: ['persist/PERSIST', 'persist/REHYDRATE'],
      },
    }),
  devTools: import.meta.env.DEV,
});

// Export type definitions
export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;

// Default export for compatibility
export default store;