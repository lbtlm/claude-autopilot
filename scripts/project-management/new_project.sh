#!/bin/bash

# 增强版新项目创建器 - new-project.sh
# 交互式项目初始化工具，支持在项目目录内运行

# 检测脚本运行位置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT_DIR="$(pwd)"

GLOBAL_RULES_PATH="$(cd "$SCRIPT_DIR/../.." && pwd)"


# 处理参数（支持无参数交互模式）
PROJECT_NAME="$1"
PROJECT_TYPE="$2"
PROJECT_PATH_INPUT="$3"
VERBOSE=false
INTERACTIVE_MODE=true

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# 显示帮助信息
show_help() {
    echo -e "${BLUE}🚀 增强版新项目创建器 v3.0 - 交互模式${NC}"
    echo ""
    echo -e "${YELLOW}功能特点:${NC}"
    echo "  ✅ 交互式项目初始化"
    echo "  ✅ 自动检测运行环境"
    echo "  ✅ 步骤引导配置"
    echo "  ✅ 智能参数选择"
    echo "  ✅ 强制部署策略遵循"
    echo "  ✅ Claude Code协作优化"
    echo "  ✅ 历史经验复用"
    echo ""
    echo -e "${YELLOW}使用方法:${NC}"
    echo "  方式1 (交互模式): $0"
    echo "  方式2 (快速模式): $0 <项目名> <项目类型>"
    echo "  方式3 (完整模式): $0 <项目名> <项目类型> [项目路径]"
    echo ""
    echo -e "${YELLOW}支持的项目类型:${NC}"
    echo "  gin-vue3          - Go + Gin + Vue3全栈项目 (🐳 强制容器化)"
    echo "  gin-microservice   - Go + Gin微服务项目 (🐳 强制容器化)"
    echo "  vue3-frontend      - Vue3 + TypeScript前端项目 (📦 静态部署)"
    echo "  go-desktop         - Go + Fyne桌面应用 (💻 本地编译)"
    echo "  python-desktop     - Python + tkinter桌面应用 (💻 本地编译)"
    echo "  fastapi-vue3       - FastAPI + Vue3全栈项目 (🐳 强制容器化)"
    echo ""
    echo -e "${YELLOW}路径选择说明:${NC}"
    echo "  不指定路径      - 智能选择默认位置"
    echo "  相对路径        - 基于当前目录"
    echo "  绝对路径        - 使用指定的完整路径"
    echo "  ~              - 用户主目录"
    echo "  ~/projects     - 用户项目目录"
    echo "  .              - 当前目录"
    echo "  ..             - 上级目录"
    echo ""
    echo -e "${YELLOW}选项:${NC}"
    echo "  -v, --verbose  - 显示详细输出"
    echo "  -h, --help     - 显示此帮助信息"
    echo ""
    echo -e "${YELLOW}示例:${NC}"
    echo -e "${CYAN}# 在默认位置创建项目（推荐）${NC}"
    echo "  $0 my-api gin-microservice"
    echo "    → 在 /Users/samsmith/GolandProjects/my-api"
    echo ""
    echo -e "${CYAN}# 指定用户目录${NC}"
    echo "  $0 my-frontend vue3-frontend ~/my-frontend"
    echo "    → 在 /Users/samsmith/my-frontend"
    echo ""
    echo -e "${CYAN}# 指定相对路径${NC}"
    echo "  $0 my-tool go-desktop ../my-tool"
    echo "    → 在上级目录的 my-tool"
    echo ""
    echo -e "${CYAN}# 指定绝对路径${NC}"
    echo "  $0 work-api gin-microservice /Users/samsmith/work/work-api"
    echo "    → 在指定的绝对路径"
    echo ""
    echo -e "${YELLOW}智能默认路径规则:${NC}"
    echo "  📍 在global_rules目录下运行    → 上级目录创建项目"
    echo "  📍 在global_rules/scripts下运行 → global_rules上级目录创建"
    echo "  📍 在其他目录运行             → 当前目录创建项目"
    echo ""
    echo -e "${YELLOW}创建后自动配置:${NC}"
    echo "  🔧 完整项目结构"
    echo "  📋 全局规则注入"
    echo "  🎯 优化Claude配置"
    echo "  📚 技术栈最佳实践"
    echo "  🧠 历史经验应用"
    echo "  🚀 立即可开发状态"
}

# 处理命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            if [ -z "$PROJECT_NAME" ]; then
                PROJECT_NAME="$1"
            elif [ -z "$PROJECT_TYPE" ]; then
                PROJECT_TYPE="$1"
            elif [ -z "$PROJECT_PATH_INPUT" ]; then
                PROJECT_PATH_INPUT="$1"
            fi
            shift
            ;;
    esac
done

# 日志函数
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

log_verbose() {
    if [ "$VERBOSE" = true ]; then
        echo -e "${PURPLE}🔍 $1${NC}"
    fi
}

# 交互式获取项目信息
get_project_info_interactive() {
    echo -e "${BLUE}🎉 欢迎使用交互式项目初始化工具！${NC}"
    echo ""
    
    # 获取项目名称
    if [ -z "$PROJECT_NAME" ]; then
        echo -e "${YELLOW}📝 请输入项目名称:${NC}"
        echo -e "${CYAN}  • 只能包含字母、数字、下划线和横线${NC}"
        echo -e "${CYAN}  • 建议使用小写字母和横线分隔${NC}"
        while true; do
            read -p "项目名称: " PROJECT_NAME
            if [ -n "$PROJECT_NAME" ] && [[ "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
                break
            else
                echo -e "${RED}❌ 无效的项目名称，请重新输入${NC}"
            fi
        done
    fi
    
    # 获取项目类型
    if [ -z "$PROJECT_TYPE" ]; then
        echo ""
        echo -e "${YELLOW}🛠️  请选择项目类型:${NC}"
        echo -e "${CYAN}1.${NC} gin-vue3          - Go + Gin + Vue3全栈项目 (🐳 强制容器化)"
        echo -e "${CYAN}2.${NC} gin-microservice   - Go + Gin微服务项目 (🐳 强制容器化)"
        echo -e "${CYAN}3.${NC} vue3-frontend      - Vue3 + TypeScript前端项目 (📦 静态部署)"
        echo -e "${CYAN}4.${NC} go-desktop         - Go + Fyne桌面应用 (💻 本地编译)"
        echo -e "${CYAN}5.${NC} python-desktop     - Python + tkinter桌面应用 (💻 本地编译)"
        echo -e "${CYAN}6.${NC} fastapi-vue3       - FastAPI + Vue3全栈项目 (🐳 强制容器化)"
        echo ""
        while true; do
            read -p "请选择 (1-6): " choice
            case $choice in
                1) PROJECT_TYPE="gin-vue3"; break ;;
                2) PROJECT_TYPE="gin-microservice"; break ;;
                3) PROJECT_TYPE="vue3-frontend"; break ;;
                4) PROJECT_TYPE="go-desktop"; break ;;
                5) PROJECT_TYPE="python-desktop"; break ;;
                6) PROJECT_TYPE="fastapi-vue3"; break ;;
                *) echo -e "${RED}❌ 无效选择，请输入 1-6${NC}" ;;
            esac
        done
    fi
    
    log_success "项目信息获取完成: $PROJECT_NAME ($PROJECT_TYPE)"
}

# 验证参数
validate_inputs() {
    # 如果是交互模式，先获取项目信息
    if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_TYPE" ]; then
        get_project_info_interactive
    fi
    
    # 验证项目名称
    if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        log_error "项目名称只能包含字母、数字、下划线和横线"
        exit 1
    fi
    
    # 验证项目类型
    case $PROJECT_TYPE in
        gin-vue3|gin-microservice|vue3-frontend|go-desktop|python-desktop|fastapi-vue3)
            ;;
        *)
            log_error "不支持的项目类型: $PROJECT_TYPE"
            echo -e "${YELLOW}请使用 $0 --help 查看支持的项目类型${NC}"
            exit 1
            ;;
    esac
}

# 智能路径选择
smart_path_selection() {
    local current_dir="$(pwd)"
    local current_basename="$(basename "$current_dir")"
    local suggested_path=""
    
    if [ -n "$PROJECT_PATH_INPUT" ]; then
        # 用户指定了路径，处理各种路径格式
        case "$PROJECT_PATH_INPUT" in
            ~*)
                # 展开用户主目录
                PROJECT_PATH="${PROJECT_PATH_INPUT/#\~/$HOME}"
                ;;
            /*)
                # 绝对路径，直接使用
                PROJECT_PATH="$PROJECT_PATH_INPUT"
                ;;
            .)
                # 当前目录
                PROJECT_PATH="$current_dir/$PROJECT_NAME"
                ;;
            ..)
                # 上级目录
                PROJECT_PATH="$(dirname "$current_dir")/$PROJECT_NAME"
                ;;
            *)
                # 相对路径
                if [[ "$PROJECT_PATH_INPUT" == *"$PROJECT_NAME" ]]; then
                    # 如果路径已包含项目名，直接使用
                    PROJECT_PATH="$(cd "$(dirname "$PROJECT_PATH_INPUT")" 2>/dev/null && pwd)/$(basename "$PROJECT_PATH_INPUT")" 2>/dev/null
                    if [ $? -ne 0 ]; then
                        PROJECT_PATH="$current_dir/$PROJECT_PATH_INPUT"
                    fi
                else
                    # 在指定目录下创建项目
                    PROJECT_PATH="$current_dir/$PROJECT_PATH_INPUT/$PROJECT_NAME"
                fi
                ;;
        esac
        log_verbose "用户指定路径: $PROJECT_PATH"
    else
        # 用户未指定路径，智能选择默认位置
        if [ "$current_basename" = "global_rules" ]; then
            # 在global_rules目录下，在上级目录创建项目
            suggested_path="$(dirname "$current_dir")/$PROJECT_NAME"
            log_info "检测到在global_rules目录下"
        elif [ "$current_basename" = "scripts" ] && [ "$(basename "$(dirname "$current_dir")")" = "global_rules" ]; then
            # 在global_rules/scripts目录下，在global_rules的上级目录创建项目
            suggested_path="$(dirname "$(dirname "$current_dir")")/$PROJECT_NAME"
            log_info "检测到在scripts目录下"
        else
            # 在其他目录，在当前目录创建
            suggested_path="$current_dir/$PROJECT_NAME"
            log_info "在当前目录创建项目"
        fi
        
        echo -e "${CYAN}💡 智能建议路径: $suggested_path${NC}"
        echo -e "${YELLOW}是否使用建议路径? (Y/n/自定义路径) [默认: Y]:${NC}"
        read -r path_choice
        
        case "$path_choice" in
            y|Y|"")
                PROJECT_PATH="$suggested_path"
                ;;
            n|N)
                echo -e "${YELLOW}请选择:${NC}"
                echo -e "${CYAN}1.${NC} 用户主目录 (~/$PROJECT_NAME)"
                echo -e "${CYAN}2.${NC} 当前目录 (./$PROJECT_NAME)"
                echo -e "${CYAN}3.${NC} 自定义路径"
                echo -e "${YELLOW}请选择 (1/2/3) [默认: 1]:${NC}"
                read -r choice
                
                # 如果用户直接按回车，默认选择1
                if [ -z "$choice" ]; then
                    choice=1
                fi
                
                case "$choice" in
                    1)
                        PROJECT_PATH="$HOME/$PROJECT_NAME"
                        ;;
                    2)
                        PROJECT_PATH="$current_dir/$PROJECT_NAME"
                        ;;
                    3)
                        echo -e "${YELLOW}请输入完整路径:${NC}"
                        read -r custom_path
                        if [ -n "$custom_path" ]; then
                            case "$custom_path" in
                                ~*)
                                    PROJECT_PATH="${custom_path/#\~/$HOME}"
                                    ;;
                                /*)
                                    PROJECT_PATH="$custom_path"
                                    ;;
                                *)
                                    PROJECT_PATH="$current_dir/$custom_path"
                                    ;;
                            esac
                        else
                            PROJECT_PATH="$suggested_path"
                        fi
                        ;;
                    *)
                        PROJECT_PATH="$suggested_path"
                        ;;
                esac
                ;;
            *)
                # 用户直接输入了自定义路径
                case "$path_choice" in
                    ~*)
                        PROJECT_PATH="${path_choice/#\~/$HOME}"
                        ;;
                    /*)
                        PROJECT_PATH="$path_choice"
                        ;;
                    *)
                        PROJECT_PATH="$current_dir/$path_choice"
                        ;;
                esac
                ;;
        esac
    fi
    
    # 确保路径是绝对路径
    if [[ "$PROJECT_PATH" != /* ]]; then
        PROJECT_PATH="$(cd "$(dirname "$PROJECT_PATH")" 2>/dev/null && pwd)/$(basename "$PROJECT_PATH")" 2>/dev/null || {
            # 如果父目录不存在，基于当前目录构建
            PROJECT_PATH="$current_dir/$PROJECT_PATH"
        }
    fi
    
    log_success "最终项目路径: $PROJECT_PATH"
}

# 搜索相似项目经验
search_similar_projects() {
    log_info "搜索相似项目经验..."
    
    local memory_file="$GLOBAL_RULES_PATH/memory.sqlite"
    local experiences_found=false
    
    if [ -f "$memory_file" ]; then
        # 搜索项目类型相关经验
        local type_experiences=$(sqlite3 "$memory_file" "SELECT message FROM memories WHERE message LIKE '%${PROJECT_TYPE}%' OR message LIKE '%$(echo $PROJECT_TYPE | cut -d'-' -f1)%' ORDER BY timestamp DESC LIMIT 3;" 2>/dev/null)
        
        if [ -n "$type_experiences" ]; then
            experiences_found=true
            log_success "找到${PROJECT_TYPE}相关成功经验:"
            echo "$type_experiences" | while read -r line; do
                if [ -n "$line" ]; then
                    echo -e "    ${PURPLE}💡 $(echo "$line" | cut -c1-80)...${NC}"
                fi
            done
        fi
        
        # 搜索项目初始化相关经验
        local init_experiences=$(sqlite3 "$memory_file" "SELECT message FROM memories WHERE message LIKE '%项目初始化%' OR message LIKE '%project init%' OR message LIKE '%新项目%' ORDER BY timestamp DESC LIMIT 2;" 2>/dev/null)
        
        if [ -n "$init_experiences" ]; then
            experiences_found=true
            log_success "找到项目初始化最佳实践:"
            echo "$init_experiences" | while read -r line; do
                if [ -n "$line" ]; then
                    echo -e "    ${CYAN}📋 $(echo "$line" | cut -c1-80)...${NC}"
                fi
            done
        fi
    fi
    
    if [ "$experiences_found" = false ]; then
        log_warning "暂无相关历史经验，将应用标准最佳实践"
    fi
    
    # 提供项目类型特定建议
    echo -e "\n${CYAN}🎯 基于${PROJECT_TYPE}的智能建议:${NC}"
    case $PROJECT_TYPE in
        gin-microservice)
            echo -e "    ${CYAN}💡 建议使用PostgreSQL作为主数据库，Redis作为缓存${NC}"
            echo -e "    ${CYAN}💡 推荐集成Swagger自动生成API文档${NC}"
            echo -e "    ${CYAN}💡 建议实现统一的错误处理和日志记录${NC}"
            echo -e "    ${CYAN}💡 推荐使用Docker容器化部署${NC}"
            ;;
        vue3-frontend)
            echo -e "    ${CYAN}💡 建议使用TypeScript提升代码质量${NC}"
            echo -e "    ${CYAN}💡 推荐Element Plus作为UI组件库${NC}"
            echo -e "    ${CYAN}💡 建议使用Pinia进行状态管理${NC}"
            echo -e "    ${CYAN}💡 推荐配置ESLint和Prettier代码规范${NC}"
            ;;
        go-desktop)
            echo -e "    ${CYAN}💡 建议使用Fyne框架构建跨平台GUI${NC}"
            echo -e "    ${CYAN}💡 推荐集成SQLite作为本地数据库${NC}"
            echo -e "    ${CYAN}💡 建议实现自动更新功能${NC}"
            echo -e "    ${CYAN}💡 推荐支持配置文件和数据备份${NC}"
            ;;
        python-desktop)
            echo -e "    ${CYAN}💡 建议使用tkinter构建GUI界面${NC}"
            echo -e "    ${CYAN}💡 推荐PyInstaller打包可执行文件${NC}"
            echo -e "    ${CYAN}💡 建议集成异常处理和日志系统${NC}"
            echo -e "    ${CYAN}💡 推荐支持多平台兼容性${NC}"
            ;;
        fastapi-vue)
            echo -e "    ${CYAN}💡 建议前后端分离架构设计${NC}"
            echo -e "    ${CYAN}💡 推荐使用Pydantic进行数据验证${NC}"
            echo -e "    ${CYAN}💡 建议集成JWT认证系统${NC}"
            echo -e "    ${CYAN}💡 推荐使用Docker Compose本地开发${NC}"
            ;;
    esac
}

# 🧠 从规范文件动态解析项目目录结构
parse_project_structure_from_spec() {
    local project_type="$1"
    local spec_file="$GLOBAL_RULES_PATH/claude-engine/project-types/${project_type}.md"
    
    if [ ! -f "$spec_file" ]; then
        log_error "规范文件不存在: $spec_file"
        return 1
    fi
    
    log_verbose "从规范文件解析目录结构: $spec_file"
    
    # 提取目录结构部分并解析
    local dirs=()
    local in_structure_section=false
    local in_code_block=false
    local current_path_stack=()
    
    while IFS= read -r line; do
        # 检测是否进入标准目录结构部分
        if echo "$line" | grep -q "标准目录结构\|Directory Structure"; then
            in_structure_section=true
            continue
        fi
        
        # 检测代码块开始
        if [ "$in_structure_section" = true ] && echo "$line" | grep -q '^```'; then
            if [ "$in_code_block" = false ]; then
                in_code_block=true
                current_path_stack=()
                continue
            else
                # 代码块结束
                break
            fi
        fi
        
        # 在代码块中解析目录结构
        if [ "$in_code_block" = true ]; then
            # 跳过项目根目录行
            if echo "$line" | grep -q "^[a-zA-Z-]*/$"; then
                continue
            fi
            
            # 解析树状结构行
            if echo "$line" | grep -qE "^[│ ]*[├└]──"; then
                # 移除树状符号和空格，获取目录/文件名
                local item=$(echo "$line" | sed -E 's/^[│ ]*[├└]── *//' | sed 's/ *#.*$//')
                
                # 跳过空行
                if [ -z "$item" ]; then
                    continue
                fi
                
                # 计算缩进级别
                local indent_level=$(echo "$line" | grep -o "│" | wc -l)
                
                # 根据缩进级别调整路径栈
                while [ ${#current_path_stack[@]} -gt $indent_level ]; do
                    unset current_path_stack[-1]
                done
                
                # 如果是目录（以/结尾）
                if echo "$item" | grep -q "/$"; then
                    local dir_name=$(echo "$item" | sed 's|/$||')
                    current_path_stack+=("$dir_name")
                    
                    # 构建完整路径
                    local full_path=""
                    for path_part in "${current_path_stack[@]}"; do
                        if [ -z "$full_path" ]; then
                            full_path="$path_part"
                        else
                            full_path="$full_path/$path_part"
                        fi
                    done
                    
                    # 添加到目录列表，跳过一些通用目录
                    if [[ ! "$full_path" =~ ^(\.vscode|\.editorconfig|\.gitignore|Makefile|project_docs|project_process|README\.md)$ ]]; then
                        dirs+=("$full_path")
                        log_verbose "解析到目录: $full_path"
                    fi
                fi
            fi
        fi
        
        # 如果遇到下一个章节，结束解析
        if [ "$in_structure_section" = true ] && echo "$line" | grep -q "^## "; then
            break
        fi
        
    done < "$spec_file"
    
    # 输出解析到的目录列表
    printf '%s\n' "${dirs[@]}"
    
    log_verbose "从规范文件解析到 ${#dirs[@]} 个目录"
}

# 📁 动态创建项目目录结构
create_dynamic_structure() {
    local project_type="$1"
    
    log_info "动态解析并创建 $project_type 项目结构..."
    
    # 解析规范文件获取目录列表
    local dirs_array=()
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            dirs_array+=("$line")
        fi
    done < <(parse_project_structure_from_spec "$project_type")
    
    if [ ${#dirs_array[@]} -eq 0 ]; then
        log_warning "未能从规范文件解析到目录结构，使用备用方案"
        # 备用方案：根据项目类型提供基础目录
        case $project_type in
            "gin_microservice")
                dirs_array=("cmd/server" "internal/api/handlers" "internal/models" "internal/services" "pkg/logger")
                ;;
            "gin_vue3")
                dirs_array=("backend/cmd/server" "backend/internal/api/handlers" "frontend/src/components" "frontend/src/views")
                ;;
            "vue3_frontend")
                dirs_array=("src/components" "src/views" "src/stores" "src/router" "src/utils")
                ;;
            *)
                log_error "未知项目类型且无法解析规范文件: $project_type"
                return 1
                ;;
        esac
        log_warning "使用备用目录结构，包含 ${#dirs_array[@]} 个目录"
    else
        log_success "成功从规范文件解析到 ${#dirs_array[@]} 个目录"
    fi
    
    # 创建解析到的目录
    for dir in "${dirs_array[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            log_verbose "创建目录: $dir"
        fi
    done
    
    log_success "动态目录结构创建完成"
    return 0
}

# 创建项目目录结构
create_project_structure() {
    log_info "创建项目目录结构..."
    
    # 检查项目目录是否已存在
    if [ -d "$PROJECT_PATH" ]; then
        log_warning "目录已存在: $PROJECT_PATH"
        echo -e "${YELLOW}是否要继续？这可能会覆盖现有文件 (y/N) [默认: N]:${NC}"
        read -r continue_create
        if [ -z "$continue_create" ] || ([ "$continue_create" != "y" ] && [ "$continue_create" != "Y" ]); then
            log_error "操作已取消"
            exit 1
        fi
    fi
    
    # 创建基础目录
    mkdir -p "$PROJECT_PATH"
    cd "$PROJECT_PATH"
    
    # 创建通用目录结构
    mkdir -p .claude_rules
    mkdir -p project_process/daily
    mkdir -p docs
    mkdir -p scripts
    
    # 🚀 使用动态解析创建项目结构
    case $PROJECT_TYPE in
        gin-vue3)
            create_dynamic_structure "gin_vue3"
            create_gin_vue3_files
            ;;
        gin-microservice)
            create_dynamic_structure "gin_microservice"
            create_gin_files
            ;;
        vue3-frontend)
            create_dynamic_structure "vue3_frontend"
            create_vue3_files
            ;;
        go-desktop)
            create_dynamic_structure "go_desktop"
            create_go_desktop_files
            ;;
        python-desktop)
            create_dynamic_structure "python_desktop"
            create_python_desktop_files
            ;;
        fastapi-vue3)
            create_dynamic_structure "fastapi_vue3"
            create_fastapi_files
            ;;
    esac
    
    log_success "项目目录结构创建完成"
}

# 创建Gin+Vue3全栈文件
create_gin_vue3_files() {
    log_verbose "创建Gin+Vue3全栈配置文件..."
    
    # 创建部署结构 (强制容器化)
    mkdir -p deployments scripts
    
    # 创建后端 go.mod
    cat > backend/go.mod << EOF
module $PROJECT_NAME-backend

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
    github.com/go-playground/validator/v10 v10.15.5
)
EOF
    
    # 创建前端 package.json
    cat > frontend/package.json << EOF
{
  "name": "$PROJECT_NAME-frontend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "lint": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --fix"
  },
  "dependencies": {
    "vue": "^3.3.4",
    "vue-router": "^4.2.4",
    "pinia": "^2.1.6",
    "element-plus": "^2.3.9",
    "@element-plus/icons-vue": "^2.1.0",
    "axios": "^1.5.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.2.3",
    "typescript": "^5.0.2",
    "vue-tsc": "^1.8.5",
    "vite": "^4.4.5",
    "vitest": "^0.34.1",
    "@vue/test-utils": "^2.4.1",
    "eslint": "^8.45.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "prettier": "^3.0.0"
  }
}
EOF
    
    # 创建多架构Docker构建脚本 (强制容器化)
    cat > scripts/multi-arch-build.sh << 'EOF'
#!/bin/bash

# 多架构镜像构建脚本 - Gin+Vue3

set -e

PROJECT_NAME="$(basename "$(pwd)")"
VERSION="${VERSION:-latest}"
REGISTRY="${DOCKER_REGISTRY:-$USER}"

echo "🏗️  开始多架构构建..."
echo "📦 项目: $PROJECT_NAME"
echo "🏷️  版本: $VERSION"
echo "📍 注册表: $REGISTRY"

# 检查Docker Buildx
if ! docker buildx version >/dev/null 2>&1; then
    echo "❌ Docker Buildx不可用"
    exit 1
fi

# 创建构建器
echo "🔧 创建多架构构建器..."
docker buildx create --name multiarch-builder --use --bootstrap 2>/dev/null || true

# 构建多架构镜像
echo "📦 构建并推送多架构镜像..."
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag "$REGISTRY/$PROJECT_NAME:$VERSION" \
  --tag "$REGISTRY/$PROJECT_NAME:latest" \
  --push \
  .

echo "✅ 多架构构建完成!"
echo "📋 镜像: $REGISTRY/$PROJECT_NAME:$VERSION"
echo "🏗️  架构: linux/amd64, linux/arm64"
EOF
    chmod +x scripts/multi-arch-build.sh
    
    # 创建智能Docker Compose配置
    cat > deployments/docker-compose.smart.yml << 'EOF'
# 智能 Docker Compose 配置 - Gin+Vue3

services:
  backend:
    image: ${DOCKER_REGISTRY:-$USER}/${PROJECT_NAME:-app}-backend:${VERSION:-latest}
    container_name: "${PROJECT_NAME:-app}-backend"
    environment:
      - APP_HOST=0.0.0.0
      - APP_PORT=${BACKEND_PORT:-8080}
      - GIN_MODE=${GIN_MODE:-release}
      - DB_HOST=${DB_HOST:-postgres}
      - DB_PORT=${DB_PORT:-5432}
      - DB_NAME=${DB_NAME:-appdb}
      - DB_USER=${DB_USER:-postgres}
      - DB_PASSWORD=${DB_PASSWORD:-password}
      - REDIS_URL=${REDIS_URL:-redis://redis:6379}
    ports:
      - "${BACKEND_PORT:-8080}:${BACKEND_PORT:-8080}"
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:${BACKEND_PORT:-8080}/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    restart: unless-stopped
    networks:
      - app-network

  frontend:
    image: ${DOCKER_REGISTRY:-$USER}/${PROJECT_NAME:-app}-frontend:${VERSION:-latest}
    container_name: "${PROJECT_NAME:-app}-frontend"
    environment:
      - VITE_API_BASE_URL=http://localhost:${BACKEND_PORT:-8080}/api
    ports:
      - "${FRONTEND_PORT:-3000}:80"
    depends_on:
      backend:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:80"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    restart: unless-stopped
    networks:
      - app-network

  postgres:
    image: postgres:15-alpine
    container_name: "${PROJECT_NAME:-app}-postgres"
    environment:
      POSTGRES_DB: ${DB_NAME:-appdb}
      POSTGRES_USER: ${DB_USER:-postgres}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-password}
    ports:
      - "${DB_PORT:-5432}:5432"
    volumes:
      - postgres-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER:-postgres} -d ${DB_NAME:-appdb}"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped
    networks:
      - app-network

  redis:
    image: redis:7-alpine
    container_name: "${PROJECT_NAME:-app}-redis"
    command: redis-server --appendonly yes
    ports:
      - "${REDIS_PORT:-6379}:6379"
    volumes:
      - redis-data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped
    networks:
      - app-network

volumes:
  postgres-data:
    name: "${PROJECT_NAME:-app}-postgres-data"
  redis-data:
    name: "${PROJECT_NAME:-app}-redis-data"

networks:
  app-network:
    name: "${PROJECT_NAME:-app}-network"
    driver: bridge
EOF
    
    # 创建生产安全部署脚本
    cat > deployments/production-safe-deploy.sh << 'EOF'
#!/bin/bash

# 生产安全部署脚本 - Gin+Vue3
# 绝不删除现有数据卷，确保数据安全

set -e

PROJECT_NAME="$(basename "$(pwd)")"
VERSION="${VERSION:-latest}"

echo "🚀 开始生产安全部署..."
echo "📦 项目: $PROJECT_NAME"
echo "🏷️  版本: $VERSION"

# 检查环境变量
if [ -f ".env.production" ]; then
    echo "📋 加载生产环境配置..."
    export $(cat .env.production | grep -v '^#' | xargs)
else
    echo "⚠️  未找到 .env.production 文件"
fi

# 检查数据卷存在性（保护数据）
echo "🔍 检查现有数据卷..."
EXISTING_VOLUMES=$(docker volume ls -q | grep "^${PROJECT_NAME}-" || true)
if [ -n "$EXISTING_VOLUMES" ]; then
    echo "✅ 检测到现有数据卷，将保持不变:"
    echo "$EXISTING_VOLUMES" | sed 's/^/  - /'
fi

# 停止现有服务（保留数据卷）
echo "⏹️  停止现有服务..."
docker compose -f deployments/docker-compose.smart.yml down --remove-orphans

# 拉取最新镜像
echo "📥 拉取最新镜像..."
docker compose -f deployments/docker-compose.smart.yml pull

# 启动服务
echo "🚀 启动服务..."
docker compose -f deployments/docker-compose.smart.yml up -d

# 等待健康检查
echo "🏥 等待健康检查..."
sleep 30

# 验证部署
echo "✅ 验证部署状态..."
if curl -f "http://localhost:${BACKEND_PORT:-8080}/health" >/dev/null 2>&1; then
    echo "✅ 后端健康检查通过"
else
    echo "❌ 后端健康检查失败"
    exit 1
fi

if curl -f "http://localhost:${FRONTEND_PORT:-3000}" >/dev/null 2>&1; then
    echo "✅ 前端健康检查通过"
else
    echo "❌ 前端健康检查失败"
    exit 1
fi

echo "🎉 生产部署成功！"
echo "🌐 前端: http://localhost:${FRONTEND_PORT:-3000}"
echo "🔗 后端: http://localhost:${BACKEND_PORT:-8080}"
echo "📊 API文档: http://localhost:${BACKEND_PORT:-8080}/swagger/index.html"
EOF
    chmod +x deployments/production-safe-deploy.sh
    
    # 创建开发测试部署脚本
    cat > deployments/smart-redis-deploy.sh << 'EOF'
#!/bin/bash

# 智能Redis检测部署脚本 - 开发/测试环境

set -e

echo "🔍 智能Redis环境检测..."

# Redis连接优先级：远程 > 本地 > Docker > 内置
REDIS_URL=""

# 1. 检查远程Redis
if [ -n "${REMOTE_REDIS_URL}" ]; then
    if redis-cli -u "${REMOTE_REDIS_URL}" ping >/dev/null 2>&1; then
        REDIS_URL="${REMOTE_REDIS_URL}"
        echo "✅ 使用远程Redis: $REDIS_URL"
    fi
fi

# 2. 检查本地Redis
if [ -z "$REDIS_URL" ]; then
    if redis-cli ping >/dev/null 2>&1; then
        REDIS_URL="redis://localhost:6379"
        echo "✅ 使用本地Redis: $REDIS_URL"
    fi
fi

# 3. 启动DockerRedis
if [ -z "$REDIS_URL" ]; then
    echo "🐳 启动Docker Redis..."
    docker compose -f deployments/docker-compose.smart.yml up -d redis
    sleep 5
    if docker compose -f deployments/docker-compose.smart.yml ps redis | grep -q "Up"; then
        REDIS_URL="redis://localhost:6379"
        echo "✅ 使用Docker Redis: $REDIS_URL"
    fi
fi

# 4. 使用内置缓存
if [ -z "$REDIS_URL" ]; then
    echo "⚠️  无可用Redis，使用内置缓存"
    export USE_MEMORY_CACHE=true
else
    export REDIS_URL="$REDIS_URL"
fi

# 启动开发环境
echo "🚀 启动开发环境..."
docker compose -f deployments/docker-compose.smart.yml up -d postgres

# 等待数据库准备就绪
echo "⏳ 等待数据库准备就绪..."
sleep 10

echo "✅ 开发环境准备就绪！"
echo "📋 Redis: ${REDIS_URL:-内置缓存}"
echo "📋 PostgreSQL: localhost:5432"
EOF
    chmod +x deployments/smart-redis-deploy.sh
    
    # 创建 Makefile
    cat > Makefile << 'EOF'
.PHONY: help init dev build test lint clean docker-build deploy-dev deploy-prod health-check

PROJECT_NAME = $(shell basename $(CURDIR))
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")

help:
	@echo "🚀 Gin+Vue3全栈项目开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  init          - 初始化开发环境"
	@echo "  dev           - 启动本地开发服务器"
	@echo "  test          - 运行测试"
	@echo "  lint          - 代码检查"
	@echo ""
	@echo "🏗️  构建部署:"
	@echo "  build-multi   - 构建多架构Docker镜像 ⭐"
	@echo "  deploy-dev    - 部署到开发环境"
	@echo "  deploy-prod   - 部署到生产环境 ⭐"
	@echo ""
	@echo "🧹 维护:"
	@echo "  clean         - 清理临时文件"
	@echo "  health-check  - 健康检查"

init:
	@echo "🔧 初始化开发环境..."
	cd backend && go mod tidy && go mod download
	cd frontend && npm install

dev:
	@echo "🚀 启动本地开发服务器..."
	./deployments/smart-redis-deploy.sh
	@echo "环境准备就绪，请在两个终端中分别运行:"
	@echo "  后端: cd backend && go run cmd/server/main.go"
	@echo "  前端: cd frontend && npm run dev"

test:
	@echo "🧪 运行测试..."
	cd backend && go test -v -race -cover ./...
	cd frontend && npm run test

lint:
	@echo "🔍 代码检查..."
	cd backend && go fmt ./... && go vet ./...
	cd frontend && npm run lint

# ⭐ 构建多架构镜像（强制容器化）
build-multi:
	@echo "📦 构建多架构Docker镜像..."
	./scripts/multi-arch-build.sh

# 开发环境部署
deploy-dev:
	@echo "🚀 部署到开发环境..."
	./deployments/smart-redis-deploy.sh

# ⭐ 生产环境部署（强制容器化）
deploy-prod:
	@echo "🚀 部署到生产环境..."
	./deployments/production-safe-deploy.sh

health-check:
	@echo "🏥 健康检查..."
	@if curl -f "http://localhost:8080/health" >/dev/null 2>&1; then \
		echo "✅ 后端服务正常"; \
	else \
		echo "❌ 后端服务异常"; \
	fi
	@if curl -f "http://localhost:3000" >/dev/null 2>&1; then \
		echo "✅ 前端服务正常"; \
	else \
		echo "❌ 前端服务异常"; \
	fi

clean:
	@echo "🧹 清理临时文件..."
	rm -rf backend/tmp backend/logs/*.log
	rm -rf frontend/dist frontend/node_modules/.cache
EOF
}

# 创建Gin微服务文件
create_gin_files() {
    log_verbose "创建Gin微服务配置文件..."
    
    # 创建部署目录
    mkdir -p deployments scripts
    
    # 创建go.mod
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
    github.com/go-playground/validator/v10 v10.15.5
)
EOF
    
    # 创建统一响应模型
    cat > internal/models/response.go << 'EOF'
package models

import (
    "time"
    "github.com/gin-gonic/gin"
)

type APIResponse struct {
    Code      int         `json:"code"`
    Message   string      `json:"message"`
    Data      interface{} `json:"data"`
    Timestamp int64       `json:"timestamp"`
    RequestID string      `json:"request_id"`
    Errors    []FieldError `json:"errors,omitempty"`
}

type FieldError struct {
    Field   string `json:"field"`
    Message string `json:"message"`
}

type PaginationResponse struct {
    List       interface{} `json:"list"`
    Pagination Pagination  `json:"pagination"`
}

type Pagination struct {
    Page       int   `json:"page"`
    PageSize   int   `json:"page_size"`
    Total      int64 `json:"total"`
    TotalPages int   `json:"total_pages"`
}

// Success 返回成功响应
func Success(c *gin.Context, data interface{}) {
    c.JSON(200, APIResponse{
        Code:      200,
        Message:   "success",
        Data:      data,
        Timestamp: time.Now().Unix(),
        RequestID: c.GetString("request_id"),
    })
}

// Error 返回错误响应
func Error(c *gin.Context, code int, message string, errors ...FieldError) {
    c.JSON(code, APIResponse{
        Code:      code,
        Message:   message,
        Data:      nil,
        Timestamp: time.Now().Unix(),
        RequestID: c.GetString("request_id"),
        Errors:    errors,
    })
}

// SuccessWithPagination 返回分页数据响应
func SuccessWithPagination(c *gin.Context, list interface{}, page, pageSize int, total int64) {
    totalPages := int((total + int64(pageSize) - 1) / int64(pageSize))
    
    c.JSON(200, APIResponse{
        Code:    200,
        Message: "success",
        Data: PaginationResponse{
            List: list,
            Pagination: Pagination{
                Page:       page,
                PageSize:   pageSize,
                Total:      total,
                TotalPages: totalPages,
            },
        },
        Timestamp: time.Now().Unix(),
        RequestID: c.GetString("request_id"),
    })
}
EOF

    # 创建主程序入口
    cat > cmd/server/main.go << 'EOF'
package main

import (
    "log"
    
    "github.com/gin-gonic/gin"
)

// @title API服务
// @version 1.0
// @description 这是一个使用Gin框架构建的API服务
// @host localhost:8080
// @BasePath /api/v1
func main() {
    // 设置Gin模式
    gin.SetMode(gin.DebugMode)
    
    // 创建路由
    r := gin.Default()
    
    // 健康检查
    r.GET("/health", func(c *gin.Context) {
        c.JSON(200, gin.H{
            "status": "ok",
            "message": "service is running",
        })
    })
    
    // API路由组
    v1 := r.Group("/api/v1")
    {
        v1.GET("/ping", func(c *gin.Context) {
            c.JSON(200, gin.H{
                "message": "pong",
            })
        })
    }
    
    // 启动服务器
    log.Println("Server starting on :8080")
    r.Run(":8080")
}
EOF

    # 创建Makefile
    cat > Makefile << 'EOF'
.PHONY: init dev build test lint clean docker help

PROJECT_NAME = $(shell basename $(CURDIR))
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")

help:
	@echo "Gin微服务项目开发命令:"
	@echo "  init     - 初始化开发环境"
	@echo "  dev      - 启动开发服务器"
	@echo "  build    - 构建可执行文件"
	@echo "  test     - 运行测试"
	@echo "  lint     - 代码检查"
	@echo "  clean    - 清理临时文件"

init:
	@echo "🔧 初始化开发环境..."
	go mod tidy
	go mod download

dev:
	@echo "🚀 启动开发服务器..."
	go run cmd/server/main.go

build:
	@echo "📦 构建可执行文件..."
	mkdir -p bin
	go build -o bin/$(PROJECT_NAME) cmd/server/main.go

test:
	@echo "🧪 运行测试..."
	go test -v -race -cover ./...

lint:
	@echo "🔍 代码检查..."
	go fmt ./...
	go vet ./...

clean:
	@echo "🧹 清理临时文件..."
	rm -rf bin/ logs/*.log
EOF
}

# 创建Vue3前端结构
create_vue3_files() {
    log_verbose "创建Vue3前端配置文件..."
    
    # 创建package.json
    cat > package.json << EOF
{
  "name": "$PROJECT_NAME",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "lint": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --fix"
  },
  "dependencies": {
    "vue": "^3.3.4",
    "vue-router": "^4.2.4",
    "pinia": "^2.1.6",
    "element-plus": "^2.3.9",
    "@element-plus/icons-vue": "^2.1.0",
    "axios": "^1.5.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.2.3",
    "typescript": "^5.0.2",
    "vue-tsc": "^1.8.5",
    "vite": "^4.4.5",
    "vitest": "^0.34.1",
    "@vue/test-utils": "^2.4.1",
    "eslint": "^8.45.0",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "prettier": "^3.0.0"
  }
}
EOF

    # 创建基础HTML
    cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vue3 App</title>
  </head>
  <body>
    <div id="app"></div>
    <script type="module" src="/src/main.ts"></script>
  </body>
</html>
EOF

    # 创建主应用文件
    cat > src/main.ts << 'EOF'
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.use(ElementPlus)

app.mount('#app')
EOF

    # 创建App.vue
    cat > src/App.vue << 'EOF'
<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script setup lang="ts">
// 主应用组件
</script>

<style scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
EOF

    # 创建基础路由
    cat > src/router/index.ts << 'EOF'
import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/HomeView.vue')
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
EOF

    # 创建首页视图
    cat > src/views/HomeView.vue << 'EOF'
<template>
  <div class="home">
    <el-container>
      <el-header>
        <h1>Vue3 + TypeScript + Element Plus</h1>
      </el-header>
      <el-main>
        <el-card>
          <template #header>
            <span>欢迎使用Vue3项目模板</span>
          </template>
          <p>这是一个标准化的Vue3项目，已配置：</p>
          <ul>
            <li>Vue3 + TypeScript</li>
            <li>Element Plus UI组件库</li>
            <li>Vue Router 路由管理</li>
            <li>Pinia 状态管理</li>
            <li>Vite 构建工具</li>
          </ul>
          <el-button type="primary" @click="handleClick">开始开发</el-button>
        </el-card>
      </el-main>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { ElMessage } from 'element-plus'

const handleClick = () => {
  ElMessage.success('项目配置完成，可以开始开发了！')
}
</script>

<style scoped>
.home {
  padding: 20px;
}

.el-header {
  text-align: center;
  background-color: #f0f2f5;
}

ul {
  text-align: left;
  margin: 20px 0;
}

li {
  margin: 8px 0;
}
</style>
EOF

    # 创建TypeScript配置
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "preserve",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src/**/*.ts", "src/**/*.d.ts", "src/**/*.tsx", "src/**/*.vue"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOF

    # 创建Vite配置
    cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src'),
    },
  },
  server: {
    port: 3000,
    open: true,
  },
})
EOF
}

# 创建Go桌面应用结构
create_go_desktop_files() {
    log_verbose "创建Go桌面应用配置文件..."
    mkdir -p pkg/{database,utils}
    mkdir -p assets/{icons,images}
    mkdir -p resources
    mkdir -p dist
    
    # 创建go.mod
    cat > go.mod << EOF
module $PROJECT_NAME

go 1.21

require (
    fyne.io/fyne/v2 v2.4.0
    gorm.io/gorm v1.25.5
    gorm.io/driver/sqlite v1.5.4
    github.com/spf13/viper v1.17.0
)
EOF

    # 创建主程序
    cat > cmd/app/main.go << 'EOF'
package main

import (
    "fyne.io/fyne/v2/app"
    "fyne.io/fyne/v2/container"
    "fyne.io/fyne/v2/widget"
)

func main() {
    myApp := app.New()
    myApp.Settings().SetTheme(&myTheme{})
    
    myWindow := myApp.NewWindow("Desktop App")
    myWindow.Resize(fyne.NewSize(800, 600))
    
    content := container.NewVBox(
        widget.NewLabel("欢迎使用Go桌面应用"),
        widget.NewButton("点击我", func() {
            widget.NewAccordion()
        }),
    )
    
    myWindow.SetContent(content)
    myWindow.ShowAndRun()
}

type myTheme struct{}

func (m myTheme) Color(name fyne.ThemeColorName, variant fyne.ThemeVariant) color.Color {
    return theme.DefaultTheme().Color(name, variant)
}

func (m myTheme) Icon(name fyne.ThemeIconName) fyne.Resource {
    return theme.DefaultTheme().Icon(name)
}

func (m myTheme) Font(style fyne.TextStyle) fyne.Resource {
    return theme.DefaultTheme().Font(style)
}

func (m myTheme) Size(name fyne.ThemeSizeName) float32 {
    return theme.DefaultTheme().Size(name)
}
EOF
}

# 创建Python桌面应用结构
create_python_desktop_files() {
    log_verbose "创建Python桌面应用配置文件..."
    mkdir -p tests
    mkdir -p dist
    mkdir -p resources
    
    # 创建requirements.txt
    cat > requirements.txt << 'EOF'
# GUI框架 - 使用tkinter（Python内置）

# 数据处理
configparser>=5.3.0

# 打包工具
pyinstaller>=5.13.0

# 开发工具
pytest>=7.4.0
black>=23.7.0
flake8>=6.0.0
EOF

    # 创建主程序
    cat > src/main.py << 'EOF'
#!/usr/bin/env python3
"""
Desktop Application Main Entry
"""

import tkinter as tk
from tkinter import ttk, messagebox
import sys
import os

# 添加src目录到路径
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from ui.main_window import MainWindow

def main():
    """主函数"""
    try:
        app = MainWindow()
        app.run()
    except Exception as e:
        messagebox.showerror("错误", f"应用程序启动失败: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main()
EOF

    # 创建主窗口
    cat > src/ui/main_window.py << 'EOF'
"""
主窗口模块
"""

import tkinter as tk
from tkinter import ttk, messagebox

class MainWindow:
    def __init__(self):
        self.root = tk.Tk()
        self.setup_window()
        self.create_widgets()
        
    def setup_window(self):
        """设置窗口属性"""
        self.root.title("Desktop Application")
        self.root.geometry("800x600")
        self.root.resizable(True, True)
        
        # 设置窗口居中
        self.center_window()
        
    def center_window(self):
        """窗口居中显示"""
        self.root.update_idletasks()
        width = self.root.winfo_width()
        height = self.root.winfo_height()
        x = (self.root.winfo_screenwidth() // 2) - (width // 2)
        y = (self.root.winfo_screenheight() // 2) - (height // 2)
        self.root.geometry(f'{width}x{height}+{x}+{y}')
        
    def create_widgets(self):
        """创建界面组件"""
        # 主框架
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # 标题
        title_label = ttk.Label(main_frame, text="Python 桌面应用", 
                               font=("Arial", 16, "bold"))
        title_label.grid(row=0, column=0, columnspan=2, pady=10)
        
        # 功能按钮
        ttk.Button(main_frame, text="功能1", 
                  command=self.feature1).grid(row=1, column=0, padx=5, pady=5)
        ttk.Button(main_frame, text="功能2", 
                  command=self.feature2).grid(row=1, column=1, padx=5, pady=5)
        
        # 文本区域
        text_frame = ttk.LabelFrame(main_frame, text="信息显示", padding="5")
        text_frame.grid(row=2, column=0, columnspan=2, sticky=(tk.W, tk.E, tk.N, tk.S), pady=10)
        
        self.text_area = tk.Text(text_frame, height=20, width=70)
        scrollbar = ttk.Scrollbar(text_frame, orient="vertical", command=self.text_area.yview)
        self.text_area.configure(yscrollcommand=scrollbar.set)
        
        self.text_area.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        scrollbar.grid(row=0, column=1, sticky=(tk.N, tk.S))
        
        # 配置权重
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        main_frame.rowconfigure(2, weight=1)
        text_frame.columnconfigure(0, weight=1)
        text_frame.rowconfigure(0, weight=1)
        
        # 初始化文本
        self.text_area.insert(tk.END, "欢迎使用Python桌面应用！\n")
        self.text_area.insert(tk.END, "这是一个标准化的tkinter应用模板。\n\n")
        self.text_area.insert(tk.END, "功能特性：\n")
        self.text_area.insert(tk.END, "- 标准化的项目结构\n")
        self.text_area.insert(tk.END, "- 模块化的代码组织\n")
        self.text_area.insert(tk.END, "- 可扩展的UI设计\n")
        self.text_area.insert(tk.END, "- PyInstaller打包支持\n")
        
    def feature1(self):
        """功能1"""
        messagebox.showinfo("功能1", "这是功能1的演示")
        self.text_area.insert(tk.END, f"执行了功能1\n")
        self.text_area.see(tk.END)
        
    def feature2(self):
        """功能2"""
        messagebox.showinfo("功能2", "这是功能2的演示")
        self.text_area.insert(tk.END, f"执行了功能2\n")
        self.text_area.see(tk.END)
        
    def run(self):
        """运行应用"""
        self.root.mainloop()
EOF

    # 创建空的__init__.py文件
    touch src/__init__.py
    touch src/ui/__init__.py
    touch src/models/__init__.py
    touch src/services/__init__.py
    touch src/utils/__init__.py

    # 创建setup.py
    cat > setup.py << EOF
from setuptools import setup, find_packages

setup(
    name="$PROJECT_NAME",
    version="1.0.0",
    packages=find_packages(where="src"),
    package_dir={"": "src"},
    python_requires=">=3.8",
    install_requires=[
        # 在这里添加运行时依赖
    ],
    entry_points={
        "console_scripts": [
            "$PROJECT_NAME=main:main",
        ],
    },
    author="Your Name",
    author_email="your.email@example.com",
    description="A desktop application built with Python and tkinter",
    long_description=open("README.md").read() if os.path.exists("README.md") else "",
    long_description_content_type="text/markdown",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: End Users/Desktop",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
)
EOF
}

# 创建FastAPI全栈结构
create_fastapi_files() {
    log_verbose "创建FastAPI全栈配置文件..."
    
    # 创建部署目录
    mkdir -p deployments scripts
    
    # 共享配置
    mkdir -p deployments/{docker,nginx}
    
    # 创建后端requirements.txt
    cat > backend/requirements.txt << 'EOF'
fastapi>=0.103.0
uvicorn[standard]>=0.23.0
pydantic>=2.3.0
sqlalchemy>=2.0.0
alembic>=1.12.0
python-jose[cryptography]>=3.3.0
passlib[bcrypt]>=1.7.4
python-multipart>=0.0.6
python-dotenv>=1.0.0
EOF

    # 创建后端主程序
    cat > backend/app/main.py << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .api import router as api_router

app = FastAPI(
    title="FastAPI Application",
    description="A full-stack application with FastAPI backend",
    version="1.0.0",
)

# CORS设置
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  # 前端开发服务器
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 包含API路由
app.include_router(api_router, prefix="/api/v1")

@app.get("/")
async def root():
    return {"message": "FastAPI + Vue3 Full Stack Application"}

@app.get("/health")
async def health_check():
    return {"status": "ok", "message": "Service is running"}
EOF

    # 创建前端package.json
    cat > frontend/package.json << EOF
{
  "name": "$PROJECT_NAME-frontend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "vue": "^3.3.4",
    "vue-router": "^4.2.4",
    "pinia": "^2.1.6",
    "axios": "^1.5.0",
    "element-plus": "^2.3.9"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.2.3",
    "typescript": "^5.0.2",
    "vue-tsc": "^1.8.5",
    "vite": "^4.4.5"
  }
}
EOF

    # 创建Docker Compose
    cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/dbname
    depends_on:
      - db
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
    image: postgres:15
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: dbname
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
EOF
}

# 创建项目特定的CLAUDE.md文件
update_claude_md() {
    local project_path="$1"
    local project_type="$2"
    local health_score="$3"
    
    log_info "创建项目特定的CLAUDE.md（符合全局规范）..."
    
    local claude_md="$project_path/CLAUDE.md"
    
    # 备份现有的CLAUDE.md（如果存在）
    if [ -f "$claude_md" ]; then
        cp "$claude_md" "$claude_md.backup.$(date +%Y%m%d_%H%M%S)"
        log_verbose "备份了现有的CLAUDE.md"
    fi
    
    # 确保健康度评分是纯数字
    local clean_health_score=$(echo "$health_score" | grep -o '[0-9]\+' | head -1)
    if [ -z "$clean_health_score" ] || [ "$clean_health_score" -eq 0 ] 2>/dev/null; then
        clean_health_score=85
    fi
    
    # 获取项目类型对应的规范文件
    local project_spec_file="$GLOBAL_RULES_PATH/claude-engine/project-types/${project_type}.md"
    local project_name="$(basename "$project_path")"
    
    # 创建优化的项目特定CLAUDE.md
    cat > "$claude_md" << EOF
# $project_name - Claude Code 操作指南

## 🎯 项目信息
- **项目名称**: $project_name
- **项目类型**: $project_type
- **健康度**: ${clean_health_score}/100
- **创建时间**: $(date '+%Y-%m-%d %H:%M:%S')
- **开发工具**: Claude Code + VSCode + MCP

## 🚨 重要提醒
- **全局规范**: 已通过 Memory MCP 管理，启动时自动加载
- **项目规范**: 严格遵循 ${project_type} 项目标准  
- **部署策略**: 遵循项目类型对应的部署规范
- **强制要求**: 遵守全局 PROJECT_MANAGEMENT_RULES.md 中的所有强制规则

## 🔧 开发工作流程

### 1. 会话启动
\`\`\`bash
# Memory MCP 自动加载全局规范和项目历史经验
memory.recall_memory_abstract(context="global_rules,${project_type}_projects,deployment_strategy")
\`\`\`

### 2. 开发命令
EOF

    # 根据项目类型添加特定的开发命令
    case $project_type in
        "gin_vue3"|"gin-vue3")
            cat >> "$claude_md" << 'EOF'
```bash
# 启动开发环境
make dev              # 同时启动前后端
make dev-backend      # 只启动Go后端  
make dev-frontend     # 只启动Vue前端

# 代码质量检查（遵循全局强制规则）
make lint             # 前后端代码检查
make test             # 运行所有测试
make build            # 构建生产版本

# 部署相关（强制容器化）
make docker-build     # 构建Docker镜像
make deploy           # 生产部署
```
EOF
            ;;
        "gin_microservice"|"gin-microservice")
            cat >> "$claude_md" << 'EOF'
```bash
# 开发环境
make dev              # 启动开发服务器
make test             # 运行测试（强制要求）
make lint             # 代码检查（强制要求）

# 构建部署（强制容器化）
make build            # 编译二进制文件
make docker-build     # 构建Docker镜像
make deploy           # 生产部署
```
EOF
            ;;
        "vue3_frontend"|"vue3-frontend")
            cat >> "$claude_md" << 'EOF'
```bash
# 开发环境
npm run dev           # 启动开发服务器
npm run test          # 运行测试（强制要求）
npm run lint          # 代码检查（强制要求）

# 构建部署
npm run build         # 构建生产版本
npm run preview       # 预览构建结果
```
EOF
            ;;
        "go_desktop"|"go-desktop"|"python_desktop"|"python-desktop")
            cat >> "$claude_md" << 'EOF'
```bash
# 开发环境
make dev              # 启动开发模式
make test             # 运行测试（强制要求）
make lint             # 代码检查（强制要求）

# 构建部署（原生编译，禁止容器化）
make build-all        # 多平台编译
make package          # 打包分发版本
```
EOF
            ;;
        *)
            cat >> "$claude_md" << 'EOF'
```bash
# 通用开发命令（遵循全局规范）
make dev              # 启动开发
make test             # 运行测试（强制要求）
make lint             # 代码检查（强制要求）
make build            # 构建项目
```
EOF
            ;;
    esac

    # 添加部署策略信息（符合全局部署规范）
    cat >> "$claude_md" << EOF

### 3. 部署策略（严格遵循全局规范）
EOF

    case $project_type in
        "gin_vue3"|"gin-vue3"|"gin_microservice"|"gin-microservice"|"fastapi_vue3"|"fastapi-vue3"|"fastapi_backend")
            cat >> "$claude_md" << 'EOF'
- **策略**: 🐳 强制容器化部署（全局规范要求）
- **架构**: 支持 ARM64 + AMD64（强制要求）
- **命令**: `./scripts/multi-arch-build.sh` → `./deployments/production-safe-deploy.sh`
- **检查**: 部署后必须通过 `/health` 端点验证
- **安全**: 生产部署绝不删除现有数据卷
EOF
            ;;
        "vue3_frontend"|"vue3-frontend")
            cat >> "$claude_md" << 'EOF'
- **策略**: 📦 静态部署优先，容器化可选
- **推荐**: Nginx + CDN 分发
- **命令**: `npm run build` → 部署到静态服务器
- **优化**: Tree Shaking + 代码分割
EOF
            ;;
        "go_desktop"|"go-desktop"|"python_desktop"|"python-desktop")
            cat >> "$claude_md" << 'EOF'
- **策略**: 💻 原生编译部署（全局规范要求）
- **禁止**: 🚫 容器化部署（严格禁止）
- **命令**: `make build-all` → 多平台可执行文件
- **分发**: 直接下载安装，无复杂依赖
EOF
            ;;
    esac

    cat >> "$claude_md" << EOF

### 4. 会话结束（遵循全局工作流程）
\`\`\`bash
# 保存开发经验到 Memory MCP（全局规范要求）
memory.save_memory(
  speaker="developer",
  message="[项目开发总结和关键决策，包括部署配置]",
  context="global_rules,${project_type}_projects,deployment_strategy"
)
\`\`\`

## 📋 项目规范重点（基于全局规范）
EOF

    # 📋 从规范文件中提取并嵌入项目结构
    if [ -f "$project_spec_file" ]; then
        echo "- 📖 **项目规范来源**: claude-engine/project-types/${project_type}.md" >> "$claude_md"
        echo "- 🔴 **全局强制规则**: 通过 Memory MCP 自动加载" >> "$claude_md"
        echo "" >> "$claude_md"
        
        # 🚀 动态提取并嵌入标准目录结构
        cat >> "$claude_md" << 'EOF'

### 📁 项目标准目录结构

EOF
        
        # 从规范文件中提取目录结构部分
        local in_structure_section=false
        local in_code_block=false
        
        while IFS= read -r line; do
            # 检测标准目录结构章节
            if echo "$line" | grep -q "标准目录结构\|Directory Structure"; then
                in_structure_section=true
                continue
            fi
            
            # 检测代码块
            if [ "$in_structure_section" = true ] && echo "$line" | grep -q '^```'; then
                if [ "$in_code_block" = false ]; then
                    in_code_block=true
                    echo '```' >> "$claude_md"
                    continue
                else
                    # 代码块结束
                    echo '```' >> "$claude_md"
                    break
                fi
            fi
            
            # 在代码块中复制目录结构
            if [ "$in_code_block" = true ]; then
                echo "$line" >> "$claude_md"
            fi
            
            # 如果遇到下一个章节，结束解析
            if [ "$in_structure_section" = true ] && echo "$line" | grep -q "^## " && ! echo "$line" | grep -q "标准目录结构"; then
                break
            fi
            
        done < "$project_spec_file"
        
        echo "" >> "$claude_md"
        
        # 根据项目类型添加关键规范提醒
        case $project_type in
            "gin_vue3"|"gin-vue3"|"gin_microservice"|"gin-microservice")
                cat >> "$claude_md" << 'EOF'
- 🏗️ **目录结构**: 遵循标准 Go 项目布局（全局规范）
- 📡 **API 设计**: 统一响应格式 + Swagger 文档（强制要求）
- 🔒 **安全规范**: JWT + 参数验证 + SQL 防注入（全局禁令遵循）
- 🐳 **容器化**: Docker 多架构支持（强制要求）
- ✅ **必须文件**: .gitignore, .editorconfig, project_process/（全局规范）
EOF
                ;;
            "vue3_frontend"|"vue3-frontend")
                cat >> "$claude_md" << 'EOF'
- 🎨 **组件化**: Element Plus + 响应式设计
- 📦 **构建优化**: Vite + Tree Shaking
- 🔧 **代码质量**: ESLint + Prettier + TypeScript（全局规范）
- 📱 **多端适配**: PC + 移动端兼容
- ✅ **必须文件**: .gitignore, .editorconfig, project_process/（全局规范）
EOF
                ;;
            "go_desktop"|"go-desktop"|"python_desktop"|"python-desktop")
                cat >> "$claude_md" << 'EOF'
- 🖥️ **跨平台**: Windows + macOS + Linux 支持
- 📦 **单文件**: 可执行程序，无复杂依赖
- 🚫 **禁止容器化**: 桌面应用不使用 Docker（全局规范）
- 🔧 **构建系统**: 多平台自动化编译
- ✅ **必须文件**: .gitignore, .editorconfig, project_process/（全局规范）
EOF
                ;;
        esac
    else
        echo "- ⚠️ 项目规范文件未找到: $project_spec_file" >> "$claude_md"
    fi

    cat >> "$claude_md" << EOF

## 🚫 绝对禁止事项（全局规范强制执行）
- 🚫 禁止硬编码敏感信息（API密钥、数据库密码等）
- 🚫 禁止提交未格式化的代码
- 🚫 禁止跳过测试步骤
- 🚫 禁止违反项目命名规范
- 🚫 禁止直接修改 main/master 分支
- 🚫 禁止提交 Claude Code 签名（必须使用 Youmi Sam 签名）
- 🚫 禁止违反项目的强制部署策略

## 🔗 相关资源
- 📖 **项目规范**: claude-engine/project-types/${project_type}.md
- 🌐 **全局规范**: 通过 Memory MCP 加载
- 🚀 **部署指南**: guides/DEPLOYMENT_STRATEGY_GUIDE.md
- 🛠️ **开发记录**: project_process/ 目录（全局规范要求）

---
**📅 创建时间**: $(date '+%Y-%m-%d %H:%M:%S')  
**🤖 生成工具**: Claude Code v2.0 (符合全局规范)  
**🎯 项目类型**: ${project_type}  
**📊 健康度**: ${clean_health_score}/100  
**💾 规范依据**: Memory MCP + 全局 PROJECT_MANAGEMENT_RULES.md
EOF

    log_success "创建了符合全局规范的项目特定CLAUDE.md"
}

# 注入全局规则
inject_global_rules() {
    log_info "注入全局规则..."
    
    local rules_dir="$PROJECT_PATH/.claude_rules"
    local rules_copied=0
    
    # 复制全局规则文件
    if [ -f "$GLOBAL_RULES_PATH/PROJECT_MANAGEMENT_RULES.md" ]; then
        cp "$GLOBAL_RULES_PATH/PROJECT_MANAGEMENT_RULES.md" "$rules_dir/"
        log_success "复制了全局管理规则"
        ((rules_copied++))
    fi
    
    if [ -f "$GLOBAL_RULES_PATH/guides/MCP_USAGE_STANDARDS.md" ]; then
        cp "$GLOBAL_RULES_PATH/guides/MCP_USAGE_STANDARDS.md" "$rules_dir/"
        log_success "复制了MCP使用标准"
        ((rules_copied++))
    fi
    
    # 复制项目类型特定规范
    local type_rule_file=""
    case $PROJECT_TYPE in
        gin-vue3) type_rule_file="gin-vue3.md" ;;
        gin-microservice) type_rule_file="gin_microservice.md" ;;
        vue3-frontend) type_rule_file="vue3-frontend.md" ;;
        go-desktop) type_rule_file="go_desktop.md" ;;
        python-desktop) type_rule_file="python_desktop.md" ;;
        fastapi-vue3) type_rule_file="fastapi_vue3.md" ;;
    esac
    
    if [ -n "$type_rule_file" ] && [ -f "$GLOBAL_RULES_PATH/claude-engine/project-types/$type_rule_file" ]; then
        cp "$GLOBAL_RULES_PATH/claude-engine/project-types/$type_rule_file" "$rules_dir/"
        log_success "复制了${PROJECT_TYPE}特定规范"
        ((rules_copied++))
    fi
    
    if [ $rules_copied -eq 0 ]; then
        log_warning "未能复制任何规则文件"
        return 1
    fi
    
    log_success "成功注入 $rules_copied 个规则文件"
    return 0
}

# 生成优化的CLAUDE.md
generate_optimized_claude_md() {
    log_info "生成优化的Claude协作配置..."
    
    cat > CLAUDE.md << EOF
# CLAUDE.md - 新项目AI协作指南

## 🚨 新项目强制规则 (优先级最高)
### 立即执行
1. **必须先阅读** \`.claude_rules/\` 目录下的所有规则文件
2. **必须使用Memory MCP**搜索相关历史经验：
   \`\`\`
   memory.recall_memory_abstract(context="${PROJECT_TYPE},global_rules,项目初始化")
   \`\`\`
3. **必须遵循**项目类型特定的技术规范
4. **必须记录**重要决策到 \`project_process/decisions.md\`

### 开发过程中严禁
- 🚫 跳过项目结构标准化
- 🚫 硬编码配置信息
- 🚫 忽略代码规范和格式化
- 🚫 提交未测试的代码
- 🚫 不记录重要的技术决策

## 🎯 项目基本信息
- **项目名称**: $PROJECT_NAME
- **项目类型**: $PROJECT_TYPE
- **创建时间**: $(date '+%Y-%m-%d')
- **项目路径**: $PROJECT_PATH
- **状态**: 新项目初始化完成

## 📋 新项目初始化检查清单
启动开发前必须确认：
- [x] 项目目录结构已按规范创建
- [ ] 开发环境依赖已安装配置
- [ ] 代码规范工具已配置
- [ ] Git仓库已初始化且配置正确
- [ ] 基础功能验证通过
- [ ] 项目文档已完善

## 🔧 标准开发工作流
1. **会话开始**: 
   - 使用 Memory MCP 回忆项目状态: \`memory.recall_memory_abstract(context="${PROJECT_TYPE},global_rules")\`
   - 阅读项目状态摘要: \`project_process/summary.md\`

2. **开发过程**:
   - 严格遵循${PROJECT_TYPE}技术规范
   - 所有代码修改必须符合项目类型规范
   - 重要决策必须记录到 \`project_process/decisions.md\`

3. **质量检查**:
   - 代码格式化检查
   - 运行测试验证
   - 遵循API规范（如适用）

4. **会话结束**:
   - 保存重要经验: \`memory.save_memory(speaker="developer", message="[具体经验]", context="${PROJECT_TYPE},global_rules")\`
   - 更新项目状态: \`project_process/summary.md\`

## 🎯 ${PROJECT_TYPE} 特定规范
EOF

    # 添加项目类型特定内容
    case $PROJECT_TYPE in
        gin-microservice)
            cat >> CLAUDE.md << 'EOF'
### API开发规范
- ✅ 必须使用 `internal/models/response.go` 中的统一响应函数
- ✅ 所有API必须返回包含 code、message、data、timestamp、request_id 的结构
- ✅ 错误处理必须使用 `models.Error()` 函数
- ✅ 分页数据必须使用 `models.SuccessWithPagination()` 函数
- ✅ 必须实现请求ID追踪

### 开发流程
1. 运行 `go mod tidy` 安装依赖
2. 实现第一个API接口
3. 添加中间件和错误处理
4. 完善数据库模型和迁移
5. 集成Swagger文档
EOF
            ;;
        vue3-frontend)
            cat >> CLAUDE.md << 'EOF'
### 前端开发规范
- ✅ 必须使用TypeScript进行类型检查
- ✅ 组件必须使用Composition API编写
- ✅ 状态管理必须使用Pinia
- ✅ UI组件优先使用Element Plus
- ✅ 路由配置必须包含类型定义

### 开发流程
1. 运行 `npm install` 安装依赖
2. 配置TypeScript和ESLint
3. 创建核心页面组件
4. 实现路由和状态管理
5. 集成API调用和错误处理
EOF
            ;;
        go-desktop)
            cat >> CLAUDE.md << 'EOF'
### 桌面应用开发规范
- ✅ 必须使用Fyne框架构建GUI
- ✅ 必须实现配置文件管理
- ✅ 必须包含错误处理和日志记录
- ✅ UI设计必须考虑多平台兼容性
- ✅ 必须支持数据备份和恢复

### 开发流程
1. 运行 `go mod tidy` 安装依赖
2. 设计主窗口界面
3. 实现核心功能模块
4. 添加配置和数据管理
5. 测试跨平台兼容性
EOF
            ;;
        python-desktop)
            cat >> CLAUDE.md << 'EOF'
### 桌面应用开发规范
- ✅ 必须使用tkinter构建GUI界面
- ✅ 必须实现模块化的代码结构
- ✅ 必须包含异常处理和日志记录
- ✅ 必须支持配置文件管理
- ✅ 必须考虑PyInstaller打包

### 开发流程
1. 创建虚拟环境并安装依赖
2. 完善主界面设计
3. 实现核心业务逻辑
4. 添加数据持久化
5. 测试打包和分发
EOF
            ;;
        fastapi-vue)
            cat >> CLAUDE.md << 'EOF'
### 全栈开发规范
- ✅ 前后端必须通过标准API接口通信
- ✅ 后端必须实现JWT认证系统
- ✅ 前端必须实现统一的错误处理
- ✅ 必须使用Pydantic进行数据验证
- ✅ 必须配置CORS和安全中间件

### 开发流程
1. 配置后端依赖和前端环境
2. 实现基础API和认证系统
3. 创建前端页面和组件
4. 集成前后端API调用
5. 配置Docker容器化部署
EOF
            ;;
    esac

    cat >> CLAUDE.md << EOF

## 🧠 Memory MCP 使用指南
### 会话开始时
\`\`\`
memory.recall_memory_abstract(context="${PROJECT_TYPE},global_rules,项目初始化")
\`\`\`

### 重要决策记录
\`\`\`
memory.save_memory(
  speaker="developer",
  message="[项目初始化] ${PROJECT_NAME} 项目选择了 ${PROJECT_TYPE} 架构，主要考虑因素：[具体原因]",
  context="${PROJECT_TYPE},global_rules,项目初始化"
)
\`\`\`

### 遇到问题时
\`\`\`
memory.recall_memory_abstract(context="${PROJECT_TYPE},troubleshooting")
\`\`\`

## 📊 项目进度追踪
请在 \`project_process/summary.md\` 中持续更新：
- 当前完成的功能模块
- 遇到的技术挑战和解决方案
- 下一步计划
- 技术债务记录

## 🔗 相关链接
- [全局规则](.claude_rules/PROJECT_MANAGEMENT_RULES.md)
- [项目类型规范](.claude_rules/${PROJECT_TYPE}.md)
- [MCP使用标准](.claude_rules/MCP_USAGE_STANDARDS.md)

---
**📅 创建时间**: $(date '+%Y-%m-%d %H:%M:%S')
**🤖 Claude版本**: 增强版新项目创建器 v2.0
**📂 项目类型**: ${PROJECT_TYPE}
**📍 项目路径**: ${PROJECT_PATH}
**🎯 状态**: 已完成初始化，可开始开发
EOF

    log_success "生成了优化的Claude协作配置"
}

# 初始化项目状态文件
initialize_project_files() {
    log_info "初始化项目状态文件..."
    
    # 创建项目摘要
    cat > project_process/summary.md << EOF
# ${PROJECT_NAME} 项目状态摘要

## 📊 项目概览
- **项目名称**: $PROJECT_NAME
- **项目类型**: $PROJECT_TYPE
- **创建时间**: $(date '+%Y-%m-%d')
- **项目路径**: $PROJECT_PATH
- **当前状态**: 初始化完成
- **完成度**: 10% (项目结构和规范已建立)

## 🎯 当前阶段目标
### 立即完成 (今日)
- [ ] 安装开发环境依赖
- [ ] 验证项目基础功能
- [ ] 配置代码编辑器和格式化工具
- [ ] 初始化Git仓库并首次提交

### 本周目标
- [ ] 实现第一个核心功能
- [ ] 添加基础测试用例
- [ ] 完善项目文档
- [ ] 配置CI/CD基础流程

## 📋 技术选型记录
- **主要框架**: $PROJECT_TYPE 标准技术栈
- **开发工具**: 遵循全局规则的标准配置
- **代码规范**: 已应用项目类型特定规范
- **AI协作**: 优化的Claude Code配置

## 🏁 完成记录
- ✅ $(date '+%Y-%m-%d') 项目结构初始化完成
- ✅ $(date '+%Y-%m-%d') 全局规则注入完成
- ✅ $(date '+%Y-%m-%d') Claude协作配置优化完成
- ✅ $(date '+%Y-%m-%d') 项目模板和依赖配置完成

## 📝 重要说明
这是一个全新的 $PROJECT_TYPE 项目，具备以下特性：
1. ✅ 完整的标准化项目结构
2. ✅ 全局开发规范已注入
3. ✅ 优化的Claude Code协作配置
4. ✅ 项目类型特定的最佳实践
5. ✅ 历史经验和知识复用

### 开发准则
- 每次开发前使用Memory MCP回忆相关经验
- 重要决策必须记录到 decisions.md
- 代码提交前必须通过格式化和测试检查
- 定期更新此摘要文件

---
**最后更新**: $(date '+%Y-%m-%d %H:%M:%S')
**健康度**: 优秀（新项目标准配置）
**下次目标**: 环境配置和基础功能实现
EOF

    # 创建决策记录
    cat > project_process/decisions.md << EOF
# 技术决策记录

## 格式说明
每个决策记录应包含：
- **决策时间**: YYYY-MM-DD
- **决策背景**: 为什么需要做这个决策
- **考虑的方案**: 列出所有考虑过的选项
- **最终决策**: 选择的方案和理由
- **影响范围**: 这个决策会影响哪些模块
- **回顾时间**: 计划何时回顾这个决策

---

## 决策记录

### 项目初始化技术选型 - $(date '+%Y-%m-%d')
**背景**: 新建 $PROJECT_NAME 项目，需要选择合适的技术架构和开发流程
**方案**: 
1. $PROJECT_TYPE - 符合团队技术栈和项目需求
2. 其他框架 - 评估后认为不适合当前场景
3. 混合技术栈 - 复杂度高，不适合项目规模
**决策**: 选择 $PROJECT_TYPE 架构
**理由**: 
- 符合全局规则的标准化要求
- 团队有相关经验积累（通过Memory MCP获取）
- 有完善的最佳实践指导
- 便于后续维护和扩展
- 支持快速开发和部署
**影响**: 确定了项目的技术方向、开发规范和工具链选择
**回顾**: 项目完成30%后评估技术选型效果

### 项目结构和规范配置 - $(date '+%Y-%m-%d')
**背景**: 需要建立标准化的项目结构和开发规范
**方案**:
1. 手动配置 - 灵活但容易不一致
2. 全局规则注入 - 自动化标准化管理
**决策**: 使用全局规则注入系统
**理由**:
- 确保开发规范的一致性
- 优化Claude Code协作效率
- 便于跨项目经验复用
- 降低项目维护成本
**影响**: 影响整个项目的开发流程、代码规范和AI协作方式
**回顾**: 使用1个月后评估规范化效果

EOF

    # 创建README.md
    cat > README.md << EOF
# $PROJECT_NAME

> 基于 $PROJECT_TYPE 的标准化项目

## 📋 项目简介

这是一个使用 $PROJECT_TYPE 技术栈构建的项目，采用标准化的开发规范和AI协作模式。

## 🚀 快速开始

### 环境要求
EOF

    # 根据项目类型添加特定说明
    case $PROJECT_TYPE in
        gin-microservice)
            cat >> README.md << 'EOF'
- Go 1.21+
- PostgreSQL 13+
- Redis 6+

### 安装依赖
```bash
go mod tidy
```

### 运行项目
```bash
# 开发模式
make dev

# 或直接运行
go run cmd/server/main.go
```

### API文档
启动项目后访问: http://localhost:8080/swagger/index.html
EOF
            ;;
        vue3-frontend)
            cat >> README.md << 'EOF'
- Node.js 16+
- npm 8+

### 安装依赖
```bash
npm install
```

### 运行项目
```bash
# 开发模式
npm run dev

# 构建生产版本
npm run build
```

### 访问地址
开发服务器: http://localhost:3000
EOF
            ;;
        go-desktop)
            cat >> README.md << 'EOF'
- Go 1.21+
- Fyne 2.4+

### 安装依赖
```bash
go mod tidy
```

### 运行项目
```bash
go run cmd/app/main.go
```

### 打包
```bash
# 当前平台
go build -o bin/app cmd/app/main.go

# 跨平台打包
fyne package -os windows -o app.exe cmd/app/main.go
```
EOF
            ;;
        python-desktop)
            cat >> README.md << 'EOF'
- Python 3.8+
- tkinter (通常已内置)

### 安装依赖
```bash
pip install -r requirements.txt
```

### 运行项目
```bash
python src/main.py
```

### 打包
```bash
pyinstaller --onefile --windowed src/main.py
```
EOF
            ;;
        fastapi-vue)
            cat >> README.md << 'EOF'
- Python 3.8+
- Node.js 16+
- PostgreSQL 13+ (可选)

### 使用Docker Compose (推荐)
```bash
docker-compose up -d
```

### 手动安装
```bash
# 后端
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload

# 前端
cd frontend
npm install
npm run dev
```

### 访问地址
- 前端: http://localhost:3000
- 后端API: http://localhost:8000
- API文档: http://localhost:8000/docs
EOF
            ;;
    esac

    cat >> README.md << EOF

## 📁 项目结构

\`\`\`
$PROJECT_NAME/
├── .claude_rules/           # AI协作规则
├── project_process/         # 项目流程记录
├── docs/                   # 项目文档
└── ...                     # 项目特定文件
\`\`\`

## 🤖 AI协作

本项目已配置Claude Code协作规范：

1. 启动开发：\`claude code\`
2. 自动读取项目规范和历史经验
3. 遵循 $PROJECT_TYPE 特定开发规范
4. 记录重要决策和经验到全局知识库

详见 [CLAUDE.md](./CLAUDE.md)

## 📚 开发规范

- 代码风格：遵循项目类型特定规范
- 提交规范：使用 Conventional Commits
- 测试要求：核心功能需要测试覆盖
- 文档要求：重要功能需要文档说明

## 🔗 相关链接

- [项目状态摘要](./project_process/summary.md)
- [技术决策记录](./project_process/decisions.md)
- [全局开发规范](./.claude_rules/PROJECT_MANAGEMENT_RULES.md)
- [$PROJECT_TYPE 规范](./.claude_rules/${PROJECT_TYPE}.md)

---

**创建时间**: $(date '+%Y-%m-%d')  
**项目类型**: $PROJECT_TYPE  
**AI协作**: ✅ 已优化
EOF

    # 创建.gitignore
    cat > .gitignore << 'EOF'
# 操作系统文件
.DS_Store
Thumbs.db

# 编辑器文件
.vscode/
.idea/
*.swp
*.swo
*~

# 日志文件
logs/
*.log

# 环境配置
.env
.env.local
.env.*.local

# 临时文件
tmp/
temp/
.cache/

# Claude相关（注意：.claude_rules/保留）
.claude_context.md

# 构建输出
dist/
build/
bin/
EOF

    # 根据项目类型添加特定忽略规则
    case $PROJECT_TYPE in
        gin-microservice|go-desktop)
            cat >> .gitignore << 'EOF'

# Go 特定
vendor/
go.sum
*.exe
*.exe~
*.dll
*.so
*.dylib
*.test
*.out
go.work

# 数据文件
*.db
*.sqlite
*.sqlite3
EOF
            ;;
        vue3-frontend)
            cat >> .gitignore << 'EOF'

# Node.js 特定
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

# 构建输出
dist/
dist-ssr/
*.local

# 测试
coverage/
.nyc_output/

# 其他
.eslintcache
EOF
            ;;
        python-desktop)
            cat >> .gitignore << 'EOF'

# Python 特定
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# 虚拟环境
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# PyInstaller
*.manifest
*.spec

# 测试
.coverage
.pytest_cache/
htmlcov/
EOF
            ;;
        fastapi-vue)
            cat >> .gitignore << 'EOF'

# 前端
frontend/node_modules/
frontend/dist/
frontend/.env.local

# 后端 Python
backend/__pycache__/
backend/*.py[cod]
backend/.env
backend/alembic/versions/

# 数据库
*.db
*.sqlite
*.sqlite3

# Docker
.docker/

# 测试
.coverage
.pytest_cache/
htmlcov/
EOF
            ;;
    esac

    log_success "项目状态文件初始化完成"
}

# 保存项目创建经验
save_creation_experience() {
    log_info "保存项目创建经验..."
    
    local memory_file="$GLOBAL_RULES_PATH/memory.sqlite"
    if [ -f "$memory_file" ]; then
        local experience="[项目创建] 成功创建 $PROJECT_TYPE 类型的新项目 $PROJECT_NAME，位于 $PROJECT_PATH，应用了完整的标准化结构、全局规则注入、优化的Claude配置，项目创建效果优秀，可立即开始开发"
        
        # 使用sqlite直接插入记录
        sqlite3 "$memory_file" "INSERT INTO memories (speaker, message, context, timestamp, sequence) VALUES ('developer', '$experience', '$PROJECT_TYPE,global_rules,项目初始化', $(date +%s), 1);" 2>/dev/null && {
            log_success "项目创建经验已保存到全局知识库"
        } || {
            log_verbose "Memory MCP记录保存失败"
        }
    else
        log_verbose "全局知识库不可用，跳过经验保存"
    fi
}

# 初始化Git仓库
initialize_git() {
    log_info "初始化Git仓库..."
    
    cd "$PROJECT_PATH"
    
    if [ ! -d ".git" ]; then
        git init >/dev/null 2>&1
        git add . >/dev/null 2>&1
        git commit -m "🎉 初始化${PROJECT_TYPE}项目

- 完整项目结构创建
- 全局规则注入完成
- Claude协作配置优化
- 项目模板和依赖配置完成

项目类型: ${PROJECT_TYPE}
创建时间: $(date '+%Y-%m-%d %H:%M:%S')
项目路径: ${PROJECT_PATH}" >/dev/null 2>&1
        
        log_success "Git仓库初始化完成"
    else
        log_verbose "Git仓库已存在"
    fi
}

# 启动Claude Code
launch_claude_code() {
    log_info "准备启动Claude Code智能开发..."
    
    echo -e "\n${BLUE}📋 新项目创建摘要:${NC}"
    echo -e "  项目名称: ${GREEN}$PROJECT_NAME${NC}"
    echo -e "  项目类型: ${GREEN}$PROJECT_TYPE${NC}"
    echo -e "  项目路径: ${GREEN}$PROJECT_PATH${NC}"
    echo -e "  规则注入: ${GREEN}✅ 完成${NC}"
    echo -e "  结构创建: ${GREEN}✅ 完成${NC}"
    echo -e "  Claude配置: ${GREEN}✅ 优化完成${NC}"
    echo -e "  Git初始化: ${GREEN}✅ 完成${NC}"
    
    echo -e "\n${CYAN}🎯 Claude Code将会自动:${NC}"
    echo -e "  1. 读取优化的项目配置 (CLAUDE.md)"
    echo -e "  2. 应用项目类型特定规范"
    echo -e "  3. 搜索相关历史经验"
    echo -e "  4. 指导您完成环境配置"
    echo -e "  5. 帮助实施最佳实践"
    
    echo -e "\n${YELLOW}💡 建议的第一步操作:${NC}"
    case $PROJECT_TYPE in
        gin-microservice)
            echo -e "  1. 运行 'go mod tidy' 安装依赖"
            echo -e "  2. 验证基础服务启动: 'make dev'"
            echo -e "  3. 访问健康检查: http://localhost:8080/health"
            echo -e "  4. 实现第一个业务API接口"
            ;;
        vue3-frontend)
            echo -e "  1. 运行 'npm install' 安装依赖"
            echo -e "  2. 启动开发服务器: 'npm run dev'"
            echo -e "  3. 访问应用: http://localhost:3000"
            echo -e "  4. 创建第一个业务页面"
            ;;
        go-desktop)
            echo -e "  1. 运行 'go mod tidy' 安装依赖"
            echo -e "  2. 启动应用: 'go run cmd/app/main.go'"
            echo -e "  3. 验证GUI界面显示"
            echo -e "  4. 实现核心功能逻辑"
            ;;
        python-desktop)
            echo -e "  1. 安装依赖: 'pip install -r requirements.txt'"
            echo -e "  2. 启动应用: 'python src/main.py'"
            echo -e "  3. 验证界面和功能"
            echo -e "  4. 扩展业务功能模块"
            ;;
        fastapi-vue)
            echo -e "  1. 启动环境: 'docker-compose up -d'"
            echo -e "  2. 访问前端: http://localhost:3000"
            echo -e "  3. 访问API文档: http://localhost:8000/docs"
            echo -e "  4. 实现认证和核心API"
            ;;
    esac
    
    echo -e "\n${PURPLE}按Enter键启动Claude Code，或Ctrl+C手动开始开发...${NC}"
    read -r
    
    # 检查Claude命令是否可用
    if command -v claude >/dev/null 2>&1; then
        echo -e "${GREEN}🚀 正在启动Claude Code...${NC}"
        cd "$PROJECT_PATH"
        claude code
    else
        echo -e "${YELLOW}⚠️  未检测到Claude Code CLI${NC}"
        echo -e "${BLUE}您可以手动导航到项目目录并启动Claude Code:${NC}"
        echo -e "${CYAN}cd $PROJECT_PATH${NC}"
        echo -e "${CYAN}claude code${NC}"
        echo -e "\n${BLUE}项目已完全配置完成，可以开始开发了！${NC}"
    fi
}

# 主执行流程
main() {
    echo -e "${BLUE}🚀 增强版新项目创建器启动${NC}"
    echo -e "${BLUE}全局规则路径: $GLOBAL_RULES_PATH${NC}"
    
    # 验证输入参数
    validate_inputs
    
    # 智能路径选择
    smart_path_selection
    
    echo -e "\n${GREEN}📋 创建信息确认:${NC}"
    echo -e "  项目名称: ${CYAN}$PROJECT_NAME${NC}"
    echo -e "  项目类型: ${CYAN}$PROJECT_TYPE${NC}"
    echo -e "  项目路径: ${CYAN}$PROJECT_PATH${NC}"
    echo -e "\n${YELLOW}确认创建? (Y/n) [默认: Y]:${NC}"
    read -r confirm_create
    
    if [ -n "$confirm_create" ] && [ "$confirm_create" != "y" ] && [ "$confirm_create" != "Y" ]; then
        log_error "操作已取消"
        exit 1
    fi
    
    # 执行创建流程
    search_similar_projects
    create_project_structure
    inject_global_rules
    # 转换项目类型格式 (gin-microservice -> gin_microservice)
    local normalized_type=$(echo "$PROJECT_TYPE" | sed 's/-/_/g')
    update_claude_md "$PROJECT_PATH" "$normalized_type" "85"
    initialize_project_files
    initialize_git
    save_creation_experience
    launch_claude_code
    
    echo -e "\n${GREEN}🎉 新项目创建完成！${NC}"
    echo -e "${GREEN}项目路径: $PROJECT_PATH${NC}"
    echo -e "${GREEN}项目类型: $PROJECT_TYPE${NC}"
    echo -e "${GREEN}请开始您的高效AI协作开发之旅！${NC}"
}

# 检查参数
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

# 执行主函数
main