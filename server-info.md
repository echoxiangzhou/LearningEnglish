# 远程服务器访问信息

## 🚀 服务器基本信息

### SSH登录信息
```
服务器IP: 191.101.232.50
用户名: root
密码: rZTFErb@YJh8D
端口: 22 (默认)
```

### 快速连接命令
```bash
# 使用sshpass直接连接
sshpass -p 'rZTFErb@YJh8D' ssh -o StrictHostKeyChecking=no root@191.101.232.50

# 传统SSH连接
ssh root@191.101.232.50
# 然后输入密码: rZTFErb@YJh8D
```

## 🐳 Docker Hub信息

### 登录凭据
```
用户名: iocas
密码: y6LFC6@fnoST4v
镜像仓库: iocas/learning-english-backend:latest
```

### Docker Hub登录命令
```bash
docker login -u iocas -p 'y6LFC6@fnoST4v'
```

## 🌐 域名信息

### 主域名
```
主域名: eng.dataisbeautiful.top
后端API: eng.dataisbeautiful.top/api
DNS指向: 191.101.232.50
```

## 📦 服务器运行的容器

### PostgreSQL数据库
```
容器名: postgres-db
端口: 5432
用户名: postgres
密码: ruiqifeng2014
数据库: learning_english
连接URL: postgresql://postgres:ruiqifeng2014@postgres-db:5432/learning_english
```

### Kokoro TTS服务
```
容器名: learningenglish-kokoro-rndkku.1.s0dsn5qc9hgsp54t8o0juakwa
内部URL: http://learningenglish-kokoro-rndkku:8880
API Key: not-needed
```

### Dokploy管理面板
```
访问地址: http://191.101.232.50:3000
网络: dokploy-network
```

## 🔧 常用操作命令

### 查看容器状态
```bash
sshpass -p 'rZTFErb@YJh8D' ssh -o StrictHostKeyChecking=no root@191.101.232.50 "docker ps"
```

### 查看应用日志
```bash
sshpass -p 'rZTFErb@YJh8D' ssh -o StrictHostKeyChecking=no root@191.101.232.50 "docker logs -f learning-english-backend"
```

### 进入应用容器
```bash
sshpass -p 'rZTFErb@YJh8D' ssh -o StrictHostKeyChecking=no root@191.101.232.50 "docker exec -it learning-english-backend bash"
```

### 数据库操作
```bash
# 连接数据库
sshpass -p 'rZTFErb@YJh8D' ssh -o StrictHostKeyChecking=no root@191.101.232.50 "docker exec -e PGPASSWORD=ruiqifeng2014 postgres-db psql -U postgres -d learning_english"

# 创建数据库备份
sshpass -p 'rZTFErb@YJh8D' ssh -o StrictHostKeyChecking=no root@191.101.232.50 "docker exec -e PGPASSWORD=ruiqifeng2014 postgres-db pg_dump -U postgres learning_english > backup.sql"
```

## ⚠️ 安全提醒

1. **不要将此文件提交到公共Git仓库**
2. **定期更改密码**
3. **限制服务器访问权限**
4. **使用SSH密钥认证（推荐）**

## 📝 部署历史

- Docker镜像: `iocas/learning-english-backend:latest`
- 最后部署: 2025-07-20
- 数据库已初始化: ✅
- 域名已配置: ✅