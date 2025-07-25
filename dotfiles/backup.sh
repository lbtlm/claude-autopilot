#!/bin/bash

# backup.sh - 配置文件备份脚本
# 备份当前系统配置到dotfiles仓库

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
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
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    💾 配置文件备份工具                       ║"
    echo "║                                                              ║"
    echo "║        将当前系统配置备份到dotfiles仓库中                     ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# 备份VSCode配置
backup_vscode_config() {
    print_info "备份VSCode配置..."
    
    local vscode_user_dir
    if [[ "$OSTYPE" == "darwin"* ]]; then
        vscode_user_dir="$HOME/Library/Application Support/Code/User"
    else
        vscode_user_dir="$HOME/.config/Code/User"
    fi
    
    if [ ! -d "$vscode_user_dir" ]; then
        print_warning "VSCode配置目录不存在: $vscode_user_dir"
        return
    fi
    
    # 备份设置文件
    if [ -f "$vscode_user_dir/settings.json" ]; then
        cp "$vscode_user_dir/settings.json" "$DOTFILES_DIR/vscode/"
        print_success "已备份 settings.json"
    fi
    
    if [ -f "$vscode_user_dir/keybindings.json" ]; then
        cp "$vscode_user_dir/keybindings.json" "$DOTFILES_DIR/vscode/"
        print_success "已备份 keybindings.json"
    fi
    
    # 备份任务配置
    if [ -f "$vscode_user_dir/tasks.json" ]; then
        cp "$vscode_user_dir/tasks.json" "$DOTFILES_DIR/vscode/"
        print_success "已备份 tasks.json"
    fi
    
    # 备份启动配置
    if [ -f "$vscode_user_dir/launch.json" ]; then
        cp "$vscode_user_dir/launch.json" "$DOTFILES_DIR/vscode/"
        print_success "已备份 launch.json"
    fi
    
    # 备份代码片段
    if [ -d "$vscode_user_dir/snippets" ]; then
        mkdir -p "$DOTFILES_DIR/vscode/snippets"
        cp -r "$vscode_user_dir/snippets/"* "$DOTFILES_DIR/vscode/snippets/" 2>/dev/null || true
        print_success "已备份代码片段"
    fi
    
    # 生成扩展列表
    if command -v code >/dev/null 2>&1; then
        print_info "生成VSCode扩展列表..."
        
        # 获取已安装的扩展
        local extensions=$(code --list-extensions)
        
        # 生成extensions.json
        cat > "$DOTFILES_DIR/vscode/extensions.json" << EOF
{
  "recommendations": [
$(echo "$extensions" | sed 's/^/    "/; s/$/",/')
  ]
}
EOF
        
        # 移除最后一行的逗号
        sed -i '$ s/,$//' "$DOTFILES_DIR/vscode/extensions.json"
        
        print_success "已生成扩展列表"
    fi
}

# 备份Git配置
backup_git_config() {
    print_info "备份Git配置..."
    
    if [ -f "$HOME/.gitconfig" ]; then
        cp "$HOME/.gitconfig" "$DOTFILES_DIR/git/"
        print_success "已备份 .gitconfig"
    fi
    
    if [ -f "$HOME/.gitmessage" ]; then
        cp "$HOME/.gitmessage" "$DOTFILES_DIR/git/"
        print_success "已备份 .gitmessage"
    fi
    
    if [ -f "$HOME/.gitignore_global" ]; then
        cp "$HOME/.gitignore_global" "$DOTFILES_DIR/git/"
        print_success "已备份 .gitignore_global"
    fi
}

# 备份Shell配置
backup_shell_config() {
    print_info "备份Shell配置..."
    
    # 检测当前Shell
    local current_shell=$(basename "$SHELL")
    
    case $current_shell in
        zsh)
            if [ -f "$HOME/.zshrc" ]; then
                cp "$HOME/.zshrc" "$DOTFILES_DIR/shell/"
                print_success "已备份 .zshrc"
            fi
            ;;
        bash)
            if [ -f "$HOME/.bashrc" ]; then
                cp "$HOME/.bashrc" "$DOTFILES_DIR/shell/"
                print_success "已备份 .bashrc"
            fi
            
            if [ -f "$HOME/.bash_profile" ]; then
                cp "$HOME/.bash_profile" "$DOTFILES_DIR/shell/"
                print_success "已备份 .bash_profile"
            fi
            ;;
        *)
            print_warning "未识别的Shell: $current_shell"
            ;;
    esac
    
    # Windows PowerShell配置
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        local ps_profile="$HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
        if [ -f "$ps_profile" ]; then
            cp "$ps_profile" "$DOTFILES_DIR/shell/profile.ps1"
            print_success "已备份 PowerShell Profile"
        fi
    fi
}

# 备份SSH配置
backup_ssh_config() {
    print_info "备份SSH配置..."
    
    if [ -f "$HOME/.ssh/config" ]; then
        # 创建SSH目录
        mkdir -p "$DOTFILES_DIR/ssh"
        
        # 备份SSH配置（不包含密钥）
        cp "$HOME/.ssh/config" "$DOTFILES_DIR/ssh/"
        print_success "已备份 SSH config"
        print_warning "SSH密钥不会被备份（安全考虑）"
    else
        print_info "未找到SSH配置文件"
    fi
}

# 备份其他配置文件
backup_other_configs() {
    print_info "备份其他配置文件..."
    
    # 备份.editorconfig
    if [ -f "$HOME/.editorconfig" ]; then
        cp "$HOME/.editorconfig" "$DOTFILES_DIR/"
        print_success "已备份 .editorconfig"
    fi
    
    # 备份npm配置
    if [ -f "$HOME/.npmrc" ]; then
        mkdir -p "$DOTFILES_DIR/npm"
        cp "$HOME/.npmrc" "$DOTFILES_DIR/npm/"
        print_success "已备份 .npmrc"
    fi
    
    # 备份pip配置
    if [ -f "$HOME/.pip/pip.conf" ]; then
        mkdir -p "$DOTFILES_DIR/pip"
        cp "$HOME/.pip/pip.conf" "$DOTFILES_DIR/pip/"
        print_success "已备份 pip.conf"
    fi
    
    # 备份Go环境配置
    if command -v go >/dev/null 2>&1; then
        mkdir -p "$DOTFILES_DIR/go"
        go env > "$DOTFILES_DIR/go/env.txt"
        print_success "已备份 Go环境变量"
    fi
}

# 清理敏感信息
clean_sensitive_info() {
    print_info "清理敏感信息..."
    
    # 清理Git配置中的个人信息
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
        # 创建模板版本，替换个人信息为占位符
        sed -e 's/name = .*/name = Your Name/' \
            -e 's/email = .*/email = your.email@example.com/' \
            -e 's/user = .*/user = your-username/' \
            "$DOTFILES_DIR/git/.gitconfig" > "$DOTFILES_DIR/git/.gitconfig.template"
        
        print_success "已创建Git配置模板（清理个人信息）"
    fi
    
    # 检查其他可能的敏感信息
    local sensitive_patterns=("password" "token" "key" "secret" "api_key")
    
    for pattern in "${sensitive_patterns[@]}"; do
        if grep -r -i "$pattern" "$DOTFILES_DIR" >/dev/null 2>&1; then
            print_warning "发现可能的敏感信息包含 '$pattern'，请手动检查"
        fi
    done
}

# 生成备份报告
generate_backup_report() {
    print_info "生成备份报告..."
    
    local report_file="$DOTFILES_DIR/BACKUP_REPORT.md"
    local backup_date=$(date +"%Y-%m-%d %H:%M:%S")
    
    cat > "$report_file" << EOF
# 配置备份报告

**备份时间**: $backup_date  
**操作系统**: $OSTYPE  
**Shell**: $(basename "$SHELL")  
**用户**: $(whoami)

## 备份的配置文件

### VSCode配置
EOF

    # VSCode配置检查
    if [ -f "$DOTFILES_DIR/vscode/settings.json" ]; then
        echo "- ✅ settings.json" >> "$report_file"
    else
        echo "- ❌ settings.json" >> "$report_file"
    fi
    
    if [ -f "$DOTFILES_DIR/vscode/keybindings.json" ]; then
        echo "- ✅ keybindings.json" >> "$report_file"
    else
        echo "- ❌ keybindings.json" >> "$report_file"
    fi
    
    if [ -f "$DOTFILES_DIR/vscode/extensions.json" ]; then
        echo "- ✅ extensions.json" >> "$report_file"
    else
        echo "- ❌ extensions.json" >> "$report_file"
    fi
    
    # Git配置检查
    cat >> "$report_file" << EOF

### Git配置
EOF
    
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
        echo "- ✅ .gitconfig" >> "$report_file"
    else
        echo "- ❌ .gitconfig" >> "$report_file"
    fi
    
    # Shell配置检查
    cat >> "$report_file" << EOF

### Shell配置
EOF
    
    case $(basename "$SHELL") in
        zsh)
            if [ -f "$DOTFILES_DIR/shell/.zshrc" ]; then
                echo "- ✅ .zshrc" >> "$report_file"
            else
                echo "- ❌ .zshrc" >> "$report_file"
            fi
            ;;
        bash)
            if [ -f "$DOTFILES_DIR/shell/.bashrc" ]; then
                echo "- ✅ .bashrc" >> "$report_file"
            else
                echo "- ❌ .bashrc" >> "$report_file"
            fi
            ;;
    esac
    
    cat >> "$report_file" << EOF

## 下一步操作

1. 检查备份的配置文件
2. 清理敏感信息
3. 提交到Git仓库
4. 在其他设备上同步配置

---

**备份脚本**: backup.sh  
**版本**: v1.0
EOF
    
    print_success "备份报告已生成: $report_file"
}

# 显示使用说明
show_usage() {
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -h, --help              显示帮助信息"
    echo "  -a, --all               备份所有配置"
    echo "  --vscode-only          仅备份VSCode配置"
    echo "  --git-only             仅备份Git配置"
    echo "  --shell-only           仅备份Shell配置"
    echo "  --clean                清理敏感信息"
    echo "  --report               生成备份报告"
    echo ""
    echo "示例:"
    echo "  $0                      # 交互式选择"
    echo "  $0 -a                   # 备份所有配置"
    echo "  $0 --vscode-only        # 仅备份VSCode"
}

# 主函数
main() {
    local backup_all=false
    local vscode_only=false
    local git_only=false
    local shell_only=false
    local clean_sensitive=false
    local generate_report=false
    
    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -a|--all)
                backup_all=true
                shift
                ;;
            --vscode-only)
                vscode_only=true
                shift
                ;;
            --git-only)
                git_only=true
                shift
                ;;
            --shell-only)
                shell_only=true
                shift
                ;;
            --clean)
                clean_sensitive=true
                shift
                ;;
            --report)
                generate_report=true
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
    
    print_info "开始备份配置文件到dotfiles仓库..."
    print_info "Dotfiles目录: $DOTFILES_DIR"
    
    # 执行备份
    if [ "$backup_all" = true ]; then
        backup_vscode_config
        backup_git_config
        backup_shell_config
        backup_ssh_config
        backup_other_configs
    elif [ "$vscode_only" = true ]; then
        backup_vscode_config
    elif [ "$git_only" = true ]; then
        backup_git_config
    elif [ "$shell_only" = true ]; then
        backup_shell_config
    else
        # 交互式选择
        echo ""
        print_info "请选择要备份的配置:"
        echo "1) VSCode配置"
        echo "2) Git配置"  
        echo "3) Shell配置"
        echo "4) SSH配置"
        echo "5) 其他配置"
        echo "6) 全部备份"
        echo ""
        read -p "请输入选择 (1-6): " choice
        
        case $choice in
            1) backup_vscode_config ;;
            2) backup_git_config ;;
            3) backup_shell_config ;;
            4) backup_ssh_config ;;
            5) backup_other_configs ;;
            6) 
                backup_vscode_config
                backup_git_config
                backup_shell_config
                backup_ssh_config
                backup_other_configs
                ;;
            *) print_error "无效选择"; exit 1 ;;
        esac
    fi
    
    # 清理敏感信息
    if [ "$clean_sensitive" = true ]; then
        clean_sensitive_info
    fi
    
    # 生成备份报告
    if [ "$generate_report" = true ]; then
        generate_backup_report
    fi
    
    echo ""
    print_success "🎉 配置备份完成！"
    print_info "💡 建议接下来执行："
    print_info "1. 检查备份的配置文件"
    print_info "2. git add . && git commit -m 'backup: 更新配置文件'"
    print_info "3. git push"
}

# 执行主函数
main "$@"