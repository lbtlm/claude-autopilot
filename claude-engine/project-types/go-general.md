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

#### **Go语言优化**
- **并发模式智能分析**: 自动识别goroutine和channel使用场景
- **性能优化建议**: 基于Go最佳实践的性能调优
- **内存管理分析**: 智能检测内存泄漏和GC优化机会
- **依赖管理**: go.mod依赖分析和版本管理建议

#### **标准项目结构支持**
```
项目结构/
├── cmd/           # 应用程序入口点
├── internal/      # 内部包（不对外暴露）
├── pkg/           # 公共库包
├── api/           # API定义文件
├── configs/       # 配置文件
├── scripts/       # 构建和部署脚本
├── test/          # 测试文件
├── docs/          # 文档
├── examples/      # 示例代码
├── go.mod         # Go模块文件
├── go.sum         # 依赖锁定文件
├── Makefile       # 构建脚本
└── README.md      # 项目说明
```

#### **智能构建和测试**
```bash
# 构建项目
make build

# 运行项目  
make run

# 运行测试
make test

# 代码检查
make lint

# 格式化代码
make fmt

# 查看帮助
make help
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

#### **质量保证工具**
- **golangci-lint**: 代码质量检查
- **go test**: 单元测试和基准测试
- **go vet**: 代码静态分析
- **gofmt**: 代码格式化

#### **性能分析工具**
- **go tool pprof**: 性能分析
- **go tool trace**: 执行追踪
- **benchstat**: 基准测试分析

### **📈 效率提升**

相比传统Go开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 提升3-5倍，专注业务逻辑
- 🎯 **代码质量**: 符合Go最佳实践的A级代码
- 🚀 **并发性能**: 智能优化的goroutine和channel设计
- 🧠 **模式复用**: Go惯用法和设计模式自动应用
- 🔒 **安全保证**: 并发安全和错误处理完善

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

# 更新依赖
go mod tidy
```

#### **性能问题**
```bash
# 性能分析
go tool pprof -http=:8080 cpu.prof

# 内存分析
go tool pprof -http=:8080 mem.prof
```

---

## 🚀 **开始Go智能开发之旅**

智能Claude Autopilot 2.1专为Go开发优化！

**直接描述您的Go开发需求**，系统会自动选择最适合的Go开发模式：

- 功能开发 → 自动应用Go设计模式和最佳实践
- 性能优化 → 智能分析并发模型和内存使用
- 代码重构 → 基于Go惯用法的代码优化

**享受符合Go哲学的一次性成功开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Go项目优化*