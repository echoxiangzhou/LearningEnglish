/**
 * 词汇库适配器服务
 * 用于处理前端静态词库与后端动态词库之间的兼容性
 */

import { vocabularyManagementService } from './vocabularyManagementService';
import type { LibrariesResponse } from './vocabularyManagementService';

export interface VocabularyLibrary {
  id: string;
  name: string;
  description: string;
  grade_level?: number;
  word_count: number;
  categories: string[];
}

// 静态词库作为后备选项（如果后端加载失败）
const FALLBACK_LIBRARIES: VocabularyLibrary[] = [
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
    id: 'middle_school_all',
    name: '初中阶段所有单词',
    description: '初中1-3年级所有必学单词合集',
    grade_level: 9,
    word_count: 1600,
    categories: ['进阶词汇', '学科词汇', '社会文化']
  },
  {
    id: 'animals_nature',
    name: '动物与自然词库',
    description: '包含动物、植物、自然现象等主题单词',
    word_count: 200,
    categories: ['动物', '植物', '自然现象', '环境']
  }
];

class VocabularyLibraryAdapter {
  /**
   * 获取词汇库列表（优先从后端加载，失败时使用静态后备）
   */
  async getVocabularyLibraries(): Promise<VocabularyLibrary[]> {
    try {
      const response = await vocabularyManagementService.getLibraries();
      
      if (response.success && response.libraries && response.libraries.length > 0) {
        // 转换后端格式到前端格式
        return response.libraries.map(lib => ({
          id: lib.id,
          name: lib.name,
          description: lib.description,
          grade_level: lib.grade_level,
          word_count: lib.word_count,
          categories: lib.categories || []
        }));
      } else {
        console.warn('Backend returned empty libraries, using fallback');
        return FALLBACK_LIBRARIES;
      }
    } catch (error) {
      console.error('Failed to load libraries from backend, using fallback:', error);
      return FALLBACK_LIBRARIES;
    }
  }

  /**
   * 检查词库是否存在于后端
   */
  async isLibraryAvailable(libraryId: string): Promise<boolean> {
    try {
      const libraries = await this.getVocabularyLibraries();
      return libraries.some(lib => lib.id === libraryId);
    } catch (error) {
      console.error('Error checking library availability:', error);
      return false;
    }
  }

  /**
   * 获取特定词库的详细信息
   */
  async getLibraryDetails(libraryId: string): Promise<VocabularyLibrary | null> {
    try {
      const libraries = await this.getVocabularyLibraries();
      return libraries.find(lib => lib.id === libraryId) || null;
    } catch (error) {
      console.error('Error getting library details:', error);
      return null;
    }
  }

  /**
   * 获取按年级级别分组的词库
   */
  async getLibrariesByGradeLevel(): Promise<Record<string, VocabularyLibrary[]>> {
    try {
      const libraries = await this.getVocabularyLibraries();
      const groupedLibraries: Record<string, VocabularyLibrary[]> = {
        elementary: [],
        middle_school: [],
        thematic: [],
        other: []
      };

      libraries.forEach(lib => {
        if (!lib.grade_level) {
          groupedLibraries.thematic.push(lib);
        } else if (lib.grade_level <= 6) {
          groupedLibraries.elementary.push(lib);
        } else if (lib.grade_level <= 9) {
          groupedLibraries.middle_school.push(lib);
        } else {
          groupedLibraries.other.push(lib);
        }
      });

      return groupedLibraries;
    } catch (error) {
      console.error('Error grouping libraries by grade level:', error);
      return { elementary: [], middle_school: [], thematic: [], other: [] };
    }
  }

  /**
   * 获取静态后备词库（用于离线或后端故障情况）
   */
  getFallbackLibraries(): VocabularyLibrary[] {
    return [...FALLBACK_LIBRARIES];
  }
}

export const vocabularyLibraryAdapter = new VocabularyLibraryAdapter();