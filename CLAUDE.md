# CLAUDE.md - Claude Autopilot 智能协作指南

## 🛩️ **Claude Autopilot 2.1 已激活**

本项目已集成Claude Autopilot 2.1智能系统，让Claude驾驶您的开发过程，提供完整的智能开发工作流程。

### **📊 项目信息**
- **项目名称**: Claude Autopilot
- **项目类型**: 智能开发环境配置工具
- **技术栈**: bash-scripts  
- **版本**: 2.1.0
- **配置时间**: 2025-07-25 18:30:00

### **🎯 智能命令**

#### **核心开发流程**
```bash
# 一键式完整功能开发 / Smart Feature Development
/智能功能开发 <功能需求描述>
# OR /smart-feature-dev <feature description>

# 智能问题诊断和修复 / Smart Bug Fix
/智能Bug修复 <问题描述>
# OR /smart-bugfix <problem description>

# 基于最佳实践的智能重构 / Smart Code Refactor  
/智能代码重构 <重构目标>
# OR /smart-code-refactor <refactor target>
```

#### **辅助工具命令**
```bash
# 重新加载全局上下文和经验 / Load Global Context
/加载全局上下文
# OR /load-global-context

# 强制刷新模式（获取最新信息）
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh

# 项目健康度分析 / Project Status Analysis
/项目状态分析
# OR /project-status-analysis

# 清理残余文件 / Cleanup Project
/清理残余文件
# OR /cleanup-project

# 提交到GitHub / Commit to GitHub
/提交github
# OR /commit-github
```

### **🐚 Bash脚本开发特色功能**

#### **脚本质量优化**
- **Shell脚本规范检查**: ShellCheck集成和最佳实践应用
- **错误处理优化**: set -euo pipefail和完善的错误处理机制
- **参数验证智能**: 输入参数验证和帮助文档自动生成
- **跨平台兼容性**: Linux/macOS/Windows WSL兼容性检查

#### **项目结构管理**
- **模块化设计**: 脚本功能模块化和库函数复用
- **配置管理**: 环境变量和配置文件管理最佳实践
- **日志记录系统**: 统一的日志记录和错误跟踪
- **测试框架集成**: Bash单元测试和集成测试

#### **部署和分发**
- **权限管理**: 执行权限和安全策略配置
- **包管理**: 脚本打包和版本管理
- **依赖检查**: 系统依赖和工具检查自动化
- **安装脚本**: 一键安装和卸载脚本生成

#### **标准项目结构支持**
```
bash-scripts项目/
├── bin/               # 可执行脚本
├── lib/               # 库函数和公共模块
├── config/            # 配置文件和模板
├── tests/             # 测试脚本
├── docs/              # 文档
├── templates/         # 模板文件
├── examples/          # 示例脚本
├── scripts/           # 辅助脚本
│   ├── install.sh     # 安装脚本
│   ├── setup.sh       # 环境设置
│   └── deploy.sh      # 部署脚本
├── .shellcheckrc      # ShellCheck配置
├── Makefile          # 构建和测试命令
├── README.md         # 项目说明
└── VERSION           # 版本信息
```

#### **智能开发和测试**
```bash
# 语法检查
make lint

# 运行测试
make test

# 安装脚本
make install

# 打包分发
make package

# 部署脚本
make deploy

# 查看帮助
make help
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: 复杂脚本逻辑设计和流程优化
- **context7**: 动态获取Bash最新文档和最佳实践
- **memory**: Bash开发经验自动复用和模式库
- **filesystem**: 脚本文件结构智能分析和组织

#### **全局规则遵守**
- **Bash代码规范**: 自动应用ShellCheck规则和Google Shell Style Guide
- **安全编程**: 避免Shell注入、路径遍历等安全漏洞
- **错误处理**: 完善的错误处理和退出码管理
- **文档规范**: 标准的脚本注释和使用说明

#### **Bash专项智能特性**
- **函数库设计**: 可复用函数库的设计和管理
- **参数处理优化**: getopts和长选项处理最佳实践
- **并发控制**: 后台任务和进程管理优化
- **跨平台适配**: 不同Shell环境的兼容性处理

### **📋 Bash开发建议**

#### **开始开发**
1. 描述脚本需求，如："创建系统监控脚本"
2. 系统会自动设计脚本架构和函数结构
3. 生成符合最佳实践的Bash代码

#### **脚本优化**
1. 说明优化目标，如："提高脚本执行效率"
2. 系统会分析性能瓶颈和优化机会
3. 提供基于最佳实践的优化方案

#### **错误处理**
1. 描述错误场景，如："网络连接失败处理"
2. 系统会设计完善的错误处理机制
3. 确保脚本的健壮性和可靠性

### **🔧 开发工具集成**

#### **质量保证工具**
- **ShellCheck**: 静态代码分析和语法检查
- **bats**: Bash自动化测试系统
- **bashcov**: 代码覆盖率分析
- **shellspec**: BDD风格的Shell测试框架

#### **开发辅助工具**
- **bash-language-server**: VSCode Bash语言支持
- **shfmt**: Bash代码格式化
- **hadolint**: Dockerfile检查（如涉及容器化）
- **git-hooks**: Git提交前质量检查

#### **部署工具**
- **rsync**: 脚本同步和部署
- **tar/zip**: 脚本打包和分发
- **systemd**: 服务化部署
- **cron**: 定时任务配置

### **📈 效率提升**

相比传统Bash开发，Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 提升3-5倍，专注业务逻辑
- 🎯 **代码质量**: 符合Shell最佳实践的A级代码
- 🔒 **安全保证**: 自动检测和修复安全漏洞
- 🧠 **模式复用**: Bash惯用法和设计模式自动应用
- 📚 **文档完善**: 自动生成使用说明和API文档

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **脚本问题**
```bash
# 语法检查
shellcheck script.sh

# 调试模式运行
bash -x script.sh

# 检查权限
ls -la script.sh
chmod +x script.sh
```

#### **依赖问题**
```bash
# 检查系统依赖
./scripts/check-deps.sh

# 安装依赖
./scripts/install-deps.sh

# 环境检查
./scripts/env-check.sh
```

#### **性能问题**
```bash
# 性能分析
time ./script.sh

# 内存使用分析
/usr/bin/time -v ./script.sh

# 系统调用跟踪
strace -c ./script.sh
```

---

## 🚀 **开始智能开发之旅**

Claude Autopilot 2.1专为智能开发环境配置优化！

**直接描述您的脚本开发需求**，系统会自动选择最适合的开发模式：

- 功能开发 → 自动应用Shell最佳实践和设计模式
- 性能优化 → 智能分析脚本性能和系统调用
- 安全加固 → 基于安全编程规范的代码审查
- 重构优化 → 模块化和函数库设计

**享受Claude驾驶的智能开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_RULES_PATH  
**项目配置**: .claude/project.json  
**最后同步**: 2025-07-25 18:30:00  
**版本**: v2.1.0

*本文件由Claude Autopilot智能系统自动生成，让Claude驾驶您的开发过程*