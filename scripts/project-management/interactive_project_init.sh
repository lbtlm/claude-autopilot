#!/bin/bash

# 交互式项目初始化器 - 类似 Vue CLI 体验
# 支持复制到任意目录运行，提供完全的用户自主权

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# 全局变量
CURRENT_DIR="$(pwd)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 自动检测 global_rules 路径
detect_global_rules_path() {
    local paths=(
        "$SCRIPT_DIR/.."
        "$CURRENT_DIR"
        "$HOME/GolandProjects/global_rules"
        "/Users/samsmith/GolandProjects/global_rules"
    )
    
    for path in "${paths[@]}"; do
        if [ -f "$path/PROJECT_MANAGEMENT_RULES.md" ]; then
            GLOBAL_RULES_PATH="$path"
            return 0
        fi
    done
    
    echo -e "${RED}❌ 无法找到 global_rules 目录${NC}"
    echo -e "${YELLOW}💡 请确保 global_rules 目录存在以下路径之一:${NC}"
    for path in "${paths[@]}"; do
        echo -e "   • $path"
    done
    exit 1
}

# 显示欢迎信息
show_welcome() {
    clear
    echo -e "${BLUE}┌─────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${BLUE}│                                                             │${NC}"
    echo -e "${BLUE}│  🚀 ${CYAN}项目初始化向导${BLUE} - 交互式配置体验               │${NC}"
    echo -e "${BLUE}│                                                             │${NC}"
    echo -e "${BLUE}│  ${GREEN}✨ 智能项目结构生成                                   ${BLUE}│${NC}"
    echo -e "${BLUE}│  ${GREEN}✨ 全局规则自动注入                                   ${BLUE}│${NC}"
    echo -e "${BLUE}│  ${GREEN}✨ 强制部署策略遵循                                   ${BLUE}│${NC}"
    echo -e "${BLUE}│  ${GREEN}✨ Claude Code 协作优化                              ${BLUE}│${NC}"
    echo -e "${BLUE}│                                                             │${NC}"
    echo -e "${BLUE}└─────────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "${CYAN}📍 当前位置: ${YELLOW}$CURRENT_DIR${NC}"
    echo -e "${CYAN}🔧 规则库: ${YELLOW}$GLOBAL_RULES_PATH${NC}"
    echo ""
}

# 项目名称配置
configure_project_name() {
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}📝 项目名称配置${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # 如果当前目录看起来像项目名称，提供建议
    local current_basename="$(basename "$CURRENT_DIR")"
    local suggested_name=""
    if [[ "$current_basename" =~ ^[a-zA-Z0-9_-]+$ ]] && [ "$current_basename" != "scripts" ] && [ "$current_basename" != "global_rules" ]; then
        suggested_name="$current_basename"
        echo -e "${CYAN}💡 检测到可能的项目名称: ${YELLOW}$suggested_name${NC}"
        echo ""
    fi
    
    echo -e "${YELLOW}项目名称要求:${NC}"
    echo -e "  • 只能包含字母、数字、下划线和横线"
    echo -e "  • 建议使用小写字母和横线分隔"
    echo -e "  • 例如: my-awesome-app, user-management-system"
    echo ""
    
    while true; do
        if [ -n "$suggested_name" ]; then
            read -p "🔸 项目名称 [$suggested_name]: " PROJECT_NAME
            PROJECT_NAME="${PROJECT_NAME:-$suggested_name}"
        else
            read -p "🔸 项目名称: " PROJECT_NAME
        fi
        
        if [ -n "$PROJECT_NAME" ] && [[ "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
            echo -e "${GREEN}✅ 项目名称: $PROJECT_NAME${NC}"
            break
        else
            echo -e "${RED}❌ 无效的项目名称，请重新输入${NC}"
        fi
    done
    echo ""
}

# 项目类型配置
configure_project_type() {
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}🛠️ 项目类型选择${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo -e "${YELLOW}请选择项目类型:${NC}"
    echo ""
    echo -e "${CYAN}🌐 Web 应用 (强制容器化部署)${NC}"
    echo -e "  ${GREEN}1)${NC} gin-vue3          - Go + Gin + Vue3 全栈项目"
    echo -e "  ${GREEN}2)${NC} gin-microservice   - Go + Gin 微服务项目"  
    echo -e "  ${GREEN}3)${NC} fastapi-vue3       - FastAPI + Vue3 全栈项目"
    echo ""
    echo -e "${CYAN}📦 前端应用 (静态部署/可选容器化)${NC}"
    echo -e "  ${GREEN}4)${NC} vue3-frontend      - Vue3 + TypeScript 前端项目"
    echo ""
    echo -e "${CYAN}💻 桌面应用 (本地编译部署)${NC}"
    echo -e "  ${GREEN}5)${NC} go-desktop         - Go + Fyne 桌面应用"
    echo -e "  ${GREEN}6)${NC} python-desktop     - Python + tkinter 桌面应用"
    echo ""
    
    while true; do
        read -p "🔸 请选择 (1-6): " choice
        case $choice in
            1) 
                PROJECT_TYPE="gin-vue3"
                DEPLOYMENT_TYPE="🐳 强制容器化"
                DESCRIPTION="Go + Gin + Vue3 全栈项目"
                break ;;
            2) 
                PROJECT_TYPE="gin-microservice"
                DEPLOYMENT_TYPE="🐳 强制容器化"
                DESCRIPTION="Go + Gin 微服务项目"
                break ;;
            3) 
                PROJECT_TYPE="fastapi-vue3"
                DEPLOYMENT_TYPE="🐳 强制容器化"
                DESCRIPTION="FastAPI + Vue3 全栈项目"
                break ;;
            4) 
                PROJECT_TYPE="vue3-frontend"
                DEPLOYMENT_TYPE="📦 静态部署"
                DESCRIPTION="Vue3 + TypeScript 前端项目"
                break ;;
            5) 
                PROJECT_TYPE="go-desktop"
                DEPLOYMENT_TYPE="💻 本地编译"
                DESCRIPTION="Go + Fyne 桌面应用"
                break ;;
            6) 
                PROJECT_TYPE="python-desktop"
                DEPLOYMENT_TYPE="💻 本地编译"
                DESCRIPTION="Python + tkinter 桌面应用"
                break ;;
            *) 
                echo -e "${RED}❌ 无效选择，请输入 1-6${NC}" ;;
        esac
    done
    
    echo -e "${GREEN}✅ 项目类型: $DESCRIPTION${NC}"
    echo -e "${GREEN}✅ 部署方式: $DEPLOYMENT_TYPE${NC}"
    echo ""
}

# 初始化位置配置
configure_project_location() {
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}📁 项目位置配置${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # 检查当前目录状态
    local dir_contents=$(ls -A "$CURRENT_DIR" 2>/dev/null)
    local file_count=$(echo "$dir_contents" | wc -l)
    local can_init_here=false
    
    if [ -z "$dir_contents" ]; then
        can_init_here=true
        echo -e "${GREEN}✅ 当前目录为空，适合就地初始化${NC}"
    elif [ "$file_count" -eq 1 ] && echo "$dir_contents" | grep -q "interactive_project_init.sh"; then
        can_init_here=true
        echo -e "${GREEN}✅ 当前目录只有脚本文件，适合就地初始化${NC}"
    else
        echo -e "${YELLOW}⚠️  当前目录不为空，包含以下文件:${NC}"
        echo "$dir_contents" | head -5 | sed 's/^/   • /'
        if [ "$file_count" -gt 5 ]; then
            echo -e "   • ... 还有 $((file_count - 5)) 个文件"
        fi
    fi
    
    echo ""
    echo -e "${YELLOW}请选择初始化位置:${NC}"
    
    if [ "$can_init_here" = true ]; then
        echo -e "  ${GREEN}1)${NC} 在当前目录初始化 (${CYAN}$CURRENT_DIR${NC})"
        echo -e "  ${GREEN}2)${NC} 创建新目录 (${CYAN}$CURRENT_DIR/$PROJECT_NAME${NC})"
        echo -e "  ${GREEN}3)${NC} 选择其他位置"
        echo ""
        read -p "🔸 请选择 (1/2/3) [默认: 1]: " location_choice
        location_choice="${location_choice:-1}"
    else
        echo -e "  ${GREEN}1)${NC} 创建新目录 (${CYAN}$CURRENT_DIR/$PROJECT_NAME${NC})"
        echo -e "  ${GREEN}2)${NC} 选择其他位置"
        echo -e "  ${GREEN}3)${NC} 在当前目录强制初始化 (⚠️ 可能覆盖现有文件)"
        echo ""
        read -p "🔸 请选择 (1/2/3) [默认: 1]: " location_choice
        location_choice="${location_choice:-1}"
        # 调整选择映射
        case $location_choice in
            1) location_choice=2 ;;  # 创建新目录
            2) location_choice=3 ;;  # 其他位置
            3) location_choice=1 ;;  # 当前目录
        esac
    fi
    
    case $location_choice in
        1)
            PROJECT_PATH="$CURRENT_DIR"
            echo -e "${GREEN}✅ 将在当前目录初始化项目${NC}"
            if [ "$can_init_here" = false ]; then
                echo -e "${YELLOW}⚠️  确认在当前目录初始化? (y/N)${NC}"
                read -p "🔸 确认: " confirm
                if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
                    echo -e "${RED}❌ 用户取消操作${NC}"
                    exit 1
                fi
            fi
            ;;
        2)
            PROJECT_PATH="$CURRENT_DIR/$PROJECT_NAME"
            echo -e "${GREEN}✅ 将创建新目录: $PROJECT_PATH${NC}"
            ;;
        3)
            echo ""
            echo -e "${CYAN}请输入完整路径:${NC}"
            echo -e "${YELLOW}提示:${NC}"
            echo -e "  • 使用 ~ 表示用户主目录"
            echo -e "  • 使用 . 表示当前目录"
            echo -e "  • 使用绝对路径如 /Users/username/projects"
            echo ""
            read -p "🔸 自定义路径: " custom_path
            
            if [ -n "$custom_path" ]; then
                case "$custom_path" in
                    ~*) PROJECT_PATH="${custom_path/#\~/$HOME}" ;;
                    /*) PROJECT_PATH="$custom_path" ;;
                    .) PROJECT_PATH="$CURRENT_DIR" ;;
                    *) PROJECT_PATH="$CURRENT_DIR/$custom_path" ;;
                esac
                
                # 如果路径不包含项目名，自动添加
                if [[ "$(basename "$PROJECT_PATH")" != "$PROJECT_NAME" ]]; then
                    PROJECT_PATH="$PROJECT_PATH/$PROJECT_NAME"
                fi
                
                echo -e "${GREEN}✅ 自定义路径: $PROJECT_PATH${NC}"
            else
                PROJECT_PATH="$CURRENT_DIR/$PROJECT_NAME"
                echo -e "${GREEN}✅ 使用默认路径: $PROJECT_PATH${NC}"
            fi
            ;;
    esac
    echo ""
}

# 高级选项配置
configure_advanced_options() {
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}⚙️ 高级选项配置${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Git 仓库初始化
    echo -e "${YELLOW}🔸 Git 仓库配置:${NC}"
    read -p "   是否初始化 Git 仓库? (Y/n) [默认: Y]: " init_git
    INIT_GIT="${init_git:-Y}"
    if [[ "$INIT_GIT" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}   ✅ 将初始化 Git 仓库${NC}"
    else
        echo -e "${YELLOW}   ⏭️ 跳过 Git 仓库初始化${NC}"
    fi
    echo ""
    
    # 依赖安装
    if [[ "$PROJECT_TYPE" =~ frontend|vue3|fastapi ]]; then
        echo -e "${YELLOW}🔸 依赖管理:${NC}"
        read -p "   是否自动安装依赖? (Y/n) [默认: Y]: " install_deps
        INSTALL_DEPS="${install_deps:-Y}"
        if [[ "$INSTALL_DEPS" =~ ^[Yy]$ ]]; then
            echo -e "${GREEN}   ✅ 将自动安装项目依赖${NC}"
        else
            echo -e "${YELLOW}   ⏭️ 跳过依赖安装${NC}"
        fi
        echo ""
    fi
    
    # Docker 配置 (仅容器化项目)
    if [[ "$DEPLOYMENT_TYPE" =~ "容器化" ]]; then
        echo -e "${YELLOW}🔸 Docker 配置:${NC}"
        read -p "   Docker Registry 用户名 [默认: $USER]: " docker_registry
        DOCKER_REGISTRY="${docker_registry:-$USER}"
        echo -e "${GREEN}   ✅ Docker Registry: $DOCKER_REGISTRY${NC}"
        echo ""
    fi
    
    # Memory MCP 集成
    echo -e "${YELLOW}🔸 AI 协作配置:${NC}"
    read -p "   是否启用 Memory MCP 历史经验查询? (Y/n) [默认: Y]: " enable_memory
    ENABLE_MEMORY="${enable_memory:-Y}"
    if [[ "$ENABLE_MEMORY" =~ ^[Yy]$ ]]; then
        echo -e "${GREEN}   ✅ 将启用 Memory MCP 经验复用${NC}"
    else
        echo -e "${YELLOW}   ⏭️ 跳过 Memory MCP 集成${NC}"
    fi
    echo ""
}

# 显示配置摘要
show_configuration_summary() {
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}📋 配置摘要${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo -e "${CYAN}📝 项目信息:${NC}"
    echo -e "   名称: ${YELLOW}$PROJECT_NAME${NC}"
    echo -e "   类型: ${YELLOW}$DESCRIPTION${NC}"
    echo -e "   路径: ${YELLOW}$PROJECT_PATH${NC}"
    echo -e "   部署: ${YELLOW}$DEPLOYMENT_TYPE${NC}"
    echo ""
    
    echo -e "${CYAN}⚙️ 选项配置:${NC}"
    echo -e "   Git 仓库: ${YELLOW}$([ "$INIT_GIT" = "Y" ] && echo "✅ 是" || echo "❌ 否")${NC}"
    
    if [[ "$PROJECT_TYPE" =~ frontend|vue3|fastapi ]]; then
        echo -e "   依赖安装: ${YELLOW}$([ "$INSTALL_DEPS" = "Y" ] && echo "✅ 是" || echo "❌ 否")${NC}"
    fi
    
    if [[ "$DEPLOYMENT_TYPE" =~ "容器化" ]]; then
        echo -e "   Docker Registry: ${YELLOW}$DOCKER_REGISTRY${NC}"
    fi
    
    echo -e "   Memory MCP: ${YELLOW}$([ "$ENABLE_MEMORY" = "Y" ] && echo "✅ 是" || echo "❌ 否")${NC}"
    echo ""
    
    echo -e "${YELLOW}⚡ 即将创建的内容:${NC}"
    case $PROJECT_TYPE in
        gin-vue3)
            echo -e "   • 后端 Go + Gin 服务"
            echo -e "   • 前端 Vue3 + TypeScript"
            echo -e "   • 多架构 Docker 配置"
            echo -e "   • 智能 Redis 部署脚本"
            echo -e "   • 生产安全部署脚本"
            ;;
        gin-microservice)
            echo -e "   • Go + Gin 微服务架构"
            echo -e "   • 统一 API 响应模型"
            echo -e "   • Swagger 文档集成"
            echo -e "   • Docker 容器化配置"
            ;;
        vue3-frontend)
            echo -e "   • Vue3 + TypeScript"
            echo -e "   • Element Plus UI"
            echo -e "   • Vite 构建工具"
            echo -e "   • ESLint + Prettier"
            ;;
        go-desktop)
            echo -e "   • Go + Fyne GUI 框架"
            echo -e "   • 跨平台编译配置"
            echo -e "   • SQLite 数据库集成"
            ;;
        python-desktop)
            echo -e "   • Python + tkinter GUI"
            echo -e "   • PyInstaller 打包配置"
            echo -e "   • 跨平台兼容性"
            ;;
        fastapi-vue3)
            echo -e "   • FastAPI 后端"
            echo -e "   • Vue3 前端"
            echo -e "   • Docker Compose 配置"
            ;;
    esac
    
    echo -e "   • 全局开发规范注入"
    echo -e "   • Claude Code 协作优化"
    echo -e "   • 项目流程管理结构"
    echo ""
    
    echo -e "${RED}⚠️ 重要提醒:${NC}"
    if [ -d "$PROJECT_PATH" ]; then
        echo -e "   目标目录已存在，可能会覆盖现有文件"
    fi
    
    case $PROJECT_TYPE in
        gin-vue3|gin-microservice|fastapi-vue3)
            echo -e "   此项目类型${RED}强制使用容器化部署${NC}"
            ;;
        go-desktop|python-desktop)
            echo -e "   此项目类型${RED}禁止使用容器化部署${NC}"
            ;;
    esac
    echo ""
}

# 确认开始创建
confirm_creation() {
    echo -e "${YELLOW}🚀 准备开始创建项目...${NC}"
    echo ""
    read -p "🔸 确认开始创建? (Y/n) [默认: Y]: " confirm
    confirm="${confirm:-Y}"
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${RED}❌ 用户取消操作${NC}"
        exit 1
    fi
    
    echo ""
    echo -e "${GREEN}🎉 开始创建项目 $PROJECT_NAME...${NC}"
    echo ""
}

# 调用原始创建函数
create_project() {
    # 设置环境变量供原始脚本使用
    export PROJECT_NAME
    export PROJECT_TYPE
    export PROJECT_PATH
    export DOCKER_REGISTRY
    export GLOBAL_RULES_PATH
    
    # 调用原始的创建逻辑
    if [ -f "$GLOBAL_RULES_PATH/scripts/new_project.sh" ]; then
        # 使用原始脚本的创建逻辑，跳过参数验证
        source "$GLOBAL_RULES_PATH/scripts/new_project.sh"
        
        # 直接调用创建函数
        search_similar_projects
        create_project_structure
        inject_global_rules "$PROJECT_PATH" "$PROJECT_TYPE"
        generate_optimized_claude_md
        initialize_project_files
        
        if [[ "$INIT_GIT" =~ ^[Yy]$ ]]; then
            initialize_git
        fi
        
        if [[ "$ENABLE_MEMORY" =~ ^[Yy]$ ]]; then
            save_creation_experience
        fi
        
        # 安装依赖
        if [[ "$INSTALL_DEPS" =~ ^[Yy]$ ]]; then
            install_dependencies
        fi
        
    else
        echo -e "${RED}❌ 找不到项目创建脚本: $GLOBAL_RULES_PATH/scripts/new_project.sh${NC}"
        exit 1
    fi
}

# 安装依赖
install_dependencies() {
    echo -e "${BLUE}📦 安装项目依赖...${NC}"
    
    cd "$PROJECT_PATH"
    
    case $PROJECT_TYPE in
        gin-vue3|gin-microservice)
            if [ -d "backend" ]; then
                echo -e "${CYAN}🔧 安装 Go 依赖...${NC}"
                cd backend && go mod tidy && go mod download
                cd ..
            fi
            if [ -d "frontend" ]; then
                echo -e "${CYAN}🔧 安装前端依赖...${NC}"
                cd frontend && npm install
                cd ..
            fi
            ;;
        vue3-frontend)
            echo -e "${CYAN}🔧 安装前端依赖...${NC}"
            npm install
            ;;
        fastapi-vue3)
            if [ -d "backend" ]; then
                echo -e "${CYAN}🔧 安装 Python 依赖...${NC}"
                cd backend && pip install -r requirements.txt
                cd ..
            fi
            if [ -d "frontend" ]; then
                echo -e "${CYAN}🔧 安装前端依赖...${NC}"
                cd frontend && npm install
                cd ..
            fi
            ;;
        python-desktop)
            echo -e "${CYAN}🔧 安装 Python 依赖...${NC}"
            pip install -r requirements.txt
            ;;
        go-desktop)
            echo -e "${CYAN}🔧 安装 Go 依赖...${NC}"
            go mod tidy && go mod download
            ;;
    esac
}

# 显示完成信息
show_completion() {
    echo ""
    echo -e "${GREEN}🎉 项目创建完成！${NC}"
    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}🎯 下一步操作建议${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo -e "${CYAN}1. 进入项目目录:${NC}"
    echo -e "   cd $PROJECT_PATH"
    echo ""
    
    echo -e "${CYAN}2. 启动开发环境:${NC}"
    case $PROJECT_TYPE in
        gin-vue3)
            echo -e "   make dev              # 启动开发环境"
            echo -e "   # 或分别启动："
            echo -e "   cd backend && go run cmd/server/main.go    # 后端"
            echo -e "   cd frontend && npm run dev                 # 前端"
            ;;
        gin-microservice)
            echo -e "   make dev              # 启动开发服务器"
            echo -e "   # 或直接运行："
            echo -e "   go run cmd/server/main.go"
            ;;
        vue3-frontend)
            echo -e "   npm run dev           # 启动开发服务器"
            ;;
        go-desktop)
            echo -e "   go run cmd/app/main.go  # 启动桌面应用"
            ;;
        python-desktop)
            echo -e "   python src/main.py      # 启动桌面应用"
            ;;
        fastapi-vue3)
            echo -e "   docker-compose up -d    # 启动完整环境"
            ;;
    esac
    echo ""
    
    echo -e "${CYAN}3. 启动 Claude Code 协作:${NC}"
    echo -e "   claude code           # 启动 AI 协作开发"
    echo ""
    
    echo -e "${CYAN}4. 访问地址:${NC}"
    case $PROJECT_TYPE in
        gin-vue3)
            echo -e "   前端: http://localhost:3000"
            echo -e "   后端: http://localhost:8080"
            echo -e "   API文档: http://localhost:8080/swagger/index.html"
            ;;
        gin-microservice)
            echo -e "   服务: http://localhost:8080"
            echo -e "   健康检查: http://localhost:8080/health"
            echo -e "   API文档: http://localhost:8080/swagger/index.html"
            ;;
        vue3-frontend)
            echo -e "   应用: http://localhost:3000"
            ;;
        fastapi-vue3)
            echo -e "   前端: http://localhost:3000"
            echo -e "   后端: http://localhost:8000"
            echo -e "   API文档: http://localhost:8000/docs"
            ;;
    esac
    echo ""
    
    # 部署相关提醒
    if [[ "$DEPLOYMENT_TYPE" =~ "容器化" ]]; then
        echo -e "${YELLOW}🐳 容器化部署提醒:${NC}"
        echo -e "   • 此项目${RED}强制使用容器化部署${NC}"
        echo -e "   • 使用 ${CYAN}make build-multi${NC} 构建多架构镜像"
        echo -e "   • 使用 ${CYAN}make deploy-prod${NC} 部署到生产环境"
        echo ""
    elif [[ "$DEPLOYMENT_TYPE" =~ "本地编译" ]]; then
        echo -e "${YELLOW}💻 本地部署提醒:${NC}"
        echo -e "   • 此项目${RED}禁止使用容器化部署${NC}"
        echo -e "   • 使用原生编译生成可执行文件"
        echo -e "   • 支持跨平台编译和分发"
        echo ""
    fi
    
    echo -e "${GREEN}祝您开发愉快！🚀${NC}"
}

# 主函数
main() {
    # 检查依赖
    detect_global_rules_path
    
    # 交互式配置流程
    show_welcome
    configure_project_name
    configure_project_type
    configure_project_location
    configure_advanced_options
    show_configuration_summary
    confirm_creation
    
    # 创建项目
    create_project
    show_completion
}

# 运行主函数
main "$@"