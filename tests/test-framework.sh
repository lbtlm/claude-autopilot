#!/bin/bash

# Claude Autopilot 2.1 测试框架
# 简单的Bash测试框架，用于验证项目功能

# 测试统计
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0
CURRENT_TEST=""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 测试开始
test_start() {
    local test_name="$1"
    CURRENT_TEST="$test_name"
    echo -e "${BLUE}🧪 运行测试: $test_name${NC}"
    TESTS_RUN=$((TESTS_RUN + 1))
}

# 断言函数
assert_equals() {
    local expected="$1"
    local actual="$2"
    local message="${3:-Expected '$expected', got '$actual'}"
    
    if [ "$expected" = "$actual" ]; then
        echo -e "  ${GREEN}✅ PASS: $message${NC}"
        return 0
    else
        echo -e "  ${RED}❌ FAIL: $message${NC}"
        echo -e "     Expected: '$expected'"
        echo -e "     Actual:   '$actual'"
        return 1
    fi
}

assert_true() {
    local condition="$1"
    local message="${2:-Condition should be true}"
    
    if [ "$condition" = true ] || [ "$condition" = "0" ]; then
        echo -e "  ${GREEN}✅ PASS: $message${NC}"
        return 0
    else
        echo -e "  ${RED}❌ FAIL: $message${NC}"
        return 1
    fi
}

assert_file_exists() {
    local file="$1"
    local message="${2:-File '$file' should exist}"
    
    if [ -f "$file" ]; then
        echo -e "  ${GREEN}✅ PASS: $message${NC}"
        return 0
    else
        echo -e "  ${RED}❌ FAIL: $message${NC}"
        return 1
    fi
}

assert_directory_exists() {
    local dir="$1"
    local message="${2:-Directory '$dir' should exist}"
    
    if [ -d "$dir" ]; then
        echo -e "  ${GREEN}✅ PASS: $message${NC}"
        return 0
    else
        echo -e "  ${RED}❌ FAIL: $message${NC}"
        return 1
    fi
}

assert_executable() {
    local file="$1"
    local message="${2:-File '$file' should be executable}"
    
    if [ -x "$file" ]; then
        echo -e "  ${GREEN}✅ PASS: $message${NC}"
        return 0
    else
        echo -e "  ${RED}❌ FAIL: $message${NC}"
        return 1
    fi
}

assert_contains() {
    local haystack="$1"
    local needle="$2"
    local message="${3:-String should contain '$needle'}"
    
    if [[ "$haystack" == *"$needle"* ]]; then
        echo -e "  ${GREEN}✅ PASS: $message${NC}"
        return 0
    else
        echo -e "  ${RED}❌ FAIL: $message${NC}"
        echo -e "     Haystack: '$haystack'"
        echo -e "     Needle:   '$needle'"
        return 1
    fi
}

# 测试结束
test_end() {
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✅ 测试通过: $CURRENT_TEST${NC}"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}❌ 测试失败: $CURRENT_TEST${NC}"
    fi
    echo ""
    return $exit_code
}

# 测试套件开始
test_suite_start() {
    local suite_name="$1"
    echo -e "${BLUE}📋 开始测试套件: $suite_name${NC}"
    echo "======================================"
}

# 测试套件结束
test_suite_end() {
    local suite_name="$1"
    echo "======================================"
    echo -e "${BLUE}📊 测试套件完成: $suite_name${NC}"
    echo -e "总计: $TESTS_RUN, 通过: ${GREEN}$TESTS_PASSED${NC}, 失败: ${RED}$TESTS_FAILED${NC}"
    
    if [ $TESTS_FAILED -eq 0 ]; then
        echo -e "${GREEN}🎉 所有测试通过!${NC}"
        return 0
    else
        echo -e "${RED}💥 $TESTS_FAILED 个测试失败${NC}"
        return 1
    fi
}

# 运行命令并捕获输出
run_command() {
    local cmd="$1"
    local output_file="${2:-/tmp/test_output.txt}"
    
    eval "$cmd" > "$output_file" 2>&1
    echo $?
}

# 创建临时测试目录
create_test_dir() {
    local test_dir="/tmp/claude-autopilot-test-$$"
    mkdir -p "$test_dir"
    echo "$test_dir"
}

# 清理测试目录
cleanup_test_dir() {
    local test_dir="$1"
    if [ -n "$test_dir" ] && [ -d "$test_dir" ]; then
        rm -rf "$test_dir"
    fi
}

# 跳过测试
skip_test() {
    local reason="$1"
    echo -e "${YELLOW}⏭️  跳过测试: $CURRENT_TEST - $reason${NC}"
    echo ""
}

# 设置测试环境
setup_test_env() {
    # 设置测试环境变量
    export TEST_MODE=true
    export TEST_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    export PATH="$TEST_ROOT/bin:$PATH"
}

# 清理测试环境
cleanup_test_env() {
    unset TEST_MODE
    unset TEST_ROOT
}

# 主测试运行器
run_test_file() {
    local test_file="$1"
    
    if [ ! -f "$test_file" ]; then
        echo -e "${RED}❌ 测试文件不存在: $test_file${NC}"
        return 1
    fi
    
    echo -e "${BLUE}🚀 运行测试文件: $test_file${NC}"
    setup_test_env
    
    # 执行测试文件
    source "$test_file"
    local result=$?
    
    cleanup_test_env
    return $result
}