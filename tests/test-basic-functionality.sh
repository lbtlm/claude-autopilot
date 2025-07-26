#!/bin/bash

# Claude Autopilot 2.1 基础功能测试

# 加载测试框架
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test-framework.sh"

# 测试项目根目录
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

test_suite_start "基础功能测试"

# 测试1: 检查项目结构
test_start "项目目录结构完整性"
assert_directory_exists "$PROJECT_ROOT/bin" "bin目录应该存在"
assert_directory_exists "$PROJECT_ROOT/lib" "lib目录应该存在"  
assert_directory_exists "$PROJECT_ROOT/etc" "etc目录应该存在"
assert_directory_exists "$PROJECT_ROOT/share" "share目录应该存在"
assert_directory_exists "$PROJECT_ROOT/tests" "tests目录应该存在"
test_end

# 测试2: 检查核心可执行文件
test_start "核心执行文件存在性"
assert_file_exists "$PROJECT_ROOT/bin/claude-autopilot" "主执行脚本应该存在"
assert_executable "$PROJECT_ROOT/bin/claude-autopilot" "主执行脚本应该可执行"
assert_file_exists "$PROJECT_ROOT/bin/setup.sh" "setup脚本应该存在"
assert_file_exists "$PROJECT_ROOT/bin/quick-setup.sh" "quick-setup脚本应该存在"
test_end

# 测试3: 检查库文件
test_start "库文件完整性"
assert_file_exists "$PROJECT_ROOT/lib/cross-platform-utils.sh" "跨平台工具库应该存在"
assert_file_exists "$PROJECT_ROOT/lib/project-type-selector.sh" "项目类型选择器应该存在"
assert_file_exists "$PROJECT_ROOT/lib/project-health-assessment.sh" "项目健康评估器应该存在"
test_end

# 测试4: 检查配置文件
test_start "配置文件存在性"
assert_file_exists "$PROJECT_ROOT/etc/command-aliases.json" "命令别名配置应该存在"
test_end

# 测试5: 检查共享资源
test_start "共享资源完整性"
assert_directory_exists "$PROJECT_ROOT/share/claude-autopilot" "共享资源目录应该存在"
assert_directory_exists "$PROJECT_ROOT/share/claude-autopilot/project-types" "项目类型模板目录应该存在"
assert_directory_exists "$PROJECT_ROOT/share/claude-autopilot/commands" "命令目录应该存在"
test_end

# 测试6: 检查文档文件
test_start "文档文件完整性"
assert_file_exists "$PROJECT_ROOT/README.md" "中文README应该存在"
assert_file_exists "$PROJECT_ROOT/README-TW.md" "繁体中文README应该存在"
assert_file_exists "$PROJECT_ROOT/README-EN.md" "英文README应该存在"
assert_file_exists "$PROJECT_ROOT/CLAUDE.md" "Claude配置文档应该存在"
test_end

# 测试7: 检查Makefile
test_start "构建系统文件"
assert_file_exists "$PROJECT_ROOT/Makefile" "Makefile应该存在"
test_end

# 测试8: 跨平台工具函数测试
test_start "跨平台工具函数"
source "$PROJECT_ROOT/lib/cross-platform-utils.sh"

# 测试get_realpath函数
test_path="/tmp"
result=$(get_realpath "$test_path")
assert_contains "$result" "/tmp" "get_realpath应该返回正确的路径"

# 测试detect_os函数
os_type=$(detect_os)
assert_true "$([ -n "$os_type" ])" "detect_os应该返回非空结果"

# 测试command_exists函数
if command_exists "bash"; then
    assert_true true "command_exists应该能检测到bash命令"
else
    assert_true false "command_exists应该能检测到bash命令"
fi
test_end

test_suite_end "基础功能测试"