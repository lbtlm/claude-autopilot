# FastAPI + Vue3 项目规范

## 📋 项目特征

- **适用场景**: 前后端分离的Web应用，API服务，数据分析平台，企业级应用
- **后端技术栈**: FastAPI 0.115.0 + SQLAlchemy 2.0 + PostgreSQL + Redis + Alembic
- **前端技术栈**: Vue 3.5 + TypeScript 5.0 + Element Plus 2.8 + Vite 5.0 + Pinia
- **部署方式**: 🚀 Docker标准化部署 + 多架构支持 + 智能Redis检测
- **特点**: 官方标准结构、异步高性能、自动API文档、类型安全、95%项目覆盖

## 🏗️ 通用标准项目结构（适用于所有FastAPI+Vue3项目）

```
fastapi-vue3-project/
├── backend/                          # 🐍 FastAPI后端 (官方标准结构)
│   ├── app/                          # 主应用包 (FastAPI官方推荐)
│   │   ├── __init__.py
│   │   ├── main.py                   # FastAPI应用入口
│   │   ├── core/                     # 核心配置 (官方结构)
│   │   │   ├── config.py             # 应用配置
│   │   │   ├── security.py           # 安全配置
│   │   │   └── database.py           # 数据库配置
│   │   ├── api/                      # API路由 (官方结构)
│   │   │   ├── __init__.py
│   │   │   ├── deps.py               # 依赖注入
│   │   │   └── v1/                   # API版本控制
│   │   │       ├── __init__.py
│   │   │       ├── auth.py           # 认证路由
│   │   │       └── users.py          # 用户路由
│   │   ├── models/                   # 数据模型 (SQLAlchemy)
│   │   │   ├── __init__.py
│   │   │   └── user.py
│   │   ├── schemas/                  # Pydantic模型
│   │   │   ├── __init__.py
│   │   │   └── user.py
│   │   ├── services/                 # 业务逻辑层
│   │   │   ├── __init__.py
│   │   │   └── user.py
│   │   └── utils/                    # 工具函数
│   │       ├── __init__.py
│   │       └── helpers.py
│   ├── tests/                        # 后端测试
│   ├── alembic/                      # 数据库迁移
│   ├── requirements.txt              # 生产依赖
│   ├── requirements-dev.txt          # 开发依赖
│   ├── .env.example                  # 环境变量示例
│   └── Dockerfile                    # 后端容器构建
├── frontend/                         # 🎨 Vue3前端 (官方create-vue结构)
│   ├── src/
│   │   ├── api/                      # API调用封装
│   │   │   ├── index.ts              # API客户端配置
│   │   │   └── users.ts              # 用户API
│   │   ├── components/               # 可复用组件
│   │   │   ├── common/               # 通用组件
│   │   │   └── user/                 # 用户相关组件
│   │   ├── views/                    # 页面组件 (Vue Router标准)
│   │   │   ├── HomeView.vue
│   │   │   └── UserView.vue
│   │   ├── stores/                   # Pinia状态管理 (Vue3官方推荐)
│   │   │   ├── index.ts
│   │   │   └── user.ts
│   │   ├── router/                   # Vue Router配置
│   │   │   └── index.ts
│   │   ├── types/                    # TypeScript类型定义
│   │   │   └── user.ts
│   │   ├── utils/                    # 工具函数
│   │   │   └── helpers.ts
│   │   ├── assets/                   # 静态资源
│   │   ├── App.vue                   # 根组件
│   │   └── main.ts                   # 应用入口
│   ├── public/
│   │   └── index.html
│   ├── package.json                  # NPM配置
│   ├── vite.config.ts                # Vite构建配置
│   ├── tsconfig.json                 # TypeScript配置
│   ├── .env.example                  # 环境变量示例
│   └── Dockerfile                    # 前端容器构建
├── deployments/                      # 🚀 部署配置 (保持现有标准)
│   ├── docker-compose.yml            # 开发环境编排
│   ├── docker-compose.prod.yml       # 生产环境编排
│   └── production-safe-deploy.sh     # 生产安全部署脚本
├── scripts/                          # 📜 构建脚本 (保持现有标准)
│   └── multi-arch-build.sh           # 多架构构建脚本
├── .gitignore                        # Git忽略文件
├── .editorconfig                     # 编辑器配置
├── Makefile                          # 构建和开发工具
└── README.md                         # 项目文档
```

## 🔧 2025年技术栈标准

### **现代技术栈特性**

**后端技术栈 (基于官方文档和最佳实践)**
- **FastAPI 0.115.0** - 最新稳定版本，支持标准依赖组
- **Python 3.11+** - 现代Python版本特性
- **SQLAlchemy 2.0+** - 最新ORM版本，全异步支持
- **Alembic 1.13+** - 数据库迁移工具
- **Pydantic v2** - 数据验证和序列化，性能大幅提升

**前端技术栈 (基于Vue3生态和2025年标准)**
- **Vue 3.5+** - 最新稳定版本，完整的Composition API
- **TypeScript 5.0+** - 类型安全开发体验
- **Vite 5.0+** - 现代构建工具，极速热更新
- **Vue Router 4.4+** - 官方路由器最新版本
- **Pinia 2.2+** - 官方状态管理库 (替代Vuex)
- **Element Plus 2.8+** - Vue3 UI组件库

### **后端依赖配置 (requirements.txt)**
```txt
# FastAPI 核心
fastapi[standard]==0.115.0

# 数据库
sqlalchemy>=2.0.0
alembic>=1.13.0
psycopg2-binary>=2.9.0

# 认证和安全
python-jose[cryptography]>=3.3.0
passlib[bcrypt]>=1.7.4
python-multipart>=0.0.6

# 其他
redis>=5.0.0
```

### **前端依赖配置 (package.json)**
```json
{
  "name": "fastapi-vue3-frontend",
  "version": "1.0.0",
  "type": "module",
  "dependencies": {
    "vue": "^3.5.0",
    "vue-router": "^4.4.0",
    "pinia": "^2.2.0",
    "element-plus": "^2.8.0",
    "@element-plus/icons-vue": "^2.3.0",
    "axios": "^1.7.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^5.0.0",
    "typescript": "^5.0.0",
    "vite": "^5.0.0",
    "vue-tsc": "^2.0.0",
    "@types/node": "^22.0.0",
    "eslint": "^9.0.0",
    "prettier": "^3.3.0"
  }
}
```

## 🚀 标准化Docker部署流程（强制规范）

### ⭐ 基于Gateway项目验证的部署标准

采用与Gin+Vue3项目相同的标准化部署流程，确保一致的部署体验：

#### 部署命令标准

```bash
# 1. 本地多架构构建
./scripts/multi-arch-build.sh

# 2. 开发环境智能部署
./deployments/smart-redis-deploy.sh

# 3. 生产环境安全部署
./deployments/production-safe-deploy.sh
```

#### 关键特性

- **数据保护**: 绝不删除现有数据卷
- **智能检测**: Redis连接优先级（远程>本地>Docker>内置）
- **健康检查**: 自动验证API /health 端点
- **多架构**: 同时支持ARM64和AMD64
- **安全部署**: 生产环境数据保护机制

## 📜 2025年标准化 Makefile

```makefile
.PHONY: init dev test lint build deploy-dev deploy-prod clean help

# 项目配置
PROJECT_NAME = fastapi-vue3-project
DOCKER_USER = your-dockerhub-username
IMAGE_NAME = $(DOCKER_USER)/$(PROJECT_NAME)

help:
	@echo "🚀 FastAPI 0.115 + Vue 3.5 项目开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  init          - 初始化开发环境"
	@echo "  dev           - 启动开发环境"
	@echo "  test          - 运行所有测试"
	@echo "  lint          - 代码质量检查"
	@echo ""
	@echo "🏗️  构建部署:"
	@echo "  build         - 构建项目"
	@echo "  deploy-dev    - 开发环境部署"
	@echo "  deploy-prod   - 生产安全部署 ⭐"
	@echo ""
	@echo "🧹 维护:"
	@echo "  clean         - 清理临时文件"
	@echo "  health-check  - 项目健康检查"

init:
	@echo "🔧 初始化开发环境..."
	cd backend && pip install -r requirements-dev.txt
	cd frontend && npm install
	@echo "✅ 环境初始化完成!"

dev:
	@echo "🚀 启动开发环境..."
	docker compose up -d --build

test:
	@echo "🧪 运行所有测试..."
	cd backend && pytest tests/ -v --cov=app
	cd frontend && npm run test

lint:
	@echo "🔍 代码质量检查..."
	cd backend && ruff check app/ tests/
	cd backend && mypy app/
	cd frontend && npm run lint
	cd frontend && npm run type-check

build:
	@echo "📦 构建项目..."
	cd frontend && npm run build
	docker build -t $(IMAGE_NAME):latest .

deploy-dev:
	@echo "🚀 开发环境部署..."
	docker compose -f deployments/docker-compose.yml up -d

deploy-prod:
	@echo "🔒 生产安全部署..."
	./deployments/production-safe-deploy.sh

clean:
	@echo "🧹 清理临时文件..."
	docker compose down -v
	cd backend && rm -rf __pycache__/ .pytest_cache/ .coverage
	cd frontend && rm -rf node_modules/ dist/

health-check:
	@echo "🏥 项目健康检查..."
	cd backend && python -m pip check
	cd backend && pytest --cov=app tests/
	cd frontend && npm run lint && npm run type-check
	@echo "✅ 健康检查完成!"

# 数据库操作
migrate:
	@echo "📊 运行数据库迁移..."
	cd backend && alembic upgrade head

makemigrations:
	@echo "📝 生成数据库迁移文件..."
	cd backend && alembic revision --autogenerate -m "$(message)"
```

## 🔒 安全规范

### 后端安全
- ✅ 使用 JWT 进行身份认证
- ✅ 密码使用 bcrypt 加密存储
- ✅ API 限流和防止暴力破解
- ✅ 输入验证和 SQL 注入防护
- ✅ CORS 正确配置
- ✅ HTTPS 强制使用

### 前端安全
- ✅ XSS 防护 (Vue3 默认提供)
- ✅ CSRF 防护
- ✅ 敏感信息不存储在 localStorage
- ✅ API 请求添加认证头
- ✅ 路由守卫和权限验证

## 📝 核心配置文件示例

### **FastAPI 主应用配置 (main.py)**
```python
# backend/app/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.api.v1.auth import router as auth_router
from app.api.v1.users import router as users_router

app = FastAPI(
    title=settings.PROJECT_NAME,
    version="1.0.0",
    openapi_url=f"{settings.API_V1_STR}/openapi.json"
)

# CORS 配置
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.BACKEND_CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# API 路由
app.include_router(auth_router, prefix=f"{settings.API_V1_STR}/auth", tags=["auth"])
app.include_router(users_router, prefix=f"{settings.API_V1_STR}/users", tags=["users"])

@app.get("/health")
async def health_check():
    return {"status": "healthy"}
```

### **SQLAlchemy 2.0 数据模型**
```python
# backend/app/models/user.py
from sqlalchemy import String, Boolean, DateTime
from sqlalchemy.orm import Mapped, mapped_column
from app.core.database import Base
from datetime import datetime

class User(Base):
    __tablename__ = "users"
    
    id: Mapped[int] = mapped_column(primary_key=True, index=True)
    email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
    hashed_password: Mapped[str] = mapped_column(String(255))
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=datetime.utcnow)
```

### **现代 API 路由设计**
```python
# backend/app/api/v1/users.py
from fastapi import APIRouter, Depends, HTTPException
from app.schemas.user import UserCreate, UserResponse
from app.services.user import UserService
from app.api.deps import get_current_user

router = APIRouter()

@router.post("/", response_model=UserResponse)
async def create_user(
    user_in: UserCreate,
    user_service: UserService = Depends()
) -> UserResponse:
    return await user_service.create_user(user_in)

@router.get("/me", response_model=UserResponse)
async def read_users_me(
    current_user: User = Depends(get_current_user)
) -> UserResponse:
    return current_user
```

### **Vue 3.5 Vite 配置**
```typescript
// frontend/vite.config.ts
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
    }),
    Components({
      resolvers: [ElementPlusResolver()],
    }),
  ],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  },
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8000',
        changeOrigin: true
      }
    }
  }
})
```

### **Vue 3.5 组合式 API 示例**
```vue
<!-- frontend/src/views/UserView.vue -->
<template>
  <div class="user-view">
    <el-card>
      <template #header>
        <h2>用户管理</h2>
      </template>
      
      <el-table :data="users" v-loading="loading">
        <el-table-column prop="email" label="邮箱" />
        <el-table-column prop="created_at" label="创建时间" />
        <el-table-column label="操作">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="editUser(row)">
              编辑
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useUserStore } from '@/stores/user'
import type { User } from '@/types/user'

const userStore = useUserStore()
const users = ref<User[]>([])
const loading = ref(false)

const fetchUsers = async () => {
  loading.value = true
  try {
    users.value = await userStore.fetchUsers()
  } finally {
    loading.value = false
  }
}

const editUser = (user: User) => {
  // 编辑用户逻辑
}

onMounted(fetchUsers)
</script>
```

### **Pinia 2.2 状态管理**
```typescript
// frontend/src/stores/user.ts
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { userApi } from '@/api/users'
import type { User, UserCreate } from '@/types/user'

export const useUserStore = defineStore('user', () => {
  // 状态
  const users = ref<User[]>([])
  const currentUser = ref<User | null>(null)
  const loading = ref(false)

  // 计算属性
  const userCount = computed(() => users.value.length)
  const isAuthenticated = computed(() => !!currentUser.value)

  // 操作
  const fetchUsers = async () => {
    loading.value = true
    try {
      const response = await userApi.getUsers()
      users.value = response.data
      return response.data
    } finally {
      loading.value = false
    }
  }

  const createUser = async (userData: UserCreate) => {
    const response = await userApi.createUser(userData)
    users.value.push(response.data)
    return response.data
  }

  return {
    users,
    currentUser,
    loading,
    userCount,
    isAuthenticated,
    fetchUsers,
    createUser
  }
})
```

## 💾 数据库设计规范

### PostgreSQL 最佳实践
- 使用 UUID 作为主键（可选）
- 添加创建时间和更新时间字段
- 建立适当的索引
- 使用外键约束保证数据完整性
- 定期备份数据

### Alembic 迁移管理
```python
# alembic/env.py 配置
from internal.db.base import Base
target_metadata = Base.metadata

# 生成迁移文件
# alembic revision --autogenerate -m "Add user table"

# 执行迁移
# alembic upgrade head
```

### **智能Docker部署配置**

**开发环境 (deployments/docker-compose.yml)**
```yaml
services:
  fastapi-backend:
    build: 
      context: ./backend
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    volumes:
      - ./backend:/app
      - /app/__pycache__
    environment:
      - APP_HOST=0.0.0.0
      - APP_PORT=8000
      - DATABASE_URL=postgresql://fastapi:fastapi123@postgres:5432/fastapi_db
      - REDIS_URL=redis://redis:6379/0
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_started
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 5

  vue-frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules
    environment:
      - VITE_API_URL=http://localhost:8000
    depends_on:
      - fastapi-backend

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: fastapi
      POSTGRES_PASSWORD: fastapi123
      POSTGRES_DB: fastapi_db
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U fastapi"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    command: redis-server --appendonly yes
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
  redis_data:
```

**生产环境 (deployments/docker-compose.prod.yml)**
```yaml
services:
  fastapi-backend:
    image: ${DOCKER_USER}/${PROJECT_NAME}-backend:latest
    ports:
      - "8000:8000"
    environment:
      - APP_HOST=0.0.0.0
      - APP_PORT=8000
      - DATABASE_URL=${DATABASE_URL}
      - REDIS_URL=${REDIS_URL}
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
      interval: 30s
      timeout: 10s
      retries: 5

  vue-frontend:
    image: ${DOCKER_USER}/${PROJECT_NAME}-frontend:latest
    ports:
      - "3000:3000"
    environment:
      - VITE_API_URL=${API_URL}
    restart: unless-stopped
    depends_on:
      - fastapi-backend

volumes:
  postgres_data:
  redis_data:
```

### **现代化测试策略**

**后端测试 (Pytest + FastAPI TestClient)**
```python
# backend/tests/test_users.py
import pytest
from fastapi.testclient import TestClient
from app.main import app
from app.core.config import settings

client = TestClient(app)

@pytest.mark.asyncio
async def test_create_user():
    response = client.post(
        f"{settings.API_V1_STR}/users/",
        json={
            "email": "test@example.com",
            "password": "testpassword123"
        }
    )
    assert response.status_code == 200
    data = response.json()
    assert data["email"] == "test@example.com"
    assert "id" in data
```

**前端测试 (Vitest + Vue Test Utils)**
```typescript
// frontend/tests/components/UserView.spec.ts
import { describe, it, expect, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import { createPinia } from 'pinia'
import UserView from '@/views/UserView.vue'

describe('UserView', () => {
  it('renders user view correctly', () => {
    const pinia = createPinia()
    const wrapper = mount(UserView, {
      global: {
        plugins: [pinia]
      }
    })
    
    expect(wrapper.find('.user-view').exists()).toBe(true)
    expect(wrapper.find('h2').text()).toBe('用户管理')
  })
})
```

## 🚀 现代化开发流程

### **项目初始化**

```bash
# 1. 创建项目结构
mkdir fastapi-vue3-project && cd fastapi-vue3-project
mkdir -p backend/{app/{core,api/v1,models,schemas,services,utils},tests,alembic} \
         frontend/src/{api,components,views,stores,router,types,utils,assets} \
         deployments scripts

# 2. 初始化开发环境
make init

# 3. 启动开发环境
make dev

# 4. 运行健康检查
make health-check
```

### **日常开发工作流**

```bash
# 🔧 开发环境管理
make dev          # 启动完整开发环境
make stop         # 停止所有服务
make restart      # 重启开发环境
make logs         # 查看服务日志

# 🧪 测试和质量检查
make test         # 运行所有测试
make lint         # 代码质量检查
make format       # 代码格式化
make type-check   # TypeScript类型检查

# 📦 构建和部署
make build        # 构建项目
make multi-arch   # 多架构镜像构建
make deploy-dev   # 开发环境部署
make deploy-prod  # 生产安全部署
```

### **性能优化**

- **后端优化**: SQLAlchemy 2.0 异步查询、Redis 智能缓存、connection pooling
- **前端优化**: Vite 5.0 构建优化、Vue 3.5 响应式系统、组件懒加载
- **部署优化**: Docker 多架构支持、生产安全部署、健康检查机制

### **安全规范**

- **认证安全**: JWT 认证 + bcrypt 密码加密 + 刷新令牌机制
- **API安全**: CORS 正确配置 + API 限流 + 输入验证
- **数据安全**: SQL 注入防护 + XSS 防护 + 敏感数据加密
- **传输安全**: HTTPS 强制使用 + 安全头配置 + CSP策略

### **开发工具链**

- **后端工具**: Ruff (代码检查) + MyPy (类型检查) + Pytest (测试) + Black (格式化)
- **前端工具**: ESLint + Prettier + TypeScript + Vitest + Vue DevTools
- **CI/CD**: Docker 自动化构建 + 多架构支持 + 健康检查 + 自动测试

## 📚 2025年技术栈参考

### **官方文档**

- [FastAPI 0.115 官方文档](https://fastapi.tiangolo.com/)
- [Vue 3.5 官方文档](https://vuejs.org/)
- [Element Plus 2.8 组件库](https://element-plus.org/)
- [Pinia 状态管理](https://pinia.vuejs.org/)
- [SQLAlchemy 2.0 文档](https://docs.sqlalchemy.org/)

### **最佳实践指南**

- FastAPI 官方标准项目结构和组织原则
- Vue 3 Composition API 和 TypeScript 最佳实践
- 现代化 Docker 容器部署和多架构支持
- 95%项目需求覆盖的通用架构模式

---

**✨ 这个模板基于官方文档和2025年最佳实践，为FastAPI+Vue3项目提供完整的开发解决方案。**