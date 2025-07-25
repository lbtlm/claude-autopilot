# CLAUDE.md - Python Web项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Python Web项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Python Web项目
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

### **🌐 Python Web开发特色功能**

#### **现代Web框架支持**
- **FastAPI**: 现代高性能异步API框架，自动生成OpenAPI文档
- **Django**: 全栈Web框架，内置ORM、管理界面、认证系统
- **Flask**: 轻量级微框架，高度可定制和灵活性
- **Starlette**: ASGI异步框架，FastAPI的底层基础

#### **高性能特性**
- **异步编程**: async/await支持高并发请求处理
- **自动文档生成**: 基于类型注解自动生成Swagger/ReDoc文档
- **数据验证**: Pydantic模型自动验证和序列化
- **依赖注入**: FastAPI依赖系统实现解耦和复用

#### **企业级架构**
- **领域驱动设计**: 按业务领域组织代码结构
- **分层架构**: Router → Service → Repository → Model清晰分层
- **配置管理**: 环境变量管理和分环境配置
- **测试驱动**: 完整的单元测试和集成测试体系

#### **标准Python Web项目结构支持**
```
python-web项目/
├── app/
│   ├── api/                     # API路由层
│   │   ├── v1/                  # API版本管理
│   │   │   ├── endpoints/       # 端点定义
│   │   │   └── router.py        # 路由汇总
│   │   └── dependencies.py      # 全局依赖
│   ├── core/                    # 核心配置
│   │   ├── config.py            # 配置管理
│   │   ├── security.py          # 安全相关
│   │   ├── database.py          # 数据库连接
│   │   └── exceptions.py        # 全局异常
│   ├── models/                  # 数据模型层
│   │   ├── user.py              # 用户模型
│   │   └── base.py              # 基础模型
│   ├── schemas/                 # Pydantic模式
│   │   ├── user.py              # 用户schema
│   │   └── base.py              # 基础schema
│   ├── services/                # 业务逻辑层
│   │   ├── user_service.py      # 用户服务
│   │   └── base_service.py      # 基础服务
│   ├── repositories/            # 数据访问层
│   │   ├── user_repository.py   # 用户仓库
│   │   └── base_repository.py   # 基础仓库
│   ├── utils/                   # 工具函数
│   │   ├── security.py          # 安全工具
│   │   └── helpers.py           # 助手函数
│   └── main.py                  # 应用入口
├── tests/                       # 测试文件
│   ├── api/                     # API测试
│   ├── services/                # 服务测试
│   ├── repositories/            # 仓库测试
│   └── conftest.py              # 测试配置
├── alembic/                     # 数据库迁移
│   ├── versions/                # 迁移版本
│   └── env.py                   # Alembic配置
├── scripts/                     # 脚本文件
│   ├── init_db.py               # 数据库初始化
│   └── seed_data.py             # 数据填充
├── docs/                        # 项目文档
├── docker/                      # Docker配置
│   ├── Dockerfile               # 应用镜像
│   └── docker-compose.yml       # 服务编排
├── requirements/                # 依赖管理
│   ├── base.txt                 # 基础依赖
│   ├── dev.txt                  # 开发依赖
│   └── prod.txt                 # 生产依赖
├── .env.example                 # 环境变量模板
├── .gitignore                   # Git忽略文件
├── pyproject.toml              # 项目配置
├── alembic.ini                 # Alembic配置
└── logging.ini                 # 日志配置
```

#### **智能开发和构建**
```bash
# 启动开发服务器
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# 运行测试
pytest tests/ -v

# 代码质量检查
ruff check --fix app/
ruff format app/

# 类型检查
mypy app/

# 数据库迁移
alembic upgrade head

# 创建新迁移
alembic revision --autogenerate -m "描述"

# 启动生产服务器
gunicorn app.main:app -w 4 -k uvicorn.workers.UvicornWorker

# Docker构建
docker build -t myapp .
docker-compose up -d
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: Web API架构设计和数据流分析
- **context7**: 动态获取Python Web框架最新文档和最佳实践
- **memory**: Python Web开发经验自动复用和设计模式库
- **puppeteer**: Web API自动化测试和端到端测试

#### **全局规则遵守**
- **Python代码规范**: 自动应用PEP 8和FastAPI最佳实践
- **API设计原则**: RESTful规范、HTTP状态码、响应格式统一
- **安全编程**: JWT认证、CORS配置、输入验证、SQL注入防护
- **性能优化**: 异步操作、数据库查询优化、缓存策略

#### **Python Web专项智能特性**
- **依赖注入模式**: FastAPI依赖系统的正确使用和链式组合
- **数据验证流程**: Pydantic模型验证和错误处理机制
- **异步编程**: async/await的正确使用和并发控制
- **API文档生成**: 基于类型注解的自动文档和响应模型

### **📋 Python Web开发建议**

#### **开始开发**
1. 描述API需求，如："创建用户认证和权限管理系统"
2. 系统会自动设计RESTful API结构和数据模型
3. 生成符合FastAPI最佳实践的异步Web应用框架

#### **API开发**
1. 说明接口需求，如："创建文章管理CRUD接口"
2. 系统会设计完整的路由、服务、仓库层结构
3. 自动处理数据验证、异常处理和响应序列化

#### **数据库集成**
1. 描述数据需求，如："设计用户和订单关系模型"
2. 系统会创建SQLAlchemy模型和Alembic迁移
3. 确保数据完整性和查询性能优化

### **🔧 开发工具集成**

#### **开发环境**
- **Python 3.9+**: 现代Python运行时环境
- **FastAPI**: 高性能异步Web框架
- **Uvicorn**: ASGI服务器用于开发和生产
- **Poetry/pip**: 依赖管理和虚拟环境

#### **代码质量**
- **Ruff**: 极速Python代码检查和格式化
- **mypy**: 静态类型检查
- **black**: 代码自动格式化（可选，推荐Ruff）
- **pre-commit**: Git钩子自动化检查

#### **测试框架**
- **pytest**: 现代Python测试框架
- **pytest-asyncio**: 异步测试支持
- **httpx**: 异步HTTP客户端，用于API测试
- **pytest-cov**: 代码覆盖率分析

#### **数据库和ORM**
- **SQLAlchemy**: 强大的Python ORM
- **Alembic**: 数据库迁移管理
- **asyncpg**: 高性能异步PostgreSQL驱动
- **Redis**: 缓存和会话存储

#### **部署和监控**
- **Docker**: 容器化部署
- **Gunicorn**: 生产级WSGI服务器
- **Nginx**: 反向代理和负载均衡
- **Prometheus**: 监控和指标收集

### **📈 效率提升**

相比传统Python Web开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: API路由和数据模型自动生成，提升4-5倍效率
- 🎯 **架构质量**: 基于领域驱动设计的可维护架构
- 🔄 **异步优化**: 智能的异步操作和并发控制
- 📊 **性能优化**: 数据库查询优化和缓存策略
- 🧪 **测试覆盖**: 自动生成API测试用例和集成测试

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **开发环境问题**
```bash
# 创建虚拟环境
python -m venv venv

# 激活虚拟环境
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# 安装依赖
pip install -r requirements/dev.txt

# 使用Poetry管理依赖
poetry install
poetry shell
```

#### **FastAPI问题**
```bash
# 检查FastAPI安装
python -c "import fastapi; print(fastapi.__version__)"

# 启动调试模式
uvicorn app.main:app --reload --log-level debug

# 查看API文档
# 访问 http://localhost:8000/docs (Swagger UI)
# 访问 http://localhost:8000/redoc (ReDoc)

# 检查异步操作
python -c "import asyncio; print('AsyncIO OK')"
```

#### **数据库问题**
```bash
# 检查数据库连接
python -c "from app.core.database import engine; print('DB OK')"

# Alembic迁移问题
alembic current
alembic history
alembic downgrade -1
alembic upgrade head

# 重置数据库
python scripts/reset_db.py

# 检查SQLAlchemy
python -c "import sqlalchemy; print(sqlalchemy.__version__)"
```

#### **依赖注入问题**
```bash
# FastAPI依赖调试
# 检查依赖循环
# 使用 Depends() 正确注入
# 避免在全局作用域定义依赖

# 异步依赖问题
# 确保异步函数使用 async def
# 在异步依赖中使用 await

# 依赖缓存问题
# FastAPI会缓存相同的依赖结果
# 使用 use_cache=False 禁用缓存
```

#### **性能问题**
```bash
# 异步操作调试
python -m pytest tests/ -v -s --tb=short

# 数据库查询分析
# 启用SQLAlchemy日志
import logging
logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)

# 内存使用分析
python -m memory_profiler app/main.py

# 并发测试
ab -n 1000 -c 10 http://localhost:8000/api/v1/users/

# 异步性能测试
python -m pytest tests/test_performance.py -v
```

#### **部署问题**
```bash
# Docker构建问题
docker build --no-cache -t myapp .
docker logs <container_id>

# 生产环境配置
export ENVIRONMENT=production
export DATABASE_URL=postgresql://...

# Gunicorn配置
gunicorn app.main:app \
  --workers 4 \
  --worker-class uvicorn.workers.UvicornWorker \
  --bind 0.0.0.0:8000 \
  --log-level info

# 健康检查
curl http://localhost:8000/health
```

---

## 🚀 **开始Python Web智能开发之旅**

智能Claude Autopilot 2.1专为Python Web开发优化！

**直接描述您的Web应用需求**，系统会自动选择最适合的开发模式：

- REST API → 基于FastAPI的高性能异步API架构
- 全栈应用 → 前后端分离的现代Web应用
- 微服务 → 容器化的可扩展微服务架构
- 数据API → 高性能的数据处理和分析API

**享受Python生态的现代化Web开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Python Web项目优化*