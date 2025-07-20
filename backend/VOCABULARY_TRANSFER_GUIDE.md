# 词汇数据传输指南 (Vocabulary Data Transfer Guide)

本指南说明如何使用SSH将本地PostgreSQL中的词汇数据上传到远程服务器的数据库中。

## 文件说明

1. **export_vocabulary_data.py** - 本地数据导出脚本
2. **import_vocabulary_remote.py** - 远程服务器数据导入脚本
3. **ssh_transfer_vocabulary.sh** - 自动化传输和导入脚本
4. **VOCABULARY_TRANSFER_GUIDE.md** - 本使用指南

## 快速使用 (推荐方式)

### 一键传输脚本

使用自动化脚本完成整个传输过程：

```bash
cd backend

# 基本用法 - 需要提供服务器信息
./ssh_transfer_vocabulary.sh \
  --remote-host your-server.com \
  --remote-user username \
  --remote-db-name learning_english \
  --remote-db-user postgres

# 完整参数示例
./ssh_transfer_vocabulary.sh \
  --remote-host 192.168.1.100 \
  --remote-user root \
  --remote-db-host localhost \
  --remote-db-name learning_english \
  --remote-db-user postgres \
  --local-db-url postgresql://postgres:password@localhost/learning_english
```

### 环境变量方式

你也可以设置环境变量：

```bash
export REMOTE_HOST=your-server.com
export REMOTE_USER=username
export REMOTE_DB_NAME=learning_english
export REMOTE_DB_USER=postgres
export DATABASE_URL=postgresql://postgres:password@localhost/learning_english

./ssh_transfer_vocabulary.sh
```

## 手动步骤

如果需要分步执行或调试，可以使用以下手动步骤：

### 步骤 1: 导出本地数据

```bash
cd backend

# 设置本地数据库连接
export DATABASE_URL=postgresql://postgres:password@localhost/learning_english

# 导出数据
python3 export_vocabulary_data.py --output-dir ./export
```

这会在 `./export` 目录中创建以下文件：
- `words.sql` - 词汇表数据
- `vocabulary_libraries.sql` - 词汇库数据
- `library_words.sql` - 词汇库关联数据
- `library_assignments.sql` - 词汇库分配数据 (如果存在)
- `import_vocabulary.sql` - 导入脚本
- `transfer_to_server.sh` - 简单传输脚本

### 步骤 2: 传输文件到服务器

```bash
# 创建远程目录
ssh username@your-server.com "mkdir -p /tmp/vocabulary_import"

# 传输文件
scp export/*.sql username@your-server.com:/tmp/vocabulary_import/
scp import_vocabulary_remote.py username@your-server.com:/tmp/vocabulary_import/
```

### 步骤 3: 在远程服务器导入数据

登录到远程服务器：

```bash
ssh username@your-server.com
cd /tmp/vocabulary_import

# 安装Python依赖 (如果需要)
pip3 install psycopg2-binary

# 导入数据
python3 import_vocabulary_remote.py \
  --host localhost \
  --database learning_english \
  --username postgres \
  --import-dir /tmp/vocabulary_import
```

## 数据表说明

传输的数据包含以下表：

1. **words** - 词汇表
   - 包含单词、发音、定义、中文含义等
   - 约 X 条记录

2. **vocabulary_libraries** - 词汇库
   - 按年级和主题组织的词汇库
   - 系统预定义库和自定义库

3. **library_words** - 词汇库关联表
   - 词汇与词汇库的多对多关系
   - 包含添加时间等元数据

4. **library_assignments** - 词汇库分配表 (可选)
   - 用户与词汇库的分配关系
   - 包含进度跟踪信息

## 安全注意事项

1. **备份**: 导入脚本会自动备份远程服务器的现有数据
2. **事务**: 所有导入操作在事务中执行，失败时自动回滚
3. **密码**: 脚本会提示输入数据库密码，不会在命令行显示
4. **SSH密钥**: 建议使用SSH密钥认证而不是密码

## 故障排除

### 连接问题

如果SSH连接失败：
```bash
# 测试SSH连接
ssh username@your-server.com

# 检查SSH密钥
ssh-add -l
```

### 数据库连接问题

如果数据库连接失败：
```bash
# 测试本地数据库连接
psql $DATABASE_URL -c "SELECT COUNT(*) FROM words;"

# 测试远程数据库连接
psql -h remote-host -U username -d database_name -c "SELECT version();"
```

### 权限问题

确保远程用户有数据库权限：
```sql
-- 在远程数据库中执行
GRANT ALL PRIVILEGES ON DATABASE learning_english TO username;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO username;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO username;
```

## 验证导入结果

导入完成后，可以验证数据：

```sql
-- 检查记录数量
SELECT 'words' as table_name, COUNT(*) as count FROM words
UNION ALL
SELECT 'vocabulary_libraries', COUNT(*) FROM vocabulary_libraries
UNION ALL
SELECT 'library_words', COUNT(*) FROM library_words;

-- 检查示例数据
SELECT word, chinese_meaning FROM words LIMIT 5;
SELECT name, total_words FROM vocabulary_libraries LIMIT 5;
```

## 清理

传输完成后，可以清理临时文件：

```bash
# 本地清理
rm -rf ./export

# 远程清理 (脚本会自动执行)
ssh username@your-server.com "rm -rf /tmp/vocabulary_import"
```