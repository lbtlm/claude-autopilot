# Node.js通用项目规范

## 📋 项目特征

- **适用场景**: 命令行工具、API服务、后端应用、微服务、中间件、库包开发
- **技术栈**: Node.js 22 LTS + ESM模块 + TypeScript + 现代工具链
- **开发模式**: 模块化架构 + 异步优先 + 三层架构 + 测试驱动开发
- **部署方式**: 🚀 Docker容器 + PM2进程管理 + Cloud Native + NPM发布
- **特点**: 高性能、可扩展、类型安全、现代化生态、95%Node.js场景覆盖

## 🔧 2025年技术栈标准

### **Node.js 22 LTS 最新特性 (基于官方文档)**

**核心运行时特性**
- **Node.js 22 LTS** - 最新长期支持版本，性能提升30%
- **原生ESM** - ES模块成为默认，更好的tree-shaking和工具兼容
- **Top-level await** - 顶层await支持，简化异步模块初始化
- **原生TypeScript支持** - `--experimental-strip-types`实验性支持

**内置新功能 (基于2025年最佳实践)**
- **原生文件监控** - 内置watch模式，无需nodemon
- **原生.env支持** - 内置环境变量加载，减少dotenv依赖
- **Web标准API** - fetch、AbortController、FormData等Web API原生支持
- **性能API** - 内置性能监控和诊断工具

### **现代化依赖配置 (package.json)**

**ESM优先配置**
```json
{
  "name": "my-nodejs-app",
  "version": "1.0.0",
  "type": "module",
  "engines": {
    "node": ">=22.0.0",
    "npm": ">=10.0.0"
  },
  "main": "./dist/index.js",
  "types": "./dist/index.d.ts",
  "exports": {
    ".": {
      "import": {
        "types": "./dist/index.d.ts",
        "default": "./dist/index.js"
      },
      "require": {
        "types": "./dist/index.d.cts",
        "default": "./dist/index.cjs"
      }
    }
  },
  "scripts": {
    "dev": "node --watch src/index.js",
    "start": "node dist/index.js",
    "build": "tsc && npm run build:cjs",
    "build:cjs": "rollup -c rollup.config.js",
    "test": "node --test tests/**/*.test.js",
    "test:coverage": "c8 npm test",
    "lint": "eslint src/**/*.js",
    "format": "prettier --write src/**/*.js",
    "type-check": "tsc --noEmit",
    "security": "npm audit && semgrep --config=auto src/",
    "prepare": "husky install"
  },
  "dependencies": {
    "fastify": "^5.0.0",
    "pino": "^9.0.0",
    "zod": "^3.23.0"
  },
  "devDependencies": {
    "typescript": "^5.4.0",
    "@types/node": "^22.0.0",
    "eslint": "^9.0.0",
    "prettier": "^3.2.0",
    "husky": "^9.0.0",
    "lint-staged": "^15.2.0",
    "c8": "^10.1.0",
    "rollup": "^4.18.0"
  }
}
```

**双模块支持 (库包开发)**
```json
{
  "exports": {
    ".": {
      "import": {
        "types": "./dist/main.d.ts",
        "default": "./dist/main.mjs"
      },
      "require": {
        "types": "./dist/main.d.cts", 
        "default": "./dist/main.cjs"
      },
      "default": "./dist/main.mjs"
    }
  },
  "files": [
    "dist",
    "README.md",
    "LICENSE"
  ]
}
```

## 🏗️ 通用标准项目结构 (基于Node.js最佳实践)

```
nodejs-app/
├── src/                             # 🔧 源代码目录
│   ├── controllers/                 # 🎮 控制器层 (entry-points)
│   │   ├── auth.controller.js       # 认证控制器
│   │   ├── user.controller.js       # 用户控制器
│   │   └── index.js                 # 控制器导出
│   ├── services/                    # 🧠 业务逻辑层 (domain)
│   │   ├── auth.service.js          # 认证服务
│   │   ├── user.service.js          # 用户服务
│   │   ├── email.service.js         # 邮件服务
│   │   └── index.js                 # 服务导出
│   ├── repositories/                # 💾 数据访问层 (data-access)
│   │   ├── user.repository.js       # 用户数据仓库
│   │   ├── cache.repository.js      # 缓存仓库
│   │   └── index.js                 # 仓库导出
│   ├── models/                      # 📋 数据模型和DTOs
│   │   ├── user.model.js            # 用户模型
│   │   ├── schemas/                 # Zod验证模式
│   │   │   ├── user.schema.js
│   │   │   └── auth.schema.js
│   │   └── index.js
│   ├── middleware/                  # 🔗 中间件
│   │   ├── auth.middleware.js       # 认证中间件
│   │   ├── validation.middleware.js # 验证中间件
│   │   ├── error.middleware.js      # 错误处理中间件
│   │   └── index.js
│   ├── routes/                      # 🛣️ 路由定义
│   │   ├── api/                     # API路由版本管理
│   │   │   ├── v1/
│   │   │   │   ├── auth.routes.js
│   │   │   │   ├── users.routes.js
│   │   │   │   └── index.js
│   │   │   └── index.js
│   │   └── index.js
│   ├── utils/                       # 🔧 工具函数
│   │   ├── logger.js                # 日志工具
│   │   ├── helpers.js               # 辅助函数
│   │   ├── constants.js             # 常量定义
│   │   └── index.js
│   ├── config/                      # ⚙️ 配置管理
│   │   ├── database.js              # 数据库配置
│   │   ├── redis.js                 # Redis配置
│   │   ├── app.js                   # 应用配置
│   │   └── index.js
│   ├── types/                       # 📝 TypeScript类型定义
│   │   ├── user.types.js            # 用户类型
│   │   ├── api.types.js             # API类型
│   │   └── index.js
│   ├── cli/                         # 🖥️ 命令行工具 (可选)
│   │   ├── commands/                # CLI命令
│   │   └── index.js
│   ├── app.js                       # 🚀 应用主文件
│   └── index.js                     # 📍 应用入口点
├── tests/                           # 🧪 测试文件
│   ├── unit/                        # 单元测试
│   │   ├── services/
│   │   ├── controllers/
│   │   └── utils/
│   ├── integration/                 # 集成测试
│   │   ├── api/
│   │   └── database/
│   ├── e2e/                         # 端到端测试
│   ├── fixtures/                    # 测试数据
│   │   ├── users.json
│   │   └── auth.json
│   └── helpers/                     # 测试辅助函数
│       ├── setup.js
│       └── teardown.js
├── scripts/                         # 📜 构建和部署脚本
│   ├── build.js                     # 构建脚本
│   ├── deploy.js                    # 部署脚本
│   ├── migration.js                 # 数据迁移
│   └── seed.js                      # 数据种子
├── docs/                            # 📚 项目文档
│   ├── api/                         # API文档
│   ├── architecture.md              # 架构说明
│   └── deployment.md                # 部署指南
├── config/                          # 🔧 配置文件模板
│   ├── development.env              # 开发环境配置
│   ├── production.env               # 生产环境配置
│   └── test.env                     # 测试环境配置
├── logs/                            # 📋 日志文件目录
├── dist/                            # 📦 构建输出 (如果需要)
├── node_modules/                    # 📚 依赖包
├── .env                             # 🔐 环境变量 (本地开发)
├── .env.example                     # 📝 环境变量示例
├── package.json                     # 📋 项目配置
├── package-lock.json                # 🔒 依赖锁定
├── .eslintrc.js                     # 🔍 ESLint配置
├── .prettierrc                      # 💄 Prettier配置
├── .gitignore                       # 🚫 Git忽略文件
├── .editorconfig                    # ⚙️ 编辑器配置
├── tsconfig.json                    # 📝 TypeScript配置 (可选)
├── jest.config.js                   # 🧪 Jest测试配置 (可选)
├── docker-compose.yml               # 🐳 Docker开发环境
├── Dockerfile                       # 🐳 Docker生产环境
├── .dockerignore                    # 🐳 Docker忽略文件
├── Makefile                         # 🔨 构建工具
├── README.md                        # 📖 项目说明
├── CHANGELOG.md                     # 📝 更新日志
├── LICENSE                          # ⚖️ 许可证
└── CLAUDE.md                        # 🤖 Claude开发配置
```

## 📝 核心代码文件示例

### **现代化应用入口 (src/index.js)**
```javascript
// src/index.js - ESM模块入口
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { createApp } from './app.js';
import { config } from './config/index.js';
import { logger } from './utils/logger.js';

// ESM __dirname 替代方案
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// 未捕获异常处理
process.on('uncaughtException', (error) => {
  logger.fatal({ error }, 'Uncaught Exception');
  process.exit(1);
});

process.on('unhandledRejection', (reason, promise) => {
  logger.fatal({ reason, promise }, 'Unhandled Rejection');
  process.exit(1);
});

// 应用启动
async function bootstrap() {
  try {
    const app = await createApp();
    
    const server = app.listen(config.port, config.host, (err) => {
      if (err) {
        logger.error(err);
        process.exit(1);
      }
      logger.info(`Server listening on http://${config.host}:${config.port}`);
    });

    // 优雅关闭
    const gracefulShutdown = (signal) => {
      logger.info(`Received ${signal}, shutting down gracefully`);
      server.close(() => {
        logger.info('Server closed');
        process.exit(0);
      });
    };

    process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
    process.on('SIGINT', () => gracefulShutdown('SIGINT'));

  } catch (error) {
    logger.fatal({ error }, 'Failed to start application');
    process.exit(1);
  }
}

// 启动应用
bootstrap();
```

### **现代化应用配置 (src/app.js)**
```javascript
// src/app.js - Fastify应用配置
import Fastify from 'fastify';
import { config } from './config/index.js';
import { logger } from './utils/logger.js';
import { routes } from './routes/index.js';
import { middleware } from './middleware/index.js';

/**
 * 创建Fastify应用实例
 * @returns {Promise<FastifyInstance>}
 */
export async function createApp() {
  const app = Fastify({
    logger: logger,
    disableRequestLogging: config.env === 'production',
    trustProxy: true,
    ignoreTrailingSlash: true,
    caseSensitive: false,
  });

  // 注册全局中间件
  await app.register(middleware.cors);
  await app.register(middleware.helmet);
  await app.register(middleware.rateLimit);

  // 健康检查端点
  app.get('/health', async (request, reply) => {
    return { 
      status: 'ok', 
      timestamp: new Date().toISOString(),
      uptime: process.uptime(),
      version: process.env.npm_package_version
    };
  });

  // 注册API路由
  await app.register(routes.api, { prefix: '/api' });

  // 全局错误处理
  app.setErrorHandler(async (error, request, reply) => {
    request.log.error({ error }, 'Unhandled error');
    
    if (error.validation) {
      return reply.status(400).send({
        error: 'Validation Error',
        message: error.message,
        details: error.validation
      });
    }

    const statusCode = error.statusCode || 500;
    const message = config.env === 'production' && statusCode === 500 
      ? 'Internal Server Error' 
      : error.message;

    return reply.status(statusCode).send({
      error: 'Server Error',
      message,
      ...(config.env !== 'production' && { stack: error.stack })
    });
  });

  // 404处理
  app.setNotFoundHandler(async (request, reply) => {
    return reply.status(404).send({
      error: 'Not Found',
      message: `Route ${request.method}:${request.url} not found`
    });
  });

  return app;
}
```

### **现代化配置管理 (src/config/index.js)**
```javascript
// src/config/index.js - 分层配置管理
import { readFileSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// 加载package.json获取版本信息
const packageJson = JSON.parse(
  readFileSync(join(__dirname, '../../package.json'), 'utf8')
);

// 环境变量验证和转换
function getEnvVar(name, defaultValue, type = 'string') {
  const value = process.env[name] || defaultValue;
  
  switch (type) {
    case 'number':
      const num = Number(value);
      if (isNaN(num)) {
        throw new Error(`Environment variable ${name} must be a number`);
      }
      return num;
    case 'boolean':
      return value === 'true' || value === '1';
    case 'array':
      return value ? value.split(',').map(item => item.trim()) : [];
    default:
      return value;
  }
}

// 基础配置
const baseConfig = {
  // 应用信息
  name: packageJson.name,
  version: packageJson.version,
  env: getEnvVar('NODE_ENV', 'development'),
  
  // 服务器配置
  host: getEnvVar('HOST', '0.0.0.0'),
  port: getEnvVar('PORT', 3000, 'number'),
  
  // 数据库配置
  database: {
    url: getEnvVar('DATABASE_URL', 'sqlite://./database.db'),
    pool: {
      min: getEnvVar('DB_POOL_MIN', 2, 'number'),
      max: getEnvVar('DB_POOL_MAX', 10, 'number'),
    },
    ssl: getEnvVar('DB_SSL', false, 'boolean'),
  },
  
  // Redis配置
  redis: {
    url: getEnvVar('REDIS_URL', 'redis://localhost:6379'),
    ttl: getEnvVar('REDIS_TTL', 3600, 'number'),
  },
  
  // JWT配置
  jwt: {
    secret: getEnvVar('JWT_SECRET'),
    expiresIn: getEnvVar('JWT_EXPIRES_IN', '24h'),
    issuer: getEnvVar('JWT_ISSUER', packageJson.name),
  },
  
  // 日志配置
  log: {
    level: getEnvVar('LOG_LEVEL', 'info'),
    pretty: getEnvVar('LOG_PRETTY', false, 'boolean'),
  },
  
  // 安全配置
  security: {
    bcryptRounds: getEnvVar('BCRYPT_ROUNDS', 12, 'number'),
    rateLimitMax: getEnvVar('RATE_LIMIT_MAX', 100, 'number'),
    rateLimitWindow: getEnvVar('RATE_LIMIT_WINDOW', 60000, 'number'),
  },
  
  // CORS配置
  cors: {
    origin: getEnvVar('CORS_ORIGIN', '*', 'array'),
    credentials: getEnvVar('CORS_CREDENTIALS', true, 'boolean'),
  },
};

// 环境特定配置
const envConfigs = {
  development: {
    log: {
      level: 'debug',
      pretty: true,
    },
  },
  
  test: {
    database: {
      url: getEnvVar('TEST_DATABASE_URL', 'sqlite://:memory:'),
    },
    log: {
      level: 'silent',
    },
  },
  
  production: {
    log: {
      pretty: false,
    },
    security: {
      rateLimitMax: 50,
    },
  },
};

// 合并配置
export const config = {
  ...baseConfig,
  ...envConfigs[baseConfig.env],
};

// 配置验证
function validateConfig() {
  const required = ['JWT_SECRET'];
  
  for (const key of required) {
    if (!process.env[key]) {
      throw new Error(`Missing required environment variable: ${key}`);
    }
  }
}

// 非测试环境验证配置
if (config.env !== 'test') {
  validateConfig();
}
```

## 📜 2025年标准化 Makefile

```makefile
# Node.js通用项目Makefile
# 支持现代化开发工作流和部署流程

# 项目配置
PROJECT_NAME = $(shell node -p "require('./package.json').name")
VERSION = $(shell node -p "require('./package.json').version")
NODE_VERSION = $(shell node -p "require('./package.json').engines.node")

# 环境变量
NODE_ENV ?= development
PORT ?= 3000

.PHONY: help install dev start build test lint format type-check security clean health-check

help:
	@echo "🚀 $(PROJECT_NAME) v$(VERSION) - Node.js开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  install       - 安装项目依赖"
	@echo "  dev           - 启动开发服务器 (带热重载)"
	@echo "  start         - 启动生产服务器"
	@echo "  debug         - 启动调试模式"
	@echo ""
	@echo "🔨 代码质量:"
	@echo "  lint          - 代码检查 (ESLint)"
	@echo "  format        - 代码格式化 (Prettier)"
	@echo "  type-check    - TypeScript类型检查"
	@echo "  test          - 运行测试"
	@echo "  test-watch    - 监听模式测试"
	@echo "  test-coverage - 测试覆盖率报告"
	@echo ""
	@echo "🔒 安全和审计:"
	@echo "  security      - 安全扫描 (npm audit + semgrep)"
	@echo "  deps-check    - 检查过时依赖"
	@echo "  deps-update   - 更新依赖"
	@echo ""
	@echo "🏗️  构建和部署:"
	@echo "  build         - 构建项目"
	@echo "  docker-build  - 构建Docker镜像"
	@echo "  docker-run    - 运行Docker容器"
	@echo ""
	@echo "🧹 维护:"
	@echo "  clean         - 清理构建文件和缓存"
	@echo "  health-check  - 项目健康检查"
	@echo "  setup         - 一键项目环境设置"

# 依赖管理
install:
	@echo "📦 安装项目依赖..."
	npm ci
	@echo "✅ 依赖安装完成!"

install-dev:
	@echo "📦 安装开发依赖..."
	npm install
	@echo "✅ 开发依赖安装完成!"

# 开发服务器
dev:
	@echo "🚀 启动开发服务器..."
	NODE_ENV=development npm run dev

start:
	@echo "🚀 启动生产服务器..."
	NODE_ENV=production npm start

debug:
	@echo "🐛 启动调试模式..."
	NODE_ENV=development node --inspect src/index.js

# 代码质量
lint:
	@echo "🔍 代码检查..."
	npm run lint
	@echo "✅ 代码检查通过!"

lint-fix:
	@echo "🔧 自动修复代码问题..."
	npm run lint -- --fix
	@echo "✅ 代码问题已修复!"

format:
	@echo "💄 代码格式化..."
	npm run format
	@echo "✅ 代码格式化完成!"

type-check:
	@echo "📝 TypeScript类型检查..."
	npm run type-check
	@echo "✅ 类型检查通过!"

# 测试
test:
	@echo "🧪 运行测试..."
	NODE_ENV=test npm test
	@echo "✅ 测试完成!"

test-watch:
	@echo "👀 监听模式测试..."
	NODE_ENV=test npm run test:watch

test-coverage:
	@echo "📊 生成测试覆盖率报告..."
	NODE_ENV=test npm run test:coverage
	@echo "✅ 覆盖率报告生成完成!"

# 安全和审计
security:
	@echo "🔒 安全扫描..."
	npm audit --audit-level=moderate
	@if command -v semgrep >/dev/null 2>&1; then \
		semgrep --config=auto src/; \
	else \
		echo "⚠️  semgrep未安装，跳过静态分析"; \
	fi
	@echo "✅ 安全扫描完成!"

deps-check:
	@echo "📊 检查过时依赖..."
	npm outdated
	@echo "✅ 依赖检查完成!"

deps-update:
	@echo "⬆️  更新依赖..."
	npm update
	npm audit fix
	@echo "✅ 依赖更新完成!"

# 构建
build:
	@echo "🏗️ 构建项目..."
	npm run build
	@echo "✅ 构建完成!"

# Docker
docker-build:
	@echo "🐳 构建Docker镜像..."
	docker build -t $(PROJECT_NAME):$(VERSION) .
	docker tag $(PROJECT_NAME):$(VERSION) $(PROJECT_NAME):latest
	@echo "✅ Docker镜像构建完成!"

docker-run:
	@echo "🐳 运行Docker容器..."
	docker run -p $(PORT):$(PORT) --env-file .env $(PROJECT_NAME):latest

docker-dev:
	@echo "🐳 启动Docker开发环境..."
	docker-compose up -d
	@echo "✅ Docker开发环境启动完成!"

docker-stop:
	@echo "🛑 停止Docker开发环境..."
	docker-compose down
	@echo "✅ Docker环境已停止!"

# 维护
clean:
	@echo "🧹 清理构建文件和缓存..."
	rm -rf dist/
	rm -rf coverage/
	rm -rf .nyc_output/
	npm cache clean --force
	@echo "✅ 清理完成!"

clean-full:
	@echo "🧹 完整清理 (包括node_modules)..."
	rm -rf node_modules/
	rm -rf package-lock.json
	$(MAKE) clean
	@echo "✅ 完整清理完成!"

health-check:
	@echo "🏥 项目健康检查..."
	@echo "Node.js版本: $(shell node --version)"
	@echo "NPM版本: $(shell npm --version)"
	@echo "项目版本: $(VERSION)"
	@echo "需要Node.js版本: $(NODE_VERSION)"
	npm run lint
	npm run type-check
	NODE_ENV=test npm test
	npm audit --audit-level=moderate
	@echo "✅ 健康检查完成!"

setup:
	@echo "🛠️  一键项目环境设置..."
	$(MAKE) install
	$(MAKE) health-check
	@echo "✅ 项目环境设置完成!"

# 生产部署辅助
deploy-check:
	@echo "🚀 部署前检查..."
	$(MAKE) test
	$(MAKE) security
	$(MAKE) build
	@echo "✅ 部署检查通过!"

pm2-start:
	@echo "🚀 使用PM2启动生产服务..."
	pm2 start ecosystem.config.js --env production
	@echo "✅ PM2服务启动完成!"

pm2-stop:
	@echo "🛑 停止PM2服务..."
	pm2 stop $(PROJECT_NAME)
	@echo "✅ PM2服务已停止!"

pm2-restart:
	@echo "🔄 重启PM2服务..."
	pm2 restart $(PROJECT_NAME)
	@echo "✅ PM2服务重启完成!"

# 数据库操作 (如果使用数据库)
db-migrate:
	@echo "🗃️  运行数据库迁移..."
	npm run db:migrate
	@echo "✅ 数据库迁移完成!"

db-seed:
	@echo "🌱 填充数据库种子数据..."
	npm run db:seed
	@echo "✅ 种子数据填充完成!"

db-reset:
	@echo "🔄 重置数据库..."
	npm run db:reset
	@echo "✅ 数据库重置完成!"

# Git hooks设置
hooks-install:
	@echo "🪝 安装Git hooks..."
	npx husky install
	@echo "✅ Git hooks安装完成!"

# 性能分析
profile:
	@echo "📊 性能分析..."
	node --prof src/index.js &
	sleep 5
	kill %1
	node --prof-process isolate-*.log > profile.txt
	@echo "✅ 性能分析完成，查看 profile.txt"

# 内存分析
memory-check:
	@echo "🧠 内存使用检查..."
	node --inspect src/index.js &
	@echo "✅ 内存检查启动，在Chrome中打开 chrome://inspect"
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: 复杂Node.js架构设计和异步流程分析
- **context7**: 动态获取Node.js生态最新文档和最佳实践
- **memory**: Node.js开发经验自动复用和设计模式库
- **filesystem**: 智能项目结构分析和模块组织
- **puppeteer**: API端点自动化测试和性能监控

#### **全局规则遵守**
- **Node.js代码规范**: 自动应用官方风格指南和ESM最佳实践
- **异步编程模式**: Promise/async-await的正确使用和错误处理
- **安全编程**: 防止注入攻击、依赖漏洞、敏感信息泄露
- **性能优化**: 事件循环优化、内存管理、流处理最佳实践

#### **Node.js专项智能特性**
- **业务组件分层**: 基于业务功能而非技术栈的模块划分
- **三层架构设计**: entry-points、domain、data-access清晰分离
- **异步编程优化**: 
  - Promise并发控制和错误边界
  - Stream API高效数据处理
  - Worker Threads CPU密集任务处理
- **ESM模块系统**: 
  - 原生ES模块导入导出
  - Top-level await使用
  - 双模块包(ESM+CJS)兼容性
- **现代化工具链**: 
  - 原生TypeScript支持
  - 内置测试运行器
  - 原生文件监控
  - Web标准API使用

### **📋 Node.js开发建议**

#### **开始开发**
1. 描述功能需求，如："创建RESTful用户管理API"
2. 系统会自动设计三层架构和业务组件分层
3. 生成符合2025年Node.js最佳实践的现代化代码

#### **API开发**
1. 说明API需求，如："实现JWT认证和授权系统"
2. 系统会设计安全的认证流程和中间件架构
3. 自动处理输入验证、错误处理和安全防护

#### **性能优化**
1. 描述性能需求，如："优化大文件上传处理"
2. 系统会使用Stream API和背压处理机制
3. 确保内存效率和并发处理能力

### **🔧 开发工具集成**

#### **现代化运行时**
- **Node.js 22 LTS**: 最新长期支持版本和性能优化
- **原生ESM**: ES模块系统和top-level await支持  
- **内置功能**: 原生文件监控、.env支持、Web标准API
- **TypeScript**: 实验性原生TypeScript支持

#### **开发生态**
- **Fastify**: 高性能Web框架，比Express快2倍
- **Pino**: 快速结构化日志记录
- **Zod**: 运行时类型验证和数据校验
- **Vitest/Jest**: 现代化测试框架

#### **代码质量**
- **ESLint 9**: 最新代码检查规则和扁平配置
- **Prettier**: 统一代码格式化
- **Husky**: Git hooks自动化质量检查
- **c8**: 原生代码覆盖率工具

#### **构建和部署**
- **Docker**: 多阶段构建和容器化部署
- **PM2**: 生产环境进程管理和集群模式
- **GitHub Actions**: CI/CD自动化流水线
- **Semantic Release**: 自动化版本发布

### **📈 效率提升**

相比传统Node.js开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 业务组件和API架构自动生成，提升4-6倍效率
- 🎯 **架构质量**: 基于2025年Node.js最佳实践的企业级设计
- 🔄 **模式复用**: 智能识别可复用的业务逻辑和设计模式
- 📊 **性能优化**: 自动应用异步优化和内存管理策略
- 🧪 **测试覆盖**: 自动生成单元测试和集成测试用例
- 🔒 **安全保证**: 内置安全最佳实践和漏洞扫描

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

# 检查Node.js版本 (需要22+)
node --version
npm --version

# 更新到最新LTS
nvm install 22
nvm use 22
```

#### **ESM模块问题**
```bash
# 检查package.json配置
# 确保设置 "type": "module"

# 文件扩展名问题
# ESM需要明确的文件扩展名
import './utils/helper.js'  # 正确
import './utils/helper'     # 错误

# __dirname在ESM中的替代
import { fileURLToPath } from 'node:url';
import { dirname } from 'node:path';
const __dirname = dirname(fileURLToPath(import.meta.url));
```

#### **性能问题**
```bash
# Node.js性能分析
node --prof src/index.js

# 内存使用分析  
node --inspect src/index.js

# 事件循环延迟监控
node --trace-events-enabled src/index.js

# CPU使用分析
node --cpu-prof src/index.js

# 堆内存快照
node --heapsnapshot-signal=SIGUSR2 src/index.js
```

#### **依赖问题**
```bash
# 依赖安全审计
npm audit
npm audit fix

# 检查过时依赖
npm outdated

# 更新依赖
npm update

# 检查依赖树
npm list

# 分析包大小
npm run build --report
```

#### **测试问题**
```bash
# 使用Node.js内置测试运行器
node --test tests/**/*.test.js

# 覆盖率报告
c8 node --test tests/**/*.test.js

# 监听模式测试
node --test --watch tests/**/*.test.js

# 调试测试
node --inspect --test tests/specific.test.js
```

---

## 🚀 **开始Node.js智能开发之旅**

智能Claude Autopilot 2.1专为Node.js通用开发优化！

**直接描述您的开发需求**，系统会自动选择最适合的开发模式：

- 后端API → 自动设计RESTful架构和三层架构分离
- 命令行工具 → 基于现代CLI最佳实践的交互式工具
- 微服务 → 业务组件化的可扩展服务架构  
- 数据处理 → 高性能Stream处理和异步数据管道
- 库包开发 → 双模块(ESM+CJS)兼容的NPM包

**享受Node.js生态的现代化开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Node.js通用项目优化*