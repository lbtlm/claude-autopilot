# React前端项目规范

## 📋 项目特征

- **适用场景**: SPA单页应用、管理后台、移动端PWA、企业级前端、组件库开发
- **技术栈**: React 18 + Vite 7.0 + TypeScript + Tailwind CSS + Zustand/Redux Toolkit
- **开发模式**: 函数组件 + Hooks + 模块化架构 + 原子设计模式
- **部署方式**: 🚀 静态部署 + CDN加速 + Docker容器化 + Vercel/Netlify
- **特点**: 组件化开发、TypeScript类型安全、高性能构建、95%项目覆盖

## 🏗️ 通用标准项目结构（适用于所有React项目）

```
react-frontend项目/
├── public/                          # 📦 静态资源
│   ├── index.html                   # HTML入口模板
│   ├── favicon.ico                  # 网站图标
│   ├── manifest.json                # PWA配置
│   └── robots.txt                   # SEO配置
├── src/                             # 📁 源代码目录
│   ├── components/                  # 🎨 组件库 (原子设计模式)
│   │   ├── atoms/                   # 原子组件
│   │   │   ├── Button/              # 按钮组件
│   │   │   │   ├── Button.tsx
│   │   │   │   ├── Button.module.css
│   │   │   │   ├── Button.test.tsx
│   │   │   │   └── index.ts
│   │   │   ├── Input/               # 输入框组件
│   │   │   ├── Badge/               # 徽章组件
│   │   │   └── index.ts             # 原子组件导出
│   │   ├── molecules/               # 分子组件
│   │   │   ├── SearchBox/           # 搜索框
│   │   │   ├── FormField/           # 表单字段
│   │   │   ├── Card/                # 卡片组件
│   │   │   └── index.ts
│   │   ├── organisms/               # 有机体组件
│   │   │   ├── Header/              # 页头
│   │   │   ├── Sidebar/             # 侧边栏
│   │   │   ├── DataTable/           # 数据表格
│   │   │   └── index.ts
│   │   ├── templates/               # 模板组件
│   │   │   ├── PageLayout/          # 页面布局
│   │   │   ├── DashboardLayout/     # 仪表板布局
│   │   │   └── index.ts
│   │   └── index.ts                 # 组件总导出
│   ├── pages/                       # 📄 页面组件
│   │   ├── Home/                    # 首页
│   │   │   ├── Home.tsx
│   │   │   ├── Home.module.css
│   │   │   └── index.ts
│   │   ├── Dashboard/               # 仪表板页面
│   │   ├── Profile/                 # 用户资料页面
│   │   ├── Login/                   # 登录页面
│   │   └── index.ts
│   ├── hooks/                       # 🪝 自定义React Hooks
│   │   ├── useAuth.ts               # 认证Hook
│   │   ├── useApi.ts                # API请求Hook
│   │   ├── useLocalStorage.ts       # 本地存储Hook
│   │   ├── useDebounce.ts           # 防抖Hook
│   │   ├── useTheme.ts              # 主题Hook
│   │   └── index.ts
│   ├── store/                       # 🏪 状态管理
│   │   ├── slices/                  # Redux Toolkit切片
│   │   │   ├── authSlice.ts         # 认证状态
│   │   │   ├── userSlice.ts         # 用户状态
│   │   │   └── appSlice.ts          # 应用状态
│   │   ├── zustand/                 # Zustand Store
│   │   │   ├── authStore.ts
│   │   │   └── userStore.ts
│   │   ├── store.ts                 # Store配置
│   │   └── index.ts
│   ├── services/                    # 🌐 API服务层
│   │   ├── api/                     # API配置
│   │   │   ├── client.ts            # Axios客户端
│   │   │   ├── endpoints.ts         # API端点
│   │   │   └── types.ts             # API类型
│   │   ├── auth.ts                  # 认证服务
│   │   ├── user.ts                  # 用户服务
│   │   ├── dashboard.ts             # 仪表板服务
│   │   └── index.ts
│   ├── utils/                       # 🛠️ 工具函数
│   │   ├── format.ts                # 格式化工具
│   │   ├── validation.ts            # 验证工具
│   │   ├── storage.ts               # 存储工具
│   │   ├── constants.ts             # 常量定义
│   │   ├── helpers.ts               # 辅助函数
│   │   └── index.ts
│   ├── types/                       # 📝 TypeScript类型定义
│   │   ├── api.ts                   # API相关类型
│   │   ├── auth.ts                  # 认证相关类型
│   │   ├── user.ts                  # 用户相关类型
│   │   ├── common.ts                # 通用类型
│   │   ├── components.ts            # 组件类型
│   │   └── global.d.ts              # 全局类型声明
│   ├── styles/                      # 🎨 样式文件
│   │   ├── globals.css              # 全局样式
│   │   ├── variables.css            # CSS变量
│   │   ├── components.css           # 组件样式
│   │   ├── utilities.css            # 工具样式
│   │   └── themes/                  # 主题样式
│   │       ├── light.css
│   │       └── dark.css
│   ├── assets/                      # 📦 静态资源
│   │   ├── images/                  # 图片资源
│   │   │   ├── logo.svg
│   │   │   ├── icons/
│   │   │   └── illustrations/
│   │   ├── fonts/                   # 字体文件
│   │   └── data/                    # 静态数据
│   │       └── mock.json
│   ├── context/                     # 🌐 React Context
│   │   ├── AuthContext.tsx          # 认证上下文
│   │   ├── ThemeContext.tsx         # 主题上下文
│   │   └── AppContext.tsx           # 应用上下文
│   ├── router/                      # 🚦 路由配置
│   │   ├── AppRouter.tsx            # 主路由
│   │   ├── PrivateRoute.tsx         # 私有路由
│   │   ├── PublicRoute.tsx          # 公共路由
│   │   └── routes.ts                # 路由常量
│   ├── App.tsx                      # 🚀 应用根组件
│   ├── main.tsx                     # 应用入口
│   └── vite-env.d.ts                # Vite类型声明
├── tests/                           # 🧪 测试文件
│   ├── __mocks__/                   # Mock文件
│   ├── setup.ts                     # 测试环境设置
│   ├── utils/                       # 测试工具
│   ├── components/                  # 组件测试
│   └── integration/                 # 集成测试
├── docs/                            # 📚 项目文档
│   ├── components.md                # 组件文档
│   ├── deployment.md                # 部署指南
│   └── styleguide.md                # 样式指南
├── .env.example                     # 环境变量示例
├── .env.local                       # 本地环境变量
├── .gitignore                       # Git忽略文件
├── .eslintrc.json                   # ESLint配置
├── prettier.config.js               # Prettier配置
├── tailwind.config.ts               # Tailwind CSS配置
├── tsconfig.json                    # TypeScript配置
├── vite.config.ts                   # Vite配置
├── package.json                     # 项目依赖和脚本
├── pnpm-lock.yaml                   # 包管理器锁定文件
├── vitest.config.ts                 # Vitest测试配置
├── Dockerfile                       # Docker容器配置
├── Makefile                         # 构建和开发工具
└── README.md                        # 项目文档
```

## 🔧 2025年技术栈标准

### **现代React核心特性**

**React 18 最新特性 (2025标准)**
- **React 18.0+** - 并发特性、自动批处理、Suspense改进
- **函数组件 + Hooks** - 100%函数式组件开发模式
- **并发渲染** - useTransition、useDeferredValue性能优化
- **Suspense改进** - 数据获取和代码分割优化
- **Strict Mode** - 开发时双重渲染检测

**现代化构建工具链 (2025标准)**
- **Vite 7.0+** - 超快的开发服务器和构建工具，完全替代CRA
- **TypeScript 5.0+** - 完整类型安全开发体验
- **Vitest** - 基于Vite的快速测试框架
- **ESLint 9+ Flat Config** - 现代化代码质量检查

### **前端依赖配置 (package.json)**
```json
{
  "name": "react-frontend-project",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "format": "prettier --write .",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "react": "^18.3.0",
    "react-dom": "^18.3.0",
    "react-router-dom": "^6.26.0",
    "@reduxjs/toolkit": "^2.3.0",
    "react-redux": "^9.1.0",
    "zustand": "^5.0.0",
    "axios": "^1.7.0",
    "react-query": "^3.39.0",
    "clsx": "^2.1.0",
    "class-variance-authority": "^0.7.0"
  },
  "devDependencies": {
    "@types/react": "^18.3.0",
    "@types/react-dom": "^18.3.0",
    "@vitejs/plugin-react": "^4.3.0",
    "vite": "^7.0.0",
    "typescript": "^5.6.0",
    "vitest": "^2.1.0",
    "@vitest/ui": "^2.1.0",
    "jsdom": "^25.0.0",
    "@testing-library/react": "^16.0.0",
    "@testing-library/jest-dom": "^6.5.0",
    "eslint": "^9.0.0",
    "@typescript-eslint/eslint-plugin": "^8.0.0",
    "prettier": "^3.3.0",
    "tailwindcss": "^3.4.0",
    "autoprefixer": "^10.4.0",
    "postcss": "^8.4.0"
  }
}
```

## 📜 2025年标准化 Makefile

```makefile
.PHONY: install dev build preview test lint format type-check clean help

# 项目配置
PROJECT_NAME = react-frontend-project
NODE_VERSION = 20
PORT = 5173

help:
	@echo "⚛️ React前端项目开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  install       - 安装项目依赖"
	@echo "  dev           - 启动Vite开发服务器"
	@echo "  preview       - 预览构建结果"
	@echo "  type-check    - TypeScript类型检查"
	@echo ""
	@echo "🏗️  构建测试:"
	@echo "  build         - 生产环境构建"
	@echo "  test          - 运行单元测试"
	@echo "  test:ui       - 运行测试UI界面"
	@echo "  lint          - 代码质量检查"
	@echo "  format        - 代码格式化"
	@echo ""
	@echo "🧹 维护:"
	@echo "  clean         - 清理构建文件"
	@echo "  health-check  - 项目健康检查"

install:
	@echo "📦 安装项目依赖..."
	npm install
	@echo "✅ 依赖安装完成!"

dev:
	@echo "⚛️ 启动Vite开发服务器..."
	npm run dev

build:
	@echo "🏗️ 生产环境构建..."
	npm run build
	@echo "✅ 构建完成!"

preview:
	@echo "👀 预览构建结果..."
	npm run preview

test:
	@echo "🧪 运行单元测试..."
	npm run test
	@echo "✅ 测试完成!"

test\\:ui:
	@echo "🎨 启动测试UI界面..."
	npm run test:ui

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

clean:
	@echo "🧹 清理构建文件..."
	rm -rf dist/
	rm -rf node_modules/.vite/
	rm -rf coverage/
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
```

## 📝 核心配置文件示例

### **Vite配置 (vite.config.ts)**
```typescript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@components': path.resolve(__dirname, './src/components'),
      '@pages': path.resolve(__dirname, './src/pages'),
      '@hooks': path.resolve(__dirname, './src/hooks'),
      '@utils': path.resolve(__dirname, './src/utils'),
      '@types': path.resolve(__dirname, './src/types'),
      '@assets': path.resolve(__dirname, './src/assets'),
    },
  },
  server: {
    port: 5173,
    open: true,
    cors: true,
  },
  build: {
    target: 'es2015',
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: false,
    minify: 'esbuild',
    chunkSizeWarningLimit: 1000,
    rollupOptions: {
      output: {
        chunkFileNames: 'js/[name]-[hash].js',
        entryFileNames: 'js/[name]-[hash].js',
        assetFileNames: '[ext]/[name]-[hash].[ext]',
      },
    },
  },
  define: {
    __APP_VERSION__: JSON.stringify(process.env.npm_package_version),
  },
})
```

### **现代化React组件示例 (原子设计模式)**
```tsx
// src/components/atoms/Button/Button.tsx
import React from 'react'
import { cva, type VariantProps } from 'class-variance-authority'
import { clsx } from 'clsx'

// 按钮变体配置
const buttonVariants = cva(
  'inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:opacity-50 disabled:pointer-events-none ring-offset-background',
  {
    variants: {
      variant: {
        default: 'bg-primary text-primary-foreground hover:bg-primary/90',
        destructive: 'bg-destructive text-destructive-foreground hover:bg-destructive/90',
        outline: 'border border-input hover:bg-accent hover:text-accent-foreground',
        secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
        ghost: 'hover:bg-accent hover:text-accent-foreground',
        link: 'underline-offset-4 hover:underline text-primary',
      },
      size: {
        default: 'h-10 py-2 px-4',
        sm: 'h-9 px-3 rounded-md',
        lg: 'h-11 px-8 rounded-md',
        icon: 'h-10 w-10',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
    },
  }
)

// 按钮属性接口
export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  loading?: boolean
  leftIcon?: React.ReactNode
  rightIcon?: React.ReactNode
}

// 按钮组件
export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, loading, leftIcon, rightIcon, children, disabled, ...props }, ref) => {
    return (
      <button
        className={clsx(buttonVariants({ variant, size, className }))}
        ref={ref}
        disabled={disabled || loading}
        {...props}
      >
        {loading && (
          <svg className="mr-2 h-4 w-4 animate-spin" viewBox="0 0 24 24">
            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
            <path
              className="opacity-75"
              fill="currentColor"
              d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
            />
          </svg>
        )}
        {leftIcon && <span className="mr-2">{leftIcon}</span>}
        {children}
        {rightIcon && <span className="ml-2">{rightIcon}</span>}
      </button>
    )
  }
)

Button.displayName = 'Button'
```

### **自定义Hook示例**
```typescript
// src/hooks/useApi.ts
import { useState, useEffect, useCallback } from 'react'
import { AxiosResponse, AxiosError } from 'axios'

interface UseApiOptions<T> {
  immediate?: boolean
  onSuccess?: (data: T) => void
  onError?: (error: AxiosError) => void
}

interface UseApiReturn<T> {
  data: T | null
  loading: boolean
  error: AxiosError | null
  execute: (...args: any[]) => Promise<T | undefined>
  reset: () => void
}

export function useApi<T>(
  apiFunction: (...args: any[]) => Promise<AxiosResponse<T>>,
  options: UseApiOptions<T> = {}
): UseApiReturn<T> {
  const { immediate = false, onSuccess, onError } = options

  const [data, setData] = useState<T | null>(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<AxiosError | null>(null)

  const execute = useCallback(
    async (...args: any[]) => {
      try {
        setLoading(true)
        setError(null)

        const response = await apiFunction(...args)
        const result = response.data

        setData(result)
        onSuccess?.(result)
        
        return result
      } catch (err) {
        const apiError = err as AxiosError
        setError(apiError)
        onError?.(apiError)
        throw apiError
      } finally {
        setLoading(false)
      }
    },
    [apiFunction, onSuccess, onError]
  )

  const reset = useCallback(() => {
    setData(null)
    setError(null)
    setLoading(false)
  }, [])

  useEffect(() => {
    if (immediate) {
      execute()
    }
  }, [immediate, execute])

  return { data, loading, error, execute, reset }
}
```

### **Zustand状态管理示例**
```typescript
// src/store/zustand/authStore.ts
import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import { authService } from '@/services/auth'

interface User {
  id: string
  name: string
  email: string
  role: string
}

interface AuthState {
  user: User | null
  token: string | null
  isAuthenticated: boolean
  loading: boolean
}

interface AuthActions {
  login: (email: string, password: string) => Promise<void>
  logout: () => void
  updateUser: (user: Partial<User>) => void
  setLoading: (loading: boolean) => void
}

export const useAuthStore = create<AuthState & AuthActions>()(
  persist(
    (set, get) => ({
      // 状态
      user: null,
      token: null,
      isAuthenticated: false,
      loading: false,

      // 操作
      login: async (email: string, password: string) => {
        try {
          set({ loading: true })
          
          const response = await authService.login({ email, password })
          const { user, token } = response.data

          set({
            user,
            token,
            isAuthenticated: true,
            loading: false,
          })
        } catch (error) {
          set({ loading: false })
          throw error
        }
      },

      logout: () => {
        set({
          user: null,
          token: null,
          isAuthenticated: false,
        })
      },

      updateUser: (userData: Partial<User>) => {
        const { user } = get()
        if (user) {
          set({
            user: { ...user, ...userData },
          })
        }
      },

      setLoading: (loading: boolean) => {
        set({ loading })
      },
    }),
    {
      name: 'auth-storage',
      partialize: (state) => ({
        user: state.user,
        token: state.token,
        isAuthenticated: state.isAuthenticated,
      }),
    }
  )
)
```

## 🧪 现代化测试策略

### **Vitest测试配置**
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
    css: true,
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
// tests/components/Button.test.tsx
import { render, screen, fireEvent } from '@testing-library/react'
import { describe, it, expect, vi } from 'vitest'
import { Button } from '@/components/atoms/Button'

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

  it('显示加载状态', () => {
    render(<Button loading>加载中</Button>)
    const button = screen.getByRole('button')
    expect(button).toBeDisabled()
    expect(screen.getByText('加载中')).toBeInTheDocument()
  })

  it('应用正确的变体样式', () => {
    render(<Button variant="destructive">删除</Button>)
    const button = screen.getByRole('button')
    expect(button).toHaveClass('bg-destructive')
  })
})
```

## 💾 现代前端架构模式

### TypeScript类型安全
- 完整的React组件类型定义
- API响应类型自动推断
- 状态管理类型安全
- 自定义Hook类型支持

### 原子设计模式
```
组件层级:
├── Atoms (原子)      - Button, Input, Label
├── Molecules (分子)  - SearchBox, FormField
├── Organisms (有机体) - Header, DataTable
├── Templates (模板)  - PageLayout
└── Pages (页面)     - HomePage, Dashboard
```

### 智能化开发工具
- **Vite**: 超快的开发服务器和HMR
- **React DevTools**: 浏览器调试扩展
- **TypeScript**: 静态类型检查和智能提示
- **ESLint + Prettier**: 自动化代码质量保证

## 🚀 现代化开发流程

### **项目初始化**

```bash
# 1. 使用Vite创建React项目 (2025推荐)
npm create vite@latest my-react-project -- --template react-ts

# 2. 进入项目目录
cd my-react-project

# 3. 安装依赖
make install

# 4. 启动开发服务器
make dev
```

### **日常开发工作流**

```bash
# 🔧 开发环境管理
make dev           # 启动Vite开发服务器 (http://localhost:5173)
make type-check    # TypeScript类型检查
make lint          # ESLint代码检查
make format        # Prettier代码格式化

# 🧪 测试和质量检查
make test          # 运行Vitest单元测试
make test:ui       # Vitest UI测试界面
make health-check  # 完整项目健康检查

# 📦 构建和部署
make build         # 生产环境构建
make preview       # 预览构建结果
make clean         # 清理构建文件

# 📊 性能分析
make upgrade-deps  # 升级依赖包
```

### **性能优化**

- **代码分割**: React.lazy动态导入和路由级分割
- **Tree Shaking**: Vite自动去除未使用代码
- **缓存策略**: 长期缓存和版本控制
- **资源优化**: 图片压缩、字体优化、CDN加速

### **现代化部署**

- **静态部署**: Vercel、Netlify、GitHub Pages
- **CDN加速**: 全球内容分发网络
- **Docker容器化**: 标准化部署环境
- **CI/CD集成**: 自动化构建和部署流程

## 📚 2025年React参考资源

### **官方文档**

- [React 18官方文档](https://react.dev/) - 最权威的React学习资源
- [Vite官方文档](https://vitejs.dev/) - 现代前端构建工具
- [React Router官方文档](https://reactrouter.com/) - React路由库
- [Redux Toolkit官方文档](https://redux-toolkit.js.org/) - 现代Redux状态管理

### **最佳实践指南**

- React 18 Hooks和函数组件最佳实践
- TypeScript在React项目中的完整集成方案
- 现代化前端工具链(Vite+Vitest+ESLint)最佳配置
- 95%React前端项目需求覆盖的通用架构模式

---

**✨ 这个模板基于React 18和2025年前端最佳实践，为React前端项目提供完整的现代化开发解决方案。**