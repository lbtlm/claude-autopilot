# Microsoft.PowerShell_profile.ps1 - PowerShell配置文件 (Windows)
# 70个项目统一开发环境配置

# 设置执行策略
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# 环境变量配置
$env:EDITOR = "code"
$env:NODE_OPTIONS = "--max-old-space-size=4096"

# 项目路径配置
$env:PROJECTS_DIR = "$env:USERPROFILE\Projects"
$env:WORK_DIR = "$env:USERPROFILE\Work" 
$env:GLOBAL_RULES_DIR = "$env:PROJECTS_DIR\global_rules"

# 别名配置
# 基础系统别名
Set-Alias ll Get-ChildItem
Set-Alias ls Get-ChildItem
Set-Alias grep Select-String
Set-Alias which Get-Command
Set-Alias curl Invoke-WebRequest

# 导航别名
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }

# 项目导航函数
function projects { Set-Location $env:PROJECTS_DIR }
function work { Set-Location $env:WORK_DIR }
function rules { Set-Location $env:GLOBAL_RULES_DIR }
function dotfiles { Set-Location "$env:USERPROFILE\dotfiles" }

# Git别名
function gs { git status $args }
function ga { git add $args }
function gaa { git add . }
function gc { git commit $args }
function gcm { git commit -m $args[0] }
function gp { git push $args }
function gpl { git pull $args }
function gl { git log --oneline -10 }
function gd { git diff $args }
function gb { git branch $args }
function gco { git checkout $args }
function gcb { git checkout -b $args[0] }

# 开发工具别名
function py { python $args }
function py3 { python $args }
function serve { python -m http.server $args }

# Node.js别名
function ni { npm install $args }
function nid { npm install --save-dev $args }
function nig { npm install -g $args }
function nr { npm run $args }
function ns { npm start }
function nt { npm test }
function nb { npm run build }

# Docker别名
function d { docker $args }
function dc { docker-compose $args }
function dcup { docker-compose up $args }
function dcdown { docker-compose down $args }
function dcbuild { docker-compose build $args }
function dps { docker ps $args }
function dpsa { docker ps -a }
function di { docker images $args }

# VSCode别名
function c. { code . }

# 系统监控别名
function df { Get-WmiObject -Class Win32_LogicalDisk | Select-Object Size,FreeSpace,DeviceID }
function ps-grep { param($Name) Get-Process | Where-Object {$_.ProcessName -like "*$Name*"} }

# 项目管理函数
# 创建新项目
function New-Project {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ProjectName,
        [Parameter(Mandatory=$true)]
        [string]$ProjectType
    )
    
    $scriptPath = "$env:GLOBAL_RULES_DIR\scripts\init-project.sh"
    if (Test-Path $scriptPath) {
        & bash $scriptPath $ProjectName $ProjectType
    } else {
        Write-Error "错误: 未找到项目初始化脚本"
    }
}

# 项目健康检查
function Invoke-HealthCheck {
    param(
        [string]$ProjectPath = "."
    )
    
    $scriptPath = "$env:GLOBAL_RULES_DIR\scripts\health-check.sh"
    if (Test-Path $scriptPath) {
        & bash $scriptPath $ProjectPath
    } else {
        Write-Error "错误: 未找到健康检查脚本"
    }
}

# 部署前检查
function Invoke-DeployCheck {
    param(
        [string]$ProjectPath = "."
    )
    
    $scriptPath = "$env:GLOBAL_RULES_DIR\scripts\pre-deploy-check.sh"
    if (Test-Path $scriptPath) {
        & bash $scriptPath $ProjectPath
    } else {
        Write-Error "错误: 未找到部署前检查脚本"
    }
}

# 快速创建目录并进入
function mkcd {
    param([string]$Path)
    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    Set-Location $Path
}

# 查找文件
function Find-File {
    param([string]$Pattern)
    Get-ChildItem -Recurse -Name "*$Pattern*"
}

# 查找目录
function Find-Directory {
    param([string]$Pattern)
    Get-ChildItem -Recurse -Directory -Name "*$Pattern*"
}

# 快速备份文件
function Backup-File {
    param([string]$FilePath)
    $backupName = "$FilePath.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Copy-Item $FilePath $backupName
    Write-Host "已备份到: $backupName"
}

# 网络信息
function Get-MyIP {
    $localIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "以太网*" | Select-Object -First 1).IPAddress
    $publicIP = (Invoke-WebRequest -Uri "http://checkip.amazonaws.com" -UseBasicParsing).Content.Trim()
    Write-Host "本地IP: $localIP"
    Write-Host "公网IP: $publicIP"
}

# 清理系统
function Invoke-Cleanup {
    Write-Host "清理系统缓存..."
    
    # 清理临时文件
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
    
    # 清理包管理器缓存
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        npm cache clean --force
    }
    
    if (Get-Command docker -ErrorAction SilentlyContinue) {
        docker system prune -f
    }
    
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        choco cache remove
    }
    
    Write-Host "清理完成!"
}

# 开发环境检查
function Test-DevEnvironment {
    Write-Host "=== 开发环境检查 ===" -ForegroundColor Cyan
    
    $tools = @{
        "Node.js" = { node --version }
        "npm" = { npm --version }
        "Python" = { python --version }
        "Go" = { go version }
        "Git" = { git --version }
        "Docker" = { docker --version }
        "VSCode" = { code --version }
        "PowerShell" = { $PSVersionTable.PSVersion }
    }
    
    foreach ($tool in $tools.GetEnumerator()) {
        try {
            $version = & $tool.Value 2>$null
            Write-Host "$($tool.Key): $($version | Select-Object -First 1)" -ForegroundColor Green
        } catch {
            Write-Host "$($tool.Key): 未安装" -ForegroundColor Red
        }
    }
}

# Claude Code工作流程
function Start-Claude {
    Write-Host "🤖 启动Claude Code工作流程..." -ForegroundColor Cyan
    Write-Host "1. 回忆项目状态"
    Write-Host "2. 检查项目健康度"
    Write-Host "3. 开始开发工作"
    
    # 自动运行健康检查
    $scriptPath = "$env:GLOBAL_RULES_DIR\scripts\health-check.sh"
    if (Test-Path $scriptPath) {
        Write-Host "正在运行项目健康检查..."
        & bash $scriptPath .
    }
}

# 设置别名
Set-Alias newproject New-Project
Set-Alias healthcheck Invoke-HealthCheck
Set-Alias deploycheck Invoke-DeployCheck
Set-Alias ff Find-File
Set-Alias fd Find-Directory
Set-Alias backup Backup-File
Set-Alias myip Get-MyIP
Set-Alias cleanup Invoke-Cleanup
Set-Alias devcheck Test-DevEnvironment
Set-Alias claude Start-Claude

# Oh My Posh配置（如果已安装）
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
}

# PSReadLine配置
if (Get-Module PSReadLine -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# 启动消息
if ($Host.UI.RawUI.WindowSize.Width -gt 0) {
    Write-Host "🚀 70个项目统一开发环境已加载!" -ForegroundColor Green
    Write-Host "💡 输入 'devcheck' 检查开发环境" -ForegroundColor Yellow
    Write-Host "🔧 输入 'claude' 启动Claude Code工作流程" -ForegroundColor Yellow
}

# 加载本地配置（如果存在）
$localProfile = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.local.ps1"
if (Test-Path $localProfile) {
    . $localProfile
}