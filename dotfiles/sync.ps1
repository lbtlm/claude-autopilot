# sync.ps1 - Windows PowerShell 配置同步脚本
# 用于同步dotfiles配置到Windows系统中

param(
    [switch]$Backup,
    [switch]$Extensions,
    [switch]$Verify,
    [switch]$SkipVSCode,
    [switch]$SkipGit,
    [switch]$SkipShell,
    [switch]$Help
)

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
║                  🔄 Dotfiles 配置同步工具                    ║
║                                                              ║
║         同步VSCode、Git、Shell配置到Windows环境               ║
╚══════════════════════════════════════════════════════════════╝
"@ "Cyan"
}

# 获取脚本目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DotfilesDir = $ScriptDir

# 备份现有配置
function Backup-ExistingConfig {
    Write-Info "备份现有配置文件..."
    
    $BackupDir = "$env:USERPROFILE\.dotfiles_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
    
    # 备份VSCode配置
    $VSCodeUserDir = "$env:APPDATA\Code\User"
    if (Test-Path $VSCodeUserDir) {
        Copy-Item -Path $VSCodeUserDir -Destination "$BackupDir\vscode_user" -Recurse -ErrorAction SilentlyContinue
    }
    
    # 备份Git配置
    if (Test-Path "$env:USERPROFILE\.gitconfig") {
        Copy-Item -Path "$env:USERPROFILE\.gitconfig" -Destination $BackupDir -ErrorAction SilentlyContinue
    }
    if (Test-Path "$env:USERPROFILE\.gitmessage") {
        Copy-Item -Path "$env:USERPROFILE\.gitmessage" -Destination $BackupDir -ErrorAction SilentlyContinue
    }
    
    # 备份PowerShell配置
    $PSProfile = $PROFILE
    if (Test-Path $PSProfile) {
        Copy-Item -Path $PSProfile -Destination $BackupDir -ErrorAction SilentlyContinue
    }
    
    if ((Get-ChildItem $BackupDir -ErrorAction SilentlyContinue).Count -gt 0) {
        Write-Success "配置文件已备份到: $BackupDir"
    } else {
        Remove-Item $BackupDir -Force
        Write-Info "没有找到需要备份的配置文件"
    }
}

# 同步VSCode配置
function Sync-VSCodeConfig {
    Write-Info "同步VSCode配置..."
    
    $VSCodeUserDir = "$env:APPDATA\Code\User"
    
    if (-not (Test-Path $VSCodeUserDir)) {
        Write-Warning "VSCode用户配置目录不存在，创建目录: $VSCodeUserDir"
        New-Item -ItemType Directory -Path $VSCodeUserDir -Force | Out-Null
    }
    
    # 同步配置文件
    if (Test-Path "$DotfilesDir\vscode\settings.json") {
        Copy-Item -Path "$DotfilesDir\vscode\settings.json" -Destination $VSCodeUserDir -Force
        Write-Success "已同步 settings.json"
    }
    
    if (Test-Path "$DotfilesDir\vscode\keybindings.json") {
        Copy-Item -Path "$DotfilesDir\vscode\keybindings.json" -Destination $VSCodeUserDir -Force
        Write-Success "已同步 keybindings.json"
    }
    
    if (Test-Path "$DotfilesDir\vscode\extensions.json") {
        Copy-Item -Path "$DotfilesDir\vscode\extensions.json" -Destination $VSCodeUserDir -Force
        Write-Success "已同步 extensions.json"
    }
    
    # 同步代码片段
    if (Test-Path "$DotfilesDir\vscode\snippets") {
        if (-not (Test-Path "$VSCodeUserDir\snippets")) {
            New-Item -ItemType Directory -Path "$VSCodeUserDir\snippets" -Force | Out-Null
        }
        Copy-Item -Path "$DotfilesDir\vscode\snippets\*" -Destination "$VSCodeUserDir\snippets" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Success "已同步代码片段"
    }
}

# 安装VSCode扩展
function Install-VSCodeExtensions {
    if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
        Write-Warning "VSCode命令行工具未安装，跳过扩展安装"
        return
    }
    
    Write-Info "安装VSCode扩展..."
    
    if (Test-Path "$DotfilesDir\vscode\extensions.json") {
        # 读取扩展列表
        $ExtensionsContent = Get-Content "$DotfilesDir\vscode\extensions.json" -Raw
        $Extensions = ($ExtensionsContent | ConvertFrom-Json).recommendations
        
        foreach ($Extension in $Extensions) {
            if ($Extension -and $Extension.Trim() -ne "") {
                Write-Info "安装扩展: $Extension"
                try {
                    & code --install-extension $Extension --force 2>$null
                } catch {
                    Write-Warning "安装扩展失败: $Extension"
                }
            }
        }
        
        Write-Success "VSCode扩展安装完成"
    }
}

# 同步Git配置
function Sync-GitConfig {
    Write-Info "同步Git配置..."
    
    if (Test-Path "$DotfilesDir\git\.gitconfig") {
        Copy-Item -Path "$DotfilesDir\git\.gitconfig" -Destination "$env:USERPROFILE\.gitconfig" -Force
        Write-Success "已同步 .gitconfig"
    }
    
    if (Test-Path "$DotfilesDir\git\.gitmessage") {
        Copy-Item -Path "$DotfilesDir\git\.gitmessage" -Destination "$env:USERPROFILE\.gitmessage" -Force
        Write-Success "已同步 .gitmessage"
    }
    
    if (Test-Path "$DotfilesDir\git\.gitignore_global") {
        Copy-Item -Path "$DotfilesDir\git\.gitignore_global" -Destination "$env:USERPROFILE\.gitignore_global" -Force
        # 设置全局忽略文件
        try {
            & git config --global core.excludesfile "$env:USERPROFILE\.gitignore_global" 2>$null
            Write-Success "已同步全局 .gitignore"
        } catch {
            Write-Warning "设置全局.gitignore失败"
        }
    }
    
    # 设置Git提交模板
    if (Test-Path "$env:USERPROFILE\.gitmessage") {
        try {
            & git config --global commit.template "$env:USERPROFILE\.gitmessage" 2>$null
        } catch {
            Write-Warning "设置Git提交模板失败"
        }
    }
    
    # 设置Windows特定的Git配置
    try {
        & git config --global core.autocrlf true 2>$null
        & git config --global core.editor "code --wait" 2>$null
    } catch {
        Write-Warning "设置Windows特定Git配置失败"
    }
}

# 同步PowerShell配置
function Sync-ShellConfig {
    Write-Info "同步PowerShell配置..."
    
    if (Test-Path "$DotfilesDir\shell\profile.ps1") {
        # 确保PowerShell配置文件目录存在
        $ProfileDir = Split-Path $PROFILE -Parent
        if (-not (Test-Path $ProfileDir)) {
            New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
        }
        
        Copy-Item -Path "$DotfilesDir\shell\profile.ps1" -Destination $PROFILE -Force
        Write-Success "已同步 PowerShell Profile"
    }
}

# 同步项目模板
function Sync-ProjectTemplates {
    Write-Info "同步项目模板..."
    
    $TemplatesDir = "$env:USERPROFILE\.project_templates"
    
    if (Test-Path "$DotfilesDir\project-templates") {
        # 创建模板目录
        if (-not (Test-Path $TemplatesDir)) {
            New-Item -ItemType Directory -Path $TemplatesDir -Force | Out-Null
        }
        
        # 复制模板文件
        Copy-Item -Path "$DotfilesDir\project-templates\*" -Destination $TemplatesDir -Recurse -Force -ErrorAction SilentlyContinue
        
        Write-Success "已同步项目模板到: $TemplatesDir"
    }
}

# 验证同步结果
function Test-SyncResult {
    Write-Info "验证同步结果..."
    
    $Errors = 0
    
    # 检查VSCode配置
    $VSCodeSettings = "$env:APPDATA\Code\User\settings.json"
    if (Test-Path $VSCodeSettings) {
        Write-Success "VSCode配置文件存在"
    } else {
        Write-Error "VSCode配置文件不存在"
        $Errors++
    }
    
    # 检查Git配置
    if (Test-Path "$env:USERPROFILE\.gitconfig") {
        Write-Success "Git配置文件存在"
    } else {
        Write-Error "Git配置文件不存在"
        $Errors++
    }
    
    # 检查PowerShell配置
    if (Test-Path $PROFILE) {
        Write-Success "PowerShell配置文件存在"
    } else {
        Write-Error "PowerShell配置文件不存在"
        $Errors++
    }
    
    if ($Errors -eq 0) {
        Write-Success "所有配置文件同步成功！"
        return $true
    } else {
        Write-Error "发现 $Errors 个问题，请检查上述错误"
        return $false
    }
}

# 显示使用说明
function Show-Usage {
    Write-Host @"
用法: .\sync.ps1 [选项]

选项:
  -Backup                 同步前备份现有配置
  -Extensions             安装VSCode扩展
  -Verify                 验证同步结果
  -SkipVSCode            跳过VSCode配置同步
  -SkipGit               跳过Git配置同步
  -SkipShell             跳过Shell配置同步
  -Help                  显示帮助信息

示例:
  .\sync.ps1                      # 标准同步
  .\sync.ps1 -Backup -Extensions -Verify  # 备份、同步、安装扩展、验证
  .\sync.ps1 -SkipVSCode          # 跳过VSCode配置
"@
}

# 主函数
function Main {
    if ($Help) {
        Show-Usage
        return
    }
    
    Write-Header
    
    Write-Info "开始同步dotfiles配置..."
    Write-Info "Dotfiles目录: $DotfilesDir"
    Write-Info "操作系统: Windows"
    
    # 备份现有配置
    if ($Backup) {
        Backup-ExistingConfig
    }
    
    # 同步各项配置
    if (-not $SkipVSCode) {
        Sync-VSCodeConfig
        if ($Extensions) {
            Install-VSCodeExtensions
        }
    }
    
    if (-not $SkipGit) {
        Sync-GitConfig
    }
    
    if (-not $SkipShell) {
        Sync-ShellConfig
    }
    
    # 同步项目模板
    Sync-ProjectTemplates
    
    # 验证结果
    if ($Verify) {
        $SyncSuccess = Test-SyncResult
    } else {
        $SyncSuccess = $true
    }
    
    Write-Host ""
    if ($SyncSuccess) {
        Write-Success "🎉 Dotfiles同步完成！"
        Write-Info "💡 建议重启PowerShell或VSCode以使配置生效"
        Write-Info "🔧 如需自定义配置，请编辑相应的配置文件"
        Write-Info "🚀 重新加载PowerShell配置: . `$PROFILE"
    } else {
        Write-Error "同步过程中发现问题，请检查上述错误信息"
    }
}

# 执行主函数
Main