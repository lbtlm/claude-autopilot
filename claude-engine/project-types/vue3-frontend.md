# CLAUDE.md - Vue3前端项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Vue3前端项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Vue3前端项目
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

### **🎨 Vue3前端开发特色功能**

#### **Vue3生态优化**
- **Composition API**: 响应式API和组合式函数最佳实践
- **Pinia状态管理**: 类型安全的现代状态管理解决方案
- **Vue Router 4**: 基于Promise的现代路由系统
- **TypeScript集成**: 完整的类型安全开发体验

#### **现代化构建工具**
- **Vite快速构建**: 极速的开发服务器和构建工具
- **热模块替换**: 实时开发体验和快速迭代
- **Tree Shaking**: 自动去除未使用代码
- **代码分割**: 智能的异步组件加载

#### **UI组件生态**
- **Element Plus**: 基于Vue3的桌面端组件库
- **Ant Design Vue**: 企业级UI设计语言Vue3版本
- **Naive UI**: 轻量级Vue3组件库
- **Quasar**: 跨平台Vue3框架

#### **标准Vue3项目结构支持**
```
vue3-frontend项目/
├── public/
│   ├── index.html               # HTML模板
│   └── favicon.ico             # 网站图标
├── src/
│   ├── components/             # 通用组件
│   ├── views/                  # 页面组件
│   ├── router/                 # 路由配置
│   ├── stores/                 # Pinia状态管理
│   ├── assets/                 # 静态资源
│   ├── utils/                  # 工具函数
│   ├── api/                    # API接口
│   ├── composables/            # 组合式函数
│   ├── types/                  # TypeScript类型定义
│   └── main.ts                 # 应用入口
├── tests/
│   ├── unit/                   # 单元测试
│   └── e2e/                    # 端到端测试
├── dist/                       # 构建输出
├── node_modules/              # 依赖包
├── package.json               # 项目配置
├── vite.config.ts             # Vite配置
├── tsconfig.json              # TypeScript配置
└── vitest.config.ts           # 测试配置
```

#### **智能开发和构建**
```bash
# 本地开发服务器
npm run dev

# 生产环境构建
npm run build

# 运行单元测试
npm run test:unit

# 类型检查
npm run type-check

# 代码检查和修复
npm run lint

# 代码格式化
npm run format

# 预览构建结果
npm run preview
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: 组件架构设计和用户体验流程分析
- **context7**: 动态获取Vue3生态最新文档和最佳实践
- **memory**: 前端开发经验自动复用和组件设计模式库
- **puppeteer**: Web应用自动化测试和UI回归测试

#### **全局规则遵守**
- **Vue3代码规范**: 自动应用Vue3官方风格指南和Composition API最佳实践
- **TypeScript规范**: 严格的类型检查和类型安全编程
- **ESLint配置**: 现代化的代码质量检查规则
- **性能优化**: 组件懒加载、虚拟滚动、代码分割等优化策略

#### **Vue3专项智能特性**
- **组合式函数设计**: 可复用业务逻辑的最佳实践
- **响应式系统优化**: ref、reactive、computed的正确使用
- **组件通信模式**: props/emit、provide/inject、状态管理选择
- **生命周期管理**: 组合式API生命周期钩子的合理使用

### **📋 Vue3前端开发建议**

#### **开始开发**
1. 描述功能需求，如：\"创建用户管理仪表板\"
2. 系统会自动设计组件架构和状态管理方案
3. 生成符合Vue3 Composition API最佳实践的代码

#### **组件开发**
1. 说明组件需求，如：\"创建可复用的数据表格组件\"
2. 系统会使用Vue3最新特性和组合式函数
3. 自动处理TypeScript类型定义、响应式数据和事件处理

#### **状态管理**
1. 描述状态需求，如：\"实现全局用户认证状态\"
2. 系统会设计Pinia store结构和组合式函数
3. 确保类型安全和响应式数据流的正确性

### **🔧 开发工具集成**

#### **开发环境**
- **Vite**: 超快的构建工具和开发服务器
- **Vue Devtools**: 浏览器调试扩展（Vue3版本）
- **TypeScript**: 静态类型检查和智能提示
- **PostCSS**: CSS后处理器和现代化CSS特性

#### **代码质量**
- **ESLint**: Vue3和TypeScript代码检查
- **Prettier**: 统一的代码格式化
- **Stylelint**: CSS/SCSS代码规范检查
- **Husky**: Git hooks自动化检查

#### **测试框架**
- **Vitest**: 基于Vite的快速单元测试框架
- **Vue Test Utils**: Vue3组件测试工具
- **Cypress**: 现代端到端测试框架
- **Testing Library**: 基于用户行为的测试方法

#### **构建优化**
- **Tree Shaking**: 自动去除未使用代码
- **Code Splitting**: 路由级别的代码分割
- **Dynamic Import**: 异步组件和懒加载
- **PWA**: 渐进式Web应用优化

### **📈 效率提升**

相比传统Vue3开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 组件模板和状态管理自动生成，提升3-5倍效率
- 🎯 **代码质量**: 基于Vue3最佳实践和TypeScript的高质量代码
- 🔄 **组件复用**: 智能识别可复用的组合式函数和组件模式
- 📊 **性能优化**: 自动应用响应式优化和构建优化策略
- 🧪 **测试覆盖**: 自动生成组件测试用例和类型测试

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

# 清理Vite缓存
npx vite --force

# 检查依赖更新
npm outdated

# 修复依赖漏洞
npm audit fix
```

#### **构建问题**
```bash
# 清理构建缓存
rm -rf dist

# 重新构建
npm run build

# 分析构建产物
npm run build -- --report

# 检查TypeScript类型
npm run type-check
```

#### **组件问题**
```bash
# 组件测试
npm run test:unit -- --watch

# 组件调试（Vue Devtools）
# 在浏览器中安装Vue Devtools扩展

# 性能分析
# 使用Vue Devtools的Performance标签

# 响应式调试
# 使用Vue Devtools查看响应式数据变化
```

---

## 🚀 **开始Vue3智能开发之旅**

智能Claude Autopilot 2.1专为Vue3前端开发优化！

**直接描述您的前端开发需求**，系统会自动选择最适合的开发模式：

- 页面开发 → 自动设计组件结构和路由配置
- 状态管理 → 智能设计Pinia store和组合式函数
- 组件开发 → 基于Composition API的现代组件设计
- 性能优化 → 前端性能监控和构建优化建议

**享受Vue3生态的现代化前端开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Vue3前端项目优化*