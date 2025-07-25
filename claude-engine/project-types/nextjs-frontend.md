# CLAUDE.md - Next.js前端项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Next.js前端项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Next.js前端项目
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

### **▲ Next.js前端开发特色功能**

#### **Next.js核心特性**
- **App Router (推荐)**: Next.js 13+的现代路由系统
- **Server Components**: 服务器端React组件提升性能
- **Server Actions**: 直接在组件中调用服务器函数
- **页面级数据获取**: getStaticProps、getServerSideProps、getStaticPaths

#### **全栈开发能力**
- **API Routes**: 内置的服务器端API开发
- **中间件**: 请求拦截和处理
- **静态生成 (SSG)**: 构建时预渲染页面
- **服务器渲染 (SSR)**: 请求时动态渲染页面

#### **性能优化内置功能**
- **自动代码分割**: 页面级自动bundle优化
- **图片优化**: Next.js Image组件自动优化
- **字体优化**: Google Fonts和本地字体自动优化
- **脚本优化**: 第三方脚本加载策略

#### **标准Next.js项目结构支持**
```
nextjs-frontend项目/
├── app/                        # App Router目录 (Next.js 13+)
│   ├── layout.tsx             # 根布局
│   ├── page.tsx               # 首页
│   ├── loading.tsx            # 加载UI
│   ├── error.tsx              # 错误UI
│   ├── not-found.tsx          # 404页面
│   └── globals.css            # 全局样式
├── pages/                      # Pages Router目录 (传统)
│   ├── api/                    # API路由
│   ├── _app.tsx               # 应用入口
│   ├── _document.tsx          # 文档结构
│   └── index.tsx              # 首页
├── components/                 # 组件
├── lib/                        # 工具库
├── hooks/                      # 自定义Hook
├── types/                      # TypeScript类型
├── styles/                     # 样式文件
├── public/                     # 静态资源
├── .next/                      # 构建输出
├── node_modules/              # 依赖包
├── package.json               # 项目配置
├── next.config.js             # Next.js配置
└── tsconfig.json              # TypeScript配置
```

#### **智能开发和构建**
```bash
# 启动开发服务器
npm run dev

# 生产环境构建
npm run build

# 启动生产服务器
npm start

# 代码检查
npm run lint

# 类型检查 (TypeScript)
npm run type-check

# 静态导出 (如需要)
npm run export

# 分析打包体积
npm run analyze
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: Next.js应用架构设计和全栈开发流程分析
- **context7**: 动态获取Next.js生态最新文档和最佳实践
- **memory**: Next.js开发经验自动复用和模式库
- **puppeteer**: Next.js应用自动化测试和SSR页面测试

#### **全局规则遵守**
- **Next.js代码规范**: 自动应用Next.js官方最佳实践和约定
- **TypeScript规范**: 严格的类型检查和Next.js特有类型
- **ESLint配置**: Next.js专用的代码质量检查规则
- **性能优化**: 自动应用SSR/SSG优化和Core Web Vitals改进

#### **Next.js专项智能特性**
- **渲染策略选择**: SSG、SSR、ISR的智能推荐和实现
- **数据获取模式**: getStaticProps、getServerSideProps的合理使用
- **API路由设计**: RESTful API和GraphQL端点的最佳实践
- **部署优化**: Vercel、Netlify等平台的部署配置

### **📋 Next.js前端开发建议**

#### **开始开发**
1. 描述功能需求，如：\"创建电商产品展示页面\"
2. 系统会自动选择合适的渲染策略和数据获取方法
3. 生成符合Next.js最佳实践的App Router或Pages Router代码

#### **页面开发**
1. 说明页面需求，如：\"创建用户仪表板页面\"
2. 系统会评估SSG、SSR或CSR的最佳选择
3. 自动处理路由、布局、数据获取和错误处理

#### **API开发**
1. 描述API需求，如：\"创建用户认证API\"
2. 系统会设计API路由结构和中间件
3. 确保API安全性和性能优化

### **🔧 开发工具集成**

#### **开发环境**
- **Next.js CLI**: 官方脚手架和开发工具
- **Turbopack**: 超快的开发服务器 (Next.js 13+)
- **TypeScript**: 完整的类型安全开发体验
- **Fast Refresh**: 快速热重载开发体验

#### **代码质量**
- **ESLint**: Next.js专用代码检查规则
- **Prettier**: 统一的代码格式化
- **TypeScript**: 静态类型检查
- **Husky**: Git hooks自动化检查

#### **测试框架**
- **Jest**: JavaScript测试框架
- **React Testing Library**: 组件测试
- **Playwright**: 端到端测试框架
- **Storybook**: 组件开发和文档化

#### **构建和部署**
- **Vercel**: 官方推荐的部署平台
- **Static Export**: 静态站点生成
- **Docker**: 容器化部署
- **CDN**: 自动静态资源优化

### **📈 效率提升**

相比传统全栈开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 页面和API路由自动生成，提升4-6倍效率
- 🎯 **架构质量**: 基于Next.js最佳实践的高质量全栈架构
- 🔄 **渲染优化**: 智能选择SSG、SSR、ISR渲染策略
- 📊 **性能监控**: 内置Core Web Vitals和性能优化建议
- 🚀 **部署简化**: 一键部署到Vercel和其他平台

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
rm -rf node_modules package-lock.json .next
npm install

# 清理Next.js缓存
rm -rf .next

# 检查Next.js版本
npm list next

# 更新Next.js
npm install next@latest
```

#### **构建问题**
```bash
# 清理构建缓存
rm -rf .next

# 重新构建
npm run build

# 检查构建输出
npm run build -- --debug

# 分析打包体积
npm run analyze
```

#### **渲染问题**
```bash
# 检查水合错误
# 查看浏览器控制台hydration warnings

# 检查服务器组件
# 确保正确使用'use client'指令

# 验证数据获取
# 检查getStaticProps/getServerSideProps返回值

# 调试路由问题
# 检查pages或app目录结构
```

#### **性能问题**
```bash
# 运行性能审计
npm run build && npm run start
# 使用Chrome DevTools Lighthouse

# 检查包体积
npm run analyze

# 优化图片
# 使用Next.js Image组件

# 检查Core Web Vitals
# 使用Vercel Analytics或Google PageSpeed Insights
```

---

## 🚀 **开始Next.js智能开发之旅**

智能Claude Autopilot 2.1专为Next.js全栈开发优化！

**直接描述您的开发需求**，系统会自动选择最适合的开发模式：

- 全栈应用 → 自动设计前后端架构和API接口
- 静态站点 → 智能选择SSG策略和构建优化
- 动态应用 → 基于SSR的高性能服务器渲染
- 混合应用 → ISR增量静态再生和缓存策略

**享受Next.js生态的现代化全栈开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Next.js前端项目优化*