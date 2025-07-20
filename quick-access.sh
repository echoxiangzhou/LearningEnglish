#!/bin/bash

# 快速访问脚本
# 用法: ./quick-access.sh [命令]

SERVER_IP="191.101.232.50"
SERVER_USER="root"
SERVER_PASS="rZTFErb@YJh8D"

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# SSH连接函数
ssh_connect() {
    log_info "连接到服务器 ${SERVER_IP}..."
    sshpass -p "${SERVER_PASS}" ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} "$@"
}

# 显示帮助
show_help() {
    echo "快速访问服务器脚本"
    echo ""
    echo "用法:"
    echo "  ./quick-access.sh [命令]"
    echo ""
    echo "示例:"
    echo "  ./quick-access.sh                    # 直接SSH登录"
    echo "  ./quick-access.sh 'docker ps'       # 查看容器状态"
    echo "  ./quick-access.sh logs              # 查看应用日志"
    echo "  ./quick-access.sh restart           # 重启应用"
    echo "  ./quick-access.sh db                # 连接数据库"
    echo ""
}

# 主函数
case "$1" in
    "")
        log_info "SSH登录到服务器..."
        ssh_connect
        ;;
    "logs")
        log_info "查看应用日志..."
        ssh_connect "docker logs -f \$(docker ps | grep learning-english-backend | awk '{print \$1}' | head -1)"
        ;;
    "restart")
        log_info "重启应用..."
        ssh_connect "docker restart \$(docker ps | grep learning-english-backend | awk '{print \$1}' | head -1)"
        ;;
    "db")
        log_info "连接数据库..."
        ssh_connect "docker exec -e PGPASSWORD=ruiqifeng2014 -it postgres-db psql -U postgres -d learning_english"
        ;;
    "status")
        log_info "查看服务状态..."
        ssh_connect "docker ps | grep -E '(learning|postgres|kokoro)'"
        ;;
    "help"|"-h"|"--help")
        show_help
        ;;
    *)
        log_info "执行命令: $*"
        ssh_connect "$@"
        ;;
esac