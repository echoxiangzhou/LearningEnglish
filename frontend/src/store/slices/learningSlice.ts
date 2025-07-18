/**
 * Learning Redux Slice
 * 
 * Manages learning module states and user progress
 */

import { createSlice } from '@reduxjs/toolkit';
import type { PayloadAction } from '@reduxjs/toolkit';

export interface LearningProgress {
  totalSessions: number;
  completedSessions: number;
  averageAccuracy: number;
  totalTimeSpent: number; // in seconds
  streakDays: number;
  lastSessionDate: string | null;
  level: number;
  experiencePoints: number;
}

export interface DictationProgress extends LearningProgress {
  totalWords: number;
  correctWords: number;
  hintsUsed: number;
  favoriteLibrary: string | null;
  averageSpeed: number;
}

export interface VocabularyProgress extends LearningProgress {
  totalWords: number;
  masteredWords: number;
  studiedWords: number;
  reviewWords: number;
  newWords: number;
}

export interface ReadingProgress extends LearningProgress {
  articlesRead: number;
  wordsRead: number;
  comprehensionAccuracy: number;
  averageReadingSpeed: number; // words per minute
}

export interface LearningState {
  currentModule: 'dashboard' | 'dictation' | 'vocabulary' | 'reading' | 'analytics' | null;
  progress: {
    dictation: DictationProgress;
    vocabulary: VocabularyProgress;
    reading: ReadingProgress;
    overall: LearningProgress;
  };
  achievements: Array<{
    id: string;
    title: string;
    description: string;
    icon: string;
    earnedAt: string;
    category: 'dictation' | 'vocabulary' | 'reading' | 'general';
  }>;
  dailyGoals: {
    dictation: { target: number; completed: number };
    vocabulary: { target: number; completed: number };
    reading: { target: number; completed: number };
    studyTime: { target: number; completed: number }; // in minutes
  };
  preferences: {
    difficulty: 'beginner' | 'elementary' | 'intermediate' | 'advanced';
    studyReminders: boolean;
    soundEffects: boolean;
    autoAdvance: boolean;
    showHints: boolean;
    studySchedule: Array<{
      day: string;
      startTime: string;
      duration: number; // in minutes
    }>;
  };
  recentActivity: Array<{
    id: string;
    type: 'dictation' | 'vocabulary' | 'reading';
    title: string;
    score?: number;
    duration: number;
    completedAt: string;
  }>;
}

const initialState: LearningState = {
  currentModule: null,
  progress: {
    dictation: {
      totalSessions: 0,
      completedSessions: 0,
      averageAccuracy: 0,
      totalTimeSpent: 0,
      streakDays: 0,
      lastSessionDate: null,
      level: 1,
      experiencePoints: 0,
      totalWords: 0,
      correctWords: 0,
      hintsUsed: 0,
      favoriteLibrary: null,
      averageSpeed: 1.0,
    },
    vocabulary: {
      totalSessions: 0,
      completedSessions: 0,
      averageAccuracy: 0,
      totalTimeSpent: 0,
      streakDays: 0,
      lastSessionDate: null,
      level: 1,
      experiencePoints: 0,
      totalWords: 0,
      masteredWords: 0,
      studiedWords: 0,
      reviewWords: 0,
      newWords: 0,
    },
    reading: {
      totalSessions: 0,
      completedSessions: 0,
      averageAccuracy: 0,
      totalTimeSpent: 0,
      streakDays: 0,
      lastSessionDate: null,
      level: 1,
      experiencePoints: 0,
      articlesRead: 0,
      wordsRead: 0,
      comprehensionAccuracy: 0,
      averageReadingSpeed: 0,
    },
    overall: {
      totalSessions: 0,
      completedSessions: 0,
      averageAccuracy: 0,
      totalTimeSpent: 0,
      streakDays: 0,
      lastSessionDate: null,
      level: 1,
      experiencePoints: 0,
    },
  },
  achievements: [],
  dailyGoals: {
    dictation: { target: 5, completed: 0 },
    vocabulary: { target: 20, completed: 0 },
    reading: { target: 2, completed: 0 },
    studyTime: { target: 30, completed: 0 },
  },
  preferences: {
    difficulty: 'elementary',
    studyReminders: true,
    soundEffects: true,
    autoAdvance: false,
    showHints: true,
    studySchedule: [],
  },
  recentActivity: [],
};

const learningSlice = createSlice({
  name: 'learning',
  initialState,
  reducers: {
    // Module navigation
    setCurrentModule: (state, action: PayloadAction<LearningState['currentModule']>) => {
      state.currentModule = action.payload;
    },
    
    // Progress updates
    updateDictationProgress: (state, action: PayloadAction<Partial<DictationProgress>>) => {
      state.progress.dictation = { ...state.progress.dictation, ...action.payload };
    },
    
    updateVocabularyProgress: (state, action: PayloadAction<Partial<VocabularyProgress>>) => {
      state.progress.vocabulary = { ...state.progress.vocabulary, ...action.payload };
    },
    
    updateReadingProgress: (state, action: PayloadAction<Partial<ReadingProgress>>) => {
      state.progress.reading = { ...state.progress.reading, ...action.payload };
    },
    
    updateOverallProgress: (state, action: PayloadAction<Partial<LearningProgress>>) => {
      state.progress.overall = { ...state.progress.overall, ...action.payload };
    },
    
    // Session completion
    completeSession: (state, action: PayloadAction<{
      type: 'dictation' | 'vocabulary' | 'reading';
      score: number;
      duration: number;
      details: any;
    }>) => {
      const { type, score, duration, details } = action.payload;
      const now = new Date().toISOString();
      
      // Update module-specific progress
      const moduleProgress = state.progress[type];
      moduleProgress.completedSessions += 1;
      moduleProgress.totalTimeSpent += duration;
      moduleProgress.lastSessionDate = now;
      
      // Update accuracy (weighted average)
      const totalSessions = moduleProgress.completedSessions;
      moduleProgress.averageAccuracy = 
        (moduleProgress.averageAccuracy * (totalSessions - 1) + score) / totalSessions;
      
      // Add experience points
      const basePoints = Math.floor(score * 10);
      const bonusPoints = score >= 90 ? 50 : score >= 80 ? 25 : 0;
      moduleProgress.experiencePoints += basePoints + bonusPoints;
      
      // Update level based on experience points
      moduleProgress.level = Math.floor(moduleProgress.experiencePoints / 1000) + 1;
      
      // Update overall progress
      state.progress.overall.completedSessions += 1;
      state.progress.overall.totalTimeSpent += duration;
      state.progress.overall.lastSessionDate = now;
      
      const overallSessions = state.progress.overall.completedSessions;
      state.progress.overall.averageAccuracy = 
        (state.progress.overall.averageAccuracy * (overallSessions - 1) + score) / overallSessions;
      
      state.progress.overall.experiencePoints = 
        state.progress.dictation.experiencePoints + 
        state.progress.vocabulary.experiencePoints + 
        state.progress.reading.experiencePoints;
      
      state.progress.overall.level = Math.floor(state.progress.overall.experiencePoints / 1000) + 1;
      
      // Update daily goals
      if (type === 'dictation') {
        state.dailyGoals.dictation.completed += 1;
      } else if (type === 'vocabulary') {
        state.dailyGoals.vocabulary.completed += 1;
      } else if (type === 'reading') {
        state.dailyGoals.reading.completed += 1;
      }
      
      state.dailyGoals.studyTime.completed += Math.ceil(duration / 60);
      
      // Add to recent activity
      state.recentActivity.unshift({
        id: `activity_${Date.now()}`,
        type,
        title: details.title || `${type.charAt(0).toUpperCase() + type.slice(1)} Session`,
        score,
        duration,
        completedAt: now,
      });
      
      // Keep only last 10 activities
      if (state.recentActivity.length > 10) {
        state.recentActivity = state.recentActivity.slice(0, 10);
      }
    },
    
    // Achievements
    addAchievement: (state, action: PayloadAction<{
      id: string;
      title: string;
      description: string;
      icon: string;
      category: 'dictation' | 'vocabulary' | 'reading' | 'general';
    }>) => {
      const achievement = {
        ...action.payload,
        earnedAt: new Date().toISOString(),
      };
      state.achievements.push(achievement);
    },
    
    // Daily goals
    updateDailyGoals: (state, action: PayloadAction<Partial<LearningState['dailyGoals']>>) => {
      state.dailyGoals = { ...state.dailyGoals, ...action.payload };
    },
    
    resetDailyGoals: (state) => {
      state.dailyGoals.dictation.completed = 0;
      state.dailyGoals.vocabulary.completed = 0;
      state.dailyGoals.reading.completed = 0;
      state.dailyGoals.studyTime.completed = 0;
    },
    
    // Preferences
    updatePreferences: (state, action: PayloadAction<Partial<LearningState['preferences']>>) => {
      state.preferences = { ...state.preferences, ...action.payload };
    },
    
    // Study schedule
    addStudySchedule: (state, action: PayloadAction<{
      day: string;
      startTime: string;
      duration: number;
    }>) => {
      const existingIndex = state.preferences.studySchedule.findIndex(
        schedule => schedule.day === action.payload.day
      );
      
      if (existingIndex >= 0) {
        state.preferences.studySchedule[existingIndex] = action.payload;
      } else {
        state.preferences.studySchedule.push(action.payload);
      }
    },
    
    removeStudySchedule: (state, action: PayloadAction<string>) => {
      state.preferences.studySchedule = state.preferences.studySchedule.filter(
        schedule => schedule.day !== action.payload
      );
    },
    
    // Load progress from API/localStorage
    loadProgress: (state, action: PayloadAction<LearningState['progress']>) => {
      state.progress = action.payload;
    },
    
    loadAchievements: (state, action: PayloadAction<LearningState['achievements']>) => {
      state.achievements = action.payload;
    },
    
    loadPreferences: (state, action: PayloadAction<LearningState['preferences']>) => {
      state.preferences = action.payload;
    },
  },
});

export const {
  setCurrentModule,
  updateDictationProgress,
  updateVocabularyProgress,
  updateReadingProgress,
  updateOverallProgress,
  completeSession,
  addAchievement,
  updateDailyGoals,
  resetDailyGoals,
  updatePreferences,
  addStudySchedule,
  removeStudySchedule,
  loadProgress,
  loadAchievements,
  loadPreferences,
} = learningSlice.actions;

export default learningSlice.reducer;