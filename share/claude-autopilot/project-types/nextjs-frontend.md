# Next.js前端项目规范

## 📋 项目特征

- **适用场景**: 全栈Web应用、电商平台、企业级前端、静态站点、博客平台、SaaS应用
- **技术栈**: Next.js 15 + App Router + TypeScript + Tailwind CSS + Server Components
- **开发模式**: 混合渲染 (SSG + SSR + ISR) + Server Actions + API Routes
- **部署方式**: 🚀 Vercel一键部署 + 静态导出 + Docker容器化 + Edge Functions
- **特点**: 全栈框架、零配置、性能优化、SEO友好、95%项目覆盖

## 🏗️ 通用标准项目结构（适用于所有Next.js项目）

```
nextjs-frontend项目/
├── src/                             # 📁 源代码目录 (2025推荐结构)
│   ├── app/                         # ▲ App Router目录 (Next.js 13+推荐)
│   │   ├── layout.tsx               # 🎨 根布局 (必需)
│   │   ├── page.tsx                 # 🏠 首页
│   │   ├── loading.tsx              # ⏳ 全局加载UI
│   │   ├── error.tsx                # ❌ 全局错误UI
│   │   ├── not-found.tsx            # 🔍 404页面
│   │   ├── globals.css              # 🎨 全局样式
│   │   ├── (auth)/                  # 🔐 路由分组 (不影响URL)
│   │   │   ├── login/               # 📂 嵌套路由
│   │   │   │   ├── page.tsx         # 登录页面
│   │   │   │   └── loading.tsx      # 登录加载UI
│   │   │   └── register/
│   │   │       └── page.tsx         # 注册页面
│   │   ├── dashboard/               # 📊 仪表板路由
│   │   │   ├── layout.tsx           # 仪表板布局
│   │   │   ├── page.tsx             # 仪表板首页
│   │   │   ├── loading.tsx          # 仪表板加载UI
│   │   │   ├── analytics/           # 📈 嵌套路由
│   │   │   │   └── page.tsx         # 分析页面
│   │   │   └── settings/
│   │   │       └── page.tsx         # 设置页面
│   │   ├── api/                     # 🌐 API路由 (App Router)
│   │   │   ├── auth/                # 认证API
│   │   │   │   ├── login/
│   │   │   │   │   └── route.ts     # POST /api/auth/login
│   │   │   │   └── logout/
│   │   │   │       └── route.ts     # POST /api/auth/logout
│   │   │   ├── users/               # 用户API
│   │   │   │   ├── route.ts         # GET/POST /api/users
│   │   │   │   └── [id]/
│   │   │   │       └── route.ts     # GET/PUT/DELETE /api/users/[id]
│   │   │   └── healthcheck/
│   │   │       └── route.ts         # 健康检查API
│   │   └── [...slug]/               # 📄 捕获所有路由 (动态路由)
│   │       └── page.tsx             # 动态页面处理
│   ├── components/                  # 🎨 组件库 (现代化组织)
│   │   ├── ui/                      # 🧩 基础UI组件 (Shadcn/ui风格)
│   │   │   ├── button.tsx           # 按钮组件
│   │   │   ├── input.tsx            # 输入框组件
│   │   │   ├── card.tsx             # 卡片组件
│   │   │   ├── modal.tsx            # 模态框组件
│   │   │   ├── toast.tsx            # 消息提示组件
│   │   │   └── index.ts             # 组件导出入口
│   │   ├── layout/                  # 📐 布局组件
│   │   │   ├── header.tsx           # 页头组件
│   │   │   ├── footer.tsx           # 页脚组件
│   │   │   ├── sidebar.tsx          # 侧边栏组件
│   │   │   └── navigation.tsx       # 导航组件
│   │   ├── forms/                   # 📝 表单组件
│   │   │   ├── login-form.tsx       # 登录表单
│   │   │   ├── register-form.tsx    # 注册表单
│   │   │   └── contact-form.tsx     # 联系表单
│   │   └── features/                # 🚀 功能组件
│   │       ├── auth/                # 认证相关组件
│   │       │   ├── auth-provider.tsx
│   │       │   └── protected-route.tsx
│   │       ├── dashboard/           # 仪表板组件
│   │       │   ├── stats-card.tsx
│   │       │   └── chart-widget.tsx
│   │       └── profile/             # 用户资料组件
│   │           ├── profile-form.tsx
│   │           └── avatar-upload.tsx
│   ├── lib/                         # 🛠️ 工具库和配置
│   │   ├── utils.ts                 # 通用工具函数
│   │   ├── validations.ts           # 数据验证 (Zod)
│   │   ├── constants.ts             # 应用常量
│   │   ├── auth.ts                  # 认证配置 (NextAuth.js)
│   │   ├── db.ts                    # 数据库配置
│   │   ├── api.ts                   # API客户端配置
│   │   └── fonts.ts                 # 字体配置 (Next.js Font)
│   ├── hooks/                       # 🪝 自定义React Hooks
│   │   ├── use-auth.ts              # 认证Hook
│   │   ├── use-local-storage.ts     # 本地存储Hook
│   │   ├── use-api.ts               # API请求Hook
│   │   ├── use-theme.ts             # 主题切换Hook
│   │   └── use-debounce.ts          # 防抖Hook
│   ├── context/                     # 🌐 React Context
│   │   ├── auth-context.tsx         # 认证上下文
│   │   ├── theme-context.tsx        # 主题上下文
│   │   └── app-context.tsx          # 应用全局上下文
│   ├── types/                       # 📝 TypeScript类型定义
│   │   ├── index.ts                 # 类型入口
│   │   ├── auth.ts                  # 认证相关类型
│   │   ├── api.ts                   # API相关类型
│   │   ├── database.ts              # 数据库相关类型
│   │   └── global.d.ts              # 全局类型声明
│   ├── styles/                      # 🎨 样式文件
│   │   ├── globals.css              # 全局样式 (Tailwind)
│   │   ├── components.css           # 组件样式
│   │   └── utilities.css            # 工具样式
│   └── middleware.ts                # 🛡️ Next.js中间件
├── public/                          # 📦 静态资源
│   ├── images/                      # 图片资源
│   │   ├── logo.svg                 # Logo
│   │   ├── hero.jpg                 # 首页英雄图
│   │   └── avatars/                 # 头像图片
│   ├── icons/                       # 图标资源
│   │   ├── favicon.ico              # 网站图标
│   │   ├── apple-touch-icon.png     # 苹果触摸图标
│   │   └── manifest.json            # PWA清单文件
│   └── robots.txt                   # 搜索引擎爬虫配置
├── tests/                           # 🧪 测试文件
│   ├── __mocks__/                   # Mock文件
│   ├── unit/                        # 单元测试
│   │   ├── components/              # 组件测试
│   │   ├── utils/                   # 工具函数测试
│   │   └── hooks/                   # Hook测试
│   ├── integration/                 # 集成测试
│   │   └── api/                     # API测试
│   ├── e2e/                         # 端到端测试 (Playwright)
│   │   ├── auth.spec.ts             # 认证流程测试
│   │   └── dashboard.spec.ts        # 仪表板测试
│   └── setup.ts                     # 测试环境设置
├── docs/                            # 📚 项目文档
│   ├── api.md                       # API文档
│   ├── deployment.md                # 部署指南
│   └── contributing.md              # 贡献指南
├── .env.example                     # 环境变量示例
├── .env.local                       # 本地环境变量
├── .gitignore                       # Git忽略文件
├── .eslintrc.json                   # ESLint配置
├── prettier.config.js               # Prettier配置
├── tailwind.config.ts               # Tailwind CSS配置
├── tsconfig.json                    # TypeScript配置
├── next.config.js                   # Next.js配置
├── package.json                     # 项目依赖和脚本
├── pnpm-lock.yaml                   # 包管理器锁定文件
├── playwright.config.ts             # Playwright E2E测试配置
├── vitest.config.ts                 # Vitest单元测试配置
├── Dockerfile                       # Docker容器配置
├── docker-compose.yml               # Docker Compose配置
├── Makefile                         # 构建和开发工具
└── README.md                        # 项目文档
```

## 🔧 2025年技术栈标准

### **现代Next.js核心特性**

**Next.js 15 最新特性 (基于官方文档)**
- **Next.js 15.0** - 最新稳定版本，React 19支持
- **App Router** - 现代化文件系统路由，完全替代Pages Router
- **Server Components** - 默认服务器组件，零JavaScript到客户端
- **Server Actions** - 表单提交和数据变更的服务器函数
- **Turbopack** - 超快开发服务器 (替代Webpack)

**现代化构建工具链 (基于Next.js官方文档)**
- **React 19** - 最新React版本完整支持
- **TypeScript 5.0+** - 完整类型安全开发体验
- **Tailwind CSS v4** - 现代化原子CSS框架
- **ESLint 9+ Flat Config** - 现代化代码质量检查

### **前端依赖配置 (package.json)**
```json
{
  "name": "nextjs-frontend-project",
  "version": "1.0.0",
  "scripts": {
    "dev": "next dev --turbo",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit",
    "test": "vitest",
    "test:e2e": "playwright test",
    "format": "prettier --write .",
    "analyze": "ANALYZE=true next build"
  },
  "dependencies": {
    "next": "^15.0.0",
    "react": "^19.0.0",
    "react-dom": "^19.0.0",
    "@next/font": "^15.0.0",
    "next-auth": "^5.0.0",
    "zod": "^3.23.0",
    "tailwindcss": "^4.0.0",
    "class-variance-authority": "^0.7.0",
    "clsx": "^2.1.0",
    "tailwind-merge": "^2.5.0"
  },
  "devDependencies": {
    "@types/node": "^22.0.0",
    "@types/react": "^19.0.0",
    "@types/react-dom": "^19.0.0",
    "typescript": "^5.6.0",
    "eslint": "^9.0.0",
    "eslint-config-next": "^15.0.0",
    "prettier": "^3.3.0",
    "prettier-plugin-tailwindcss": "^0.6.0",
    "@playwright/test": "^1.47.0",
    "vitest": "^2.1.0",
    "@vitejs/plugin-react": "^4.3.0",
    "autoprefixer": "^10.4.0",
    "postcss": "^8.4.0"
  }
}
```

### **开发依赖 (devDependencies)**
```json
{
  "devDependencies": {
    "@testing-library/react": "^16.0.0",
    "@testing-library/jest-dom": "^6.5.0",
    "@next/bundle-analyzer": "^15.0.0",
    "husky": "^9.1.0",
    "lint-staged": "^15.2.0",
    "@commitlint/cli": "^19.0.0",
    "@commitlint/config-conventional": "^19.0.0",
    "jsdom": "^25.0.0"
  }
}
```

## 🚀 标准化开发流程

### ⭐ 基于Next.js官方最佳实践的开发流程

遵循Next.js官方文档推荐的App Router开发模式和项目结构：

#### 项目初始化命令

```bash
# 1. 使用官方脚手架创建项目 (2025推荐配置)
npx create-next-app@latest my-nextjs-project \
  --typescript \
  --tailwind \
  --eslint \
  --app \
  --src-dir \
  --import-alias "@/*"

# 2. 进入项目目录
cd my-nextjs-project

# 3. 安装额外依赖
npm install next-auth zod class-variance-authority clsx tailwind-merge

# 4. 安装开发依赖
npm install -D @playwright/test vitest @vitejs/plugin-react jsdom
```

## 📜 2025年标准化 Makefile

```makefile
.PHONY: install dev build start test lint format type-check e2e analyze clean help

# 项目配置
PROJECT_NAME = nextjs-frontend-project
NODE_VERSION = 20
PORT = 3000

help:
	@echo "🚀 Next.js前端项目开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  install       - 安装项目依赖"
	@echo "  dev           - 启动开发服务器 (Turbopack)"
	@echo "  start         - 启动生产服务器"
	@echo "  type-check    - TypeScript类型检查"
	@echo ""
	@echo "🏗️  构建测试:"
	@echo "  build         - 生产环境构建"
	@echo "  test          - 运行单元测试"
	@echo "  test:e2e      - 运行端到端测试"
	@echo "  lint          - 代码质量检查"
	@echo "  format        - 代码格式化"
	@echo ""
	@echo "📊 分析优化:"
	@echo "  analyze       - 构建产物分析"
	@echo "  lighthouse    - 性能审计"
	@echo ""
	@echo "🧹 维护:"
	@echo "  clean         - 清理构建文件"
	@echo "  health-check  - 项目健康检查"

install:
	@echo "📦 安装项目依赖..."
	npm install
	@echo "✅ 依赖安装完成!"

dev:
	@echo "🚀 启动开发服务器 (Turbopack)..."
	npm run dev

build:
	@echo "🏗️ 生产环境构建..."
	npm run build
	@echo "✅ 构建完成!"

start:
	@echo "▶️ 启动生产服务器..."
	npm run start

test:
	@echo "🧪 运行单元测试..."
	npm run test
	@echo "✅ 测试完成!"

test\\:e2e:
	@echo "🎭 运行端到端测试..."
	npm run test:e2e
	@echo "✅ E2E测试完成!"

lint:
	@echo "🔍 代码质量检查..."
	npm run lint
	@echo "✅ 代码检查完成!"

format:
	@echo "✨ 代码格式化..."
	npm run format
	@echo "✅ 格式化完成!"

type-check:
	@echo "📝 TypeScript类型检查..."
	npm run type-check
	@echo "✅ 类型检查完成!"

analyze:
	@echo "📊 构建产物分析..."
	npm run analyze
	@echo "✅ 分析完成!"

lighthouse:
	@echo "🔍 运行Lighthouse性能审计..."
	npm run build && npm run start &
	sleep 5
	npx lighthouse http://localhost:$(PORT) --output=html --output-path=./lighthouse-report.html
	@echo "✅ 性能审计完成! 查看 lighthouse-report.html"

clean:
	@echo "🧹 清理构建文件..."
	rm -rf .next/
	rm -rf out/
	rm -rf node_modules/.cache/
	rm -rf coverage/
	rm -rf test-results/
	rm -rf playwright-report/
	@echo "✅ 清理完成!"

health-check:
	@echo "🏥 项目健康检查..."
	npm run type-check
	npm run lint
	npm run test -- --run
	npm run build
	@echo "✅ 健康检查完成!"

# 依赖管理
upgrade-deps:
	@echo "⬆️ 升级依赖包..."
	npm update
	@echo "✅ 依赖升级完成!"

# 部署准备
deploy-check:
	@echo "🚀 部署前检查..."
	npm run health-check
	npm run analyze
	@echo "✅ 部署检查完成!"

# Docker相关
docker-build:
	@echo "🐳 构建Docker镜像..."
	docker build -t $(PROJECT_NAME):latest .
	@echo "✅ Docker镜像构建完成!"

docker-run:
	@echo "🐳 运行Docker容器..."
	docker run -p $(PORT):$(PORT) $(PROJECT_NAME):latest

# 开发辅助
db-generate:
	@echo "🗃️ 生成数据库类型..."
	npx prisma generate

db-migrate:
	@echo "🗃️ 运行数据库迁移..."
	npx prisma migrate dev
```

## 📝 核心配置文件示例

### **Next.js配置 (next.config.js)**
```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  // React严格模式
  reactStrictMode: true,
  
  // 实验性功能
  experimental: {
    // 启用Turbopack (开发时超快构建)
    turbo: {
      rules: {
        '*.svg': {
          loaders: ['@svgr/webpack'],
          as: '*.js',
        },
      },
    },
    // Server Actions
    serverActions: {
      allowedOrigins: ['localhost:3000'],
    },
  },

  // 图片域名配置
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'example.com',
        port: '',
        pathname: '/images/**',
      },
    ],
  },

  // 环境变量
  env: {
    CUSTOM_KEY: process.env.CUSTOM_KEY,
  },

  // 重定向配置
  async redirects() {
    return [
      {
        source: '/old-page',
        destination: '/new-page',
        permanent: true,
      },
    ]
  },

  // 重写配置
  async rewrites() {
    return [
      {
        source: '/api/proxy/:path*',
        destination: 'https://api.example.com/:path*',
      },
    ]
  },

  // Webpack配置
  webpack: (config, { buildId, dev, isServer, defaultLoaders, webpack }) => {
    // 自定义Webpack配置
    return config
  },

  // 输出配置
  output: 'standalone', // Docker部署优化
  
  // PoweredBy头移除
  poweredByHeader: false,
  
  // 压缩启用
  compress: true,
}

// 条件性配置
if (process.env.ANALYZE === 'true') {
  const withBundleAnalyzer = require('@next/bundle-analyzer')({
    enabled: true,
  })
  module.exports = withBundleAnalyzer(nextConfig)
} else {
  module.exports = nextConfig
}
```

### **现代化App Router页面示例 (基于官方最佳实践)**
```tsx
// src/app/dashboard/page.tsx
import { Suspense } from 'react'
import { Metadata } from 'next'
import { notFound } from 'next/navigation'
import { getUserData, getAnalytics } from '@/lib/api'
import { StatsCard } from '@/components/features/dashboard/stats-card'
import { ChartWidget } from '@/components/features/dashboard/chart-widget'
import { LoadingSkeleton } from '@/components/ui/loading-skeleton'

// 静态元数据
export const metadata: Metadata = {
  title: '仪表板 - 数据统计',
  description: '查看您的数据统计和分析报告',
  keywords: ['仪表板', '统计', '分析'],
}

// 动态元数据 (如果需要)
export async function generateMetadata({ params }: { params: { id: string } }): Promise<Metadata> {
  const user = await getUserData(params.id)
  
  if (!user) {
    return { title: '用户不存在' }
  }
  
  return {
    title: `${user.name}的仪表板`,
    description: `查看${user.name}的数据统计`,
  }
}

// 服务器组件 (默认)
export default async function DashboardPage({
  searchParams,
}: {
  searchParams: { [key: string]: string | string[] | undefined }
}) {
  // 服务器端数据获取
  const [userData, analyticsData] = await Promise.all([
    getUserData(),
    getAnalytics(searchParams.period as string),
  ])

  if (!userData) {
    notFound() // 自动显示 not-found.tsx
  }

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white">
          欢迎回来，{userData.name}
        </h1>
        <p className="text-gray-600 dark:text-gray-300 mt-2">
          这是您的数据仪表板
        </p>
      </div>

      {/* 统计卡片网格 */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        {analyticsData.stats.map((stat) => (
          <StatsCard
            key={stat.id}
            title={stat.title}
            value={stat.value}
            change={stat.change}
            trend={stat.trend}
          />
        ))}
      </div>

      {/* 图表组件 */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Suspense fallback={<LoadingSkeleton />}>
          <ChartWidget
            title="用户增长趋势"
            data={analyticsData.userGrowth}
            type="line"
          />
        </Suspense>
        
        <Suspense fallback={<LoadingSkeleton />}>
          <ChartWidget
            title="收入统计"
            data={analyticsData.revenue}
            type="bar"
          />
        </Suspense>
      </div>
    </div>
  )
}

// 路由段配置
export const dynamic = 'force-dynamic' // 总是服务器渲染
export const revalidate = 3600 // ISR: 每小时重新生成
```

### **Server Actions示例 (表单处理)**
```tsx
// src/app/contact/page.tsx
import { SubmitButton } from '@/components/ui/submit-button'
import { redirect } from 'next/navigation'
import { z } from 'zod'

// 服务器动作 (Server Action)
async function submitContact(formData: FormData) {
  'use server'
  
  // 数据验证
  const schema = z.object({
    name: z.string().min(2, '姓名至少2个字符'),
    email: z.string().email('请输入有效的邮箱地址'),
    message: z.string().min(10, '消息至少10个字符'),
  })
  
  const result = schema.safeParse({
    name: formData.get('name'),
    email: formData.get('email'),
    message: formData.get('message'),
  })
  
  if (!result.success) {
    throw new Error('表单数据无效')
  }
  
  // 处理数据 (发送邮件、保存到数据库等)
  await saveContactMessage(result.data)
  
  // 重定向到成功页面
  redirect('/contact/success')
}

export default function ContactPage() {
  return (
    <div className="max-w-2xl mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-8">联系我们</h1>
      
      <form action={submitContact} className="space-y-6">
        <div>
          <label htmlFor="name" className="block text-sm font-medium mb-2">
            姓名
          </label>
          <input
            type="text"
            id="name"
            name="name"
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        
        <div>
          <label htmlFor="email" className="block text-sm font-medium mb-2">
            邮箱
          </label>
          <input
            type="email"
            id="email"
            name="email"
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        
        <div>
          <label htmlFor="message" className="block text-sm font-medium mb-2">
            消息
          </label>
          <textarea
            id="message"
            name="message"
            rows={5}
            required
            className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        
        <SubmitButton />
      </form>
    </div>
  )
}

async function saveContactMessage(data: {
  name: string
  email: string
  message: string
}) {
  // 实际的数据库保存逻辑
  console.log('保存联系消息:', data)
}
```

### **API路由示例 (App Router)**
```typescript
// src/app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server'
import { z } from 'zod'
import { getServerSession } from 'next-auth'
import { authOptions } from '@/lib/auth'

// 用户数据验证schema
const createUserSchema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
  role: z.enum(['user', 'admin']).default('user'),
})

// GET /api/users
export async function GET(request: NextRequest) {
  try {
    // 认证检查
    const session = await getServerSession(authOptions)
    if (!session) {
      return NextResponse.json({ error: '未授权' }, { status: 401 })
    }

    // 查询参数
    const searchParams = request.nextUrl.searchParams
    const page = parseInt(searchParams.get('page') || '1')
    const limit = parseInt(searchParams.get('limit') || '10')

    // 获取用户列表 (模拟数据库查询)
    const users = await getUserList({ page, limit })

    return NextResponse.json({
      data: users,
      pagination: {
        page,
        limit,
        total: users.length,
      },
    })
  } catch (error) {
    console.error('获取用户列表失败:', error)
    return NextResponse.json(
      { error: '内部服务器错误' },
      { status: 500 }
    )
  }
}

// POST /api/users
export async function POST(request: NextRequest) {
  try {
    // 认证检查
    const session = await getServerSession(authOptions)
    if (!session || session.user.role !== 'admin') {
      return NextResponse.json({ error: '权限不足' }, { status: 403 })
    }

    // 解析请求体
    const body = await request.json()
    
    // 数据验证
    const result = createUserSchema.safeParse(body)
    if (!result.success) {
      return NextResponse.json(
        { error: '数据验证失败', details: result.error.format() },
        { status: 400 }
      )
    }

    // 创建用户
    const newUser = await createUser(result.data)

    return NextResponse.json(
      { data: newUser, message: '用户创建成功' },
      { status: 201 }
    )
  } catch (error) {
    console.error('创建用户失败:', error)
    return NextResponse.json(
      { error: '内部服务器错误' },
      { status: 500 }
    )
  }
}

// 模拟数据库操作
async function getUserList({ page, limit }: { page: number; limit: number }) {
  // 实际项目中这里会是数据库查询
  return [
    { id: 1, name: '张三', email: 'zhangsan@example.com', role: 'user' },
    { id: 2, name: '李四', email: 'lisi@example.com', role: 'admin' },
  ]
}

async function createUser(userData: z.infer<typeof createUserSchema>) {
  // 实际项目中这里会是数据库插入
  return {
    id: Date.now(),
    ...userData,
    createdAt: new Date().toISOString(),
  }
}
```

### **中间件示例 (middleware.ts)**
```typescript
// src/middleware.ts
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'
import { getToken } from 'next-auth/jwt'

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl

  // 静态资源和API路由跳过处理
  if (
    pathname.startsWith('/_next') ||
    pathname.startsWith('/api/auth') ||
    pathname.startsWith('/images') ||
    pathname.includes('.')
  ) {
    return NextResponse.next()
  }

  // 获取认证token
  const token = await getToken({ 
    req: request, 
    secret: process.env.NEXTAUTH_SECRET 
  })

  // 保护需要认证的路由
  const protectedRoutes = ['/dashboard', '/profile', '/admin']
  const isProtectedRoute = protectedRoutes.some(route => 
    pathname.startsWith(route)
  )

  if (isProtectedRoute && !token) {
    // 重定向到登录页面
    const loginUrl = new URL('/login', request.url)
    loginUrl.searchParams.set('callbackUrl', pathname)
    return NextResponse.redirect(loginUrl)
  }

  // 管理员路由检查
  if (pathname.startsWith('/admin') && token?.role !== 'admin') {
    return NextResponse.redirect(new URL('/unauthorized', request.url))
  }

  // 地理位置限制 (示例)
  const country = request.geo?.country || 'US'
  if (pathname.startsWith('/restricted') && country === 'CN') {
    return NextResponse.redirect(new URL('/not-available', request.url))
  }

  // 添加自定义头
  const response = NextResponse.next()
  response.headers.set('X-Custom-Header', 'Next.js App Router')
  
  return response
}

// 配置匹配器
export const config = {
  matcher: [
    /*
     * 匹配所有路径除了:
     * - api (API routes)
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     */
    '/((?!api|_next/static|_next/image|favicon.ico).*)',
  ],
}
```

## 🧪 现代化测试策略

### **Vitest单元测试配置**
```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./tests/setup.ts'],
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
})
```

### **组件测试示例**
```typescript
// tests/unit/components/button.test.tsx
import { render, screen, fireEvent } from '@testing-library/react'
import { describe, it, expect, vi } from 'vitest'
import { Button } from '@/components/ui/button'

describe('Button组件', () => {
  it('正确渲染按钮文本', () => {
    render(<Button>点击我</Button>)
    expect(screen.getByRole('button', { name: '点击我' })).toBeInTheDocument()
  })

  it('处理点击事件', () => {
    const handleClick = vi.fn()
    render(<Button onClick={handleClick}>点击</Button>)
    
    fireEvent.click(screen.getByRole('button'))
    expect(handleClick).toHaveBeenCalledTimes(1)
  })

  it('应用正确的样式变体', () => {
    render(<Button variant="destructive">删除</Button>)
    const button = screen.getByRole('button')
    expect(button).toHaveClass('bg-destructive')
  })
})
```

### **Playwright E2E测试**
```typescript
// tests/e2e/auth.spec.ts
import { test, expect } from '@playwright/test'

test.describe('用户认证流程', () => {
  test('用户可以成功登录', async ({ page }) => {
    // 访问登录页面
    await page.goto('/login')
    
    // 填写表单
    await page.fill('input[name="email"]', 'test@example.com')
    await page.fill('input[name="password"]', 'password123')
    
    // 点击登录按钮
    await page.click('button[type="submit"]')
    
    // 验证重定向到仪表板
    await expect(page).toHaveURL('/dashboard')
    await expect(page.locator('h1')).toContainText('欢迎回来')
  })

  test('显示无效凭据错误', async ({ page }) => {
    await page.goto('/login')
    
    await page.fill('input[name="email"]', 'invalid@example.com')
    await page.fill('input[name="password"]', 'wrongpassword')
    await page.click('button[type="submit"]')
    
    await expect(page.locator('[role="alert"]')).toContainText('登录失败')
  })
})
```

## 💾 现代前端架构模式

### TypeScript类型安全
- 完整的App Router类型支持
- Server Components和Client Components类型区分
- API路由响应类型自动推断
- Server Actions类型安全表单处理

### 渲染策略优化
```typescript
// 静态生成 (SSG)
export default async function StaticPage() {
  const data = await fetch('https://api.example.com/data')
  return <div>{/* 静态内容 */}</div>
}

// 服务器渲染 (SSR)
export const dynamic = 'force-dynamic'
export default async function DynamicPage() {
  const data = await fetch('https://api.example.com/realtime')
  return <div>{/* 动态内容 */}</div>
}

// 增量静态再生 (ISR)
export const revalidate = 3600 // 每小时重新生成
export default async function ISRPage() {
  const data = await fetch('https://api.example.com/content')
  return <div>{/* 缓存内容 */}</div>
}
```

### 智能化开发工具
- **Turbopack**: 超快的开发服务器和构建工具
- **Next.js DevTools**: 浏览器开发者工具扩展
- **TypeScript**: 静态类型检查和智能提示
- **ESLint + Prettier**: 自动化代码质量保证

## 🚀 现代化开发流程

### **项目初始化**

```bash
# 1. 使用Next.js官方脚手架 (2025推荐配置)
npx create-next-app@latest my-nextjs-project \
  --typescript \
  --tailwind \
  --eslint \
  --app \
  --src-dir \
  --import-alias "@/*"

# 2. 进入项目目录
cd my-nextjs-project

# 3. 安装额外依赖
make install

# 4. 启动开发服务器
make dev
```

### **日常开发工作流**

```bash
# 🔧 开发环境管理
make dev           # 启动Turbopack开发服务器 (http://localhost:3000)
make type-check    # TypeScript类型检查
make lint          # Next.js ESLint代码检查
make format        # Prettier代码格式化

# 🧪 测试和质量检查
make test          # 运行Vitest单元测试
make test:e2e      # 运行Playwright端到端测试
make health-check  # 完整项目健康检查

# 📦 构建和部署
make build         # 生产环境构建
make start         # 启动生产服务器
make analyze       # 构建产物分析
make lighthouse    # 性能审计

# 📊 性能分析
make analyze       # Bundle分析器
make lighthouse    # Lighthouse性能审计
make deploy-check  # 部署前检查
```

### **性能优化**

- **自动代码分割**: App Router自动按页面分割代码
- **图片优化**: Next.js Image组件自动优化和懒加载
- **字体优化**: Google Fonts和本地字体自动优化
- **服务器组件**: 零JavaScript到客户端的服务器渲染

### **现代化部署**

- **Vercel部署**: 零配置一键部署到Vercel平台
- **静态导出**: `next export`生成静态站点
- **Docker容器化**: 标准化容器部署
- **Edge Functions**: 边缘计算和全球分发

## 📚 2025年Next.js参考资源

### **官方文档**

- [Next.js 15官方文档](https://nextjs.org/docs) - 最权威的Next.js学习资源
- [App Router指南](https://nextjs.org/docs/app) - 现代化App Router开发指南
- [React 19文档](https://react.dev/) - 最新React特性和Hook
- [Tailwind CSS文档](https://tailwindcss.com/) - 原子CSS框架

### **最佳实践指南**

- Next.js App Router官方项目结构和文件约定
- Server Components和Client Components最佳实践
- 现代化TypeScript和Tailwind CSS集成方案
- 95%Next.js全栈项目需求覆盖的通用架构模式

---

**✨ 这个模板基于Next.js 15官方文档和2025年前端最佳实践，为Next.js全栈项目提供完整的现代化开发解决方案。**