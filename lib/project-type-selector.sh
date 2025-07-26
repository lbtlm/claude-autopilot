#!/bin/bash

# 项目类型选择工具
# 功能：提供交互式项目类型选择界面
# 版本：2.0.0

# 项目类型定义
declare -A PROJECT_TYPES=(
    ["1"]="gin-microservice"
    ["2"]="gin-vue3"
    ["3"]="go-desktop"
    ["4"]="go-general"
    ["5"]="vue3-frontend"
    ["6"]="vue2-frontend"
    ["7"]="react-frontend"
    ["8"]="nextjs-frontend"
    ["9"]="nodejs-general"
    ["10"]="python-desktop"
    ["11"]="django"
    ["12"]="python-general"
    ["13"]="fastapi_vue3"
    ["14"]="bash-scripts"
    ["15"]="java-maven"
    ["16"]="java-gradle"
    ["17"]="rust-project"
    ["18"]="php-project"
)

declare -A PROJECT_DESCRIPTIONS=(
    ["gin-microservice"]="Go + Gin微服务"
    ["gin-vue3"]="Go + Gin + Vue3全栈"
    ["go-desktop"]="Go桌面应用"
    ["go-general"]="Go通用项目"
    ["vue3-frontend"]="Vue3前端项目"
    ["vue2-frontend"]="Vue2前端项目"
    ["react-frontend"]="React前端项目"
    ["nextjs-frontend"]="Next.js前端项目"
    ["nodejs-general"]="Node.js通用项目"
    ["python-desktop"]="Python桌面应用"
    ["django"]="Django Web应用"
    ["python-general"]="Python通用项目"
    ["fastapi_vue3"]="FastAPI + Vue3全栈"
    ["bash-scripts"]="Bash脚本项目"
    ["java-maven"]="Java Maven项目"
    ["java-gradle"]="Java Gradle项目"
    ["rust-project"]="Rust项目"
    ["php-project"]="PHP项目"
)

# 显示项目类型菜单
show_project_type_menu() {
    echo "📋 请选择项目类型："
    echo "     1) gin-microservice    (Go + Gin微服务)"
    echo "     2) gin-vue3           (Go + Gin + Vue3全栈)"
    echo "     3) go-desktop         (Go桌面应用)"
    echo "     4) go-general         (Go通用项目)"
    echo "     5) vue3-frontend      (Vue3前端项目)"
    echo "     6) vue2-frontend      (Vue2前端项目)"
    echo "     7) react-frontend     (React前端项目)"
    echo "     8) nextjs-frontend    (Next.js前端项目)"
    echo "     9) nodejs-general     (Node.js通用项目)"
    echo "    10) python-desktop     (Python桌面应用)"
    echo "    11) django             (Django Web应用)"
    echo "    12) python-general     (Python通用项目)"
    echo "    13) fastapi_vue3       (FastAPI + Vue3全栈)"
    echo "    14) bash-scripts       (Bash脚本项目)"
    echo "    15) java-maven         (Java Maven项目)"
    echo "    16) java-gradle        (Java Gradle项目)"
    echo "    17) rust-project       (Rust项目)"
    echo "    18) php-project        (PHP项目)"
    echo ""
}

# 验证项目类型有效性
validate_project_type() {
    local type="$1"
    local valid_types="gin-microservice gin-vue3 go-desktop go-general vue3-frontend vue2-frontend react-frontend nextjs-frontend nodejs-general python-desktop django python-general fastapi_vue3 bash-scripts java-maven java-gradle rust-project php-project"
    
    if echo "$valid_types" | grep -wq "$type"; then
        return 0  # 有效
    else
        return 1  # 无效
    fi
}

# 获取项目类型描述
get_project_type_description() {
    local type="$1"
    echo "${PROJECT_DESCRIPTIONS[$type]}"
}

# 交互式选择项目类型
select_project_type_interactive() {
    local max_attempts=3
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
    show_project_type_menu
    read -p "请输入选项编号 (1-18): " choice
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le 18 ]; then
            local project_type="${PROJECT_TYPES[$choice]}"
            echo "✅ 已选择项目类型: $project_type (${PROJECT_DESCRIPTIONS[$project_type]})"
            echo "$project_type"
            return 0
        else
            echo "❌ 无效选择: $choice"
            attempt=$((attempt + 1))
            if [ $attempt -le $max_attempts ]; then
                echo "   剩余尝试次数: $((max_attempts - attempt + 1))"
                echo ""
            fi
        fi
    done
    
    echo "❌ 超过最大尝试次数，退出选择"
    return 1
}

# 主函数
main() {
    case "${1:-}" in
        "--interactive"|"-i")
            select_project_type_interactive
            ;;
        "--validate"|"-v")
            if [ -z "$2" ]; then
                echo "❌ 错误: 缺少项目类型参数"
                echo "用法: $0 --validate <项目类型>"
                exit 1
            fi
            if validate_project_type "$2"; then
                echo "✅ 项目类型有效: $2"
                exit 0
            else
                echo "❌ 项目类型无效: $2"
                exit 1
            fi
            ;;
        "--description"|"-d")
            if [ -z "$2" ]; then
                echo "❌ 错误: 缺少项目类型参数"
                echo "用法: $0 --description <项目类型>"
                exit 1
            fi
            description=$(get_project_type_description "$2")
            if [ -n "$description" ]; then
                echo "$description"
            else
                echo "❌ 未知项目类型: $2"
                exit 1
            fi
            ;;
        "--list"|"-l")
            echo "🏷️ 支持的项目类型："
            for key in $(echo "${!PROJECT_TYPES[@]}" | tr ' ' '\n' | sort -n); do
                type="${PROJECT_TYPES[$key]}"
                desc="${PROJECT_DESCRIPTIONS[$type]}"
                printf "   %-18s - %s\n" "$type" "$desc"
            done
            ;;
        "--help"|"-h"|"")
            echo "📖 项目类型选择工具"
            echo ""
            echo "用法："
            echo "   $0 --interactive     交互式选择项目类型"
            echo "   $0 --validate <type> 验证项目类型有效性"
            echo "   $0 --description <type> 获取项目类型描述"
            echo "   $0 --list           列出所有支持的项目类型"
            echo "   $0 --help           显示此帮助信息"
            echo ""
            echo "别名："
            echo "   -i  --interactive"
            echo "   -v  --validate"
            echo "   -d  --description"
            echo "   -l  --list"
            echo "   -h  --help"
            ;;
        *)
            echo "❌ 未知选项: $1"
            echo "使用 $0 --help 查看帮助信息"
            exit 1
            ;;
    esac
}

# 仅在直接执行时运行主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi