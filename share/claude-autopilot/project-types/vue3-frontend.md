# Vue3前端项目规范

## 📋 项目特征

- **适用场景**: 纯前端SPA、管理后台、移动端H5、PWA应用、企业级前端项目
- **技术栈**: Vue 3.5 + Vite 7.0 + TypeScript + Pinia + Vue Router + Vitest
- **开发模式**: Composition API + `<script setup>` + 组合式函数最佳实践
- **部署方式**: 🚀 静态部署 + CDN加速 + Docker容器化部署支持
- **特点**: 现代化前端架构、TypeScript类型安全、95%前端项目覆盖

## 🏗️ 通用标准项目结构（适用于所有Vue3前端项目）

```
vue3-frontend项目/
├── public/
│   ├── index.html               # HTML入口模板
│   ├── favicon.ico             # 网站图标
│   └── manifest.json           # PWA配置文件
├── src/
│   ├── components/             # 🎨 通用组件 (Atomic Design架构)
│   │   ├── base/               # 基础原子组件
│   │   │   ├── BaseButton.vue   # 按钮组件
│   │   │   ├── BaseInput.vue    # 输入框组件
│   │   │   ├── BaseModal.vue    # 模态框组件
│   │   │   └── BaseLoading.vue  # 加载组件
│   │   ├── layout/             # 布局组件
│   │   │   ├── AppHeader.vue    # 应用头部
│   │   │   ├── AppSidebar.vue   # 侧边栏
│   │   │   ├── AppFooter.vue    # 页脚
│   │   │   └── AppLayout.vue    # 主布局
│   │   └── business/           # 业务组件
│   │       ├── UserCard.vue     # 用户卡片
│   │       ├── DataTable.vue    # 数据表格
│   │       └── ChartWidget.vue  # 图表组件
│   ├── views/                  # 📄 页面级组件
│   │   ├── HomeView.vue         # 首页
│   │   ├── AboutView.vue        # 关于页面
│   │   ├── auth/               # 认证相关页面
│   │   │   ├── LoginView.vue    # 登录页面
│   │   │   └── RegisterView.vue # 注册页面
│   │   └── admin/              # 管理后台页面
│   │       ├── DashboardView.vue
│   │       └── UsersView.vue
│   ├── router/                 # 🚦 Vue Router 4路由配置
│   │   ├── index.ts            # 路由主配置
│   │   ├── guards.ts           # 路由守卫
│   │   └── modules/            # 模块化路由
│   │       ├── auth.ts         # 认证路由
│   │       └── admin.ts        # 管理路由
│   ├── stores/                 # 🍍 Pinia状态管理
│   │   ├── index.ts            # Store入口
│   │   ├── modules/            # 模块化Store
│   │   │   ├── auth.ts         # 认证状态
│   │   │   ├── user.ts         # 用户状态
│   │   │   └── app.ts          # 应用全局状态
│   │   └── types.ts            # Store类型定义
│   ├── composables/            # 🔧 组合式函数 (Vue3核心特性)
│   │   ├── useApi.ts           # API请求composable
│   │   ├── useAuth.ts          # 认证逻辑composable
│   │   ├── useLocalStorage.ts  # 本地存储composable
│   │   ├── useTheme.ts         # 主题切换composable
│   │   ├── usePermission.ts    # 权限管理composable
│   │   └── useUtils.ts         # 通用工具composable
│   ├── api/                    # 🌐 API接口层
│   │   ├── index.ts            # Axios配置和拦截器
│   │   ├── types/              # API类型定义
│   │   │   ├── auth.ts         # 认证API类型
│   │   │   ├── user.ts         # 用户API类型
│   │   │   └── common.ts       # 通用API类型
│   │   └── modules/            # 按业务模块分类
│   │       ├── auth.ts         # 认证接口
│   │       ├── user.ts         # 用户接口
│   │       └── upload.ts       # 文件上传接口
│   ├── assets/                 # 📦 静态资源
│   │   ├── styles/             # 全局样式
│   │   │   ├── main.scss       # 主样式文件
│   │   │   ├── variables.scss  # 样式变量
│   │   │   ├── mixins.scss     # 样式混入
│   │   │   └── components.scss # 组件样式
│   │   ├── images/             # 图片资源
│   │   │   ├── logo.svg        # Logo
│   │   │   └── icons/          # 图标文件
│   │   └── fonts/              # 字体文件
│   ├── utils/                  # 🛠️ 工具函数
│   │   ├── index.ts            # 工具函数入口
│   │   ├── request.ts          # 请求工具
│   │   ├── storage.ts          # 存储工具
│   │   ├── format.ts           # 格式化工具
│   │   ├── validate.ts         # 验证工具
│   │   └── auth.ts             # 认证工具
│   ├── types/                  # 📝 TypeScript类型定义
│   │   ├── index.ts            # 类型入口
│   │   ├── api.ts              # API相关类型
│   │   ├── auth.ts             # 认证相关类型
│   │   ├── user.ts             # 用户相关类型
│   │   └── global.d.ts         # 全局类型声明
│   ├── constants/              # 📋 常量定义
│   │   ├── index.ts            # 常量入口
│   │   ├── api.ts              # API常量
│   │   ├── routes.ts           # 路由常量
│   │   └── app.ts              # 应用常量
│   ├── plugins/                # 🔌 插件配置
│   │   ├── index.ts            # 插件入口
│   │   ├── element-plus.ts     # Element Plus配置
│   │   └── directives.ts       # 自定义指令
│   ├── directives/             # 📐 自定义指令
│   │   ├── index.ts            # 指令入口
│   │   ├── permission.ts       # 权限指令
│   │   └── loading.ts          # 加载指令
│   └── main.ts                 # 🚀 应用入口文件
├── tests/                      # 🧪 测试文件
│   ├── unit/                   # 单元测试
│   │   ├── components/         # 组件测试
│   │   ├── utils/              # 工具函数测试
│   │   └── stores/             # Store测试
│   ├── e2e/                    # 端到端测试
│   │   ├── auth.spec.ts        # 认证流程测试
│   │   └── user.spec.ts        # 用户功能测试
│   └── setup.ts                # 测试环境设置
├── dist/                       # 🏗️ 构建输出目录
├── node_modules/               # 📦 依赖包
├── .env.example                # 环境变量示例
├── .env.development            # 开发环境变量
├── .env.production             # 生产环境变量
├── .gitignore                  # Git忽略文件
├── .editorconfig               # 编辑器配置
├── vite.config.ts              # Vite配置
├── vitest.config.ts            # Vitest测试配置
├── tsconfig.json               # TypeScript配置
├── tsconfig.app.json           # 应用TypeScript配置
├── tsconfig.vitest.json        # 测试TypeScript配置
├── eslint.config.mjs           # ESLint Flat Config (ESLint 9+)
├── prettier.config.js          # Prettier配置
├── package.json                # 项目配置
├── pnpm-lock.yaml              # 包管理器锁定文件
├── Makefile                    # 构建和开发工具
└── README.md                   # 项目文档
```

## 🔧 2025年技术栈标准

### **现代Vue3核心特性**

**Vue 3.5+ 最新特性 (基于官方文档)**
- **Vue 3.5.0** - 最新稳定版本，性能大幅提升
- **Composition API** - 100% `<script setup>` 语法
- **Reactive Props Destructure** - Vue 3.5新特性，解构props保持响应性
- **defineSlots()** - TypeScript槽类型推断 (推荐替代useSlots)
- **Suspense** - 异步组件加载支持

**现代化构建工具链 (基于Vite官方文档)**
- **Vite 7.0+** - 超快的开发服务器和构建工具
- **TypeScript 5.0+** - 完整类型安全开发体验
- **Vitest** - 基于Vite的快速单元测试框架
- **ESLint 9+ Flat Config** - 现代化代码质量检查

### **前端依赖配置 (package.json)**
```json
{
  "name": "vue3-frontend-project",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview",
    "test:unit": "vitest",
    "test:e2e": "cypress run",
    "lint": "eslint . --fix",
    "format": "prettier --write .",
    "type-check": "vue-tsc --noEmit"
  },
  "dependencies": {
    "vue": "^3.5.0",
    "vue-router": "^4.4.0",
    "pinia": "^2.2.0",
    "axios": "^1.7.0",
    "element-plus": "^2.8.0",
    "@element-plus/icons-vue": "^2.3.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^5.1.0",
    "@vue/tsconfig": "^0.5.0",
    "vite": "^7.0.0",
    "vitest": "^2.1.0",
    "vue-tsc": "^2.1.0",
    "typescript": "^5.6.0",
    "@types/node": "^22.0.0",
    "eslint": "^9.0.0",
    "@vue/eslint-config-typescript": "^14.0.0",
    "@vue/eslint-config-prettier": "^10.0.0",
    "prettier": "^3.3.0",
    "sass": "^1.80.0",
    "unplugin-auto-import": "^0.18.0",
    "unplugin-vue-components": "^0.27.0"
  }
}
```

### **开发依赖 (devDependencies)**
```json
{
  "devDependencies": {
    "@vue/test-utils": "^2.4.0",
    "@vitest/ui": "^2.1.0",
    "jsdom": "^25.0.0",
    "cypress": "^13.15.0",
    "husky": "^9.1.0",
    "lint-staged": "^15.2.0",
    "@commitlint/cli": "^19.0.0",
    "@commitlint/config-conventional": "^19.0.0"
  }
}
```

## 🚀 标准化开发流程

### ⭐ 基于Vue3官方最佳实践的开发流程

遵循Vue 3官方文档推荐的开发模式和项目结构：

#### 项目初始化命令

```bash
# 1. 使用官方脚手架创建项目
npm create vue@latest my-vue3-project

# 2. 选择配置选项
✔ Add TypeScript? … Yes
✔ Add Pinia for state management? … Yes  
✔ Add Vue Router for Single Page Application development? … Yes
✔ Add Vitest for Unit Testing? … Yes
✔ Add an End-to-End Testing Solution? › Cypress
✔ Add ESLint for code quality? … Yes
✔ Add Prettier for code formatting? … Yes

# 3. 安装依赖
cd my-vue3-project
npm install
```

## 📜 2025年标准化 Makefile

```makefile
.PHONY: install dev build test lint format type-check preview clean help

# 项目配置
PROJECT_NAME = vue3-frontend-project
NODE_VERSION = 18

help:
	@echo "🚀 Vue3前端项目开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  install       - 安装项目依赖"
	@echo "  dev           - 启动开发服务器"
	@echo "  preview       - 预览构建结果"
	@echo "  type-check    - TypeScript类型检查"
	@echo ""
	@echo "🏗️  构建测试:"
	@echo "  build         - 生产环境构建"
	@echo "  test          - 运行单元测试"
	@echo "  test:e2e      - 运行端到端测试"
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
	@echo "🚀 启动开发服务器..."
	npm run dev

build:
	@echo "🏗️ 生产环境构建..."
	npm run build
	@echo "✅ 构建完成!"

test:
	@echo "🧪 运行单元测试..."
	npm run test:unit
	@echo "✅ 测试完成!"

test\:e2e:
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

preview:
	@echo "👀 预览构建结果..."
	npm run preview

clean:
	@echo "🧹 清理构建文件..."
	rm -rf dist/
	rm -rf node_modules/.cache/
	rm -rf coverage/
	@echo "✅ 清理完成!"

health-check:
	@echo "🏥 项目健康检查..."
	npm run type-check
	npm run lint
	npm run test:unit
	@echo "✅ 健康检查完成!"

# 依赖管理
upgrade-deps:
	@echo "⬆️ 升级依赖包..."
	npm update
	@echo "✅ 依赖升级完成!"

# 开发辅助
analyze:
	@echo "📊 分析构建产物..."
	npm run build -- --report
	@echo "✅ 分析完成!"
```

## 📝 核心配置文件示例

### **Vite配置 (vite.config.ts)**
```typescript
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import { ElementPlusResolver } from 'unplugin-vue-components/resolvers'

export default defineConfig({
  plugins: [
    vue(),
    AutoImport({
      resolvers: [ElementPlusResolver()],
      imports: ['vue', 'vue-router', 'pinia'],
      dts: true
    }),
    Components({
      resolvers: [ElementPlusResolver()],
      dts: true
    })
  ],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  },
  server: {
    port: 3000,
    open: true,
    cors: true
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
        assetFileNames: '[ext]/[name]-[hash].[ext]'
      }
    }
  }
})
```

### **现代化Vue3组件示例 (基于官方最佳实践)**
```vue
<!-- src/components/UserProfile.vue -->
<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import type { User } from '@/types/user'

// 响应式Props Destructure (Vue 3.5新特性)
interface Props {
  userId: string
  showAvatar?: boolean
}

const { userId, showAvatar = true } = defineProps<Props>()

// 组合式函数
const authStore = useAuthStore()

// 响应式状态
const user = ref<User | null>(null)
const loading = ref(false)

// 计算属性
const displayName = computed(() => 
  user.value ? `${user.value.firstName} ${user.value.lastName}` : '未知用户'
)

// 事件定义 (Vue 3.3+ 语法)
const emit = defineEmits<{
  userLoaded: [user: User]
  error: [message: string]
}>()

// 生命周期
onMounted(async () => {
  await fetchUser()
})

// 方法
const fetchUser = async () => {
  try {
    loading.value = true
    const userData = await authStore.fetchUser(userId)
    user.value = userData
    emit('userLoaded', userData)
  } catch (error) {
    emit('error', '获取用户信息失败')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="user-profile">
    <div v-if="loading" class="loading">
      加载中...
    </div>
    <div v-else-if="user" class="user-info">
      <img 
        v-if="showAvatar" 
        :src="user.avatar" 
        :alt="displayName"
        class="avatar"
      >
      <h3>{{ displayName }}</h3>
      <p>{{ user.email }}</p>
    </div>
    <div v-else class="error">
      用户信息加载失败
    </div>
  </div>
</template>

<style scoped lang="scss">
.user-profile {
  padding: 1rem;
  border-radius: 8px;
  background: var(--bg-color);
  
  .avatar {
    width: 64px;
    height: 64px;
    border-radius: 50%;
    object-fit: cover;
  }
  
  .loading {
    text-align: center;
    color: var(--text-secondary);
  }
}
</style>
```

### **Pinia Store示例 (基于官方最佳实践)**
```typescript
// src/stores/auth.ts
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import type { User, LoginForm } from '@/types/auth'
import { authApi } from '@/api/modules/auth'
import { useLocalStorage } from '@/composables/useLocalStorage'

export const useAuthStore = defineStore('auth', () => {
  // 状态
  const user = ref<User | null>(null)
  const token = useLocalStorage('auth-token', '')
  const loading = ref(false)

  // 计算属性
  const isAuthenticated = computed(() => !!token.value && !!user.value)
  const userName = computed(() => user.value?.name || '游客')

  // 方法
  const login = async (loginForm: LoginForm) => {
    try {
      loading.value = true
      const response = await authApi.login(loginForm)
      
      token.value = response.token
      user.value = response.user
      
      return { success: true }
    } catch (error) {
      return { 
        success: false, 
        message: error instanceof Error ? error.message : '登录失败' 
      }
    } finally {
      loading.value = false
    }
  }

  const logout = async () => {
    try {
      await authApi.logout()
    } finally {
      token.value = ''
      user.value = null
    }
  }

  const fetchUser = async (userId: string) => {
    const response = await authApi.getUser(userId)
    return response.data
  }

  return {
    // 状态
    user: readonly(user),
    token: readonly(token),
    loading: readonly(loading),
    
    // 计算属性
    isAuthenticated,
    userName,
    
    // 方法
    login,
    logout,
    fetchUser
  }
})
```

### **组合式函数示例 (Composables最佳实践)**
```typescript
// src/composables/useApi.ts
import { ref, type Ref } from 'vue'
import type { ApiResponse } from '@/types/api'

interface UseApiOptions {
  immediate?: boolean
  onError?: (error: Error) => void
  onSuccess?: (data: any) => void
}

export function useApi<T>(
  apiFunction: (...args: any[]) => Promise<ApiResponse<T>>,
  options: UseApiOptions = {}
) {
  const { immediate = false, onError, onSuccess } = options
  
  const data: Ref<T | null> = ref(null)
  const loading = ref(false)
  const error = ref<Error | null>(null)

  const execute = async (...args: any[]) => {
    try {
      loading.value = true
      error.value = null
      
      const response = await apiFunction(...args)
      data.value = response.data
      
      onSuccess?.(response.data)
      return response.data
    } catch (err) {
      const apiError = err instanceof Error ? err : new Error('API请求失败')
      error.value = apiError
      onError?.(apiError)
      throw apiError
    } finally {
      loading.value = false
    }
  }

  if (immediate) {
    execute()
  }

  return {
    data: readonly(data),
    loading: readonly(loading),
    error: readonly(error),
    execute
  }
}
```

## 🧪 现代化测试策略

### **Vitest单元测试配置**
```typescript
// vitest.config.ts
import { defineConfig } from 'vitest/config'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./tests/setup.ts']
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  }
})
```

### **组件测试示例**
```typescript
// tests/unit/components/UserProfile.spec.ts
import { describe, it, expect, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import { createPinia, setActivePinia } from 'pinia'
import UserProfile from '@/components/UserProfile.vue'

describe('UserProfile.vue', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
  })

  it('显示用户信息', async () => {
    const wrapper = mount(UserProfile, {
      props: {
        userId: '123',
        showAvatar: true
      }
    })

    expect(wrapper.find('.user-profile').exists()).toBe(true)
  })

  it('处理加载状态', async () => {
    const wrapper = mount(UserProfile, {
      props: { userId: '123' }
    })

    expect(wrapper.find('.loading').exists()).toBe(true)
  })
})
```

## 💾 现代前端架构模式

### TypeScript类型安全
- 完整的类型定义体系
- API响应类型自动推断
- 组件Props严格类型检查
- Pinia Store类型安全

### 组合式函数模式
```typescript
// 可复用的业务逻辑
export function usePermission() {
  const hasPermission = (permission: string) => {
    // 权限检查逻辑
  }
  
  return { hasPermission }
}

// 在组件中使用
const { hasPermission } = usePermission()
```

### 智能化开发工具
- **Vite**: 超快的开发服务器和构建工具
- **Vue DevTools**: 浏览器调试扩展
- **TypeScript**: 静态类型检查和智能提示
- **ESLint + Prettier**: 自动化代码质量保证

## 🚀 现代化开发流程

### **项目初始化**

```bash
# 1. 使用Vue官方脚手架
npm create vue@latest my-vue3-project

# 2. 进入项目目录
cd my-vue3-project

# 3. 安装依赖
make install

# 4. 启动开发服务器
make dev
```

### **日常开发工作流**

```bash
# 🔧 开发环境管理
make dev           # 启动开发服务器 (http://localhost:3000)
make type-check    # TypeScript类型检查
make lint          # ESLint代码检查
make format        # Prettier代码格式化

# 🧪 测试和质量检查
make test          # 运行Vitest单元测试
make test:e2e      # 运行Cypress端到端测试
make health-check  # 完整项目健康检查

# 📦 构建和部署
make build         # 生产环境构建
make preview       # 预览构建结果
make clean         # 清理构建文件

# 📊 项目分析
make analyze       # 构建产物分析
make upgrade-deps  # 升级依赖包
```

### **性能优化**

- **代码分割**: 路由级别的懒加载和动态导入
- **Tree Shaking**: Vite自动去除未使用代码
- **缓存策略**: 长期缓存和版本控制
- **资源优化**: 图片压缩、字体优化、CDN加速

### **现代化部署**

- **静态部署**: Netlify、Vercel、GitHub Pages
- **CDN加速**: 全球内容分发网络
- **Docker容器化**: 标准化部署环境
- **CI/CD集成**: 自动化构建和部署流程

## 📚 2025年Vue3参考资源

### **官方文档**

- [Vue 3官方文档](https://vuejs.org/) - 最权威的Vue3学习资源
- [Vite官方文档](https://vitejs.dev/) - 现代前端构建工具
- [Pinia官方文档](https://pinia.vuejs.org/) - Vue官方状态管理库
- [Vue Router 4文档](https://router.vuejs.org/) - Vue官方路由库

### **最佳实践指南**

- Vue 3 Composition API官方风格指南和最佳实践
- TypeScript在Vue3项目中的完整集成方案
- 现代化前端工具链(Vite+Vitest+ESLint)最佳配置
- 95%Vue3前端项目需求覆盖的通用架构模式

---

**✨ 这个模板基于Vue 3.5官方文档和2025年前端最佳实践，为Vue3前端项目提供完整的现代化开发解决方案。**