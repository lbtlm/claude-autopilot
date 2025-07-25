# ~/.zshrc - Zsh配置文件 (macOS)
# 70个项目统一开发环境配置

# Oh My Zsh配置
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# 插件配置
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    docker-compose
    node
    npm
    yarn
    golang
    python
    vscode
    macos
)

source $ZSH/oh-my-zsh.sh

# 环境变量配置
export LANG=en_US.UTF-8
export EDITOR='code'
export BROWSER='open'

# Node.js配置
export NODE_OPTIONS="--max-old-space-size=4096"
export NPM_CONFIG_REGISTRY="https://registry.npmmirror.com"

# Go配置
export GOPATH=$HOME/go
export GOROOT=$(brew --prefix)/Cellar/go/$(brew list --versions go | tr ' ' '\n' | tail -1)/libexec
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
export GOPROXY=https://goproxy.cn,direct
export GO111MODULE=on

# Python配置
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# Java配置（如果需要）
if [[ -f /usr/libexec/java_home ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# 开发工具路径
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# 项目路径配置
export PROJECTS_DIR="$HOME/Projects"
export WORK_DIR="$HOME/Work"
export GLOBAL_RULES_DIR="$HOME/Projects/global_rules"

# 别名配置
# 基础系统别名
alias ll='ls -la'
alias la='ls -la'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# 项目导航别名
alias projects='cd $PROJECTS_DIR'
alias work='cd $WORK_DIR'
alias rules='cd $GLOBAL_RULES_DIR'
alias dotfiles='cd $HOME/dotfiles'

# Git别名
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'

# 开发工具别名
alias py='python'
alias py3='python3'
alias pip='python -m pip'
alias serve='python -m http.server'
alias json='python -m json.tool'

# Node.js别名
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'
alias nb='npm run build'

# Docker别名
alias d='docker'
alias dc='docker-compose'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dcbuild='docker-compose build'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'

# VSCode别名
alias code.='code .'
alias c.='code .'

# 系统监控别名
alias top='htop'
alias df='df -h'
alias du='du -h'
alias free='vm_stat'

# 网络工具别名
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias wget='curl -O'

# 项目管理函数
# 创建新项目
function newproject() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "使用方法: newproject <项目名> <项目类型>"
        echo "项目类型: vue3-frontend, gin-microservice, go-desktop, python-desktop"
        return 1
    fi
    
    if [ -f "$GLOBAL_RULES_DIR/scripts/init-project.sh" ]; then
        $GLOBAL_RULES_DIR/scripts/init-project.sh "$1" "$2"
    else
        echo "错误: 未找到项目初始化脚本"
    fi
}

# 项目健康检查
function healthcheck() {
    local project_path=${1:-.}
    if [ -f "$GLOBAL_RULES_DIR/scripts/health-check.sh" ]; then
        $GLOBAL_RULES_DIR/scripts/health-check.sh "$project_path"
    else
        echo "错误: 未找到健康检查脚本"
    fi
}

# 部署前检查
function deploycheck() {
    local project_path=${1:-.}
    if [ -f "$GLOBAL_RULES_DIR/scripts/pre-deploy-check.sh" ]; then
        $GLOBAL_RULES_DIR/scripts/pre-deploy-check.sh "$project_path"
    else
        echo "错误: 未找到部署前检查脚本"
    fi
}

# 快速创建目录并进入
function mkcd() {
    mkdir -p "$1" && cd "$1"
}

# 查找文件
function ff() {
    find . -type f -name "*$1*"
}

# 查找目录
function fd() {
    find . -type d -name "*$1*"
}

# 快速备份文件
function backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# 解压函数
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' 无法解压!!" ;;
        esac
    else
        echo "'$1' 不是有效文件!"
    fi
}

# 网络信息
function myip() {
    echo "本地IP: $(ipconfig getifaddr en0)"
    echo "公网IP: $(curl -s http://checkip.amazonaws.com)"
}

# 清理系统
function cleanup() {
    echo "清理系统缓存..."
    sudo rm -rf /tmp/*
    brew cleanup
    npm cache clean --force
    docker system prune -f
    echo "清理完成!"
}

# 开发环境检查
function devcheck() {
    echo "=== 开发环境检查 ==="
    echo "Node.js: $(node --version 2>/dev/null || echo '未安装')"
    echo "npm: $(npm --version 2>/dev/null || echo '未安装')"
    echo "Python: $(python --version 2>/dev/null || echo '未安装')"
    echo "Go: $(go version 2>/dev/null || echo '未安装')"
    echo "Git: $(git --version 2>/dev/null || echo '未安装')"
    echo "Docker: $(docker --version 2>/dev/null || echo '未安装')"
    echo "VSCode: $(code --version 2>/dev/null | head -1 || echo '未安装')"
}

# Claude Code工作流程
function claude() {
    echo "🤖 启动Claude Code工作流程..."
    echo "1. 回忆项目状态"
    echo "2. 检查项目健康度"
    echo "3. 开始开发工作"
    
    # 自动运行健康检查
    if [ -f "$GLOBAL_RULES_DIR/scripts/health-check.sh" ]; then
        echo "正在运行项目健康检查..."
        $GLOBAL_RULES_DIR/scripts/health-check.sh .
    fi
}

# 历史记录配置
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# 自动补全配置
autoload -U compinit
compinit

# 加载本地配置（如果存在）
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# 启动消息
if [ -t 1 ]; then
    echo "🚀 70个项目统一开发环境已加载!"
    echo "💡 输入 'devcheck' 检查开发环境"
    echo "🔧 输入 'claude' 启动Claude Code工作流程"
fi

# 自动建议配置
if [ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 语法高亮配置
if [ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi