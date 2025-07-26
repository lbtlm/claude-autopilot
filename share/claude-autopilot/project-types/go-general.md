# CLAUDE.md - Go通用项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Go通用项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Go通用项目
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

### **🐹 Go开发特色功能**

#### **现代Go技术栈 (2025年标准)**

**核心技术栈**
- **Go 1.21+** - 最新稳定版本特性和泛型支持
- **数据库ORM** - GORM v1.25.x (PostgreSQL/MySQL/SQLite支持)
- **HTTP框架** - Gin/Echo/标准库/Fiber (灵活选择)
- **配置管理** - Viper配置文件和环境变量管理

**开发工具链**
- **代码检查** - golangci-lint v1.55+ (2025年最新规则)
- **测试框架** - Go标准库 + testify v1.8.x
- **容器化** - Docker + Docker Compose
- **构建工具** - Make + shell脚本自动化

**Go语言特性优化**
- **并发模式智能分析**: 自动识别goroutine和channel使用场景
- **性能优化建议**: 基于Go最佳实践的性能调优
- **内存管理分析**: 智能检测内存泄漏和GC优化机会
- **依赖管理**: go.mod依赖分析和版本管理建议

#### **通用标准项目结构（适用于所有Go项目）**

```
go-project/
├── cmd/                              # 🚀 主应用程序 (Go标准布局)
│   └── server/
│       └── main.go                   # 应用入口点
├── internal/                         # 🔒 私有应用代码 (Go编译器强制)
│   ├── handler/                      # HTTP处理器层
│   ├── service/                      # 业务逻辑层  
│   ├── repository/                   # 数据访问层
│   ├── model/                        # 数据模型定义
│   ├── middleware/                   # 中间件
│   └── config/                       # 配置管理
├── pkg/                             # 📦 可复用公共库 (可被外部导入)
│   ├── database/                    # 数据库连接和配置
│   ├── logger/                      # 日志组件
│   └── utils/                       # 工具函数
├── api/                             # 📋 API定义文件
│   └── openapi.yaml                 # OpenAPI 3.0规范
├── configs/                         # ⚙️ 配置文件
│   ├── config.yaml                  # 主配置文件
│   └── config.dev.yaml              # 开发环境配置
├── scripts/                         # 📜 构建和部署脚本
│   ├── build.sh                     # 构建脚本
│   └── migrate.sh                   # 数据库迁移脚本
├── migrations/                      # 🗃️ 数据库迁移文件
├── tests/                          # 🧪 测试文件
│   ├── integration/                 # 集成测试
│   └── unit/                       # 单元测试
├── deployments/                     # 🚀 部署配置
│   ├── docker-compose.yml           # 开发环境编排
│   ├── docker-compose.prod.yml      # 生产环境编排
│   └── Dockerfile                   # 容器构建文件
├── .golangci.yml                    # golangci-lint配置
├── go.mod                          # Go模块定义
├── go.sum                          # 依赖锁定文件
├── .env.example                    # 环境变量示例
├── .gitignore                      # Git忽略文件
├── .editorconfig                   # 编辑器配置
├── Makefile                        # 构建和开发工具
└── README.md                       # 项目文档
```

#### **智能构建和开发工作流**

```bash
# 核心开发命令
make build                        # 构建项目生成可执行文件
make run                          # 运行项目 (开发模式)
make test                         # 运行所有测试 (包含竞态检测)
make lint                         # 代码质量检查 (golangci-lint)
make fmt                          # 代码格式化 (go fmt + goimports)
make tidy                         # 清理和更新依赖

# 高级命令
make docker                       # 构建 Docker 镜像
make deploy-dev                   # 部署到开发环境
make migrate                      # 数据库迁移
make test-integration             # 运行集成测试
make clean                        # 清理构建文件
make help                         # 查看所有可用命令
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: 复杂Go架构设计和并发模式分析
- **context7**: 动态获取Go最新文档和最佳实践
- **memory**: Go开发经验自动复用和模式库
- **filesystem**: Go代码结构智能分析

#### **全局规则遵守**
- **Go代码规范**: 自动应用gofmt、golint规则
- **并发安全**: 自动检测race condition和死锁风险
- **API设计**: 遵循Go interface设计原则
- **错误处理**: 符合Go error handling最佳实践

#### **Go专项智能特性**
- **接口设计智能建议**: 基于Go惯用法的interface设计
- **并发模式智能实现**: goroutine和channel最佳实践应用
- **包结构智能优化**: 符合Go项目布局标准
- **测试策略智能生成**: 表驱动测试和benchmark优化

### **📋 Go开发建议**

#### **开始开发**
1. 描述功能需求，如："实现用户认证中间件"
2. 系统会自动选择合适的Go设计模式
3. 生成符合Go惯用法的代码实现

#### **性能优化**
1. 说明优化目标，如："优化API响应时间"
2. 系统会分析goroutine使用、内存分配等
3. 提供基于Go性能最佳实践的优化方案

#### **并发编程**
1. 描述并发需求，如："处理大量并发请求"
2. 系统会智能设计goroutine池和channel通信
3. 确保并发安全和性能最优

### **🔧 开发工具集成**

#### **核心配置文件示例**

**go.mod 现代依赖配置:**
```go
module myproject

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    gorm.io/gorm v1.25.5
    gorm.io/driver/postgres v1.5.4
    github.com/spf13/viper v1.18.2
    github.com/stretchr/testify v1.8.4
)
```

**Makefile 2025年标准工作流:**
```makefile
.PHONY: build test lint fmt tidy run clean docker

BINARY_NAME=myproject

build:
	go build -o bin/$(BINARY_NAME) cmd/server/main.go

test:
	go test ./... -race -coverprofile=coverage.out

lint:
	golangci-lint run --enable-all --timeout 5m

fmt:
	go fmt ./...
	goimports -w .

tidy:
	go mod tidy

run:
	go run cmd/server/main.go

clean:
	rm -rf bin/

docker:
	docker build -t $(BINARY_NAME) .
```

#### **2025年开发工具集成**

**质量保证工具**
- **golangci-lint v1.55+**: 最新代码质量检查器
- **testify v1.8.x**: 现代测试框架和断言库
- **go test**: 内置单元测试和基准测试
- **go vet**: 代码静态分析工具

**性能分析工具**
- **go tool pprof**: CPU和内存性能分析
- **go tool trace**: 并发执行追踪分析
- **benchstat**: 基准测试结果对比分析

### **📈 效率提升**

相比传统Go开发，基于2025年最佳实践的智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 提升3-5倍，专注业务逻辑开发
- 🎯 **代码质量**: 遵循Go官方标准和社区最佳实践的A级代码
- 🚀 **现代架构**: 基于golang-standards/project-layout的标准化架构
- 🧠 **模式复用**: Go惯用法和设计模式自动应用
- 🔧 **工具链集成**: golangci-lint v1.55+, GORM v1.25.x, Docker现代工作流
- 🔒 **安全保证**: 并发安全和错误处理完善

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **构建和依赖问题**
```bash
# 清理并重新构建
make clean && make build

# 更新和清理依赖
go mod tidy
go mod download

# 检查模块状态
go list -m all
```

#### **代码质量问题**
```bash
# 全面代码检查
make lint

# 修复格式问题
make fmt

# 检查模块整体性
go vet ./...
```

#### **性能分析问题**
```bash
# CPU性能分析
go tool pprof -http=:8080 cpu.prof

# 内存分析
go tool pprof -http=:8080 mem.prof

# 并发竞态检测
go test -race ./...
```

---

## 🚀 **开始Go智能开发之旅**

智能Claude Autopilot 2.1专为Go开发优化，遵循Go官方标准和2025年最佳实践！

**直接描述您的Go开发需求**，系统会自动选择最适合的开发模式：

- 功能开发 → 基于golang-standards/project-layout的标准化架构
- 性能优化 → 智能分析并发模型和内存使用
- 代码重构 → 基于Go惯用法和golangci-lint v1.55+的代码优化
- 数据库集成 → GORM v1.25.x + PostgreSQL/MySQL/SQLite现代配置

**享受符合Go哲学和2025年标准的一次性成功开发体验！** ✨

### **🎆 项目快速启动**

```bash
# 1. 初始化Go模块
go mod init myproject

# 2. 创建标准项目结构
mkdir -p cmd/server internal/{handler,service,repository,model,middleware,config} \
         pkg/{database,logger,utils} api configs scripts migrations \
         tests/{integration,unit} deployments

# 3. 创建主程序入口
echo 'package main\n\nfunc main() {\n\tprintln("Hello, Go 2025!")\n}' > cmd/server/main.go

# 4. 设置开发环境
make dev-setup

# 5. 开始智能开发
# 在Claude Code中描述您的需求，享受AI驱动的开发体验！
```

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Go项目优化*