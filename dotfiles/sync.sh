#!/bin/bash

# sync.sh - 跨平台配置同步脚本 (macOS/Linux)
# 用于同步dotfiles配置到系统中

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 脚本目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

# 打印函数
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                  🔄 Dotfiles 配置同步工具                    ║"
    echo "║                                                              ║"
    echo "║         同步VSCode、Git、Shell配置到系统环境                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# 备份现有配置
backup_existing_config() {
    print_info "备份现有配置文件..."
    
    local backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    # 备份VSCode配置
    if [ -d "$HOME/Library/Application Support/Code/User" ]; then
        cp -r "$HOME/Library/Application Support/Code/User" "$backup_dir/vscode_user" 2>/dev/null || true
    fi
    
    # 备份Git配置
    [ -f "$HOME/.gitconfig" ] && cp "$HOME/.gitconfig" "$backup_dir/" 2>/dev/null || true
    [ -f "$HOME/.gitmessage" ] && cp "$HOME/.gitmessage" "$backup_dir/" 2>/dev/null || true
    
    # 备份Shell配置
    [ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$backup_dir/" 2>/dev/null || true
    [ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$backup_dir/" 2>/dev/null || true
    
    if [ "$(ls -A $backup_dir 2>/dev/null)" ]; then
        print_success "配置文件已备份到: $backup_dir"
    else
        rm -rf "$backup_dir"
        print_info "没有找到需要备份的配置文件"
    fi
}

# 同步VSCode配置
sync_vscode_config() {
    print_info "同步VSCode配置..."
    
    local vscode_user_dir
    if [[ "$OSTYPE" == "darwin"* ]]; then
        vscode_user_dir="$HOME/Library/Application Support/Code/User"
    else
        vscode_user_dir="$HOME/.config/Code/User"
    fi
    
    if [ ! -d "$vscode_user_dir" ]; then
        print_warning "VSCode用户配置目录不存在，创建目录: $vscode_user_dir"
        mkdir -p "$vscode_user_dir"
    fi
    
    # 同步配置文件
    if [ -f "$DOTFILES_DIR/vscode/settings.json" ]; then
        cp "$DOTFILES_DIR/vscode/settings.json" "$vscode_user_dir/"
        print_success "已同步 settings.json"
    fi
    
    if [ -f "$DOTFILES_DIR/vscode/keybindings.json" ]; then
        cp "$DOTFILES_DIR/vscode/keybindings.json" "$vscode_user_dir/"
        print_success "已同步 keybindings.json"
    fi
    
    if [ -f "$DOTFILES_DIR/vscode/extensions.json" ]; then
        cp "$DOTFILES_DIR/vscode/extensions.json" "$vscode_user_dir/"
        print_success "已同步 extensions.json"
    fi
    
    # 同步代码片段
    if [ -d "$DOTFILES_DIR/vscode/snippets" ]; then
        cp -r "$DOTFILES_DIR/vscode/snippets" "$vscode_user_dir/" 2>/dev/null || true
        print_success "已同步代码片段"
    fi
}

# 安装VSCode扩展
install_vscode_extensions() {
    if ! command -v code >/dev/null 2>&1; then
        print_warning "VSCode命令行工具未安装，跳过扩展安装"
        return
    fi
    
    print_info "安装VSCode扩展..."
    
    if [ -f "$DOTFILES_DIR/vscode/extensions.json" ]; then
        # 提取扩展ID并安装
        local extensions=$(cat "$DOTFILES_DIR/vscode/extensions.json" | grep -E '^\s*"[^"]+",?\s*$' | sed 's/[",]//g' | sed 's/^\s*//' | grep -v '^//')
        
        echo "$extensions" | while read -r extension; do
            if [ -n "$extension" ]; then
                print_info "安装扩展: $extension"
                code --install-extension "$extension" --force 2>/dev/null || print_warning "安装扩展失败: $extension"
            fi
        done
        
        print_success "VSCode扩展安装完成"
    fi
}

# 同步Git配置
sync_git_config() {
    print_info "同步Git配置..."
    
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
        cp "$DOTFILES_DIR/git/.gitconfig" "$HOME/"
        print_success "已同步 .gitconfig"
    fi
    
    if [ -f "$DOTFILES_DIR/git/.gitmessage" ]; then
        cp "$DOTFILES_DIR/git/.gitmessage" "$HOME/"
        print_success "已同步 .gitmessage"
    fi
    
    if [ -f "$DOTFILES_DIR/git/.gitignore_global" ]; then
        cp "$DOTFILES_DIR/git/.gitignore_global" "$HOME/"
        # 设置全局忽略文件
        git config --global core.excludesfile "$HOME/.gitignore_global" 2>/dev/null || true
        print_success "已同步全局 .gitignore"
    fi
    
    # 设置Git提交模板
    if [ -f "$HOME/.gitmessage" ]; then
        git config --global commit.template "$HOME/.gitmessage" 2>/dev/null || true
    fi
}

# 同步Shell配置
sync_shell_config() {
    print_info "同步Shell配置..."
    
    # 检测当前Shell
    local current_shell=$(basename "$SHELL")
    
    case $current_shell in
        zsh)
            if [ -f "$DOTFILES_DIR/shell/.zshrc" ]; then
                cp "$DOTFILES_DIR/shell/.zshrc" "$HOME/"
                print_success "已同步 .zshrc"
            fi
            ;;
        bash)
            if [ -f "$DOTFILES_DIR/shell/.bashrc" ]; then
                cp "$DOTFILES_DIR/shell/.bashrc" "$HOME/"
                print_success "已同步 .bashrc"
            fi
            ;;
        *)
            print_warning "未识别的Shell: $current_shell，跳过Shell配置同步"
            ;;
    esac
}

# 同步项目模板
sync_project_templates() {
    print_info "同步项目模板..."
    
    local templates_dir="$HOME/.project_templates"
    
    if [ -d "$DOTFILES_DIR/project-templates" ]; then
        # 创建模板目录
        mkdir -p "$templates_dir"
        
        # 复制模板文件
        cp -r "$DOTFILES_DIR/project-templates/"* "$templates_dir/" 2>/dev/null || true
        
        print_success "已同步项目模板到: $templates_dir"
    fi
}

# 创建符号链接（可选）
create_symlinks() {
    print_info "创建配置文件符号链接..."
    
    # 注意：这是可选功能，有些用户可能不希望使用符号链接
    # 可以通过参数控制是否启用
    
    if [ "$USE_SYMLINKS" = "true" ]; then
        # VSCode配置符号链接
        local vscode_user_dir
        if [[ "$OSTYPE" == "darwin"* ]]; then
            vscode_user_dir="$HOME/Library/Application Support/Code/User"
        else
            vscode_user_dir="$HOME/.config/Code/User"
        fi
        
        # 这里可以创建符号链接而不是复制文件
        # ln -sf "$DOTFILES_DIR/vscode/settings.json" "$vscode_user_dir/settings.json"
        
        print_info "符号链接模式尚未启用"
    fi
}

# 验证同步结果
verify_sync() {
    print_info "验证同步结果..."
    
    local errors=0
    
    # 检查VSCode配置
    if [[ "$OSTYPE" == "darwin"* ]]; then
        vscode_settings="$HOME/Library/Application Support/Code/User/settings.json"
    else
        vscode_settings="$HOME/.config/Code/User/settings.json"
    fi
    
    if [ -f "$vscode_settings" ]; then
        print_success "VSCode配置文件存在"
    else
        print_error "VSCode配置文件不存在"
        errors=$((errors + 1))
    fi
    
    # 检查Git配置
    if [ -f "$HOME/.gitconfig" ]; then
        print_success "Git配置文件存在"
    else
        print_error "Git配置文件不存在"
        errors=$((errors + 1))
    fi
    
    # 检查Shell配置
    local current_shell=$(basename "$SHELL")
    case $current_shell in
        zsh)
            if [ -f "$HOME/.zshrc" ]; then
                print_success "Zsh配置文件存在"
            else
                print_error "Zsh配置文件不存在"
                errors=$((errors + 1))
            fi
            ;;
        bash)
            if [ -f "$HOME/.bashrc" ]; then
                print_success "Bash配置文件存在"
            else
                print_error "Bash配置文件不存在"
                errors=$((errors + 1))
            fi
            ;;
    esac
    
    if [ $errors -eq 0 ]; then
        print_success "所有配置文件同步成功！"
    else
        print_error "发现 $errors 个问题，请检查上述错误"
        return 1
    fi
}

# 显示使用说明
show_usage() {
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -h, --help              显示帮助信息"
    echo "  -b, --backup            同步前备份现有配置"
    echo "  -e, --extensions        安装VSCode扩展"
    echo "  -s, --symlinks          使用符号链接（实验性功能）"
    echo "  -v, --verify            验证同步结果"
    echo "  --skip-vscode          跳过VSCode配置同步"
    echo "  --skip-git             跳过Git配置同步"
    echo "  --skip-shell           跳过Shell配置同步"
    echo ""
    echo "示例:"
    echo "  $0                      # 标准同步"
    echo "  $0 -b -e -v             # 备份、同步、安装扩展、验证"
    echo "  $0 --skip-vscode        # 跳过VSCode配置"
}

# 主函数
main() {
    # 默认选项
    local do_backup=false
    local install_extensions=false
    local verify_result=false
    local skip_vscode=false
    local skip_git=false
    local skip_shell=false
    export USE_SYMLINKS=false
    
    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -b|--backup)
                do_backup=true
                shift
                ;;
            -e|--extensions)
                install_extensions=true
                shift
                ;;
            -s|--symlinks)
                USE_SYMLINKS=true
                shift
                ;;
            -v|--verify)
                verify_result=true
                shift
                ;;
            --skip-vscode)
                skip_vscode=true
                shift
                ;;
            --skip-git)
                skip_git=true
                shift
                ;;
            --skip-shell)
                skip_shell=true
                shift
                ;;
            *)
                print_error "未知选项: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    print_header
    
    print_info "开始同步dotfiles配置..."
    print_info "Dotfiles目录: $DOTFILES_DIR"
    print_info "操作系统: $OSTYPE"
    
    # 备份现有配置
    if [ "$do_backup" = true ]; then
        backup_existing_config
    fi
    
    # 同步各项配置
    if [ "$skip_vscode" != true ]; then
        sync_vscode_config
        if [ "$install_extensions" = true ]; then
            install_vscode_extensions
        fi
    fi
    
    if [ "$skip_git" != true ]; then
        sync_git_config
    fi
    
    if [ "$skip_shell" != true ]; then
        sync_shell_config
    fi
    
    # 同步项目模板
    sync_project_templates
    
    # 创建符号链接（可选）
    create_symlinks
    
    # 验证结果
    if [ "$verify_result" = true ]; then
        verify_sync
    fi
    
    echo ""
    print_success "🎉 Dotfiles同步完成！"
    print_info "💡 建议重启终端或VSCode以使配置生效"
    print_info "🔧 如需自定义配置，请编辑相应的配置文件"
    
    if [ "$skip_shell" != true ]; then
        print_info "🚀 重新加载Shell配置: source ~/.$(basename $SHELL)rc"
    fi
}

# 执行主函数
main "$@"