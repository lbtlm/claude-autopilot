#!/bin/bash

# 快捷命令执行脚本
# 支持中英文命令的统一入口

COMMAND_NAME="$1"
shift

# 检测语言偏好
LANG_PREF="chinese"
if [ -f ".claude-lang" ]; then
    LANG_PREF=$(cat .claude-lang | grep "language=" | cut -d= -f2)
fi

# 根据语言偏好显示消息
if [ "$LANG_PREF" = "chinese" ]; then
    echo "🚀 执行智能命令: $COMMAND_NAME"
    echo "💡 提示: 您也可以使用英文命令名"
else
    echo "🚀 Executing smart command: $COMMAND_NAME" 
    echo "💡 Tip: You can also use Chinese command names"
fi

# 调用命令解析和执行
source .claude/scripts/chinese-commands.sh "$COMMAND_NAME" "$@"
