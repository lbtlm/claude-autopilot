#!/bin/bash
set -euo pipefail

# Claude Autopilot 2.1 生产安全部署脚本
# 功能：零停机部署、数据保护、智能健康检查

PROJECT_NAME="\${PROJECT_NAME:-myapp}"
IMAGE_NAME="\${IMAGE_NAME:-\$PROJECT_NAME:latest}"
CONTAINER_NAME="\${CONTAINER_NAME:-\$PROJECT_NAME}"
APP_PORT="\${APP_PORT:-8080}"

echo "🚀 开始生产安全部署..."
echo "   项目: \$PROJECT_NAME"
echo "   镜像: \$IMAGE_NAME"
echo "   端口: \$APP_PORT"

# 停止旧服务（保护数据卷）
if docker ps -q -f name=\$CONTAINER_NAME | grep -q .; then
    echo "⏹️  停止旧服务..."
    docker stop \$CONTAINER_NAME || true
    docker rm \$CONTAINER_NAME || true
fi

# 启动新服务
echo "▶️  启动新服务..."
docker compose -f docker-compose.smart.yml up -d

# 健康检查
echo "🔍 等待服务健康检查..."
for i in {1..30}; do
    if curl -sf http://localhost:\$APP_PORT/health > /dev/null 2>&1; then
        echo "✅ 服务部署成功！"
        exit 0
    fi
    echo "   尝试 \$i/30..."
    sleep 2
done

echo "❌ 健康检查失败，请检查服务状态"
docker logs \$CONTAINER_NAME --tail 50
exit 1
