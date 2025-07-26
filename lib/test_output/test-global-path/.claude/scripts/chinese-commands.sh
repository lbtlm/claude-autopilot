#!/bin/bash

# 中文命令包装脚本
# 将中文命令转换为英文文件名并执行

# 动态检测Claude Autopilot路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_CE_PATH="$(dirname "$SCRIPT_DIR")"
source "$GLOBAL_CE_PATH/utils/alias-resolver.sh"

# 解析中文命令
CHINESE_COMMAND="$1"
shift  # 移除第一个参数，保留其余参数

# 解析为英文文件名
ENGLISH_COMMAND=$(resolve_command_alias "$CHINESE_COMMAND")

if [ "$ENGLISH_COMMAND" = "$CHINESE_COMMAND" ]; then
    echo "⚠️ 未找到命令映射: $CHINESE_COMMAND"
    echo "可用命令请查看: .claude/commands/"
    exit 1
fi

# 查找对应的命令文件
COMMAND_FILE=$(check_command_file_exists "$CHINESE_COMMAND")

if [ $? -ne 0 ]; then
    echo "❌ 命令文件不存在: $CHINESE_COMMAND"
    exit 1
fi

# 显示正在执行的命令
echo "🎯 执行命令: $CHINESE_COMMAND -> $ENGLISH_COMMAND"
echo "📄 文件: $COMMAND_FILE"

# 这里可以添加实际的命令执行逻辑
# 例如：解析markdown文件并执行其中的脚本
echo "✅ 命令映射成功"
