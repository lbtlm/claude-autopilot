# FastAPI + Vue3 项目规范

## 📋 项目特征

- **适用场景**: 前后端分离的Web应用，API服务，数据分析平台
- **后端技术栈**: FastAPI + PostgreSQL + Redis + SQLAlchemy + Alembic
- **前端技术栈**: Vue3 + TypeScript + Element Plus + Vite
- **部署方式**: 🚀 Docker标准化部署 + 多架构支持 + 智能Redis检测
- **特点**: 异步高性能、自动API文档、类型安全、现代Python栈

## 🏗️ 标准目录结构

```
project-name/
├── CLAUDE.md              # Claude Code 操作指南
├── .vscode/              # VSCode 配置
├── .editorconfig         # 编辑器规范
├── .gitignore           # Git 忽略规则
├── Makefile             # 构建命令
├── project_docs/         # 项目文档
├── project_process/      # 开发记录
├── backend/             # 后端代码
│   ├── cmd/             # 主程序入口
│   │   └── server/      # 服务器主程序
│   │       └── main.py  # 程序入口
│   ├── internal/        # 内部包
│   │   ├── __init__.py
│   │   ├── app.py       # FastAPI 应用入口
│   │   ├── api/         # API 路由
│   │   │   ├── __init__.py
│   │   │   ├── deps.py  # 依赖注入
│   │   │   ├── auth.py  # 认证相关
│   │   │   ├── handlers/   # API 处理器
│   │   │   │   ├── user/  # 用户相关接口
│   │   │   │   ├── auth/  # 认证相关接口
│   │   │   │   └── health/ # 健康检查接口
│   │   │   └── middleware/  # 中间件
│   │   │       ├── auth.py  # 认证中间件
│   │   │       ├── cors.py  # 跨域中间件
│   │   │       ├── logger.py # 日志中间件
│   │   │       └── error.py  # 错误处理中间件
│   │   ├── core/        # 核心配置
│   │   │   ├── __init__.py
│   │   │   ├── config.py
│   │   │   ├── security.py
│   │   │   └── database.py
│   │   ├── db/          # 数据库相关
│   │   │   ├── __init__.py
│   │   │   ├── base.py
│   │   │   ├── models/
│   │   │   └── migrations/
│   │   ├── schemas/     # Pydantic 模型
│   │   │   ├── __init__.py
│   │   │   ├── user.py
│   │   │   └── auth.py
│   │   ├── services/    # 业务逻辑
│   │   │   ├── __init__.py
│   │   │   ├── user.py
│   │   │   └── auth.py
│   │   └── utils/       # 工具函数
│   ├── pkg/             # 可复用包
│   │   ├── logger/      # 日志工具
│   │   ├── database/    # 数据库工具
│   │   ├── errors/      # 错误处理
│   │   ├── response/    # 响应封装
│   │   └── constants/   # 常量定义
│   ├── tests/           # 后端测试
│   ├── alembic/         # 数据库迁移
│   ├── requirements.txt
│   ├── requirements-dev.txt
│   └── Dockerfile
├── frontend/            # 前端代码
│   ├── src/
│   │   ├── api/         # API 调用封装
│   │   ├── components/  # 可复用组件
│   │   ├── views/       # 页面组件
│   │   ├── stores/      # Pinia 状态管理
│   │   ├── router/      # 路由配置
│   │   ├── utils/       # 工具函数
│   │   ├── types/       # TypeScript 类型
│   │   ├── styles/      # 样式文件
│   │   ├── assets/      # 静态资源
│   │   ├── App.vue
│   │   └── main.ts
│   ├── public/
│   ├── package.json
│   ├── vite.config.ts
│   ├── tsconfig.json
│   ├── .env.example
│   └── Dockerfile
├── deployments/         # ⭐ 部署配置 (标准化)
│   ├── docker-compose.smart.yml      # 智能Docker配置
│   ├── production-safe-deploy.sh     # 生产安全部署脚本
│   └── smart-redis-deploy.sh         # 开发测试部署脚本
├── scripts/             # ⭐ 构建脚本 (标准化)
│   └── multi-arch-build.sh          # 多架构镜像构建脚本
└── .env.example         # 环境变量示例
```

## 🔧 技术栈版本要求

### 后端依赖
```txt
# requirements.txt
fastapi>=0.104.0
uvicorn[standard]>=0.24.0
sqlalchemy>=2.0.0
alembic>=1.12.0
psycopg2-binary>=2.9.0
redis>=5.0.0
python-jose[cryptography]>=3.3.0
passlib[bcrypt]>=1.7.4
python-multipart>=0.0.6
```

### 前端依赖
```json
// package.json
{
  "dependencies": {
    "vue": "^3.3.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "@element-plus/icons-vue": "^2.1.0",
    "element-plus": "^2.4.0",
    "axios": "^1.5.0",
    "dayjs": "^1.11.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.4.0",
    "typescript": "^5.2.0",
    "vite": "^4.5.0",
    "@types/node": "^20.8.0",
    "eslint": "^8.51.0",
    "@typescript-eslint/eslint-plugin": "^6.7.0",
    "prettier": "^3.0.0"
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

## 📜 标准 Makefile

```makefile
.PHONY: init dev test lint build build-multi deploy-dev deploy-prod clean help

# Docker 配置
DOCKER_USER = your-dockerhub-username
PROJECT_NAME = your-fastapi-project
IMAGE_NAME = $(DOCKER_USER)/$(PROJECT_NAME)

help:
	@echo "🚀 FastAPI + Vue3 项目标准化开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  init          - 初始化开发环境"
	@echo "  dev           - 启动开发环境"
	@echo "  test          - 运行所有测试"
	@echo "  lint          - 代码检查和格式化"
	@echo ""
	@echo "🏗️  构建部署:"
	@echo "  build         - 构建本地镜像"
	@echo "  build-multi   - 构建多架构镜像并推送 ⭐"
	@echo ""
	@echo "🚀 部署命令:"
	@echo "  deploy-dev    - 智能开发环境部署"
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
	# 使用智能Redis检测部署
	./deployments/smart-redis-deploy.sh

test:
	@echo "🧪 运行测试..."
	@echo "📋 后端测试..."
	cd backend && pytest tests/ -v --cov=app
	@echo "📋 前端测试..."
	cd frontend && npm run test

lint:
	@echo "🔍 代码检查..."
	@echo "📋 Python 代码检查..."
	cd backend && flake8 app/ tests/
	cd backend && mypy app/
	cd backend && black app/ tests/ --check
	@echo "📋 前端代码检查..."
	cd frontend && npm run lint
	cd frontend && npm run type-check

build:
	@echo "📦 构建本地镜像..."
	cd frontend && npm run build
	docker build -t $(IMAGE_NAME):latest -f backend/Dockerfile .

# ⭐ 多架构镜像构建（推荐）
build-multi:
	@echo "🌍 构建多架构镜像..."
	./scripts/multi-arch-build.sh

# ⭐ 智能开发环境部署
deploy-dev:
	@echo "🚀 智能开发环境部署..."
	./deployments/smart-redis-deploy.sh

# ⭐ 生产安全部署
deploy-prod:
	@echo "🔒 生产安全部署..."
	./deployments/production-safe-deploy.sh

clean:
	@echo "🧹 清理临时文件..."
	docker-compose -f deployments/docker-compose.smart.yml down
	cd backend && rm -rf __pycache__/ .pytest_cache/ .coverage htmlcov/
	cd frontend && rm -rf node_modules/ dist/

# 项目健康检查
health-check:
	@echo "🏥 项目健康检查..."
	@echo "📋 Python环境检查..."
	cd backend && python -m pip check
	@echo "📋 代码质量检查..."
	cd backend && flake8 app/ tests/
	cd backend && mypy app/
	@echo "📋 测试覆盖率..."
	cd backend && pytest --cov=app tests/
	@echo "📋 前端检查..."
	cd frontend && npm run lint && npm run type-check
	@echo "✅ 健康检查完成!"

# 数据库迁移
migrate:
	@echo "📊 运行数据库迁移..."
	cd backend && alembic upgrade head

# 生成迁移文件
makemigrations:
	@echo "📝 生成数据库迁移文件..."
	cd backend && alembic revision --autogenerate -m "$(message)"

# API文档
docs:
	@echo "📚 启动API文档服务..."
	@echo "🌐 文档地址: http://localhost:8000/docs"
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

## 🎨 后端开发规范

### FastAPI 项目结构
```python
# backend/internal/app.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from internal.api.api import api_router
from internal.core.config import settings

app = FastAPI(title=settings.PROJECT_NAME)

# CORS 配置
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.BACKEND_CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(api_router, prefix="/api")
```

### 数据库模型规范
```python
# backend/internal/db/models/user.py
from sqlalchemy import Column, Integer, String, Boolean, DateTime
from internal.db.base_class import Base

class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=func.now())
```

### API 路由规范
```python
# backend/internal/api/handlers/user/users.py
from fastapi import APIRouter, Depends, HTTPException
from internal.schemas.user import UserCreate, UserResponse
from internal.services.user import UserService

router = APIRouter()

@router.post("/", response_model=UserResponse)
async def create_user(
    user_in: UserCreate,
    user_service: UserService = Depends()
) -> UserResponse:
    return await user_service.create_user(user_in)
```

## 🎨 前端开发规范

### Vue3 组合式 API
```typescript
// src/views/UserList.vue
<template>
  <div class="user-list">
    <el-table :data="users" loading="loading">
      <el-table-column prop="email" label="邮箱" />
      <el-table-column prop="created_at" label="创建时间" />
    </el-table>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useUserStore } from '@/stores/user'
import type { User } from '@/types/user'

const userStore = useUserStore()
const users = ref<User[]>([])
const loading = ref(false)

onMounted(async () => {
  loading.value = true
  try {
    users.value = await userStore.fetchUsers()
  } finally {
    loading.value = false
  }
})
</script>
```

### Pinia 状态管理
```typescript
// src/stores/user.ts
import { defineStore } from 'pinia'
import { userApi } from '@/api/user'
import type { User, UserCreate } from '@/types/user'

export const useUserStore = defineStore('user', {
  state: () => ({
    users: [] as User[],
    currentUser: null as User | null,
  }),
  
  actions: {
    async fetchUsers() {
      const response = await userApi.getUsers()
      this.users = response.data
      return response.data
    },
    
    async createUser(userData: UserCreate) {
      const response = await userApi.createUser(userData)
      this.users.push(response.data)
      return response.data
    }
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

## 🐳 Docker 配置

### 开发环境 docker-compose.yml
```yaml
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    volumes:
      - ./backend:/app
    depends_on:
      - postgres
      - redis
    environment:
      - DATABASE_URL=postgresql://user:password@postgres:5432/dbname
      - REDIS_URL=redis://redis:6379

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
      - /app/node_modules

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: dbname
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
```

## 🧪 测试策略

### 后端测试
```python
# tests/test_users.py
import pytest
from fastapi.testclient import TestClient
from internal.app import app

client = TestClient(app)

def test_create_user():
    response = client.post("/api/users/", json={
        "email": "test@example.com",
        "password": "testpassword"
    })
    assert response.status_code == 200
    assert response.json()["email"] == "test@example.com"
```

### 前端测试
```typescript
// tests/components/UserList.spec.ts
import { mount } from '@vue/test-utils'
import UserList from '@/components/UserList.vue'

describe('UserList', () => {
  it('renders user list correctly', () => {
    const wrapper = mount(UserList)
    expect(wrapper.find('.user-list').exists()).toBe(true)
  })
})
```

## 🚀 部署和运维

### 生产环境配置
- 使用 HTTPS
- 配置 Nginx 反向代理
- 设置环境变量管理
- 配置日志收集
- 设置监控和告警

### 性能优化
- 数据库查询优化
- Redis 缓存策略
- 前端代码分割
- CDN 静态资源加速
- 接口响应压缩

## 📚 推荐资源

### 官方文档
- [FastAPI 文档](https://fastapi.tiangolo.com/)
- [Vue3 文档](https://vuejs.org/)
- [Element Plus 文档](https://element-plus.org/)

### 最佳实践
- RESTful API 设计原则
- 前后端分离开发模式
- 微服务架构考虑
- 容器化部署策略