#!/bin/bash

# Claude Autopilot 2.1 快速配置脚本
# 一行命令完成智能开发环境配置

# 动态检测项目根路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🛩️ Claude Autopilot 2.1 快速配置"
echo "================================================"

# 直接调用核心注入脚本
if [ -f "$PROJECT_ROOT/scripts/ce-inject.sh" ]; then
    "$PROJECT_ROOT/scripts/ce-inject.sh" "$@"
else
    echo "❌ 错误: 找不到ce-inject.sh脚本"
    echo "请确保项目完整安装"
    exit 1
fi

# 给脚本添加执行权限
chmod +x "$0"