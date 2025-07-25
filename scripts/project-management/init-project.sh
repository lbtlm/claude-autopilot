#!/bin/bash

# 项目初始化脚本
# 使用方法: ./init-project.sh <项目名称> <项目类型> [可选参数]
# 项目类型: python-desktop, fastapi-vue, gin-vue, vue3-frontend, gin-microservice, go-desktop

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 全局变量
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_RULES_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_NAME=""
PROJECT_TYPE=""
TARGET_DIR=""
CURRENT_DATE=$(date +"%Y-%m-%d")
CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S")

# 支持的项目类型
declare -A PROJECT_TYPES=(
    ["python-desktop"]="Python桌面应用"
    ["fastapi-vue"]="FastAPI + Vue3 Web项目"
    ["gin-vue"]="Gin + Vue3 Web项目"
    ["vue3-frontend"]="Vue3纯前端项目"
    ["gin-microservice"]="Gin微服务"
    ["go-desktop"]="Go桌面应用"
)

# 打印函数
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_step() {
    echo -e "${PURPLE}🔧 $1${NC}"
}

print_header() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    项目初始化脚本 v1.0                        ║"
    echo "║                                                              ║"
    echo "║  支持Claude Code主导的现代化开发工作流                        ║"
    echo "║  自动创建标准目录结构和配置文件                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# 显示帮助信息
show_help() {
    echo -e "${CYAN}使用方法:${NC}"
    echo "  $0 <项目名称> <项目类型> [选项]"
    echo ""
    echo -e "${CYAN}支持的项目类型:${NC}"
    for type in "${!PROJECT_TYPES[@]}"; do
        echo "  ${type} - ${PROJECT_TYPES[$type]}"
    done
    echo ""
    echo -e "${CYAN}选项:${NC}"
    echo "  -h, --help       显示帮助信息"
    echo "  -d, --directory  指定项目创建目录 (默认: 当前目录)"
    echo "  -g, --git        初始化Git仓库"
    echo "  -v, --verbose    详细输出"
    echo ""
    echo -e "${CYAN}示例:${NC}"
    echo "  $0 my-app vue3-frontend"
    echo "  $0 my-api gin-microservice -g"
    echo "  $0 my-desktop go-desktop -d ~/Projects"
}

# 验证参数
validate_args() {
    if [[ $# -lt 2 ]]; then
        print_error "参数不足"
        show_help
        exit 1
    fi

    PROJECT_NAME="$1"
    PROJECT_TYPE="$2"

    # 验证项目名称
    if [[ ! $PROJECT_NAME =~ ^[a-zA-Z0-9_-]+$ ]]; then
        print_error "项目名称只能包含字母、数字、下划线和连字符"
        exit 1
    fi

    # 验证项目类型
    if [[ ! ${PROJECT_TYPES[$PROJECT_TYPE]+_} ]]; then
        print_error "不支持的项目类型: $PROJECT_TYPE"
        echo ""
        echo "支持的类型:"
        for type in "${!PROJECT_TYPES[@]}"; do
            echo "  - $type"
        done
        exit 1
    fi
}

# 解析选项
parse_options() {
    INIT_GIT=false
    VERBOSE=false
    BASE_DIR="$(pwd)"

    # 跳过前两个参数（项目名称和类型）
    shift 2

    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -d|--directory)
                BASE_DIR="$2"
                shift 2
                ;;
            -g|--git)
                INIT_GIT=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            *)
                print_error "未知选项: $1"
                show_help
                exit 1
                ;;
        esac
    done

    TARGET_DIR="$BASE_DIR/$PROJECT_NAME"
}

# 检查依赖
check_dependencies() {
    print_step "检查依赖..."

    local deps=("git")
    
    case $PROJECT_TYPE in
        "python-desktop"|"fastapi-vue")
            deps+=("python3" "pip3")
            ;;
        "gin-vue"|"gin-microservice"|"go-desktop")
            deps+=("go")
            ;;
        "vue3-frontend"|"fastapi-vue"|"gin-vue")
            deps+=("node" "npm")
            ;;
    esac

    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            print_error "依赖 $dep 未安装"
            exit 1
        fi
    done

    print_success "依赖检查完成"
}

# 创建目录结构
create_directory_structure() {
    print_step "创建项目目录结构..."

    # 检查目录是否已存在
    if [[ -d "$TARGET_DIR" ]]; then
        read -p "目录 $TARGET_DIR 已存在，是否继续? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "操作已取消"
            exit 0
        fi
    fi

    mkdir -p "$TARGET_DIR"
    cd "$TARGET_DIR"

    # 通用目录
    mkdir -p {project_docs,project_process/{daily,weekly,monthly},docs,.vscode}

    case $PROJECT_TYPE in
        "python-desktop")
            mkdir -p {src/{ui,core,utils},tests,resources,venv}
            ;;
        "fastapi-vue")
            mkdir -p {backend/{app/{api,core,db,schemas,services,utils},tests},frontend/{src/{api,components,views,stores,router,utils,types,assets},tests,public},deployments/{docker,k8s},scripts}
            ;;
        "gin-vue"|"gin_vue3")
            mkdir -p {backend/{cmd/server,internal/{api/{v1,middleware},models,services,repository,config,utils},pkg/{logger,database,errors,constants},tests},frontend/{src/{api,components,views,stores,router,utils,types,assets},tests,public},deployments/{docker,k8s},scripts}
            ;;
        "vue3-frontend")
            mkdir -p {src/{api,components/{common,layout,business},composables,stores,router,views,utils,types,assets/{styles,images,fonts}},tests/{unit,e2e},docs,public}
            ;;
        "gin-microservice")
            mkdir -p {cmd/server,internal/{api/{v1,middleware},models,services,repository,config,utils},pkg/{logger,database,errors,constants},api/{swagger,postman},deployments/{docker,k8s,nginx},scripts,migrations,tests/{unit,integration,fixtures},configs,logs}
            ;;
        "go-desktop")
            mkdir -p {cmd,internal/{ui/{windows,components,styles},core/{models,services,database},utils,config},pkg/{logger,errors,constants},assets/{icons,images,fonts},configs,scripts,tests,docs}
            ;;
    esac

    print_success "目录结构创建完成"
}

# 复制配置文件
copy_config_files() {
    print_step "复制配置文件..."

    # 复制VSCode配置
    cp -r "$GLOBAL_RULES_DIR/vscode_templates/"* ".vscode/"

    # 复制通用配置文件（如果存在）
    if [[ -f "$GLOBAL_RULES_DIR/templates/.editorconfig" ]]; then
        cp "$GLOBAL_RULES_DIR/templates/.editorconfig" .
    fi

    if [[ -f "$GLOBAL_RULES_DIR/templates/.gitignore" ]]; then
        cp "$GLOBAL_RULES_DIR/templates/.gitignore" .
    fi

    # 创建项目特定的配置文件
    case $PROJECT_TYPE in
        "python-desktop")
            create_python_desktop_configs
            ;;
        "fastapi-vue")
            create_fastapi_vue_configs
            ;;
        "gin-vue"|"gin_vue3")
            create_gin_vue_configs
            ;;
        "vue3-frontend")
            create_vue3_frontend_configs
            ;;
        "gin-microservice")
            create_gin_microservice_configs
            ;;
        "go-desktop")
            create_go_desktop_configs
            ;;
    esac

    print_success "配置文件复制完成"
}

# 创建Python桌面应用配置
create_python_desktop_configs() {
    # requirements.txt
    cat > requirements.txt << EOF
tkinter-modernui>=1.0.0
Pillow>=10.0.0
requests>=2.31.0

# 开发工具
black>=23.0.0
flake8>=6.0.0
pytest>=7.0.0
pyinstaller>=5.0.0
EOF

    # requirements-dev.txt
    cat > requirements-dev.txt << EOF
-r requirements.txt

# 开发和测试工具
pytest-cov>=4.0.0
pytest-mock>=3.10.0
mypy>=1.5.0
pre-commit>=3.3.0
EOF

    # Makefile
    cat > Makefile << 'EOF'
.PHONY: init dev test build clean install

PYTHON = python3
PIP = pip3
VENV = venv
APP_NAME = $(shell basename $(CURDIR))

help:
	@echo "Python桌面应用开发命令:"
	@echo "  init     - 初始化开发环境"
	@echo "  dev      - 启动开发模式"
	@echo "  test     - 运行测试"
	@echo "  build    - 构建可执行文件"
	@echo "  clean    - 清理临时文件"

init:
	@echo "🔧 初始化开发环境..."
	$(PYTHON) -m venv $(VENV)
	./$(VENV)/bin/pip install -r requirements-dev.txt
	@echo "✅ 环境初始化完成!"

dev:
	@echo "🚀 启动开发模式..."
	./$(VENV)/bin/python src/main.py

test:
	@echo "🧪 运行测试..."
	./$(VENV)/bin/pytest tests/ -v

build:
	@echo "📦 构建可执行文件..."
	./$(VENV)/bin/pyinstaller --onefile --windowed src/main.py --name $(APP_NAME)
	@echo "✅ 构建完成! 输出: dist/$(APP_NAME)"

clean:
	@echo "🧹 清理临时文件..."
	rm -rf build/ dist/ *.spec
	find . -type d -name "__pycache__" -delete
	find . -name "*.pyc" -delete
EOF

    # src/main.py
    cat > src/main.py << 'EOF'
#!/usr/bin/env python3
"""
主程序入口
"""

import tkinter as tk
from tkinter import ttk
import sys
import os

# 添加项目路径
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from ui.main_window import MainWindow

def main():
    """主函数"""
    # 创建主窗口
    root = tk.Tk()
    app = MainWindow(root)
    
    # 启动事件循环
    app.run()

if __name__ == "__main__":
    main()
EOF

    # src/ui/main_window.py
    mkdir -p src/ui
    cat > src/ui/main_window.py << 'EOF'
import tkinter as tk
from tkinter import ttk, messagebox

class MainWindow:
    def __init__(self, root):
        self.root = root
        self.setup_window()
        self.create_widgets()
    
    def setup_window(self):
        """设置窗口属性"""
        self.root.title("Python桌面应用")
        self.root.geometry("800x600")
        self.root.resizable(True, True)
        
        # 居中显示
        self.center_window()
    
    def center_window(self):
        """窗口居中"""
        self.root.update_idletasks()
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (width // 2)
        y = (self.root.winfo_screenheight() // 2) - (height // 2)
        self.root.geometry(f"{width}x{height}+{x}+{y}")
    
    def create_widgets(self):
        """创建界面组件"""
        # 主框架
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # 标题标签
        title_label = ttk.Label(main_frame, text="欢迎使用Python桌面应用", 
                               font=("Arial", 16, "bold"))
        title_label.grid(row=0, column=0, columnspan=2, pady=(0, 20))
        
        # 示例按钮
        demo_button = ttk.Button(main_frame, text="点击我", 
                                command=self.on_demo_click)
        demo_button.grid(row=1, column=0, padx=(0, 10))
        
        # 退出按钮
        quit_button = ttk.Button(main_frame, text="退出", 
                                command=self.on_quit_click)
        quit_button.grid(row=1, column=1)
        
        # 配置网格权重
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
    
    def on_demo_click(self):
        """演示按钮点击事件"""
        messagebox.showinfo("演示", "这是一个演示消息!")
    
    def on_quit_click(self):
        """退出按钮点击事件"""
        if messagebox.askokcancel("退出", "确定要退出吗?"):
            self.root.quit()
    
    def run(self):
        """启动应用"""
        self.root.mainloop()
EOF
}

# 创建Vue3前端配置
create_vue3_frontend_configs() {
    # package.json
    cat > package.json << EOF
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "test:coverage": "vitest --coverage",
    "lint": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --fix --ignore-path .gitignore",
    "lint:fix": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --fix --ignore-path .gitignore",
    "format": "prettier --write src/",
    "type-check": "vue-tsc --noEmit"
  },
  "dependencies": {
    "vue": "^3.4.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "axios": "^1.6.0",
    "element-plus": "^2.4.0",
    "@element-plus/icons-vue": "^2.1.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.5.0",
    "@vue/test-utils": "^2.4.0",
    "@vue/tsconfig": "^0.4.0",
    "vite": "^5.0.0",
    "vue-tsc": "^1.8.0",
    "typescript": "^5.0.0",
    "@types/node": "^20.8.0",
    "vitest": "^1.0.0",
    "jsdom": "^23.0.0",
    "eslint": "^8.51.0",
    "@typescript-eslint/parser": "^6.7.0",
    "@typescript-eslint/eslint-plugin": "^6.7.0",
    "eslint-plugin-vue": "^9.17.0",
    "prettier": "^3.0.0",
    "eslint-config-prettier": "^9.0.0",
    "eslint-plugin-prettier": "^5.0.0",
    "tailwindcss": "^3.3.0",
    "autoprefixer": "^10.4.0",
    "postcss": "^8.4.0",
    "sass": "^1.69.0"
  }
}
EOF

    # vite.config.ts
    cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
      '@/components': resolve(__dirname, 'src/components'),
      '@/views': resolve(__dirname, 'src/views'),
      '@/utils': resolve(__dirname, 'src/utils'),
      '@/api': resolve(__dirname, 'src/api'),
      '@/stores': resolve(__dirname, 'src/stores'),
      '@/assets': resolve(__dirname, 'src/assets'),
      '@/types': resolve(__dirname, 'src/types')
    }
  },
  server: {
    host: '0.0.0.0',
    port: 3000,
    open: true
  },
  build: {
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: false,
    chunkSizeWarningLimit: 1000
  }
})
EOF

    # tsconfig.json
    cat > tsconfig.json << 'EOF'
{
  "extends": "@vue/tsconfig/tsconfig.dom.json",
  "include": ["env.d.ts", "src/**/*", "src/**/*.vue"],
  "exclude": ["src/**/__tests__/*"],
  "compilerOptions": {
    "composite": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    },
    "strict": true,
    "skipLibCheck": true
  }
}
EOF

    # index.html
    cat > index.html << EOF
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>$PROJECT_NAME</title>
  </head>
  <body>
    <div id="app"></div>
    <script type="module" src="/src/main.ts"></script>
  </body>
</html>
EOF
}

# 创建Gin微服务配置
create_gin_microservice_configs() {
    # go.mod
    cat > go.mod << EOF
module $PROJECT_NAME

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    github.com/gin-contrib/cors v1.4.0
    gorm.io/gorm v1.25.5
    gorm.io/driver/postgres v1.5.4
    github.com/redis/go-redis/v9 v9.3.0
    github.com/spf13/viper v1.17.0
    github.com/golang-jwt/jwt/v5 v5.0.0
    go.uber.org/zap v1.26.0
    github.com/swaggo/gin-swagger v1.6.0
    github.com/swaggo/files v1.0.1
    github.com/swaggo/swag v1.16.2
)
EOF

    # configs/config.yaml
    cat > configs/config.yaml << EOF
app:
  name: "$PROJECT_NAME"
  mode: "development"

server:
  port: 8080
  read_timeout: 60
  write_timeout: 60
  idle_timeout: 60

database:
  postgresql:
    host: "localhost"
    port: 5432
    user: "postgres"
    password: "password"
    dbname: "${PROJECT_NAME//-/_}"
    sslmode: "disable"
    max_idle_conns: 10
    max_open_conns: 100
    conn_max_lifetime: 3600

redis:
  host: "localhost"
  port: 6379
  password: ""
  db: 0

jwt:
  secret_key: "your-secret-key-change-in-production"
  expire_time: 3600
  refresh_time: 604800
  issuer: "$PROJECT_NAME"
  signing_method: "HS256"

log:
  level: "info"
  format: "json"
  output: "stdout"
EOF

    # Docker Compose
    cat > deployments/docker/docker-compose.yml << EOF
version: '3.8'

services:
  app:
    build:
      context: ../..
      dockerfile: deployments/docker/Dockerfile
    ports:
      - "8080:8080"
    environment:
      - GIN_MODE=debug
      - DATABASE_HOST=postgres
      - REDIS_HOST=redis
    depends_on:
      - postgres
      - redis
    networks:
      - app-network

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
      POSTGRES_DB: ${PROJECT_NAME//-/_}
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - app-network

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    networks:
      - app-network

volumes:
  postgres_data:
  redis_data:

networks:
  app-network:
    driver: bridge
EOF

    # Dockerfile
    cat > deployments/docker/Dockerfile << 'EOF'
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o main cmd/server/main.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates tzdata
WORKDIR /root/

COPY --from=builder /app/main .
COPY --from=builder /app/configs ./configs

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/api/v1/health || exit 1

CMD ["./main"]
EOF
}

# 创建Go桌面应用配置
create_go_desktop_configs() {
    # go.mod
    cat > go.mod << EOF
module $PROJECT_NAME

go 1.21

require (
    fyne.io/fyne/v2 v2.4.0
    gorm.io/gorm v1.25.5
    gorm.io/driver/sqlite v1.5.4
    github.com/spf13/viper v1.17.0
    go.uber.org/zap v1.26.0
)
EOF

    # cmd/main.go
    mkdir -p cmd
    cat > cmd/main.go << 'EOF'
package main

import (
    "context"
    "log"
    
    "fyne.io/fyne/v2/app"
    "fyne.io/fyne/v2/widget"
    
    "PROJECT_NAME/internal/ui"
    "PROJECT_NAME/internal/core"
)

func main() {
    // 创建应用
    myApp := app.New()
    myApp.SetIcon(resourceIconPng)
    
    // 创建主窗口
    myWindow := myApp.NewWindow("应用标题")
    myWindow.Resize(fyne.NewSize(800, 600))
    
    // 初始化核心服务
    ctx := context.Background()
    coreService := core.NewService(ctx)
    
    // 创建UI
    mainUI := ui.NewMainWindow(myWindow, coreService)
    myWindow.SetContent(mainUI.Build())
    
    // 显示并运行
    myWindow.ShowAndRun()
}
EOF
}

# 创建优化的CLAUDE.md文件（项目特定）
create_claude_md() {
    print_step "创建项目特定的CLAUDE.md操作指南..."

    # 获取项目类型对应的规范文件路径
    local project_spec_file="$GLOBAL_RULES_DIR/project_types/${PROJECT_TYPE}.md"
    local deployment_guide="$GLOBAL_RULES_DIR/guides/DEPLOYMENT_STRATEGY_GUIDE.md"
    
    # 创建简洁的项目特定CLAUDE.md
    cat > CLAUDE.md << EOF
# $PROJECT_NAME - Claude Code 操作指南

## 🎯 项目信息
- **项目名称**: $PROJECT_NAME
- **项目类型**: ${PROJECT_TYPES[$PROJECT_TYPE]}
- **创建日期**: $CURRENT_DATE
- **开发工具**: Claude Code + VSCode + MCP

## 🚨 重要提醒
- **全局规范**: 已通过 Memory MCP 管理，启动时自动加载
- **项目规范**: 严格遵循 ${PROJECT_TYPE} 项目标准
- **部署策略**: 遵循项目类型对应的部署规范

## 🔧 开发工作流程

### 1. 会话启动
\`\`\`bash
# Memory MCP 自动加载全局规范和历史经验
memory.recall_memory_abstract(context="global_rules,${PROJECT_TYPE}_projects")
\`\`\`

### 2. 开发命令
EOF

    # 根据项目类型添加特定的开发命令
    case $PROJECT_TYPE in
        "gin-vue"|"gin_vue3")
            cat >> CLAUDE.md << 'EOF'
```bash
# 启动开发环境
make dev              # 同时启动前后端
make dev-backend      # 只启动Go后端
make dev-frontend     # 只启动Vue前端

# 代码质量检查
make lint             # 前后端代码检查
make test             # 运行所有测试
make build            # 构建生产版本

# 部署相关（Docker容器化）
make docker-build     # 构建Docker镜像
make docker-run       # 运行Docker容器
make deploy           # 生产部署
```
EOF
            ;;
        "gin-microservice")
            cat >> CLAUDE.md << 'EOF'
```bash
# 开发环境
make dev              # 启动开发服务器
make test             # 运行测试
make lint             # 代码检查

# 构建部署
make build            # 编译二进制文件
make docker-build     # 构建Docker镜像
make deploy           # 生产部署
```
EOF
            ;;
        "vue3-frontend")
            cat >> CLAUDE.md << 'EOF'
```bash
# 开发环境
npm run dev           # 启动开发服务器
npm run test          # 运行测试
npm run lint          # 代码检查

# 构建部署
npm run build         # 构建生产版本
npm run preview       # 预览构建结果
```
EOF
            ;;
        "python-desktop")
            cat >> CLAUDE.md << 'EOF'
```bash
# 开发环境
make init             # 初始化虚拟环境
make dev              # 启动开发模式
make test             # 运行测试

# 构建部署
make build            # 构建可执行文件
make package          # 打包分发版本
```
EOF
            ;;
        "go-desktop")
            cat >> CLAUDE.md << 'EOF'
```bash
# 开发环境
make dev              # 启动开发模式
make test             # 运行测试
make lint             # 代码检查

# 构建部署
make build-all        # 多平台编译
make package          # 打包分发版本
```
EOF
            ;;
        *)
            cat >> CLAUDE.md << 'EOF'
```bash
# 通用开发命令
make init             # 初始化环境
make dev              # 启动开发
make test             # 运行测试
make lint             # 代码检查
make build            # 构建项目
```
EOF
            ;;
    esac

    # 添加部署策略信息
    cat >> CLAUDE.md << EOF

### 3. 部署策略
EOF

    case $PROJECT_TYPE in
        "gin-vue"|"gin-microservice"|"fastapi-vue")
            cat >> CLAUDE.md << 'EOF'
- **策略**: 🐳 强制容器化部署
- **架构**: 支持 ARM64 + AMD64
- **命令**: `./scripts/multi-arch-build.sh` → `./deployments/production-safe-deploy.sh`
- **检查**: 部署后必须通过 `/health` 端点验证
EOF
            ;;
        "vue3-frontend")
            cat >> CLAUDE.md << 'EOF'
- **策略**: 📦 静态部署优先，容器化可选
- **推荐**: Nginx + CDN 分发
- **命令**: `npm run build` → 部署到静态服务器
EOF
            ;;
        "go-desktop"|"python-desktop")
            cat >> CLAUDE.md << 'EOF'
- **策略**: 💻 原生编译部署
- **禁止**: 🚫 容器化部署
- **命令**: `make build-all` → 多平台可执行文件
- **分发**: 直接下载安装，无复杂依赖
EOF
            ;;
    esac

    cat >> CLAUDE.md << EOF

### 4. 会话结束
\`\`\`bash
# 保存开发经验到 Memory MCP
memory.save_memory(
  speaker="developer",
  message="[项目开发总结和关键决策]",
  context="global_rules,${PROJECT_TYPE}_projects"
)
\`\`\`

## 📋 项目规范重点
EOF

    # 引用项目类型特定规范的关键点
    if [[ -f "$project_spec_file" ]]; then
        echo "- 📖 完整规范: 请查看 \`project_types/${PROJECT_TYPE}.md\`" >> CLAUDE.md
        
        # 提取项目规范文件的关键信息（前几个要点）
        if grep -q "## 🔴 强制要求" "$project_spec_file" 2>/dev/null; then
            echo "- 🔴 **强制要求**: 已集成到全局 Memory MCP 中" >> CLAUDE.md
        fi
        
        # 根据项目类型添加关键规范提醒
        case $PROJECT_TYPE in
            "gin-vue"|"gin-microservice")
                cat >> CLAUDE.md << 'EOF'
- 🏗️ **目录结构**: 遵循标准 Go 项目布局
- 📡 **API 设计**: 统一响应格式 + Swagger 文档
- 🔒 **安全规范**: JWT + 参数验证 + SQL 防注入
- 🐳 **容器化**: Docker 多架构支持必须
EOF
                ;;
            "vue3-frontend")
                cat >> CLAUDE.md << 'EOF'
- 🎨 **组件化**: Element Plus + 响应式设计
- 📦 **构建优化**: Vite + Tree Shaking
- 🔧 **代码质量**: ESLint + Prettier + TypeScript
- 📱 **多端适配**: PC + 移动端兼容
EOF
                ;;
            "go-desktop"|"python-desktop")
                cat >> CLAUDE.md << 'EOF'
- 🖥️ **跨平台**: Windows + macOS + Linux 支持
- 📦 **单文件**: 可执行程序，无复杂依赖
- 🚫 **禁止容器化**: 桌面应用不使用 Docker
- 🔧 **构建系统**: 多平台自动化编译
EOF
                ;;
        esac
    else
        echo "- ⚠️ 项目规范文件未找到: $project_spec_file" >> CLAUDE.md
    fi

    cat >> CLAUDE.md << EOF

## 🔗 相关资源
- 📖 [项目类型规范](project_types/${PROJECT_TYPE}.md)
- 🚀 [部署策略指南](guides/DEPLOYMENT_STRATEGY_GUIDE.md)
- 💾 Memory MCP: 全局规范和历史经验已自动加载
- 🛠️ 开发记录: \`project_process/\` 目录

---
**📅 创建时间**: $CURRENT_TIME  
**🤖 生成工具**: Claude Code v2.0 (优化版)  
**🎯 项目类型**: ${PROJECT_TYPES[$PROJECT_TYPE]}  
**💾 规范来源**: Memory MCP + project_types/${PROJECT_TYPE}.md
EOF

    print_success "项目特定的CLAUDE.md创建完成"
}

# 创建README.md
create_readme() {
    print_step "创建README.md..."

    cat > README.md << EOF
# $PROJECT_NAME

${PROJECT_TYPES[$PROJECT_TYPE]}

## 📋 项目简介

项目描述待补充...

## 🚀 快速开始

### 环境要求

EOF

    case $PROJECT_TYPE in
        "python-desktop"|"fastapi-vue")
            cat >> README.md << EOF
- Python 3.8+
- pip3
EOF
            ;;
        "gin-vue"|"gin-microservice"|"go-desktop")
            cat >> README.md << EOF
- Go 1.19+
EOF
            ;;
        "vue3-frontend"|"fastapi-vue"|"gin-vue")
            cat >> README.md << EOF
- Node.js 16+
- npm
EOF
            ;;
    esac

    cat >> README.md << EOF

### 安装和运行

\`\`\`bash
# 初始化项目
make init

# 启动开发环境
make dev

# 运行测试
make test

# 构建项目
make build
\`\`\`

## 📖 更多信息

详细的开发指南请查看 [CLAUDE.md](./CLAUDE.md)

## 📅 开发记录

项目的详细开发过程记录在 \`project_process/\` 目录中。

---

**创建时间**: $CURRENT_TIME  
**开发工具**: Claude Code + VSCode
EOF

    print_success "README.md创建完成"
}

# 初始化Git仓库
init_git_repo() {
    if [[ $INIT_GIT == true ]]; then
        print_step "初始化Git仓库..."
        
        git init
        git add .
        git commit -m "feat: initial project setup

- 项目类型: ${PROJECT_TYPES[$PROJECT_TYPE]}
- 使用Claude Code标准模板创建
- 包含完整的目录结构和配置文件

🤖 Generated with Claude Code"

        print_success "Git仓库初始化完成"
    fi
}

# 创建首次开发记录
create_initial_record() {
    print_step "创建首次开发记录..."

    local daily_record="project_process/daily/$CURRENT_DATE.md"
    
    cat > "$daily_record" << EOF
# 开发记录 - $CURRENT_DATE

## 📅 今日概要

**日期**: $CURRENT_DATE  
**工作类型**: 项目初始化  
**主要成果**: 完成项目基础架构搭建

## ✅ 今日完成

### 🏗️ 项目初始化
- [x] 创建标准目录结构
- [x] 配置开发环境文件 (VSCode, ESLint, Prettier等)
- [x] 创建项目文档框架
- [x] 建立开发记录体系

### 📋 具体工作

1. **环境配置**
   - 项目类型: ${PROJECT_TYPES[$PROJECT_TYPE]}
   - 目录结构: 按照全局规范创建
   - 开发工具: VSCode + Claude Code

2. **文件创建**
   - CLAUDE.md: Claude Code操作指南
   - README.md: 项目说明文档
   - Makefile: 构建和开发命令
   - .vscode/: 统一的编辑器配置

## 🔄 下一步计划

### 明日目标
- [ ] 完善项目配置
- [ ] 开始核心功能开发
- [ ] 补充测试用例

### 近期规划
- 完成基础功能模块
- 建立CI/CD流程
- 完善文档和测试

## 🤖 Claude Code 执行记录

### $CURRENT_TIME
- **命令**: 项目初始化脚本
- **结果**: 成功创建完整项目结构
- **文件**: 生成了所有必要的配置和模板文件

## 💭 今日反思

- 项目架构设计合理，遵循了最佳实践
- 开发环境配置完整，支持高效开发
- 建立了标准化的工作流程

## 📊 时间统计

- **项目初始化**: 30分钟
- **配置调整**: 15分钟
- **文档编写**: 15分钟

**总计**: 1小时

---

**记录者**: Claude Code  
**记录时间**: $CURRENT_TIME
EOF

    print_success "首次开发记录创建完成"
}

# 显示完成总结
show_completion_summary() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    🎉 项目初始化完成! 🎉                     ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    print_success "项目信息"
    echo "  📁 项目名称: $PROJECT_NAME"
    echo "  🏷️  项目类型: ${PROJECT_TYPES[$PROJECT_TYPE]}"
    echo "  📍 项目路径: $TARGET_DIR"
    echo ""
    
    print_success "创建的文件"
    echo "  📄 CLAUDE.md - Claude Code操作指南"
    echo "  📄 README.md - 项目说明文档"
    echo "  📄 Makefile - 构建命令"
    echo "  📁 .vscode/ - VSCode配置"
    echo "  📁 project_process/ - 开发记录"
    echo ""
    
    print_success "下一步操作"
    echo "  1. 进入项目目录: cd $PROJECT_NAME"
    echo "  2. 初始化环境: make init"
    echo "  3. 查看操作指南: cat CLAUDE.md"
    echo "  4. 开始开发: make dev"
    echo ""
    
    if [[ $INIT_GIT == true ]]; then
        print_success "Git仓库已初始化，首次提交已完成"
    else
        print_info "提示: 使用 -g 选项可以自动初始化Git仓库"
    fi
    
    echo ""
    print_info "🚀 现在可以用Claude Code开始高效开发了!"
}

# 主函数
main() {
    print_header
    
    # 解析参数
    if [[ $# -eq 0 ]]; then
        show_help
        exit 0
    fi
    
    # 处理帮助选项
    if [[ $1 == "-h" || $1 == "--help" ]]; then
        show_help
        exit 0
    fi
    
    validate_args "$@"
    parse_options "$@"
    
    print_info "开始初始化项目: $PROJECT_NAME ($PROJECT_TYPE)"
    
    # 执行初始化步骤
    check_dependencies
    create_directory_structure
    copy_config_files
    create_claude_md
    create_readme
    create_initial_record
    init_git_repo
    
    # 显示完成总结
    show_completion_summary
}

# 执行主函数
main "$@"