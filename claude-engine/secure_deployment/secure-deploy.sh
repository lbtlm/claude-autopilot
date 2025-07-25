#!/bin/bash

# 统一安全部署脚本 - 支持动态端口配置
# 使用方法: ./secure-deploy.sh <项目名> <环境> [版本] [端口]

set -euo pipefail

# =============== 配置变量 ===============
PROJECT_NAME="${1:-}"
ENVIRONMENT="${2:-staging}"
VERSION="${3:-$(git describe --tags --always --dirty 2>/dev/null || echo "dev")}"
CUSTOM_PORT="${4:-}"

# 验证参数
if [ -z "$PROJECT_NAME" ]; then
    echo "❌ 错误: 请指定项目名称"
    echo "使用方法: $0 <项目名> <环境> [版本] [端口]"
    exit 1
fi

# Docker配置
DOCKER_REGISTRY="${DOCKER_REGISTRY:-your-dockerhub-username}"
IMAGE_NAME="${DOCKER_REGISTRY}/${PROJECT_NAME}"
IMAGE_TAG="${IMAGE_NAME}:${VERSION}"
LATEST_TAG="${IMAGE_NAME}:latest"

# 项目配置文件路径
PROJECT_CONFIG=".env.${ENVIRONMENT}"
if [ ! -f "$PROJECT_CONFIG" ]; then
    echo "⚠️  警告: 未找到环境配置文件 $PROJECT_CONFIG"
    PROJECT_CONFIG=".env.example"
fi

# 读取项目配置
if [ -f "$PROJECT_CONFIG" ]; then
    source "$PROJECT_CONFIG"
fi

# 端口配置（优先级：命令行参数 > 环境变量 > 配置文件 > 默认值）
if [ -n "$CUSTOM_PORT" ]; then
    APP_PORT="$CUSTOM_PORT"
elif [ -n "${PORT:-}" ]; then
    APP_PORT="$PORT"
elif [ -n "${APP_PORT:-}" ]; then
    APP_PORT="$APP_PORT"
else
    # 根据项目类型设置默认端口
    case "$ENVIRONMENT" in
        "staging")
            APP_PORT="8080"
            ;;
        "production")
            APP_PORT="80"
            ;;
        *)
            APP_PORT="8080"
            ;;
    esac
fi

# Host配置
APP_HOST="${HOST:-0.0.0.0}"

# 远程服务器配置
case $ENVIRONMENT in
    "staging")
        REMOTE_HOST="${STAGING_HOST:-staging.example.com}"
        DOCKER_COMPOSE_FILE="docker-compose.staging.yml"
        ;;
    "production")
        REMOTE_HOST="${PRODUCTION_HOST:-prod.example.com}"
        DOCKER_COMPOSE_FILE="docker-compose.prod.yml"
        ;;
    *)
        echo "❌ 错误: 不支持的环境 $ENVIRONMENT"
        exit 1
        ;;
esac

echo "🚀 开始安全部署流程..."
echo "  项目名称: $PROJECT_NAME"
echo "  部署环境: $ENVIRONMENT"
echo "  应用版本: $VERSION"
echo "  监听地址: $APP_HOST:$APP_PORT"
echo "  目标服务器: $REMOTE_HOST"

# =============== 安全检查阶段 ===============
echo "🔒 执行安全检查..."

# 检查是否有未提交的更改
if [[ $(git status --porcelain) ]]; then
    echo "⚠️  警告: 有未提交的更改，确定要部署吗? (y/N)"
    read -r confirm
    [[ $confirm == [yY] ]] || exit 1
fi

# 检查Go项目的安全性
if [ -f "go.mod" ]; then
    echo "🔍 运行Go安全扫描..."
    if command -v gosec &> /dev/null; then
        gosec ./... || {
            echo "❌ Go安全扫描失败，请修复安全问题后重试"
            exit 1
        }
    else
        echo "⚠️  未安装gosec，跳过Go安全扫描"
    fi
    
    # 检查依赖漏洞
    echo "🔍 检查Go依赖漏洞..."
    go list -json -m all | head -20 > /dev/null || {
        echo "❌ 依赖检查失败"
        exit 1
    }
fi

# =============== 构建阶段 ===============
echo "🏗️  构建Docker镜像..."

# 清理之前的构建
docker system prune -f

# 构建镜像（多阶段构建，确保无源码泄露）
docker build \
    --no-cache \
    --build-arg BUILD_TIME="$(date +%Y-%m-%d_%H:%M:%S)" \
    --build-arg VERSION="$VERSION" \
    --build-arg HOST="$APP_HOST" \
    --build-arg PORT="$APP_PORT" \
    -t "$IMAGE_TAG" \
    -t "$LATEST_TAG" \
    -f Dockerfile .

# =============== 安全验证阶段 ===============
echo "🔍 验证镜像安全性..."

# 检查镜像是否包含源码文件
echo "📋 检查镜像内容..."
SOURCE_FILES=$(docker run --rm --entrypoint="" "$IMAGE_TAG" sh -c "find / -name '*.go' -o -name '*.mod' -o -name '*.sum' 2>/dev/null | head -5" 2>/dev/null || echo "")
if [[ -n "$SOURCE_FILES" ]]; then
    echo "❌ 错误: 镜像中发现源码文件!"
    echo "$SOURCE_FILES"
    exit 1
fi

# 检查镜像大小
IMAGE_SIZE=$(docker images "$IMAGE_TAG" --format "{{.Size}}" | head -1)
echo "📦 镜像大小: $IMAGE_SIZE"

# 验证环境变量配置
echo "🔧 验证环境变量配置..."
ENV_TEST=$(docker run --rm --entrypoint="" -e HOST="$APP_HOST" -e PORT="$APP_PORT" "$IMAGE_TAG" printenv HOST PORT 2>/dev/null || echo "ENV_FAILED")
if [[ "$ENV_TEST" == "ENV_FAILED" ]]; then
    echo "⚠️  环境变量测试失败，但继续部署"
fi

# 扫描镜像漏洞（如果有trivy）
if command -v trivy &> /dev/null; then
    echo "🔍 扫描镜像漏洞..."
    trivy image --severity HIGH,CRITICAL "$IMAGE_TAG"
fi

# =============== 推送阶段 ===============
echo "📤 推送镜像到Docker Hub..."

# 登录Docker Hub（使用访问令牌）
if [ -n "${DOCKER_HUB_TOKEN:-}" ]; then
    echo "$DOCKER_HUB_TOKEN" | docker login -u "$DOCKER_REGISTRY" --password-stdin
else
    echo "⚠️  未设置DOCKER_HUB_TOKEN环境变量，请手动登录Docker Hub"
    docker login
fi

# 推送镜像
docker push "$IMAGE_TAG"
docker push "$LATEST_TAG"

echo "✅ 镜像推送完成: $IMAGE_TAG"

# =============== 部署阶段 ===============
echo "🚀 部署到 $ENVIRONMENT 环境..."

# 生成动态的docker-compose配置
cat > "/tmp/${PROJECT_NAME}-${ENVIRONMENT}.yml" << EOF
version: '3.8'

services:
  ${PROJECT_NAME}:
    image: ${IMAGE_TAG}
    container_name: ${PROJECT_NAME}-${ENVIRONMENT}
    ports:
      - "${APP_PORT}:${APP_PORT}"
    environment:
      - HOST=${APP_HOST}
      - PORT=${APP_PORT}
      - ENV=${ENVIRONMENT}
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "/app", "--health-check"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
EOF

# 在远程服务器执行部署
ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" << EOF
    # 拉取最新镜像
    docker pull $IMAGE_TAG
    
    # 上传compose文件
    cat > ${PROJECT_NAME}-${ENVIRONMENT}.yml << 'COMPOSE_EOF'
$(cat "/tmp/${PROJECT_NAME}-${ENVIRONMENT}.yml")
COMPOSE_EOF
    
    # 停止旧容器
    docker-compose -f ${PROJECT_NAME}-${ENVIRONMENT}.yml down || true
    
    # 启动新容器
    docker-compose -f ${PROJECT_NAME}-${ENVIRONMENT}.yml up -d
    
    # 健康检查
    sleep 15
    
    # 检查容器状态
    if ! docker ps | grep -q ${PROJECT_NAME}-${ENVIRONMENT}; then
        echo "❌ 容器启动失败"
        docker logs ${PROJECT_NAME}-${ENVIRONMENT}
        exit 1
    fi
    
    # 应用级健康检查
    for i in {1..10}; do
        if curl -f -m 5 http://localhost:${APP_PORT}/health 2>/dev/null; then
            echo "✅ 应用健康检查通过"
            break
        fi
        if [ \$i -eq 10 ]; then
            echo "❌ 应用健康检查失败"
            docker logs ${PROJECT_NAME}-${ENVIRONMENT}
            exit 1
        fi
        echo "⏳ 等待应用启动... (\$i/10)"
        sleep 3
    done
    
    # 清理旧镜像
    docker image prune -f
EOF

# 清理临时文件
rm -f "/tmp/${PROJECT_NAME}-${ENVIRONMENT}.yml"

echo "✅ 部署完成!"
echo "🌐 服务地址: http://$REMOTE_HOST:$APP_PORT"
echo "📊 健康检查: http://$REMOTE_HOST:$APP_PORT/health"

# =============== 部署后验证 ===============
echo "🔍 执行部署后验证..."

# 远程健康检查
if curl -f -m 10 "http://$REMOTE_HOST:$APP_PORT/health" &>/dev/null; then
    echo "✅ 远程健康检查通过"
else
    echo "⚠️  远程健康检查失败，请手动验证服务状态"
fi

echo "🎉 安全部署流程完成！"
echo "📝 部署信息:"
echo "  项目: $PROJECT_NAME"
echo "  版本: $VERSION"
echo "  环境: $ENVIRONMENT"
echo "  地址: $APP_HOST:$APP_PORT"
echo "  镜像: $IMAGE_TAG"