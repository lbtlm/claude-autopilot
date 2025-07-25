# CLAUDE.md - Gin微服务项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Gin微服务项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Gin微服务项目
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

### **🏗️ Gin微服务开发特色功能**

#### **微服务架构优化**
- **API设计智能分析**: 基于RESTful最佳实践的微服务API设计
- **中间件智能配置**: CORS、认证、日志、限流、熔断器自动配置
- **服务发现集成**: Consul、Etcd等服务注册发现机制
- **配置管理**: Viper配置管理和热重载

#### **数据层优化**
- **数据库操作优化**: GORM集成和SQL优化建议
- **缓存策略**: Redis缓存模式和数据一致性保证
- **事务管理**: 分布式事务和数据一致性处理
- **数据验证**: 请求参数验证和数据清洗

#### **微服务治理**
- **链路追踪**: Jaeger/Zipkin分布式追踪集成
- **监控告警**: Prometheus + Grafana监控体系
- **健康检查**: 服务健康状态监控和自动恢复
- **优雅关闭**: 服务平滑重启和资源清理

#### **标准微服务项目结构支持**
```
gin-microservice项目/
├── cmd/
│   └── server/
│       └── main.go          # 服务入口
├── internal/
│   ├── handler/             # HTTP处理器
│   ├── service/             # 业务逻辑层
│   ├── repository/          # 数据访问层
│   ├── middleware/          # 自定义中间件
│   └── config/              # 配置管理
├── pkg/
│   ├── logger/              # 日志组件
│   ├── database/            # 数据库连接
│   ├── redis/               # Redis客户端
│   └── utils/               # 工具函数
├── api/
│   └── proto/               # Protocol Buffers定义
├── migrations/              # 数据库迁移
├── docs/                    # API文档
├── deployments/             # 部署配置
├── docker-compose.yml       # 本地开发环境
├── Dockerfile              # 容器化配置
├── Makefile               # 构建脚本
└── go.mod                 # Go模块文件
```

#### **智能开发和部署**
```bash
# 本地开发
make dev

# 代码检查
make lint

# 运行测试
make test

# 构建服务
make build

# 容器化构建
make docker-build

# 部署到测试环境
make deploy-staging

# 部署到生产环境
make deploy-prod

# 查看帮助
make help
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: 微服务架构设计和性能优化分析
- **context7**: 动态获取Gin和微服务最新文档和最佳实践
- **memory**: 微服务开发经验自动复用和模式库
- **puppeteer**: API接口自动化测试和文档验证

#### **全局规则遵守**
- **Go代码规范**: 自动应用gofmt、golint规则和微服务最佳实践
- **API设计规范**: RESTful API设计和统一响应格式
- **安全规范**: JWT认证、CORS配置、SQL注入防护
- **微服务规范**: 服务拆分原则、接口幂等性、数据一致性

#### **微服务专项智能特性**
- **服务拆分建议**: 基于业务边界的智能服务拆分
- **接口设计优化**: API版本管理和向后兼容性
- **性能优化分析**: 数据库查询优化、缓存策略、并发处理
- **监控指标设计**: 关键业务指标和SLA监控

### **📋 微服务开发建议**

#### **开始开发**
1. 描述业务需求，如："实现用户认证微服务"
2. 系统会自动设计微服务架构和API接口
3. 生成符合微服务最佳实践的代码

#### **API开发**
1. 说明API需求，如："创建订单管理CRUD接口"
2. 系统会自动生成Gin路由、中间件和业务逻辑
3. 确保API设计符合RESTful规范和微服务原则

#### **性能优化**
1. 描述性能需求，如："优化订单查询接口性能"
2. 系统会分析数据库查询、缓存使用和并发处理
3. 提供基于最佳实践的优化方案

### **🔧 开发工具集成**

#### **代码质量保证**
- **golangci-lint**: Go代码质量检查
- **go test**: 单元测试和集成测试
- **testify**: 测试断言和Mock框架
- **go-sqlmock**: 数据库测试Mock

#### **API开发工具**
- **Swagger**: API文档自动生成
- **Postman**: API接口测试
- **Wire**: 依赖注入框架
- **Viper**: 配置管理

#### **微服务工具链**
- **Docker**: 容器化部署
- **Kubernetes**: 容器编排
- **Istio**: 服务网格
- **Helm**: Kubernetes包管理

#### **监控和运维**
- **Prometheus**: 指标收集
- **Grafana**: 监控面板
- **Jaeger**: 分布式追踪
- **ELK**: 日志收集和分析

### **📈 效率提升**

相比传统微服务开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 微服务模板和代码生成，提升5-8倍效率
- 🎯 **架构质量**: 基于最佳实践的微服务架构设计
- 🔒 **安全保证**: 自动应用安全最佳实践和漏洞检测
- 📊 **可观测性**: 内置监控、日志、追踪完整体系
- 🔄 **CI/CD集成**: 自动化构建、测试、部署流水线

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **服务启动问题**
```bash
# 检查配置文件
make config-check

# 检查依赖服务
make deps-check

# 查看服务日志
make logs

# 健康检查
make health-check
```

#### **数据库问题**
```bash
# 检查数据库连接
make db-ping

# 运行数据库迁移
make migrate

# 重置开发数据库
make db-reset-dev
```

#### **性能问题**
```bash
# 性能分析
make profile

# 查看metrics
make metrics

# 压力测试
make load-test
```

---

## 🚀 **开始微服务智能开发之旅**

智能Claude Autopilot 2.1专为Gin微服务开发优化！

**直接描述您的微服务开发需求**，系统会自动选择最适合的开发模式：

- 微服务设计 → 自动应用DDD领域驱动设计
- API开发 → 智能生成RESTful接口和文档
- 性能优化 → 数据库、缓存、并发优化建议
- 运维集成 → 监控、日志、追踪完整方案

**享受云原生微服务的一次性成功开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Gin微服务项目优化*