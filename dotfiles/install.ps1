# install.ps1 - Windows 开发环境一键安装脚本
# 自动安装开发工具并配置环境

param(
    [switch]$Minimal,
    [switch]$SkipNodejs,
    [switch]$SkipPython,
    [switch]$SkipGolang,
    [switch]$SkipVSCode,
    [switch]$SkipDocker,
    [switch]$SkipSync,
    [switch]$Help
)

# 检查管理员权限
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ 此脚本需要管理员权限运行" -ForegroundColor Red
    Write-Host "请以管理员身份重新运行PowerShell" -ForegroundColor Yellow
    exit 1
}

# 颜色输出函数
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Write-Info {
    param([string]$Message)
    Write-ColorOutput "ℹ️  $Message" "Blue"
}

function Write-Success {
    param([string]$Message)
    Write-ColorOutput "✅ $Message" "Green"
}

function Write-Warning {
    param([string]$Message)
    Write-ColorOutput "⚠️  $Message" "Yellow"
}

function Write-Error {
    param([string]$Message)
    Write-ColorOutput "❌ $Message" "Red"
}

function Write-Header {
    Write-ColorOutput @"
╔══════════════════════════════════════════════════════════════╗
║                🚀 70个项目开发环境一键安装                   ║
║                                                              ║
║    自动安装开发工具、配置环境、同步dotfiles配置文件           ║
╚══════════════════════════════════════════════════════════════╝
"@ "Cyan"
}

# 获取脚本目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 安装Chocolatey
function Install-Chocolatey {
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Success "Chocolatey已安装"
        # 更新Chocolatey
        & choco upgrade chocolatey -y
        return
    }
    
    Write-Info "安装Chocolatey包管理器..."
    
    # 设置执行策略
    Set-ExecutionPolicy Bypass -Scope Process -Force
    
    # 下载并安装Chocolatey
    try {
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        
        # 刷新环境变量
        $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
        
        Write-Success "Chocolatey安装完成"
    } catch {
        Write-Error "Chocolatey安装失败: $($_.Exception.Message)"
        exit 1
    }
}

# 安装基础工具
function Install-BasicTools {
    Write-Info "安装基础开发工具..."
    
    $BasicTools = @(
        "git",
        "curl",
        "wget",
        "jq",
        "make",
        "7zip",
        "powershell-core"
    )
    
    foreach ($Tool in $BasicTools) {
        Write-Info "安装 $Tool..."
        try {
            & choco install $Tool -y --no-progress
        } catch {
            Write-Warning "安装 $Tool 失败"
        }
    }
    
    Write-Success "基础工具安装完成"
}

# 安装Windows Terminal
function Install-WindowsTerminal {
    Write-Info "安装Windows Terminal..."
    
    try {
        & choco install microsoft-windows-terminal -y --no-progress
        Write-Success "Windows Terminal安装完成"
    } catch {
        Write-Warning "Windows Terminal安装失败，尝试从Microsoft Store安装"
        Write-Info "请手动从Microsoft Store安装Windows Terminal"
    }
}

# 安装Node.js环境
function Install-NodeJS {
    Write-Info "安装Node.js环境..."
    
    try {
        # 安装Node.js LTS版本
        & choco install nodejs-lts -y --no-progress
        
        # 安装Yarn
        & choco install yarn -y --no-progress
        
        # 刷新环境变量
        $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
        
        # 配置npm镜像
        if (Get-Command npm -ErrorAction SilentlyContinue) {
            & npm config set registry https://registry.npmmirror.com
        }
        
        Write-Success "Node.js环境安装完成"
        if (Get-Command node -ErrorAction SilentlyContinue) {
            Write-Info "Node版本: $(& node --version)"
        }
        if (Get-Command npm -ErrorAction SilentlyContinue) {
            Write-Info "npm版本: $(& npm --version)"
        }
    } catch {
        Write-Error "Node.js安装失败: $($_.Exception.Message)"
    }
}

# 安装Python环境
function Install-Python {
    Write-Info "安装Python环境..."
    
    try {
        # 安装Python
        & choco install python -y --no-progress
        
        # 刷新环境变量
        $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
        
        # 安装pipenv
        if (Get-Command pip -ErrorAction SilentlyContinue) {
            & pip install pipenv
        }
        
        Write-Success "Python环境安装完成"
        if (Get-Command python -ErrorAction SilentlyContinue) {
            Write-Info "Python版本: $(& python --version)"
        }
    } catch {
        Write-Error "Python安装失败: $($_.Exception.Message)"
    }
}

# 安装Go环境
function Install-Golang {
    Write-Info "安装Go环境..."
    
    try {
        # 安装Go
        & choco install golang -y --no-progress
        
        # 刷新环境变量
        $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
        
        # 设置GOPATH
        $GoPath = "$env:USERPROFILE\go"
        [System.Environment]::SetEnvironmentVariable("GOPATH", $GoPath, "User")
        
        # 创建Go工作目录
        if (-not (Test-Path $GoPath)) {
            New-Item -ItemType Directory -Path $GoPath -Force | Out-Null
            New-Item -ItemType Directory -Path "$GoPath\bin" -Force | Out-Null
            New-Item -ItemType Directory -Path "$GoPath\src" -Force | Out-Null
            New-Item -ItemType Directory -Path "$GoPath\pkg" -Force | Out-Null
        }
        
        # 配置Go代理
        if (Get-Command go -ErrorAction SilentlyContinue) {
            & go env -w GOPROXY=https://goproxy.cn,direct
            & go env -w GO111MODULE=on
        }
        
        Write-Success "Go环境安装完成"
        if (Get-Command go -ErrorAction SilentlyContinue) {
            Write-Info "Go版本: $(& go version)"
        }
    } catch {
        Write-Error "Go安装失败: $($_.Exception.Message)"
    }
}

# 安装VSCode
function Install-VSCode {
    Write-Info "安装Visual Studio Code..."
    
    try {
        & choco install vscode -y --no-progress
        
        # 刷新环境变量
        $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")
        
        Write-Success "VSCode安装完成"
    } catch {
        Write-Error "VSCode安装失败: $($_.Exception.Message)"
    }
}

# 安装Docker Desktop
function Install-Docker {
    Write-Info "安装Docker Desktop..."
    
    try {
        & choco install docker-desktop -y --no-progress
        
        Write-Success "Docker Desktop安装完成"
        Write-Warning "请手动启动Docker Desktop应用并完成初始设置"
    } catch {
        Write-Error "Docker Desktop安装失败: $($_.Exception.Message)"
    }
}

# 配置PowerShell环境
function Setup-PowerShell {
    Write-Info "配置PowerShell环境..."
    
    try {
        # 安装Oh My Posh (PowerShell美化)
        if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
            & choco install oh-my-posh -y --no-progress
        }
        
        # 安装PSReadLine (改进的命令行体验)
        if (-not (Get-Module PSReadLine -ListAvailable)) {
            Install-Module PSReadLine -Force -SkipPublisherCheck
        }
        
        # 安装posh-git (Git集成)
        if (-not (Get-Module posh-git -ListAvailable)) {
            Install-Module posh-git -Force
        }
        
        Write-Success "PowerShell环境配置完成"
    } catch {
        Write-Warning "PowerShell环境配置可能不完整: $($_.Exception.Message)"
    }
}

# 安装开发辅助工具
function Install-DevTools {
    Write-Info "安装开发辅助工具..."
    
    $DevTools = @(
        "postman",
        "fiddler",
        "sysinternals"
    )
    
    foreach ($Tool in $DevTools) {
        Write-Info "安装 $Tool..."
        try {
            & choco install $Tool -y --no-progress
        } catch {
            Write-Warning "安装 $Tool 失败"
        }
    }
    
    Write-Success "开发辅助工具安装完成"
}

# 同步dotfiles配置
function Sync-Dotfiles {
    Write-Info "同步dotfiles配置..."
    
    $SyncScript = Join-Path $ScriptDir "sync.ps1"
    if (Test-Path $SyncScript) {
        try {
            & $SyncScript -Backup -Extensions -Verify
            Write-Success "Dotfiles配置同步完成"
        } catch {
            Write-Error "Dotfiles同步失败: $($_.Exception.Message)"
        }
    } else {
        Write-Error "未找到sync.ps1脚本"
    }
}

# 验证安装结果
function Test-Installation {
    Write-Info "验证安装结果..."
    
    Write-Host ""
    Write-Host "=== 开发环境检查 ===" -ForegroundColor Cyan
    
    # 检查各个工具
    $Tools = @{
        "git" = "Git版本控制"
        "node" = "Node.js运行时"
        "npm" = "Node包管理器"
        "python" = "Python解释器"
        "go" = "Go编程语言"
        "code" = "VSCode编辑器"
        "docker" = "Docker容器"
        "choco" = "Chocolatey包管理器"
    }
    
    $SuccessCount = 0
    $TotalCount = $Tools.Count
    
    foreach ($Tool in $Tools.GetEnumerator()) {
        try {
            $Version = & $Tool.Key --version 2>$null | Select-Object -First 1
            if ($Version) {
                Write-Success "$($Tool.Value): $Version"
                $SuccessCount++
            } else {
                Write-Error "$($Tool.Value): 未安装"
            }
        } catch {
            Write-Error "$($Tool.Value): 未安装"
        }
    }
    
    Write-Host ""
    if ($SuccessCount -eq $TotalCount) {
        Write-Success "🎉 所有工具安装成功！($SuccessCount/$TotalCount)"
    } else {
        Write-Warning "⚠️ 部分工具安装失败 ($SuccessCount/$TotalCount)"
    }
    
    Write-Host ""
    Write-Info "💡 后续步骤:"
    Write-Info "1. 重启PowerShell以使环境变量生效"
    Write-Info "2. 打开VSCode验证配置"
    Write-Info "3. 运行 'git config --global user.name `"Your Name`"' 设置Git用户信息"
    Write-Info "4. 运行 'git config --global user.email `"your.email@example.com`"' 设置Git邮箱"
    Write-Info "5. 启动Docker Desktop并完成初始设置"
}

# 显示使用说明
function Show-Usage {
    Write-Host @"
用法: .\install.ps1 [选项]

选项:
  -Minimal               最小化安装（仅基础工具）
  -SkipNodejs           跳过Node.js安装
  -SkipPython           跳过Python安装
  -SkipGolang           跳过Go安装
  -SkipVSCode           跳过VSCode安装
  -SkipDocker           跳过Docker安装
  -SkipSync             跳过dotfiles同步
  -Help                 显示帮助信息

示例:
  .\install.ps1                     # 完整安装
  .\install.ps1 -Minimal            # 最小化安装
  .\install.ps1 -SkipDocker         # 跳过Docker安装

注意:
  - 此脚本需要管理员权限
  - 建议在安装前关闭杀毒软件
  - 安装过程可能需要较长时间
"@
}

# 主函数
function Main {
    if ($Help) {
        Show-Usage
        return
    }
    
    Write-Header
    
    Write-Info "开始安装70个项目开发环境..."
    Write-Info "操作系统: Windows"
    
    # 安装Chocolatey包管理器
    Install-Chocolatey
    
    # 安装基础工具
    Install-BasicTools
    
    # 安装Windows Terminal
    Install-WindowsTerminal
    
    # 根据选项安装其他工具
    if (-not $Minimal) {
        if (-not $SkipNodejs) {
            Install-NodeJS
        }
        
        if (-not $SkipPython) {
            Install-Python
        }
        
        if (-not $SkipGolang) {
            Install-Golang
        }
        
        if (-not $SkipVSCode) {
            Install-VSCode
        }
        
        if (-not $SkipDocker) {
            Install-Docker
        }
        
        # 安装开发辅助工具
        Install-DevTools
    }
    
    # 配置PowerShell环境
    Setup-PowerShell
    
    # 同步dotfiles配置
    if (-not $SkipSync) {
        Sync-Dotfiles
    }
    
    # 验证安装结果
    Test-Installation
    
    Write-Host ""
    Write-Success "🎉 70个项目开发环境安装完成！"
    Write-Info "🔄 请重启PowerShell以使所有配置生效"
    Write-Warning "⚠️ 某些工具可能需要重启计算机后才能正常使用"
}

# 执行主函数
Main