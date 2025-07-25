#!/bin/bash

# Claude Autopilot 2.1 部署策略管理器
# 基于项目类型和环境要求提供智能部署策略

# 动态检测路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_CE_PATH="$(dirname "$SCRIPT_DIR")"
DEPLOYMENT_STRATEGIES_DIR="$GLOBAL_CE_PATH/deployment-strategies"
CURRENT_STRATEGY=""
DEPLOYMENT_CONFIG=""

# 初始化部署策略管理器
init_deployment_strategy_manager() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    echo "🚀 初始化部署策略管理器..."
    
    # 创建部署策略目录
    mkdir -p "$project_path/deployments"
    mkdir -p "$project_path/deployments/docker"
    mkdir -p "$project_path/deployments/k8s"
    mkdir -p "$project_path/deployments/scripts"
    
    # 分析项目部署需求
    analyze_deployment_requirements "$project_path" "$project_type"
    
    # 生成部署策略
    generate_deployment_strategy "$project_path" "$project_type" "$project_name"
    
    # 创建部署脚本
    create_deployment_scripts "$project_path" "$project_type" "$project_name"
    
    echo "✅ 部署策略管理器初始化完成"
}

# 分析项目部署需求
analyze_deployment_requirements() {
    local project_path="$1" 
    local project_type="$2"
    
    echo "🔍 分析项目部署需求..."
    
    # 检测数据库需求
    local needs_database=false
    local database_type=""
    
    if [ -f "$project_path/go.mod" ]; then
        if grep -q "gorm\|database/sql\|postgres\|mysql" "$project_path/go.mod" 2>/dev/null; then
            needs_database=true
            if grep -q "postgres" "$project_path/go.mod" 2>/dev/null; then
                database_type="postgresql"
            elif grep -q "mysql" "$project_path/go.mod" 2>/dev/null; then
                database_type="mysql"
            else
                database_type="postgresql"  # 默认
            fi
        fi
    elif [ -f "$project_path/package.json" ]; then
        if grep -q "mongoose\|sequelize\|prisma\|pg\|mysql" "$project_path/package.json" 2>/dev/null; then
            needs_database=true
            if grep -q "pg\|postgres" "$project_path/package.json" 2>/dev/null; then
                database_type="postgresql"
            elif grep -q "mysql" "$project_path/package.json" 2>/dev/null; then
                database_type="mysql"
            else
                database_type="postgresql"  # 默认
            fi
        fi
    elif [ -f "$project_path/requirements.txt" ] || [ -f "$project_path/pyproject.toml" ]; then
        if grep -q "sqlalchemy\|django\|psycopg\|pymysql" "$project_path/requirements.txt" "$project_path/pyproject.toml" 2>/dev/null; then
            needs_database=true
            if grep -q "psycopg\|postgres" "$project_path/requirements.txt" "$project_path/pyproject.toml" 2>/dev/null; then
                database_type="postgresql"
            elif grep -q "pymysql\|mysql" "$project_path/requirements.txt" "$project_path/pyproject.toml" 2>/dev/null; then
                database_type="mysql"
            else
                database_type="postgresql"  # 默认
            fi
        fi
    fi
    
    # 检测Redis需求
    local needs_redis=false
    if find "$project_path" -name "*.go" -o -name "*.js" -o -name "*.ts" -o -name "*.py" 2>/dev/null | \
        xargs grep -l -i "redis" 2>/dev/null | head -1 | grep -q .; then
        needs_redis=true
    fi
    
    # 检测静态文件服务需求
    local needs_nginx=false
    case "$project_type" in
        *"frontend"*|*"web"*)
            needs_nginx=true
            ;;
    esac
    
    # 保存分析结果
    DEPLOYMENT_CONFIG="database=$needs_database;database_type=$database_type;redis=$needs_redis;nginx=$needs_nginx"
    
    echo "   📊 分析结果:"
    echo "   - 数据库需求: $needs_database ($database_type)"
    echo "   - Redis需求: $needs_redis"
    echo "   - Nginx需求: $needs_nginx"
}

# 生成部署策略
generate_deployment_strategy() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    echo "📋 生成部署策略..."
    
    # 解析配置
    local needs_database=$(echo "$DEPLOYMENT_CONFIG" | grep -o "database=[^;]*" | cut -d= -f2)
    local database_type=$(echo "$DEPLOYMENT_CONFIG" | grep -o "database_type=[^;]*" | cut -d= -f2)
    local needs_redis=$(echo "$DEPLOYMENT_CONFIG" | grep -o "redis=[^;]*" | cut -d= -f2)
    local needs_nginx=$(echo "$DEPLOYMENT_CONFIG" | grep -o "nginx=[^;]*" | cut -d= -f2)
    
    # 确定部署策略
    if [[ "$needs_database" == "true" && "$needs_redis" == "true" ]]; then
        CURRENT_STRATEGY="full-stack"
    elif [[ "$needs_database" == "true" ]]; then
        CURRENT_STRATEGY="database-app"
    elif [[ "$needs_nginx" == "true" ]]; then
        CURRENT_STRATEGY="frontend-app"
    else
        CURRENT_STRATEGY="simple-app"
    fi
    
    echo "   🎯 选择策略: $CURRENT_STRATEGY"
    
    # 生成Docker Compose配置
    create_docker_compose_config "$project_path" "$project_name" "$CURRENT_STRATEGY"
    
    # 生成Dockerfile
    create_dockerfile "$project_path" "$project_type"
    
    # 生成Kubernetes配置（可选）
    create_kubernetes_config "$project_path" "$project_name" "$CURRENT_STRATEGY"
    
    # 生成部署配置文档
    create_deployment_documentation "$project_path" "$project_name" "$CURRENT_STRATEGY"
}

# 创建Docker Compose配置
create_docker_compose_config() {
    local project_path="$1"
    local project_name="$2"
    local strategy="$3"
    
    local compose_file="$project_path/docker-compose.yml"
    
    echo "🐳 创建Docker Compose配置..."
    
    # 解析配置
    local needs_database=$(echo "$DEPLOYMENT_CONFIG" | grep -o "database=[^;]*" | cut -d= -f2)
    local database_type=$(echo "$DEPLOYMENT_CONFIG" | grep -o "database_type=[^;]*" | cut -d= -f2)
    local needs_redis=$(echo "$DEPLOYMENT_CONFIG" | grep -o "redis=[^;]*" | cut -d= -f2)
    local needs_nginx=$(echo "$DEPLOYMENT_CONFIG" | grep -o "nginx=[^;]*" | cut -d= -f2)
    
    cat > "$compose_file" << EOF
version: '3.8'

services:
  app:
    build: .
    container_name: ${project_name}-app
    ports:
      - "8080:8080"
    environment:
      - APP_ENV=production
      - APP_NAME=$project_name
EOF
    
    # 如果需要数据库，添加数据库服务配置
    if [[ "$needs_database" == "true" ]]; then
        cat >> "$compose_file" << EOF
      - DATABASE_URL=${database_type}://user:password@db:5432/${project_name}
    depends_on:
      - db
    networks:
      - app-network

  db:
    image: ${database_type}:latest
    container_name: ${project_name}-db
    environment:
EOF
        
        if [[ "$database_type" == "postgresql" ]]; then
            cat >> "$compose_file" << EOF
      - POSTGRES_DB=$project_name
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    ports:
      - "5432:5432"
EOF
        else  # MySQL
            cat >> "$compose_file" << EOF
      - MYSQL_DATABASE=$project_name
      - MYSQL_USER=user
      - MYSQL_PASSWORD=password
      - MYSQL_ROOT_PASSWORD=rootpassword
    ports:
      - "3306:3306"
EOF
        fi
        
        cat >> "$compose_file" << EOF
    volumes:
      - db_data:/var/lib/${database_type}/data
    networks:
      - app-network
EOF
    else
        cat >> "$compose_file" << EOF
    networks:
      - app-network
EOF
    fi
    
    # 如果需要Redis，添加Redis服务
    if [[ "$needs_redis" == "true" ]]; then
        cat >> "$compose_file" << EOF

  redis:
    image: redis:alpine
    container_name: ${project_name}-redis
    ports:
      - "6379:6379"
    networks:
      - app-network
EOF
    fi
    
    # 如果需要Nginx，添加Nginx服务
    if [[ "$needs_nginx" == "true" ]]; then
        cat >> "$compose_file" << EOF

  nginx:
    image: nginx:alpine
    container_name: ${project_name}-nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./deployments/nginx/nginx.conf:/etc/nginx/nginx.conf
      - ./deployments/nginx/ssl:/etc/nginx/ssl
    depends_on:
      - app
    networks:
      - app-network
EOF
    fi
    
    # 添加网络和卷配置
    cat >> "$compose_file" << EOF

networks:
  app-network:
    driver: bridge

volumes:
EOF
    
    if [[ "$needs_database" == "true" ]]; then
        cat >> "$compose_file" << EOF
  db_data:
EOF
    else
        cat >> "$compose_file" << EOF
  # 暂无持久化数据卷需求
EOF
    fi
    
    echo "   ✅ Docker Compose配置: docker-compose.yml"
    
    # 创建环境变量文件
    create_docker_env_file "$project_path" "$project_name"
    
    # 如果需要Nginx，创建Nginx配置
    if [[ "$needs_nginx" == "true" ]]; then
        create_nginx_config "$project_path" "$project_name"
    fi
}

# 创建Dockerfile
create_dockerfile() {
    local project_path="$1"
    local project_type="$2"
    
    local dockerfile="$project_path/Dockerfile"
    
    if [ -f "$dockerfile" ]; then
        echo "   ℹ️ Dockerfile已存在，跳过创建"
        return
    fi
    
    echo "🐳 创建Dockerfile..."
    
    case "$project_type" in
        "gin-microservice"|"go-general"|"go-desktop")
            cat > "$dockerfile" << 'EOF'
# 构建阶段
FROM golang:1.21-alpine AS builder

WORKDIR /app

# 复制go mod文件
COPY go.mod go.sum ./
RUN go mod download

# 复制源代码
COPY . .

# 构建应用
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main ./cmd

# 运行阶段
FROM alpine:latest

# 安装ca-certificates for HTTPS
RUN apk --no-cache add ca-certificates tzdata

WORKDIR /root/

# 从构建阶段复制二进制文件
COPY --from=builder /app/main .
COPY --from=builder /app/.env.example .env

# 暴露端口
EXPOSE 8080

# 运行应用
CMD ["./main"]
EOF
            ;;
        "vue3-frontend"|"vue2-frontend"|"react-frontend"|"nextjs-frontend")
            cat > "$dockerfile" << 'EOF'
# 构建阶段
FROM node:18-alpine AS builder

WORKDIR /app

# 复制package文件
COPY package*.json ./
RUN npm ci --only=production

# 复制源代码
COPY . .

# 构建应用
RUN npm run build

# 运行阶段
FROM nginx:alpine

# 复制构建结果到nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# 复制nginx配置
COPY deployments/nginx/nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
EOF
            ;;
        "python-web"|"python-desktop")
            cat > "$dockerfile" << 'EOF'
FROM python:3.11-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 复制requirements文件
COPY requirements.txt .

# 安装Python依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY . .

# 创建非root用户
RUN useradd --create-home --shell /bin/bash app && chown -R app:app /app
USER app

# 暴露端口
EXPOSE 8000

# 启动应用
CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOF
            ;;
        "nodejs-general")
            cat > "$dockerfile" << 'EOF'
FROM node:18-alpine

WORKDIR /app

# 复制package文件
COPY package*.json ./

# 安装依赖
RUN npm ci --only=production

# 复制应用代码
COPY . .

# 创建非root用户
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs

# 暴露端口
EXPOSE 3000

# 启动应用
CMD ["npm", "start"]
EOF
            ;;
        *)
            cat > "$dockerfile" << 'EOF'
# 通用Dockerfile模板
# 请根据具体项目类型进行定制

FROM alpine:latest

WORKDIR /app

# 安装基础工具
RUN apk add --no-cache ca-certificates

# 复制应用文件
COPY . .

# 暴露端口
EXPOSE 8080

# 启动命令（请根据实际情况修改）
CMD ["echo", "请根据项目类型定制启动命令"]
EOF
            ;;
    esac
    
    echo "   ✅ Dockerfile创建完成"
}

# 创建Docker环境变量文件
create_docker_env_file() {
    local project_path="$1"
    local project_name="$2"
    
    local env_file="$project_path/.env.docker"
    
    cat > "$env_file" << EOF
# Docker部署环境变量配置
# 生产环境使用

# 应用配置
APP_NAME=$project_name
APP_ENV=production
APP_DEBUG=false
APP_URL=https://yourdomain.com

# 数据库配置（根据需要修改）
DATABASE_URL=postgresql://user:password@db:5432/$project_name
DB_HOST=db
DB_PORT=5432
DB_DATABASE=$project_name
DB_USERNAME=user
DB_PASSWORD=password

# Redis配置
REDIS_HOST=redis
REDIS_PORT=6379

# JWT配置
JWT_SECRET=your-production-jwt-secret-here
JWT_EXPIRY=24h

# API配置
API_KEY=your-production-api-key
API_URL=https://api.yourdomain.com

# 日志配置
LOG_LEVEL=info
LOG_FORMAT=json

# 邮件配置
MAIL_HOST=smtp.yourdomain.com
MAIL_PORT=587
MAIL_USERNAME=noreply@yourdomain.com
MAIL_PASSWORD=your-mail-password
EOF
    
    echo "   ✅ Docker环境变量文件: .env.docker"
}

# 创建Nginx配置
create_nginx_config() {
    local project_path="$1"
    local project_name="$2"
    
    mkdir -p "$project_path/deployments/nginx"
    local nginx_conf="$project_path/deployments/nginx/nginx.conf"
    
    cat > "$nginx_conf" << 'EOF'
events {
    worker_connections 1024;
}

http {
    upstream app {
        server app:8080;
    }

    server {
        listen 80;
        server_name localhost;

        # 重定向到HTTPS
        return 301 https://$server_name$request_uri;
    }

    server {
        listen 443 ssl http2;
        server_name localhost;

        # SSL配置
        ssl_certificate /etc/nginx/ssl/cert.pem;
        ssl_certificate_key /etc/nginx/ssl/key.pem;
        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384;
        ssl_prefer_server_ciphers off;

        # 安全头
        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;
        add_header X-XSS-Protection "1; mode=block";
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

        # 日志配置
        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        # 反向代理配置
        location / {
            proxy_pass http://app;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            
            # 超时设置
            proxy_connect_timeout 30s;
            proxy_send_timeout 30s;
            proxy_read_timeout 30s;
        }

        # 静态文件缓存
        location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
            expires 1y;
            add_header Cache-Control "public, immutable";
        }

        # 健康检查
        location /health {
            proxy_pass http://app;
            access_log off;
        }
    }
}
EOF
    
    echo "   ✅ Nginx配置: deployments/nginx/nginx.conf"
}

# 创建Kubernetes配置
create_kubernetes_config() {
    local project_path="$1"
    local project_name="$2"
    local strategy="$3"
    
    echo "☸️ 创建Kubernetes配置..."
    
    mkdir -p "$project_path/deployments/k8s"
    
    # 创建Deployment配置
    cat > "$project_path/deployments/k8s/deployment.yaml" << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $project_name
  labels:
    app: $project_name
spec:
  replicas: 3
  selector:
    matchLabels:
      app: $project_name
  template:
    metadata:
      labels:
        app: $project_name
    spec:
      containers:
      - name: $project_name
        image: $project_name:latest
        ports:
        - containerPort: 8080
        env:
        - name: APP_ENV
          value: "production"
        - name: APP_NAME
          value: "$project_name"
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: $project_name-service
spec:
  selector:
    app: $project_name
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: ClusterIP
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $project_name-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: $project_name.yourdomain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: $project_name-service
            port:
              number: 80
EOF
    
    echo "   ✅ Kubernetes配置: deployments/k8s/deployment.yaml"
}

# 创建部署脚本
create_deployment_scripts() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    echo "📜 创建部署脚本..."
    
    # 创建本地部署脚本
    create_local_deploy_script "$project_path" "$project_name"
    
    # 创建Docker部署脚本
    create_docker_deploy_script "$project_path" "$project_name"
    
    # 创建生产部署脚本
    create_production_deploy_script "$project_path" "$project_name"
}

# 创建本地部署脚本
create_local_deploy_script() {
    local project_path="$1"
    local project_name="$2"
    
    local script_file="$project_path/deployments/scripts/deploy-local.sh"
    
    cat > "$script_file" << 'EOF'
#!/bin/bash

# 本地开发环境部署脚本

set -e

echo "🚀 开始本地部署..."

# 检查环境变量文件
if [ ! -f ".env" ]; then
    echo "⚠️ .env文件不存在，从.env.example复制"
    cp .env.example .env
    echo "请编辑.env文件配置必要的环境变量"
fi

# 安装依赖
echo "📦 安装依赖..."
make install

# 运行测试
echo "🧪 运行测试..."
make test

# 代码检查
echo "🔍 代码检查..."
make lint

# 启动服务
echo "🎯 启动开发服务..."
make dev
EOF
    
    chmod +x "$script_file"
    echo "   ✅ 本地部署脚本: deployments/scripts/deploy-local.sh"
}

# 创建Docker部署脚本
create_docker_deploy_script() {
    local project_path="$1"
    local project_name="$2"
    
    local script_file="$project_path/deployments/scripts/deploy-docker.sh"
    
    cat > "$script_file" << EOF
#!/bin/bash

# Docker环境部署脚本

set -e

PROJECT_NAME="$project_name"

echo "🐳 开始Docker部署..."

# 检查Docker是否运行
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker未运行，请启动Docker"
    exit 1
fi

# 检查环境变量文件
if [ ! -f ".env.docker" ]; then
    echo "⚠️ .env.docker文件不存在，从模板创建"
    echo "请编辑.env.docker文件配置生产环境变量"
    exit 1
fi

# 构建镜像
echo "🏗️ 构建Docker镜像..."
docker build -t \$PROJECT_NAME:latest .

# 停止现有容器
echo "🛑 停止现有容器..."
docker-compose down

# 启动服务
echo "🚀 启动Docker服务..."
docker-compose --env-file .env.docker up -d

# 检查服务状态
echo "🔍 检查服务状态..."
sleep 10
docker-compose ps

# 健康检查
echo "🏥 执行健康检查..."
if curl -f http://localhost:8080/health > /dev/null 2>&1; then
    echo "✅ 部署成功！服务健康检查通过"
else
    echo "❌ 健康检查失败，请查看日志"
    docker-compose logs
    exit 1
fi

echo "🎉 Docker部署完成！"
echo "访问地址: http://localhost:8080"
EOF
    
    chmod +x "$script_file"
    echo "   ✅ Docker部署脚本: deployments/scripts/deploy-docker.sh"
}

# 创建生产部署脚本
create_production_deploy_script() {
    local project_path="$1"
    local project_name="$2"
    
    local script_file="$project_path/deployments/scripts/deploy-production.sh"
    
    cat > "$script_file" << EOF
#!/bin/bash

# 生产环境部署脚本

set -e

PROJECT_NAME="$project_name"
DOCKER_REGISTRY="\${DOCKER_REGISTRY:-your-registry.com}"
VERSION="\${VERSION:-\$(git rev-parse --short HEAD)}"

echo "🚀 开始生产环境部署..."
echo "项目: \$PROJECT_NAME"
echo "版本: \$VERSION"
echo "镜像仓库: \$DOCKER_REGISTRY"

# 预部署检查
echo "🔍 执行预部署检查..."

# 检查Git状态
if [ -n "\$(git status --porcelain)" ]; then
    echo "⚠️ 工作目录有未提交的更改"
    read -p "继续部署？(y/N): " -n 1 -r
    echo
    if [[ ! \$REPLY =~ ^[Yy]\$ ]]; then
        exit 1
    fi
fi

# 运行测试
echo "🧪 运行测试套件..."
make test

# 代码检查
echo "🔍 执行代码检查..."
make lint

# 安全扫描
echo "🔒 执行安全扫描..."
make security-scan

# 构建生产镜像
echo "🏗️ 构建生产镜像..."
docker build -t \$DOCKER_REGISTRY/\$PROJECT_NAME:\$VERSION .
docker tag \$DOCKER_REGISTRY/\$PROJECT_NAME:\$VERSION \$DOCKER_REGISTRY/\$PROJECT_NAME:latest

# 推送镜像到仓库
echo "📤 推送镜像到仓库..."
docker push \$DOCKER_REGISTRY/\$PROJECT_NAME:\$VERSION
docker push \$DOCKER_REGISTRY/\$PROJECT_NAME:latest

# 部署到生产环境
echo "🚀 部署到生产环境..."
# 这里可以集成具体的部署方式：
# - Docker Swarm部署
# - Kubernetes部署  
# - 服务器直接部署等

# 示例：Kubernetes部署
# kubectl set image deployment/\$PROJECT_NAME \$PROJECT_NAME=\$DOCKER_REGISTRY/\$PROJECT_NAME:\$VERSION

echo "⏳ 等待部署完成..."
sleep 30

# 部署后验证
echo "🔍 执行部署后验证..."
# 健康检查
# 烟雾测试
# 监控指标检查

echo "🎉 生产环境部署完成！"
echo "版本: \$VERSION"
echo "记得更新CHANGELOG.md"
EOF
    
    chmod +x "$script_file"
    echo "   ✅ 生产部署脚本: deployments/scripts/deploy-production.sh"
}

# 创建部署文档
create_deployment_documentation() {
    local project_path="$1"
    local project_name="$2"
    local strategy="$3"
    
    echo "📚 创建部署文档..."
    
    # 更新已有的DEPLOYMENT.md，添加具体配置信息
    local deploy_doc="$project_path/project_docs/DEPLOYMENT.md"
    
    # 在现有文档基础上添加策略特定信息
    cat >> "$deploy_doc" << EOF

## 🎯 **部署策略: $strategy**

基于项目分析，自动选择了 **$strategy** 部署策略。

### 部署组件

$(echo "$DEPLOYMENT_CONFIG" | sed 's/;/\n/g' | sed 's/=/: /' | sed 's/^/- /')

### 快速部署命令

#### 本地开发环境
\`\`\`bash
# 本地部署
./deployments/scripts/deploy-local.sh
\`\`\`

#### Docker环境
\`\`\`bash
# 配置环境变量
cp .env.example .env.docker
vim .env.docker

# Docker部署
./deployments/scripts/deploy-docker.sh
\`\`\`

#### 生产环境
\`\`\`bash
# 生产部署（需要配置镜像仓库）
export DOCKER_REGISTRY=your-registry.com
export VERSION=v1.0.0
./deployments/scripts/deploy-production.sh
\`\`\`

### 智能部署命令

项目已集成智能部署系统，可使用以下命令：

\`\`\`bash
# Claude Code中执行
/智能部署推送Docker

# 或使用英文命令
/smart-docker-deploy
\`\`\`

### 配置文件说明

- \`docker-compose.yml\` - Docker服务编排配置
- \`.env.docker\` - Docker环境变量配置  
- \`deployments/nginx/nginx.conf\` - Nginx反向代理配置
- \`deployments/k8s/\` - Kubernetes部署配置
- \`deployments/scripts/\` - 部署脚本集合

### 监控和维护

部署完成后，访问以下端点进行监控：

- 健康检查: \`/health\`
- API文档: \`/swagger/index.html\` (如果有)
- 应用日志: \`docker-compose logs -f app\`
- 数据库日志: \`docker-compose logs -f db\`

---
*本部署策略由Claude Autopilot 2.1智能分析生成*
EOF
    
    echo "   ✅ 部署文档已更新: project_docs/DEPLOYMENT.md"
}

# 主函数 - 如果直接执行此脚本
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    if [ -z "$1" ]; then
        echo "使用: $0 <project_path> [project_type] [project_name]"
        echo "示例: $0 /path/to/project gin-microservice myapp"
        exit 1
    fi
    
    PROJECT_PATH=$(realpath "$1")
    PROJECT_TYPE="${2:-unknown}"
    PROJECT_NAME="${3:-$(basename "$PROJECT_PATH")}"
    
    init_deployment_strategy_manager "$PROJECT_PATH" "$PROJECT_TYPE" "$PROJECT_NAME"
fi