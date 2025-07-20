#!/usr/bin/env python3
"""
Sync audio files between local and server
同步本地和服务器的音频文件
"""

import os
import subprocess
import hashlib
from datetime import datetime

# 配置
LOCAL_AUDIO_DIR = "/Users/echo/codeProjects/LearningEnglish/backend/static/audio_cache"
LOCAL_INSTANCE_DIR = "/Users/echo/codeProjects/LearningEnglish/backend/instance/audio_cache"
SERVER_HOST = "root@191.101.232.50"
SERVER_PASSWORD = "rZTFErb@YJh8D"
BACKEND_CONTAINER = "learningenglish-backend-aviqpp.1.rs6r80auxihlij48dzspir61k"
SERVER_AUDIO_DIR = "/app/static/audio_cache"

def run_command(cmd, capture_output=True):
    """执行shell命令"""
    try:
        result = subprocess.run(cmd, shell=True, capture_output=capture_output, text=True)
        if result.returncode == 0:
            return result.stdout.strip() if capture_output else True
        else:
            print(f"命令执行失败: {cmd}")
            print(f"错误: {result.stderr}")
            return None
    except Exception as e:
        print(f"执行命令出错: {cmd} - {e}")
        return None

def get_local_audio_files():
    """获取本地音频文件列表"""
    local_files = {}
    
    # 检查static/audio_cache目录
    if os.path.exists(LOCAL_AUDIO_DIR):
        for root, dirs, files in os.walk(LOCAL_AUDIO_DIR):
            for file in files:
                if file.endswith('.mp3'):
                    full_path = os.path.join(root, file)
                    # 获取相对路径
                    rel_path = os.path.relpath(full_path, LOCAL_AUDIO_DIR)
                    file_size = os.path.getsize(full_path)
                    local_files[rel_path] = {
                        'full_path': full_path,
                        'size': file_size
                    }
    
    # 检查instance/audio_cache目录
    if os.path.exists(LOCAL_INSTANCE_DIR):
        for root, dirs, files in os.walk(LOCAL_INSTANCE_DIR):
            for file in files:
                if file.endswith('.mp3'):
                    full_path = os.path.join(root, file)
                    rel_path = os.path.relpath(full_path, LOCAL_INSTANCE_DIR)
                    file_size = os.path.getsize(full_path)
                    # 使用instance_前缀区分
                    local_files[f"instance_{rel_path}"] = {
                        'full_path': full_path,
                        'size': file_size
                    }
    
    return local_files

def get_server_audio_files():
    """获取服务器音频文件列表"""
    cmd = f'sshpass -p "{SERVER_PASSWORD}" ssh -o StrictHostKeyChecking=no {SERVER_HOST} "docker exec {BACKEND_CONTAINER} find {SERVER_AUDIO_DIR} -name \'*.mp3\' -exec stat -c \'%n %s\' {{}} \\;"'
    
    result = run_command(cmd)
    if not result:
        return {}
    
    server_files = {}
    for line in result.split('\n'):
        if line.strip():
            parts = line.strip().split(' ')
            if len(parts) >= 2:
                file_path = ' '.join(parts[:-1])  # 文件路径可能包含空格
                file_size = int(parts[-1])
                # 获取相对路径
                rel_path = file_path.replace(f"{SERVER_AUDIO_DIR}/", "")
                server_files[rel_path] = {
                    'full_path': file_path,
                    'size': file_size
                }
    
    return server_files

def find_missing_files(local_files, server_files):
    """找出缺失的文件"""
    missing_files = []
    
    for rel_path, info in local_files.items():
        # 对于instance_文件，检查时去掉前缀
        check_path = rel_path.replace("instance_", "") if rel_path.startswith("instance_") else rel_path
        
        if check_path not in server_files:
            missing_files.append((rel_path, info))
        elif server_files[check_path]['size'] != info['size']:
            print(f"文件大小不匹配: {check_path} (本地: {info['size']}, 服务器: {server_files[check_path]['size']})")
            missing_files.append((rel_path, info))
    
    return missing_files

def upload_file_to_server(local_path, remote_path):
    """上传单个文件到服务器"""
    # 首先上传到服务器临时目录
    temp_file = f"/tmp/{os.path.basename(local_path)}"
    
    cmd = f'sshpass -p "{SERVER_PASSWORD}" scp "{local_path}" {SERVER_HOST}:{temp_file}'
    if not run_command(cmd):
        return False
    
    # 然后复制到Docker容器
    cmd = f'sshpass -p "{SERVER_PASSWORD}" ssh -o StrictHostKeyChecking=no {SERVER_HOST} "docker cp {temp_file} {BACKEND_CONTAINER}:{remote_path}"'
    if not run_command(cmd):
        return False
    
    # 清理临时文件
    cmd = f'sshpass -p "{SERVER_PASSWORD}" ssh -o StrictHostKeyChecking=no {SERVER_HOST} "rm {temp_file}"'
    run_command(cmd)
    
    return True

def create_server_directory(dir_path):
    """在服务器上创建目录"""
    cmd = f'sshpass -p "{SERVER_PASSWORD}" ssh -o StrictHostKeyChecking=no {SERVER_HOST} "docker exec {BACKEND_CONTAINER} mkdir -p {dir_path}"'
    return run_command(cmd)

def sync_audio_files():
    """同步音频文件"""
    print("开始同步音频文件...")
    print(f"本地音频目录: {LOCAL_AUDIO_DIR}")
    print(f"本地实例目录: {LOCAL_INSTANCE_DIR}")
    print(f"服务器音频目录: {SERVER_AUDIO_DIR}")
    
    # 获取文件列表
    print("\n获取本地文件列表...")
    local_files = get_local_audio_files()
    print(f"本地音频文件数量: {len(local_files)}")
    
    print("\n获取服务器文件列表...")
    server_files = get_server_audio_files()
    print(f"服务器音频文件数量: {len(server_files)}")
    
    # 找出缺失的文件
    print("\n检查缺失的文件...")
    missing_files = find_missing_files(local_files, server_files)
    
    if not missing_files:
        print("✅ 所有音频文件已同步，无需上传")
        return
    
    print(f"发现 {len(missing_files)} 个文件需要上传:")
    for rel_path, info in missing_files:
        print(f"  - {rel_path} ({info['size']} bytes)")
    
    # 上传缺失的文件
    print("\n开始上传文件...")
    successful_uploads = 0
    failed_uploads = 0
    
    for rel_path, info in missing_files:
        local_path = info['full_path']
        
        # 确定远程路径
        if rel_path.startswith("instance_"):
            # instance文件直接放到audio_cache根目录
            remote_file = rel_path.replace("instance_", "")
        else:
            remote_file = rel_path
        
        remote_path = f"{SERVER_AUDIO_DIR}/{remote_file}"
        
        # 创建远程目录（如果需要）
        remote_dir = os.path.dirname(remote_path)
        if remote_dir != SERVER_AUDIO_DIR:
            create_server_directory(remote_dir)
        
        print(f"上传: {rel_path} -> {remote_file}")
        
        if upload_file_to_server(local_path, remote_path):
            successful_uploads += 1
            print(f"  ✅ 成功")
        else:
            failed_uploads += 1
            print(f"  ❌ 失败")
    
    print(f"\n上传完成:")
    print(f"  成功: {successful_uploads}")
    print(f"  失败: {failed_uploads}")
    
    # 重新检查服务器文件数量
    print("\n重新验证服务器文件数量...")
    updated_server_files = get_server_audio_files()
    print(f"服务器音频文件数量: {len(updated_server_files)}")

def main():
    """主函数"""
    print("=" * 50)
    print("音频文件同步工具")
    print("=" * 50)
    
    # 检查本地目录
    if not os.path.exists(LOCAL_AUDIO_DIR):
        print(f"错误: 本地音频目录不存在: {LOCAL_AUDIO_DIR}")
        return
    
    # 执行同步
    sync_audio_files()
    
    print("\n音频文件同步完成!")

if __name__ == "__main__":
    main()