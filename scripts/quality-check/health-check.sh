#!/bin/bash

# 项目健康检查脚本
# 用于评估项目的健康状况，发现潜在问题和改进点
# 适用于70个项目的批量健康度评估

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
PROJECT_PATH=""
PROJECT_TYPE=""
HEALTH_SCORE=0
MAX_SCORE=100
CURRENT_DATE=$(date +"%Y-%m-%d")
REPORT_FILE=""
VERBOSE=false
FIX_ISSUES=false

# 检查结果数组
declare -a ISSUES=()
declare -a WARNINGS=()
declare -a RECOMMENDATIONS=()

# 打印函数
print_header() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    项目健康检查工具 v1.0                     ║"
    echo "║                                                              ║"
    echo "║  评估项目规范性、代码质量、文档完整性、安全性等指标           ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

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

print_score() {
    local score=$1
    if [ $score -ge 90 ]; then
        echo -e "${GREEN}🏆 健康度: $score/100 (优秀)${NC}"
    elif [ $score -ge 75 ]; then
        echo -e "${BLUE}🥈 健康度: $score/100 (良好)${NC}"
    elif [ $score -ge 60 ]; then
        echo -e "${YELLOW}🥉 健康度: $score/100 (一般)${NC}"
    else
        echo -e "${RED}🔴 健康度: $score/100 (需要改进)${NC}"
    fi
}

# 显示帮助信息
show_help() {
    echo -e "${CYAN}使用方法:${NC}"
    echo "  $0 [项目路径] [选项]"
    echo ""
    echo -e "${CYAN}选项:${NC}"
    echo "  -h, --help       显示帮助信息"
    echo "  -v, --verbose    详细输出"
    echo "  -f, --fix        自动修复可修复的问题"
    echo "  -r, --report     生成详细报告文件"
    echo "  -t, --type       指定项目类型 (auto/python-desktop/vue3-frontend/gin-microservice/go-desktop)"
    echo ""
    echo -e "${CYAN}示例:${NC}"
    echo "  $0 /path/to/project"
    echo "  $0 /path/to/project --verbose --fix"
    echo "  $0 . --type vue3-frontend --report"
}

# 解析命令行参数
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -f|--fix)
                FIX_ISSUES=true
                shift
                ;;
            -r|--report)
                REPORT_FILE="health_report_$(date +%Y%m%d_%H%M%S).md"
                shift
                ;;
            -t|--type)
                PROJECT_TYPE="$2"
                shift 2
                ;;
            -*)
                print_error "未知选项: $1"
                show_help
                exit 1
                ;;
            *)
                if [ -z "$PROJECT_PATH" ]; then
                    PROJECT_PATH="$1"
                else
                    print_error "只能指定一个项目路径"
                    exit 1
                fi
                shift
                ;;
        esac
    done

    # 默认为当前目录
    if [ -z "$PROJECT_PATH" ]; then
        PROJECT_PATH="$(pwd)"
    fi

    # 转换为绝对路径
    PROJECT_PATH="$(cd "$PROJECT_PATH" && pwd)"
}

# 检测项目类型
detect_project_type() {
    if [ "$PROJECT_TYPE" != "" ] && [ "$PROJECT_TYPE" != "auto" ]; then
        return
    fi

    print_info "检测项目类型..."

    if [ -f "$PROJECT_PATH/package.json" ] && [ -f "$PROJECT_PATH/vite.config.ts" ]; then
        PROJECT_TYPE="vue3-frontend"
    elif [ -f "$PROJECT_PATH/go.mod" ] && [ -d "$PROJECT_PATH/cmd" ]; then
        if grep -q "gin-gonic/gin" "$PROJECT_PATH/go.mod" 2>/dev/null; then
            PROJECT_TYPE="gin-microservice"
        else
            PROJECT_TYPE="go-desktop"
        fi
    elif [ -f "$PROJECT_PATH/requirements.txt" ] && [ -d "$PROJECT_PATH/src" ]; then
        PROJECT_TYPE="python-desktop"
    elif [ -f "$PROJECT_PATH/package.json" ] && [ -d "$PROJECT_PATH/backend" ] && [ -d "$PROJECT_PATH/frontend" ]; then
        PROJECT_TYPE="fastapi-vue"
    else
        PROJECT_TYPE="unknown"
    fi

    if [ "$PROJECT_TYPE" = "unknown" ]; then
        print_warning "无法自动检测项目类型，使用通用检查"
    else
        print_success "检测到项目类型: $PROJECT_TYPE"
    fi
}

# 基础项目结构检查
check_basic_structure() {
    print_info "检查基础项目结构..."
    local score=0

    # 检查必要文件
    local required_files=("README.md" ".gitignore")
    for file in "${required_files[@]}"; do
        if [ -f "$PROJECT_PATH/$file" ]; then
            score=$((score + 5))
            [ "$VERBOSE" = true ] && print_success "找到 $file"
        else
            ISSUES+=("缺少必要文件: $file")
            print_warning "缺少 $file"
        fi
    done

    # 检查Git仓库
    if [ -d "$PROJECT_PATH/.git" ]; then
        score=$((score + 10))
        [ "$VERBOSE" = true ] && print_success "Git仓库已初始化"
    else
        ISSUES+=("项目未初始化Git仓库")
        print_warning "未初始化Git仓库"
    fi

    # 检查CLAUDE.md
    if [ -f "$PROJECT_PATH/CLAUDE.md" ]; then
        score=$((score + 10))
        print_success "发现Claude Code操作指南"
    else
        RECOMMENDATIONS+=("建议添加CLAUDE.md文件以改善AI协作")
        print_warning "缺少CLAUDE.md文件"
    fi

    # 检查project_process目录
    if [ -d "$PROJECT_PATH/project_process" ]; then
        score=$((score + 10))
        print_success "发现项目过程记录目录"
    else
        RECOMMENDATIONS+=("建议创建project_process目录记录开发过程")
        print_warning "缺少project_process目录"
    fi

    # 检查.editorconfig
    if [ -f "$PROJECT_PATH/.editorconfig" ]; then
        score=$((score + 5))
        [ "$VERBOSE" = true ] && print_success "发现编辑器配置文件"
    else
        RECOMMENDATIONS+=("建议添加.editorconfig统一编辑器配置")
    fi

    HEALTH_SCORE=$((HEALTH_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "基础结构得分: $score/40"
}

# 检查代码质量
check_code_quality() {
    print_info "检查代码质量..."
    local score=0

    case $PROJECT_TYPE in
        "vue3-frontend")
            check_vue3_quality score
            ;;
        "gin-microservice"|"go-desktop")
            check_go_quality score
            ;;
        "python-desktop")
            check_python_quality score
            ;;
        *)
            check_general_quality score
            ;;
    esac

    HEALTH_SCORE=$((HEALTH_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "代码质量得分: $score/25"
}

# Vue3项目质量检查
check_vue3_quality() {
    local -n score_ref=$1

    # 检查package.json
    if [ -f "$PROJECT_PATH/package.json" ]; then
        score_ref=$((score_ref + 5))
        
        # 检查关键依赖
        if grep -q '"vue"' "$PROJECT_PATH/package.json"; then
            score_ref=$((score_ref + 5))
        fi
        
        if grep -q '"typescript"' "$PROJECT_PATH/package.json"; then
            score_ref=$((score_ref + 5))
            print_success "使用TypeScript"
        else
            RECOMMENDATIONS+=("建议使用TypeScript提高代码质量")
        fi
    fi

    # 检查配置文件
    if [ -f "$PROJECT_PATH/vite.config.ts" ]; then
        score_ref=$((score_ref + 5))
    fi

    if [ -f "$PROJECT_PATH/tsconfig.json" ]; then
        score_ref=$((score_ref + 5))
    fi
}

# Go项目质量检查
check_go_quality() {
    local -n score_ref=$1

    # 检查go.mod
    if [ -f "$PROJECT_PATH/go.mod" ]; then
        score_ref=$((score_ref + 5))
        
        # 检查Go版本
        local go_version=$(grep "^go " "$PROJECT_PATH/go.mod" | awk '{print $2}')
        if [ ! -z "$go_version" ]; then
            score_ref=$((score_ref + 5))
            [ "$VERBOSE" = true ] && print_success "Go版本: $go_version"
        fi
    fi

    # 检查标准目录结构
    if [ -d "$PROJECT_PATH/cmd" ]; then
        score_ref=$((score_ref + 5))
    fi

    if [ -d "$PROJECT_PATH/internal" ]; then
        score_ref=$((score_ref + 5))
    fi

    if [ -d "$PROJECT_PATH/pkg" ]; then
        score_ref=$((score_ref + 3))
    fi

    if [ -f "$PROJECT_PATH/Makefile" ]; then
        score_ref=$((score_ref + 2))
    fi
}

# Python项目质量检查
check_python_quality() {
    local -n score_ref=$1

    # 检查requirements.txt
    if [ -f "$PROJECT_PATH/requirements.txt" ]; then
        score_ref=$((score_ref + 5))
        [ "$VERBOSE" = true ] && print_success "发现依赖文件"
    fi

    # 检查虚拟环境配置
    if [ -f "$PROJECT_PATH/requirements-dev.txt" ]; then
        score_ref=$((score_ref + 3))
    fi

    # 检查标准目录结构
    if [ -d "$PROJECT_PATH/src" ]; then
        score_ref=$((score_ref + 5))
    fi

    if [ -d "$PROJECT_PATH/tests" ]; then
        score_ref=$((score_ref + 5))
    fi

    if [ -f "$PROJECT_PATH/Makefile" ]; then
        score_ref=$((score_ref + 3))
    fi

    # 检查入口文件
    if [ -f "$PROJECT_PATH/src/main.py" ]; then
        score_ref=$((score_ref + 4))
    fi
}

# 通用代码质量检查
check_general_quality() {
    local -n score_ref=$1

    # 检查是否有测试目录
    if [ -d "$PROJECT_PATH/tests" ] || [ -d "$PROJECT_PATH/test" ]; then
        score_ref=$((score_ref + 10))
        print_success "发现测试目录"
    else
        RECOMMENDATIONS+=("建议添加测试目录和测试用例")
    fi

    # 检查文档目录
    if [ -d "$PROJECT_PATH/docs" ]; then
        score_ref=$((score_ref + 5))
    fi

    # 检查构建配置
    if [ -f "$PROJECT_PATH/Makefile" ]; then
        score_ref=$((score_ref + 5))
    fi

    # 基础分数
    score_ref=$((score_ref + 5))
}

# 检查文档完整性
check_documentation() {
    print_info "检查文档完整性..."
    local score=0

    # 检查README.md内容
    if [ -f "$PROJECT_PATH/README.md" ]; then
        local readme_size=$(wc -c < "$PROJECT_PATH/README.md" 2>/dev/null || echo 0)
        if [ $readme_size -gt 500 ]; then
            score=$((score + 10))
            print_success "README.md内容充实"
        elif [ $readme_size -gt 100 ]; then
            score=$((score + 5))
            RECOMMENDATIONS+=("README.md内容可以更详细")
        else
            ISSUES+=("README.md内容过于简单")
        fi
    fi

    # 检查CLAUDE.md详细程度
    if [ -f "$PROJECT_PATH/CLAUDE.md" ]; then
        local claude_size=$(wc -c < "$PROJECT_PATH/CLAUDE.md" 2>/dev/null || echo 0)
        if [ $claude_size -gt 1000 ]; then
            score=$((score + 10))
            print_success "CLAUDE.md内容详细"
        elif [ $claude_size -gt 300 ]; then
            score=$((score + 5))
        else
            WARNINGS+=("CLAUDE.md内容可以更详细")
        fi
    fi

    # 检查项目过程记录
    if [ -d "$PROJECT_PATH/project_process" ]; then
        local daily_count=$(find "$PROJECT_PATH/project_process" -name "*.md" 2>/dev/null | wc -l)
        if [ $daily_count -gt 5 ]; then
            score=$((score + 10))
            print_success "项目过程记录丰富"
        elif [ $daily_count -gt 0 ]; then
            score=$((score + 5))
        fi
    fi

    HEALTH_SCORE=$((HEALTH_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "文档完整性得分: $score/30"
}

# 检查版本控制
check_version_control() {
    print_info "检查版本控制..."
    local score=0

    if [ ! -d "$PROJECT_PATH/.git" ]; then
        ISSUES+=("项目未使用Git版本控制")
        return
    fi

    # 检查提交历史
    cd "$PROJECT_PATH"
    local commit_count=$(git rev-list --all --count 2>/dev/null || echo 0)
    if [ $commit_count -gt 10 ]; then
        score=$((score + 5))
        print_success "有丰富的提交历史"
    elif [ $commit_count -gt 1 ]; then
        score=$((score + 3))
    fi

    # 检查最近提交时间
    local last_commit=$(git log -1 --format=%cd --date=short 2>/dev/null || echo "")
    if [ ! -z "$last_commit" ]; then
        local days_ago=$(( ($(date +%s) - $(date -d "$last_commit" +%s)) / 86400 ))
        if [ $days_ago -lt 30 ]; then
            score=$((score + 5))
            [ "$VERBOSE" = true ] && print_success "最近有活跃提交 ($days_ago 天前)"
        elif [ $days_ago -lt 90 ]; then
            score=$((score + 3))
            WARNINGS+=("项目较长时间未更新 ($days_ago 天前)")
        else
            WARNINGS+=("项目长时间未更新 ($days_ago 天前)")
        fi
    fi

    # 检查分支策略
    local branch_count=$(git branch -a 2>/dev/null | wc -l)
    if [ $branch_count -gt 1 ]; then
        score=$((score + 3))
    fi

    # 检查.gitignore质量
    if [ -f "$PROJECT_PATH/.gitignore" ]; then
        local gitignore_size=$(wc -l < "$PROJECT_PATH/.gitignore" 2>/dev/null || echo 0)
        if [ $gitignore_size -gt 20 ]; then
            score=$((score + 2))
            [ "$VERBOSE" = true ] && print_success ".gitignore配置详细"
        fi
    fi

    HEALTH_SCORE=$((HEALTH_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "版本控制得分: $score/15"
}

# 检查安全性
check_security() {
    print_info "检查安全性..."
    local score=5  # 基础分数

    # 检查敏感文件
    local sensitive_files=(".env" "config.local" "*.key" "*.pem")
    for pattern in "${sensitive_files[@]}"; do
        if find "$PROJECT_PATH" -name "$pattern" -type f 2>/dev/null | grep -q .; then
            if git check-ignore "$PROJECT_PATH/$pattern" >/dev/null 2>&1; then
                [ "$VERBOSE" = true ] && print_success "敏感文件 $pattern 已被忽略"
            else
                ISSUES+=("敏感文件 $pattern 可能未被正确忽略")
            fi
        fi
    done

    # 检查依赖安全性 (如果有的话)
    if [ -f "$PROJECT_PATH/package.json" ]; then
        if command -v npm >/dev/null 2>&1; then
            cd "$PROJECT_PATH"
            if npm audit --level=high 2>/dev/null | grep -q "0 vulnerabilities"; then
                score=$((score + 5))
                print_success "NPM依赖安全检查通过"
            else
                WARNINGS+=("NPM依赖存在安全漏洞，建议运行 npm audit fix")
            fi
        fi
    fi

    HEALTH_SCORE=$((HEALTH_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "安全性得分: $score/10"
}

# 自动修复问题
auto_fix_issues() {
    if [ "$FIX_ISSUES" != true ]; then
        return
    fi

    print_info "尝试自动修复问题..."
    local fixed_count=0

    # 创建基础文件
    if [ ! -f "$PROJECT_PATH/.gitignore" ]; then
        if [ -f "$SCRIPT_DIR/../templates/.gitignore" ]; then
            cp "$SCRIPT_DIR/../templates/.gitignore" "$PROJECT_PATH/"
            print_success "已创建.gitignore文件"
            fixed_count=$((fixed_count + 1))
        fi
    fi

    if [ ! -f "$PROJECT_PATH/.editorconfig" ]; then
        if [ -f "$SCRIPT_DIR/../templates/.editorconfig" ]; then
            cp "$SCRIPT_DIR/../templates/.editorconfig" "$PROJECT_PATH/"
            print_success "已创建.editorconfig文件"
            fixed_count=$((fixed_count + 1))
        fi
    fi

    # 创建基础目录
    if [ ! -d "$PROJECT_PATH/project_process" ]; then
        mkdir -p "$PROJECT_PATH/project_process/daily"
        mkdir -p "$PROJECT_PATH/project_process/weekly"
        mkdir -p "$PROJECT_PATH/project_process/monthly"
        print_success "已创建project_process目录结构"
        fixed_count=$((fixed_count + 1))
    fi

    if [ $fixed_count -gt 0 ]; then
        print_success "自动修复了 $fixed_count 个问题"
    else
        print_info "没有可自动修复的问题"
    fi
}

# 生成建议
generate_recommendations() {
    print_info "生成改进建议..."

    # 基于项目类型的特定建议
    case $PROJECT_TYPE in
        "vue3-frontend")
            if [ ! -f "$PROJECT_PATH/vite.config.ts" ]; then
                RECOMMENDATIONS+=("建议添加Vite配置文件优化构建")
            fi
            ;;
        "gin-microservice"|"go-desktop")
            if [ ! -f "$PROJECT_PATH/Makefile" ]; then
                RECOMMENDATIONS+=("建议添加Makefile统一构建命令")
            fi
            ;;
        "python-desktop")
            if [ ! -f "$PROJECT_PATH/requirements-dev.txt" ]; then
                RECOMMENDATIONS+=("建议添加开发依赖文件")
            fi
            ;;
    esac

    # 通用建议
    if [ ! -d "$PROJECT_PATH/.vscode" ]; then
        RECOMMENDATIONS+=("建议添加VSCode配置文件统一开发环境")
    fi

    if [ ! -f "$PROJECT_PATH/Makefile" ] && [ "$PROJECT_TYPE" != "unknown" ]; then
        RECOMMENDATIONS+=("建议添加Makefile提供统一的项目管理命令")
    fi
}

# 生成报告
generate_report() {
    if [ -z "$REPORT_FILE" ]; then
        return
    fi

    print_info "生成详细报告: $REPORT_FILE"

    cat > "$REPORT_FILE" << EOF
# 项目健康检查报告

**项目路径**: $PROJECT_PATH  
**项目类型**: $PROJECT_TYPE  
**检查时间**: $CURRENT_DATE  
**健康评分**: $HEALTH_SCORE/$MAX_SCORE

$(print_score $HEALTH_SCORE)

---

## 📊 检查结果概览

- **问题数量**: ${#ISSUES[@]}
- **警告数量**: ${#WARNINGS[@]}  
- **改进建议**: ${#RECOMMENDATIONS[@]}

---

## ❌ 发现的问题

EOF

    if [ ${#ISSUES[@]} -eq 0 ]; then
        echo "✅ 未发现严重问题" >> "$REPORT_FILE"
    else
        for issue in "${ISSUES[@]}"; do
            echo "- ❌ $issue" >> "$REPORT_FILE"
        done
    fi

    cat >> "$REPORT_FILE" << EOF

---

## ⚠️ 警告信息

EOF

    if [ ${#WARNINGS[@]} -eq 0 ]; then
        echo "✅ 无警告信息" >> "$REPORT_FILE"
    else
        for warning in "${WARNINGS[@]}"; do
            echo "- ⚠️ $warning" >> "$REPORT_FILE"
        done
    fi

    cat >> "$REPORT_FILE" << EOF

---

## 💡 改进建议

EOF

    if [ ${#RECOMMENDATIONS[@]} -eq 0 ]; then
        echo "✅ 项目状态良好，暂无改进建议" >> "$REPORT_FILE"
    else
        for rec in "${RECOMMENDATIONS[@]}"; do
            echo "- 💡 $rec" >> "$REPORT_FILE"
        done
    fi

    cat >> "$REPORT_FILE" << EOF

---

## 🎯 后续行动建议

### 立即处理 (高优先级)
$(for issue in "${ISSUES[@]}"; do echo "- [ ] $issue"; done)

### 计划改进 (中优先级)  
$(for warning in "${WARNINGS[@]}"; do echo "- [ ] $warning"; done)

### 优化建议 (低优先级)
$(for rec in "${RECOMMENDATIONS[@]}"; do echo "- [ ] $rec"; done)

---

**报告生成时间**: $(date)  
**生成工具**: Claude Code项目健康检查脚本 v1.0
EOF

    print_success "报告已生成: $REPORT_FILE"
}

# 显示总结
show_summary() {
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                     📊 健康检查总结                          ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    print_score $HEALTH_SCORE
    echo ""
    
    echo "📋 **检查详情**:"
    echo "  🏗️ 项目类型: $PROJECT_TYPE"
    echo "  📁 项目路径: $PROJECT_PATH"
    echo "  ❌ 发现问题: ${#ISSUES[@]} 个"
    echo "  ⚠️ 警告信息: ${#WARNINGS[@]} 个"
    echo "  💡 改进建议: ${#RECOMMENDATIONS[@]} 个"
    echo ""

    if [ ${#ISSUES[@]} -gt 0 ]; then
        echo "🔴 **需要立即处理的问题**:"
        for issue in "${ISSUES[@]}"; do
            echo "  - $issue"
        done
        echo ""
    fi

    if [ ${#WARNINGS[@]} -gt 0 ]; then
        echo "⚠️ **警告信息**:"
        for warning in "${WARNINGS[@]}"; do
            echo "  - $warning"
        done
        echo ""
    fi

    if [ ${#RECOMMENDATIONS[@]} -gt 0 ]; then
        echo "💡 **改进建议**:"
        for rec in "${RECOMMENDATIONS[@]}"; do
            echo "  - $rec"
        done
        echo ""
    fi

    # 给出总体评价
    if [ $HEALTH_SCORE -ge 90 ]; then
        echo -e "${GREEN}🏆 项目状况优秀！继续保持高质量的开发标准。${NC}"
    elif [ $HEALTH_SCORE -ge 75 ]; then
        echo -e "${BLUE}🥈 项目状况良好，有一些小的改进空间。${NC}"
    elif [ $HEALTH_SCORE -ge 60 ]; then
        echo -e "${YELLOW}🥉 项目状况一般，建议重点关注发现的问题。${NC}"
    else
        echo -e "${RED}🔴 项目需要重点改进，建议按优先级逐项解决问题。${NC}"
    fi

    if [ ! -z "$REPORT_FILE" ]; then
        echo ""
        echo "📄 详细报告已保存到: $REPORT_FILE"
    fi
}

# 主函数
main() {
    print_header
    
    # 解析参数
    parse_args "$@"
    
    print_info "开始检查项目: $PROJECT_PATH"
    
    # 检查项目是否存在
    if [ ! -d "$PROJECT_PATH" ]; then
        print_error "项目路径不存在: $PROJECT_PATH"
        exit 1
    fi
    
    # 执行检查步骤
    detect_project_type
    check_basic_structure
    check_code_quality  
    check_documentation
    check_version_control
    check_security
    
    # 生成建议和修复
    generate_recommendations
    auto_fix_issues
    
    # 生成报告和总结
    generate_report
    show_summary
    
    # 返回适当的退出码
    if [ $HEALTH_SCORE -ge 75 ]; then
        exit 0
    elif [ $HEALTH_SCORE -ge 50 ]; then
        exit 1
    else
        exit 2
    fi
}

# 执行主函数
main "$@"