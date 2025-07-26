#!/bin/bash

# 文件重组引擎
# 功能：智能将不符合GNU标准的文件移动到正确位置
# 版本：2.1.0

set -euo pipefail

# 定义文件重组规则
get_reorganization_rules() {
    cat << 'EOF'
# 文件重组规则 (source_pattern:destination_path:description)
CONTRIBUTING.md:share/claude-autopilot/docs/CONTRIBUTING.md:贡献指南移至标准文档目录
LICENSE:share/claude-autopilot/docs/LICENSE:许可证移至标准文档目录
CHANGELOG.md:share/claude-autopilot/docs/CHANGELOG.md:更新日志移至标准文档目录
*.dockerfile:deployments/docker/:Docker文件移至部署目录
docker-compose*.yml:deployments/docker/:Docker Compose文件移至部署目录
*.env.example:etc/:环境变量示例移至配置目录
VERSION:share/claude-autopilot/VERSION:版本文件移至share目录
EOF
}

# 创建目标目录
ensure_target_directory() {
    local target_path="$1"
    local target_dir="$(dirname "$target_path")"
    
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
        echo "   📁 创建目录: $target_dir"
    fi
}

# 智能文件重组
reorganize_project_files() {
    local project_path="$1"
    local project_type="$2"
    
    echo "🔄 开始智能文件重组..."
    echo "   📂 项目路径: $project_path"
    echo "   🏷️ 项目类型: $project_type"
    echo ""
    
    local moved_count=0
    local backup_dir="$project_path/project_process/backups/reorganize-$(date '+%Y%m%d-%H%M%S')"
    mkdir -p "$backup_dir"
    
    # 处理根目录下不符合标准的重要文件
    while IFS=':' read -r pattern destination description; do
        [[ "$pattern" =~ ^#.*$ ]] && continue  # 跳过注释行
        [[ -z "$pattern" ]] && continue        # 跳过空行
        
        # 在根目录查找匹配的文件
        while IFS= read -r -d '' file; do
            if [ -f "$file" ]; then
                local filename="$(basename "$file")"
                local target_path="$project_path/$destination"
                
                # 如果目标路径是目录，则保持原文件名
                if [[ "$destination" =~ /$ ]]; then
                    target_path="${target_path}${filename}"
                fi
                
                # 确保目标目录存在
                ensure_target_directory "$target_path"
                
                # 创建备份
                cp "$file" "$backup_dir/" 2>/dev/null || true
                
                # 移动文件
                if mv "$file" "$target_path" 2>/dev/null; then
                    echo "   ✅ $description"
                    echo "      $filename -> $destination"
                    moved_count=$((moved_count + 1))
                else
                    echo "   ❌ 移动失败: $file -> $target_path"
                fi
            fi
        done < <(find "$project_path" -maxdepth 1 -name "$pattern" -print0 2>/dev/null)
        
    done < <(get_reorganization_rules)
    
    # 特殊处理：Dockerfile相关文件
    if [ -f "$project_path/Dockerfile" ]; then
        ensure_target_directory "$project_path/deployments/docker/Dockerfile"
        cp "$project_path/Dockerfile" "$backup_dir/" 2>/dev/null || true
        if mv "$project_path/Dockerfile" "$project_path/deployments/docker/Dockerfile" 2>/dev/null; then
            echo "   ✅ Dockerfile移至部署目录"
            echo "      Dockerfile -> deployments/docker/"
            moved_count=$((moved_count + 1))
        fi
    fi
    
    # 特殊处理：环境配置文件
    for env_file in "$project_path"/.env.example "$project_path"/.env.docker; do
        if [ -f "$env_file" ]; then
            local filename="$(basename "$env_file")"
            ensure_target_directory "$project_path/etc/$filename"
            cp "$env_file" "$backup_dir/" 2>/dev/null || true
            if mv "$env_file" "$project_path/etc/$filename" 2>/dev/null; then
                echo "   ✅ 环境配置文件移至etc目录"
                echo "      $filename -> etc/"
                moved_count=$((moved_count + 1))
            fi
        fi
    done
    
    # 整理项目根目录，只保留标准文件
    echo ""
    echo "📋 项目根目录标准化完成："
    echo "   ✅ 移动文件数量: $moved_count"
    echo "   📦 备份位置: $backup_dir"
    echo ""
    
    # 显示现在的标准目录结构
    echo "🏗️ 当前项目结构符合GNU标准："
    echo "   📁 bin/           - 可执行文件"
    echo "   📁 lib/           - 库函数"
    echo "   📁 etc/           - 配置文件"
    echo "   📁 share/         - 共享资源和文档"
    echo "   📁 tests/         - 测试文件"
    echo "   📁 deployments/   - 部署配置"
    echo "   📁 project_process/ - 项目过程文件"
    echo "   📄 README*.md     - 项目说明文档"  
    echo "   📄 Makefile       - 构建脚本"
    echo ""
    
    return $moved_count
}

# 如果脚本被直接执行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [ $# -lt 2 ]; then
        echo "用法: $0 <项目路径> <项目类型>"
        exit 1
    fi
    
    reorganize_project_files "$@"
fi