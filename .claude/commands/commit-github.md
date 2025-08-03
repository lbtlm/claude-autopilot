# /提交 github | /commit-github

## 签名为 ## Co-Authored-By: SamSmith <bwf5314@gmail.com>"

## Generated with [Claude Autopilot 2.1](https://claude-autopilot.com)

## 🚀 智能 GitHub 提交命令

这是一个智能的 Git 操作命令，能够自动处理代码提交、推送到 GitHub，并确保遵循标准的 Git 工作流程和提交规范。

## 📋 功能特性

### 🔄 智能 Git 工作流程

- **状态检查**：自动检查工作目录状态和分支信息
- **文件分析**：智能分析变更文件并生成合理的提交信息
- **冲突检测**：检测并处理潜在的合并冲突
- **签名配置**：自动配置 Youmi Sam 签名和指定邮箱

### 📝 标准化提交

- **Conventional Commits**：遵循标准的提交信息格式
- **智能分类**：根据文件变更自动判断提交类型
- **详细描述**：生成包含变更详情的提交信息
- **签名规范**：统一使用 Youmi Sam 签名替换 Claude Code 签名

### 🔒 安全检查

- **敏感信息**：检查并阻止敏感信息提交
- **文件验证**：确保不提交临时文件和编译产物
- **分支保护**：防止直接提交到受保护分支
- **远程同步**：确保本地分支与远程同步

## 🚀 使用方法

### 基础提交

```
/提交github
```

或

```
/commit-github
```

自动分析变更并生成提交信息

### 自定义提交信息

```
/提交github "feat: 添加用户登录功能"
/commit-github "feat: 添加用户登录功能"
```

### 高级选项

```
/提交github --push
/commit-github --push
```

提交后自动推送到远程仓库

```
/提交github --branch feature/login
/commit-github --branch feature/login
```

切换到指定分支后提交

```
/提交github --amend
/commit-github --amend
```

修改最后一次提交

```
/提交github --force-push
/commit-github --force-push
```

强制推送（谨慎使用）

```
/提交github --dry-run
/commit-github --dry-run
```

预览模式，显示将要执行的操作

## 🧠 智能提交信息生成

### 提交类型识别

- **feat**: 新功能添加
- **fix**: Bug 修复
- **docs**: 文档更新
- **style**: 代码格式化
- **refactor**: 代码重构
- **test**: 测试相关
- **chore**: 构建过程或辅助工具变动

### 文件变更分析

```
新增文件: auth.go, login.html → feat: 添加用户认证功能
修复bug: fix typo in user.go → fix: 修复用户模块中的拼写错误
删除文件: old_config.json → chore: 删除过时的配置文件
文档更新: README.md → docs: 更新项目文档
```

### 智能描述生成

```
feat: 添加用户登录功能

- 实现JWT token认证机制
- 添加登录和登出接口
- 集成密码加密和验证
- 更新用户模型和数据库结构

文件变更:
- 新增: internal/auth/jwt.go
- 新增: api/handlers/login.go
- 修改: models/user.go
- 修改: database/migrations/

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Youmi Sam <bwf5314@gmail.com>
```

## 🔧 工作流程详解

### 1. 预检查阶段

```
🔍 Git状态检查...
   • 工作目录状态: clean/dirty
   • 当前分支: main/feature
   • 远程状态: up-to-date/behind/ahead
   • 暂存区状态: empty/staged
```

### 2. 文件分析阶段

```
📁 变更文件分析...
   • 新增文件: 3个
   • 修改文件: 5个
   • 删除文件: 1个
   • 重命名文件: 0个

🔍 敏感信息检查...
   ✅ 未发现API密钥或密码
   ✅ 未发现数据库连接字符串
   ⚠️ 发现临时文件: temp.log (已忽略)
```

### 3. 提交信息生成

```
📝 生成提交信息...
   🎯 检测到提交类型: feat (新功能)
   📋 主要变更: 用户认证系统
   📄 详细描述: 基于文件变更自动生成
   ✅ 符合Conventional Commits规范
```

### 4. 用户确认阶段

```
📋 提交预览:
标题: feat: 添加用户认证系统
描述: [显示完整提交信息]

文件列表:
✓ internal/auth/jwt.go (新增)
✓ api/handlers/login.go (新增)
✓ models/user.go (修改)
✓ database/migrations/add_users.sql (新增)

确认提交? [y/N]: y
```

### 5. 执行提交

```
🚀 执行Git操作...
   📦 添加文件到暂存区...
   ✅ 提交完成: feat: 添加用户认证系统 (abc1234)
   🔄 推送到远程仓库...
   ✅ 推送成功: origin/main
```

## ⚙️ 配置选项

### Git 配置自动管理

```bash
# 自动配置用户信息
git config --local user.name "Youmi Sam"
git config --local user.email "bwf5314@gmail.com"

# 配置提交签名
git config --local commit.gpgsign false
git config --local commit.cleanup whitespace
```

### 项目特定配置

可以在 `.claude/project.json` 中自定义提交配置:

```json
{
  "git_settings": {
    "auto_push": true,
    "protected_branches": ["main", "master", "develop"],
    "commit_template": "conventional",
    "require_issue_reference": false,
    "pre_commit_hooks": ["lint", "test"],
    "post_commit_hooks": ["notify"]
  },
  "author_override": {
    "name": "Youmi Sam",
    "email": "bwf5314@gmail.com"
  }
}
```

## 🔒 安全机制

### 敏感信息检测

- **API 密钥模式**: `api[_-]?key`, `secret[_-]?key`
- **密码模式**: `password\s*=`, `passwd\s*=`
- **Token 模式**: `token\s*=`, `access[_-]?token`
- **数据库连接**: `mongodb://`, `mysql://`, `postgres://`

### 文件类型过滤

```bash
# 自动忽略的文件类型
*.tmp *.temp *~ .DS_Store
node_modules/ dist/ build/
*.log logs/ *.pid
.env .env.local .env.production
```

### 分支保护机制

- 检查当前分支是否为保护分支
- 如果是保护分支，建议创建 feature 分支
- 提供自动分支创建和切换功能

## 📊 输出示例

### 成功提交

```
🎉 提交成功！
===============================================

✅ 提交信息: feat: 添加用户认证系统
📝 提交哈希: abc1234567
🌿 目标分支: main
⏱️ 提交时间: 2024-01-20 15:30:45

📊 变更统计:
  • 新增文件: 3个
  • 修改文件: 5个
  • 删除行数: 25行
  • 新增行数: 156行

🚀 远程推送: ✅ 成功
📱 通知状态: ✅ 已发送

💡 后续建议:
  - 考虑创建PR到主分支
  - 更新相关文档
  - 通知团队成员review
```

### 错误处理

```
❌ 提交失败！
===============================================

🚫 检测到问题:
  • 发现敏感信息: config/database.go (第15行)
  • 暂存区为空: 没有文件变更
  • 分支冲突: 需要先合并远程变更

🔧 解决建议:
  1. 移除敏感信息或添加到.gitignore
  2. 使用git add添加要提交的文件
  3. 执行git pull合并远程变更

📚 获取帮助:
  /git状态检查 - 查看详细Git状态
  /清理残余文件 - 清理临时文件
```

## 🔗 相关命令

- `/清理残余文件` - 提交前清理项目
- `/项目状态分析` - 检查项目健康度
- `/智能代码重构` - 优化代码结构
- `/加载全局上下文` - 刷新 Git 配置

## 📚 技术实现

- 基于 `git-operations.sh` 核心引擎
- 支持多种 Git 工作流程
- 集成 Conventional Commits 规范
- 自动化签名和邮箱配置
