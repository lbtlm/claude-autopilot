#!/bin/bash

# 文件清理引擎
# 功能：智能识别和清理项目中的临时文件、编译产物和不规范文件
# 版本：2.0.0

# 配置变量
CLEANUP_VERSION="2.0.0"
BACKUP_ENABLED=true
BACKUP_RETENTION_DAYS=30
DRY_RUN=false
AUTO_MODE=false
DEEP_CLEAN=false

# 日志记录
log_cleanup() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$CLEANUP_LOG"
    echo "$message"
}

# 初始化清理环境
init_cleanup_environment() {
    local project_path="$1"
    local project_type="$2"
    
    # 创建必要目录
    mkdir -p "$project_path/project_process/backups"
    mkdir -p "$project_path/project_process/cleanup"
    
    # 设置日志文件
    CLEANUP_LOG="$project_path/project_process/cleanup/cleanup-$(date '+%Y%m%d-%H%M%S').log"
    CLEANUP_REPORT="$project_path/project_process/cleanup/cleanup-report-$(date '+%Y%m%d-%H%M%S').md"
    
    # 设置备份目录
    if [ "$BACKUP_ENABLED" = true ]; then
        BACKUP_DIR="$project_path/project_process/backups/cleanup-$(date '+%Y%m%d-%H%M%S')"
        mkdir -p "$BACKUP_DIR"
    fi
    
    log_cleanup "🧹 清理引擎初始化完成"
    log_cleanup "   项目路径: $project_path"
    log_cleanup "   项目类型: $project_type"
    log_cleanup "   备份目录: $BACKUP_DIR"
}

# 定义通用临时文件模式
get_common_temp_patterns() {
    echo "*.tmp *.temp *~ .DS_Store Thumbs.db *.swp *.swo .*.swp .*.swo *.bak *.backup *.old"
}

# 定义项目特定的清理模式
get_project_specific_patterns() {
    local project_type="$1"
    
    case "$project_type" in
        "gin-microservice"|"go-desktop"|"go-general")
            echo "*.exe *.dll *.so main app server coverage.out *.test vendor/"
            ;;
        "vue3-frontend"|"vue2-frontend"|"react-frontend"|"nextjs-frontend"|"nodejs-general")
            echo "node_modules/ bower_components/ dist/ build/ .next/ .nuxt/ .npm/ .yarn/ coverage/"
            ;;
        "python-desktop"|"python-web"|"python-general")
            echo "__pycache__/ *.pyc *.pyo venv/ env/ .venv/ *.egg-info/ dist/ build/ .pytest_cache/"
            ;;
        "java-maven")
            echo "target/ *.class .m2/repository/"
            ;;
        "java-gradle")
            echo "build/ .gradle/ *.class"
            ;;
        "rust-project")
            echo "target/ Cargo.lock"
            ;;
        "php-project")
            echo "vendor/ composer.lock"
            ;;
        *)
            echo ""
            ;;
    esac
}

# 定义日志文件清理规则
get_log_cleanup_patterns() {
    echo "*.log logs/ log/"
}

# 定义受保护的文件模式
get_protected_patterns() {
    echo "CLAUDE.md .gitignore .env.example README.md LICENSE go.mod go.sum package.json requirements.txt Cargo.toml composer.json pom.xml build.gradle project_process/"
}

# 检查文件是否受保护
is_file_protected() {
    local file="$1"
    local protected_patterns=$(get_protected_patterns)
    
    for pattern in $protected_patterns; do
        if [[ "$file" == *"$pattern"* ]]; then
            return 0  # 受保护
        fi
    done
    return 1  # 不受保护
}

# 获取文件大小（人类可读格式）
get_human_readable_size() {
    local size_bytes="$1"
    
    if [ "$size_bytes" -lt 1024 ]; then
        echo "${size_bytes}B"
    elif [ "$size_bytes" -lt 1048576 ]; then
        echo "$((size_bytes / 1024))KB"
    elif [ "$size_bytes" -lt 1073741824 ]; then
        echo "$((size_bytes / 1048576))MB"
    else
        echo "$((size_bytes / 1073741824))GB"
    fi
}

# 扫描可清理文件
scan_cleanable_files() {
    local project_path="$1"
    local project_type="$2"
    
    log_cleanup "🔍 开始扫描可清理文件..."
    
    # 初始化统计变量
    local temp_files=""
    local temp_count=0
    local temp_size=0
    
    local build_files=""
    local build_count=0
    local build_size=0
    
    local log_files=""
    local log_count=0
    local log_size=0
    
    local confirm_files=""
    local confirm_count=0
    
    # 获取清理模式
    local common_patterns=$(get_common_temp_patterns)
    local project_patterns=$(get_project_specific_patterns "$project_type")
    local log_patterns=$(get_log_cleanup_patterns)
    
    # 扫描临时文件
    for pattern in $common_patterns; do
        while IFS= read -r -d '' file; do
            if [ -e "$file" ] && ! is_file_protected "$file"; then
                local size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
                temp_files="$temp_files$file\n"
                temp_count=$((temp_count + 1))
                temp_size=$((temp_size + size))
            fi
        done < <(find "$project_path" -name "$pattern" -print0 2>/dev/null)
    done
    
    # 扫描编译产物
    for pattern in $project_patterns; do
        while IFS= read -r -d '' file; do
            if [ -e "$file" ] && ! is_file_protected "$file"; then
                local size=$(du -sb "$file" 2>/dev/null | cut -f1 || echo 0)
                build_files="$build_files$file\n"
                build_count=$((build_count + 1))
                build_size=$((build_size + size))
            fi
        done < <(find "$project_path" -name "$pattern" -print0 2>/dev/null)
    done
    
    # 扫描日志文件（需要确认）
    for pattern in $log_patterns; do
        while IFS= read -r -d '' file; do
            if [ -e "$file" ] && ! is_file_protected "$file"; then
                # 检查文件年龄，7天以上的日志文件加入确认列表
                local file_age=$(find "$file" -mtime +7 2>/dev/null)
                if [ -n "$file_age" ]; then
                    local size=$(du -sb "$file" 2>/dev/null | cut -f1 || echo 0)
                    confirm_files="$confirm_files$file\n"
                    confirm_count=$((confirm_count + 1))
                    log_size=$((log_size + size))
                else
                    local size=$(du -sb "$file" 2>/dev/null | cut -f1 || echo 0)
                    log_files="$log_files$file\n"
                    log_count=$((log_count + 1))
                    log_size=$((log_size + size))
                fi
            fi
        done < <(find "$project_path" -name "$pattern" -print0 2>/dev/null)
    done
    
    # 保存扫描结果到全局变量
    SCAN_TEMP_FILES="$temp_files"
    SCAN_TEMP_COUNT="$temp_count"
    SCAN_TEMP_SIZE="$temp_size"
    
    SCAN_BUILD_FILES="$build_files"
    SCAN_BUILD_COUNT="$build_count"
    SCAN_BUILD_SIZE="$build_size"
    
    SCAN_LOG_FILES="$log_files"
    SCAN_LOG_COUNT="$log_count"
    SCAN_LOG_SIZE="$log_size"
    
    SCAN_CONFIRM_FILES="$confirm_files"
    SCAN_CONFIRM_COUNT="$confirm_count"
    
    local total_count=$((temp_count + build_count + log_count))
    local total_size=$((temp_size + build_size + log_size))
    
    log_cleanup "✅ 扫描完成: $total_count 个文件, $(get_human_readable_size $total_size)"
}

# 显示扫描结果
show_scan_results() {
    local project_path="$1"
    local project_type="$2"
    local project_name=$(basename "$project_path")
    
    echo "🧹 智能项目清理器 - 扫描结果"
    echo "==============================================="
    echo ""
    echo "📂 项目: $project_name ($project_type)"
    echo "🔍 扫描路径: $project_path"
    echo ""
    echo "📋 发现可清理文件:"
    echo ""
    
    # 显示临时文件
    if [ "$SCAN_TEMP_COUNT" -gt 0 ]; then
        echo "🗂️ 临时文件 ($SCAN_TEMP_COUNT个文件, $(get_human_readable_size $SCAN_TEMP_SIZE)):"
        echo -e "$SCAN_TEMP_FILES" | head -5 | while read -r file; do
            [ -n "$file" ] && echo "  ✓ $(basename "$file")"
        done
        if [ "$SCAN_TEMP_COUNT" -gt 5 ]; then
            echo "  ... 还有 $((SCAN_TEMP_COUNT - 5)) 个文件"
        fi
        echo ""
    fi
    
    # 显示编译产物
    if [ "$SCAN_BUILD_COUNT" -gt 0 ]; then
        echo "📦 编译产物 ($SCAN_BUILD_COUNT个文件, $(get_human_readable_size $SCAN_BUILD_SIZE)):"
        echo -e "$SCAN_BUILD_FILES" | head -5 | while read -r file; do
            [ -n "$file" ] && echo "  ✓ $(basename "$file")"
        done
        if [ "$SCAN_BUILD_COUNT" -gt 5 ]; then
            echo "  ... 还有 $((SCAN_BUILD_COUNT - 5)) 个文件"
        fi
        echo ""
    fi
    
    # 显示日志文件
    if [ "$SCAN_LOG_COUNT" -gt 0 ]; then
        echo "📄 日志文件 ($SCAN_LOG_COUNT个文件, $(get_human_readable_size $SCAN_LOG_SIZE)):"
        echo -e "$SCAN_LOG_FILES" | head -3 | while read -r file; do
            [ -n "$file" ] && echo "  ✓ $(basename "$file")"
        done
        if [ "$SCAN_LOG_COUNT" -gt 3 ]; then
            echo "  ... 还有 $((SCAN_LOG_COUNT - 3)) 个文件"
        fi
        echo ""
    fi
    
    # 显示需要确认的文件
    if [ "$SCAN_CONFIRM_COUNT" -gt 0 ]; then
        echo "⚠️ 需要确认的文件 ($SCAN_CONFIRM_COUNT个):"
        echo -e "$SCAN_CONFIRM_FILES" | head -3 | while read -r file; do
            [ -n "$file" ] && echo "  ? $(basename "$file") (7天前)"
        done
        echo ""
    fi
    
    # 显示保护文件信息
    echo "🔒 受保护文件 (已忽略):"
    echo "  • CLAUDE.md, .gitignore"
    echo "  • package.json, go.mod"
    echo "  • project_process/"
    echo ""
    
    local total_count=$((SCAN_TEMP_COUNT + SCAN_BUILD_COUNT + SCAN_LOG_COUNT))
    local total_size=$((SCAN_TEMP_SIZE + SCAN_BUILD_SIZE + SCAN_LOG_SIZE))
    echo "💾 总计: $total_count个文件/目录, 预计释放 $(get_human_readable_size $total_size) 空间"
}

# 用户确认清理操作
confirm_cleanup() {
    if [ "$AUTO_MODE" = true ]; then
        return 0  # 自动模式，直接确认
    fi
    
    echo ""
    echo "请确认清理操作:"
    echo "[y] 清理所有建议的文件"
    echo "[n] 取消清理"
    echo "[s] 选择性清理"
    echo "[d] 查看详细信息"
    echo ""
    read -p "您的选择: " choice
    
    case "$choice" in
        [Yy]*)
            return 0  # 确认全部清理
            ;;
        [Nn]*)
            return 1  # 取消清理
            ;;
        [Ss]*)
            return 2  # 选择性清理
            ;;
        [Dd]*)
            return 3  # 查看详细信息
            ;;
        *)
            echo "无效选择，请重新输入"
            confirm_cleanup  # 递归调用
            ;;
    esac
}

# 选择性清理
selective_cleanup() {
    echo ""
    echo "选择性清理模式:"
    echo "1. [✓] 临时文件 ($SCAN_TEMP_COUNT个)"
    echo "2. [✓] 编译产物 ($SCAN_BUILD_COUNT个)"
    echo "3. [ ] 日志文件 ($SCAN_LOG_COUNT个)"
    echo "4. [ ] 需确认文件 ($SCAN_CONFIRM_COUNT个)"
    echo ""
    read -p "请选择要清理的类别 (1-4, 用空格分隔): " selections
    
    CLEANUP_TEMP=false
    CLEANUP_BUILD=false
    CLEANUP_LOG=false
    CLEANUP_CONFIRM=false
    
    for selection in $selections; do
        case "$selection" in
            1) CLEANUP_TEMP=true ;;
            2) CLEANUP_BUILD=true ;;
            3) CLEANUP_LOG=true ;;
            4) CLEANUP_CONFIRM=true ;;
        esac
    done
}

# 创建备份
create_backup() {
    local file="$1"
    
    if [ "$BACKUP_ENABLED" = true ] && [ -e "$file" ]; then
        local backup_path="$BACKUP_DIR/$(basename "$file")"
        cp -r "$file" "$backup_path" 2>/dev/null || true
        log_cleanup "📦 已备份: $file -> $backup_path"
    fi
}

# 执行文件删除
delete_files() {
    local files="$1"
    local category="$2"
    local count=0
    local size=0
    
    if [ -n "$files" ]; then
        echo -e "$files" | while read -r file; do
            if [ -n "$file" ] && [ -e "$file" ]; then
                local file_size=$(du -sb "$file" 2>/dev/null | cut -f1 || echo 0)
                
                if [ "$DRY_RUN" = true ]; then
                    log_cleanup "🔍 [DRY RUN] 将删除: $file"
                else
                    create_backup "$file"
                    rm -rf "$file" 2>/dev/null || true
                    log_cleanup "🗑️ 已删除: $file"
                fi
                
                count=$((count + 1))
                size=$((size + file_size))
            fi
        done
    fi
    
    echo "$count:$size"
}

# 执行清理操作
execute_cleanup() {
    local total_deleted=0
    local total_size=0
    
    log_cleanup "🚀 开始执行清理操作..."
    
    if [ "$DRY_RUN" = true ]; then
        echo "🔍 预览模式 - 以下文件将被删除:"
        echo "=================================="
    else
        echo "🗑️ 执行清理操作..."
        echo "===================="
    fi
    
    # 清理临时文件
    if [ "${CLEANUP_TEMP:-true}" = true ] && [ "$SCAN_TEMP_COUNT" -gt 0 ]; then
        echo "处理临时文件..."
        local result=$(delete_files "$SCAN_TEMP_FILES" "临时文件")
        local count=$(echo "$result" | cut -d: -f1)
        local size=$(echo "$result" | cut -d: -f2)
        total_deleted=$((total_deleted + count))
        total_size=$((total_size + size))
    fi
    
    # 清理编译产物
    if [ "${CLEANUP_BUILD:-true}" = true ] && [ "$SCAN_BUILD_COUNT" -gt 0 ]; then
        echo "处理编译产物..."
        local result=$(delete_files "$SCAN_BUILD_FILES" "编译产物")
        local count=$(echo "$result" | cut -d: -f1)
        local size=$(echo "$result" | cut -d: -f2)
        total_deleted=$((total_deleted + count))
        total_size=$((total_size + size))
    fi
    
    # 清理日志文件
    if [ "${CLEANUP_LOG:-false}" = true ] && [ "$SCAN_LOG_COUNT" -gt 0 ]; then
        echo "处理日志文件..."
        local result=$(delete_files "$SCAN_LOG_FILES" "日志文件")
        local count=$(echo "$result" | cut -d: -f1)
        local size=$(echo "$result" | cut -d: -f2)
        total_deleted=$((total_deleted + count))
        total_size=$((total_size + size))
    fi
    
    # 清理需确认文件
    if [ "${CLEANUP_CONFIRM:-false}" = true ] && [ "$SCAN_CONFIRM_COUNT" -gt 0 ]; then
        echo "处理需确认文件..."
        local result=$(delete_files "$SCAN_CONFIRM_FILES" "需确认文件")
        local count=$(echo "$result" | cut -d: -f1)
        local size=$(echo "$result" | cut -d: -f2)
        total_deleted=$((total_deleted + count))
        total_size=$((total_size + size))
    fi
    
    TOTAL_DELETED="$total_deleted"
    TOTAL_SIZE="$total_size"
}

# 生成清理报告
generate_cleanup_report() {
    local project_path="$1"
    local project_type="$2"
    local project_name=$(basename "$project_path")
    
    cat > "$CLEANUP_REPORT" << EOF
# 项目清理报告

## 基本信息
- **项目名称**: $project_name
- **项目类型**: $project_type
- **项目路径**: $project_path
- **清理时间**: $(date '+%Y-%m-%d %H:%M:%S')
- **清理版本**: $CLEANUP_VERSION

## 清理统计
- **扫描文件总数**: $((SCAN_TEMP_COUNT + SCAN_BUILD_COUNT + SCAN_LOG_COUNT + SCAN_CONFIRM_COUNT))
- **删除文件数量**: $TOTAL_DELETED
- **释放磁盘空间**: $(get_human_readable_size $TOTAL_SIZE)

## 分类统计
### 临时文件
- 发现数量: $SCAN_TEMP_COUNT
- 文件大小: $(get_human_readable_size $SCAN_TEMP_SIZE)
- 处理状态: ${CLEANUP_TEMP:-true}

### 编译产物
- 发现数量: $SCAN_BUILD_COUNT  
- 文件大小: $(get_human_readable_size $SCAN_BUILD_SIZE)
- 处理状态: ${CLEANUP_BUILD:-true}

### 日志文件
- 发现数量: $SCAN_LOG_COUNT
- 文件大小: $(get_human_readable_size $SCAN_LOG_SIZE)
- 处理状态: ${CLEANUP_LOG:-false}

### 需确认文件
- 发现数量: $SCAN_CONFIRM_COUNT
- 处理状态: ${CLEANUP_CONFIRM:-false}

## 备份信息
- 备份启用: $BACKUP_ENABLED
- 备份目录: $BACKUP_DIR
- 备份保留: $BACKUP_RETENTION_DAYS 天

## 详细日志
详细操作日志请查看: $CLEANUP_LOG
EOF
    
    log_cleanup "📝 清理报告已生成: $CLEANUP_REPORT"
}

# 显示清理结果
show_cleanup_results() {
    local end_time=$(date '+%Y-%m-%d %H:%M:%S')
    
    if [ "$DRY_RUN" = true ]; then
        echo ""
        echo "🔍 预览完成！"
        echo "==============================================="
        echo ""
        echo "📋 预览结果:"
        echo "  • 将删除文件: $TOTAL_DELETED个"
        echo "  • 将释放空间: $(get_human_readable_size $TOTAL_SIZE)"
        echo ""
        echo "💡 要执行实际清理，请去掉 --dry-run 参数"
    else
        echo ""
        echo "🎉 清理完成！"
        echo "==============================================="
        echo ""
        echo "✅ 已删除文件: $TOTAL_DELETED个"
        echo "💾 释放空间: $(get_human_readable_size $TOTAL_SIZE)"
        echo "⏱️ 完成时间: $end_time"
        echo ""
        echo "📋 清理详情:"
        [ "${CLEANUP_TEMP:-true}" = true ] && echo "  • 临时文件: $SCAN_TEMP_COUNT个已删除"
        [ "${CLEANUP_BUILD:-true}" = true ] && echo "  • 编译产物: $SCAN_BUILD_COUNT个已删除"
        [ "${CLEANUP_LOG:-false}" = true ] && echo "  • 日志文件: $SCAN_LOG_COUNT个已删除"
        [ "${CLEANUP_CONFIRM:-false}" = true ] && echo "  • 需确认文件: $SCAN_CONFIRM_COUNT个已删除"
        echo ""
        
        if [ "$BACKUP_ENABLED" = true ]; then
            echo "🔄 备份位置: $BACKUP_DIR"
        fi
        echo "📝 详细日志: $CLEANUP_LOG"
        echo "📊 清理报告: $CLEANUP_REPORT"
        echo ""
        echo "💡 建议:"
        echo "  - 考虑将常见临时文件添加到 .gitignore"
        echo "  - 配置自动清理脚本定期执行"
        echo "  - 定期检查项目健康度"
    fi
}

# 主清理函数
cleanup_project_files() {
    local project_path="$1"
    local project_type="$2"
    shift 2
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --auto)
                AUTO_MODE=true
                shift
                ;;
            --deep)
                DEEP_CLEAN=true
                shift
                ;;
            --backup)
                BACKUP_ENABLED=true
                shift
                ;;
            --no-backup)
                BACKUP_ENABLED=false
                shift
                ;;
            *)
                shift
                ;;
        esac
    done
    
    # 初始化清理环境
    init_cleanup_environment "$project_path" "$project_type"
    
    # 扫描可清理文件
    scan_cleanable_files "$project_path" "$project_type"
    
    # 显示扫描结果
    show_scan_results "$project_path" "$project_type"
    
    # 用户确认或选择性清理
    if [ "$AUTO_MODE" = false ]; then
        confirm_cleanup
        case $? in
            0) ;;  # 继续执行
            1) 
                log_cleanup "❌ 用户取消清理操作"
                echo "❌ 清理操作已取消"
                return 1
                ;;
            2) 
                selective_cleanup
                ;;
            3)
                # 显示详细信息后重新确认
                echo "详细文件列表请查看日志: $CLEANUP_LOG"
                confirm_cleanup
                ;;
        esac
    fi
    
    # 执行清理操作
    execute_cleanup
    
    # 生成清理报告
    generate_cleanup_report "$project_path" "$project_type"
    
    # 显示清理结果
    show_cleanup_results
    
    log_cleanup "✅ 清理操作完成"
}

# 如果脚本被直接执行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [ $# -lt 2 ]; then
        echo "用法: $0 <项目路径> <项目类型> [选项]"
        echo "选项:"
        echo "  --dry-run    预览模式，不实际删除文件"
        echo "  --auto       自动模式，跳过交互确认"
        echo "  --deep       深度清理模式"
        echo "  --backup     强制创建备份"
        echo "  --no-backup  禁用备份功能"
        exit 1
    fi
    
    cleanup_project_files "$@"
fi