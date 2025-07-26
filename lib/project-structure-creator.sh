#!/bin/bash

# Claude Autopilot 2.1 标准项目结构创建器
# 基于项目类型自动创建标准化目录结构和基础文件

# 动态检测脚本路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载核心模块
source "$SCRIPT_DIR/cross-platform-utils.sh"
source "$SCRIPT_DIR/template-parser.sh"

# 智能创建项目结构（新的动态方式）
create_standard_project_structure() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    echo "🏗️ 智能创建项目结构 (动态模板解析)..."
    echo "   项目类型: $project_type"
    echo "   项目路径: $project_path"
    echo ""
    
    # 使用智能模板解析器创建完整结构
    if create_project_from_template "$project_path" "$project_type" "$project_name"; then
        echo "✅ 项目结构创建成功！"
        return 0
    else
        echo "❌ 项目结构创建失败，回退到兼容模式..."
        # 回退到传统方式（兼容性保障）
        create_legacy_project_structure "$project_path" "$project_type" "$project_name"
        return $?
    fi
}

# 传统项目结构创建方式（兼容性保障）
create_legacy_project_structure() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    echo "🔄 使用传统模式创建项目结构..."
    
    # 创建通用基础结构
    create_universal_structure "$project_path" "$project_name"
    
    # 根据项目类型创建特定结构  
    case "$project_type" in
        "gin-microservice")
            create_gin_microservice_structure "$project_path" "$project_name"
            ;;
        "gin-vue3")
            create_gin_vue3_structure "$project_path" "$project_name"
            ;;
        "go-desktop")
            create_go_desktop_structure "$project_path" "$project_name"
            ;;
        "go-general")
            create_go_general_structure "$project_path" "$project_name"
            ;;
        "vue3-frontend")
            create_vue3_frontend_structure "$project_path" "$project_name"
            ;;
        "vue2-frontend")
            create_vue2_frontend_structure "$project_path" "$project_name"
            ;;
        "react-frontend")
            create_react_frontend_structure "$project_path" "$project_name"
            ;;
        "nextjs-frontend")
            create_nextjs_frontend_structure "$project_path" "$project_name"
            ;;
        "nodejs-general")
            create_nodejs_general_structure "$project_path" "$project_name"
            ;;
        "django"|"python-web")
            create_django_structure "$project_path" "$project_name"
            ;;
        "fastapi_vue3")
            create_fastapi_vue3_structure "$project_path" "$project_name"
            ;;
        "python-desktop")
            create_python_desktop_structure "$project_path" "$project_name"
            ;;
        "python-general")
            create_python_general_structure "$project_path" "$project_name"
            ;;
        "bash-scripts")
            create_bash_scripts_structure "$project_path" "$project_name"
            ;;
        "java-maven")
            create_java_maven_structure "$project_path" "$project_name"
            ;;
        "java-gradle")
            create_java_gradle_structure "$project_path" "$project_name"
            ;;
        "rust-project")
            create_rust_project_structure "$project_path" "$project_name"
            ;;
        "php-project")
            create_php_project_structure "$project_path" "$project_name"
            ;;
        *)
            create_generic_structure "$project_path" "$project_name"
            ;;
    esac
    
    echo "✅ 标准项目结构创建完成"
}

# 创建通用基础结构（所有项目都需要）
create_universal_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "📁 创建通用基础结构..."
    
    # 创建必要目录
    local universal_dirs=(
        "project_process"
        "project_process/daily"
        "project_process/reports"
        "project_process/prps"
        "project_process/bugfixes"
        "project_process/analysis"
        "project_docs"
        "docs"
        "scripts"
        "tests"
        ".vscode"
    )
    
    for dir in "${universal_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
            
            # 为空目录添加.gitkeep
            if [ -z "$(ls -A "$project_path/$dir" 2>/dev/null)" ]; then
                touch "$project_path/$dir/.gitkeep"
            fi
        fi
    done
    
    # 创建基础文件
    create_universal_files "$project_path" "$project_name"
}

# 创建通用基础文件
create_universal_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建.gitignore（如果不存在）
    if [ ! -f "$project_path/.gitignore" ]; then
        cat > "$project_path/.gitignore" << 'EOF'
# 依赖目录
node_modules/
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
env/
venv/
.venv/
.env

# 构建输出
dist/
build/
*.o
*.so
*.exe

# IDE和编辑器文件
.vscode/settings.json
.vscode/launch.json
.idea/
*.swp
*.swo
*~

# 系统文件
.DS_Store
Thumbs.db
desktop.ini

# 日志文件
*.log
logs/
Logs/

# 临时文件
*.tmp
*.temp
*.cache

# 测试覆盖报告
coverage/
.coverage
.nyc_output/
.pytest_cache/

# 部署相关
.env.production
.env.staging

# 项目特定忽略文件
# 在此添加项目特定的忽略规则
EOF
        echo "   ✅ 创建文件: .gitignore"
    fi
    
    # 创建.editorconfig（如果不存在）
    if [ ! -f "$project_path/.editorconfig" ]; then
        cat > "$project_path/.editorconfig" << 'EOF'
# EditorConfig helps developers define and maintain consistent
# coding styles between different editors and IDEs
# editorconfig.org

root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

[*.{py,go}]
indent_size = 4

[*.md]
trim_trailing_whitespace = false

[Makefile]
indent_style = tab
EOF
        echo "   ✅ 创建文件: .editorconfig"
    fi
    
    # 创建.env.example（如果不存在）
    if [ ! -f "$project_path/.env.example" ]; then
        cat > "$project_path/.env.example" << 'EOF'
# 应用配置
APP_NAME=MyApp
APP_ENV=development
APP_DEBUG=true
APP_URL=http://localhost

# 数据库配置
DATABASE_URL=
DB_HOST=localhost
DB_PORT=5432
DB_DATABASE=myapp
DB_USERNAME=
DB_PASSWORD=

# JWT配置
JWT_SECRET=your-super-secret-jwt-key-here
JWT_EXPIRY=24h

# API配置
API_KEY=your-api-key-here
API_URL=https://api.example.com

# Redis配置（可选）
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# 邮件配置（可选）
MAIL_HOST=
MAIL_PORT=587
MAIL_USERNAME=
MAIL_PASSWORD=
EOF
        echo "   ✅ 创建文件: .env.example"
    fi
    
    # 创建README.md框架（如果不存在或内容很少）
    if [ ! -f "$project_path/README.md" ] || [ $(wc -c < "$project_path/README.md" 2>/dev/null || echo 0) -lt 100 ]; then
        cat > "$project_path/README.md" << EOF
# $project_name

简短的项目描述。

## 🚀 快速开始

### 安装依赖
\`\`\`bash
# 安装依赖命令
\`\`\`

### 环境配置
\`\`\`bash
# 复制环境变量文件
cp .env.example .env

# 编辑环境变量
vim .env
\`\`\`

### 运行项目
\`\`\`bash
# 开发模式
make dev
# 或
npm run dev
\`\`\`

## 📁 项目结构
\`\`\`
$project_name/
├── src/                 # 源代码
├── tests/               # 测试文件
├── docs/                # 文档
├── project_docs/        # 项目文档
├── project_process/     # 开发过程记录
├── scripts/             # 脚本
└── README.md
\`\`\`

## 🛠️ 开发

### 代码质量
\`\`\`bash
# 代码检查
make lint

# 运行测试
make test

# 类型检查
make typecheck
\`\`\`

### 构建部署
\`\`\`bash
# 构建项目
make build

# 部署
make deploy
\`\`\`

## 📚 文档

- [API文档](project_docs/API.md)
- [数据库设计](project_docs/DATABASE.md) 
- [部署说明](project_docs/DEPLOYMENT.md)

## 🤝 贡献

1. Fork 本仓库
2. 创建特性分支 (\`git checkout -b feature/AmazingFeature\`)
3. 提交更改 (\`git commit -m 'Add some AmazingFeature'\`)
4. 推送到分支 (\`git push origin feature/AmazingFeature\`)
5. 打开 Pull Request

## 📄 许可证

本项目使用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。
EOF
        echo "   ✅ 创建文件: README.md"
    fi
    
    # 创建基础项目文档
    create_basic_project_docs "$project_path" "$project_name"
}

# 创建基础项目文档
create_basic_project_docs() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建API.md
    if [ ! -f "$project_path/project_docs/API.md" ]; then
        cat > "$project_path/project_docs/API.md" << EOF
# API 接口文档

## 接口概览

本项目严格遵循全局API设计规范。

### 基础URL
\`\`\`
开发环境: http://localhost:8080
生产环境: https://api.yourdomain.com
\`\`\`

### 统一响应格式
\`\`\`json
{
  "code": 200,
  "message": "操作成功",
  "data": {}
}
\`\`\`

### 统一路径规范
\`\`\`
/health                     # 健康检查
/ping                      # 心跳检查
/swagger/*any              # API文档
/api/{service}/{action}    # 业务API
\`\`\`

## 认证

### JWT认证
\`\`\`http
Authorization: Bearer <token>
\`\`\`

## 接口列表

### 健康检查
- **GET** \`/health\`
- **描述**: 检查服务健康状态
- **响应**: 
\`\`\`json
{
  "code": 200,
  "message": "健康",
  "data": {
    "status": "ok",
    "timestamp": "2024-01-01T00:00:00Z"
  }
}
\`\`\`

### 示例API组
// 待完善：根据实际业务添加接口文档

## 错误码

| 错误码 | 说明 |
|-------|------|
| 200   | 成功 |
| 400   | 请求参数错误 |
| 401   | 未认证 |
| 403   | 无权限 |
| 404   | 资源不存在 |
| 500   | 服务器内部错误 |

## 更新日志

### v1.0.0
- 初始版本
EOF
        echo "   ✅ 创建文档: project_docs/API.md"
    fi
    
    # 创建DATABASE.md  
    if [ ! -f "$project_path/project_docs/DATABASE.md" ]; then
        cat > "$project_path/project_docs/DATABASE.md" << EOF
# 数据库设计文档

## 数据库信息
- **类型**: PostgreSQL / MySQL / SQLite (请根据实际情况修改)
- **版本**: 
- **字符集**: UTF8

## 命名规范
严格遵循全局数据库管理规范：

### 表命名
- 小写 + 下划线 + 复数形式
- 示例: \`users\`, \`user_orders\`, \`product_categories\`

### 字段命名  
- 小写 + 下划线
- 示例: \`user_name\`, \`created_at\`, \`is_active\`

### 必须字段
每个表必须包含：
\`\`\`sql
id         BIGINT PRIMARY KEY AUTO_INCREMENT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
deleted_at TIMESTAMP NULL  -- 软删除（可选）
\`\`\`

## 表结构

### 示例表 (users)
\`\`\`sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    
    INDEX idx_users_username (username),
    INDEX idx_users_email (email),
    INDEX idx_users_created_at (created_at)
);
\`\`\`

## 关系图
// 待完善：添加ER图或关系说明

## 迁移管理
迁移文件命名：\`{序号}_{操作}_{表名}.sql\`
- 示例: \`001_create_users.sql\`, \`002_add_email_to_users.sql\`

## 索引设计
索引命名：\`idx_{表名}_{字段名}\`
- 示例: \`idx_users_email\`, \`idx_users_created_at\`

## 数据字典
// 待完善：详细的字段说明
EOF
        echo "   ✅ 创建文档: project_docs/DATABASE.md"
    fi
    
    # 创建DEPLOYMENT.md
    if [ ! -f "$project_path/project_docs/DEPLOYMENT.md" ]; then
        cat > "$project_path/project_docs/DEPLOYMENT.md" << EOF
# 部署说明文档

## 环境要求

### 开发环境
- Node.js / Python / Go (根据项目类型)
- 数据库 (PostgreSQL/MySQL/SQLite)
- Redis (可选)

### 生产环境
- Docker & Docker Compose
- Nginx (反向代理)
- SSL证书

## 本地开发部署

### 1. 环境配置
\`\`\`bash
# 复制环境变量文件
cp .env.example .env

# 编辑环境变量
vim .env
\`\`\`

### 2. 安装依赖
\`\`\`bash
# 根据项目类型选择
npm install
# 或
pip install -r requirements.txt
# 或
go mod tidy
\`\`\`

### 3. 数据库初始化
\`\`\`bash
# 创建数据库
createdb myapp

# 运行迁移
make migrate
\`\`\`

### 4. 启动服务
\`\`\`bash
# 开发模式
make dev

# 生产模式
make prod
\`\`\`

## Docker部署

### 1. 构建镜像
\`\`\`bash
docker build -t $project_name .
\`\`\`

### 2. 使用Docker Compose
\`\`\`bash
docker-compose up -d
\`\`\`

## 生产部署

### 1. 服务器准备
- 安装Docker和Docker Compose
- 配置防火墙和安全组
- 申请SSL证书

### 2. 部署脚本
\`\`\`bash
# 使用智能部署命令
/智能部署推送Docker
\`\`\`

### 3. 监控和日志
- 日志位置: \`/var/log/\` 或项目的\`Logs/\`目录
- 监控端点: \`/health\`, \`/metrics\`

## 故障排查

### 常见问题
1. **端口被占用**: 检查并修改配置中的端口号
2. **数据库连接失败**: 检查数据库配置和网络连接
3. **权限问题**: 检查文件和目录权限

### 日志查看
\`\`\`bash
# 查看应用日志
tail -f Logs/app.log

# 查看HTTP访问日志
tail -f Logs/http.log

# Docker日志
docker-compose logs -f
\`\`\`

## 回滚方案
\`\`\`bash
# 回滚到上一版本
git checkout <previous-commit>
make deploy
\`\`\`

## 性能调优
// 待完善：根据实际部署情况添加性能优化建议
EOF
        echo "   ✅ 创建文档: project_docs/DEPLOYMENT.md"
    fi
    
    # 创建CHANGELOG.md
    if [ ! -f "$project_path/CHANGELOG.md" ]; then
        cat > "$project_path/CHANGELOG.md" << EOF
# 更新日志

本文档记录项目的所有重要变更。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
并且本项目遵循 [语义化版本控制](https://semver.org/zh-CN/)。

## [Unreleased]

### Added
- 智能Claude Autopilot 2.1系统集成
- 项目标准化结构和配置

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [1.0.0] - $(date +%Y-%m-%d)

### Added
- 项目初始化
- 基础项目结构
- 标准配置文件
EOF
        echo "   ✅ 创建文档: CHANGELOG.md"
    fi
}

# 创建Gin微服务项目结构
create_gin_microservice_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🍸 创建Gin微服务项目结构..."
    
    local gin_dirs=(
        "cmd"
        "internal"
        "internal/handlers"
        "internal/services"
        "internal/models"
        "internal/middleware"
        "internal/config"
        "internal/database"
        "internal/utils"
        "pkg"
        "api"
        "migrations"
        "deployments"
        "scripts"
    )
    
    for dir in "${gin_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    # 创建基础Go文件
    create_gin_base_files "$project_path" "$project_name"
}

# 创建Gin基础文件
create_gin_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建main.go
    if [ ! -f "$project_path/cmd/main.go" ]; then
        cat > "$project_path/cmd/main.go" << EOF
package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	
	// 健康检查端点
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"code":    200,
			"message": "健康",
			"data": gin.H{
				"status": "ok",
			},
		})
	})
	
	// API路由组
	api := r.Group("/api")
	{
		// 示例端点
		api.GET("/ping", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{
				"code":    200,
				"message": "pong",
			})
		})
	}
	
	log.Println("服务启动在 :8080")
	log.Fatal(r.Run(":8080"))
}
EOF
        echo "   ✅ 创建文件: cmd/main.go"
    fi
    
    # 创建Makefile
    create_go_makefile "$project_path"
}

# 创建Vue前端项目结构
create_vue_frontend_structure() {
    local project_path="$1"
    local project_name="$2"
    local project_type="$3"
    
    echo "🖼️ 创建Vue前端项目结构..."
    
    local vue_dirs=(
        "src"
        "src/components"
        "src/views"
        "src/router"
        "src/store"
        "src/utils"
        "src/api"
        "src/assets"
        "src/styles"
        "public"
        "tests/unit"
        "tests/e2e"
    )
    
    for dir in "${vue_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_vue_base_files "$project_path" "$project_name" "$project_type"
}

# 创建Vue基础文件
create_vue_base_files() {
    local project_path="$1"
    local project_name="$2"
    local project_type="$3"
    
    # 创建package.json基础结构（如果不存在）
    if [ ! -f "$project_path/package.json" ]; then
        local vue_version="3"
        if [[ "$project_type" == "vue2-frontend" ]]; then
            vue_version="2"
        fi
        
        cat > "$project_path/package.json" << EOF
{
  "name": "$project_name",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint",
    "test:unit": "vue-cli-service test:unit"
  },
  "dependencies": {
    "vue": "^$vue_version.0.0"
  },
  "devDependencies": {
    "@vue/cli-service": "~5.0.0"
  }
}
EOF
        echo "   ✅ 创建文件: package.json"
    fi
    
    create_frontend_makefile "$project_path"
}

# 创建Django项目结构
create_django_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🐍 创建Django项目结构..."
    
    local django_dirs=(
        "$project_name"
        "$project_name/settings"
        "apps"
        "apps/users"
        "apps/users/migrations"
        "apps/core"
        "apps/core/migrations"
        "static"
        "static/css"
        "static/js"
        "static/images"
        "media"
        "templates"
        "templates/base"
        "locale"
        "tests"
        "scripts"
        "requirements"
        "docs"
        "deployments"
        "deployments/docker"
    )
    
    for dir in "${django_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_django_base_files "$project_path" "$project_name"
}

# 创建FastAPI + Vue3项目结构
create_fastapi_vue3_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🚀🖼️ 创建FastAPI + Vue3全栈项目结构..."
    
    local fastapi_vue3_dirs=(
        "backend"
        "backend/app"
        "backend/app/api"
        "backend/app/api/v1"
        "backend/app/core"
        "backend/app/db"
        "backend/app/models"
        "backend/app/schemas"
        "backend/app/services"
        "backend/app/utils"
        "backend/tests"
        "backend/scripts"
        "frontend"
        "frontend/src"
        "frontend/src/components"
        "frontend/src/views"
        "frontend/src/router"
        "frontend/src/stores"
        "frontend/src/assets"
        "frontend/src/utils"
        "frontend/src/api"
        "frontend/src/types"
        "frontend/tests/unit"
        "frontend/tests/e2e"
        "deployments"
        "deployments/docker"
    )
    
    for dir in "${fastapi_vue3_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_fastapi_vue3_base_files "$project_path" "$project_name"
}

# 创建Python基础文件
create_python_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建requirements.txt
    if [ ! -f "$project_path/requirements.txt" ]; then
        cat > "$project_path/requirements.txt" << 'EOF'
fastapi>=0.68.0
uvicorn[standard]>=0.15.0
pydantic>=1.8.0
python-dotenv>=0.19.0
sqlalchemy>=1.4.0
alembic>=1.7.0
pytest>=6.2.0
requests>=2.26.0
EOF
        echo "   ✅ 创建文件: requirements.txt"
    fi
    
    create_python_makefile "$project_path"
}

# 创建Django基础文件
create_django_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建manage.py
    if [ ! -f "$project_path/manage.py" ]; then
        cat > "$project_path/manage.py" << EOF
#!/usr/bin/env python
import os
import sys

if __name__ == '__main__':
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', '$project_name.settings.development')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)
EOF
        chmod +x "$project_path/manage.py"
        echo "   ✅ 创建文件: manage.py"
    fi
    
    # 创建Django主设置文件
    if [ ! -f "$project_path/$project_name/__init__.py" ]; then
        touch "$project_path/$project_name/__init__.py"
        echo "   ✅ 创建文件: $project_name/__init__.py"
    fi
    
    # 创建Django settings
    if [ ! -f "$project_path/$project_name/settings/__init__.py" ]; then
        mkdir -p "$project_path/$project_name/settings"
        touch "$project_path/$project_name/settings/__init__.py"
        
        # 基础设置
        cat > "$project_path/$project_name/settings/base.py" << 'EOF'
from pathlib import Path
import os

BASE_DIR = Path(__file__).resolve().parent.parent.parent

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    
    # 本地应用
    'apps.users',
    'apps.core',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = '$project_name.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = '$project_name.wsgi.application'

# 国际化
LANGUAGE_CODE = 'zh-hans'
TIME_ZONE = 'Asia/Shanghai'
USE_I18N = True
USE_TZ = True

# 静态文件
STATIC_URL = '/static/'
STATICFILES_DIRS = [BASE_DIR / 'static']
STATIC_ROOT = BASE_DIR / 'staticfiles'

# 媒体文件
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# 默认主键类型
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
EOF
        
        # 开发环境设置
        cat > "$project_path/$project_name/settings/development.py" << 'EOF'
from .base import *

DEBUG = True
ALLOWED_HOSTS = ['localhost', '127.0.0.1']

# 数据库配置
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# 开发工具
INSTALLED_APPS += [
    'django_extensions',
]
EOF
        
        echo "   ✅ 创建文件: $project_name/settings/"
    fi
    
    # 创建 requirements.txt
    if [ ! -f "$project_path/requirements/base.txt" ]; then
        mkdir -p "$project_path/requirements"
        
        cat > "$project_path/requirements/base.txt" << 'EOF'
Django>=5.1.0
psycopg2-binary>=2.9.0
pillow>=10.0.0
django-cors-headers>=4.3.0
django-filter>=24.0
djangorestframework>=3.15.0
celery[redis]>=5.3.0
redis>=5.0.0
python-dotenv>=1.0.0
EOF
        
        cat > "$project_path/requirements/development.txt" << 'EOF'
-r base.txt

django-extensions>=3.2.0
django-debug-toolbar>=4.2.0
ipython>=8.16.0
pytest-django>=4.6.0
pytest-cov>=4.1.0
black>=23.9.0
flake8>=6.1.0
isort>=5.12.0
mypy>=1.6.0
EOF
        
        # 主 requirements.txt
        echo "-r requirements/base.txt" > "$project_path/requirements.txt"
        
        echo "   ✅ 创建文件: requirements/"
    fi
    
    create_django_makefile "$project_path"
}

# 创建FastAPI Vue3基础文件
create_fastapi_vue3_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建后端主文件
    if [ ! -f "$project_path/backend/app/main.py" ]; then
        cat > "$project_path/backend/app/main.py" << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="FastAPI + Vue3 全栈应用",
    description="现代化全栈Web应用",
    version="1.0.0"
)

# CORS配置
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"message": "FastAPI + Vue3 全栈应用"}

@app.get("/health")
def health_check():
    return {
        "code": 200,
        "message": "健康",
        "data": {"status": "ok"}
    }
EOF
        echo "   ✅ 创建文件: backend/app/main.py"
    fi
    
    # 创建后端 requirements.txt
    if [ ! -f "$project_path/backend/requirements.txt" ]; then
        cat > "$project_path/backend/requirements.txt" << 'EOF'
fastapi>=0.104.0
uvicorn[standard]>=0.24.0
pydantic>=2.5.0
python-dotenv>=1.0.0
sqlalchemy>=2.0.0
psycopg2-binary>=2.9.0
redis>=5.0.0
celery[redis]>=5.3.0
pytest>=7.4.0
httpx>=0.25.0
EOF
        echo "   ✅ 创建文件: backend/requirements.txt"
    fi
    
    # 创建前端 package.json
    if [ ! -f "$project_path/frontend/package.json" ]; then
        cat > "$project_path/frontend/package.json" << EOF
{
  "name": "$project_name-frontend",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview",
    "lint": "eslint . --fix",
    "format": "prettier --write .",
    "test:unit": "vitest"
  },
  "dependencies": {
    "vue": "^3.4.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "axios": "^1.6.0",
    "element-plus": "^2.4.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.5.0",
    "typescript": "^5.3.0",
    "vue-tsc": "^1.8.0",
    "vite": "^5.0.0",
    "vitest": "^1.0.0",
    "eslint": "^8.55.0",
    "prettier": "^3.1.0"
  }
}
EOF
        echo "   ✅ 创建文件: frontend/package.json"
    fi
    
    # 创建 docker-compose.yml
    if [ ! -f "$project_path/docker-compose.yml" ]; then
        cat > "$project_path/docker-compose.yml" << 'EOF'
services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/myapp
      - REDIS_URL=redis://redis:6379
    depends_on:
      - db
      - redis
    volumes:
      - ./backend:/app
    command: uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    command: npm run dev

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
      POSTGRES_DB: myapp
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
EOF
        echo "   ✅ 创建文件: docker-compose.yml"
    fi
    
    create_python_makefile "$project_path/backend"
    create_frontend_makefile "$project_path/frontend"
    
    # 创建根目录Makefile
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# FastAPI + Vue3 全栈项目Makefile

.PHONY: help dev build test clean docker-dev docker-build

help:
	@echo "🚀 FastAPI + Vue3 全栈应用命令:"
	@echo ""
	@echo "💻 开发:"
	@echo "  dev          - 启动开发环境"
	@echo "  backend-dev  - 启动后端开发服务器"
	@echo "  frontend-dev - 启动前端开发服务器"
	@echo ""
	@echo "📦 构建:"
	@echo "  build        - 构建所有组件"
	@echo "  test         - 运行所有测试"
	@echo ""
	@echo "🐳 Docker:"
	@echo "  docker-dev   - 启动Docker开发环境"
	@echo "  docker-build - 构建Docker镜像"
	@echo "  docker-stop  - 停止Docker服务"

dev:
	@echo "🚀 启动全栈开发环境..."
	make -C backend dev &
	make -C frontend dev &
	wait

backend-dev:
	@echo "🔥 启动后端开发服务器..."
	make -C backend dev

frontend-dev:
	@echo "✨ 启动前端开发服务器..."
	make -C frontend dev

build:
	@echo "📦 构建所有组件..."
	make -C backend build
	make -C frontend build

test:
	@echo "🧪 运行所有测试..."
	make -C backend test
	make -C frontend test

docker-dev:
	@echo "🐳 启动Docker开发环境..."
	docker-compose up -d

docker-build:
	@echo "📦 构建Docker镜像..."
	docker-compose build

docker-stop:
	@echo "🛑 停止Docker服务..."
	docker-compose down

clean:
	@echo "🧹 清理构建文件..."
	make -C backend clean
	make -C frontend clean
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建Django Makefile
create_django_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# Django项目Makefile

.PHONY: help install dev migrate test lint clean collectstatic

# 默认目标
all: lint test

# 创建虚拟环境
venv:
	python3 -m venv venv
	@echo "激活虚拟环境: source venv/bin/activate"

# 安装依赖
install:
	pip install -r requirements/development.txt

# 数据库迁移
migrate:
	python manage.py makemigrations
	python manage.py migrate

# 创建超级用户
createsuperuser:
	python manage.py createsuperuser

# 开发模式
dev:
	python manage.py runserver

# 生产模式
prod:
	gunicorn myproject.wsgi:application --bind 0.0.0.0:8000

# 运行测试
test:
	python manage.py test
	pytest

# 代码检查
lint:
	black --check .
	flake8 .
	isort --check-only .
	mypy .

# 代码格式化
format:
	black .
	isort .

# 类型检查
typecheck:
	mypy .

# 安全扫描
security-scan:
	bandit -r .
	safety check

# 收集静态文件
collectstatic:
	python manage.py collectstatic --noinput

# 清理
clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf .pytest_cache/
	rm -rf htmlcov/
	rm -rf .coverage

# Django命令
shell:
	python manage.py shell_plus

makemessages:
	python manage.py makemessages -l zh_Hans

compilemessages:
	python manage.py compilemessages

# 帮助
help:
	@echo "🚀 Django项目开发命令:"
	@echo ""
	@echo "💻 环境设置:"
	@echo "  venv         - 创建虚拟环境"
	@echo "  install      - 安装依赖"
	@echo ""
	@echo "🗺️ 数据库:"
	@echo "  migrate      - 运行数据库迁移"
	@echo "  createsuperuser - 创建超级用户"
	@echo ""
	@echo "🚀 开发:"
	@echo "  dev          - 启动开发服务器"
	@echo "  shell        - Django shell"
	@echo "  test         - 运行测试"
	@echo ""
	@echo "🔍 代码质量:"
	@echo "  lint         - 代码检查"
	@echo "  format       - 代码格式化"
	@echo "  typecheck    - 类型检查"
	@echo "  security-scan - 安全扫描"
	@echo ""
	@echo "📦 部署:"
	@echo "  prod         - 生产模式运行"
	@echo "  collectstatic - 收集静态文件"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建Go通用Makefile
create_go_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# Go项目Makefile

.PHONY: build clean test lint dev prod install

# 变量定义
APP_NAME := $(shell basename $(PWD))
BUILD_DIR := ./build
CMD_DIR := ./cmd

# 默认目标
all: lint test build

# 安装依赖
install:
	go mod tidy
	go mod download

# 代码检查
lint:
	gofmt -l .
	go vet ./...
	test -z "$(shell gofmt -l .)"

# 运行测试
test:
	go test -v -race -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html

# 类型检查 (Go天然支持)
typecheck:
	go build -o /dev/null ./...

# 安全扫描
security-scan:
	@echo "Go安全扫描需要安装gosec工具"
	@if command -v gosec > /dev/null; then \
		gosec ./...; \
	else \
		echo "请安装gosec: go install github.com/securecodewarrior/gosec/v2/cmd/gosec@latest"; \
	fi

# 构建
build: clean
	mkdir -p $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(APP_NAME) $(CMD_DIR)/main.go

# 开发模式运行
dev:
	go run $(CMD_DIR)/main.go

# 生产模式构建
prod: lint test build

# 清理
clean:
	rm -rf $(BUILD_DIR)
	rm -f coverage.out coverage.html

# Docker相关
docker-build:
	docker build -t $(APP_NAME) .

docker-run:
	docker run -p 8080:8080 --env-file .env $(APP_NAME)

# 数据库迁移
migrate-up:
	@echo "运行数据库迁移"

migrate-down:
	@echo "回滚数据库迁移"

# 帮助
help:
	@echo "可用的make命令："
	@echo "  install      - 安装依赖"
	@echo "  lint         - 代码检查"
	@echo "  test         - 运行测试"
	@echo "  typecheck    - 类型检查"
	@echo "  security-scan - 安全扫描"
	@echo "  build        - 构建项目"
	@echo "  dev          - 开发模式运行"
	@echo "  prod         - 生产构建"
	@echo "  clean        - 清理构建文件"
	@echo "  docker-build - 构建Docker镜像"
	@echo "  docker-run   - 运行Docker容器"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建前端项目Makefile
create_frontend_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# 前端项目Makefile

.PHONY: install dev build test lint clean serve prod typecheck security-scan

# 默认目标
all: lint test build

# 安装依赖
install:
	npm install

# 开发模式
dev:
	npm run serve

# 构建项目
build:
	npm run build

# 运行测试
test:
	npm run test:unit

# 代码检查
lint:
	npm run lint

# 类型检查 (如果使用TypeScript)
typecheck:
	@if [ -f "tsconfig.json" ]; then \
		npx tsc --noEmit; \
	else \
		echo "跳过类型检查 (非TypeScript项目)"; \
	fi

# 安全扫描
security-scan:
	npm audit
	@if command -v npm > /dev/null; then \
		npm audit fix; \
	fi

# 生产构建
prod: lint typecheck test build

# 清理
clean:
	rm -rf dist/
	rm -rf node_modules/.cache/

# 启动开发服务器
serve: dev

# 预览生产构建
preview:
	@if command -v serve > /dev/null; then \
		serve -s dist; \
	else \
		echo "请安装serve: npm install -g serve"; \
	fi

# 部署相关
deploy:
	@echo "执行部署脚本"

# 帮助
help:
	@echo "可用的make命令："
	@echo "  install      - 安装依赖"
	@echo "  dev          - 开发模式运行"
	@echo "  build        - 构建项目"
	@echo "  test         - 运行测试"
	@echo "  lint         - 代码检查"
	@echo "  typecheck    - 类型检查"
	@echo "  security-scan - 安全扫描"
	@echo "  prod         - 生产构建"
	@echo "  clean        - 清理构建文件"
	@echo "  serve        - 启动开发服务器"
	@echo "  preview      - 预览生产构建"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建Python项目Makefile
create_python_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# Python项目Makefile

.PHONY: install dev test lint clean typecheck security-scan venv

# 变量定义
PYTHON := python3
PIP := pip3
VENV_DIR := venv

# 默认目标
all: lint typecheck test

# 创建虚拟环境
venv:
	$(PYTHON) -m venv $(VENV_DIR)
	@echo "激活虚拟环境: source $(VENV_DIR)/bin/activate"

# 安装依赖
install:
	$(PIP) install -r requirements.txt
	@if [ -f "requirements-dev.txt" ]; then \
		$(PIP) install -r requirements-dev.txt; \
	fi

# 开发模式
dev:
	$(PYTHON) -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# 生产模式
prod:
	$(PYTHON) -m uvicorn app.main:app --host 0.0.0.0 --port 8000

# 运行测试
test:
	$(PYTHON) -m pytest tests/ -v --cov=app --cov-report=html --cov-report=term-missing

# 代码检查
lint:
	$(PYTHON) -m flake8 app/ tests/
	$(PYTHON) -m black --check app/ tests/
	$(PYTHON) -m isort --check-only app/ tests/

# 代码格式化
format:
	$(PYTHON) -m black app/ tests/
	$(PYTHON) -m isort app/ tests/

# 类型检查
typecheck:
	$(PYTHON) -m mypy app/

# 安全扫描
security-scan:
	$(PYTHON) -m bandit -r app/
	$(PYTHON) -m safety check

# 数据库迁移
migrate:
	alembic upgrade head

# 创建迁移
migration:
	alembic revision --autogenerate -m "$(msg)"

# 清理
clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf .pytest_cache/
	rm -rf htmlcov/
	rm -rf .coverage
	rm -rf dist/
	rm -rf build/
	rm -rf *.egg-info/

# 构建分发包
build:
	$(PYTHON) setup.py sdist bdist_wheel

# 安装开发依赖
install-dev:
	$(PIP) install pytest black flake8 isort mypy bandit safety

# 帮助
help:
	@echo "可用的make命令："
	@echo "  venv         - 创建虚拟环境"
	@echo "  install      - 安装依赖"
	@echo "  install-dev  - 安装开发依赖"
	@echo "  dev          - 开发模式运行"
	@echo "  prod         - 生产模式运行"
	@echo "  test         - 运行测试"
	@echo "  lint         - 代码检查"
	@echo "  format       - 代码格式化"
	@echo "  typecheck    - 类型检查"
	@echo "  security-scan - 安全扫描"
	@echo "  migrate      - 运行数据库迁移"
	@echo "  clean        - 清理临时文件"
	@echo "  build        - 构建分发包"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建Go通用项目结构
create_go_general_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🐹 创建Go通用项目结构..."
    
    local go_dirs=(
        "cmd"
        "internal"
        "pkg"
        "scripts"
        "test"
        "docs"
        "examples"
    )
    
    for dir in "${go_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    # 创建基础Go文件
    create_go_general_base_files "$project_path" "$project_name"
}

# 创建Go通用基础文件
create_go_general_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建main.go（如果不存在）
    if [ ! -f "$project_path/cmd/main.go" ]; then
        cat > "$project_path/cmd/main.go" << 'EOF'
package main

import (
	"fmt"
	"log"
)

func main() {
	fmt.Println("Hello, World!")
	log.Println("Application started successfully")
}
EOF
        echo "   ✅ 创建文件: cmd/main.go"
    fi
    
    # 创建Makefile（如果不存在）
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
.PHONY: build run test clean lint

# 构建应用
build:
	go build -o bin/app ./cmd

# 运行应用
run:
	go run ./cmd

# 运行测试
test:
	go test ./...

# 清理构建文件
clean:
	rm -rf bin/

# 代码检查
lint:
	golangci-lint run

# 格式化代码
fmt:
	go fmt ./...

# 下载依赖
deps:
	go mod download
	go mod tidy

# 帮助
help:
	@echo "可用的命令:"
	@echo "  build  - 构建应用"
	@echo "  run    - 运行应用"
	@echo "  test   - 运行测试"
	@echo "  clean  - 清理构建文件"
	@echo "  lint   - 代码检查"
	@echo "  fmt    - 格式化代码"
	@echo "  deps   - 下载依赖"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
    
    # 创建README.md（如果内容过于简单）
    if [ ! -f "$project_path/README.md" ] || [ "$(wc -l < "$project_path/README.md")" -lt 5 ]; then
        cat > "$project_path/README.md" << EOF
# $project_name

## 项目描述

这是一个Go通用项目。

## 快速开始

### 环境要求

- Go 1.19+

### 安装依赖

\`\`\`bash
make deps
\`\`\`

### 运行项目

\`\`\`bash
make run
\`\`\`

### 构建项目

\`\`\`bash
make build
\`\`\`

### 运行测试

\`\`\`bash
make test
\`\`\`

## 项目结构

\`\`\`
$project_name/
├── cmd/           # 应用程序入口
├── internal/      # 内部包（不对外暴露）
├── pkg/           # 公共库
├── test/          # 测试文件
├── scripts/       # 脚本文件
├── docs/          # 文档
├── examples/      # 示例代码
├── go.mod         # Go模块文件
├── go.sum         # 依赖锁定文件
├── Makefile       # 构建脚本
└── README.md      # 项目说明
\`\`\`

## 开发规范

- 遵循Go官方代码规范
- 使用gofmt格式化代码
- 编写单元测试
- 使用golangci-lint进行代码检查

## 许可证

待定
EOF
        echo "   ✅ 创建文件: README.md"
    fi
}

# 创建通用项目结构（未知类型）
create_generic_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "📦 创建通用项目结构..."
    
    local generic_dirs=(
        "src"
        "lib" 
        "bin"
        "config"
        "data"
        "examples"
    )
    
    for dir in "${generic_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    # 创建通用Makefile
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# 通用项目Makefile

.PHONY: help clean test lint build install dev prod

# 默认目标
all: help

# 安装依赖
install:
	@echo "请根据项目类型配置安装命令"

# 开发模式
dev:
	@echo "请根据项目类型配置开发运行命令"

# 生产模式
prod:
	@echo "请根据项目类型配置生产运行命令"

# 构建项目
build:
	@echo "请根据项目类型配置构建命令"

# 运行测试
test:
	@echo "请根据项目类型配置测试命令"

# 代码检查
lint:
	@echo "请根据项目类型配置代码检查命令"

# 类型检查
typecheck:
	@echo "请根据项目类型配置类型检查命令"

# 安全扫描
security-scan:
	@echo "请根据项目类型配置安全扫描命令"

# 清理
clean:
	@echo "请根据项目类型配置清理命令"

# 帮助
help:
	@echo "通用项目Makefile模板"
	@echo "请根据具体项目类型定制make命令"
	@echo ""
	@echo "常用命令模板："
	@echo "  install      - 安装依赖"
	@echo "  dev          - 开发模式运行"
	@echo "  build        - 构建项目"
	@echo "  test         - 运行测试"
	@echo "  lint         - 代码检查"
	@echo "  clean        - 清理构建文件"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建Gin+Vue3全栈项目结构
create_gin_vue3_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🍸🖼️ 创建Gin+Vue3全栈项目结构..."
    
    local gin_vue3_dirs=(
        "backend"
        "backend/cmd"
        "backend/internal"
        "backend/internal/handlers"
        "backend/internal/services"
        "backend/internal/models"
        "backend/internal/middleware"
        "backend/internal/config"
        "backend/pkg"
        "backend/api"
        "backend/migrations"
        "frontend"
        "frontend/public"
        "frontend/src"
        "frontend/src/components"
        "frontend/src/views"
        "frontend/src/router"
        "frontend/src/stores"
        "frontend/src/assets"
        "frontend/src/utils"
        "frontend/src/api"
        "frontend/src/types"
        "frontend/tests/unit"
        "frontend/tests/e2e"
        "deployments"
        "deployments/docker"
        "deployments/k8s"
    )
    
    for dir in "${gin_vue3_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_gin_vue3_base_files "$project_path" "$project_name"
}

# 创建Gin+Vue3基础文件
create_gin_vue3_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建docker-compose.yml
    if [ ! -f "$project_path/docker-compose.yml" ]; then
        cat > "$project_path/docker-compose.yml" << 'EOF'
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8080:8080"
    environment:
      - DATABASE_URL=postgres://user:password@db:5432/dbname
      - REDIS_URL=redis://redis:6379
    depends_on:
      - db
      - redis

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    depends_on:
      - backend

  db:
    image: postgres:13
    environment:
      POSTGRES_DB: dbname
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:6
    ports:
      - "6379:6379"

volumes:
  postgres_data:
EOF
        echo "   ✅ 创建文件: docker-compose.yml"
    fi
    
    create_go_makefile "$project_path/backend"
    create_frontend_makefile "$project_path/frontend"
}

# 创建Go桌面应用结构
create_go_desktop_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🖥️ 创建Go桌面应用项目结构..."
    
    local go_desktop_dirs=(
        "cmd"
        "cmd/app"
        "internal"
        "internal/ui"
        "internal/ui/windows"
        "internal/ui/widgets"
        "internal/ui/themes"
        "internal/logic"
        "internal/storage"
        "internal/config"
        "pkg"
        "pkg/utils"
        "pkg/models"
        "assets"
        "assets/icons"
        "assets/images"
        "assets/fonts"
        "build"
        "build/windows"
        "build/macos"
        "build/linux"
        "configs"
    )
    
    for dir in "${go_desktop_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_go_desktop_base_files "$project_path" "$project_name"
}

# 创建Go桌面应用基础文件
create_go_desktop_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建主程序文件
    if [ ! -f "$project_path/cmd/app/main.go" ]; then
        cat > "$project_path/cmd/app/main.go" << 'EOF'
package main

import (
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/widget"
)

func main() {
	myApp := app.New()
	myWindow := myApp.NewWindow("Hello")
	myWindow.SetContent(widget.NewLabel("Hello Fyne!"))

	myWindow.ShowAndRun()
}
EOF
        echo "   ✅ 创建文件: cmd/app/main.go"
    fi
    
    # 创建fyne-bundle.json
    if [ ! -f "$project_path/fyne-bundle.json" ]; then
        cat > "$project_path/fyne-bundle.json" << 'EOF'
{
  "Details": {
    "Icon": "assets/icon.png",
    "Name": "MyApp"
  }
}
EOF
        echo "   ✅ 创建文件: fyne-bundle.json"
    fi
    
    create_go_makefile "$project_path"
}

# 创建Vue3前端项目结构
create_vue3_frontend_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🎨 创建Vue3前端项目结构..."
    
    local vue3_dirs=(
        "public"
        "src"
        "src/components"
        "src/views"
        "src/router"
        "src/stores"
        "src/assets"
        "src/utils"
        "src/api"
        "src/composables"
        "src/types"
        "tests"
        "tests/unit"
        "tests/e2e"
        "dist"
        "node_modules"
    )
    
    for dir in "${vue3_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_vue3_base_files "$project_path" "$project_name"
}

# 创建Vue3基础文件
create_vue3_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建package.json
    if [ ! -f "$project_path/package.json" ]; then
        cat > "$project_path/package.json" << EOF
{
  "name": "$project_name",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview",
    "lint": "eslint . --fix",
    "format": "prettier --write .",
    "test:unit": "vitest"
  },
  "dependencies": {
    "vue": "^3.3.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.2.0",
    "typescript": "^5.0.0",
    "vue-tsc": "^1.6.0",
    "vite": "^4.3.0",
    "vitest": "^0.31.0",
    "eslint": "^8.39.0",
    "prettier": "^2.8.0"
  }
}
EOF
        echo "   ✅ 创建文件: package.json"
    fi
    
    # 创建vite.config.ts
    if [ ! -f "$project_path/vite.config.ts" ]; then
        cat > "$project_path/vite.config.ts" << 'EOF'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  server: {
    port: 3000,
    open: true
  },
  build: {
    outDir: 'dist',
    sourcemap: true
  }
})
EOF
        echo "   ✅ 创建文件: vite.config.ts"
    fi
    
    create_frontend_makefile "$project_path"
}

# 创建Vue2前端项目结构
create_vue2_frontend_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🎨 创建Vue2前端项目结构..."
    
    local vue2_dirs=(
        "public"
        "src"
        "src/components"
        "src/views"
        "src/router"
        "src/store"
        "src/assets"
        "src/utils"
        "src/api"
        "src/mixins"
        "tests"
        "tests/unit"
        "tests/e2e"
        "dist"
        "node_modules"
    )
    
    for dir in "${vue2_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_vue2_base_files "$project_path" "$project_name"
}

# 创建Vue2基础文件
create_vue2_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建package.json
    if [ ! -f "$project_path/package.json" ]; then
        cat > "$project_path/package.json" << EOF
{
  "name": "$project_name",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "serve": "vue-cli-service serve",
    "build": "vue-cli-service build",
    "lint": "vue-cli-service lint",
    "test:unit": "vue-cli-service test:unit"
  },
  "dependencies": {
    "vue": "^2.6.14",
    "vue-router": "^3.5.1",
    "vuex": "^3.6.2"
  },
  "devDependencies": {
    "@vue/cli-service": "~5.0.0",
    "@vue/cli-plugin-router": "~5.0.0",
    "@vue/cli-plugin-vuex": "~5.0.0",
    "eslint": "^7.32.0",
    "@vue/eslint-config-standard": "^6.1.0"
  }
}
EOF
        echo "   ✅ 创建文件: package.json"
    fi
    
    # 创建vue.config.js
    if [ ! -f "$project_path/vue.config.js" ]; then
        cat > "$project_path/vue.config.js" << 'EOF'
const { defineConfig } = require('@vue/cli-service')

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    port: 8080,
    open: true
  },
  productionSourceMap: false
})
EOF
        echo "   ✅ 创建文件: vue.config.js"
    fi
    
    create_frontend_makefile "$project_path"
}

# 创建React前端项目结构
create_react_frontend_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "⚛️ 创建React前端项目结构..."
    
    local react_dirs=(
        "public"
        "src"
        "src/components"
        "src/pages"
        "src/hooks"
        "src/context"
        "src/services"
        "src/utils"
        "src/types"
        "src/styles"
        "tests"
        "build"
        "node_modules"
    )
    
    for dir in "${react_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_react_base_files "$project_path" "$project_name"
}

# 创建React基础文件
create_react_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建package.json
    if [ ! -f "$project_path/package.json" ]; then
        cat > "$project_path/package.json" << EOF
{
  "name": "$project_name",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.8.0",
    "typescript": "^4.9.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject",
    "lint": "eslint src --ext .ts,.tsx"
  },
  "devDependencies": {
    "react-scripts": "5.0.1",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "eslint": "^8.0.0"
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  }
}
EOF
        echo "   ✅ 创建文件: package.json"
    fi
    
    create_frontend_makefile "$project_path"
}

# 创建Next.js前端项目结构
create_nextjs_frontend_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "▲ 创建Next.js前端项目结构..."
    
    local nextjs_dirs=(
        "pages"
        "pages/api"
        "app"
        "components"
        "lib"
        "hooks"
        "types"
        "styles"
        "public"
        ".next"
        "node_modules"
    )
    
    for dir in "${nextjs_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_nextjs_base_files "$project_path" "$project_name"
}

# 创建Next.js基础文件
create_nextjs_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建package.json
    if [ ! -f "$project_path/package.json" ]; then
        cat > "$project_path/package.json" << EOF
{
  "name": "$project_name",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "next": "^13.4.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "typescript": "^5.0.0"
  },
  "devDependencies": {
    "@types/node": "^20.0.0",
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "eslint": "^8.0.0",
    "eslint-config-next": "^13.4.0"
  }
}
EOF
        echo "   ✅ 创建文件: package.json"
    fi
    
    # 创建next.config.js
    if [ ! -f "$project_path/next.config.js" ]; then
        cat > "$project_path/next.config.js" << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  experimental: {
    appDir: true,
  },
}

module.exports = nextConfig
EOF
        echo "   ✅ 创建文件: next.config.js"
    fi
    
    create_frontend_makefile "$project_path"
}

# 创建Node.js通用项目结构
create_nodejs_general_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🟢 创建Node.js通用项目结构..."
    
    local nodejs_dirs=(
        "src"
        "src/controllers"
        "src/services"
        "src/models"
        "src/middleware"
        "src/routes"
        "src/utils"
        "src/config"
        "tests"
        "scripts"
        "docs"
        "node_modules"
    )
    
    for dir in "${nodejs_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_nodejs_base_files "$project_path" "$project_name"
}

# 创建Node.js基础文件
create_nodejs_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建package.json
    if [ ! -f "$project_path/package.json" ]; then
        cat > "$project_path/package.json" << EOF
{
  "name": "$project_name",
  "version": "1.0.0",
  "description": "",
  "main": "src/app.js",
  "scripts": {
    "start": "node src/app.js",
    "dev": "nodemon src/app.js",
    "test": "jest",
    "lint": "eslint src/",
    "format": "prettier --write src/"
  },
  "dependencies": {
    "express": "^4.18.0",
    "dotenv": "^16.0.0"
  },
  "devDependencies": {
    "nodemon": "^2.0.0",
    "jest": "^29.0.0",
    "eslint": "^8.0.0",
    "prettier": "^2.8.0"
  }
}
EOF
        echo "   ✅ 创建文件: package.json"
    fi
    
    # 创建src/app.js
    if [ ! -f "$project_path/src/app.js" ]; then
        cat > "$project_path/src/app.js" << 'EOF'
const express = require('express');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// 中间件
app.use(express.json());

// 路由
app.get('/health', (req, res) => {
  res.json({ 
    code: 200, 
    message: '健康',
    data: { status: 'ok' }
  });
});

app.listen(PORT, () => {
  console.log(`服务器运行在端口 ${PORT}`);
});
EOF
        echo "   ✅ 创建文件: src/app.js"
    fi
    
    create_frontend_makefile "$project_path"
}

# 创建Python通用项目结构
create_python_general_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🐍 创建Python通用项目结构..."
    
    local python_dirs=(
        "src"
        "src/core"
        "src/utils"
        "tests"
        "scripts"
    )
    
    for dir in "${python_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_python_general_base_files "$project_path" "$project_name"
}

# 创建Python通用基础文件
create_python_general_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建requirements.txt
    if [ ! -f "$project_path/requirements.txt" ]; then
        cat > "$project_path/requirements.txt" << 'EOF'
# 基础依赖
python-dotenv>=0.19.0
requests>=2.26.0

# 开发依赖 (可选)
pytest>=6.2.0
black>=22.0.0
flake8>=4.0.0
isort>=5.10.0
EOF
        echo "   ✅ 创建文件: requirements.txt"
    fi
    
    # 创建src/main.py
    if [ ! -f "$project_path/src/main.py" ]; then
        cat > "$project_path/src/main.py" << 'EOF'
#!/usr/bin/env python3
"""
主程序入口
"""

def main():
    print("Hello, Python!")

if __name__ == "__main__":
    main()
EOF
        echo "   ✅ 创建文件: src/main.py"
    fi
    
    create_python_makefile "$project_path"
}

# 创建Bash脚本项目结构
create_bash_scripts_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "📜 创建Bash脚本项目结构..."
    
    local bash_dirs=(
        "bin"
        "lib"
        "lib/utils"
        "config"
        "tests"
        "examples"
        "scripts"
    )
    
    for dir in "${bash_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_bash_scripts_base_files "$project_path" "$project_name"
}

# 创建Bash脚本基础文件
create_bash_scripts_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建.shellcheckrc
    if [ ! -f "$project_path/.shellcheckrc" ]; then
        cat > "$project_path/.shellcheckrc" << 'EOF'
# ShellCheck配置文件
disable=SC2034  # 未使用的变量
disable=SC1091  # 无法找到被包含的文件
EOF
        echo "   ✅ 创建文件: .shellcheckrc"
    fi
    
    # 创建VERSION文件
    if [ ! -f "$project_path/VERSION" ]; then
        echo "1.0.0" > "$project_path/VERSION"
        echo "   ✅ 创建文件: VERSION"
    fi
    
    create_bash_makefile "$project_path"
}

# 创建Bash项目Makefile
create_bash_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# Bash脚本项目Makefile

.PHONY: install test lint clean format check setup help

# 默认目标
all: lint test

# 安装依赖（检查必要工具）
install:
	@echo "检查必要工具..."
	@command -v shellcheck >/dev/null 2>&1 || { echo "请安装 shellcheck"; exit 1; }
	@command -v bats >/dev/null 2>&1 || echo "建议安装 bats 用于测试"

# 运行测试
test:
	@if [ -d "tests" ] && command -v bats >/dev/null 2>&1; then \
		bats tests/; \
	else \
		echo "跳过测试 (未安装bats或无测试文件)"; \
	fi

# 代码检查
lint:
	@echo "运行 ShellCheck 检查..."
	@find . -name "*.sh" -not -path "./node_modules/*" -not -path "./.git/*" | xargs shellcheck

# 格式化代码
format:
	@echo "格式化shell脚本..."
	@find . -name "*.sh" -not -path "./node_modules/*" -not -path "./.git/*" -exec shfmt -w {} \;

# 安全检查
security-scan:
	@echo "检查潜在的安全问题..."
	@find . -name "*.sh" -not -path "./node_modules/*" -not -path "./.git/*" -exec grep -l "eval\|exec\|system" {} \; || echo "未发现明显的安全问题"

# 类型检查（shell脚本语法检查）
typecheck:
	@echo "检查语法..."
	@find . -name "*.sh" -not -path "./node_modules/*" -not -path "./.git/*" -exec bash -n {} \;

# 设置可执行权限
setup:
	@echo "设置脚本可执行权限..."
	@find bin/ -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
	@find scripts/ -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

# 清理
clean:
	@echo "清理临时文件..."
	@find . -name "*.tmp" -delete
	@find . -name "*.log" -delete

# 帮助
help:
	@echo "可用的make命令："
	@echo "  install      - 安装/检查依赖工具"
	@echo "  test         - 运行测试"
	@echo "  lint         - 代码检查"
	@echo "  format       - 格式化代码"
	@echo "  typecheck    - 语法检查"
	@echo "  security-scan - 安全检查"
	@echo "  setup        - 设置可执行权限"
	@echo "  clean        - 清理临时文件"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建Java Maven项目结构
create_java_maven_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "☕ 创建Java Maven项目结构..."
    
    local java_maven_dirs=(
        "src/main/java"
        "src/main/resources"
        "src/test/java"
        "src/test/resources"
        "target"
        "docs"
        "scripts"
        ".mvn"
    )
    
    for dir in "${java_maven_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_java_maven_base_files "$project_path" "$project_name"
}

# 创建Java Maven基础文件
create_java_maven_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建pom.xml
    if [ ! -f "$project_path/pom.xml" ]; then
        cat > "$project_path/pom.xml" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>$project_name</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <name>$project_name</name>
    <description>Java应用程序</description>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <junit.version>5.8.2</junit.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter</artifactId>
            <version>\${junit.version}</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.10.1</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.0.0-M7</version>
            </plugin>
        </plugins>
    </build>
</project>
EOF
        echo "   ✅ 创建文件: pom.xml"
    fi
    
    create_java_makefile "$project_path"
}

# 创建Java Makefile
create_java_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# Java项目Makefile

.PHONY: compile test clean package install run lint typecheck security-scan

# 默认目标
all: compile test package

# 编译
compile:
	mvn compile

# 运行测试
test:
	mvn test

# 清理
clean:
	mvn clean

# 打包
package:
	mvn package

# 安装到本地仓库
install:
	mvn install

# 运行应用
run:
	mvn exec:java

# 代码检查
lint:
	@if command -v checkstyle >/dev/null 2>&1; then \
		checkstyle -c checkstyle.xml src/; \
	else \
		echo "跳过代码检查 (未安装checkstyle)"; \
	fi

# 类型检查 (Java自带)
typecheck:
	mvn compile

# 安全扫描
security-scan:
	@if command -v dependency-check >/dev/null 2>&1; then \
		dependency-check --project "$(PROJECT_NAME)" --scan .; \
	else \
		echo "跳过安全扫描 (未安装dependency-check)"; \
	fi

# 开发模式
dev:
	mvn spring-boot:run

# 生产构建
prod: clean compile test package

# 依赖更新
update-deps:
	mvn versions:display-dependency-updates

# 帮助
help:
	@echo "可用的make命令："
	@echo "  compile      - 编译源代码"
	@echo "  test         - 运行测试"
	@echo "  clean        - 清理构建文件"
	@echo "  package      - 打包应用"
	@echo "  install      - 安装到本地仓库"
	@echo "  run          - 运行应用"
	@echo "  dev          - 开发模式运行"
	@echo "  lint         - 代码检查"
	@echo "  security-scan - 安全扫描"
	@echo "  update-deps  - 检查依赖更新"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建Java Gradle项目结构
create_java_gradle_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "☕ 创建Java Gradle项目结构..."
    
    local java_gradle_dirs=(
        "src/main/java"
        "src/main/resources"
        "src/test/java"
        "src/test/resources"
        "build"
        "gradle"
        "docs"
        "scripts"
    )
    
    for dir in "${java_gradle_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_java_gradle_base_files "$project_path" "$project_name"
}

# 创建Java Gradle基础文件
create_java_gradle_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建build.gradle
    if [ ! -f "$project_path/build.gradle" ]; then
        cat > "$project_path/build.gradle" << EOF
plugins {
    id 'java'
    id 'application'
}

group = 'com.example'
version = '1.0.0'

java {
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.slf4j:slf4j-api:1.7.36'
    implementation 'ch.qos.logback:logback-classic:1.2.11'
    
    testImplementation 'org.junit.jupiter:junit-jupiter:5.8.2'
}

application {
    mainClass = 'com.example.Main'
}

test {
    useJUnitPlatform()
}

tasks.named('test') {
    testLogging {
        events "passed", "skipped", "failed"
    }
}
EOF
        echo "   ✅ 创建文件: build.gradle"
    fi
    
    # 创建settings.gradle
    if [ ! -f "$project_path/settings.gradle" ]; then
        cat > "$project_path/settings.gradle" << EOF
rootProject.name = '$project_name'
EOF
        echo "   ✅ 创建文件: settings.gradle"
    fi
    
    create_gradle_makefile "$project_path"
}

# 创建Gradle Makefile
create_gradle_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# Gradle项目Makefile

.PHONY: build test clean run lint typecheck security-scan

# 默认目标
all: build test

# 构建
build:
	./gradlew build

# 运行测试
test:
	./gradlew test

# 清理
clean:
	./gradlew clean

# 运行应用
run:
	./gradlew run

# 代码检查
lint:
	./gradlew checkstyleMain checkstyleTest

# 类型检查 (Java自带)
typecheck:
	./gradlew compileJava

# 安全扫描
security-scan:
	./gradlew dependencyCheckAnalyze

# 开发模式
dev:
	./gradlew bootRun

# 生产构建
prod: clean build test

# 创建包装器
wrapper:
	gradle wrapper

# 依赖报告
deps:
	./gradlew dependencies

# 帮助
help:
	@echo "可用的make命令："
	@echo "  build        - 构建项目"
	@echo "  test         - 运行测试"
	@echo "  clean        - 清理构建文件"
	@echo "  run          - 运行应用"
	@echo "  dev          - 开发模式运行"
	@echo "  lint         - 代码检查"
	@echo "  security-scan - 安全扫描"
	@echo "  deps         - 显示依赖"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建Rust项目结构
create_rust_project_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🦀 创建Rust项目结构..."
    
    local rust_dirs=(
        "src"
        "src/bin"
        "tests"
        "examples"
        "benches"
        "target"
    )
    
    for dir in "${rust_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_rust_base_files "$project_path" "$project_name"
}

# 创建Rust基础文件
create_rust_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建Cargo.toml
    if [ ! -f "$project_path/Cargo.toml" ]; then
        cat > "$project_path/Cargo.toml" << EOF
[package]
name = "$project_name"
version = "0.1.0"
edition = "2021"
authors = ["Your Name <you@example.com>"]
description = "Rust应用程序"
license = "MIT"

[dependencies]
serde = { version = "1.0", features = ["derive"] }
tokio = { version = "1.0", features = ["full"] }

[dev-dependencies]
tokio-test = "0.4"

[[bin]]
name = "main"
path = "src/main.rs"
EOF
        echo "   ✅ 创建文件: Cargo.toml"
    fi
    
    # 创建src/main.rs
    if [ ! -f "$project_path/src/main.rs" ]; then
        cat > "$project_path/src/main.rs" << 'EOF'
fn main() {
    println!("Hello, Rust!");
}
EOF
        echo "   ✅ 创建文件: src/main.rs"
    fi
    
    # 创建src/lib.rs
    if [ ! -f "$project_path/src/lib.rs" ]; then
        cat > "$project_path/src/lib.rs" << 'EOF'
//! 库文档

pub fn add(left: usize, right: usize) -> usize {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
EOF
        echo "   ✅ 创建文件: src/lib.rs"
    fi
    
    create_rust_makefile "$project_path"
}

# 创建Rust Makefile
create_rust_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# Rust项目Makefile

.PHONY: build test clean run lint format typecheck security-scan

# 默认目标
all: lint test build

# 构建
build:
	cargo build

# 运行
run:
	cargo run

# 测试
test:
	cargo test

# 清理
clean:
	cargo clean

# 代码检查
lint:
	cargo clippy -- -D warnings

# 格式化
format:
	cargo fmt

# 类型检查
typecheck:
	cargo check

# 安全扫描
security-scan:
	@if command -v cargo-audit >/dev/null 2>&1; then \
		cargo audit; \
	else \
		echo "跳过安全扫描 (请安装cargo-audit: cargo install cargo-audit)"; \
	fi

# 开发模式
dev:
	cargo watch -x run

# 生产构建
prod:
	cargo build --release

# 文档生成
docs:
	cargo doc --open

# 基准测试
bench:
	cargo bench

# 更新依赖
update:
	cargo update

# 帮助
help:
	@echo "可用的make命令："
	@echo "  build        - 构建项目"
	@echo "  run          - 运行项目"
	@echo "  test         - 运行测试"
	@echo "  clean        - 清理构建文件"
	@echo "  lint         - 代码检查"
	@echo "  format       - 格式化代码"
	@echo "  typecheck    - 类型检查"
	@echo "  security-scan - 安全扫描"
	@echo "  dev          - 开发模式"
	@echo "  prod         - 生产构建"
	@echo "  docs         - 生成文档"
	@echo "  bench        - 基准测试"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 创建PHP项目结构
create_php_project_structure() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🐘 创建PHP项目结构..."
    
    local php_dirs=(
        "src"
        "tests"
        "vendor"
        "public"
        "config"
        "storage"
        "bootstrap"
    )
    
    for dir in "${php_dirs[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
        fi
    done
    
    create_php_base_files "$project_path" "$project_name"
}

# 创建PHP基础文件
create_php_base_files() {
    local project_path="$1"
    local project_name="$2"
    
    # 创建composer.json
    if [ ! -f "$project_path/composer.json" ]; then
        cat > "$project_path/composer.json" << EOF
{
    "name": "example/$project_name",
    "description": "PHP应用程序",
    "type": "project",
    "require": {
        "php": ">=8.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^9.0",
        "squizlabs/php_codesniffer": "^3.6"
    },
    "autoload": {
        "psr-4": {
            "App\\\\": "src/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "Tests\\\\": "tests/"
        }
    },
    "scripts": {
        "test": "phpunit",
        "lint": "phpcs src/ --standard=PSR2",
        "fix": "phpcbf src/ --standard=PSR2"
    }
}
EOF
        echo "   ✅ 创建文件: composer.json"
    fi
    
    # 创建public/index.php
    if [ ! -f "$project_path/public/index.php" ]; then
        cat > "$project_path/public/index.php" << 'EOF'
<?php

require_once __DIR__ . '/../vendor/autoload.php';

echo json_encode([
    'code' => 200,
    'message' => '健康',
    'data' => [
        'status' => 'ok',
        'timestamp' => date('c')
    ]
]);
EOF
        echo "   ✅ 创建文件: public/index.php"
    fi
    
    create_php_makefile "$project_path"
}

# 创建PHP Makefile
create_php_makefile() {
    local project_path="$1"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
# PHP项目Makefile

.PHONY: install test lint fix clean serve typecheck security-scan

# 默认目标
all: install lint test

# 安装依赖
install:
	composer install

# 运行测试
test:
	composer test

# 代码检查
lint:
	composer lint

# 修复代码格式
fix:
	composer fix

# 类型检查
typecheck:
	@if command -v phpstan >/dev/null 2>&1; then \
		phpstan analyse src/; \
	else \
		echo "跳过类型检查 (请安装phpstan: composer require --dev phpstan/phpstan)"; \
	fi

# 安全扫描
security-scan:
	composer audit

# 清理
clean:
	rm -rf vendor/
	rm -f composer.lock

# 开发服务器
serve:
	php -S localhost:8000 -t public/

# 更新依赖
update:
	composer update

# 生产部署准备
prod:
	composer install --no-dev --optimize-autoloader

# 帮助
help:
	@echo "可用的make命令："
	@echo "  install      - 安装依赖"
	@echo "  test         - 运行测试"
	@echo "  lint         - 代码检查"
	@echo "  fix          - 修复代码格式"
	@echo "  typecheck    - 类型检查"
	@echo "  security-scan - 安全扫描"
	@echo "  clean        - 清理依赖"
	@echo "  serve        - 启动开发服务器"
	@echo "  update       - 更新依赖"
	@echo "  prod         - 生产部署准备"
EOF
        echo "   ✅ 创建文件: Makefile"
    fi
}

# 主函数 - 如果直接执行此脚本
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    if [ -z "$1" ]; then
        echo "使用: $0 <project_path> [project_type] [project_name]"
        echo "示例: $0 /path/to/project gin-microservice myapp"
        exit 1
    fi
    
    PROJECT_PATH=$(get_realpath "$1")
    PROJECT_TYPE="${2:-generic}"
    PROJECT_NAME="${3:-$(basename "$PROJECT_PATH")}"
    
    create_standard_project_structure "$PROJECT_PATH" "$PROJECT_TYPE" "$PROJECT_NAME"
fi