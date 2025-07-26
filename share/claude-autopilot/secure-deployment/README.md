# 统一安全部署模板

## 🎯 概述

这套安全部署模板为不同类型的项目提供零源码泄露的Docker部署方案，确保在保护源代码安全的同时实现高效的自动化部署。

## 📁 模板文件说明

### 核心模板
- `secure-deploy.sh` - 统一安全部署脚本，支持所有项目类型
- `docker-compose.template.yml` - 多服务部署配置模板

### Dockerfile模板
- `Dockerfile.gin-microservice` - Go 1.24 + Gin微服务（多阶段构建，scratch基础镜像）
- `Dockerfile.vue3-frontend` - Vue3前端项目（Node.js构建 + Nginx服务）
- `Dockerfile.fastapi-vue3` - FastAPI+Vue3全栈项目（前后端分离构建）

## 🔒 安全特性

### 零源码泄露设计
- ✅ 多阶段Docker构建，最终镜像不包含源代码
- ✅ 使用scratch/alpine基础镜像，最小化攻击面
- ✅ 构建阶段和运行阶段完全隔离
- ✅ 自动验证镜像中是否包含源码文件

### 动态配置支持
- ✅ 支持HOST和PORT环境变量动态配置
- ✅ 多环境配置（staging/production）
- ✅ 环境变量优先级：命令行参数 > 环境变量 > 配置文件 > 默认值

### 安全检查机制
- ✅ Go项目：gosec安全扫描 + 依赖漏洞检查
- ✅ 镜像安全：trivy漏洞扫描
- ✅ 构建过程：确保无源码泄露
- ✅ 部署验证：健康检查 + 功能验证

## 🚀 使用方法

### 1. 新项目创建
```bash
# 创建新项目时会自动注入安全部署模板
./scripts/new_project.sh my-gin-api gin-microservice
```

### 2. 现有项目注入
```bash
# 为现有项目注入安全部署配置
./scripts/inject_project.sh /path/to/existing/project
```

### 3. 项目部署
```bash
# 部署到测试环境
./deployments/secure-deploy.sh my-project staging

# 部署到生产环境（指定端口）
./deployments/secure-deploy.sh my-project production v1.0.0 8080
```

## 📋 支持的项目类型

### Web服务项目（支持Docker部署）
1. **gin-microservice** - Go 1.24 + Gin框架微服务
   - 使用scratch基础镜像
   - 静态链接二进制文件
   - 支持健康检查端点

2. **vue3-frontend** - Vue3前端项目
   - Node.js构建 + Nginx服务
   - 静态文件服务
   - SPA路由支持

3. **fastapi-vue3** - FastAPI+Vue3全栈项目
   - 前后端分离构建
   - Python Alpine基础镜像
   - 集成前端静态文件服务

### 桌面应用项目（使用原生打包）
1. **python-desktop** - Python tkinter桌面应用
   - 使用PyInstaller打包
   - 无需Docker部署

2. **go-desktop** - Go原生桌面应用
   - 直接编译为可执行文件
   - 无需Docker部署

## ⚙️ 环境变量配置

### 必需变量
```bash
# Docker Hub配置
DOCKER_REGISTRY=your-dockerhub-username
DOCKER_HUB_TOKEN=your-access-token

# 服务器配置
STAGING_HOST=staging.example.com
PRODUCTION_HOST=prod.example.com
```

### 可选变量
```bash
# 应用配置
HOST=0.0.0.0          # 监听地址
PORT=8080              # 监听端口
ENV=staging            # 环境标识

# 数据库配置（FastAPI项目）
DB_HOST=localhost
DB_PORT=5432
DB_NAME=your_db
DB_USER=your_user
DB_PASSWORD=your_password
```

## 🔧 自定义配置

### 端口配置优先级
1. 命令行参数：`./secure-deploy.sh project env version 9000`
2. 环境变量：`PORT=9000`
3. 配置文件：`.env.staging` 中的 `PORT=9000`
4. 默认值：`8080`（staging）/ `80`（production）

### 添加新项目类型
1. 创建对应的Dockerfile模板：`Dockerfile.new-type`
2. 更新 `inject_secure_deployment()` 函数
3. 添加环境变量配置模板

## 📊 部署流程

```
开始部署
    ↓
安全检查阶段
├── Git状态检查
├── 代码安全扫描（gosec）
└── 依赖漏洞检查
    ↓
构建阶段
├── 清理旧构建
├── 多阶段Docker构建
└── 动态配置注入
    ↓
安全验证阶段
├── 镜像内容验证
├── 源码泄露检查
└── 漏洞扫描（trivy）
    ↓
推送阶段
├── Docker Hub登录
└── 镜像推送
    ↓
部署阶段
├── 远程服务器部署
├── 容器健康检查
└── 应用功能验证
    ↓
部署完成
```

## 📝 最佳实践

### 安全建议
1. **定期更新**：保持基础镜像和依赖的最新版本
2. **密钥管理**：使用环境变量或密钥管理服务，避免硬编码
3. **访问控制**：配置防火墙和网络策略
4. **监控告警**：部署监控和日志收集系统

### 性能优化
1. **镜像缓存**：合理利用Docker层缓存
2. **资源限制**：配置容器资源限制
3. **健康检查**：设置合适的健康检查间隔
4. **日志管理**：配置日志轮转和清理策略

### 运维建议
1. **版本管理**：使用语义化版本号
2. **回滚策略**：保留多个版本以便快速回滚
3. **备份恢复**：定期备份数据和配置
4. **文档维护**：及时更新部署文档和操作手册

---

**创建时间**: $(date '+%Y-%m-%d %H:%M:%S')
**模板版本**: v2.0
**Go版本**: 1.24
**支持特性**: 动态端口配置、零源码泄露、统一安全部署