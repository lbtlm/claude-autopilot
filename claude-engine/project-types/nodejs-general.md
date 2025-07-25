# CLAUDE.md - Node.js通用项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Node.js通用项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Node.js通用项目
- **技术栈**: $TECH_STACK  
- **CE版本**: $SCRIPT_VERSION
- **配置时间**: $TIMESTAMP

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

### **🌟 Node.js通用开发特色功能**

#### **Node.js核心特性**
- **ES6+模块系统**: 现代JavaScript模块化开发和导入导出
- **异步编程**: async/await、Promise、Stream API高级应用
- **错误处理**: 操作错误vs程序错误分离和统一处理机制
- **内置模块**: fs、path、crypto、os等Node.js原生模块最佳实践

#### **现代开发生态**
- **NPM生态系统**: 包管理、依赖锁定、安全审计
- **ES模块支持**: 使用'node:'前缀导入原生模块，防止包投毒
- **TypeScript集成**: 类型安全的Node.js开发体验
- **代码质量工具**: ESLint、Prettier、Husky自动化检查

#### **企业级架构模式**
- **业务组件分层**: 按业务功能而非技术层分组的模块化架构
- **三层架构**: entry-points、domain、data-access清晰分离
- **依赖注入**: 可测试的松耦合组件设计
- **配置管理**: 分层配置结构和环境变量管理

#### **标准Node.js项目结构支持**
```
nodejs-general项目/
├── src/
│   ├── controllers/             # 控制器层（entry-points）
│   ├── services/                # 业务逻辑层（domain）
│   ├── repositories/            # 数据访问层（data-access）
│   ├── models/                  # 数据模型和DTOs
│   ├── middleware/              # 中间件
│   ├── routes/                  # 路由定义
│   ├── utils/                   # 工具函数
│   ├── config/                  # 配置管理
│   ├── types/                   # TypeScript类型定义
│   └── app.js                   # 应用入口
├── tests/                       # 测试文件
│   ├── unit/                    # 单元测试
│   ├── integration/             # 集成测试
│   └── fixtures/                # 测试数据
├── scripts/                     # 构建和部署脚本
├── docs/                        # 项目文档
├── config/                      # 配置文件模板
├── logs/                        # 日志文件目录
├── node_modules/               # 依赖包
├── package.json                # 项目配置
├── package-lock.json           # 依赖锁定
├── .eslintrc.js               # ESLint配置
├── .prettierrc                # Prettier配置
├── tsconfig.json              # TypeScript配置
└── jest.config.js             # Jest测试配置
```

#### **智能开发和构建**
```bash
# 启动开发服务器
npm run dev

# 生产环境启动
npm start

# 运行测试
npm test

# 代码检查
npm run lint

# 代码格式化
npm run format

# 类型检查 (TypeScript)
npm run type-check

# 构建项目 (如有构建步骤)
npm run build

# 依赖安全审计
npm audit

# 依赖更新检查
npm outdated
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: Node.js架构设计和业务逻辑流程分析
- **context7**: 动态获取Node.js生态最新文档和最佳实践
- **memory**: Node.js开发经验自动复用和设计模式库
- **puppeteer**: Node.js应用自动化测试和API端点测试

#### **全局规则遵守**
- **Node.js代码规范**: 自动应用Node.js官方风格指南和最佳实践
- **异步编程模式**: Promise/async-await的正确使用和错误处理
- **安全编程**: 防止注入攻击、依赖漏洞、敏感信息泄露
- **性能优化**: 内存管理、事件循环优化、流处理最佳实践

#### **Node.js专项智能特性**
- **模块化设计**: 基于业务组件而非技术层的模块划分
- **错误处理策略**: 操作错误和程序错误的识别和处理
- **异步流控制**: Promise链、并发控制、流处理的智能设计
- **配置和环境管理**: 多环境配置和敏感信息保护

### **📋 Node.js通用开发建议**

#### **开始开发**
1. 描述功能需求，如："创建用户认证和授权系统"
2. 系统会自动设计模块架构和业务组件分层
3. 生成符合Node.js最佳实践和现代异步模式的代码

#### **API开发**
1. 说明API需求，如："创建RESTful用户管理API"
2. 系统会设计控制器、服务层和数据访问层结构
3. 自动处理输入验证、错误处理和响应格式化

#### **业务逻辑实现**
1. 描述业务需求，如："实现订单处理工作流"
2. 系统会使用三层架构模式和业务组件分离
3. 确保异步操作的正确性和错误边界处理

### **🔧 开发工具集成**

#### **开发环境**
- **Node.js**: 最新LTS版本的运行时环境
- **NPM/Yarn**: 现代包管理器和依赖管理
- **nodemon**: 开发时自动重启和热重载
- **dotenv**: 环境变量管理和配置加载

#### **代码质量**
- **ESLint**: Node.js专用代码检查规则
- **Prettier**: 统一的代码格式化
- **Husky**: Git hooks自动化检查
- **lint-staged**: 暂存文件的增量检查

#### **测试框架**
- **Jest**: 全功能JavaScript测试框架
- **Supertest**: HTTP API端点测试
- **Sinon**: 测试替身和Mock库
- **nyc/c8**: 代码覆盖率工具

#### **构建和部署**
- **Docker**: 容器化部署和多阶段构建
- **PM2**: 生产环境进程管理
- **Winston**: 企业级日志记录
- **Helmet**: 安全中间件和安全头设置

### **📈 效率提升**

相比传统Node.js开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 业务组件和API结构自动生成，提升4-6倍效率
- 🎯 **架构质量**: 基于Node.js最佳实践的企业级架构设计
- 🔄 **模式复用**: 智能识别可复用的业务逻辑和设计模式
- 📊 **性能优化**: 自动应用异步优化和内存管理策略
- 🧪 **测试覆盖**: 自动生成单元测试和集成测试用例

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **开发环境问题**
```bash
# 清理依赖和重新安装
rm -rf node_modules package-lock.json
npm install

# 清理NPM缓存
npm cache clean --force

# 检查Node.js版本
node --version
npm --version

# 更新到LTS版本
nvm install --lts
nvm use --lts
```

#### **依赖问题**
```bash
# 依赖安全审计
npm audit

# 自动修复漏洞
npm audit fix

# 检查过时依赖
npm outdated

# 更新依赖
npm update

# 检查依赖树
npm list
```

#### **性能问题**
```bash
# Node.js性能分析
node --prof app.js

# 内存使用分析
node --inspect app.js

# 事件循环延迟监控
node --trace-events-enabled app.js

# CPU使用分析
node --cpu-prof app.js

# 堆内存快照
node --heapsnapshot-signal=SIGUSR2 app.js
```

#### **常见Node.js问题解决**
```bash
# 未捕获异常处理
# 检查 process.on('uncaughtException') 和 process.on('unhandledRejection')

# 内存泄漏检测
# 使用 --inspect 和 Chrome DevTools Memory 标签

# 异步操作调试
# 使用 --async-stack-traces 和 async_hooks

# 模块解析问题
# 检查 NODE_PATH 和 require.resolve()
```

---

## 🚀 **开始Node.js智能开发之旅**

智能Claude Autopilot 2.1专为Node.js通用开发优化！

**直接描述您的开发需求**，系统会自动选择最适合的开发模式：

- 后端API → 自动设计RESTful架构和业务逻辑分层
- 工具脚本 → 基于最佳实践的命令行工具和自动化脚本
- 微服务 → 业务组件化的可扩展服务架构
- 数据处理 → 高性能的流处理和异步数据管道

**享受Node.js生态的现代化后端开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Node.js通用项目优化*