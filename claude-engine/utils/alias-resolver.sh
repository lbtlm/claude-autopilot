#!/bin/bash

# Claude Autopilot 2.1 命令别名解析器
# 支持中文命令到英文文件名的映射

# 动态检测路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_CE_PATH="$(dirname "$SCRIPT_DIR")"
ALIAS_CONFIG_PATH="$GLOBAL_CE_PATH/command-aliases.json"

# 解析命令别名
resolve_command_alias() {
    local input_command="$1"
    
    # 检查别名配置文件是否存在
    if [ ! -f "$ALIAS_CONFIG_PATH" ]; then
        echo "警告: 别名配置文件不存在: $ALIAS_CONFIG_PATH" >&2
        echo "$input_command"  # 返回原命令
        return 1
    fi
    
    # 使用python解析JSON (更可靠的方法)
    if command -v python3 &> /dev/null; then
        local resolved_command=$(python3 -c "
import json
try:
    with open('$ALIAS_CONFIG_PATH', 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # 首先检查command_aliases
    if '$input_command' in data.get('command_aliases', {}):
        print(data['command_aliases']['$input_command'])
    # 然后检查workflow_aliases  
    elif '$input_command' in data.get('workflow_aliases', {}):
        print(data['workflow_aliases']['$input_command'])
    # 最后检查template_aliases
    elif '$input_command' in data.get('template_aliases', {}):
        print(data['template_aliases']['$input_command'])
    else:
        print('$input_command')  # 无映射则返回原命令
except Exception as e:
    print('$input_command')  # 出错则返回原命令
")
        echo "$resolved_command"
    else
        # 降级方案：使用简单的grep (不够准确但至少可用)
        local resolved_command=$(grep -o "\"$input_command\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" "$ALIAS_CONFIG_PATH" | sed 's/.*: *"\([^"]*\)".*/\1/' | head -1)
        if [ -n "$resolved_command" ]; then
            echo "$resolved_command"
        else
            echo "$input_command"  # 返回原命令
        fi
    fi
}

# 检查文件是否存在 (支持别名解析)
check_command_file_exists() {
    local command_name="$1"
    local resolved_name=$(resolve_command_alias "$command_name")
    
    # 检查commands目录
    if [ -f "$GLOBAL_CE_PATH/commands/${resolved_name}.md" ]; then
        echo "$GLOBAL_CE_PATH/commands/${resolved_name}.md"
        return 0
    fi
    
    # 检查workflows目录  
    if [ -f "$GLOBAL_CE_PATH/workflows/${resolved_name}.md" ]; then
        echo "$GLOBAL_CE_PATH/workflows/${resolved_name}.md"
        return 0
    fi
    
    # 检查templates目录
    if [ -f "$GLOBAL_CE_PATH/templates/${resolved_name}.md" ]; then
        echo "$GLOBAL_CE_PATH/templates/${resolved_name}.md"
        return 0
    fi
    
    return 1
}

# 列出所有可用命令
list_available_commands() {
    echo "📋 可用的智能命令 / Available Commands:"
    echo ""
    
    echo "🛠️ Commands (命令):"
    for file in $GLOBAL_CE_PATH/commands/*.md; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file" .md)
            local title=$(head -1 "$file" | sed 's/^# *//')
            echo "   • /$filename"
            echo "     $title"
        fi
    done
    
    echo ""
    echo "🔄 Workflows (工作流):"  
    for file in $GLOBAL_CE_PATH/workflows/*.md; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file" .md)
            local title=$(head -1 "$file" | sed 's/^# *//')
            echo "   • /$filename"
            echo "     $title"
        fi
    done
    
    echo ""
    echo "📄 Templates (模板):"
    for file in $GLOBAL_CE_PATH/templates/*.md; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file" .md)
            local title=$(head -1 "$file" | sed 's/^# *//')
            echo "   • /$filename"
            echo "     $title"
        fi
    done
}

# 获取命令的显示名称 (双语支持)
get_command_display_name() {
    local command_name="$1"
    local resolved_name=$(resolve_command_alias "$command_name")
    local file_path=""
    
    # 查找文件路径
    if [ -f "$GLOBAL_CE_PATH/commands/${resolved_name}.md" ]; then
        file_path="$GLOBAL_CE_PATH/commands/${resolved_name}.md"
    elif [ -f "$GLOBAL_CE_PATH/workflows/${resolved_name}.md" ]; then
        file_path="$GLOBAL_CE_PATH/workflows/${resolved_name}.md"
    elif [ -f "$GLOBAL_CE_PATH/templates/${resolved_name}.md" ]; then
        file_path="$GLOBAL_CE_PATH/templates/${resolved_name}.md"
    fi
    
    # 提取标题
    if [ -n "$file_path" ] && [ -f "$file_path" ]; then
        local title=$(head -1 "$file_path" | sed 's/^# *//')
        echo "$title"
    else
        echo "$command_name"
    fi
}

# 主函数 - 如果直接执行此脚本
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    case "${1:-}" in
        "resolve")
            if [ -n "$2" ]; then
                resolve_command_alias "$2"
            else
                echo "使用: $0 resolve <command_name>" >&2
                exit 1
            fi
            ;;
        "check")
            if [ -n "$2" ]; then
                if check_command_file_exists "$2"; then
                    echo "✅ 命令文件存在"
                else
                    echo "❌ 命令文件不存在" >&2
                    exit 1
                fi
            else
                echo "使用: $0 check <command_name>" >&2
                exit 1
            fi
            ;;
        "list")
            list_available_commands
            ;;
        "display")
            if [ -n "$2" ]; then
                get_command_display_name "$2"
            else
                echo "使用: $0 display <command_name>" >&2
                exit 1
            fi
            ;;
        *)
            echo "Claude Autopilot 2.1 命令别名解析器"
            echo ""
            echo "用法:"
            echo "  $0 resolve <command_name>  - 解析命令别名"
            echo "  $0 check <command_name>    - 检查命令文件是否存在"
            echo "  $0 list                    - 列出所有可用命令"
            echo "  $0 display <command_name>  - 获取命令的显示名称"
            echo ""
            echo "示例:"
            echo "  $0 resolve '智能功能开发'"
            echo "  $0 check 'smart-feature-dev'"
            echo "  $0 list"
            ;;
    esac
fi