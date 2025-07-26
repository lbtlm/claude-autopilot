#!/bin/bash

# Claude Autopilot 2.1 主入口脚本
# 一键式智能开发环境配置工具
# 作者: Youmi Sam
# 版本: 2.1.0

set -e

# 动态检测项目根路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 显示标题
show_header() {
    echo -e "${CYAN}"
    echo "================================================================"
    echo "🛩️ Claude Autopilot 2.1 智能开发环境配置工具"
    echo "================================================================"
    echo -e "${NC}"
    echo "📖 一键式配置智能AI协作开发环境"
    echo "🎯 支持多种项目类型的自动化配置"
    echo "🌍 开源友好，支持任意路径部署"
    echo ""
}

# 显示使用帮助
show_help() {
    echo -e "${YELLOW}📖 使用说明：${NC}"
    echo ""
    echo "这个工具会自动为您的项目配置智能AI协作环境"
    echo ""
    echo -e "${GREEN}支持的项目类型：${NC}"
    echo "  • gin-microservice  - Go + Gin微服务"
    echo "  • gin-vue3         - Go + Gin + Vue3全栈"
    echo "  • vue3-frontend    - Vue3前端项目"
    echo "  • react-frontend   - React前端项目"
    echo "  • nextjs-frontend  - Next.js前端项目"
    echo "  • nodejs-general   - Node.js通用项目"
    echo "  • python-web       - Python Web应用"
    echo "  • bash-scripts     - Bash脚本项目"
    echo "  • 以及更多..."
    echo ""
    echo -e "${GREEN}使用方法：${NC}"
    echo "  1. 对于新项目（空目录）："
    echo "     $0 [项目路径] [项目类型]"
    echo "     例如: $0 /path/to/new/project gin-microservice"
    echo ""
    echo "  2. 对于现有项目（自动检测类型）："
    echo "     $0 [项目路径]"
    echo "     例如: $0 /path/to/existing/project"
    echo ""
    echo "  3. 在当前目录配置："
    echo "     $0"
    echo ""
}

# 显示主菜单
show_menu() {
    echo -e "${BLUE}🎯 请选择操作：${NC}"
    echo ""
    echo "  1) 为当前目录配置智能开发环境"
    echo "  2) 为指定项目配置智能开发环境"
    echo "  3) 创建新项目并配置环境"
    echo "  4) 项目健康度检查"
    echo "  5) 显示帮助信息"
    echo "  6) 退出"
    echo ""
}

# 检查当前目录配置
configure_current_directory() {
    echo -e "${GREEN}🏗️ 为当前目录配置智能开发环境...${NC}"
    echo ""
    
    if [ -f "$PROJECT_ROOT/scripts/ce-inject.sh" ]; then
        "$PROJECT_ROOT/scripts/ce-inject.sh" "$(pwd)"
    else
        echo -e "${RED}❌ 错误: 找不到ce-inject.sh脚本${NC}"
        echo "请确保项目完整安装"
        exit 1
    fi
}

# 配置指定项目
configure_specified_project() {
    echo -e "${YELLOW}📂 请输入项目路径：${NC}"
    read -r project_path
    
    if [ ! -d "$project_path" ]; then
        echo -e "${RED}❌ 错误: 目录不存在: $project_path${NC}"
        return 1
    fi
    
    echo -e "${GREEN}🏗️ 为项目配置智能开发环境: $project_path${NC}"
    echo ""
    
    if [ -f "$PROJECT_ROOT/scripts/ce-inject.sh" ]; then
        "$PROJECT_ROOT/scripts/ce-inject.sh" "$project_path"
    else
        echo -e "${RED}❌ 错误: 找不到ce-inject.sh脚本${NC}"
        echo "请确保项目完整安装"
        exit 1
    fi
}

# 创建新项目
create_new_project() {
    echo -e "${YELLOW}🆕 创建新项目${NC}"
    echo ""
    echo -e "${YELLOW}请输入新项目路径：${NC}"
    read -r project_path
    
    echo -e "${YELLOW}请选择项目类型：${NC}"
    echo "  1) gin-microservice  - Go + Gin微服务"
    echo "  2) gin-vue3         - Go + Gin + Vue3全栈"
    echo "  3) vue3-frontend    - Vue3前端项目"
    echo "  4) react-frontend   - React前端项目"
    echo "  5) nextjs-frontend  - Next.js前端项目"
    echo "  6) nodejs-general   - Node.js通用项目"
    echo "  7) python-web       - Python Web应用"
    echo "  8) bash-scripts     - Bash脚本项目"
    echo ""
    echo -e "${YELLOW}请输入选项编号 (1-8)：${NC}"
    read -r choice
    
    case "$choice" in
        1) project_type="gin-microservice" ;;
        2) project_type="gin-vue3" ;;
        3) project_type="vue3-frontend" ;;
        4) project_type="react-frontend" ;;
        5) project_type="nextjs-frontend" ;;
        6) project_type="nodejs-general" ;;
        7) project_type="python-web" ;;
        8) project_type="bash-scripts" ;;
        *)
            echo -e "${RED}❌ 无效选择${NC}"
            return 1
            ;;
    esac
    
    # 创建目录
    mkdir -p "$project_path"
    
    echo -e "${GREEN}🏗️ 创建新项目: $project_path ($project_type)${NC}"
    echo ""
    
    if [ -f "$PROJECT_ROOT/scripts/ce-inject.sh" ]; then
        "$PROJECT_ROOT/scripts/ce-inject.sh" "$project_path" "$project_type"
    else
        echo -e "${RED}❌ 错误: 找不到ce-inject.sh脚本${NC}"
        echo "请确保项目完整安装"
        exit 1
    fi
}

# 项目健康度检查
check_project_health() {
    echo -e "${YELLOW}📂 请输入要检查的项目路径（回车使用当前目录）：${NC}"
    read -r project_path
    
    if [ -z "$project_path" ]; then
        project_path="$(pwd)"
    fi
    
    if [ ! -d "$project_path" ]; then
        echo -e "${RED}❌ 错误: 目录不存在: $project_path${NC}"
        return 1
    fi
    
    echo -e "${GREEN}🏥 检查项目健康度: $project_path${NC}"
    echo ""
    
    if [ -f "$PROJECT_ROOT/scripts/quality-check/health-check.sh" ]; then
        "$PROJECT_ROOT/scripts/quality-check/health-check.sh" "$project_path"
    else
        echo -e "${RED}❌ 错误: 找不到health-check脚本${NC}"
        echo "请确保项目完整安装"
        exit 1
    fi
}

# 主程序
main() {
    # 检查参数
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        show_header
        show_help
        exit 0
    fi
    
    # 如果有参数，直接执行配置
    if [ $# -gt 0 ]; then
        echo -e "${GREEN}🏗️ 直接配置模式${NC}"
        echo ""
        
        if [ -f "$PROJECT_ROOT/scripts/ce-inject.sh" ]; then
            "$PROJECT_ROOT/scripts/ce-inject.sh" "$@"
        else
            echo -e "${RED}❌ 错误: 找不到ce-inject.sh脚本${NC}"
            echo "请确保项目完整安装"
            exit 1
        fi
        exit 0
    fi
    
    # 交互式菜单
    show_header
    
    while true; do
        show_menu
        echo -e "${YELLOW}请输入选项编号：${NC}"
        read -r choice
        echo ""
        
        case "$choice" in
            1)
                configure_current_directory
                break
                ;;
            2)
                configure_specified_project
                break
                ;;
            3)
                create_new_project
                break
                ;;
            4)
                check_project_health
                echo ""
                echo -e "${CYAN}按任意键继续...${NC}"
                read -r
                ;;
            5)
                show_help
                echo ""
                echo -e "${CYAN}按任意键继续...${NC}"
                read -r
                ;;
            6)
                echo -e "${GREEN}👋 感谢使用 Claude Autopilot 2.1！${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ 无效选择，请重试${NC}"
                echo ""
                ;;
        esac
    done
    
    echo ""
    echo -e "${GREEN}✨ 配置完成！现在可以开始智能开发了！${NC}"
    echo ""
    echo -e "${CYAN}💡 使用提示：${NC}"
    echo "  1. 进入项目目录"
    echo "  2. 运行: claude code"
    echo "  3. 直接描述您的开发需求即可开始智能开发！"
    echo ""
}

# 给脚本添加执行权限
chmod +x "$0"

# 运行主程序
main "$@"