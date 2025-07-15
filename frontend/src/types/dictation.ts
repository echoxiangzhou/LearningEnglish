export interface DictationSentence {
  id: number;
  text: string;
  chinese_translation: string;
  difficulty: number;
  grade_level?: number;
  topic?: string;
  source: string;
  words: string[];
}

export interface DictationSession {
  id: number;
  sentence_id: number;
  user_id: number;
  session_data: {
    sentence_text: string;
    chinese_translation: string;
    words: DictationWord[];
    blanked_words: number[];
    total_words: number;
    completed_words: number;
  };
  playback_speed: number;
  status: 'active' | 'completed' | 'paused';
  start_time: string;
  completion_time?: string;
  accuracy_score?: number;
  hints_used: number;
  audio_plays: number;
}

export interface DictationWord {
  position: number;
  word: string;
  is_blank: boolean;
  user_input?: string;
  is_correct?: boolean;
  hints_used: number;
  attempt_count: number;
}

export interface DictationSettings {
  default_playback_speed: number;
  auto_replay: boolean;
  replay_delay_seconds: number;
  preferred_difficulty: 'easy' | 'medium' | 'hard';
  auto_difficulty_adjustment: boolean;
  blank_percentage: number;
  enable_hints: boolean;
  hint_delay_seconds: number;
  max_hints_per_word: number;
  show_word_count: boolean;
  show_timer: boolean;
  show_progress_bar: boolean;
  enable_keyboard_shortcuts: boolean;
  enable_sound_effects: boolean;
  enable_visual_feedback: boolean;
}

export interface WordInput {
  position: number;
  value: string;
  isCorrect?: boolean;
  showHint?: boolean;
  hintLevel: number;
}

export interface AudioPlayback {
  url: string;
  duration: number;
  isPlaying: boolean;
  currentTime: number;
  speed: number;
}

export interface HintInfo {
  type: 'letter' | 'phonetic' | 'definition' | 'full';
  content: string;
  cost: number;
}

export interface DictationProgress {
  totalWords: number;
  completedWords: number;
  correctWords: number;
  hintsUsed: number;
  audioPlays: number;
  timeSpent: number;
  accuracy: number;
}

export interface WordLibrary {
  id: string;
  name: string;
  description: string;
  grade_level?: number;
  word_count: number;
  categories: string[];
}

export const WORD_LIBRARIES: WordLibrary[] = [
  {
    id: 'elementary_all',
    name: '小学必学单词',
    description: '小学1-6年级所有必学单词',
    grade_level: 6,
    word_count: 800,
    categories: ['基础词汇', '日常用语']
  },
  {
    id: 'middle_school_all',
    name: '初中必学单词',
    description: '初中1-3年级所有必学单词',
    grade_level: 9,
    word_count: 1600,
    categories: ['进阶词汇', '学科词汇']
  },
  {
    id: 'grade_4',
    name: '小学四年级单词',
    description: '小学四年级上下学期所有单词',
    grade_level: 4,
    word_count: 120,
    categories: ['四年级词汇']
  },
  {
    id: 'grade_5',
    name: '小学五年级单词',
    description: '小学五年级上下学期所有单词',
    grade_level: 5,
    word_count: 150,
    categories: ['五年级词汇']
  },
  {
    id: 'grade_6',
    name: '小学六年级单词',
    description: '小学六年级上下学期所有单词',
    grade_level: 6,
    word_count: 180,
    categories: ['六年级词汇']
  }
];

export type DictationMode = 'full_blank' | 'partial_blank' | 'key_words_only';

export interface DictationConfig {
  library: string;
  mode: DictationMode;
  sentence_count: number;
  difficulty_level: number;
  show_chinese: boolean;
  auto_play: boolean;
  playback_speed: number;
}