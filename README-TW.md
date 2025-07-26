# Claude Autopilot 2.1 - 智能開發環境自動配置工具

**🌐 語言版本 | Language Versions**
- [简体中文](README.md) | [繁體中文](README-TW.md) | [English](README-EN.md)

> 🛩️ 讓Claude駕駛您的開發過程，一鍵式AI協作開發環境配置，支援多種專案類型的自動化智能配置

## 📋 專案简介

Claude Autopilot 2.1 是一个开源的智能開發環境配置工具，专为现代開發者设计。通过简单的命令行操作，让Claude自动驾驶您的專案配置过程，为專案配置完美的AI协作開發環境，支援多种编程语言和框架。

### ✨ 核心特性

- 🛩️ **自动驾驶配置** - 让Claude接管專案配置，解放双手
- 🤖 **智能检测** - 自动识别專案类型和技术栈
- 🌍 **开源友好** - 支援任意路径部署，无硬编码依赖
- 📚 **多语言支援** - 支援Go、JavaScript、Python、Bash等多种语言
- 🔧 **开箱即用** - 无需复杂配置，即装即用

## 📋 系统要求

### 🛠️ 必需依赖

#### 1. **Claude Code CLI** (必需)
Claude Autopilot 2.1 依赖 Claude Code CLI 进行智能開發：

```bash
# 安装Claude Code CLI
# 方法1: 通过官方安装脚本
curl -fsSL https://claude.ai/install.sh | sh

# 方法2: 通过包管理器 (如果支援)
# npm install -g @anthropic/claude-code  # 示例，以官方文档为准
# pip install claude-code              # 示例，以官方文档为准

# 验证安装
claude --version
```

#### 2. **MCP (Model Context Protocol) 服务器** (可选但推荐)
为了获得最佳智能開發体验，建议安装以下MCP服务器：

**🧠 核心智能工具包：**

```bash
# 1. Sequential Thinking - 复杂任务分解和分析
npm install -g @mcp/sequential-thinking

# 2. Context7 - 动态技术文档获取
npm install -g @mcp/context7

# 3. Memory - 開發经验记忆和复用
npm install -g @mcp/memory

# 4. Puppeteer - Web專案自动化测试 (可选)
npm install -g @mcp/puppeteer
```

**📦 MCP服务器配置 (在Claude Code中)：**

创建或更新 `~/.claude/mcp-servers.json`：

```json
{
  "servers": {
    "sequential-thinking": {
      "command": "npx",
      "args": ["@mcp/sequential-thinking"]
    },
    "context7": {
      "command": "npx", 
      "args": ["@mcp/context7"]
    },
    "memory": {
      "command": "npx",
      "args": ["@mcp/memory"]
    },
    "puppeteer": {
      "command": "npx",
      "args": ["@mcp/puppeteer"]
    }
  }
}
```

**⚠️ 注意**：MCP服务器包名和配置方式以官方文档为准，上述仅为示例。

#### 3. **系统工具**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install git make curl shellcheck

# macOS
brew install git make curl shellcheck

# CentOS/RHEL
sudo yum install git make curl
# ShellCheck需要单独安装: https://github.com/koalaman/shellcheck
```

### ✅ 安装验证

运行以下命令验证環境：

```bash
# 检查必需工具
claude --version          # Claude Code CLI
git --version             # Git版本控制
make --version            # Make构建工具
shellcheck --version      # Shell代码检查 (可选)

# 检查可选工具
node --version            # Node.js (MCP服务器需要)
npm --version             # npm包管理器
```

---

## 🚀 快速开始

### 1. 克隆和安装

#### 🐧 Linux / macOS 用户

```bash
# 克隆專案
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot

# 设置脚本执行权限（自动完成）
make dev-setup
```

#### 🪟 Windows 用户

**推荐方式 - 使用WSL (Windows Subsystem for Linux):**

```bash
# 1. 安装WSL2 (如果未安装)
# 在PowerShell中以管理员身份运行：
wsl --install

# 2. 在WSL中执行
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot
make dev-setup
```

**备选方式 - 使用Git Bash:**

```bash
# 1. 安装Git for Windows (包含Git Bash)
# 2. 在Git Bash中执行
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot

# 手动设置执行权限 (Git Bash環境)
chmod +x scripts/*.sh
chmod +x lib/*.sh
```

**注意事项:**
- ⚠️ 不支援纯Windows Command Prompt或PowerShell
- ✅ 推荐使用WSL2获得最佳兼容性
- ⚡ Git Bash可以运行，但某些功能可能受限

### 2. 基本使用

**🎯 推荐方式 - 使用Makefile（最简单）：**

```bash
# 交互式配置（新手友好）
make setup

# 快速配置当前目录
make quick-setup

# 配置指定專案
make quick-setup PROJECT=/path/to/your/project

# 配置新專案并指定类型
make inject-type PROJECT=/path/to/new/project TYPE=gin-microservice
```

**⚡ 直接使用脚本（高级用户）：**

```bash
# 交互式配置
./scripts/setup.sh

# 快速配置
./scripts/quick-setup.sh [專案路径] [專案类型]
```

## 📖 详细使用说明

### 🎯 核心使用方式

Claude Autopilot 2.1 提供了三种使用方式，从简单到高级：

#### 方式1: Makefile命令（⭐ 推荐）

**最简单的使用方式，一键完成所有操作：**

```bash
# 查看所有可用命令
make help

# 🚀 快速开始（新手推荐）
make setup                                           # 交互式配置
make quick-setup                                     # 快速配置当前目录

# 🎯 高级功能
make inject PROJECT=/path/to/project                 # 自动检测專案类型
make inject-type PROJECT=/path/to/new TYPE=vue3      # 指定專案类型
make inject-batch PROJECTS_DIR=/path/to/projects     # 批量配置

# 🔧 開發工具
make lint                                            # 代码质量检查
make test                                            # 运行测试
make dev-setup                                       # 设置開發環境
```

#### 方式2: 直接使用脚本

**适合需要更多控制的高级用户：**

```bash
# 核心脚本
./scripts/setup.sh                                  # 交互式配置
./scripts/quick-setup.sh                            # 快速配置
./bin/claude-autopilot [專案路径] [專案类型]        # 核心注入脚本

# 专用工具
./scripts/quality-check/health-check.sh             # 健康检查
./scripts/project-management/new_project.sh         # 新專案创建
```

#### 方式3: 系统安装（可选）

**安装到系统后全局使用：**

```bash
# 安装到系统
sudo make install

# 全局使用
ce-inject /path/to/project                          # 直接使用
setup.sh                                            # 全局交互式配置
```

### 🏷️ 支援的專案类型

| 專案类型 | 说明 | 技术栈 |
|---------|------|--------|
| `gin-microservice` | Go微服务 | Go + Gin + 数据库 |
| `gin-vue3` | 全栈应用 | Go + Gin + Vue3 |
| `vue3-frontend` | Vue3前端 | Vue3 + TypeScript + Vite |
| `react-frontend` | React前端 | React + TypeScript |
| `nextjs-frontend` | Next.js应用 | Next.js + React |
| `nodejs-general` | Node.js应用 | Node.js + Express |
| `python-web` | Python Web | FastAPI/Flask/Django |
| `python-desktop` | Python桌面 | tkinter/PyQt |
| `bash-scripts` | Bash脚本 | Shell Scripts |
| `java-maven` | Java Maven | Java + Maven |
| `java-gradle` | Java Gradle | Java + Gradle |
| `rust-project` | Rust專案 | Rust + Cargo |
| `php-project` | PHP專案 | PHP + Composer |

### 🎯 使用场景

#### 场景1：新專案创建

```bash
# 🎯 使用Makefile（推荐）
make setup                                            # 交互式创建
make inject-type PROJECT=my-vue3-app TYPE=vue3       # 直接创建

# ⚡ 使用脚本
./scripts/setup.sh                                   # 交互式菜单
mkdir my-vue3-app && ./scripts/quick-setup.sh my-vue3-app vue3-frontend
```

#### 场景2：现有專案配置

```bash
# 🎯 使用Makefile（推荐）
make inject PROJECT=/path/to/existing/project        # 自动检测类型

# ⚡ 使用脚本
cd /path/to/existing/project
./scripts/quick-setup.sh .
```

#### 场景3：多專案批量配置

```bash
# 🎯 使用Makefile（推荐）
make inject-batch PROJECTS_DIR=/path/to/projects     # 一键批量配置

# ⚡ 使用脚本
for project in /path/to/projects/*; do
    ./scripts/quick-setup.sh "$project"
done
```

### 🏥 專案健康度检查

使用健康度检查功能评估專案状态：

```bash
# 🎯 使用Makefile（推荐）
make health-check                                     # 检查当前專案

# ⚡ 使用脚本
./scripts/setup.sh                                   # 交互式菜单选择选项4
./scripts/quality-check/health-check.sh /path/to/project    # 直接检查
```

## 🔧 配置完成后

配置完成后，您的專案将包含：

### 📁 新增的文件和目录

```
your-project/
├── .claude/                 # Claude Code配置
│   ├── project.json        # 專案配置文件
│   └── commands/           # 智能命令链接
├── CLAUDE.md              # AI协作指南
├── project_process/       # 開發过程记录
├── project_docs/          # 專案文档
├── .vscode/              # VSCode配置
├── .editorconfig         # 编辑器配置
└── Makefile             # 构建命令
```

### 🎯 可用的智能命令

配置完成後，在Claude Code中可以使用以下智能命令：

## 🚀 **核心開發命令** - 日常開發必備

### 1. 🔧 智能功能開發 `/智能功能開發` 或 `/smart-feature-dev`

**快速開始新功能開發，從設計到實現的完整流程**

```bash
# 基礎用法
/智能功能開發 用戶登錄功能
/smart-feature-dev user authentication system

# 詳細用法
/智能功能開發 創建一個Vue3的用戶管理介面，包含增刪改查功能
/智能功能開發 實現JWT認證的API端點，支援登錄、註冊、刷新token
```

**功能特點:**

- ✨ 自動分析功能需求並拆解任務
- 🏗️ 生成符合專案架構的程式碼結構
- 🧪 創建相關測試檔案
- 📝 更新專案文件

---

### 2. 🐛 智能Bug修復 `/智能Bug修復` 或 `/smart-bugfix`

**快速診斷和修復程式碼問題，支援多種程式語言**

```bash
# 基礎用法
/智能Bug修復 頁面載入緩慢
/smart-bugfix API返回500錯誤

# 詳細用法
/智能Bug修復 Vue元件渲染異常，控制台顯示Cannot read property of undefined
/智能Bug修復 資料庫連接超時，查詢時間超過30秒
```

**功能特點:**

- 🔍 智能程式碼分析和問題定位
- 🛠️ 提供多種修復方案
- 📊 效能優化建議
- 🧪 驗證修復效果

---

### 3. 🔄 智能程式碼重構 `/智能代码重构` 或 `/smart-code-refactor`

**基於最佳實踐的程式碼重構和優化**

```bash
# 基礎用法
/智能代码重构 優化資料庫查詢
/smart-code-refactor improve component structure

# 詳細用法
/智能代码重构 將類別元件重構為函數元件，使用Hooks
/智能代码重构 優化API介面，實現快取和分頁功能
```

**功能特點:**

- 🎯 遵循程式碼最佳實踐
- ⚡ 效能優化建議
- 🧹 程式碼清理和規範化
- 📚 架構改進建議

---

## 🛠️ **專案管理命令** - 專案維護工具

### 4. 🔄 載入全域上下文 `/加载全局上下文` 或 `/load-global-context`

**重新載入Claude Autopilot環境和專案上下文**

```bash
# 基礎用法
/加载全局上下文
/load-global-context

# 強制刷新模式
/加载全局上下文 --force-refresh
/load-global-context --force-refresh
```

**使用場景:**

- 🔧 更新專案配置後
- 🚨 命令無法識別時
- 📝 修改專案類型後
- 🔄 環境變更後

---

### 5. 📊 專案狀態分析 `/專案状态分析` 或 `/project-status-analysis`

**全面分析專案健康度和技術債務**

```bash
# 基礎用法
/專案状态分析
/project-status-analysis

# 詳細分析
/專案状态分析 --detailed
/project-status-analysis --with-suggestions
```

**分析內容:**

- 🏗️ 專案架構合規性
- 📦 依賴版本和安全性
- 🧪 測試覆蓋率分析
- 📝 文件完整性檢查
- 🚀 效能瓶頸識別

---

### 6. 🧹 專案清理重組 `/清理残余文件` 或 `/cleanup-project`

**智能清理專案檔案，符合GNU編碼標準**

```bash
# 完整互動式清理
/清理残余文件
/cleanup-project

# 自動模式（跳過確認）
/cleanup-project --auto

# 預覽模式（僅顯示不執行）
/cleanup-project --dry-run

# 深度清理模式
/cleanup-project --deep
```

**清理內容:**

- 🗑️ 臨時檔案和快取
- 📁 非標準目錄結構
- 🔄 重複和冗餘檔案
- 🏗️ 不符合專案架構的檔案
- 💾 備份舊檔案（安全清理）

---

### 7. 📤 提交到GitHub `/提交github` 或 `/commit-github`

**智能Git提交，生成規範的提交信息**

```bash
# 基礎用法
/提交github
/commit-github

# 指定提交類型
/commit-github --type feat
/commit-github --type fix
```

**功能特點:**

- 📝 自動分析程式碼變更
- 🎯 生成符合Conventional Commits規範的提交信息
- 🔍 程式碼品質檢查
- 🚀 自動推送到遠端儲存庫

---

## 💡 **使用技巧**

### 🎯 **快速上手**

1. **新專案開發**: 使用 `/智能功能開發` 快速創建功能
2. **問題解決**: 遇到bug時使用 `/智能Bug修復`
3. **程式碼優化**: 定期使用 `/智能代码重构` 改進程式碼品質
4. **專案維護**: 使用 `/專案状态分析` 和 `/清理残余文件` 保持專案健康

### 🔄 **命令組合使用**

```bash
# 完整開發流程示例
1. /專案状态分析                    # 分析專案當前狀態
2. /智能功能開發 新功能需求          # 開發新功能  
3. /智能代码重构 優化新功能          # 重構和優化
4. /清理残余文件                   # 清理臨時檔案
5. /提交github                     # 提交程式碼
```

### 📝 **最佳實踐**

- ✅ 詳細描述需求，獲得更準確的結果
- ✅ 定期使用專案維護命令
- ✅ 組合使用多個命令完成複雜任務
- ✅ 利用參數選項定制命令行為

### 🚀 开始使用

1. **启动Claude Code**：
   ```bash
   cd your-project
   claude code
   ```

2. **直接描述需求**：
   - "帮我创建用户登录功能"
   - "优化数据库查询性能"
   - "添加单元测试"

3. **享受Claude驾驶的智能開發体验**！

## 📁 專案结构详解

### 🏗️ 核心目录结构

```
claude-autopilot/
├── 📁 scripts/                    # 核心脚本目录 (主要入口)
│   ├── 🚀 setup.sh               # 交互式配置脚本 (新手推荐)
│   ├── ⚡ quick-setup.sh          # 快速配置脚本 (熟练用户)
│   ├── 🔧 ce-inject.sh           # 核心注入脚本 (核心引擎)
│   ├── 📁 project-management/    # 專案管理工具
│   ├── 📁 quality-check/         # 质量检查工具
│   └── 📁 autopilot/                 # Autopilot 2.1 智能系统
│
├── 📁 share/claude-autopilot/    # 智能上下文引擎
│   ├── 📁 project-types/         # 專案类型模板 (关键配置)
│   │   ├── gin-microservice.md   # Go微服务配置
│   │   ├── vue3-frontend.md      # Vue3前端配置
│   │   ├── react-frontend.md     # React前端配置
│   │   ├── python-web.md         # Python Web配置
│   │   └── ... (更多專案类型)
│   │
│   ├── 📁 commands/              # 智能命令定义
│   ├── 📁 utils/                 # 工具函数库
│   ├── 📁 templates/             # 文件模板
│   └── command-aliases.json      # 命令别名配置
│
├── 🔧 Makefile                   # 统一构建接口 (推荐入口)
├── 📖 README.md                  # 專案文档 (本文件)
├── 📖 README-EN.md               # 英文版文档
├── 📖 README-TW.md               # 繁体中文版文档
├── 📋 CLAUDE.md                  # Claude Code 配置指南
└── 📄 VERSION                    # 版本信息
```

### 🎯 核心组件说明

#### 1. **scripts/ - 脚本入口目录**
- **setup.sh** - 交互式配置，适合新手，提供友好的菜单界面
- **quick-setup.sh** - 快速配置，适合熟练用户，命令行直接使用
- **ce-inject.sh** - 核心注入引擎，所有配置逻辑的实现

#### 2. **share/claude-autopilot/ - 智能引擎核心**
- **project-types/** - 各种專案类型的配置模板和最佳实践
- **commands/** - 智能命令链接，支援中英文命令
- **utils/** - 核心工具函数，提供可复用的功能模块

#### 3. **Makefile - 统一接口**
- 提供所有功能的统一入口点
- 自动处理脚本权限和依赖
- 支援从简单到高级的各种使用场景

### 🎨 使用入口层次

```
🏁 入口层次 (从简单到高级)

1️⃣ Makefile接口 (推荐，最简单)
   make setup                    # 新手友好的交互式配置
   make quick-setup              # 一键快速配置
   make inject PROJECT=/path     # 高级批量配置

2️⃣ 脚本直接调用 (更多控制)
   ./scripts/setup.sh            # 交互式菜单
   ./scripts/quick-setup.sh      # 快速配置
   ./bin/claude-autopilot        # 直接引擎调用

3️⃣ 系统安装 (全局使用)
   sudo make install             # 安装到系统
   ce-inject /path/to/project    # 全局命令使用
```

### 💡 设计理念

- **🛩️ 自动驾驶优先** - 让Claude接管重复性配置工作
- **🔧 灵活配置** - 高级用户可以直接调用脚本获得更多控制
- **🧠 智能感知** - 自动检测專案类型和技术栈
- **🌍 开源友好** - 无硬编码路径，支援任意環境部署

## 🛠️ 高级配置

### 自定义專案类型

如果您需要支援新的專案类型：

1. 在 `share/claude-autopilot/project-types/` 目录下创建新的配置文件
2. 参考现有配置文件的格式（推荐复制类似專案类型进行修改）
3. 重新运行配置脚本

#### 🔨 创建自定义專案类型示例

```bash
# 1. 创建新的專案类型配置
cp share/claude-autopilot/project-types/gin-microservice.md \
   share/claude-autopilot/project-types/my-custom-type.md

# 2. 编辑配置文件，修改專案描述和模板
vim share/claude-autopilot/project-types/my-custom-type.md

# 3. 测试新配置
./scripts/quick-setup.sh /path/to/test/project my-custom-type
```

### 環境变量配置

可以通过環境变量自定义配置：

```bash
# 自定义安装路径
export CE_INSTALL_PATH="/custom/path"

# 默认專案类型
export CE_DEFAULT_PROJECT_TYPE="gin-microservice"

# 启用调试模式
export CE_DEBUG=true

# 自定义模板目录
export CE_TEMPLATE_DIR="/custom/templates"
```

## 🤝 贡献指南

欢迎贡献代码！请遵循以下步骤：

1. Fork 本仓库
2. 创建功能分支：`git checkout -b feature/amazing-feature`
3. 提交更改：`git commit -m 'Add amazing feature'`
4. 推送分支：`git push origin feature/amazing-feature`
5. 提交Pull Request

### 開發環境设置

```bash
# 为本專案配置開發環境
./scripts/quick-setup.sh . bash-scripts
```

## 📄 许可证

本專案采用 MIT 许可证。详情请参阅 [LICENSE](LICENSE) 文件。

## 🆘 故障排除

### 🪟 Windows 兼容性问题

#### **Q: 在Windows上运行脚本时出现 "chmod: command not found" 错误**

**症状**: 脚本执行时显示 `chmod: command not found` 或权限相关错误

**解决方案**:

1. **推荐 - 使用WSL2 (最佳体验)**:
   ```bash
   # 安装WSL2后，在Ubuntu環境中运行
   wsl
   cd /mnt/c/path/to/claude-autopilot
   make dev-setup
   ```

2. **备选 - 使用Git Bash**:
   ```bash
   # 在Git Bash中手动设置权限
   find scripts/ -name "*.sh" -exec chmod +x {} \;
   find lib/ -name "*.sh" -exec chmod +x {} \;
   ```

3. **Git配置优化 (一次性设置)**:
   ```bash
   # 在專案目录中运行
   git config core.filemode false
   git update-index --chmod=+x scripts/setup.sh
   git update-index --chmod=+x scripts/quick-setup.sh
   git update-index --chmod=+x bin/claude-autopilot
   ```

#### **Q: 脚本在PowerShell中无法运行**

**症状**: 脚本无法在Windows PowerShell或Command Prompt中执行

**解决方案**: 不支援纯Windows環境，请使用以下方式之一:
- ✅ **WSL2** (推荐): 完全兼容Linux環境
- ✅ **Git Bash**: 基本功能可用
- ❌ **PowerShell/CMD**: 不支援

### 🐧 Linux/macOS 常见问题

**Q: 脚本没有执行权限**
```bash
# 自动设置所有脚本权限
make dev-setup

# 或者手动设置
chmod +x scripts/*.sh
chmod +x lib/*.sh
```

**Q: 找不到ce-inject脚本**
```bash
# 确保專案完整克隆
git clone --recurse-submodules https://github.com/lbtlm/claude-autopilot.git

# 检查脚本是否存在
ls -la bin/claude-autopilot
```

**Q: 專案类型检测失败**
```bash
# 手动指定專案类型
./scripts/quick-setup.sh /path/to/project your-project-type

# 查看支援的專案类型
ls share/claude-autopilot/project-types/
```

### 🔧 通用问题解决

**Q: Makefile命令不工作**
```bash
# 检查make是否安装
which make

# Ubuntu/Debian安装make
sudo apt install build-essential

# macOS安装make
xcode-select --install
```

**Q: 脚本执行权限问题持续存在**
```bash
# 强制重置所有权限
find . -name "*.sh" -exec chmod +x {} \;

# 检查文件系统挂载选项 (WSL用户)
mount | grep "your-drive"
```

**Q: 專案配置后Claude Code无法识别**
```bash
# 检查配置文件是否正确生成
ls -la .claude/

# 验证CLAUDE.md文件
cat CLAUDE.md | head -20

# 重新运行配置
make quick-setup
```

### 获取帮助

- 📖 查看帮助：`./scripts/setup.sh --help`
- 🐛 报告问题：[GitHub Issues](https://github.com/lbtlm/claude-autopilot/issues)
- 💬 讨论交流：[GitHub Discussions](https://github.com/lbtlm/claude-autopilot/discussions)

---

## 🌐 平台兼容性说明

### 📊 兼容性矩阵

| 平台環境 | 兼容性 | 功能完整度 | 推荐等级 | 说明 |
|---------|--------|-----------|----------|------|
| 🐧 **Linux (Ubuntu/Debian/CentOS)** | ✅ 完全支援 | 100% | ⭐⭐⭐⭐⭐ | 原生支援，最佳性能 |
| 🍎 **macOS** | ✅ 完全支援 | 100% | ⭐⭐⭐⭐⭐ | 原生支援，优秀体验 |
| 🪟 **Windows + WSL2** | ✅ 完全支援 | 95% | ⭐⭐⭐⭐⭐ | 推荐方案，几乎原生体验 |
| 🪟 **Windows + Git Bash** | ⚠️ 基本支援 | 80% | ⭐⭐⭐ | 可用，部分功能受限 |
| 🪟 **Windows PowerShell** | ❌ 不支援 | 0% | ❌ | Bash脚本无法运行 |
| 🪟 **Windows Command Prompt** | ❌ 不支援 | 0% | ❌ | Bash脚本无法运行 |

### 🎯 Windows 用户建议

#### **最佳实践 - WSL2 環境**
```bash
# 1. 启用WSL功能 (PowerShell管理员)
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# 2. 安装WSL2和Ubuntu
wsl --install -d Ubuntu

# 3. 在WSL2中使用 (完全兼容)
wsl
cd /mnt/c/your/project/path
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot
make dev-setup
```

#### **备选方案 - Git Bash**
```bash
# 功能受限，但基本可用
# 注意: 某些高级功能可能不工作
chmod +x scripts/*.sh
./scripts/setup.sh
```

### ⚡ 性能对比

| 環境 | 启动速度 | 执行效率 | 稳定性 | 開發体验 |
|-----|---------|----------|--------|----------|
| Linux原生 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 |
| macOS原生 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 |
| WSL2 | 🚀🚀🚀🚀 | 🚀🚀🚀🚀 | 🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 |
| Git Bash | 🚀🚀🚀 | 🚀🚀🚀 | 🚀🚀🚀 | 🚀🚀🚀 |

---

## 🌟 未来计划

### 📈 專案路线图

- ✅ **v2.0 - 核心功能** (前一版本)
  - 多專案类型支援 (18种主流技术栈)
  - 智能命令系统 (中英文双语)
  - 跨平台兼容性 (Linux/macOS/Windows WSL)

- ✅ **v2.1 - Claude Autopilot** (当前版本)
  - 品牌升级为Claude Autopilot
  - 增强的文档系统 (多语言支援)
  - 改进的Windows兼容性
  - 优化的智能命令系统

- 🚧 **v2.2 - 扩展模板** (開發中)
  - 更多前端框架支援 (Svelte, Angular)
  - 移动開發模板 (React Native, Flutter)
  - 微服务架构模板 (Docker Compose, Kubernetes)
  - 数据科学模板 (Jupyter, MLOps)

- 🎯 **v2.3 - 智能增强** (计划中)
  - AI驱动的專案结构优化
  - 自动依赖管理和版本检查
  - 集成CI/CD pipeline生成
  - 代码质量自动化检查

- 🔮 **v3.0 - 社区驱动** (远期规划)
  - 社区自定义模板市场
  - 插件系统架构
  - 团队协作模板共享
  - 企业级專案管理集成

### 🤝 参与贡献

我们欢迎社区贡献新的專案模板！如果您希望添加新的專案类型支援：

1. **模板贡献流程**:
   ```bash
   # 1. Fork 本專案
   git clone https://github.com/lbtlm/claude-autopilot.git
   
   # 2. 创建新的專案类型模板
   cp share/claude-autopilot/project-types/gin-microservice.md \
      share/claude-autopilot/project-types/your-new-type.md
   
   # 3. 根据您的技术栈调整模板内容
   vim share/claude-autopilot/project-types/your-new-type.md
   
   # 4. 提交Pull Request
   ```

2. **模板标准**:
   - 使用Markdown格式
   - 包含完整的專案结构说明
   - 提供技术栈特定的最佳实践
   - 包含适当的依赖和工具配置

3. **优先支援的技术栈**:
   - 🎯 **高需求**: Svelte, Angular, Flutter, React Native
   - 🔧 **框架**: Spring Boot, Laravel, Ruby on Rails
   - 📊 **数据**: TensorFlow, PyTorch, Apache Spark
   - ☁️ **云原生**: Serverless, AWS CDK, Terraform
   - 🎮 **其他**: Unity, Unreal Engine, Electron

---

**让Claude驾驶您的開發过程，享受智能開發的未来！** ✨

*基于MIT许可证开源，欢迎贡献和改进。*