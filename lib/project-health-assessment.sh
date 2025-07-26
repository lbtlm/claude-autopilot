#!/bin/bash

# Claude Autopilot 2.1 项目健康度评估系统
# 基于全局规则评估项目的健康状况

# 动态检测路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载跨平台工具函数
source "$SCRIPT_DIR/cross-platform-utils.sh"
GLOBAL_CE_PATH="$(dirname "$SCRIPT_DIR")"
HEALTH_SCORE=0
TOTAL_CHECKS=0
ISSUES_FOUND=()
RECOMMENDATIONS=()

# 项目健康度评估主函数
assess_project_health() {
    local project_path="$1"
    local project_type="$2"
    
    echo "🏥 开始项目健康度评估..." >&2
    echo "📂 项目路径: $project_path" >&2
    echo "🏷️ 项目类型: $project_type" >&2
    echo "" >&2
    
    # 重置评估变量
    HEALTH_SCORE=0
    TOTAL_CHECKS=0
    ISSUES_FOUND=()
    RECOMMENDATIONS=()
    
    # 执行各项检查
    check_mandatory_files "$project_path"
    check_mandatory_directories "$project_path"
    check_git_repository "$project_path"
    check_security_configuration "$project_path"
    check_code_quality_setup "$project_path" "$project_type"
    check_documentation_completeness "$project_path"
    check_development_environment "$project_path" "$project_type"
    
    # 计算总体健康评分
    local health_percentage=0
    if [ $TOTAL_CHECKS -gt 0 ]; then
        health_percentage=$((HEALTH_SCORE * 100 / TOTAL_CHECKS))
    fi
    
    # 生成健康度报告（输出到stderr避免干扰函数返回值）
    generate_health_report "$project_path" "$project_type" "$health_percentage" >&2
    
    # 输出百分比到stdout，供调用者获取
    echo "$health_percentage"
}

# 检查必须文件
check_mandatory_files() {
    local project_path="$1"
    echo "📄 检查必须文件..."
    
    local mandatory_files=(
        "CLAUDE.md"
        ".editorconfig"
        ".gitignore"
        ".env.example"
        "README.md"
    )
    
    for file in "${mandatory_files[@]}"; do
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        if [ -f "$project_path/$file" ]; then
            HEALTH_SCORE=$((HEALTH_SCORE + 1))
            echo "   ✅ $file"
        else
            echo "   ❌ 缺失: $file"
            ISSUES_FOUND+=("缺失必须文件: $file")
            RECOMMENDATIONS+=("创建 $file 文件")
        fi
    done
}

# 检查必须目录
check_mandatory_directories() {
    local project_path="$1"
    echo "📁 检查必须目录..."
    
    local mandatory_dirs=(
        "project_process"
        "project_process/daily"
        "project_docs"
    )
    
    for dir in "${mandatory_dirs[@]}"; do
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        if [ -d "$project_path/$dir" ]; then
            HEALTH_SCORE=$((HEALTH_SCORE + 1))
            echo "   ✅ $dir/"
        else
            echo "   ❌ 缺失: $dir/"
            ISSUES_FOUND+=("缺失必须目录: $dir/")
            RECOMMENDATIONS+=("创建 $dir/ 目录")
        fi
    done
}

# 检查Git仓库状态
check_git_repository() {
    local project_path="$1"
    echo "🔄 检查Git仓库..."
    
    pushd "$project_path" > /dev/null 2>&1
    
    # 检查是否为Git仓库
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if git rev-parse --git-dir > /dev/null 2>&1; then
        HEALTH_SCORE=$((HEALTH_SCORE + 1))
        echo "   ✅ Git仓库已初始化"
        
        # 检查是否有远程仓库
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        if git remote -v | grep -q origin; then
            HEALTH_SCORE=$((HEALTH_SCORE + 1))
            echo "   ✅ 远程仓库已配置"
        else
            echo "   ⚠️  未配置远程仓库"
            RECOMMENDATIONS+=("配置远程Git仓库")
        fi
        
        # 检查.gitignore
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        if [ -f ".gitignore" ]; then
            local gitignore_completeness=$(check_gitignore_completeness)
            if [ "$gitignore_completeness" -gt 80 ]; then
                HEALTH_SCORE=$((HEALTH_SCORE + 1))
                echo "   ✅ .gitignore规则完整"
            else
                echo "   ⚠️  .gitignore规则不够完整 ($gitignore_completeness%)"
                RECOMMENDATIONS+=("完善.gitignore规则")
            fi
        else
            echo "   ❌ 缺失.gitignore"
            ISSUES_FOUND+=("缺失.gitignore文件")
        fi
    else
        echo "   ❌ 未初始化Git仓库"
        ISSUES_FOUND+=("未初始化Git仓库")
        RECOMMENDATIONS+=("初始化Git仓库: git init")
    fi
    
    popd > /dev/null 2>&1
}

# 检查安全配置
check_security_configuration() {
    local project_path="$1"
    echo "🔒 检查安全配置..."
    
    # 检查.env.example
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [ -f "$project_path/.env.example" ]; then
        HEALTH_SCORE=$((HEALTH_SCORE + 1))
        echo "   ✅ .env.example存在"
        
        # 检查关键环境变量
        local required_env_vars=("DATABASE_URL" "JWT_SECRET" "API_KEY")
        for var in "${required_env_vars[@]}"; do
            if grep -q "$var" "$project_path/.env.example"; then
                echo "   ✅ 包含环境变量模板: $var"
            else
                echo "   ⚠️  缺少环境变量模板: $var"
                RECOMMENDATIONS+=("在.env.example中添加 $var 模板")
            fi
        done
    else
        echo "   ❌ 缺失.env.example"
        ISSUES_FOUND+=("缺失.env.example文件")
    fi
    
    # 检查.env是否被错误提交
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [ -f "$project_path/.env" ]; then
        pushd "$project_path" > /dev/null 2>&1
        if git check-ignore ".env" > /dev/null 2>&1; then
            HEALTH_SCORE=$((HEALTH_SCORE + 1))
            echo "   ✅ .env文件被正确忽略"
        else
            echo "   🚨 .env文件未被忽略，存在安全风险！"
            ISSUES_FOUND+=("严重安全风险: .env文件未被Git忽略")
            RECOMMENDATIONS+=("立即在.gitignore中添加.env")
        fi
        popd > /dev/null 2>&1
    else
        HEALTH_SCORE=$((HEALTH_SCORE + 1))
        echo "   ✅ 无.env文件泄露风险"
    fi
    
    # 扫描硬编码密钥
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    local hardcoded_secrets=$(find "$project_path" -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.go" -o -name "*.java" 2>/dev/null | \
        xargs grep -l -E "(password|secret|key|token).*=.*['\"][^'\"]{8,}['\"]" 2>/dev/null | \
        grep -v ".env.example" | wc -l)
    
    if [ "$hardcoded_secrets" -eq 0 ]; then
        HEALTH_SCORE=$((HEALTH_SCORE + 1))
        echo "   ✅ 未发现硬编码密钥"
    else
        echo "   🚨 发现 $hardcoded_secrets 个文件包含硬编码密钥！"
        ISSUES_FOUND+=("严重安全风险: 发现硬编码密钥")
        RECOMMENDATIONS+=("移除硬编码密钥，使用环境变量")
    fi
}

# 检查代码质量设置
check_code_quality_setup() {
    local project_path="$1"
    local project_type="$2"
    echo "⚙️ 检查代码质量设置..."
    
    # 检查构建配置文件
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    local build_config_exists=false
    local build_files=("Makefile" "package.json" "pyproject.toml" "go.mod" "pom.xml" "build.gradle")
    
    for build_file in "${build_files[@]}"; do
        if [ -f "$project_path/$build_file" ]; then
            build_config_exists=true
            echo "   ✅ 发现构建配置: $build_file"
            break
        fi
    done
    
    if [ "$build_config_exists" = true ]; then
        HEALTH_SCORE=$((HEALTH_SCORE + 1))
        
        pushd "$project_path" > /dev/null 2>&1
        
        # 检查make命令可用性
        if command -v make > /dev/null 2>&1; then
            # 检查lint命令
            TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
            if make --dry-run lint > /dev/null 2>&1; then
                HEALTH_SCORE=$((HEALTH_SCORE + 1))
                echo "   ✅ make lint 命令可用"
            else
                echo "   ❌ make lint 命令不可用"
                RECOMMENDATIONS+=("配置 make lint 命令")
            fi
            
            # 检查test命令
            TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
            if make --dry-run test > /dev/null 2>&1; then
                HEALTH_SCORE=$((HEALTH_SCORE + 1))
                echo "   ✅ make test 命令可用"
            else
                echo "   ❌ make test 命令不可用"
                RECOMMENDATIONS+=("配置 make test 命令")
            fi
        fi
        
        popd > /dev/null 2>&1
    else
        echo "   ❌ 缺失构建配置文件"
        ISSUES_FOUND+=("缺失构建配置文件")
        RECOMMENDATIONS+=("创建适合 $project_type 的构建配置")
    fi
    
    # 检查.editorconfig
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [ -f "$project_path/.editorconfig" ]; then
        HEALTH_SCORE=$((HEALTH_SCORE + 1))
        echo "   ✅ .editorconfig存在"
    else
        echo "   ❌ 缺失.editorconfig"
        RECOMMENDATIONS+=("创建.editorconfig文件")
    fi
}

# 检查文档完整性
check_documentation_completeness() {
    local project_path="$1"
    echo "📚 检查文档完整性..."
    
    # 检查README.md质量
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [ -f "$project_path/README.md" ]; then
        local readme_size=$(wc -c < "$project_path/README.md")
        if [ "$readme_size" -gt 500 ]; then
            HEALTH_SCORE=$((HEALTH_SCORE + 1))
            echo "   ✅ README.md内容充实"
        else
            echo "   ⚠️  README.md内容过少"
            RECOMMENDATIONS+=("丰富README.md内容")
        fi
    else
        echo "   ❌ 缺失README.md"
        ISSUES_FOUND+=("缺失README.md文件")
    fi
    
    # 检查project_docs目录下的文档
    local doc_files=("API.md" "DATABASE.md" "DEPLOYMENT.md" "CHANGELOG.md")
    for doc_file in "${doc_files[@]}"; do
        TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
        if [ -f "$project_path/project_docs/$doc_file" ]; then
            HEALTH_SCORE=$((HEALTH_SCORE + 1))
            echo "   ✅ $doc_file存在"
        else
            echo "   ⚠️  缺失project_docs/$doc_file"
            RECOMMENDATIONS+=("创建project_docs/$doc_file文档")
        fi
    done
}

# 检查开发环境
check_development_environment() {
    local project_path="$1"
    local project_type="$2"
    echo "🔧 检查开发环境..."
    
    # 检查依赖安装状态
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    pushd "$project_path" > /dev/null 2>&1
    
    case "$project_type" in
        *"nodejs"*|*"vue"*|*"react"*)
            if [ -d "node_modules" ]; then
                HEALTH_SCORE=$((HEALTH_SCORE + 1))
                echo "   ✅ Node.js依赖已安装"
            else
                echo "   ⚠️  Node.js依赖未安装"
                RECOMMENDATIONS+=("运行 npm install 安装依赖")
            fi
            ;;
        *"python"*)
            if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
                HEALTH_SCORE=$((HEALTH_SCORE + 1))
                echo "   ✅ Python依赖配置文件存在"
            else
                echo "   ⚠️  缺少Python依赖配置"
                RECOMMENDATIONS+=("创建requirements.txt或pyproject.toml")
            fi
            ;;
        *"go"*)
            if [ -f "go.sum" ]; then
                HEALTH_SCORE=$((HEALTH_SCORE + 1))
                echo "   ✅ Go依赖已锁定"
            else
                echo "   ⚠️  Go依赖未锁定"
                RECOMMENDATIONS+=("运行 go mod tidy 锁定依赖")
            fi
            ;;
    esac
    
    popd > /dev/null 2>&1
}

# 检查.gitignore完整性
check_gitignore_completeness() {
    local common_patterns=(
        "node_modules"
        ".env"
        "*.log"
        ".DS_Store"
        "dist/"
        "build/"
        "__pycache__"
        ".pytest_cache"
        ".coverage"
        "*.pyc"
        ".idea/"
        ".vscode/settings.json"
        "Thumbs.db"
    )
    
    local found_patterns=0
    local total_patterns=${#common_patterns[@]}
    
    for pattern in "${common_patterns[@]}"; do
        if grep -q "$pattern" .gitignore 2>/dev/null; then
            found_patterns=$((found_patterns + 1))
        fi
    done
    
    echo $((found_patterns * 100 / total_patterns))
}

# 生成健康度报告
generate_health_report() {
    local project_path="$1"
    local project_type="$2"
    local health_percentage="$3"
    
    echo ""
    echo "📊 项目健康度报告"
    echo "=================================="
    echo "🏷️ 项目类型: $project_type"
    echo "🏥 健康评分: $health_percentage% ($HEALTH_SCORE/$TOTAL_CHECKS)"
    
    # 健康等级
    local health_grade=""
    local health_emoji=""
    if [ "$health_percentage" -ge 90 ]; then
        health_grade="优秀 (A)"
        health_emoji="🟢"
    elif [ "$health_percentage" -ge 80 ]; then
        health_grade="良好 (B)"
        health_emoji="🟡"
    elif [ "$health_percentage" -ge 70 ]; then
        health_grade="一般 (C)"
        health_emoji="🟠"
    elif [ "$health_percentage" -ge 60 ]; then
        health_grade="较差 (D)"
        health_emoji="🔴"
    else
        health_grade="危险 (F)"
        health_emoji="🚨"
    fi
    
    echo "📈 健康等级: $health_emoji $health_grade"
    echo ""
    
    # 发现的问题
    if [ ${#ISSUES_FOUND[@]} -gt 0 ]; then
        echo "🚨 发现的问题:"
        for issue in "${ISSUES_FOUND[@]}"; do
            echo "   • $issue"
        done
        echo ""
    fi
    
    # 改进建议
    if [ ${#RECOMMENDATIONS[@]} -gt 0 ]; then
        echo "💡 改进建议:"
        for recommendation in "${RECOMMENDATIONS[@]}"; do
            echo "   • $recommendation"
        done
        echo ""
    fi
    
    # 生成健康度报告文件
    mkdir -p "$project_path/project_process"
    local report_file="$project_path/project_process/health-assessment-$(date +%Y%m%d-%H%M%S).md"
    cat > "$report_file" << EOF
# 项目健康度评估报告
*生成时间: $(date '+%Y-%m-%d %H:%M:%S')*

## 📊 评估结果
- **项目类型**: $project_type
- **健康评分**: $health_percentage% ($HEALTH_SCORE/$TOTAL_CHECKS)
- **健康等级**: $health_emoji $health_grade

## 🚨 发现的问题
EOF

    if [ ${#ISSUES_FOUND[@]} -gt 0 ]; then
        for issue in "${ISSUES_FOUND[@]}"; do
            echo "- $issue" >> "$report_file"
        done
    else
        echo "- 无重大问题发现" >> "$report_file"
    fi
    
    cat >> "$report_file" << EOF

## 💡 改进建议
EOF

    if [ ${#RECOMMENDATIONS[@]} -gt 0 ]; then
        for recommendation in "${RECOMMENDATIONS[@]}"; do
            echo "- $recommendation" >> "$report_file"
        done
    else
        echo "- 项目健康状况良好，无需改进" >> "$report_file"
    fi
    
    cat >> "$report_file" << EOF

## 📈 健康度趋势
本次评估为首次记录，建议定期进行健康度评估以跟踪项目改进趋势。

---
*本报告由Claude Autopilot 2.1健康度评估系统生成*
EOF

    echo "📄 健康度报告已保存到: $report_file"
}

# 主函数 - 如果直接执行此脚本
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    if [ -z "$1" ]; then
        echo "使用: $0 <project_path> [project_type]"
        echo "示例: $0 /path/to/project nodejs-general"
        exit 1
    fi
    
    PROJECT_PATH=$(get_realpath "$1")
    PROJECT_TYPE="${2:-unknown}"
    
    assess_project_health "$PROJECT_PATH" "$PROJECT_TYPE"
    exit $?
fi