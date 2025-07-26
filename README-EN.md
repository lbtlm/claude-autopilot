# Claude Autopilot 2.1 - Intelligent Development Environment Configuration Tool

**🌐 Language Versions**
- [简体中文](README.md) | [繁體中文](README-TW.md) | [English](README-EN.md)

> 🛩️ Let Claude Drive Your Development - One-click AI collaborative development environment setup, supporting multiple project types with automated intelligent configuration

## 📋 Project Overview

Claude Autopilot 2.1 is an open-source intelligent development environment configuration tool designed for modern developers. Through simple command-line operations, let Claude automatically drive your project configuration process, setting up perfect AI collaborative development environments for your projects, supporting multiple programming languages and frameworks.

### ✨ Core Features

- 🛩️ **Autopilot Configuration** - Let Claude take control of project setup, hands-free experience
- 🤖 **Intelligent Detection** - Automatically identify project types and tech stacks
- 🌍 **Open Source Friendly** - Support deployment anywhere, no hardcoded dependencies
- 📚 **Multi-Language Support** - Support Go, JavaScript, Python, Bash and more
- 🔧 **Out-of-the-Box** - No complex configuration needed, ready to use

## 📋 System Requirements

### 🛠️ Required Dependencies

#### 1. **Claude Code CLI** (Required)
Claude Autopilot 2.1 relies on Claude Code CLI for intelligent development:

```bash
# Install Claude Code CLI
# Method 1: Official installation script
curl -fsSL https://claude.ai/install.sh | sh

# Method 2: Package manager (if supported)
# npm install -g @anthropic/claude-code  # Example, follow official docs
# pip install claude-code              # Example, follow official docs

# Verify installation
claude --version
```

#### 2. **MCP (Model Context Protocol) Servers** (Optional but Recommended)
For the best intelligent development experience, we recommend installing the following MCP servers:

**🧠 Core Intelligence Toolkit:**

```bash
# 1. Sequential Thinking - Complex task decomposition and analysis
npm install -g @mcp/sequential-thinking

# 2. Context7 - Dynamic technical documentation retrieval
npm install -g @mcp/context7

# 3. Memory - Development experience memory and reuse
npm install -g @mcp/memory

# 4. Puppeteer - Web project automation testing (optional)
npm install -g @mcp/puppeteer
```

**📦 MCP Server Configuration (in Claude Code):**

Create or update `~/.claude/mcp-servers.json`:

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

**⚠️ Note**: MCP server package names and configuration methods should follow official documentation. The above are examples only.

#### 3. **System Tools**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install git make curl shellcheck

# macOS
brew install git make curl shellcheck

# CentOS/RHEL
sudo yum install git make curl
# ShellCheck needs separate installation: https://github.com/koalaman/shellcheck
```

### ✅ Installation Verification

Run the following commands to verify your environment:

```bash
# Check required tools
claude --version          # Claude Code CLI
git --version             # Git version control
make --version            # Make build tool
shellcheck --version      # Shell code checker (optional)

# Check optional tools
node --version            # Node.js (needed for MCP servers)
npm --version             # npm package manager
```

---

## 🚀 Quick Start

### 1. Clone and Install

#### 🐧 Linux / macOS Users

```bash
# Clone project
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot

# Set script execution permissions (automatic)
make dev-setup
```

#### 🪟 Windows Users

**Recommended - Use WSL (Windows Subsystem for Linux):**

```bash
# 1. Install WSL2 (if not installed)
# Run in PowerShell as administrator:
wsl --install

# 2. Execute in WSL
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot
make dev-setup
```

**Alternative - Use Git Bash:**

```bash
# 1. Install Git for Windows (includes Git Bash)
# 2. Execute in Git Bash
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot

# Manually set execution permissions (Git Bash environment)
chmod +x scripts/*.sh
chmod +x lib/*.sh
```

**Notes:**
- ⚠️ Does not support pure Windows Command Prompt or PowerShell
- ✅ Recommend using WSL2 for best compatibility
- ⚡ Git Bash works but some features may be limited

### 2. Basic Usage

**🎯 Recommended Method - Using Makefile (Simplest):**

```bash
# Interactive configuration (beginner-friendly)
make setup

# Quick configure current directory
make quick-setup

# Configure specific project
make quick-setup PROJECT=/path/to/your/project

# Configure new project with specified type
make inject-type PROJECT=/path/to/new/project TYPE=gin-microservice
```

**⚡ Direct Script Usage (Advanced Users):**

```bash
# Interactive configuration
./scripts/setup.sh

# Quick configuration
./scripts/quick-setup.sh [project_path] [project_type]
```

## 📖 Detailed Usage Guide

### 🎯 Core Usage Methods

Claude Autopilot 2.1 provides three usage methods, from simple to advanced:

#### Method 1: Makefile Commands (⭐ Recommended)

**Simplest usage method, one-click completion:**

```bash
# View all available commands
make help

# 🚀 Quick start (recommended for beginners)
make setup                                           # Interactive configuration
make quick-setup                                     # Quick configure current directory

# 🎯 Advanced features
make inject PROJECT=/path/to/project                 # Auto-detect project type
make inject-type PROJECT=/path/to/new TYPE=vue3      # Specify project type
make inject-batch PROJECTS_DIR=/path/to/projects     # Batch configuration

# 🔧 Development tools
make lint                                            # Code quality check
make test                                            # Run tests
make dev-setup                                       # Setup development environment
```

#### Method 2: Direct Script Usage

**For advanced users who need more control:**

```bash
# Core scripts
./scripts/setup.sh                                  # Interactive configuration
./scripts/quick-setup.sh                            # Quick configuration
./bin/claude-autopilot [project_path] [project_type]        # Core injection script

# Specialized tools
./scripts/quality-check/health-check.sh             # Health check
./scripts/project-management/new_project.sh         # New project creation
```

#### Method 3: System Installation (Optional)

**For global use after system installation:**

```bash
# Install to system
sudo make install

# Global usage
ce-inject /path/to/project                          # Direct usage
setup.sh                                            # Global interactive configuration
```

### 🏷️ Supported Project Types

| Project Type | Description | Tech Stack |
|-------------|-------------|------------|
| `gin-microservice` | Go Microservice | Go + Gin + Database |
| `gin-vue3` | Full-stack App | Go + Gin + Vue3 |
| `vue3-frontend` | Vue3 Frontend | Vue3 + TypeScript + Vite |
| `react-frontend` | React Frontend | React + TypeScript |
| `nextjs-frontend` | Next.js App | Next.js + React |
| `nodejs-general` | Node.js App | Node.js + Express |
| `python-web` | Python Web | FastAPI/Flask/Django |
| `python-desktop` | Python Desktop | tkinter/PyQt |
| `bash-scripts` | Bash Scripts | Shell Scripts |
| `java-maven` | Java Maven | Java + Maven |
| `java-gradle` | Java Gradle | Java + Gradle |
| `rust-project` | Rust Project | Rust + Cargo |
| `php-project` | PHP Project | PHP + Composer |

### 🎯 Usage Scenarios

#### Scenario 1: New Project Creation

```bash
# 🎯 Using Makefile (recommended)
make setup                                            # Interactive creation
make inject-type PROJECT=my-vue3-app TYPE=vue3       # Direct creation

# ⚡ Using scripts
./scripts/setup.sh                                   # Interactive menu
mkdir my-vue3-app && ./scripts/quick-setup.sh my-vue3-app vue3-frontend
```

#### Scenario 2: Existing Project Configuration

```bash
# 🎯 Using Makefile (recommended)
make inject PROJECT=/path/to/existing/project        # Auto-detect type

# ⚡ Using scripts
cd /path/to/existing/project
./scripts/quick-setup.sh .
```

#### Scenario 3: Batch Multi-Project Configuration

```bash
# 🎯 Using Makefile (recommended)
make inject-batch PROJECTS_DIR=/path/to/projects     # One-click batch configuration

# ⚡ Using scripts
for project in /path/to/projects/*; do
    ./scripts/quick-setup.sh "$project"
done
```

### 🏥 Project Health Check

Use the health check feature to assess project status:

```bash
# 🎯 Using Makefile (recommended)
make health-check                                     # Check current project

# ⚡ Using scripts
./scripts/setup.sh                                   # Interactive menu option 4
./scripts/quality-check/health-check.sh /path/to/project    # Direct check
```

## 🔧 After Configuration

After configuration, your project will contain:

### 📁 New Files and Directories

```
your-project/
├── .claude/                 # Claude Code configuration
│   ├── project.json        # Project configuration file
│   └── commands/           # Smart command links
├── CLAUDE.md              # AI collaboration guide
├── project_process/       # Development process records
├── project_docs/          # Project documentation
├── .vscode/              # VSCode configuration
├── .editorconfig         # Editor configuration
└── Makefile             # Build commands
```

### 🎯 Available Smart Commands

After configuration, you can use the following smart commands in Claude Code:

## 🚀 **Core Development Commands** - Daily Development Essentials

### 1. 🔧 Smart Feature Development `/smart-feature-dev` or Chinese `/智能功能开发`

**Quickly start new feature development with complete workflow from design to implementation**

```bash
# Basic usage
/smart-feature-dev user authentication system
/智能功能开发 用户登录功能

# Detailed usage
/smart-feature-dev Create a Vue3 user management interface with CRUD operations
/smart-feature-dev Implement JWT authentication API endpoints with login, register, refresh token
```

**Key Features:**

- ✨ Automatically analyze requirements and break down tasks
- 🏗️ Generate code structure following project architecture
- 🧪 Create related test files
- 📝 Update project documentation

---

### 2. 🐛 Smart Bug Fix `/smart-bugfix` or Chinese `/智能Bug修复`

**Quickly diagnose and fix code issues, supporting multiple programming languages**

```bash
# Basic usage
/smart-bugfix Page loading slowly
/智能Bug修复 API返回500错误

# Detailed usage
/smart-bugfix Vue component rendering error, console shows Cannot read property of undefined
/smart-bugfix Database connection timeout, queries taking over 30 seconds
```

**Key Features:**

- 🔍 Intelligent code analysis and issue location
- 🛠️ Provide multiple fix solutions
- 📊 Performance optimization suggestions
- 🧪 Verify fix effectiveness

---

### 3. 🔄 Smart Code Refactor `/smart-code-refactor` or Chinese `/智能代码重构`

**Code refactoring and optimization based on best practices**

```bash
# Basic usage
/smart-code-refactor optimize database queries
/智能代码重构 优化数据库查询

# Detailed usage
/smart-code-refactor Convert class components to function components using Hooks
/smart-code-refactor Optimize API endpoints, implement caching and pagination
```

**Key Features:**

- 🎯 Follow code best practices
- ⚡ Performance optimization suggestions
- 🧹 Code cleanup and standardization
- 📚 Architecture improvement recommendations

---

## 🛠️ **Project Management Commands** - Project Maintenance Tools

### 4. 🔄 Load Global Context `/load-global-context` or Chinese `/加载全局上下文`

**Reload Claude Autopilot environment and project context**

```bash
# Basic usage
/load-global-context
/加载全局上下文

# Force refresh mode
/load-global-context --force-refresh
/加载全局上下文 --force-refresh
```

**Use Cases:**

- 🔧 After updating project configuration
- 🚨 When commands are not recognized
- 📝 After modifying project type
- 🔄 After environment changes

---

### 5. 📊 Project Status Analysis `/project-status-analysis` or Chinese `/项目状态分析`

**Comprehensive analysis of project health and technical debt**

```bash
# Basic usage
/project-status-analysis
/项目状态分析

# Detailed analysis
/project-status-analysis --detailed
/项目状态分析 --with-suggestions
```

**Analysis Content:**

- 🏗️ Project architecture compliance
- 📦 Dependency versions and security
- 🧪 Test coverage analysis
- 📝 Documentation completeness check
- 🚀 Performance bottleneck identification

---

### 6. 🧹 Project Cleanup `/cleanup-project` or Chinese `/清理残余文件`

**Intelligent project file cleanup, compliant with GNU coding standards**

```bash
# Complete interactive cleanup
/cleanup-project
/清理残余文件

# Automatic mode (skip confirmations)
/cleanup-project --auto

# Preview mode (show only, don't execute)
/cleanup-project --dry-run

# Deep cleanup mode
/cleanup-project --deep
```

**Cleanup Content:**

- 🗑️ Temporary files and cache
- 📁 Non-standard directory structures
- 🔄 Duplicate and redundant files
- 🏗️ Files not compliant with project architecture
- 💾 Backup old files (safe cleanup)

---

### 7. 📤 Commit to GitHub `/commit-github` or Chinese `/提交github`

**Smart Git commit with standard commit messages**

```bash
# Basic usage
/commit-github
/提交github

# Specify commit type
/commit-github --type feat
/commit-github --type fix
```

**Key Features:**

- 📝 Automatically analyze code changes
- 🎯 Generate Conventional Commits compliant messages
- 🔍 Code quality checks
- 🚀 Automatic push to remote repository

---

## 💡 **Usage Tips**

### 🎯 **Quick Start**

1. **New Project Development**: Use `/smart-feature-dev` to quickly create features
2. **Problem Solving**: Use `/smart-bugfix` when encountering bugs
3. **Code Optimization**: Regularly use `/smart-code-refactor` to improve code quality
4. **Project Maintenance**: Use `/project-status-analysis` and `/cleanup-project` to keep project healthy

### 🔄 **Command Combination Usage**

```bash
# Complete development workflow example
1. /project-status-analysis          # Analyze current project status
2. /smart-feature-dev new feature    # Develop new feature
3. /smart-code-refactor optimize     # Refactor and optimize
4. /cleanup-project                  # Clean temporary files
5. /commit-github                    # Commit code
```

### 📝 **Best Practices**

- ✅ Describe requirements in detail for more accurate results
- ✅ Regularly use project maintenance commands
- ✅ Combine multiple commands for complex tasks
- ✅ Use parameter options to customize command behavior

### 🚀 Start Using

1. **Launch Claude Code**:
   ```bash
   cd your-project
   claude code
   ```

2. **Directly describe requirements**:
   - "Help me create user login functionality"
   - "Optimize database query performance"
   - "Add unit tests"

3. **Enjoy intelligent development experience**!

## 📁 Project Structure Details

### 🏗️ Core Directory Structure

```
claude-autopilot/
├── 📁 scripts/                    # Core scripts directory (main entry)
│   ├── 🚀 setup.sh               # Interactive configuration script (beginner recommended)
│   ├── ⚡ quick-setup.sh          # Quick configuration script (experienced users)
│   ├── 🔧 ce-inject.sh           # Core injection script (core engine)
│   ├── 📁 project-management/    # Project management tools
│   ├── 📁 quality-check/         # Quality check tools
│   └── 📁 autopilot/                 # Autopilot 2.1 intelligent system
│
├── 📁 share/claude-autopilot/             # Intelligent context engine
│   ├── 📁 project-types/         # Project type templates (key configuration)
│   │   ├── gin-microservice.md   # Go microservice configuration
│   │   ├── vue3-frontend.md      # Vue3 frontend configuration
│   │   ├── react-frontend.md     # React frontend configuration
│   │   ├── python-web.md         # Python Web configuration
│   │   └── ... (more project types)
│   │
│   ├── 📁 commands/              # Smart command definitions
│   ├── 📁 utils/                 # Utility function library
│   ├── 📁 templates/             # File templates
│   └── command-aliases.json      # Command alias configuration
│
├── 🔧 Makefile                   # Unified build interface (recommended entry)
├── 📖 README.md                  # Project documentation (this file)
├── 📋 CLAUDE.md                  # Claude Code configuration guide
└── 📄 VERSION                    # Version information
```

### 🎯 Core Component Description

#### 1. **scripts/ - Script Entry Directory**
- **setup.sh** - Interactive configuration, suitable for beginners, provides friendly menu interface
- **quick-setup.sh** - Quick configuration, suitable for experienced users, direct command line usage
- **ce-inject.sh** - Core injection engine, implementation of all configuration logic

#### 2. **share/claude-autopilot/ - Intelligent Engine Core**
- **project-types/** - Configuration templates and best practices for various project types
- **commands/** - Smart command links, supporting Chinese and English commands
- **utils/** - Core utility functions, providing reusable functional modules

#### 3. **Makefile - Unified Interface**
- Provides unified entry point for all functions
- Automatically handles script permissions and dependencies
- Supports various usage scenarios from simple to advanced

### 🎨 Usage Entry Hierarchy

```
🏁 Entry Hierarchy (from simple to advanced)

1️⃣ Makefile Interface (recommended, simplest)
   make setup                    # Beginner-friendly interactive configuration
   make quick-setup              # One-click quick configuration
   make inject PROJECT=/path     # Advanced batch configuration

2️⃣ Direct Script Calls (more control)
   ./scripts/setup.sh            # Interactive menu
   ./scripts/quick-setup.sh      # Quick configuration
   ./bin/claude-autopilot        # Direct engine call

3️⃣ System Installation (global usage)
   sudo make install             # Install to system
   ce-inject /path/to/project    # Global command usage
```

### 💡 Design Philosophy

- **🎯 Simplicity First** - Novice users prioritize simple Makefile interface
- **🔧 Flexible Configuration** - Advanced users can call scripts directly for more control
- **🧠 Intelligent Perception** - Automatically detect project types and tech stacks
- **🌍 Open Source Friendly** - No hardcoded paths, support deployment in any environment

## 🛠️ Advanced Configuration

### Custom Project Types

If you need to support new project types:

1. Create new configuration files in the `share/claude-autopilot/project-types/` directory
2. Refer to existing configuration file formats (recommend copying similar project types for modification)
3. Re-run configuration scripts

#### 🔨 Creating Custom Project Type Example

```bash
# 1. Create new project type configuration
cp share/claude-autopilot/project-types/gin-microservice.md \
   share/claude-autopilot/project-types/my-custom-type.md

# 2. Edit configuration file, modify project description and templates
vim share/claude-autopilot/project-types/my-custom-type.md

# 3. Test new configuration
./scripts/quick-setup.sh /path/to/test/project my-custom-type
```

### Environment Variable Configuration

You can customize configuration through environment variables:

```bash
# Custom installation path
export CE_INSTALL_PATH="/custom/path"

# Default project type
export CE_DEFAULT_PROJECT_TYPE="gin-microservice"

# Enable debug mode
export CE_DEBUG=true

# Custom template directory
export CE_TEMPLATE_DIR="/custom/templates"
```

## 🤝 Contribution Guide

Welcome code contributions! Please follow these steps:

1. Fork this repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push branch: `git push origin feature/amazing-feature`
5. Submit Pull Request

### Development Environment Setup

```bash
# Configure development environment for this project
./scripts/quick-setup.sh . bash-scripts
```

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## 🆘 Troubleshooting

### 🪟 Windows Compatibility Issues

#### **Q: "chmod: command not found" error when running scripts on Windows**

**Symptoms**: Scripts show `chmod: command not found` or permission-related errors

**Solutions**:

1. **Recommended - Use WSL2 (Best Experience)**:
   ```bash
   # After installing WSL2, run in Ubuntu environment
   wsl
   cd /mnt/c/path/to/claude-autopilot
   make dev-setup
   ```

2. **Alternative - Use Git Bash**:
   ```bash
   # Manually set permissions in Git Bash
   find scripts/ -name "*.sh" -exec chmod +x {} \;
   find share/claude-autopilot/utils/ -name "*.sh" -exec chmod +x {} \;
   ```

3. **Git Configuration Optimization (One-time Setup)**:
   ```bash
   # Run in project directory
   git config core.filemode false
   git update-index --chmod=+x scripts/setup.sh
   git update-index --chmod=+x scripts/quick-setup.sh
   git update-index --chmod=+x scripts/ce-inject.sh
   ```

#### **Q: Scripts cannot run in PowerShell**

**Symptoms**: Scripts cannot execute in Windows PowerShell or Command Prompt

**Solution**: Pure Windows environments are not supported, please use one of the following:
- ✅ **WSL2** (recommended): Fully compatible Linux environment
- ✅ **Git Bash**: Basic functionality available
- ❌ **PowerShell/CMD**: Not supported

### 🐧 Linux/macOS Common Issues

**Q: Scripts don't have execution permissions**
```bash
# Automatically set all script permissions
make dev-setup

# Or set manually
chmod +x scripts/*.sh
chmod +x lib/*.sh
```

**Q: Cannot find ce-inject script**
```bash
# Ensure project is completely cloned
git clone --recurse-submodules https://github.com/lbtlm/claude-autopilot.git

# Check if script exists
ls -la scripts/ce-inject.sh
```

**Q: Project type detection failed**
```bash
# Manually specify project type
./scripts/quick-setup.sh /path/to/project your-project-type

# View supported project types
ls share/claude-autopilot/project-types/
```

### 🔧 General Problem Solving

**Q: Makefile commands don't work**
```bash
# Check if make is installed
which make

# Install make on Ubuntu/Debian
sudo apt install build-essential

# Install make on macOS
xcode-select --install
```

**Q: Script execution permission issues persist**
```bash
# Force reset all permissions
find . -name "*.sh" -exec chmod +x {} \;

# Check filesystem mount options (WSL users)
mount | grep "your-drive"
```

**Q: Claude Code cannot recognize after project configuration**
```bash
# Check if configuration files are correctly generated
ls -la .claude/

# Verify CLAUDE.md file
cat CLAUDE.md | head -20

# Re-run configuration
make quick-setup
```

### Get Help

- 📖 View help: `./scripts/setup.sh --help`
- 🐛 Report issues: [GitHub Issues](https://github.com/lbtlm/claude-autopilot/issues)
- 💬 Discussion: [GitHub Discussions](https://github.com/lbtlm/claude-autopilot/discussions)

---

## 🌐 Platform Compatibility

### 📊 Compatibility Matrix

| Platform Environment | Compatibility | Feature Completeness | Recommendation Level | Notes |
|---------------------|---------------|---------------------|----------------------|-------|
| 🐧 **Linux (Ubuntu/Debian/CentOS)** | ✅ Full Support | 100% | ⭐⭐⭐⭐⭐ | Native support, best performance |
| 🍎 **macOS** | ✅ Full Support | 100% | ⭐⭐⭐⭐⭐ | Native support, excellent experience |
| 🪟 **Windows + WSL2** | ✅ Full Support | 95% | ⭐⭐⭐⭐⭐ | Recommended solution, near-native experience |
| 🪟 **Windows + Git Bash** | ⚠️ Basic Support | 80% | ⭐⭐⭐ | Usable, some features limited |
| 🪟 **Windows PowerShell** | ❌ Not Supported | 0% | ❌ | Bash scripts cannot run |
| 🪟 **Windows Command Prompt** | ❌ Not Supported | 0% | ❌ | Bash scripts cannot run |

### 🎯 Windows User Recommendations

#### **Best Practice - WSL2 Environment**
```bash
# 1. Enable WSL feature (PowerShell administrator)
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# 2. Install WSL2 and Ubuntu
wsl --install -d Ubuntu

# 3. Use in WSL2 (fully compatible)
wsl
cd /mnt/c/your/project/path
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot
make dev-setup
```

#### **Alternative - Git Bash**
```bash
# Limited functionality but basically usable
# Note: Some advanced features may not work
chmod +x scripts/*.sh
./scripts/setup.sh
```

### ⚡ Performance Comparison

| Environment | Startup Speed | Execution Efficiency | Stability | Development Experience |
|------------|---------------|---------------------|-----------|----------------------|
| Linux Native | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 |
| macOS Native | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 |
| WSL2 | 🚀🚀🚀🚀 | 🚀🚀🚀🚀 | 🚀🚀🚀🚀 | 🚀🚀🚀🚀🚀 |
| Git Bash | 🚀🚀🚀 | 🚀🚀🚀 | 🚀🚀🚀 | 🚀🚀🚀 |

---

## 🌟 Future Plans

### 📈 Project Roadmap

- ✅ **v2.0 - Core Features** (Previous Version)
  - Multi-project type support (18 mainstream tech stacks)
  - Smart command system (Chinese-English bilingual)
  - Cross-platform compatibility (Linux/macOS/Windows WSL)

- ✅ **v2.1 - Enhanced Templates** (Current Version)
  - Improved documentation (multi-language support)
  - Enhanced Windows compatibility
  - Optimized smart command system
  - MIT license and open-source preparation

- 🚧 **v2.2 - Extended Templates** (In Development)
  - More frontend framework support (Svelte, Angular, Vue2)
  - Mobile development templates (React Native, Flutter)
  - Microservice architecture templates (Docker Compose, Kubernetes)
  - Data science templates (Jupyter, MLOps)

- 🎯 **v2.3 - Intelligence Enhancement** (Planned)
  - AI-driven project structure optimization
  - Automatic dependency management and version checking
  - Integrated CI/CD pipeline generation
  - Automated code quality checking

- 🔮 **v3.0 - Community Driven** (Long-term Planning)
  - Community custom template marketplace
  - Plugin system architecture
  - Team collaboration template sharing
  - Enterprise project management integration

### 🤝 Contributing

We welcome community contributions of new project templates! If you want to add new project type support:

1. **Template Contribution Process**:
   ```bash
   # 1. Fork this project
   git clone https://github.com/lbtlm/claude-autopilot.git
   
   # 2. Create new project type template
   cp share/claude-autopilot/project-types/gin-microservice.md \
      share/claude-autopilot/project-types/your-new-type.md
   
   # 3. Adjust template content according to your tech stack
   vim share/claude-autopilot/project-types/your-new-type.md
   
   # 4. Submit Pull Request
   ```

2. **Template Standards**:
   - Use Markdown format
   - Include complete project structure description
   - Provide tech stack-specific best practices
   - Include appropriate dependencies and tool configurations

3. **Priority Support Tech Stacks**:
   - 🎯 **High Demand**: Svelte, Angular, Flutter, React Native
   - 🔧 **Frameworks**: Spring Boot, Laravel, Ruby on Rails
   - 📊 **Data**: TensorFlow, PyTorch, Apache Spark
   - ☁️ **Cloud Native**: Serverless, AWS CDK, Terraform
   - 🎮 **Others**: Unity, Unreal Engine, Electron

---

**Make AI development smarter, more efficient, and more reliable!** ✨

*Open source under MIT license, contributions and improvements welcome.*