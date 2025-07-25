#!/bin/bash

# install.sh - macOS/Linux 开发环境一键安装脚本
# 自动安装开发工具并配置环境

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
    echo "║                🚀 70个项目开发环境一键安装                   ║"
    echo "║                                                              ║"
    echo "║    自动安装开发工具、配置环境、同步dotfiles配置文件           ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# 检测操作系统
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macOS"
        PACKAGE_MANAGER="brew"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="Linux"
        if command -v apt-get >/dev/null 2>&1; then
            PACKAGE_MANAGER="apt"
        elif command -v yum >/dev/null 2>&1; then
            PACKAGE_MANAGER="yum"
        elif command -v dnf >/dev/null 2>&1; then
            PACKAGE_MANAGER="dnf"
        elif command -v pacman >/dev/null 2>&1; then
            PACKAGE_MANAGER="pacman"
        else
            print_error "不支持的Linux发行版"
            exit 1
        fi
    else
        print_error "不支持的操作系统: $OSTYPE"
        exit 1
    fi
    
    print_info "检测到操作系统: $OS ($PACKAGE_MANAGER)"
}

# 安装包管理器
install_package_manager() {
    if [[ "$OS" == "macOS" ]]; then
        if ! command -v brew >/dev/null 2>&1; then
            print_info "安装Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            
            # 添加Homebrew到PATH
            if [[ -f "/opt/homebrew/bin/brew" ]]; then
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
            
            print_success "Homebrew安装完成"
        else
            print_success "Homebrew已安装"
            brew update
        fi
    fi
}

# 安装基础工具
install_basic_tools() {
    print_info "安装基础开发工具..."
    
    case $PACKAGE_MANAGER in
        brew)
            # macOS使用Homebrew
            brew install git curl wget jq make cmake
            print_success "基础工具安装完成"
            ;;
        apt)
            # Ubuntu/Debian
            sudo apt-get update
            sudo apt-get install -y git curl wget jq make cmake build-essential
            print_success "基础工具安装完成"
            ;;
        yum|dnf)
            # CentOS/RHEL/Fedora
            sudo $PACKAGE_MANAGER install -y git curl wget jq make cmake gcc gcc-c++
            print_success "基础工具安装完成"
            ;;
        pacman)
            # Arch Linux
            sudo pacman -S --noconfirm git curl wget jq make cmake base-devel
            print_success "基础工具安装完成"
            ;;
    esac
}

# 安装Node.js环境
install_nodejs() {
    print_info "安装Node.js环境..."
    
    case $PACKAGE_MANAGER in
        brew)
            brew install node yarn
            ;;
        apt)
            # 安装NodeSource仓库
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
            sudo npm install -g yarn
            ;;
        yum|dnf)
            # 安装NodeSource仓库
            curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
            sudo $PACKAGE_MANAGER install -y nodejs
            sudo npm install -g yarn
            ;;
        pacman)
            sudo pacman -S --noconfirm nodejs npm yarn
            ;;
    esac
    
    # 配置npm镜像
    npm config set registry https://registry.npmmirror.com
    
    print_success "Node.js环境安装完成"
    print_info "Node版本: $(node --version)"
    print_info "npm版本: $(npm --version)"
}

# 安装Python环境
install_python() {
    print_info "安装Python环境..."
    
    case $PACKAGE_MANAGER in
        brew)
            brew install python@3.11 pyenv
            # 安装pipenv
            pip3 install pipenv
            ;;
        apt)
            sudo apt-get install -y python3 python3-pip python3-venv
            pip3 install --user pipenv
            ;;
        yum|dnf)
            sudo $PACKAGE_MANAGER install -y python3 python3-pip
            pip3 install --user pipenv
            ;;
        pacman)
            sudo pacman -S --noconfirm python python-pip
            pip install --user pipenv
            ;;
    esac
    
    print_success "Python环境安装完成"
    print_info "Python版本: $(python3 --version)"
}

# 安装Go环境
install_golang() {
    print_info "安装Go环境..."
    
    case $PACKAGE_MANAGER in
        brew)
            brew install go
            ;;
        apt|yum|dnf|pacman)
            # 手动安装最新版Go
            local go_version="1.21.5"
            local go_archive="go${go_version}.linux-amd64.tar.gz"
            
            if [[ "$OS" == "macOS" ]]; then
                go_archive="go${go_version}.darwin-amd64.tar.gz"
            fi
            
            cd /tmp
            wget -q "https://golang.org/dl/${go_archive}"
            sudo rm -rf /usr/local/go
            sudo tar -C /usr/local -xzf "${go_archive}"
            rm "${go_archive}"
            
            # 添加到PATH
            if ! grep -q "/usr/local/go/bin" ~/.bashrc 2>/dev/null; then
                echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
            fi
            if ! grep -q "/usr/local/go/bin" ~/.zshrc 2>/dev/null; then
                echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
            fi
            
            export PATH=$PATH:/usr/local/go/bin
            ;;
    esac
    
    # 配置Go环境
    mkdir -p ~/go/{bin,src,pkg}
    
    print_success "Go环境安装完成"
    print_info "Go版本: $(go version 2>/dev/null || echo '需要重启终端')"
}

# 安装VSCode
install_vscode() {
    print_info "安装Visual Studio Code..."
    
    case $PACKAGE_MANAGER in
        brew)
            brew install --cask visual-studio-code
            ;;
        apt)
            # 添加Microsoft仓库
            wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
            sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
            sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
            sudo apt update
            sudo apt install -y code
            ;;
        yum|dnf)
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
            sudo $PACKAGE_MANAGER install -y code
            ;;
        pacman)
            # 从AUR安装
            print_warning "Arch Linux用户请手动从AUR安装VSCode"
            print_info "命令: yay -S visual-studio-code-bin"
            ;;
    esac
    
    print_success "VSCode安装完成"
}

# 安装Docker
install_docker() {
    print_info "安装Docker..."
    
    case $PACKAGE_MANAGER in
        brew)
            brew install --cask docker
            print_warning "请手动启动Docker Desktop应用"
            ;;
        apt)
            # 安装Docker官方源
            sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
            sudo apt-get update
            sudo apt-get install -y ca-certificates curl gnupg lsb-release
            
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            
            sudo apt-get update
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
            
            # 添加用户到docker组
            sudo usermod -aG docker $USER
            ;;
        yum|dnf)
            sudo $PACKAGE_MANAGER install -y yum-utils
            sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
            sudo $PACKAGE_MANAGER install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
            sudo systemctl start docker
            sudo systemctl enable docker
            sudo usermod -aG docker $USER
            ;;
        pacman)
            sudo pacman -S --noconfirm docker docker-compose
            sudo systemctl start docker
            sudo systemctl enable docker
            sudo usermod -aG docker $USER
            ;;
    esac
    
    print_success "Docker安装完成"
}

# 配置Shell环境
setup_shell() {
    print_info "配置Shell环境..."
    
    if [[ "$OS" == "macOS" ]]; then
        # macOS配置Zsh
        if ! command -v zsh >/dev/null 2>&1; then
            brew install zsh
        fi
        
        # 安装Oh My Zsh
        if [ ! -d "$HOME/.oh-my-zsh" ]; then
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        fi
        
        # 安装powerlevel10k主题
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        fi
        
        # 安装插件
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
            git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        fi
        
        if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        fi
        
        print_success "Zsh环境配置完成"
    else
        # Linux配置Bash/Zsh
        print_info "Linux环境，建议手动安装Oh My Zsh"
    fi
}

# 同步dotfiles配置
sync_dotfiles() {
    print_info "同步dotfiles配置..."
    
    if [ -f "$SCRIPT_DIR/sync.sh" ]; then
        "$SCRIPT_DIR/sync.sh" -b -e -v
        print_success "Dotfiles配置同步完成"
    else
        print_error "未找到sync.sh脚本"
    fi
}

# 验证安装结果
verify_installation() {
    print_info "验证安装结果..."
    
    echo ""
    echo "=== 开发环境检查 ==="
    
    # 检查各个工具
    local tools=(
        "git:Git版本控制"
        "node:Node.js运行时"
        "npm:Node包管理器"
        "python3:Python解释器"
        "go:Go编程语言"
        "code:VSCode编辑器"
        "docker:Docker容器"
    )
    
    local success_count=0
    local total_count=${#tools[@]}
    
    for tool_info in "${tools[@]}"; do
        IFS=':' read -r tool desc <<< "$tool_info"
        if command -v "$tool" >/dev/null 2>&1; then
            local version=$($tool --version 2>/dev/null | head -1 || echo "已安装")
            print_success "$desc: $version"
            success_count=$((success_count + 1))
        else
            print_error "$desc: 未安装"
        fi
    done
    
    echo ""
    if [ $success_count -eq $total_count ]; then
        print_success "🎉 所有工具安装成功！($success_count/$total_count)"
    else
        print_warning "⚠️ 部分工具安装失败 ($success_count/$total_count)"
    fi
    
    echo ""
    print_info "💡 后续步骤:"
    print_info "1. 重启终端以使环境变量生效"
    print_info "2. 打开VSCode验证配置"
    print_info "3. 运行 'git config --global user.name \"Your Name\"' 设置Git用户信息"
    print_info "4. 运行 'git config --global user.email \"your.email@example.com\"' 设置Git邮箱"
    
    if [[ "$OS" == "Linux" ]] && command -v docker >/dev/null 2>&1; then
        print_info "5. 重新登录以使Docker权限生效"
    fi
}

# 显示使用说明
show_usage() {
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -h, --help              显示帮助信息"
    echo "  -m, --minimal           最小化安装（仅基础工具）"
    echo "  --skip-nodejs          跳过Node.js安装"
    echo "  --skip-python          跳过Python安装"
    echo "  --skip-golang          跳过Go安装"
    echo "  --skip-vscode          跳过VSCode安装"
    echo "  --skip-docker          跳过Docker安装"
    echo "  --skip-sync            跳过dotfiles同步"
    echo ""
    echo "示例:"
    echo "  $0                      # 完整安装"
    echo "  $0 -m                   # 最小化安装"
    echo "  $0 --skip-docker        # 跳过Docker安装"
}

# 主函数
main() {
    # 默认选项
    local minimal_install=false
    local skip_nodejs=false
    local skip_python=false
    local skip_golang=false
    local skip_vscode=false
    local skip_docker=false
    local skip_sync=false
    
    # 解析命令行参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -m|--minimal)
                minimal_install=true
                shift
                ;;
            --skip-nodejs)
                skip_nodejs=true
                shift
                ;;
            --skip-python)
                skip_python=true
                shift
                ;;
            --skip-golang)
                skip_golang=true
                shift
                ;;
            --skip-vscode)
                skip_vscode=true
                shift
                ;;
            --skip-docker)
                skip_docker=true
                shift
                ;;
            --skip-sync)
                skip_sync=true
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
    
    # 检测操作系统
    detect_os
    
    # 开始安装
    print_info "开始安装70个项目开发环境..."
    
    # 安装包管理器
    install_package_manager
    
    # 安装基础工具
    install_basic_tools
    
    # 根据选项安装其他工具
    if [ "$minimal_install" != true ]; then
        if [ "$skip_nodejs" != true ]; then
            install_nodejs
        fi
        
        if [ "$skip_python" != true ]; then
            install_python
        fi
        
        if [ "$skip_golang" != true ]; then
            install_golang
        fi
        
        if [ "$skip_vscode" != true ]; then
            install_vscode
        fi
        
        if [ "$skip_docker" != true ]; then
            install_docker
        fi
    fi
    
    # 配置Shell环境
    setup_shell
    
    # 同步dotfiles配置
    if [ "$skip_sync" != true ]; then
        sync_dotfiles
    fi
    
    # 验证安装结果
    verify_installation
    
    echo ""
    print_success "🎉 70个项目开发环境安装完成！"
    print_info "🔄 请重启终端以使所有配置生效"
}

# 检查是否以root身份运行
if [ "$EUID" -eq 0 ]; then
    print_error "请不要以root身份运行此脚本"
    exit 1
fi

# 执行主函数
main "$@"