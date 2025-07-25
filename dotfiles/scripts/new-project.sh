#!/bin/bash

# new-project.sh - 基于dotfiles的新项目创建脚本
# 快速创建标准化的新项目

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

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

print_header() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                  🚀 新项目创建工具                           ║"
    echo "║                                                              ║"
    echo "║           基于dotfiles模板快速创建标准化项目                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# 显示可用的项目类型
show_project_types() {
    echo -e "${CYAN}可用的项目类型:${NC}"
    echo "  vue3-frontend      - Vue3 + TypeScript + Element Plus 前端项目"
    echo "  gin-microservice   - Go + Gin + PostgreSQL 微服务项目"
    echo "  go-desktop         - Go + Fyne/Walk 桌面应用"
    echo "  python-desktop     - Python + tkinter 桌面应用"
    echo "  fastapi-vue        - FastAPI + Vue3 全栈项目"
    echo ""
}

# 显示使用说明
show_usage() {
    echo "用法: $0 <项目名称> <项目类型> [选项]"
    echo ""
    show_project_types
    echo "选项:"
    echo "  -d, --directory DIR    指定项目创建目录 (默认: 当前目录)"
    echo "  -g, --git             初始化Git仓库"
    echo "  -r, --remote URL      设置Git远程仓库"
    echo "  -h, --help            显示帮助信息"
    echo ""
    echo "示例:"
    echo "  $0 my-app vue3-frontend"
    echo "  $0 my-service gin-microservice -g"
    echo "  $0 my-desktop go-desktop -d ~/Projects -g"
}

# 复制项目模板
copy_project_template() {
    local project_name="$1"
    local project_type="$2"
    local target_dir="$3"
    
    local template_dir="$DOTFILES_DIR/project-templates/global_rules"
    local type_spec_file="$template_dir/project_types/${project_type}.md"
    
    print_info "创建项目: $project_name (类型: $project_type)"
    
    # 检查模板是否存在
    if [ ! -f "$type_spec_file" ]; then
        print_error "项目类型 '$project_type' 不存在"
        print_info "运行 '$0 --help' 查看可用类型"
        exit 1
    fi
    
    # 创建项目目录
    local project_path="$target_dir/$project_name"
    if [ -d "$project_path" ]; then
        print_error "项目目录已存在: $project_path"
        exit 1
    fi
    
    mkdir -p "$project_path"
    cd "$project_path"
    
    # 复制通用模板文件
    print_info "复制通用模板文件..."
    
    # 复制基础配置文件
    if [ -f "$template_dir/templates/.editorconfig" ]; then
        cp "$template_dir/templates/.editorconfig" .
    fi
    
    if [ -f "$template_dir/templates/.gitignore" ]; then
        cp "$template_dir/templates/.gitignore" .
    fi
    
    # 创建CLAUDE.md
    if [ -f "$template_dir/templates/CLAUDE.md.template" ]; then
        sed "s/{{PROJECT_NAME}}/$project_name/g; s/{{PROJECT_TYPE}}/$project_type/g" \
            "$template_dir/templates/CLAUDE.md.template" > CLAUDE.md
    fi
    
    # 创建project_process目录结构
    mkdir -p project_process/{daily,weekly,monthly}
    
    if [ -f "$template_dir/templates/project_process_structure/README.md" ]; then
        cp "$template_dir/templates/project_process_structure/README.md" project_process/
    fi
    
    # 根据项目类型创建特定结构
    create_project_structure "$project_type" "$project_name"
    
    print_success "项目模板创建完成"
}

# 根据项目类型创建特定结构
create_project_structure() {
    local project_type="$1"
    local project_name="$2"
    
    case "$project_type" in
        "vue3-frontend")
            create_vue3_structure "$project_name"
            ;;
        "gin-microservice")
            create_gin_structure "$project_name"
            ;;
        "go-desktop")
            create_go_desktop_structure "$project_name"
            ;;
        "python-desktop")
            create_python_desktop_structure "$project_name"
            ;;
        "fastapi-vue")
            create_fastapi_vue_structure "$project_name"
            ;;
        *)
            print_warning "未知项目类型: $project_type，只创建基础结构"
            ;;
    esac
}

# 创建Vue3前端项目结构
create_vue3_structure() {
    local project_name="$1"
    
    print_info "创建Vue3项目结构..."
    
    # 创建目录结构
    mkdir -p src/{components,views,stores,router,api,utils,assets/{images,styles}}
    mkdir -p public
    mkdir -p tests/unit
    
    # 创建package.json
    cat > package.json << EOF
{
  "name": "$project_name",
  "version": "1.0.0",
  "description": "Vue3 + TypeScript + Element Plus 前端项目",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "lint": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --fix",
    "type-check": "vue-tsc --noEmit"
  },
  "dependencies": {
    "vue": "^3.4.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "element-plus": "^2.5.0",
    "@element-plus/icons-vue": "^2.3.0",
    "axios": "^1.6.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^5.0.0",
    "@vue/tsconfig": "^0.5.0",
    "typescript": "^5.3.0",
    "vue-tsc": "^1.8.0",
    "vite": "^5.0.0",
    "vitest": "^1.0.0",
    "eslint": "^8.57.0",
    "@typescript-eslint/eslint-plugin": "^6.19.0",
    "@typescript-eslint/parser": "^6.19.0",
    "eslint-plugin-vue": "^9.20.0",
    "prettier": "^3.2.0"
  }
}
EOF

    # 创建vite.config.ts
    cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  },
  server: {
    port: 3000,
    open: true
  },
  build: {
    outDir: 'dist',
    sourcemap: false,
    rollupOptions: {
      output: {
        chunkFileNames: 'js/[name]-[hash].js',
        entryFileNames: 'js/[name]-[hash].js',
        assetFileNames: '[ext]/[name]-[hash].[ext]'
      }
    }
  }
})
EOF

    # 创建tsconfig.json
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
    }
  }
}
EOF

    # 创建基础Vue文件
    cat > src/main.ts << 'EOF'
import { createApp } from 'vue'
import { createPinia } from 'pinia'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'

import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.use(ElementPlus)

app.mount('#app')
EOF

    # 创建README.md
    cat > README.md << EOF
# $project_name

Vue3 + TypeScript + Element Plus 前端项目

## 开发环境要求

- Node.js >= 18.0.0
- npm >= 9.0.0

## 快速开始

\`\`\`bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build

# 运行测试
npm run test
\`\`\`

## 项目结构

\`\`\`
src/
├── components/     # 通用组件
├── views/          # 页面组件
├── stores/         # Pinia状态管理
├── router/         # Vue Router路由
├── api/            # API接口
├── utils/          # 工具函数
└── assets/         # 静态资源
\`\`\`
EOF

    print_success "Vue3项目结构创建完成"
}

# 创建Gin微服务项目结构
create_gin_structure() {
    local project_name="$1"
    
    print_info "创建Gin微服务项目结构..."
    
    # 创建目录结构
    mkdir -p cmd/server
    mkdir -p internal/{api,models,services,repository,middleware,config}
    mkdir -p pkg/{utils,response}
    mkdir -p configs
    mkdir -p deployments/{docker,k8s}
    mkdir -p tests
    mkdir -p docs
    
    # 创建go.mod
    cat > go.mod << EOF
module $project_name

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    github.com/spf13/viper v1.17.0
    gorm.io/gorm v1.25.5
    gorm.io/driver/postgres v1.5.4
    github.com/redis/go-redis/v9 v9.3.0
)
EOF

    # 创建main.go
    cat > cmd/server/main.go << 'EOF'
package main

import (
    "log"
    "github.com/gin-gonic/gin"
)

func main() {
    r := gin.Default()
    
    r.GET("/health", func(c *gin.Context) {
        c.JSON(200, gin.H{
            "status": "ok",
            "service": "gin-microservice",
        })
    })
    
    log.Println("服务启动在端口 :8080")
    r.Run(":8080")
}
EOF

    # 创建Makefile
    cat > Makefile << 'EOF'
.PHONY: build run test clean docker

# Go参数
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get

# 项目参数
BINARY_NAME=server
BINARY_UNIX=$(BINARY_NAME)_unix

# 构建
build:
	$(GOBUILD) -o $(BINARY_NAME) ./cmd/server

# 运行
run:
	$(GOBUILD) -o $(BINARY_NAME) ./cmd/server
	./$(BINARY_NAME)

# 测试
test:
	$(GOTEST) -v ./...

# 清理
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(BINARY_UNIX)

# Docker构建
docker:
	docker build -t $(BINARY_NAME) .

# 跨平台构建
build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_UNIX) ./cmd/server
EOF

    # 创建Dockerfile
    cat > Dockerfile << 'EOF'
# 构建阶段
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o server ./cmd/server

# 运行阶段
FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /root/

COPY --from=builder /app/server .

EXPOSE 8080

CMD ["./server"]
EOF

    # 创建README.md
    cat > README.md << EOF
# $project_name

Go + Gin + PostgreSQL 微服务项目

## 开发环境要求

- Go >= 1.21
- PostgreSQL >= 13
- Redis >= 6.0

## 快速开始

\`\`\`bash
# 安装依赖
go mod tidy

# 运行服务
make run

# 构建
make build

# 运行测试
make test
\`\`\`

## 项目结构

\`\`\`
cmd/server/         # 应用入口
internal/           # 私有代码
├── api/           # HTTP处理器
├── models/        # 数据模型
├── services/      # 业务逻辑
├── repository/    # 数据访问层
├── middleware/    # 中间件
└── config/        # 配置
pkg/               # 可复用包
deployments/       # 部署配置
\`\`\`
EOF

    print_success "Gin微服务项目结构创建完成"
}

# 创建Go桌面应用项目结构
create_go_desktop_structure() {
    local project_name="$1"
    
    print_info "创建Go桌面应用项目结构..."
    
    # 创建目录结构
    mkdir -p cmd
    mkdir -p internal/{ui,models,services,config}
    mkdir -p pkg/utils
    mkdir -p assets/{icons,images}
    mkdir -p configs
    mkdir -p build
    
    # 创建go.mod
    cat > go.mod << EOF
module $project_name

go 1.21

require (
    fyne.io/fyne/v2 v2.4.3
    gorm.io/gorm v1.25.5
    gorm.io/driver/sqlite v1.5.4
)
EOF

    # 创建main.go
    cat > cmd/main.go << 'EOF'
package main

import (
    "fyne.io/fyne/v2/app"
    "fyne.io/fyne/v2/container"
    "fyne.io/fyne/v2/widget"
)

func main() {
    myApp := app.New()
    myWindow := myApp.NewWindow("Go Desktop App")
    myWindow.Resize(fyne.NewSize(800, 600))

    hello := widget.NewLabel("Hello, World!")
    content := container.NewVBox(hello)

    myWindow.SetContent(content)
    myWindow.ShowAndRun()
}
EOF

    print_success "Go桌面应用项目结构创建完成"
}

# 创建Python桌面项目结构
create_python_desktop_structure() {
    local project_name="$1"
    
    print_info "创建Python桌面项目结构..."
    
    # 创建目录结构
    mkdir -p src/{ui,models,services,utils}
    mkdir -p assets/{icons,images}
    mkdir -p tests
    mkdir -p configs
    
    # 创建requirements.txt
    cat > requirements.txt << 'EOF'
tkinter
pillow>=10.0.0
sqlite3
EOF

    # 创建requirements-dev.txt
    cat > requirements-dev.txt << 'EOF'
pytest>=7.0.0
black>=23.0.0
flake8>=6.0.0
mypy>=1.0.0
EOF

    # 创建src/main.py
    cat > src/main.py << 'EOF'
#!/usr/bin/env python3
"""
Python Desktop Application
"""

import tkinter as tk
from tkinter import ttk

class MainApplication:
    def __init__(self, root):
        self.root = root
        self.root.title("Python Desktop App")
        self.root.geometry("800x600")
        
        self.create_widgets()
    
    def create_widgets(self):
        # 创建主框架
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # 添加标签
        label = ttk.Label(main_frame, text="Hello, World!")
        label.grid(row=0, column=0, pady=10)
        
        # 添加按钮
        button = ttk.Button(main_frame, text="点击我", command=self.on_button_click)
        button.grid(row=1, column=0, pady=10)
    
    def on_button_click(self):
        print("按钮被点击了！")

def main():
    root = tk.Tk()
    app = MainApplication(root)
    root.mainloop()

if __name__ == "__main__":
    main()
EOF

    chmod +x src/main.py

    print_success "Python桌面项目结构创建完成"
}

# 创建FastAPI+Vue全栈项目结构
create_fastapi_vue_structure() {
    local project_name="$1"
    
    print_info "创建FastAPI+Vue全栈项目结构..."
    
    # 创建后端结构
    mkdir -p backend/{app/{api,core,db,schemas,services},tests}
    mkdir -p frontend/src/{components,views,stores,router,api,utils}
    mkdir -p deployments/{docker,k8s}
    
    # 创建后端requirements.txt
    cat > backend/requirements.txt << 'EOF'
fastapi>=0.104.0
uvicorn[standard]>=0.24.0
sqlalchemy>=2.0.0
alembic>=1.12.0
psycopg2-binary>=2.9.0
pydantic>=2.5.0
python-jose[cryptography]>=3.3.0
passlib[bcrypt]>=1.7.0
python-multipart>=0.0.6
EOF

    # 创建前端package.json
    cat > frontend/package.json << EOF
{
  "name": "$project_name-frontend",
  "version": "1.0.0",
  "description": "FastAPI + Vue3 前端",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "vue": "^3.4.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "axios": "^1.6.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^5.0.0",
    "typescript": "^5.3.0",
    "vue-tsc": "^1.8.0",
    "vite": "^5.0.0"
  }
}
EOF

    print_success "FastAPI+Vue全栈项目结构创建完成"
}

# 初始化Git仓库
init_git_repo() {
    local remote_url="$1"
    
    print_info "初始化Git仓库..."
    
    git init
    git add .
    git commit -m "feat: 初始化项目

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"
    
    if [ -n "$remote_url" ]; then
        print_info "添加远程仓库: $remote_url"
        git remote add origin "$remote_url"
    fi
    
    print_success "Git仓库初始化完成"
}

# 运行项目健康检查
run_health_check() {
    local health_script="$DOTFILES_DIR/project-templates/global_rules/scripts/health-check.sh"
    
    if [ -f "$health_script" ]; then
        print_info "运行项目健康检查..."
        "$health_script" . --verbose
    else
        print_warning "未找到健康检查脚本，跳过检查"
    fi
}

# 主函数
main() {
    local project_name=""
    local project_type=""
    local target_dir="$(pwd)"
    local init_git=false
    local remote_url=""
    
    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--directory)
                target_dir="$2"
                shift 2
                ;;
            -g|--git)
                init_git=true
                shift
                ;;
            -r|--remote)
                remote_url="$2"
                init_git=true
                shift 2
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            -*)
                print_error "未知选项: $1"
                show_usage
                exit 1
                ;;
            *)
                if [ -z "$project_name" ]; then
                    project_name="$1"
                elif [ -z "$project_type" ]; then
                    project_type="$1"
                else
                    print_error "过多的参数: $1"
                    show_usage
                    exit 1
                fi
                shift
                ;;
        esac
    done
    
    # 检查必需参数
    if [ -z "$project_name" ] || [ -z "$project_type" ]; then
        print_error "缺少必需参数"
        show_usage
        exit 1
    fi
    
    # 验证项目名称
    if [[ ! "$project_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        print_error "项目名称只能包含字母、数字、下划线和连字符"
        exit 1
    fi
    
    # 确保目标目录存在
    if [ ! -d "$target_dir" ]; then
        print_info "创建目标目录: $target_dir"
        mkdir -p "$target_dir"
    fi
    
    print_header
    
    # 复制项目模板
    copy_project_template "$project_name" "$project_type" "$target_dir"
    
    # 进入项目目录
    cd "$target_dir/$project_name"
    
    # 初始化Git仓库
    if [ "$init_git" = true ]; then
        init_git_repo "$remote_url"
    fi
    
    # 运行健康检查
    run_health_check
    
    echo ""
    print_success "🎉 项目创建完成！"
    print_info "📍 项目路径: $target_dir/$project_name"
    print_info "🔧 项目类型: $project_type"
    
    echo ""
    print_info "💡 下一步操作:"
    case "$project_type" in
        "vue3-frontend")
            print_info "1. cd $project_name && npm install"
            print_info "2. npm run dev"
            ;;
        "gin-microservice"|"go-desktop")
            print_info "1. cd $project_name && go mod tidy"
            print_info "2. make run"
            ;;
        "python-desktop")
            print_info "1. cd $project_name && pip install -r requirements.txt"
            print_info "2. python src/main.py"
            ;;
        "fastapi-vue")
            print_info "1. cd $project_name"
            print_info "2. 后端: cd backend && pip install -r requirements.txt"
            print_info "3. 前端: cd frontend && npm install"
            ;;
    esac
    
    print_info "🤖 使用Claude Code开始开发吧！"
}

# 执行主函数
main "$@"