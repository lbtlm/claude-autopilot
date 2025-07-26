#!/bin/bash

# Claude Autopilot 2.1 测试运行器
# 运行所有测试并生成报告

# 脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# 加载测试框架
source "$SCRIPT_DIR/test-framework.sh"

# 测试文件列表
TEST_FILES=(
    "$SCRIPT_DIR/test-basic-functionality.sh"
    "$SCRIPT_DIR/test-main-script.sh"
)

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# 主函数
main() {
    echo -e "${BOLD}${BLUE}🚀 Claude Autopilot 2.1 测试套件${NC}"
    echo "======================================"
    echo -e "项目根目录: ${PROJECT_ROOT}"
    echo -e "测试目录: ${SCRIPT_DIR}"
    echo ""
    
    local total_files=${#TEST_FILES[@]}
    local failed_files=0
    local start_time=$(date +%s)
    
    # 运行所有测试文件
    for test_file in "${TEST_FILES[@]}"; do
        if [ -f "$test_file" ]; then
            echo -e "${BLUE}📋 运行测试文件: $(basename "$test_file")${NC}"
            if run_test_file "$test_file"; then
                echo -e "${GREEN}✅ 测试文件通过: $(basename "$test_file")${NC}"
            else
                echo -e "${RED}❌ 测试文件失败: $(basename "$test_file")${NC}"
                failed_files=$((failed_files + 1))
            fi
            echo ""
        else
            echo -e "${YELLOW}⚠️  测试文件不存在: $test_file${NC}"
            failed_files=$((failed_files + 1))
        fi
    done
    
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    # 生成最终报告
    echo "======================================"
    echo -e "${BOLD}📊 测试总结报告${NC}"
    echo "======================================"
    echo -e "测试文件总数: $total_files"
    echo -e "通过文件数: $((total_files - failed_files))"
    echo -e "失败文件数: $failed_files"
    echo -e "执行时间: ${duration}秒"
    
    if [ $failed_files -eq 0 ]; then
        echo -e "${GREEN}${BOLD}🎉 所有测试通过！${NC}"
        echo -e "${GREEN}项目重构验证成功，可以投入使用。${NC}"
        return 0
    else
        echo -e "${RED}${BOLD}💥 测试失败！${NC}"
        echo -e "${RED}请检查失败的测试并修复问题。${NC}"
        return 1
    fi
}

# 显示使用帮助
show_help() {
    echo "使用方法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -h, --help     显示此帮助信息"
    echo "  -v, --verbose  详细输出模式"
    echo "  -q, --quiet    静默模式"
    echo "  --basic-only   仅运行基础功能测试"
    echo "  --script-only  仅运行脚本功能测试"
    echo ""
    echo "示例:"
    echo "  $0                    # 运行所有测试"
    echo "  $0 --basic-only       # 仅运行基础功能测试"
    echo "  $0 --verbose          # 详细输出模式"
}

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -v|--verbose)
            set -x
            shift
            ;;
        -q|--quiet)
            exec > /dev/null 2>&1
            shift
            ;;
        --basic-only)
            TEST_FILES=("$SCRIPT_DIR/test-basic-functionality.sh")
            shift
            ;;
        --script-only)
            TEST_FILES=("$SCRIPT_DIR/test-main-script.sh")
            shift
            ;;
        *)
            echo -e "${RED}未知选项: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# 运行主函数
main "$@"