#!/bin/bash

# Git操作工具
# 功能：提供智能的Git操作，包括提交、推送、分支管理等
# 版本：2.0.0

# 配置变量
GIT_VERSION="2.0.0"
DRY_RUN=false
AUTO_PUSH=false
FORCE_PUSH=false
AMEND_COMMIT=false
AUTHOR_NAME="Youmi Sam"
AUTHOR_EMAIL="bwf5314@gmail.com"

# 敏感信息检测模式
SENSITIVE_PATTERNS=(
    "api[_-]?key\s*[:=]\s*['\"][^'\"]+['\"]"
    "secret[_-]?key\s*[:=]\s*['\"][^'\"]+['\"]"
    "password\s*[:=]\s*['\"][^'\"]+['\"]"
    "passwd\s*[:=]\s*['\"][^'\"]+['\"]"
    "token\s*[:=]\s*['\"][^'\"]+['\"]"
    "bearer\s+[a-zA-Z0-9._-]+"
    "mongodb://[^\\s]+"
    "mysql://[^\\s]+"
    "postgres://[^\\s]+"
    "redis://[^\\s]+"
    "AWS_ACCESS_KEY"
    "AWS_SECRET_KEY"
    "DATABASE_URL"
    "PRIVATE_KEY"
)

# 日志记录
log_git() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$GIT_LOG"
    echo "$message"
}

# 初始化Git操作环境
init_git_environment() {
    local project_path="$1"
    
    # 创建必要目录
    mkdir -p "$project_path/project_process/git"
    
    # 设置日志文件
    GIT_LOG="$project_path/project_process/git/git-operations-$(date '+%Y%m%d-%H%M%S').log"
    
    log_git "🚀 Git操作工具初始化完成"
    log_git "   项目路径: $project_path"
    log_git "   作者信息: $AUTHOR_NAME <$AUTHOR_EMAIL>"
}

# 配置Git用户信息
configure_git_user() {
    local project_path="$1"
    
    log_git "⚙️ 配置Git用户信息..."
    
    # 设置本地仓库的用户信息
    git -C "$project_path" config --local user.name "$AUTHOR_NAME" 2>/dev/null || true
    git -C "$project_path" config --local user.email "$AUTHOR_EMAIL" 2>/dev/null || true
    
    # 其他Git配置
    git -C "$project_path" config --local commit.gpgsign false 2>/dev/null || true
    git -C "$project_path" config --local core.autocrlf false 2>/dev/null || true
    git -C "$project_path" config --local core.filemode false 2>/dev/null || true
    
    log_git "✅ Git用户信息配置完成"
}

# 检查Git仓库状态
check_git_status() {
    local project_path="$1"
    
    log_git "🔍 检查Git仓库状态..."
    
    # 检查是否是Git仓库
    if ! git -C "$project_path" rev-parse --git-dir >/dev/null 2>&1; then
        log_git "❌ 错误: 不是Git仓库"
        return 1
    fi
    
    # 获取基本状态信息
    GIT_CURRENT_BRANCH=$(git -C "$project_path" branch --show-current 2>/dev/null || echo "detached")
    GIT_STATUS_CLEAN=$(git -C "$project_path" status --porcelain 2>/dev/null | wc -l)
    GIT_STAGED_FILES=$(git -C "$project_path" diff --cached --name-only 2>/dev/null | wc -l)
    
    # 检查远程状态
    local remote_exists=false
    if git -C "$project_path" remote -v | grep -q origin; then
        remote_exists=true
        GIT_REMOTE_STATUS=$(git -C "$project_path" status -sb 2>/dev/null | head -1)
    else
        GIT_REMOTE_STATUS="no remote"
    fi
    
    log_git "   当前分支: $GIT_CURRENT_BRANCH"
    log_git "   工作目录: $([ $GIT_STATUS_CLEAN -eq 0 ] && echo "clean" || echo "dirty ($GIT_STATUS_CLEAN files)")"
    log_git "   暂存区: $([ $GIT_STAGED_FILES -eq 0 ] && echo "empty" || echo "$GIT_STAGED_FILES files")"
    log_git "   远程状态: $GIT_REMOTE_STATUS"
    
    return 0
}

# 检查敏感信息
check_sensitive_info() {
    local project_path="$1"
    local sensitive_found=false
    
    log_git "🔒 检查敏感信息..."
    
    # 获取已暂存的文件
    local staged_files=$(git -C "$project_path" diff --cached --name-only 2>/dev/null)
    
    if [ -z "$staged_files" ]; then
        log_git "   ℹ️ 暂存区为空，跳过敏感信息检查"
        return 0
    fi
    
    # 检查每个暂存的文件
    while IFS= read -r file; do
        if [ -f "$project_path/$file" ]; then
            for pattern in "${SENSITIVE_PATTERNS[@]}"; do
                if grep -qiE "$pattern" "$project_path/$file" 2>/dev/null; then
                    log_git "   ⚠️ 发现敏感信息: $file (匹配模式: ${pattern:0:20}...)"
                    sensitive_found=true
                fi
            done
        fi
    done <<< "$staged_files"
    
    if [ "$sensitive_found" = true ]; then
        log_git "❌ 检测到敏感信息，建议在提交前移除"
        return 1
    else
        log_git "✅ 未发现敏感信息"
        return 0
    fi
}

# 分析文件变更
analyze_file_changes() {
    local project_path="$1"
    
    log_git "📁 分析文件变更..."
    
    # 统计变更类型
    local added_files=$(git -C "$project_path" diff --cached --name-status | grep '^A' | wc -l)
    local modified_files=$(git -C "$project_path" diff --cached --name-status | grep '^M' | wc -l)
    local deleted_files=$(git -C "$project_path" diff --cached --name-status | grep '^D' | wc -l)
    local renamed_files=$(git -C "$project_path" diff --cached --name-status | grep '^R' | wc -l)
    
    # 获取文件列表
    CHANGED_FILES=$(git -C "$project_path" diff --cached --name-only 2>/dev/null)
    
    # 统计行数变更
    local stats=$(git -C "$project_path" diff --cached --numstat 2>/dev/null | awk '{added+=$1; deleted+=$2} END {print added":"deleted}')
    local added_lines=$(echo "$stats" | cut -d: -f1)
    local deleted_lines=$(echo "$stats" | cut -d: -f2)
    
    # 保存统计信息到全局变量
    FILE_STATS_ADDED="$added_files"
    FILE_STATS_MODIFIED="$modified_files"
    FILE_STATS_DELETED="$deleted_files"
    FILE_STATS_RENAMED="$renamed_files"
    LINE_STATS_ADDED="${added_lines:-0}"
    LINE_STATS_DELETED="${deleted_lines:-0}"
    
    log_git "   新增文件: $added_files 个"
    log_git "   修改文件: $modified_files 个"
    log_git "   删除文件: $deleted_files 个"
    log_git "   重命名文件: $renamed_files 个"
    log_git "   新增行数: ${added_lines:-0} 行"
    log_git "   删除行数: ${deleted_lines:-0} 行"
}

# 智能生成提交类型
detect_commit_type() {
    local project_path="$1"
    local changed_files="$CHANGED_FILES"
    
    log_git "🧠 智能检测提交类型..."
    
    # 检查文件扩展名和路径模式
    local has_source_files=false
    local has_test_files=false
    local has_doc_files=false
    local has_config_files=false
    local has_build_files=false
    
    while IFS= read -r file; do
        case "$file" in
            *.go|*.js|*.ts|*.py|*.java|*.c|*.cpp|*.h|*.hpp|*.rs|*.php)
                has_source_files=true
                ;;
            *test*|*spec*|*_test.*|*.test.*)
                has_test_files=true
                ;;
            *.md|*.txt|*.rst|*.adoc|docs/*|documentation/*)
                has_doc_files=true
                ;;
            *.json|*.yaml|*.yml|*.toml|*.ini|*.conf|config/*|configs/*)
                has_config_files=true
                ;;
            Makefile|Dockerfile|*.dockerfile|docker-compose*|*.build|build/*|scripts/*)
                has_build_files=true
                ;;
        esac
    done <<< "$changed_files"
    
    # 根据变更模式推断提交类型
    local commit_type="chore"
    
    if [ "$FILE_STATS_ADDED" -gt 0 ] && [ "$has_source_files" = true ]; then
        commit_type="feat"
    elif [ "$has_test_files" = true ]; then
        commit_type="test"
    elif [ "$has_doc_files" = true ]; then
        commit_type="docs"
    elif [ "$has_config_files" = true ]; then
        commit_type="chore"
    elif [ "$has_build_files" = true ]; then
        commit_type="build"
    elif [ "$FILE_STATS_MODIFIED" -gt 0 ] && [ "$FILE_STATS_ADDED" -eq 0 ]; then
        # 检查是否是bug修复的关键词
        local recent_commits=$(git -C "$project_path" log --oneline -5 2>/dev/null | grep -i "fix\|bug\|error" | wc -l)
        if [ "$recent_commits" -gt 0 ]; then
            commit_type="fix"
        else
            commit_type="refactor"
        fi
    fi
    
    DETECTED_COMMIT_TYPE="$commit_type"
    log_git "   检测到提交类型: $commit_type"
}

# 生成智能提交信息
generate_commit_message() {
    local project_path="$1"
    local custom_message="$2"
    
    if [ -n "$custom_message" ]; then
        COMMIT_MESSAGE="$custom_message"
        log_git "📝 使用自定义提交信息: $custom_message"
        return 0
    fi
    
    log_git "📝 生成智能提交信息..."
    
    # 获取项目名称
    local project_name=$(basename "$project_path")
    
    # 生成主要描述
    local main_description=""
    case "$DETECTED_COMMIT_TYPE" in
        "feat")
            main_description="添加新功能"
            ;;
        "fix")
            main_description="修复问题"
            ;;
        "docs")
            main_description="更新文档"
            ;;
        "test")
            main_description="更新测试"
            ;;
        "refactor")
            main_description="重构代码"
            ;;
        "build")
            main_description="更新构建配置"
            ;;
        *)
            main_description="更新项目文件"
            ;;
    esac
    
    # 分析主要变更文件
    local key_files=""
    local file_count=0
    while IFS= read -r file; do
        if [ $file_count -lt 3 ]; then
            key_files="$key_files$(basename "$file"), "
            file_count=$((file_count + 1))
        fi
    done <<< "$CHANGED_FILES"
    key_files=${key_files%, }  # 移除最后的逗号和空格
    
    # 构建提交标题
    local commit_title="$DETECTED_COMMIT_TYPE: $main_description"
    if [ -n "$key_files" ]; then
        commit_title="$commit_title - $key_files"
    fi
    
    # 构建详细描述
    local commit_body=""
    commit_body="$commit_body\n文件变更统计:"
    [ "$FILE_STATS_ADDED" -gt 0 ] && commit_body="$commit_body\n- 新增文件: $FILE_STATS_ADDED 个"
    [ "$FILE_STATS_MODIFIED" -gt 0 ] && commit_body="$commit_body\n- 修改文件: $FILE_STATS_MODIFIED 个"
    [ "$FILE_STATS_DELETED" -gt 0 ] && commit_body="$commit_body\n- 删除文件: $FILE_STATS_DELETED 个"
    [ "$FILE_STATS_RENAMED" -gt 0 ] && commit_body="$commit_body\n- 重命名文件: $FILE_STATS_RENAMED 个"
    
    commit_body="$commit_body\n\n代码变更:"
    commit_body="$commit_body\n- 新增行数: $LINE_STATS_ADDED 行"
    commit_body="$commit_body\n- 删除行数: $LINE_STATS_DELETED 行"
    
    # 添加签名
    commit_body="$commit_body\n\n🤖 Generated with [Claude Code](https://claude.ai/code)"
    commit_body="$commit_body\n\nCo-Authored-By: $AUTHOR_NAME <$AUTHOR_EMAIL>"
    
    # 组合完整提交信息
    COMMIT_MESSAGE="$commit_title$commit_body"
    
    log_git "✅ 提交信息生成完成"
}

# 显示提交预览
show_commit_preview() {
    local project_path="$1"
    
    echo ""
    echo "📋 提交预览:"
    echo "============================================="
    echo ""
    echo "📝 提交信息:"
    echo "$COMMIT_MESSAGE"
    echo ""
    echo "📁 变更文件 ($((FILE_STATS_ADDED + FILE_STATS_MODIFIED + FILE_STATS_DELETED))个):"
    
    # 显示文件状态
    git -C "$project_path" diff --cached --name-status | while read -r status file; do
        case "$status" in
            A) echo "  ✅ $file (新增)" ;;
            M) echo "  📝 $file (修改)" ;;
            D) echo "  🗑️ $file (删除)" ;;
            R*) echo "  🔄 $file (重命名)" ;;
            *) echo "  📄 $file ($status)" ;;
        esac
    done
    
    echo ""
    echo "📊 变更统计:"
    echo "  • 新增: +$LINE_STATS_ADDED 行"
    echo "  • 删除: -$LINE_STATS_DELETED 行"
    echo "  • 净变更: $((LINE_STATS_ADDED - LINE_STATS_DELETED)) 行"
    echo ""
}

# 用户确认提交
confirm_commit() {
    if [ "$DRY_RUN" = true ]; then
        return 0  # 预览模式直接返回
    fi
    
    read -p "确认提交? [y/N]: " choice
    case "$choice" in
        [Yy]*)
            return 0  # 确认提交
            ;;
        *)
            return 1  # 取消提交
            ;;
    esac
}

# 执行Git提交
execute_commit() {
    local project_path="$1"
    
    if [ "$DRY_RUN" = true ]; then
        log_git "🔍 [DRY RUN] 模拟提交执行"
        echo "🔍 预览模式 - 以下操作将被执行:"
        echo "  • git add (已暂存的文件)"
        echo "  • git commit -m \"[提交信息]\""
        [ "$AUTO_PUSH" = true ] && echo "  • git push origin $GIT_CURRENT_BRANCH"
        return 0
    fi
    
    log_git "🚀 执行Git提交..."
    
    # 执行提交
    local commit_args="-m"
    [ "$AMEND_COMMIT" = true ] && commit_args="--amend -m"
    
    if git -C "$project_path" commit $commit_args "$COMMIT_MESSAGE"; then
        local commit_hash=$(git -C "$project_path" rev-parse --short HEAD)
        log_git "✅ 提交成功: $commit_hash"
        echo "✅ 提交成功: $commit_hash"
        
        COMMIT_HASH="$commit_hash"
        COMMIT_SUCCESS=true
    else
        log_git "❌ 提交失败"
        echo "❌ 提交失败"
        COMMIT_SUCCESS=false
        return 1
    fi
}

# 执行推送
execute_push() {
    local project_path="$1"
    
    if [ "$DRY_RUN" = true ] || [ "$AUTO_PUSH" != true ]; then
        return 0
    fi
    
    log_git "📤 推送到远程仓库..."
    
    # 检查是否有远程仓库
    if ! git -C "$project_path" remote | grep -q origin; then
        log_git "⚠️ 没有配置远程仓库，跳过推送"
        echo "⚠️ 没有配置远程仓库，跳过推送"
        return 0
    fi
    
    # 执行推送
    local push_args="origin $GIT_CURRENT_BRANCH"
    [ "$FORCE_PUSH" = true ] && push_args="--force $push_args"
    
    if git -C "$project_path" push $push_args; then
        log_git "✅ 推送成功"
        echo "✅ 推送成功"
        PUSH_SUCCESS=true
    else
        log_git "❌ 推送失败"
        echo "❌ 推送失败，可能需要先pull合并远程变更"
        PUSH_SUCCESS=false
        return 1
    fi
}

# 显示操作结果
show_commit_results() {
    local project_path="$1"
    local end_time=$(date '+%Y-%m-%d %H:%M:%S')
    
    if [ "$DRY_RUN" = true ]; then
        echo ""
        echo "🔍 预览完成！"
        echo "==============================================="
        echo ""
        echo "📋 预览结果:"
        echo "  • 检测到提交类型: $DETECTED_COMMIT_TYPE"
        echo "  • 变更文件数量: $((FILE_STATS_ADDED + FILE_STATS_MODIFIED + FILE_STATS_DELETED)) 个"
        echo "  • 代码行变更: +$LINE_STATS_ADDED/-$LINE_STATS_DELETED"
        echo ""
        echo "💡 要执行实际提交，请去掉 --dry-run 参数"
        return 0
    fi
    
    echo ""
    if [ "$COMMIT_SUCCESS" = true ]; then
        echo "🎉 Git操作完成！"
    else
        echo "❌ Git操作失败！"
    fi
    echo "==============================================="
    echo ""
    
    if [ "$COMMIT_SUCCESS" = true ]; then
        echo "✅ 提交信息: $(echo "$COMMIT_MESSAGE" | head -1)"
        echo "📝 提交哈希: $COMMIT_HASH"
        echo "🌿 目标分支: $GIT_CURRENT_BRANCH"
        echo "⏱️ 提交时间: $end_time"
        echo ""
        echo "📊 变更统计:"
        echo "  • 新增文件: $FILE_STATS_ADDED 个"
        echo "  • 修改文件: $FILE_STATS_MODIFIED 个"
        [ "$FILE_STATS_DELETED" -gt 0 ] && echo "  • 删除文件: $FILE_STATS_DELETED 个"
        [ "$FILE_STATS_RENAMED" -gt 0 ] && echo "  • 重命名文件: $FILE_STATS_RENAMED 个"
        echo "  • 新增行数: $LINE_STATS_ADDED 行"
        echo "  • 删除行数: $LINE_STATS_DELETED 行"
        echo ""
        
        if [ "$AUTO_PUSH" = true ]; then
            echo "🚀 远程推送: $([ "$PUSH_SUCCESS" = true ] && echo "✅ 成功" || echo "❌ 失败")"
        else
            echo "📝 提示: 使用 --push 参数可以自动推送到远程仓库"
        fi
        
        echo ""
        echo "💡 后续建议:"
        echo "  - 检查GitHub上的提交状态"
        echo "  - 考虑创建Pull Request"
        echo "  - 更新相关文档"
    else
        echo "🚫 提交失败原因:"
        echo "  - 检查暂存区是否有文件"
        echo "  - 确认没有合并冲突"
        echo "  - 验证提交信息格式"
        echo ""
        echo "🔧 解决建议:"
        echo "  - 使用 git status 检查状态"
        echo "  - 使用 git add 添加要提交的文件"
        echo "  - 使用 git pull 合并远程变更"
    fi
    
    echo ""
    echo "📚 详细日志: $GIT_LOG"
}

# 主函数：智能Git提交
commit_to_github() {
    local project_path="$1"
    local custom_message="$2"
    shift 2
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --push)
                AUTO_PUSH=true
                shift
                ;;
            --force-push)
                FORCE_PUSH=true
                AUTO_PUSH=true
                shift
                ;;
            --amend)
                AMEND_COMMIT=true
                shift
                ;;
            --branch)
                TARGET_BRANCH="$2"
                shift 2
                ;;
            *)
                shift
                ;;
        esac
    done
    
    # 初始化环境
    init_git_environment "$project_path"
    
    # 配置Git用户信息
    configure_git_user "$project_path"
    
    # 检查Git状态
    if ! check_git_status "$project_path"; then
        return 1
    fi
    
    # 检查是否有暂存的文件
    if [ "$GIT_STAGED_FILES" -eq 0 ] && [ "$AMEND_COMMIT" != true ]; then
        # 自动添加所有修改的文件
        log_git "📦 自动添加修改的文件到暂存区..."
        git -C "$project_path" add -A
        
        # 重新检查暂存区
        GIT_STAGED_FILES=$(git -C "$project_path" diff --cached --name-only 2>/dev/null | wc -l)
        
        if [ "$GIT_STAGED_FILES" -eq 0 ]; then
            log_git "❌ 错误: 没有文件变更需要提交"
            echo "❌ 错误: 没有文件变更需要提交"
            return 1
        fi
    fi
    
    # 检查敏感信息
    if ! check_sensitive_info "$project_path"; then
        echo "⚠️ 检测到敏感信息！"
        read -p "是否继续提交？[y/N]: " continue_commit
        if [[ ! "$continue_commit" =~ ^[Yy]$ ]]; then
            log_git "❌ 用户取消提交（发现敏感信息）"
            echo "❌ 提交已取消"
            return 1
        fi
    fi
    
    # 分析文件变更
    analyze_file_changes "$project_path"
    
    # 检测提交类型
    detect_commit_type "$project_path"
    
    # 生成提交信息
    generate_commit_message "$project_path" "$custom_message"
    
    # 显示提交预览
    show_commit_preview "$project_path"
    
    # 用户确认
    if ! confirm_commit; then
        log_git "❌ 用户取消提交"
        echo "❌ 提交已取消"
        return 1
    fi
    
    # 执行提交
    if ! execute_commit "$project_path"; then
        return 1
    fi
    
    # 执行推送
    execute_push "$project_path"
    
    # 显示结果
    show_commit_results "$project_path"
    
    log_git "✅ Git操作完成"
}

# 如果脚本被直接执行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [ $# -lt 1 ]; then
        echo "用法: $0 <项目路径> [提交信息] [选项]"
        echo "选项:"
        echo "  --dry-run       预览模式，不实际提交"
        echo "  --push          提交后自动推送"
        echo "  --force-push    强制推送"
        echo "  --amend         修改最后一次提交"
        echo "  --branch <name> 切换到指定分支"
        exit 1
    fi
    
    commit_to_github "$@"
fi