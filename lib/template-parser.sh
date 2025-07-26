#!/bin/bash

# Claude Autopilot 2.1 智能模板解析器
# 功能：动态解析项目类型模板并合并全局规则生成完整项目结构
# 版本：1.0.0

# 动态检测脚本路径  
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 确保路径变量（直接计算，不依赖环境变量）
ensure_global_paths() {
    # 直接计算全局路径
    GLOBAL_RULES_PATH="$(dirname "$SCRIPT_DIR")"
    GLOBAL_CE_PATH="$GLOBAL_RULES_PATH/share/claude-autopilot"
}

# 加载跨平台工具函数
source "$SCRIPT_DIR/cross-platform-utils.sh"

# 全局规则定义：所有项目都需要的通用结构
GLOBAL_STRUCTURE=(
    # 项目管理目录
    "project_process"
    "project_process/daily"
    "project_process/reports" 
    "project_process/prps"
    "project_process/bugfixes"
    "project_process/analysis"
    "project_docs"
    
    # 开发工具目录
    "scripts"
    "tests"
    ".vscode"
    ".claude"
    ".claude/commands"
    
    # 部署目录（智能Docker部署标准）
    "deployments"
)

# 全局规则文件：所有项目都需要的文件
GLOBAL_FILES=(
    ".gitignore"
    ".editorconfig"
    "README.md"
    "Makefile"
)

# 全局部署文件（智能Docker部署标准）
GLOBAL_DEPLOYMENT_FILES=(
    "deployments/docker-compose.smart.yml"
    "deployments/production-safe-deploy.sh"
    "deployments/.env.example"
)

# 解析项目类型模板
parse_project_template() {
    local project_type="$1"
    
    # 直接使用固定路径
    local template_file="$GLOBAL_RULES_PATH/share/claude-autopilot/project-types/${project_type}.md"
    
    if [ ! -f "$template_file" ]; then
        echo "❌ 错误: 项目类型模板不存在: $template_file"
        return 1
    fi
    
    echo "📖 解析项目模板: $project_type"
    
    # 提取项目结构定义（在## 📁 项目架构 或 ## 🏗️ 通用标准项目结构 部分）
    local structure_section=""
    local in_structure_section=false
    local structure_lines=()
    
    while IFS= read -r line; do
        # 检测结构开始标记
        if [[ "$line" =~ ^##.*项目(架构|结构) ]] || [[ "$line" =~ ^##.*标准项目结构 ]]; then
            in_structure_section=true
            continue
        fi
        
        # 检测下一个## 标题，结束结构解析
        if [[ "$in_structure_section" == true ]] && [[ "$line" =~ ^## ]]; then
            break
        fi
        
        # 收集结构行
        if [[ "$in_structure_section" == true ]]; then
            structure_lines+=("$line")
        fi
    done < "$template_file"
    
    # 简单解析目录结构（暂时使用默认结构）
    local directories=(
        "backend"
        "backend/cmd"
        "backend/cmd/server"
        "backend/internal"
        "backend/internal/handler"
        "backend/internal/service"
        "backend/internal/model"
        "backend/internal/middleware"
        "backend/internal/config"
        "backend/pkg"
        "backend/pkg/database"
        "backend/pkg/utils"
        "backend/configs"
        "backend/migrations"
        "frontend"
        "frontend/src"
        "frontend/src/components"
        "frontend/src/views"
        "frontend/src/stores"
        "frontend/src/utils"
        "frontend/src/api"
        "frontend/src/router"
        "frontend/src/types"
        "frontend/public"
    )
    
    # 输出解析结果到全局变量
    PARSED_DIRECTORIES=("${directories[@]}")
    return 0
}

# 提取模板中的依赖配置
extract_template_dependencies() {
    local project_type="$1"
    
    # 确保全局路径变量正确设置
    ensure_global_paths
    
    # 使用全局路径变量
    local template_file="$GLOBAL_CE_PATH/project-types/${project_type}.md"
    
    # 提取依赖配置部分（如package.json, requirements.txt等）
    local in_deps_section=false
    local deps_content=""
    
    while IFS= read -r line; do
        # 检测依赖配置开始
        if [[ "$line" =~ (package\.json|requirements\.txt|go\.mod|Cargo\.toml|pom\.xml) ]]; then
            in_deps_section=true
        fi
        
        # 检测代码块结束
        if [[ "$in_deps_section" == true ]] && [[ "$line" =~ ^\`\`\` ]]; then
            in_deps_section=false
        fi
        
        # 收集依赖内容
        if [[ "$in_deps_section" == true ]]; then
            deps_content+="$line"$'\n'
        fi
    done < "$template_file"
    
    # 输出到全局变量
    PARSED_DEPENDENCIES="$deps_content"
}

# 提取模板中的Makefile配置
extract_template_makefile() {
    local project_type="$1"
    
    # 确保全局路径变量正确设置
    ensure_global_paths
    
    # 使用全局路径变量
    local template_file="$GLOBAL_CE_PATH/project-types/${project_type}.md"
    
    # 提取Makefile部分
    local in_makefile_section=false
    local makefile_content=""
    
    while IFS= read -r line; do
        # 检测Makefile开始
        if [[ "$line" =~ Makefile ]] && [[ "$line" =~ ^\`\`\` ]]; then
            in_makefile_section=true
            continue
        fi
        
        # 检测代码块结束
        if [[ "$in_makefile_section" == true ]] && [[ "$line" =~ ^\`\`\` ]]; then
            in_makefile_section=false
            break
        fi
        
        # 收集Makefile内容
        if [[ "$in_makefile_section" == true ]]; then
            makefile_content+="$line"$'\n'
        fi
    done < "$template_file"
    
    # 输出到全局变量
    PARSED_MAKEFILE="$makefile_content"
}

# 合并全局规则和项目特定结构
merge_global_and_project_structure() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    echo "🔄 合并全局规则和项目特定结构..."
    
    # 确保全局路径变量正确设置
    ensure_global_paths
    
    # 解析项目模板
    if ! parse_project_template "$project_type"; then
        echo "❌ 模板解析失败，使用通用结构"
        PARSED_DIRECTORIES=("src" "tests")
    fi
    
    # 合并目录结构
    local all_directories=()
    
    # 添加全局规则目录
    for dir in "${GLOBAL_STRUCTURE[@]}"; do
        all_directories+=("$dir")
    done
    
    # 添加项目特定目录
    for dir in "${PARSED_DIRECTORIES[@]}"; do
        # 避免重复
        if ! printf '%s\n' "${all_directories[@]}" | grep -q "^${dir}$"; then
            all_directories+=("$dir")
        fi
    done
    
    # 创建所有目录
    echo "📁 创建目录结构..."
    for dir in "${all_directories[@]}"; do
        if [ ! -d "$project_path/$dir" ]; then
            mkdir -p "$project_path/$dir"
            echo "   ✅ 创建目录: $dir/"
            
            # 为空目录添加.gitkeep
            if [ -z "$(ls -A "$project_path/$dir" 2>/dev/null)" ]; then
                touch "$project_path/$dir/.gitkeep"
            fi
        fi
    done
    
    # 创建全局规则文件
    create_global_files "$project_path" "$project_name"
    
    # 创建项目特定文件
    create_template_files "$project_path" "$project_type" "$project_name"
    
    echo "✅ 结构合并完成"
}

# 创建全局规则文件
create_global_files() {
    local project_path="$1"
    local project_name="$2"
    
    echo "📄 创建全局规则文件..."
    
    # 创建.gitignore
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
    
    # 创建.editorconfig
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
    
    # 创建全局部署文件
    create_global_deployment_files "$project_path" "$project_name"
    
    # 复制Claude命令文件
    create_claude_commands "$project_path"
    
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
        echo "   ✅ 创建文件: CHANGELOG.md"
    fi
}

# 创建全局部署文件
create_global_deployment_files() {
    local project_path="$1"
    local project_name="$2"
    
    echo "🚀 创建全局部署文件..."
    
    # 创建 deployments/docker-compose.smart.yml
    if [ ! -f "$project_path/deployments/docker-compose.smart.yml" ]; then
        cat > "$project_path/deployments/docker-compose.smart.yml" << 'EOF'
# Claude Autopilot 2.1 智能Docker Compose配置
# 支持智能环境检测和多架构部署

services:
  app:
    image: \${IMAGE_NAME:-myapp:latest}
    container_name: \${CONTAINER_NAME:-myapp}
    ports:
      - "\${APP_PORT:-8080}:8080"
    environment:
      - APP_ENV=\${APP_ENV:-production}
      - APP_HOST=0.0.0.0
      - APP_PORT=8080
    volumes:
      - app-data:/data
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

volumes:
  app-data:
    driver: local
EOF
        echo "   ✅ 创建文件: deployments/docker-compose.smart.yml"
    fi
    
    # 创建 deployments/production-safe-deploy.sh
    if [ ! -f "$project_path/deployments/production-safe-deploy.sh" ]; then
        cat > "$project_path/deployments/production-safe-deploy.sh" << 'EOF'
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
EOF
        chmod +x "$project_path/deployments/production-safe-deploy.sh"
        echo "   ✅ 创建文件: deployments/production-safe-deploy.sh"
    fi
    
    # 创建 deployments/.env.example
    if [ ! -f "$project_path/deployments/.env.example" ]; then
        cat > "$project_path/deployments/.env.example" << 'EOF'
# 生产部署环境变量配置

# 应用配置
PROJECT_NAME=myapp
IMAGE_NAME=myapp:latest
CONTAINER_NAME=myapp
APP_ENV=production
APP_PORT=8080

# 数据库配置（如需要）
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
DB_HOST=localhost
DB_PORT=5432
DB_DATABASE=myapp
DB_USERNAME=
DB_PASSWORD=

# Redis配置（如需要）
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# 安全配置
JWT_SECRET=your-super-secret-jwt-key-here
API_KEY=your-api-key-here
EOF
        echo "   ✅ 创建文件: deployments/.env.example"
    fi
}

# 创建Claude命令文件（Markdown格式）
create_claude_commands() {
    local project_path="$1"
    
    # 确保全局路径变量正确设置
    ensure_global_paths
    
    # 使用全局路径变量
    local source_docs_path="$GLOBAL_CE_PATH/docs"
    
    echo "🤖 复制Claude命令文件..."
    echo "   📂 源目录: $source_docs_path/"
    echo "   📂 目标目录: $project_path/.claude/commands/"
    
    # 复制核心智能命令（Markdown格式）
    local commands=(
        "cleanup-project"
        "smart-structure-validation"
        "smart-feature-dev"
        "smart-bugfix"
        "load-global-context"
        "commit-github"
        "smart-project-planning"
        "smart-work-summary"
    )
    
    local copied_count=0
    for cmd in "${commands[@]}"; do
        if [ -f "$source_docs_path/${cmd}.md" ]; then
            cp "$source_docs_path/${cmd}.md" "$project_path/.claude/commands/"
            echo "   ✅ 复制命令: ${cmd}.md"
            ((copied_count++))
        else
            echo "   ⚠️ 命令文件不存在: ${cmd}.md"
        fi
    done
    
    echo "   📊 成功复制 $copied_count 个命令文件"
}

# 创建项目特定文件（基于模板）
create_template_files() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    echo "📄 创建项目特定文件..."
    
    # 提取并创建依赖文件
    extract_template_dependencies "$project_type"
    if [ -n "$PARSED_DEPENDENCIES" ]; then
        # 根据项目类型创建相应的依赖文件
        case "$project_type" in
            "nodejs-general"|"vue3-frontend"|"react-frontend"|"nextjs-frontend")
                create_package_json "$project_path" "$project_name"
                ;;
            "django"|"python-"*)
                create_requirements_txt "$project_path"
                ;;
            "go-"*)
                create_go_mod "$project_path" "$project_name"
                ;;
            "rust-project")
                create_cargo_toml "$project_path" "$project_name"
                ;;
        esac
    fi
    
    # 提取并创建Makefile
    extract_template_makefile "$project_type"
    if [ -n "$PARSED_MAKEFILE" ]; then
        create_template_makefile "$project_path" "$project_type"
    else
        create_generic_makefile "$project_path" "$project_type"
    fi
    
    # 创建项目特定的基础文件
    create_project_base_files "$project_path" "$project_type" "$project_name"
}

# 创建package.json文件
create_package_json() {
    local project_path="$1"
    local project_name="$2"
    
    if [ ! -f "$project_path/package.json" ]; then
        cat > "$project_path/package.json" << EOF
{
  "name": "$project_name",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "lint": "eslint . --fix",
    "format": "prettier --write .",
    "test": "vitest"
  },
  "dependencies": {},
  "devDependencies": {}
}
EOF
        echo "   ✅ 创建文件: package.json"
    fi
}

# 创建requirements.txt文件
create_requirements_txt() {
    local project_path="$1"
    
    if [ ! -f "$project_path/requirements.txt" ]; then
        cat > "$project_path/requirements.txt" << 'EOF'
# 基础依赖
python-dotenv>=1.0.0
requests>=2.31.0

# 开发依赖
pytest>=7.4.0
black>=23.9.0
flake8>=6.1.0
isort>=5.12.0
EOF
        echo "   ✅ 创建文件: requirements.txt"
    fi
}

# 创建go.mod文件
create_go_mod() {
    local project_path="$1"
    local project_name="$2"
    
    if [ ! -f "$project_path/go.mod" ]; then
        cat > "$project_path/go.mod" << EOF
module $project_name

go 1.21

require ()
EOF
        echo "   ✅ 创建文件: go.mod"
    fi
}

# 创建Cargo.toml文件
create_cargo_toml() {
    local project_path="$1"
    local project_name="$2"
    
    if [ ! -f "$project_path/Cargo.toml" ]; then
        cat > "$project_path/Cargo.toml" << EOF
[package]
name = "$project_name"
version = "0.1.0"
edition = "2021"

[dependencies]
EOF
        echo "   ✅ 创建文件: Cargo.toml"
    fi
}

# 创建基于模板的Makefile
create_template_makefile() {
    local project_path="$1"
    local project_type="$2"
    
    if [ ! -f "$project_path/Makefile" ] && [ -n "$PARSED_MAKEFILE" ]; then
        echo "$PARSED_MAKEFILE" > "$project_path/Makefile"
        echo "   ✅ 创建文件: Makefile (基于模板)"
    fi
}

# 创建通用Makefile
create_generic_makefile() {
    local project_path="$1"
    local project_type="$2"
    
    if [ ! -f "$project_path/Makefile" ]; then
        cat > "$project_path/Makefile" << 'EOF'
.PHONY: help install dev build test lint clean

help:
	@echo "可用命令:"
	@echo "  install    - 安装依赖"
	@echo "  dev        - 启动开发环境"
	@echo "  build      - 构建项目"
	@echo "  test       - 运行测试"
	@echo "  lint       - 代码检查"
	@echo "  clean      - 清理临时文件"

install:
	@echo "🔧 安装依赖..."
	@echo "请根据项目类型配置安装命令"

dev:
	@echo "🚀 启动开发环境..."
	@echo "请根据项目类型配置开发命令"

build:
	@echo "📦 构建项目..."
	@echo "请根据项目类型配置构建命令"

test:
	@echo "🧪 运行测试..."
	@echo "请根据项目类型配置测试命令"

lint:
	@echo "🔍 代码检查..."
	@echo "请根据项目类型配置检查命令"

clean:
	@echo "🧹 清理临时文件..."
	@echo "请根据项目类型配置清理命令"
EOF
        echo "   ✅ 创建文件: Makefile (通用模板)"
    fi
}

# 创建项目基础文件
create_project_base_files() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    # 根据项目类型创建入口文件
    case "$project_type" in
        "nodejs-general")
            create_nodejs_entry "$project_path"
            ;;
        "python-"*)
            create_python_entry "$project_path"
            ;;
        "go-"*)
            create_go_entry "$project_path"
            ;;
        "rust-project")
            create_rust_entry "$project_path"
            ;;
    esac
}

# 创建Node.js入口文件
create_nodejs_entry() {
    local project_path="$1"
    
    if [ ! -f "$project_path/src/index.js" ]; then
        mkdir -p "$project_path/src"
        cat > "$project_path/src/index.js" << 'EOF'
console.log("Hello, Node.js!");
EOF
        echo "   ✅ 创建文件: src/index.js"
    fi
}

# 创建Python入口文件
create_python_entry() {
    local project_path="$1"
    
    if [ ! -f "$project_path/src/main.py" ]; then
        mkdir -p "$project_path/src"
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
}

# 创建Go入口文件
create_go_entry() {
    local project_path="$1"
    
    if [ ! -f "$project_path/cmd/main.go" ]; then
        mkdir -p "$project_path/cmd"
        cat > "$project_path/cmd/main.go" << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello, Go!")
}
EOF
        echo "   ✅ 创建文件: cmd/main.go"
    fi
}

# 创建Rust入口文件
create_rust_entry() {
    local project_path="$1"
    
    if [ ! -f "$project_path/src/main.rs" ]; then
        mkdir -p "$project_path/src"
        cat > "$project_path/src/main.rs" << 'EOF'
fn main() {
    println!("Hello, Rust!");
}
EOF
        echo "   ✅ 创建文件: src/main.rs"
    fi
}

# 公共接口函数（用于兼容性）
create_project_from_template() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    # 调用主要实现函数
    create_dynamic_project_structure "$project_path" "$project_type" "$project_name"
}

# 主要公共接口函数
create_dynamic_project_structure() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    # 信息已在上级函数输出，避免重复
    echo ""
    
    # 合并全局规则和项目特定结构
    merge_global_and_project_structure "$project_path" "$project_type" "$project_name"
    
    echo "✅ 动态项目结构创建完成"
}

# 测试函数
test_template_parser() {
    local test_project_type="$1"
    echo "🧪 测试模板解析器..."
    
    if parse_project_template "$test_project_type"; then
        echo "✅ 模板解析成功"
        echo "解析到的目录："
        for dir in "${PARSED_DIRECTORIES[@]}"; do
            echo "  - $dir"
        done
    else
        echo "❌ 模板解析失败"
    fi
}

# 主函数 - 如果直接执行此脚本
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    if [ -z "$1" ]; then
        echo "使用: $0 <project_path> <project_type> [project_name]"
        echo "或者: $0 test <project_type>  # 测试模板解析"
        exit 1
    fi
    
    if [ "$1" = "test" ]; then
        test_template_parser "$2"
    else
        PROJECT_PATH="$1"
        PROJECT_TYPE="$2"
        PROJECT_NAME="${3:-$(basename "$PROJECT_PATH")}"
        
        create_dynamic_project_structure "$PROJECT_PATH" "$PROJECT_TYPE" "$PROJECT_NAME"
    fi
fi