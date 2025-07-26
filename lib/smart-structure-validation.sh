#!/bin/bash

# /smart-structure-validation 智能项目结构验证和重组命令
# 版本: 2.1.0

set -euo pipefail

# 获取脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 加载必要的库 (同目录下)
source "$SCRIPT_DIR/cross-platform-utils.sh"
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
    
    echo "项目类型: $project_type" >&2
    echo "$project_type"
}

# 验证项目结构
validate_project_structure() {
    local project_path="$1"
    local project_type="$2"
    
    echo "🔍 验证项目结构合规性..."
    echo "================================"
    
    local issues=0
    
    # 检查根目录下不应该存在的文件
    local non_standard_files=(
        "CONTRIBUTING.md"
        "LICENSE" 
        "CHANGELOG.md"
        "Dockerfile"
        ".env.example"
        ".env.docker"
        "VERSION"
    )
    
    echo "📋 检查根目录文件合规性："
    for file in "${non_standard_files[@]}"; do
        if [ -f "$project_path/$file" ]; then
            echo "   ⚠️  $file (应移至标准目录)"
            issues=$((issues + 1))
        else
            echo "   ✅ $file (已在标准位置或不存在)"
        fi
    done
    
    echo ""
    echo "📊 结构验证结果："
    if [ "$issues" -gt 0 ]; then
        echo "   🚨 发现 $issues 个结构问题"
        echo "   💡 建议运行智能重组来修复这些问题"
        return 1
    else
        echo "   ✅ 项目结构完全符合GNU标准"
        return 0
    fi
}

# 主执行函数
main() {
    local project_path="$(pwd)"
    local action="${1:-validate}"
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --reorganize|--fix)
                action="reorganize"
                shift
                ;;
            --validate|--check)
                action="validate"
                shift
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
    
    echo "🏗️ 智能项目结构验证器"
    echo "===================="
    echo "📂 项目路径: $project_path"
    
    # 检测项目类型
    local project_type=$(detect_project_info "$project_path")
    echo "🏷️ 项目类型: $project_type"
    echo ""
    
    if [ "$action" = "validate" ]; then
        # 只验证，不修复
        if validate_project_structure "$project_path" "$project_type"; then
            echo ""
            echo "🎉 项目结构验证通过！"
        else
            echo ""
            echo "💡 运行 '$0 --reorganize' 来自动修复结构问题"
            exit 1
        fi
    elif [ "$action" = "reorganize" ]; then
        # 先验证，然后重组
        echo "🔄 执行智能项目重组..."
        echo ""
        
        local moved_count
        moved_count=$(reorganize_project_files "$project_path" "$project_type")
        
        if [ "$moved_count" -gt 0 ]; then
            echo "🎊 项目结构重组完成！"
            echo "   📁 已重组 $moved_count 个文件到标准位置"
            echo ""
            
            # 重新验证
            echo "🔍 重新验证项目结构..."
            if validate_project_structure "$project_path" "$project_type"; then
                echo ""
                echo "✨ 项目现在完全符合GNU编码标准！"
            fi
        else
            echo "ℹ️  项目结构已经符合标准，无需重组"
        fi
    fi
}

# 执行主函数
main "$@"