#!/usr/bin/env python3
"""
Export local database data and sync to server database
导出本地数据库数据并同步到服务器数据库
"""

import os
import sys
import json
import requests
from datetime import datetime

# 添加项目根目录到Python路径
project_root = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, project_root)

# 导入现有的应用和数据库
from app import create_app, db
from app.models.word import Word
from app.models.sentence import Sentence
from app.models.vocabulary_library import VocabularyLibrary

# 服务器API配置
SERVER_BASE_URL = "https://eng.dataisbeautiful.top/api"
ADMIN_CREDENTIALS = {
    "email": "admin@example.com",
    "password": "admin123"
}

def get_admin_token():
    """获取管理员访问令牌"""
    try:
        response = requests.post(f"{SERVER_BASE_URL}/auth/login", 
                               json=ADMIN_CREDENTIALS)
        if response.status_code == 200:
            data = response.json()
            return data.get('access_token')
        else:
            print(f"登录失败: {response.status_code} - {response.text}")
            return None
    except Exception as e:
        print(f"登录错误: {e}")
        return None

def export_local_words():
    """导出本地词汇数据"""
    app = create_app()
    with app.app_context():
        words = Word.query.all()
        words_data = []
        
        for word in words:
            word_dict = {
                'word': word.word,
                'phonetic': word.phonetic,
                'pronunciation': word.pronunciation,
                'definition': word.definition,
                'chinese_meaning': word.chinese_meaning,
                'part_of_speech': word.part_of_speech,
                'irregular_forms': word.irregular_forms,
                'grade_level': word.grade_level,
                'frequency': word.frequency,
                'difficulty': word.difficulty,
                'difficulty_level': word.difficulty_level,
                'audio_url': word.audio_url,
                'image_url': word.image_url,
                'example_sentence': word.example_sentence,
                'example_chinese': word.example_chinese,
                'etymology': word.etymology,
                'synonyms': word.synonyms,
                'antonyms': word.antonyms,
                'related_words': word.related_words,
                'usage_notes': word.usage_notes,
                'common_mistakes': word.common_mistakes,
                'source': word.source,
                'is_active': word.is_active,
                'is_core_vocabulary': word.is_core_vocabulary
            }
            words_data.append(word_dict)
        
        print(f"导出了 {len(words_data)} 个词汇")
        return words_data

def export_local_sentences():
    """导出本地句子数据"""
    app = create_app()
    with app.app_context():
        sentences = Sentence.query.all()
        sentences_data = []
        
        for sentence in sentences:
            sentence_dict = {
                'text': sentence.text,
                'difficulty': sentence.difficulty,
                'grade_level': sentence.grade_level,
                'topic': sentence.topic,
                'source': sentence.source,
                'audio_url': sentence.audio_url
            }
            sentences_data.append(sentence_dict)
        
        print(f"导出了 {len(sentences_data)} 个句子")
        return sentences_data

def export_local_vocabulary_libraries():
    """导出本地词汇库数据"""
    app = create_app()
    with app.app_context():
        libraries = VocabularyLibrary.query.all()
        libraries_data = []
        
        for library in libraries:
            library_dict = {
                'name': library.name,
                'description': library.description,
                'grade_level': library.grade_level,
                'subject': library.subject,
                'publisher': library.publisher,
                'is_active': library.is_active,
                'display_order': library.display_order
            }
            libraries_data.append(library_dict)
        
        print(f"导出了 {len(libraries_data)} 个词汇库")
        return libraries_data

def upload_words_to_server(words_data, access_token):
    """上传词汇到服务器"""
    headers = {
        'Authorization': f'Bearer {access_token}',
        'Content-Type': 'application/json'
    }
    
    successful_uploads = 0
    failed_uploads = 0
    
    for word_data in words_data:
        try:
            # 检查词汇是否已存在
            check_response = requests.get(
                f"{SERVER_BASE_URL}/vocabulary/word/{word_data['word']}", 
                headers=headers
            )
            
            if check_response.status_code == 200:
                print(f"词汇 '{word_data['word']}' 已存在，跳过")
                continue
            
            # 上传新词汇
            response = requests.post(
                f"{SERVER_BASE_URL}/vocabulary/words", 
                json=word_data, 
                headers=headers
            )
            
            if response.status_code in [200, 201]:
                successful_uploads += 1
                print(f"✓ 上传词汇: {word_data['word']}")
            else:
                failed_uploads += 1
                print(f"✗ 上传失败: {word_data['word']} - {response.text}")
                
        except Exception as e:
            failed_uploads += 1
            print(f"✗ 上传出错: {word_data['word']} - {e}")
    
    print(f"\n词汇上传完成: 成功 {successful_uploads}, 失败 {failed_uploads}")
    return successful_uploads, failed_uploads

def upload_sentences_to_server(sentences_data, access_token):
    """上传句子到服务器"""
    headers = {
        'Authorization': f'Bearer {access_token}',
        'Content-Type': 'application/json'
    }
    
    successful_uploads = 0
    failed_uploads = 0
    
    for sentence_data in sentences_data:
        try:
            response = requests.post(
                f"{SERVER_BASE_URL}/sentence-admin/sentences", 
                json=sentence_data, 
                headers=headers
            )
            
            if response.status_code in [200, 201]:
                successful_uploads += 1
                print(f"✓ 上传句子: {sentence_data['text'][:50]}...")
            else:
                failed_uploads += 1
                print(f"✗ 上传失败: {sentence_data['text'][:50]}... - {response.text}")
                
        except Exception as e:
            failed_uploads += 1
            print(f"✗ 上传出错: {sentence_data['text'][:50]}... - {e}")
    
    print(f"\n句子上传完成: 成功 {successful_uploads}, 失败 {failed_uploads}")
    return successful_uploads, failed_uploads

def save_data_to_files(words_data, sentences_data, libraries_data):
    """保存数据到JSON文件作为备份"""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    
    # 保存词汇数据
    words_file = f"exported_words_{timestamp}.json"
    with open(words_file, 'w', encoding='utf-8') as f:
        json.dump(words_data, f, ensure_ascii=False, indent=2)
    print(f"词汇数据已保存到: {words_file}")
    
    # 保存句子数据
    sentences_file = f"exported_sentences_{timestamp}.json"
    with open(sentences_file, 'w', encoding='utf-8') as f:
        json.dump(sentences_data, f, ensure_ascii=False, indent=2)
    print(f"句子数据已保存到: {sentences_file}")
    
    # 保存词汇库数据
    libraries_file = f"exported_libraries_{timestamp}.json"
    with open(libraries_file, 'w', encoding='utf-8') as f:
        json.dump(libraries_data, f, ensure_ascii=False, indent=2)
    print(f"词汇库数据已保存到: {libraries_file}")
    
    return words_file, sentences_file, libraries_file

def main():
    """主函数"""
    print("开始导出本地数据库数据...")
    
    # 1. 导出本地数据
    print("\n=== 导出本地数据 ===")
    words_data = export_local_words()
    sentences_data = export_local_sentences()
    libraries_data = export_local_vocabulary_libraries()
    
    # 2. 保存到文件作为备份
    print("\n=== 保存数据备份 ===")
    save_data_to_files(words_data, sentences_data, libraries_data)
    
    # 3. 获取管理员令牌
    print("\n=== 获取服务器访问令牌 ===")
    access_token = get_admin_token()
    if not access_token:
        print("无法获取访问令牌，停止上传")
        return
    
    print("获取访问令牌成功")
    
    # 4. 上传数据到服务器
    print("\n=== 上传词汇到服务器 ===")
    if words_data:
        upload_words_to_server(words_data, access_token)
    else:
        print("没有词汇数据需要上传")
    
    print("\n=== 上传句子到服务器 ===")
    if sentences_data:
        upload_sentences_to_server(sentences_data, access_token)
    else:
        print("没有句子数据需要上传")
    
    print("\n=== 数据同步完成 ===")

if __name__ == "__main__":
    main()