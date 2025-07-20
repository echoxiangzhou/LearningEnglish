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

export interface TokenWithPunctuation {
  type: 'word' | 'punctuation';
  text: string;
  word_position?: number;
}

export interface DictationSession {
  session_id: number;
  id?: number; // alias for session_id
  sentence_id: number;
  user_id?: number;
  session_data: {
    sentence_text: string;
    chinese_translation?: string;
    target_word?: string;
    sentence_difficulty?: string;
  };
  words: WordAttempt[];
  tokens_with_punctuation?: TokenWithPunctuation[];
  blanked_words: number;
  total_words: number;
  completed_words: number;
  playback_speed: number;
  play_count: number;
  is_completed: boolean;
  accuracy_score: number;
  hints_used: number;
  progress: number;
  start_time?: string;
  completion_time?: string;
}

export interface WordAttempt {
  position: number;
  original: string;
  display: string;
  is_blanked: boolean;
  is_completed: boolean;
  user_input: string;
  hints_available: string[];
  hints_used: string[];
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

// DEPRECATED: 静态词库已被废弃，现在从后端动态加载
// 使用 vocabularyLibraryAdapter.getVocabularyLibraries() 替代
// 这个常量仅作为后备选项保留
export const WORD_LIBRARIES: WordLibrary[] = [
  // 小学阶段词库
  {
    id: 'elementary_all',
    name: '小学阶段所有单词',
    description: '小学1-6年级所有必学单词合集',
    grade_level: 6,
    word_count: 800,
    categories: ['基础词汇', '日常用语', '学校生活']
  },
  {
    id: 'grade_1',
    name: '小学一年级单词',
    description: '小学一年级上下学期必学单词',
    grade_level: 1,
    word_count: 80,
    categories: ['基础词汇', '家庭', '动物', '颜色']
  },
  {
    id: 'grade_2',
    name: '小学二年级单词',
    description: '小学二年级上下学期必学单词',
    grade_level: 2,
    word_count: 100,
    categories: ['日常用品', '食物', '身体部位', '数字']
  },
  {
    id: 'grade_3',
    name: '小学三年级单词',
    description: '小学三年级上下学期必学单词',
    grade_level: 3,
    word_count: 120,
    categories: ['学校用品', '运动', '天气', '时间']
  },
  {
    id: 'grade_4',
    name: '小学四年级单词',
    description: '小学四年级上下学期必学单词',
    grade_level: 4,
    word_count: 140,
    categories: ['职业', '交通', '节日', '服装']
  },
  {
    id: 'grade_5',
    name: '小学五年级单词',
    description: '小学五年级上下学期必学单词',
    grade_level: 5,
    word_count: 160,
    categories: ['科目', '地理', '自然', '情感']
  },
  {
    id: 'grade_6',
    name: '小学六年级单词',
    description: '小学六年级上下学期必学单词',
    grade_level: 6,
    word_count: 200,
    categories: ['进阶词汇', '抽象概念', '社会生活']
  },
  
  // 初中阶段词库
  {
    id: 'middle_school_all',
    name: '初中阶段所有单词',
    description: '初中1-3年级所有必学单词合集',
    grade_level: 9,
    word_count: 1600,
    categories: ['进阶词汇', '学科词汇', '社会文化']
  },
  {
    id: 'grade_7',
    name: '初中一年级单词',
    description: '初中一年级（七年级）上下学期必学单词',
    grade_level: 7,
    word_count: 400,
    categories: ['学科词汇', '生活技能', '科技']
  },
  {
    id: 'grade_8',
    name: '初中二年级单词',
    description: '初中二年级（八年级）上下学期必学单词',
    grade_level: 8,
    word_count: 500,
    categories: ['环境', '历史', '文学', '艺术']
  },
  {
    id: 'grade_9',
    name: '初中三年级单词',
    description: '初中三年级（九年级）上下学期必学单词',
    grade_level: 9,
    word_count: 700,
    categories: ['高级词汇', '学术词汇', '社会议题']
  },

  // 主题分类词库
  {
    id: 'animals_nature',
    name: '动物与自然词库',
    description: '包含动物、植物、自然现象等主题单词',
    word_count: 200,
    categories: ['动物', '植物', '自然现象', '环境']
  },
  {
    id: 'food_drinks',
    name: '食物与饮品词库',
    description: '包含各类食物、饮品、餐具等相关单词',
    word_count: 150,
    categories: ['食物', '饮品', '餐具', '烹饪']
  },
  {
    id: 'family_friends',
    name: '家庭与朋友词库',
    description: '包含家庭成员、朋友关系、社交等单词',
    word_count: 120,
    categories: ['家庭', '朋友', '关系', '社交']
  },
  {
    id: 'school_subjects',
    name: '学校与学科词库',
    description: '包含学校设施、学科名称、学习用品等单词',
    word_count: 180,
    categories: ['学校', '学科', '学习用品', '教育']
  },
  {
    id: 'sports_hobbies',
    name: '运动与爱好词库',
    description: '包含各类运动、爱好、娱乐活动等单词',
    word_count: 160,
    categories: ['运动', '爱好', '娱乐', '游戏']
  }
];

export type DictationMode = 'full_blank' | 'partial_blank' | 'key_words_only';
export type PracticeType = 'word' | 'sentence';

export interface DictationConfig {
  practice_type: PracticeType; // 练习类型：单词练习或句子练习
  library: string;
  mode: DictationMode;
  sentence_count: number;
  difficulty_level: number;
  show_chinese: boolean;
  auto_play: boolean;
  playback_speed: number;
  categories?: number[]; // 选择的分类ID列表
  auto_play_new_sentence?: boolean; // 切换到新句子时自动播放
}