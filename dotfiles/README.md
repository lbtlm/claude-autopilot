# Dotfiles - 70个项目统一配置管理

## 📋 概述

这是一个跨平台的开发环境配置同步仓库，为70个项目管理提供统一的配置文件和开发环境。支持Windows和macOS的无缝切换和配置同步。

## 🎯 功能特性

- **🔄 跨平台同步**: Windows和macOS配置文件自动同步
- **⚙️ VSCode统一配置**: 插件、设置、任务配置标准化
- **🔧 Shell环境标准化**: 别名、环境变量、工具配置统一
- **📦 项目模板集成**: 70个项目的标准化模板
- **🤖 Claude Code集成**: Memory MCP和其他MCP标准配置

## 📁 目录结构

```
dotfiles/
├── README.md                # 本文件
├── install.sh              # macOS/Linux 安装脚本  
├── install.ps1             # Windows 安装脚本
├── sync.sh                 # macOS/Linux 同步脚本
├── sync.ps1                # Windows 同步脚本
├── backup.sh               # 配置备份脚本
├── .gitignore              # Git忽略文件
│
├── vscode/                 # VSCode配置
│   ├── settings.json       # 用户设置
│   ├── keybindings.json    # 快捷键配置
│   ├── tasks.json          # 任务配置
│   ├── launch.json         # 调试配置
│   ├── extensions.json     # 扩展清单
│   └── snippets/           # 代码片段
│
├── git/                    # Git配置
│   ├── .gitconfig          # Git全局配置
│   ├── .gitmessage         # 提交模板
│   └── .gitignore_global   # 全局忽略文件
│
├── shell/                  # Shell配置
│   ├── .zshrc              # macOS zsh配置
│   ├── .bashrc             # Linux bash配置  
│   ├── profile.ps1         # Windows PowerShell配置
│   ├── aliases.sh          # 通用别名
│   └── exports.sh          # 环境变量
│
├── scripts/                # 实用脚本
│   ├── setup-env.sh        # 环境初始化
│   ├── new-project.sh      # 新项目创建
│   ├── health-check.sh     # 项目健康检查
│   └── deploy-check.sh     # 部署前检查
│
└── project-templates/      # 项目模板
    ├── global_rules/       # 全局规则和模板
    ├── vue3-frontend/      # Vue3前端模板
    ├── gin-microservice/   # Gin微服务模板
    └── go-desktop/         # Go桌面应用模板
```

## 🚀 快速开始

### **1. 克隆仓库**
```bash
# 建议克隆到用户目录
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### **2. 运行安装脚本**

**macOS/Linux:**
```bash
./install.sh
```

**Windows (PowerShell as Administrator):**
```powershell
.\install.ps1
```

### **3. 同步配置**
```bash
# macOS/Linux
./sync.sh

# Windows  
.\sync.ps1
```

## ⚙️ 配置说明

### **VSCode配置**
- **settings.json**: 统一的编辑器设置、格式化规则、主题配置
- **keybindings.json**: 标准化的快捷键映射
- **extensions.json**: 必装插件清单（包括Claude Code、GitHub Copilot等）
- **tasks.json**: 项目构建、测试、部署任务模板
- **snippets/**: 各种语言的代码片段

### **Git配置**
- **全局用户配置**: 姓名、邮箱、默认编辑器
- **提交模板**: Conventional Commits标准模板
- **别名配置**: 常用Git命令简化
- **全局忽略**: 系统文件、IDE文件等

### **Shell配置**
- **开发工具别名**: 简化常用命令
- **项目导航**: 快速切换项目目录
- **环境变量**: 开发工具路径配置
- **提示符美化**: 显示Git状态、项目信息

## 🔄 使用流程

### **日常同步**
```bash
# 每天开始工作前
cd ~/dotfiles && ./sync.sh

# 修改配置后推送
git add . && git commit -m "update: 配置更新" && git push
```

### **新机器设置**
```bash
# 1. 克隆dotfiles
git clone https://github.com/your-username/dotfiles.git ~/dotfiles

# 2. 运行安装脚本
cd ~/dotfiles && ./install.sh

# 3. 重启终端/VSCode使配置生效
```

### **配置更新**
```bash
# 1. 修改dotfiles中的配置文件
# 2. 运行同步脚本应用更改
./sync.sh

# 3. 提交并推送更改
git add . && git commit -m "feat: 新增XX配置" && git push
```

## 📦 集成的项目模板

### **可用模板**
- **Vue3前端项目**: Vite + TypeScript + Element Plus
- **Gin微服务**: Go + PostgreSQL + Docker  
- **Go桌面应用**: Fyne/Walk + SQLite
- **Python桌面**: tkinter + PyInstaller
- **FastAPI后端**: Python + PostgreSQL + Docker

### **使用项目模板**
```bash
# 创建新项目
~/dotfiles/scripts/new-project.sh my-app vue3-frontend

# 项目健康检查
~/dotfiles/scripts/health-check.sh /path/to/project

# 部署前检查
~/dotfiles/scripts/deploy-check.sh /path/to/project
```

## 🤖 Claude Code集成

### **Memory MCP配置**
- **自动记忆**: 项目状态、技术决策、解决方案
- **知识复用**: 跨项目经验共享
- **智能提示**: 基于历史记录的建议

### **标准工作流程**
1. **开始工作**: Claude Code自动回忆项目状态
2. **开发过程**: 实时记录重要决策和解决方案  
3. **问题解决**: 查找历史相似问题的解决方案
4. **结束工作**: 自动保存进展和项目状态

## 🔧 自定义配置

### **添加新的配置文件**
```bash
# 1. 将配置文件添加到对应目录
cp ~/.vscode/settings.json ~/dotfiles/vscode/

# 2. 更新同步脚本
# 编辑 sync.sh 或 sync.ps1 添加同步规则

# 3. 测试同步
./sync.sh
```

### **平台特定配置**
```bash
# 在配置文件中使用条件判断
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific config
elif [[ "$OSTYPE" == "msys" ]]; then
    # Windows specific config
fi
```

## 📋 维护指南

### **定期维护任务**
- **每周**: 更新扩展清单，清理无用配置
- **每月**: 备份重要配置，检查同步脚本
- **每季度**: 评估配置效果，优化工作流程

### **故障排除**
- **同步失败**: 检查文件权限和路径
- **VSCode插件问题**: 重新安装扩展
- **Shell配置不生效**: 重新加载配置文件
- **Git配置问题**: 检查用户信息和SSH密钥

## 🤝 贡献指南

1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feature/new-config`)
3. 提交更改 (`git commit -m 'feat: 添加新配置'`)
4. 推送到分支 (`git push origin feature/new-config`)
5. 创建 Pull Request

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

**📅 创建时间**: 2024-07-19  
**🎯 适用范围**: 70个项目统一管理  
**🔄 版本**: v1.0  
**⚡ 核心价值**: 跨平台开发环境标准化