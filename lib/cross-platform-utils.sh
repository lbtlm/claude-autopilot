#!/bin/bash

# 跨平台工具函数库
# 提供跨平台兼容的基础函数

# 跨平台realpath函数
get_realpath() {
    if command -v realpath >/dev/null 2>&1; then
        realpath "$1"
    else
        # 兼容macOS等没有realpath的系统
        local target="$1"
        if [ -d "$target" ]; then
            cd "$target" && pwd
        else
            cd "$(dirname "$target")" && echo "$(pwd)/$(basename "$target")"
        fi
    fi
}

# 跨平台sed函数 (处理macOS和Linux的差异)
cross_platform_sed() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS需要-i后面加空字符串参数
        sed -i "" "$@"
    else
        # Linux
        sed -i "$@"
    fi
}

# 检测操作系统类型
detect_os() {
    case "$OSTYPE" in
        linux*) echo "linux" ;;
        darwin*) echo "macos" ;;
        msys*|cygwin*) echo "windows" ;;
        *) echo "unknown" ;;
    esac
}

# 跨平台路径分隔符
get_path_separator() {
    case "$(detect_os)" in
        windows) echo "\\" ;;
        *) echo "/" ;;
    esac
}

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 跨平台文件权限设置
set_executable() {
    local file="$1"
    if [ -f "$file" ]; then
        chmod +x "$file"
        return 0
    else
        return 1
    fi
}

# 跨平台创建临时目录
create_temp_dir() {
    if command_exists mktemp; then
        mktemp -d
    else
        # 降级方案
        local temp_dir="/tmp/claude-autopilot-$$"
        mkdir -p "$temp_dir"
        echo "$temp_dir"
    fi
}