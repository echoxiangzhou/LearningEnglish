#!/usr/bin/env python3
"""
Simple data export script - exports local data to SQL format
简单数据导出脚本 - 将本地数据导出为SQL格式
"""

import os
import sys
from datetime import datetime

# 添加项目根目录到Python路径
project_root = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, project_root)

# 导入现有的应用和数据库
from app import create_app, db
from app.models.word import Word
from app.models.sentence import Sentence
from app.models.vocabulary_library import VocabularyLibrary

def escape_sql_string(value):
    """转义SQL字符串"""
    if value is None:
        return 'NULL'
    if isinstance(value, bool):
        return 'true' if value else 'false'
    if isinstance(value, (int, float)):
        return str(value)
    if isinstance(value, str):
        # 转义单引号
        escaped = value.replace("'", "''")
        return f"'{escaped}'"
    return 'NULL'

def export_words_to_sql():
    """导出词汇数据为SQL INSERT语句"""
    app = create_app()
    with app.app_context():
        words = Word.query.all()
        
        if not words:
            print("没有找到词汇数据")
            return []
        
        sql_statements = []
        
        for word in words:
            # 构建INSERT语句
            columns = [
                'word', 'phonetic', 'pronunciation', 'definition', 'chinese_meaning',
                'part_of_speech', 'irregular_forms', 'grade_level', 'frequency', 
                'difficulty', 'difficulty_level', 'audio_url', 'image_url',
                'example_sentence', 'example_chinese', 'etymology', 'synonyms',
                'antonyms', 'related_words', 'usage_notes', 'common_mistakes',
                'source', 'is_active', 'is_core_vocabulary', 'created_at', 'updated_at'
            ]
            
            values = [
                escape_sql_string(word.word),
                escape_sql_string(word.phonetic),
                escape_sql_string(word.pronunciation),
                escape_sql_string(word.definition),
                escape_sql_string(word.chinese_meaning),
                escape_sql_string(word.part_of_speech),
                escape_sql_string(word.irregular_forms),
                escape_sql_string(word.grade_level),
                escape_sql_string(word.frequency),
                escape_sql_string(word.difficulty),
                escape_sql_string(word.difficulty_level),
                escape_sql_string(word.audio_url),
                escape_sql_string(word.image_url),
                escape_sql_string(word.example_sentence),
                escape_sql_string(word.example_chinese),
                escape_sql_string(word.etymology),
                escape_sql_string(word.synonyms),
                escape_sql_string(word.antonyms),
                escape_sql_string(word.related_words),
                escape_sql_string(word.usage_notes),
                escape_sql_string(word.common_mistakes),
                escape_sql_string(word.source),
                escape_sql_string(word.is_active),
                escape_sql_string(word.is_core_vocabulary),
                f"'{word.created_at}'" if word.created_at else 'NOW()',
                f"'{word.updated_at}'" if word.updated_at else 'NOW()'
            ]
            
            sql = f"INSERT INTO words ({', '.join(columns)}) VALUES ({', '.join(values)}) ON CONFLICT (word) DO NOTHING;"
            sql_statements.append(sql)
        
        print(f"导出了 {len(sql_statements)} 个词汇的SQL语句")
        return sql_statements

def export_sentences_to_sql():
    """导出句子数据为SQL INSERT语句"""
    app = create_app()
    with app.app_context():
        sentences = Sentence.query.all()
        
        if not sentences:
            print("没有找到句子数据")
            return []
        
        sql_statements = []
        
        for sentence in sentences:
            columns = ['text', 'difficulty', 'grade_level', 'topic', 'source', 'audio_url', 'created_at', 'updated_at']
            
            values = [
                escape_sql_string(sentence.text),
                escape_sql_string(sentence.difficulty),
                escape_sql_string(sentence.grade_level),
                escape_sql_string(sentence.topic),
                escape_sql_string(sentence.source),
                escape_sql_string(sentence.audio_url),
                f"'{sentence.created_at}'" if sentence.created_at else 'NOW()',
                f"'{sentence.updated_at}'" if sentence.updated_at else 'NOW()'
            ]
            
            sql = f"INSERT INTO sentences ({', '.join(columns)}) VALUES ({', '.join(values)});"
            sql_statements.append(sql)
        
        print(f"导出了 {len(sql_statements)} 个句子的SQL语句")
        return sql_statements

def export_vocabulary_libraries_to_sql():
    """导出词汇库数据为SQL INSERT语句"""
    app = create_app()
    with app.app_context():
        libraries = VocabularyLibrary.query.all()
        
        if not libraries:
            print("没有找到词汇库数据")
            return []
        
        sql_statements = []
        
        for library in libraries:
            columns = ['name', 'description', 'grade_level', 'subject', 'publisher', 'is_active', 'display_order', 'created_at', 'updated_at']
            
            values = [
                escape_sql_string(library.name),
                escape_sql_string(library.description),
                escape_sql_string(library.grade_level),
                escape_sql_string(library.subject),
                escape_sql_string(library.publisher),
                escape_sql_string(library.is_active),
                escape_sql_string(library.display_order),
                f"'{library.created_at}'" if library.created_at else 'NOW()',
                f"'{library.updated_at}'" if library.updated_at else 'NOW()'
            ]
            
            sql = f"INSERT INTO vocabulary_libraries ({', '.join(columns)}) VALUES ({', '.join(values)}) ON CONFLICT (name) DO NOTHING;"
            sql_statements.append(sql)
        
        print(f"导出了 {len(sql_statements)} 个词汇库的SQL语句")
        return sql_statements

def save_sql_to_file(sql_statements, filename):
    """保存SQL语句到文件"""
    try:
        with open(filename, 'w', encoding='utf-8') as f:
            f.write("-- Learning English Database Export\n")
            f.write(f"-- Generated on: {datetime.now()}\n\n")
            
            for sql in sql_statements:
                f.write(sql + '\n')
            
            f.write('\n-- Export completed\n')
        
        print(f"SQL文件已保存到: {filename}")
        return True
    except Exception as e:
        print(f"保存SQL文件出错: {e}")
        return False

def main():
    """主函数"""
    print("开始导出本地数据库为SQL格式...")
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # 导出词汇
    print("\n=== 导出词汇数据 ===")
    words_sql = export_words_to_sql()
    if words_sql:
        words_file = f"words_export_{timestamp}.sql"
        save_sql_to_file(words_sql, words_file)
    
    # 导出句子
    print("\n=== 导出句子数据 ===")
    sentences_sql = export_sentences_to_sql()
    if sentences_sql:
        sentences_file = f"sentences_export_{timestamp}.sql"
        save_sql_to_file(sentences_sql, sentences_file)
    
    # 导出词汇库
    print("\n=== 导出词汇库数据 ===")
    libraries_sql = export_vocabulary_libraries_to_sql()
    if libraries_sql:
        libraries_file = f"libraries_export_{timestamp}.sql"
        save_sql_to_file(libraries_sql, libraries_file)
    
    # 合并所有SQL
    all_sql = words_sql + sentences_sql + libraries_sql
    if all_sql:
        combined_file = f"complete_export_{timestamp}.sql"
        save_sql_to_file(all_sql, combined_file)
        print(f"\n=== 完整导出文件: {combined_file} ===")
    
    print("\n数据导出完成！")

if __name__ == "__main__":
    main()