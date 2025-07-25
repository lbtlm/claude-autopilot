# CLAUDE.md - React前端项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为React前端项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: React前端项目
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

### **⚛️ React前端开发特色功能**

#### **React核心特性**
- **函数组件 + Hooks**: 现代React开发模式和最佳实践
- **状态管理**: useState、useReducer、Context API模式选择
- **副作用处理**: useEffect、useLayoutEffect生命周期管理
- **性能优化**: useMemo、useCallback、React.memo优化技巧

#### **现代开发工具链**
- **Create React App**: 零配置快速启动开发环境
- **Vite**: 超快的现代构建工具（推荐）
- **TypeScript**: 类型安全的React开发体验
- **热重载**: 实时开发体验和快速迭代

#### **UI生态系统**
- **Material-UI (MUI)**: Google Material Design React组件库
- **Ant Design**: 企业级UI设计语言React版本
- **Chakra UI**: 简洁现代的组件库
- **React Bootstrap**: Bootstrap的React实现

#### **标准React项目结构支持**
```
react-frontend项目/
├── public/
│   ├── index.html              # HTML模板
│   └── favicon.ico             # 网站图标
├── src/
│   ├── components/             # 通用组件
│   ├── pages/                  # 页面组件
│   ├── hooks/                  # 自定义Hook
│   ├── context/                # React Context
│   ├── services/               # API服务
│   ├── utils/                  # 工具函数
│   ├── types/                  # TypeScript类型
│   ├── styles/                 # 样式文件
│   └── index.tsx               # 应用入口
├── tests/                      # 测试文件
├── build/                      # 构建输出
├── node_modules/              # 依赖包
├── package.json               # 项目配置
├── tsconfig.json              # TypeScript配置
└── craco.config.js            # CRACO配置（如使用）
```

#### **智能开发和构建**
```bash
# 启动开发服务器
npm start

# 生产环境构建
npm run build

# 运行测试
npm test

# 代码检查
npm run lint

# 类型检查 (TypeScript)
npm run type-check

# 代码格式化
npm run format

# 预览构建结果
npx serve -s build
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: React组件架构设计和状态管理模式分析
- **context7**: 动态获取React生态最新文档和最佳实践
- **memory**: React开发经验自动复用和Hook设计模式库
- **puppeteer**: React应用自动化测试和组件交互测试

#### **全局规则遵守**
- **React代码规范**: 自动应用React官方风格指南和Hooks最佳实践
- **TypeScript规范**: 严格的类型检查和React组件类型定义
- **ESLint配置**: React专用的代码质量检查规则
- **性能优化**: 组件渲染优化、Bundle拆分、懒加载策略

#### **React专项智能特性**
- **Hooks模式设计**: 自定义Hook的可复用逻辑提取
- **组件组合模式**: props、children、render props最佳实践
- **状态管理策略**: 本地状态vs全局状态的智能选择建议
- **副作用管理**: useEffect依赖数组和清理函数的正确使用

### **📋 React前端开发建议**

#### **开始开发**
1. 描述功能需求，如：\"创建用户个人资料管理页面\"
2. 系统会自动设计组件层次结构和状态管理方案
3. 生成符合React最佳实践和现代Hooks模式的代码

#### **组件开发**
1. 说明组件需求，如：\"创建可复用的数据表格组件\"
2. 系统会使用React最新特性和设计模式
3. 自动处理TypeScript类型、props验证和事件处理

#### **状态管理**
1. 描述状态需求，如：\"实现全局主题切换功能\"
2. 系统会评估并选择合适的状态管理方案（Context API、Redux等）
3. 确保状态更新的不可变性和性能优化

### **🔧 开发工具集成**

#### **开发环境**
- **React DevTools**: 浏览器调试扩展
- **Create React App**: 零配置开发环境
- **Vite**: 快速的现代构建工具（推荐）
- **Webpack**: 强大的模块打包器

#### **代码质量**
- **ESLint**: React专用代码检查规则
- **Prettier**: 统一的代码格式化
- **Husky**: Git hooks自动化检查
- **lint-staged**: 暂存文件的增量检查

#### **测试框架**
- **Jest**: JavaScript测试框架
- **React Testing Library**: 基于用户行为的组件测试
- **Cypress**: 端到端测试框架
- **Storybook**: 组件开发和文档化工具

#### **构建优化**
- **Code Splitting**: 基于路由的代码分割
- **Tree Shaking**: 死代码消除
- **Bundle Analyzer**: 打包体积分析
- **PWA**: 渐进式Web应用功能

### **📈 效率提升**

相比传统React开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 组件模板和Hook逻辑自动生成，提升3-5倍效率
- 🎯 **代码质量**: 基于React最佳实践和TypeScript的高质量代码
- 🔄 **模式复用**: 智能识别可复用的组件和Hook设计模式
- 📊 **性能优化**: 自动应用渲染优化和内存泄漏预防策略
- 🧪 **测试覆盖**: 自动生成组件测试用例和用户交互测试

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

# 清理Create React App缓存
rm -rf node_modules/.cache

# 检查依赖冲突
npm ls

# 更新依赖
npm update
```

#### **构建问题**
```bash
# 清理构建缓存
rm -rf build

# 重新构建
npm run build

# 分析打包体积
npm run analyze

# 检查TypeScript类型
npm run type-check
```

#### **组件问题**
```bash
# 组件测试
npm test -- --watch

# 组件调试（React DevTools）
# 在浏览器中安装React DevTools扩展

# 性能分析
# 使用React DevTools的Profiler标签

# 状态调试
# 使用React DevTools查看组件状态和props
```

#### **常见React问题解决**
```bash
# Hook规则检查
npm run lint -- --fix

# 内存泄漏检测
# 检查useEffect清理函数

# 无限渲染检查
# 检查useEffect依赖数组

# 性能问题排查
# 使用React.memo和useMemo优化
```

---

## 🚀 **开始React智能开发之旅**

智能Claude Autopilot 2.1专为React前端开发优化！

**直接描述您的前端开发需求**，系统会自动选择最适合的开发模式：

- 页面开发 → 自动设计组件层次结构和路由配置
- 状态管理 → 智能选择Context API、Redux或本地状态方案
- 组件开发 → 基于Hooks的现代组件设计模式
- 性能优化 → React性能监控和渲染优化建议

**享受React生态的现代化前端开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为React前端项目优化*