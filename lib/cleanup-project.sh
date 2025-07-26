#!/bin/bash

# /cleanup-project 智能项目清理命令实现
# 版本: 2.1.0

set -euo pipefail

# 获取脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载必要的库 (同目录下)
source "$SCRIPT_DIR/cross-platform-utils.sh"
source "$SCRIPT_DIR/file-cleanup-engine.sh"
source "$SCRIPT_DIR/file-reorganizer.sh"

# 检测项目信息
detect_project_info() {
    local project_path="$1"
    
    # 读取项目配置
    if [ -f "$project_path/.claude/project.json" ]; then
        local project_type=$(grep -o '"project_type"[[:space:]]*:[[:space:]]*"[^"]*"' "$project_path/.claude/project.json" | cut -d'"' -f4 2>/dev/null || echo "bash-scripts")
    else
        local project_type="bash-scripts"
    fi
    
    # echo "项目类型: $project_type" # 调试信息，已注释
    echo "$project_type"
}

# 主执行函数
main() {
    local project_path="$(pwd)"
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run|--auto|--deep|--backup|--no-backup)
                # 这些参数会传递给清理引擎
                break
                ;;
            *)
                if [[ -d "$1" ]]; then
                    project_path="$1"
                    shift
                else
                    break
                fi
                ;;
        esac
    done
    
    echo "🧹 智能项目清理器启动"
    echo "===================="
    echo "📂 项目路径: $project_path"
    
    # 检测项目类型
    local project_type=$(detect_project_info "$project_path")
    echo "🏷️ 项目类型: $project_type"
    echo ""
    
    # 第一步：智能重组文件到标准位置
    echo "🔄 第一步：执行智能文件重组..."
    reorganize_project_files "$project_path" "$project_type" > /dev/null
    local reorganized_count=$?
    
    if [ "$reorganized_count" -gt 0 ]; then
        echo "   ✅ 已重组 $reorganized_count 个文件到标准位置"
        echo ""
    else
        echo "   ℹ️  项目结构已符合标准，无需重组"
        echo ""
    fi
    
    # 第二步：清理临时文件和残余文件
    echo "🧹 第二步：执行智能清理..."
    cleanup_project_files "$project_path" "$project_type" "$@"
}

# 执行主函数
main "$@"