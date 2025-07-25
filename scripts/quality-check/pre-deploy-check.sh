#!/bin/bash

# 部署前检查脚本
# 在部署到生产环境前执行全面的安全、质量和配置检查
# 确保项目符合部署标准，避免生产环境问题

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
ENVIRONMENT="production"
CHECK_SCORE=0
MAX_SCORE=100
BLOCKING_ISSUES=0
WARNINGS=0
FORCE_DEPLOY=false
SKIP_TESTS=false
VERBOSE=false

# 检查结果数组
declare -a CRITICAL_ISSUES=()
declare -a BLOCKING_ISSUES_LIST=()
declare -a WARNING_ISSUES=()
declare -a SECURITY_ISSUES=()

# 打印函数
print_header() {
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                   🚀 部署前检查工具 v1.0                    ║"
    echo "║                                                              ║"
    echo "║  确保项目满足生产环境部署标准，避免部署后问题                 ║"
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
    WARNINGS=$((WARNINGS + 1))
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
    BLOCKING_ISSUES=$((BLOCKING_ISSUES + 1))
}

print_critical() {
    echo -e "${RED}🚨 严重: $1${NC}"
    BLOCKING_ISSUES=$((BLOCKING_ISSUES + 1))
}

# 显示帮助信息
show_help() {
    echo -e "${CYAN}使用方法:${NC}"
    echo "  $0 [项目路径] [选项]"
    echo ""
    echo -e "${CYAN}选项:${NC}"
    echo "  -h, --help       显示帮助信息"
    echo "  -e, --env        目标环境 (staging/production) [默认: production]"
    echo "  -f, --force      强制部署 (忽略非关键问题)"
    echo "  -s, --skip-tests 跳过测试检查"
    echo "  -v, --verbose    详细输出"
    echo "  -t, --type       指定项目类型 (auto/vue3-frontend/gin-microservice/go-desktop/python-desktop)"
    echo ""
    echo -e "${CYAN}示例:${NC}"
    echo "  $0 /path/to/project"
    echo "  $0 . --env staging"
    echo "  $0 /path/to/project --force --verbose"
}

# 解析命令行参数
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -e|--env)
                ENVIRONMENT="$2"
                shift 2
                ;;
            -f|--force)
                FORCE_DEPLOY=true
                shift
                ;;
            -s|--skip-tests)
                SKIP_TESTS=true
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
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
    else
        PROJECT_TYPE="unknown"
        print_warning "无法自动检测项目类型，使用通用检查"
        return
    fi

    print_success "检测到项目类型: $PROJECT_TYPE"
}

# 检查代码仓库状态
check_repository_status() {
    print_info "检查代码仓库状态..."
    local score=0

    if [ ! -d "$PROJECT_PATH/.git" ]; then
        print_critical "项目未使用Git版本控制"
        CRITICAL_ISSUES+=("项目必须使用Git版本控制")
        return
    fi

    cd "$PROJECT_PATH"

    # 检查是否有未提交的更改
    if ! git diff-index --quiet HEAD --; then
        print_error "存在未提交的更改，请先提交或暂存"
        BLOCKING_ISSUES_LIST+=("存在未提交的更改")
    else
        score=$((score + 10))
        print_success "工作区干净"
    fi

    # 检查是否有未跟踪的文件
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        print_warning "存在未跟踪的文件"
        WARNING_ISSUES+=("存在未跟踪的文件，确认是否需要添加到版本控制")
    else
        score=$((score + 5))
    fi

    # 检查当前分支
    local current_branch=$(git branch --show-current)
    if [ "$current_branch" = "main" ] || [ "$current_branch" = "master" ]; then
        if [ "$ENVIRONMENT" = "production" ]; then
            score=$((score + 10))
            print_success "当前在主分支 ($current_branch)"
        else
            print_warning "在主分支部署到 $ENVIRONMENT 环境"
        fi
    else
        if [ "$ENVIRONMENT" = "production" ]; then
            print_error "生产环境部署必须从主分支进行"
            BLOCKING_ISSUES_LIST+=("生产环境部署必须从主分支进行")
        else
            score=$((score + 5))
            print_info "当前分支: $current_branch"
        fi
    fi

    # 检查最近提交时间
    local last_commit_time=$(git log -1 --format=%ct)
    local current_time=$(date +%s)
    local hours_since_commit=$(( (current_time - last_commit_time) / 3600 ))
    
    if [ $hours_since_commit -lt 24 ]; then
        score=$((score + 5))
        [ "$VERBOSE" = true ] && print_success "最近有提交活动 ($hours_since_commit 小时前)"
    elif [ $hours_since_commit -gt 168 ]; then  # 一周
        print_warning "最后提交时间较久 ($((hours_since_commit / 24)) 天前)"
    fi

    CHECK_SCORE=$((CHECK_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "仓库状态得分: $score/30"
}

# 检查构建配置
check_build_configuration() {
    print_info "检查构建配置..."
    local score=0

    case $PROJECT_TYPE in
        "vue3-frontend")
            check_vue3_build_config score
            ;;
        "gin-microservice"|"go-desktop")
            check_go_build_config score
            ;;
        "python-desktop")
            check_python_build_config score
            ;;
        *)
            print_warning "未知项目类型，跳过构建配置检查"
            score=10  # 基础分数
            ;;
    esac

    CHECK_SCORE=$((CHECK_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "构建配置得分: $score/20"
}

# Vue3项目构建检查
check_vue3_build_config() {
    local -n score_ref=$1

    # 检查package.json
    if [ ! -f "$PROJECT_PATH/package.json" ]; then
        print_critical "缺少package.json文件"
        CRITICAL_ISSUES+=("Vue3项目必须有package.json文件")
        return
    fi

    # 检查构建脚本
    if grep -q '"build"' "$PROJECT_PATH/package.json"; then
        score_ref=$((score_ref + 5))
        print_success "发现构建脚本"
    else
        print_error "package.json中缺少build脚本"
        BLOCKING_ISSUES_LIST+=("必须定义build脚本")
    fi

    # 检查Vite配置
    if [ -f "$PROJECT_PATH/vite.config.ts" ]; then
        score_ref=$((score_ref + 5))
        
        # 检查生产环境配置
        if grep -q "build:" "$PROJECT_PATH/vite.config.ts"; then
            score_ref=$((score_ref + 5))
        fi
    else
        print_warning "缺少vite.config.ts配置文件"
    fi

    # 检查环境变量配置
    if [ -f "$PROJECT_PATH/.env.production" ]; then
        score_ref=$((score_ref + 5))
        print_success "发现生产环境配置"
    else
        print_warning "建议添加.env.production配置文件"
    fi
}

# Go项目构建检查
check_go_build_config() {
    local -n score_ref=$1

    # 检查go.mod
    if [ ! -f "$PROJECT_PATH/go.mod" ]; then
        print_critical "缺少go.mod文件"
        CRITICAL_ISSUES+=("Go项目必须有go.mod文件")
        return
    fi

    score_ref=$((score_ref + 5))

    # 检查Makefile
    if [ -f "$PROJECT_PATH/Makefile" ]; then
        score_ref=$((score_ref + 5))
        
        # 检查构建目标
        if grep -q "build:" "$PROJECT_PATH/Makefile"; then
            score_ref=$((score_ref + 5))
        fi
    else
        print_warning "建议添加Makefile简化构建过程"
    fi

    # 检查Dockerfile
    if [ -f "$PROJECT_PATH/Dockerfile" ] || [ -f "$PROJECT_PATH/deployments/docker/Dockerfile" ]; then
        score_ref=$((score_ref + 5))
        print_success "发现Docker配置"
    else
        print_warning "建议添加Dockerfile支持容器化部署"
    fi
}

# Python项目构建检查
check_python_build_config() {
    local -n score_ref=$1

    # 检查requirements.txt
    if [ ! -f "$PROJECT_PATH/requirements.txt" ]; then
        print_critical "缺少requirements.txt文件"
        CRITICAL_ISSUES+=("Python项目必须有requirements.txt文件")
        return
    fi

    score_ref=$((score_ref + 5))

    # 检查构建脚本
    if [ -f "$PROJECT_PATH/setup.py" ]; then
        score_ref=$((score_ref + 5))
    fi

    if [ -f "$PROJECT_PATH/pyproject.toml" ]; then
        score_ref=$((score_ref + 5))
    fi

    # 检查打包配置
    if [ -f "$PROJECT_PATH/build.spec" ]; then
        score_ref=$((score_ref + 5))
        print_success "发现PyInstaller配置"
    else
        print_warning "建议添加PyInstaller配置用于打包"
    fi
}

# 运行测试
run_tests() {
    if [ "$SKIP_TESTS" = true ]; then
        print_info "跳过测试检查"
        CHECK_SCORE=$((CHECK_SCORE + 15))  # 给予基础分数
        return
    fi

    print_info "运行测试..."
    local score=0

    cd "$PROJECT_PATH"

    case $PROJECT_TYPE in
        "vue3-frontend")
            run_vue3_tests score
            ;;
        "gin-microservice"|"go-desktop")
            run_go_tests score
            ;;
        "python-desktop")
            run_python_tests score
            ;;
        *)
            print_warning "未知项目类型，跳过测试检查"
            score=15  # 基础分数
            ;;
    esac

    CHECK_SCORE=$((CHECK_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "测试得分: $score/20"
}

# Vue3项目测试
run_vue3_tests() {
    local -n score_ref=$1

    if [ ! -f "$PROJECT_PATH/package.json" ]; then
        return
    fi

    # 检查是否有测试脚本
    if grep -q '"test"' "$PROJECT_PATH/package.json"; then
        print_info "运行前端测试..."
        if npm test 2>/dev/null; then
            score_ref=$((score_ref + 15))
            print_success "所有测试通过"
        else
            print_error "测试失败"
            BLOCKING_ISSUES_LIST+=("测试失败，请修复后再部署")
        fi
    else
        print_warning "未配置测试脚本"
        score_ref=$((score_ref + 5))  # 部分分数
    fi

    # 检查类型检查
    if grep -q '"type-check"' "$PROJECT_PATH/package.json"; then
        if npm run type-check 2>/dev/null; then
            score_ref=$((score_ref + 5))
            print_success "TypeScript类型检查通过"
        else
            print_error "TypeScript类型检查失败"
            BLOCKING_ISSUES_LIST+=("TypeScript类型检查失败")
        fi
    fi
}

# Go项目测试
run_go_tests() {
    local -n score_ref=$1

    # 检查是否有测试文件
    if find "$PROJECT_PATH" -name "*_test.go" -type f | grep -q .; then
        print_info "运行Go测试..."
        if go test ./... 2>/dev/null; then
            score_ref=$((score_ref + 15))
            print_success "所有测试通过"
        else
            print_error "Go测试失败"
            BLOCKING_ISSUES_LIST+=("Go测试失败，请修复后再部署")
        fi

        # 运行竞态检测
        if go test -race ./... 2>/dev/null; then
            score_ref=$((score_ref + 5))
            print_success "竞态检测通过"
        else
            print_warning "竞态检测发现问题"
        fi
    else
        print_warning "未发现测试文件"
        score_ref=$((score_ref + 5))  # 部分分数
    fi
}

# Python项目测试
run_python_tests() {
    local -n score_ref=$1

    # 检查是否有测试目录
    if [ -d "$PROJECT_PATH/tests" ]; then
        print_info "运行Python测试..."
        if python -m pytest tests/ 2>/dev/null; then
            score_ref=$((score_ref + 15))
            print_success "所有测试通过"
        else
            print_error "Python测试失败"
            BLOCKING_ISSUES_LIST+=("Python测试失败，请修复后再部署")
        fi
    else
        print_warning "未发现测试目录"
        score_ref=$((score_ref + 5))  # 部分分数
    fi
}

# 检查安全性
check_security() {
    print_info "检查安全性..."
    local score=0

    # 检查敏感文件是否被正确忽略
    check_sensitive_files_security

    # 检查依赖安全性
    check_dependencies_security score

    # 检查配置文件安全性
    check_config_security score

    # 检查环境变量
    check_environment_variables score

    CHECK_SCORE=$((CHECK_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "安全检查得分: $score/15"
}

# 检查敏感文件安全性
check_sensitive_files_security() {
    local sensitive_patterns=("*.key" "*.pem" "*.p12" "*.env" ".env.*" "config.local.*" "secrets.*")
    
    for pattern in "${sensitive_patterns[@]}"; do
        while IFS= read -r -d '' file; do
            local rel_path=$(realpath --relative-to="$PROJECT_PATH" "$file")
            
            # 检查是否在版本控制中
            if git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
                print_critical "敏感文件被提交到版本控制: $rel_path"
                SECURITY_ISSUES+=("敏感文件 $rel_path 不应该被提交到版本控制")
            fi
            
            # 检查是否被.gitignore忽略
            if [ -f "$PROJECT_PATH/.gitignore" ]; then
                if ! git check-ignore "$file" >/dev/null 2>&1; then
                    print_warning "敏感文件未被.gitignore忽略: $rel_path"
                    WARNING_ISSUES+=("敏感文件 $rel_path 建议添加到.gitignore")
                fi
            fi
        done < <(find "$PROJECT_PATH" -name "$pattern" -type f -print0 2>/dev/null)
    done
}

# 检查依赖安全性
check_dependencies_security() {
    local -n score_ref=$1

    case $PROJECT_TYPE in
        "vue3-frontend")
            if command -v npm >/dev/null 2>&1 && [ -f "$PROJECT_PATH/package.json" ]; then
                cd "$PROJECT_PATH"
                if npm audit --audit-level=high 2>/dev/null | grep -q "0 vulnerabilities"; then
                    score_ref=$((score_ref + 5))
                    print_success "NPM依赖安全检查通过"
                else
                    print_error "发现高危NPM依赖漏洞"
                    SECURITY_ISSUES+=("存在高危NPM依赖漏洞，运行 npm audit fix 修复")
                fi
            fi
            ;;
        "go-desktop"|"gin-microservice")
            # Go dependencies security check
            if command -v govulncheck >/dev/null 2>&1; then
                cd "$PROJECT_PATH"
                if govulncheck ./... 2>/dev/null; then
                    score_ref=$((score_ref + 5))
                    print_success "Go依赖安全检查通过"
                else
                    print_warning "Go依赖存在已知漏洞"
                fi
            else
                [ "$VERBOSE" = true ] && print_info "govulncheck未安装，跳过Go安全检查"
                score_ref=$((score_ref + 3))
            fi
            ;;
        "python-desktop")
            if command -v safety >/dev/null 2>&1 && [ -f "$PROJECT_PATH/requirements.txt" ]; then
                cd "$PROJECT_PATH"
                if safety check -r requirements.txt 2>/dev/null; then
                    score_ref=$((score_ref + 5))
                    print_success "Python依赖安全检查通过"
                else
                    print_error "Python依赖存在安全漏洞"
                    SECURITY_ISSUES+=("Python依赖存在安全漏洞")
                fi
            fi
            ;;
    esac
}

# 检查配置文件安全性
check_config_security() {
    local -n score_ref=$1
    local config_files=()

    # 查找配置文件
    while IFS= read -r -d '' file; do
        config_files+=("$file")
    done < <(find "$PROJECT_PATH" -name "*.conf" -o -name "*.ini" -o -name "*.yaml" -o -name "*.yml" -o -name "config.*" -type f -print0 2>/dev/null)

    for config_file in "${config_files[@]}"; do
        # 检查是否包含硬编码密码或密钥
        if grep -E "(password|passwd|secret|key|token).*=" "$config_file" 2>/dev/null | grep -v "example\|placeholder\|xxx" >/dev/null; then
            print_warning "配置文件可能包含硬编码敏感信息: $(basename "$config_file")"
            WARNING_ISSUES+=("配置文件 $(basename "$config_file") 可能包含硬编码敏感信息")
        fi
    done

    score_ref=$((score_ref + 3))
}

# 检查环境变量
check_environment_variables() {
    local -n score_ref=$1

    # 检查是否有生产环境配置
    case $PROJECT_TYPE in
        "vue3-frontend")
            if [ -f "$PROJECT_PATH/.env.production" ]; then
                score_ref=$((score_ref + 2))
            elif [ "$ENVIRONMENT" = "production" ]; then
                print_warning "生产环境缺少.env.production文件"
            fi
            ;;
        *)
            # 通用环境变量检查
            if [ -f "$PROJECT_PATH/.env.example" ]; then
                score_ref=$((score_ref + 2))
                print_success "发现环境变量示例文件"
            fi
            ;;
    esac
}

# 检查性能和资源
check_performance() {
    print_info "检查性能和资源配置..."
    local score=0

    case $PROJECT_TYPE in
        "vue3-frontend")
            check_vue3_performance score
            ;;
        "gin-microservice"|"go-desktop")
            check_go_performance score
            ;;
        *)
            score=10  # 基础分数
            ;;
    esac

    CHECK_SCORE=$((CHECK_SCORE + score))
    [ "$VERBOSE" = true ] && print_info "性能检查得分: $score/15"
}

# Vue3性能检查
check_vue3_performance() {
    local -n score_ref=$1

    # 检查构建配置
    if [ -f "$PROJECT_PATH/vite.config.ts" ]; then
        if grep -q "rollupOptions" "$PROJECT_PATH/vite.config.ts"; then
            score_ref=$((score_ref + 5))
            print_success "发现Rollup优化配置"
        fi

        if grep -q "chunkSizeWarningLimit" "$PROJECT_PATH/vite.config.ts"; then
            score_ref=$((score_ref + 3))
        fi
    fi

    # 检查是否启用了代码分割
    if grep -r "import(" "$PROJECT_PATH/src" >/dev/null 2>&1; then
        score_ref=$((score_ref + 4))
        print_success "发现动态导入代码分割"
    else
        print_warning "建议使用动态导入进行代码分割"
    fi

    # 检查图片优化
    if [ -d "$PROJECT_PATH/public" ]; then
        local large_images=$(find "$PROJECT_PATH/public" -name "*.jpg" -o -name "*.png" -size +1M 2>/dev/null | wc -l)
        if [ $large_images -gt 0 ]; then
            print_warning "发现 $large_images 个大于1MB的图片文件"
        else
            score_ref=$((score_ref + 3))
        fi
    fi
}

# Go性能检查
check_go_performance() {
    local -n score_ref=$1

    # 检查是否有性能优化的构建标志
    if [ -f "$PROJECT_PATH/Makefile" ]; then
        if grep -q "\-ldflags" "$PROJECT_PATH/Makefile"; then
            score_ref=$((score_ref + 5))
            print_success "发现链接优化配置"
        fi
    fi

    # 检查并发处理
    if grep -r "goroutine\|sync\|channel" "$PROJECT_PATH" >/dev/null 2>&1; then
        score_ref=$((score_ref + 5))
        [ "$VERBOSE" = true ] && print_success "使用了Go并发特性"
    fi

    score_ref=$((score_ref + 5))  # 基础分数
}

# 最终部署决策
make_deployment_decision() {
    print_info "评估部署就绪状态..."

    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                     📊 部署检查总结                          ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # 显示总体评分
    if [ $CHECK_SCORE -ge 85 ]; then
        echo -e "${GREEN}🏆 检查评分: $CHECK_SCORE/$MAX_SCORE (优秀)${NC}"
    elif [ $CHECK_SCORE -ge 70 ]; then
        echo -e "${BLUE}🥈 检查评分: $CHECK_SCORE/$MAX_SCORE (良好)${NC}"
    elif [ $CHECK_SCORE -ge 50 ]; then
        echo -e "${YELLOW}🥉 检查评分: $CHECK_SCORE/$MAX_SCORE (一般)${NC}"
    else
        echo -e "${RED}🔴 检查评分: $CHECK_SCORE/$MAX_SCORE (不建议部署)${NC}"
    fi

    echo ""
    echo "📋 **检查结果概览**:"
    echo "  🚨 严重问题: ${#CRITICAL_ISSUES[@]} 个"
    echo "  ❌ 阻塞问题: ${#BLOCKING_ISSUES_LIST[@]} 个"
    echo "  🔒 安全问题: ${#SECURITY_ISSUES[@]} 个"
    echo "  ⚠️ 警告信息: ${#WARNING_ISSUES[@]} 个"
    echo ""

    # 显示具体问题
    if [ ${#CRITICAL_ISSUES[@]} -gt 0 ]; then
        echo -e "${RED}🚨 严重问题 (必须解决):${NC}"
        for issue in "${CRITICAL_ISSUES[@]}"; do
            echo "  - $issue"
        done
        echo ""
    fi

    if [ ${#BLOCKING_ISSUES_LIST[@]} -gt 0 ]; then
        echo -e "${RED}❌ 阻塞问题 (阻止部署):${NC}"
        for issue in "${BLOCKING_ISSUES_LIST[@]}"; do
            echo "  - $issue"
        done
        echo ""
    fi

    if [ ${#SECURITY_ISSUES[@]} -gt 0 ]; then
        echo -e "${RED}🔒 安全问题 (安全风险):${NC}"
        for issue in "${SECURITY_ISSUES[@]}"; do
            echo "  - $issue"
        done
        echo ""
    fi

    if [ ${#WARNING_ISSUES[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️ 警告信息 (建议修复):${NC}"
        for issue in "${WARNING_ISSUES[@]}"; do
            echo "  - $issue"
        done
        echo ""
    fi

    # 做出部署决策
    local can_deploy=true

    if [ ${#CRITICAL_ISSUES[@]} -gt 0 ]; then
        can_deploy=false
        echo -e "${RED}🚫 部署被阻止: 存在严重问题必须先解决${NC}"
    fi

    if [ ${#BLOCKING_ISSUES_LIST[@]} -gt 0 ]; then
        if [ "$FORCE_DEPLOY" = true ]; then
            echo -e "${YELLOW}⚠️ 强制部署: 忽略阻塞问题继续部署${NC}"
        else
            can_deploy=false
            echo -e "${RED}🚫 部署被阻止: 存在阻塞问题${NC}"
        fi
    fi

    if [ ${#SECURITY_ISSUES[@]} -gt 0 ]; then
        if [ "$FORCE_DEPLOY" = true ]; then
            echo -e "${YELLOW}⚠️ 强制部署: 忽略安全问题继续部署${NC}"
        else
            can_deploy=false
            echo -e "${RED}🚫 部署被阻止: 存在安全问题${NC}"
        fi
    fi

    echo ""
    if [ "$can_deploy" = true ]; then
        echo -e "${GREEN}✅ 项目通过部署检查，可以安全部署到 $ENVIRONMENT 环境${NC}"
        if [ ${#WARNING_ISSUES[@]} -gt 0 ]; then
            echo -e "${YELLOW}💡 建议: 部署后关注警告信息并持续改进${NC}"
        fi
        echo ""
        echo -e "${GREEN}🚀 运行以下命令开始部署:${NC}"
        case $PROJECT_TYPE in
            "vue3-frontend")
                echo "  npm run build && npm run deploy"
                ;;
            "gin-microservice"|"go-desktop")
                echo "  make build && make deploy"
                ;;
            "python-desktop")
                echo "  make build && make package"
                ;;
            *)
                echo "  请参考项目文档执行部署命令"
                ;;
        esac
        exit 0
    else
        echo -e "${RED}❌ 项目未通过部署检查，不建议部署${NC}"
        echo ""
        echo -e "${YELLOW}📝 建议的修复步骤:${NC}"
        echo "  1. 解决所有严重问题和阻塞问题"
        echo "  2. 修复安全问题"
        echo "  3. 重新运行部署前检查"
        echo "  4. 如需强制部署，使用 --force 参数"
        exit 1
    fi
}

# 主函数
main() {
    print_header
    
    # 解析参数
    parse_args "$@"
    
    print_info "开始部署前检查: $PROJECT_PATH"
    print_info "目标环境: $ENVIRONMENT"
    
    # 检查项目是否存在
    if [ ! -d "$PROJECT_PATH" ]; then
        print_error "项目路径不存在: $PROJECT_PATH"
        exit 1
    fi
    
    # 执行检查步骤
    detect_project_type
    check_repository_status
    check_build_configuration
    run_tests
    check_security
    check_performance
    
    # 做出部署决策
    make_deployment_decision
}

# 执行主函数
main "$@"