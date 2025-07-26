# CLAUDE.md - Gin + Vue3 全栈智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Gin + Vue3全栈项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Gin + Vue3 全栈项目
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

### **🌐 全栈开发特色功能**

#### **技术栈特色**

**后端 (Gin)**
- **标准分层架构**: handler/service/model三层分离
- **GORM数据库**: PostgreSQL/MySQL支持，自动迁移
- **中间件系统**: CORS、认证、日志等常用中间件
- **配置管理**: Viper配置文件和环境变量支持

**前端 (Vue3)**
- **组合式API**: 使用最新的Vue 3 Composition API
- **Pinia状态管理**: 轻量级、类型安全的状态管理
- **Vite构建**: 极速热更新和构建优化
- **TypeScript**: 完整的类型安全支持

**全栈集成**
- **API代理**: 前端开发环境自动代理到后端
- **Docker环境**: 统一的开发和部署环境
- **类型安全**: 前后端接口类型定义一致
- **模块化设计**: 清晰的目录结构和代码组织

#### **通用标准项目结构（适用于所有Gin+Vue3项目）**

```
gin-vue3-project/
├── backend/                          # 🔥 Gin后端项目
│   ├── cmd/
│   │   └── server/
│   │       └── main.go               # 应用程序入口
│   ├── internal/                     # 私有应用代码
│   │   ├── handler/                  # HTTP处理器层
│   │   ├── service/                  # 业务逻辑层
│   │   ├── model/                    # 数据模型
│   │   ├── middleware/               # 中间件
│   │   └── config/                   # 配置管理
│   ├── pkg/                          # 可复用公共库
│   │   ├── database/                 # 数据库连接
│   │   └── utils/                    # 工具函数
│   ├── configs/                      # 配置文件
│   │   └── config.yaml               # 主配置文件
│   ├── migrations/                   # 数据库迁移文件
│   ├── go.mod                        # Go模块文件
│   ├── go.sum                        # Go依赖锁定
│   ├── .env.example                  # 环境变量示例
│   ├── .gitignore                    # Git忽略文件
│   └── Dockerfile                    # Docker构建文件
├── frontend/                         # 🚀 Vue3前端项目
│   ├── src/
│   │   ├── components/               # Vue组件
│   │   ├── views/                    # 页面组件
│   │   ├── stores/                   # Pinia状态管理
│   │   ├── utils/                    # 工具函数
│   │   ├── api/                      # API接口定义
│   │   ├── router/                   # 路由配置
│   │   ├── types/                    # TypeScript类型定义
│   │   ├── App.vue                   # 根组件
│   │   └── main.ts                   # 应用入口文件
│   ├── public/
│   │   └── index.html                # HTML模板
│   ├── package.json                  # NPM包配置
│   ├── vite.config.ts                # Vite配置文件
│   ├── tsconfig.json                 # TypeScript配置
│   ├── .env.example                  # 环境变量示例
│   ├── .gitignore                    # Git忽略文件
│   └── Dockerfile                    # Docker构建文件
├── deployments/                      # 🚀 部署配置
│   └── docker-compose.yml            # Docker编排配置
├── .gitignore                        # 根目录Git忽略文件
├── .editorconfig                     # 编辑器配置
├── Makefile                          # 构建和管理脚本
└── README.md                         # 项目说明文档
```

#### **智能构建和部署**

```bash
# 全栈构建
make build

# 开发环境启动
make dev

# 生产环境部署
make deploy

# 运行测试（前后端）
make test

# 代码检查（前后端）
make lint

# 查看帮助
make help
```

#### **核心配置文件示例**

**前端配置文件**

```typescript
// frontend/vite.config.ts
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { resolve } from 'path'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': resolve(__dirname, 'src')
    }
  },
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true
      }
    }
  }
})
```

```json
// frontend/package.json
{
  "name": "gin-vue3-frontend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vue-tsc && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "vue": "^3.4.0",
    "vue-router": "^4.2.0",
    "pinia": "^2.1.0",
    "axios": "^1.6.0",
    "element-plus": "^2.4.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^4.5.0",
    "typescript": "^5.2.0",
    "vue-tsc": "^1.8.0",
    "vite": "^5.0.0"
  }
}
```

**后端配置文件**

```yaml
# backend/configs/config.yaml
app:
  name: "gin-vue3-project"
  port: "8080"
  mode: "development"

database:
  driver: "postgres"
  host: "localhost"
  port: 5432
  username: "postgres"
  password: "password"
  dbname: "gin_vue3_db"

jwt:
  secret: "your-secret-key"
  expires_in: "24h"

cors:
  allow_origins: ["http://localhost:3000"]
  allow_methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
  allow_headers: ["Content-Type", "Authorization"]
```

```go
// backend/go.mod
module gin-vue3-project

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    github.com/gin-contrib/cors v1.5.0
    gorm.io/gorm v1.25.5
    gorm.io/driver/postgres v1.5.4
    github.com/spf13/viper v1.18.2
)
```

**Docker配置文件**

```yaml
# docker-compose.yml
version: '3.8'

services:
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    environment:
      - VITE_API_URL=http://localhost:8080
    depends_on:
      - backend

  backend:
    build: ./backend
    ports:
      - "8080:8080"
    environment:
      - DB_HOST=postgres
      - DB_USER=postgres
      - DB_PASSWORD=password
      - DB_NAME=gin_vue3_db
    depends_on:
      - postgres

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
      POSTGRES_DB: gin_vue3_db
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: 全栈架构设计和前后端协作分析
- **context7**: 动态获取Gin和Vue3最新文档和最佳实践
- **memory**: 全栈开发经验自动复用和模式库
- **puppeteer**: Web应用自动化测试和UI验证

#### **全局规则遵守**
- **Go代码规范**: 自动应用gofmt、golint规则和Gin最佳实践
- **Vue3代码规范**: ESLint、Prettier配置和Vue3组合式API规范
- **API设计规范**: RESTful API设计和统一响应格式
- **安全规范**: CORS配置、JWT认证、SQL注入防护

#### **全栈专项智能特性**
- **接口契约智能管理**: OpenAPI/Swagger自动生成和同步
- **状态管理智能设计**: 前后端状态一致性保证
- **权限控制智能实现**: 前后端权限系统统一管理
- **性能优化智能分析**: 全栈性能瓶颈识别和优化建议

### **📋 全栈开发建议**

#### **开始开发**
1. 描述功能需求，如："实现用户登录认证系统"
2. 系统会自动设计前后端接口和实现方案
3. 生成符合全栈最佳实践的代码

#### **API开发**
1. 说明API需求，如："创建用户管理CRUD接口"
2. 系统会自动生成Gin路由、控制器和Vue3页面
3. 确保前后端接口一致性和类型安全

#### **界面开发**
1. 描述UI需求，如："创建响应式用户列表页面"
2. 系统会使用Vue3组合式API和UI组件库
3. 自动处理状态管理和API调用

### **🔧 开发工具集成**

#### **后端质量保证**
- **golangci-lint**: Go代码质量检查
- **go test**: 单元测试和集成测试
- **Swagger**: API文档自动生成
- **Docker**: 容器化部署

#### **前端质量保证**
- **ESLint + Prettier**: Vue3代码规范检查
- **Vitest**: 单元测试和组件测试
- **Cypress**: E2E测试
- **Vite**: 快速构建和热更新

#### **全栈工具链**
- **Docker Compose**: 本地开发环境
- **Nginx**: 反向代理和静态资源服务
- **Redis**: 缓存和会话管理
- **PostgreSQL/MySQL**: 数据库选择

### **📈 效率提升**

相比传统全栈开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 前后端协同开发，提升5-8倍效率
- 🎯 **代码质量**: 全栈最佳实践保证A级代码质量
- 🔄 **接口一致性**: 自动化接口对接，避免前后端不匹配
- 🧠 **架构复用**: 全栈开发模式和组件自动复用
- 🔒 **安全保证**: 全栈安全最佳实践自动应用

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **构建问题**
```bash
# 清理并重新构建
make clean && make build

# 后端依赖更新
cd backend && go mod tidy

# 前端依赖更新
cd frontend && npm install
```

#### **开发环境问题**
```bash
# 重启开发环境
make down && make dev

# 检查服务状态
make status

# 查看日志
make logs
```

#### **数据库问题**
```bash
# 重置数据库
make db-reset

# 运行迁移
make migrate

# 查看数据库状态
make db-status
```

---

## 🚀 **开始全栈智能开发之旅**

智能Claude Autopilot 2.1专为Gin + Vue3全栈开发优化！

**直接描述您的全栈开发需求**，系统会自动选择最适合的开发模式：

- 功能开发 → 自动设计前后端架构和接口
- 界面开发 → 智能生成Vue3组件和页面
- API开发 → 自动创建Gin路由和数据模型
- 性能优化 → 全栈性能分析和优化建议

**享受前后端无缝协作的一次性成功开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Gin + Vue3全栈项目优化*