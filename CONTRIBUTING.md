# 贡献指南 / Contributing Guide

感谢您对Claude Autopilot项目的关注和贡献意愿！🎉

Thank you for your interest in contributing to Claude Autopilot! 🎉

## 📋 目录 / Table of Contents

- [行为准则 / Code of Conduct](#行为准则--code-of-conduct)
- [如何贡献 / How to Contribute](#如何贡献--how-to-contribute)
- [开发环境设置 / Development Setup](#开发环境设置--development-setup)
- [提交规范 / Commit Guidelines](#提交规范--commit-guidelines)
- [代码规范 / Code Style](#代码规范--code-style)
- [测试指南 / Testing Guidelines](#测试指南--testing-guidelines)
- [文档贡献 / Documentation](#文档贡献--documentation)

## 🤝 行为准则 / Code of Conduct

我们致力于创建一个友好、包容的社区环境。参与本项目即表示您同意遵守以下准则：

We are committed to creating a friendly and inclusive community. By participating in this project, you agree to abide by the following guidelines:

### 我们的承诺 / Our Pledge
- 欢迎所有人参与，无论经验水平、性别、种族、宗教或技术背景
- 尊重不同的观点和经验
- 优雅地接受建设性批评
- 专注于对社区最有利的事情

### 不可接受的行为 / Unacceptable Behavior
- 使用性化语言或图像
- 人身攻击或政治攻击
- 公开或私下骚扰
- 未经许可发布他人私人信息

## 🛠️ 如何贡献 / How to Contribute

### 报告Bug / Reporting Bugs

1. 检查[现有Issues](https://github.com/lbtlm/claude-autopilot/issues)确保没有重复
2. 使用[Bug报告模板](https://github.com/lbtlm/claude-autopilot/issues/new?template=bug_report.yml)
3. 提供详细的重现步骤和环境信息
4. 添加相关的错误日志或截图

### 功能请求 / Feature Requests

1. 检查[现有Issues](https://github.com/lbtlm/claude-autopilot/issues)确保没有重复
2. 使用[功能请求模板](https://github.com/lbtlm/claude-autopilot/issues/new?template=feature_request.yml)
3. 详细描述功能的用途和价值
4. 考虑提供实现建议

### 代码贡献 / Code Contributions

1. **Fork项目 / Fork the repository**
   ```bash
   git clone https://github.com/your-username/claude-autopilot.git
   cd claude-autopilot
   ```

2. **创建功能分支 / Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   # 或 / or
   git checkout -b fix/your-bug-fix
   ```

3. **进行开发 / Make your changes**
   - 遵循代码规范
   - 添加必要的测试
   - 更新相关文档

4. **测试变更 / Test your changes**
   ```bash
   # 运行相关项目类型的测试
   ./scripts/ce-inject.sh test-project go-general
   ./scripts/ce-inject.sh test-project vue3-frontend
   ```

5. **提交变更 / Commit your changes**
   ```bash
   git add .
   git commit -m "feat: 添加新功能描述"
   ```

6. **推送分支 / Push your branch**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **创建Pull Request / Create a Pull Request**
   - 使用[PR模板](https://github.com/lbtlm/claude-autopilot/compare)
   - 详细描述变更内容
   - 链接相关Issues

## 🔧 开发环境设置 / Development Setup

### 系统要求 / System Requirements

- **操作系统 / OS**: Linux, macOS, Windows (WSL)
- **Shell**: bash, zsh
- **必需工具 / Required tools**:
  - Git
  - Claude Code CLI
  - 相关项目类型的开发工具 (Go, Node.js, Python等)

### 快速设置 / Quick Setup

```bash
# 1. 克隆项目 / Clone the repository
git clone https://github.com/lbtlm/claude-autopilot.git
cd claude-autopilot

# 2. 运行设置脚本 / Run setup script
chmod +x scripts/setup.sh
./scripts/setup.sh

# 3. 测试安装 / Test installation
./scripts/ce-inject.sh --version
```

### 开发工具 / Development Tools

推荐使用以下工具提高开发效率：

Recommended tools for improved development experience:

- **编辑器 / Editor**: VS Code with Shell extensions
- **调试工具 / Debug tools**: shellcheck for shell script linting
- **测试工具 / Testing tools**: bats for bash testing

## 📝 提交规范 / Commit Guidelines

我们使用[Conventional Commits](https://conventionalcommits.org/)规范：

We use the [Conventional Commits](https://conventionalcommits.org/) specification:

### 提交消息格式 / Commit Message Format

```
<类型>[可选范围]: <描述>

[可选正文]

[可选脚注]
```

### 类型说明 / Types

- **feat**: 新功能 / New feature
- **fix**: Bug修复 / Bug fix
- **docs**: 文档变更 / Documentation changes
- **style**: 代码格式变更 / Code style changes
- **refactor**: 代码重构 / Code refactoring
- **test**: 测试相关 / Test-related changes
- **chore**: 构建或辅助工具变更 / Build or auxiliary tool changes

### 示例 / Examples

```bash
# 新功能
feat: 添加Python Web项目类型支持

# Bug修复
fix: 修复Go项目配置文件生成问题

# 文档更新
docs: 更新README安装说明

# 重构
refactor: 优化项目类型检测逻辑
```

## 🎨 代码规范 / Code Style

### Shell脚本规范 / Shell Script Guidelines

1. **使用shellcheck检查 / Use shellcheck**
   ```bash
   shellcheck scripts/ce-inject.sh
   ```

2. **遵循Google Shell Style Guide**
   - 使用4空格缩进
   - 函数名使用小写和下划线  
   - 变量名使用大写和下划线

3. **错误处理 / Error Handling**
   ```bash
   set -euo pipefail  # 严格模式
   
   # 检查命令执行结果
   if ! command -v git >/dev/null 2>&1; then
       echo "错误: Git未安装"
       exit 1
   fi
   ```

4. **注释规范 / Comments**
   ```bash
   #!/bin/bash
   # 脚本描述
   # 作者: Claude Autopilot Team
   # 版本: 2.1.0
   
   # 函数说明
   function setup_project() {
       local project_name="$1"
       # 实现逻辑...
   }
   ```

### Markdown文档规范 / Markdown Guidelines

1. **使用标准Markdown语法**
2. **保持中英文对照** (如适用)
3. **使用表情符号增强可读性** 🎨
4. **代码块指定语言类型**

## 🧪 测试指南 / Testing Guidelines

### 测试类型 / Test Types

1. **单元测试 / Unit Tests**
   - 测试单个函数功能
   - 使用bats框架

2. **集成测试 / Integration Tests**
   - 测试完整工作流程
   - 验证多个项目类型

3. **手动测试 / Manual Tests**
   - 在不同操作系统上测试
   - 验证用户体验

### 测试命令 / Test Commands

```bash
# 运行所有测试
make test

# 测试特定项目类型
./scripts/ce-inject.sh test-project gin-microservice

# 运行shellcheck检查
make lint
```

### 测试覆盖率 / Test Coverage

确保新功能有相应的测试覆盖：

Ensure new features have appropriate test coverage:

- 核心功能: 80%+ 覆盖率
- 新增功能: 100% 覆盖率
- Bug修复: 包含回归测试

## 📚 文档贡献 / Documentation

### 文档类型 / Documentation Types

1. **README文档**
   - 保持中英文同步更新
   - 包含最新的安装和使用说明

2. **项目类型文档**
   - 位于 `claude-engine/project-types/`
   - 包含完整的配置说明

3. **API文档**
   - 命令行接口文档
   - 配置选项说明

### 文档写作规范 / Documentation Standards

1. **结构清晰** / Clear structure
2. **示例丰富** / Rich examples  
3. **保持更新** / Keep updated
4. **易于理解** / Easy to understand

## 🏷️ 标签系统 / Label System

我们使用以下标签分类Issues和PRs：

We use the following labels to categorize Issues and PRs:

### 类型标签 / Type Labels
- `bug`: Bug报告
- `enhancement`: 功能增强
- `question`: 问题咨询
- `documentation`: 文档相关

### 优先级标签 / Priority Labels
- `priority/low`: 低优先级
- `priority/medium`: 中优先级  
- `priority/high`: 高优先级
- `priority/critical`: 关键优先级

### 状态标签 / Status Labels
- `triage`: 需要分类
- `help wanted`: 需要帮助
- `good first issue`: 适合新贡献者

## 🎉 致谢 / Acknowledgments

感谢所有为Claude Autopilot项目做出贡献的开发者！

Thanks to all the developers who have contributed to the Claude Autopilot project!

您的贡献让这个项目变得更好！

Your contributions make this project better!

---

## 📞 获取帮助 / Getting Help

如果您在贡献过程中遇到问题，可以通过以下方式获取帮助：

If you encounter any issues during the contribution process, you can get help through:

- 🐛 [创建Issue](https://github.com/lbtlm/claude-autopilot/issues/new)
- 💬 [GitHub Discussions](https://github.com/lbtlm/claude-autopilot/discussions)
- 📧 通过GitHub联系维护者

再次感谢您的贡献！🙏

Thank you again for your contribution! 🙏