# Claude Autopilot 2.1 - 智慧開發環境自動配置工具

> 🛩️ 讓Claude駕駛您的開發過程，一鍵式AI協作開發環境配置，支援多種專案類型的自動化智慧配置

## 📋 專案簡介

Claude Autopilot 2.1 是一個開源的智慧開發環境配置工具，專為現代開發者設計。透過簡單的命令列操作，讓Claude自動駕駛您的專案配置過程，為專案配置完美的AI協作開發環境，支援多種程式語言和框架。

### ✨ 核心特性

- 🛩️ **自動駕駛配置** - 讓Claude接管專案配置，解放雙手
- 🤖 **智慧檢測** - 自動識別專案類型和技術棧
- 🌍 **開源友善** - 支援任意路徑部署，無硬編碼依賴
- 📚 **多語言支援** - 支援Go、JavaScript、Python、Bash等多種語言
- 🔧 **開箱即用** - 無需複雜配置，即裝即用

## 📋 系統要求

### 🛠️ 必需依賴

#### 1. **Claude Code CLI** (必需)
Claude Autopilot 2.1 依賴 Claude Code CLI 進行智慧開發：

```bash
# 安裝Claude Code CLI
curl -fsSL https://claude.ai/install.sh | sh

# 驗證安裝
claude --version
```

#### 2. **MCP 服務器** (可選但推薦)
為了獲得最佳智慧開發體驗，建議安裝以下MCP服務器：

```bash
npm install -g @mcp/sequential-thinking
npm install -g @mcp/context7
npm install -g @mcp/memory
npm install -g @mcp/puppeteer
```

## 🚀 快速開始

### 安裝

#### 🐧 Linux / macOS 用戶

```bash
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot
make dev-setup
```

#### 🪟 Windows 用戶

**推薦 - 使用WSL2:**

```bash
wsl --install
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot
make dev-setup
```

### 基本使用

```bash
# 交互式配置（新手友善）
make setup

# 快速配置當前目錄
make quick-setup

# 配置指定專案
make inject PROJECT=/path/to/your/project

# 配置新專案並指定類型
make inject-type PROJECT=/path/to/new/project TYPE=gin-microservice
```

## 🏷️ 支援的專案類型

| 專案類型 | 說明 | 技術棧 |
|---------|------|--------|
| `gin-microservice` | Go微服務 | Go + Gin + 數據庫 |
| `gin-vue3` | 全棧應用 | Go + Gin + Vue3 |
| `vue3-frontend` | Vue3前端 | Vue3 + TypeScript + Vite |
| `react-frontend` | React前端 | React + TypeScript |
| `nextjs-frontend` | Next.js應用 | Next.js + React |
| `nodejs-general` | Node.js應用 | Node.js + Express |
| `python-web` | Python Web | FastAPI/Flask/Django |
| `bash-scripts` | Bash腳本 | Shell Scripts |
| `java-maven` | Java Maven | Java + Maven |
| `rust-project` | Rust專案 | Rust + Cargo |

## 🎯 使用場景

### 新專案創建

```bash
# 互動式創建
make setup

# 直接創建
make inject-type PROJECT=my-vue3-app TYPE=vue3-frontend
```

### 現有專案配置

```bash
# 自動檢測類型
make inject PROJECT=/path/to/existing/project
```

### 多專案批量配置

```bash
# 一鍵批量配置
make inject-batch PROJECTS_DIR=/path/to/projects
```

## 🔧 配置完成後

### 新增的檔案和目錄

```
your-project/
├── .claude/                 # Claude Code配置
├── CLAUDE.md               # AI協作指南
├── project_process/        # 開發過程記錄
├── project_docs/           # 專案文件
├── .vscode/               # VSCode配置
└── Makefile              # 建置命令
```

### 可用的智慧命令

```bash
# 核心開發流程
/智能功能開發 <功能描述>        OR  /smart-feature-dev <feature description>
/智能Bug修復 <問題描述>         OR  /smart-bugfix <problem description>
/智能代碼重構 <重構目標>       OR  /smart-code-refactor <refactor target>

# 輔助工具
/加載全域上下文               OR  /load-global-context
/專案狀態分析                OR  /project-status-analysis
/清理殘餘檔案                OR  /cleanup-project
/提交github                  OR  /commit-github
```

## 🛠️ 高級配置

### 自定義專案類型

```bash
# 創建新的專案類型配置
cp claude-engine/project-types/gin-microservice.md \
   claude-engine/project-types/my-custom-type.md

# 編輯配置檔案
vim claude-engine/project-types/my-custom-type.md

# 測試新配置
./scripts/quick-setup.sh /path/to/test/project my-custom-type
```

### 環境變數配置

```bash
export CE_INSTALL_PATH="/custom/path"
export CE_DEFAULT_PROJECT_TYPE="gin-microservice"
export CE_DEBUG=true
```

## 🆘 故障排除

### Windows 相容性問題

**Q: 在Windows上執行腳本時出現 "chmod: command not found" 錯誤**

**解決方案:**
1. 推薦使用WSL2
2. 備選使用Git Bash
3. 不支持純Windows環境

### Linux/macOS 常見問題

```bash
# 腳本沒有執行權限
make dev-setup

# 找不到ce-inject腳本
git clone --recurse-submodules https://github.com/lbtlm/claude-autopilot.git

# 專案類型檢測失敗
./scripts/quick-setup.sh /path/to/project your-project-type
```

## 🌐 平台相容性說明

| 平台環境 | 相容性 | 功能完整度 | 推薦等級 |
|---------|--------|-----------|----------|
| 🐧 **Linux** | ✅ 完全支援 | 100% | ⭐⭐⭐⭐⭐ |
| 🍎 **macOS** | ✅ 完全支援 | 100% | ⭐⭐⭐⭐⭐ |
| 🪟 **Windows + WSL2** | ✅ 完全支援 | 95% | ⭐⭐⭐⭐⭐ |
| 🪟 **Windows + Git Bash** | ⚠️ 基本支援 | 80% | ⭐⭐⭐ |

## 🌟 未來計劃

### 版本路線圖

- ✅ **v2.1 - Claude Autopilot** (當前版本)
  - 品牌升級為Claude Autopilot
  - 增強的文件系統 (多語言支援)
  - 改進的Windows相容性

- 🚧 **v2.2 - 擴展模板** (開發中)
  - 更多前端框架支援 (Svelte, Angular)
  - 行動開發模板 (React Native, Flutter)
  - 微服務架構模板 (Docker Compose, Kubernetes)

- 🎯 **v2.3 - 智慧增強** (計劃中)
  - AI驅動的專案結構最佳化
  - 自動依賴管理和版本檢查
  - 整合CI/CD pipeline生成

## 🤝 貢獻指南

歡迎貢獻程式碼！

1. Fork 本倉庫
2. 創建功能分支：`git checkout -b feature/amazing-feature`
3. 提交更改：`git commit -m 'Add amazing feature'`
4. 推送分支：`git push origin feature/amazing-feature`
5. 提交Pull Request

## 📄 許可證

本專案採用 MIT 許可證。詳情請參閱 [LICENSE](LICENSE) 檔案。

## 🔗 相關連結

- 📖 GitHub 倉庫：[https://github.com/lbtlm/claude-autopilot](https://github.com/lbtlm/claude-autopilot)
- 🐛 問題報告：[GitHub Issues](https://github.com/lbtlm/claude-autopilot/issues)
- 💬 討論交流：[GitHub Discussions](https://github.com/lbtlm/claude-autopilot/discussions)

---

**讓Claude駕駛您的開發過程，享受智慧開發的未來！** ✨

*基於MIT許可證開源，歡迎貢獻和改進。*