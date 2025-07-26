# CLAUDE.md - Rust项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Rust项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Rust项目
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

### **🦀 Rust开发特色功能**

#### **Rust核心特性**
- **内存安全**: 零成本抽象和编译时内存安全保证
- **并发编程**: 无数据竞争的安全并发和异步编程
- **系统编程**: 接近C性能的系统级编程能力
- **跨平台**: 支持多种架构和操作系统的原生编译

#### **现代Rust生态**
- **Cargo工具链**: 包管理、构建、测试、文档一体化
- **异步编程**: tokio、async-std响应式编程框架
- **Web开发**: actix-web、axum、warp高性能Web框架
- **系统工具**: CLI工具、网络服务、嵌入式开发

#### **性能和安全**
- **零成本抽象**: 高级特性不牺牲运行时性能
- **所有权系统**: 编译时防止内存泄漏和悬挂指针
- **类型系统**: 强大的类型系统和模式匹配
- **WASM支持**: 编译到WebAssembly的一流支持

#### **标准Rust项目结构支持**
```
rust-project/
├── src/
│   ├── bin/                     # 二进制目标
│   │   └── cli.rs               # 命令行工具
│   ├── lib.rs                   # 库入口
│   ├── main.rs                  # 主程序入口
│   ├── modules/                 # 模块
│   │   ├── config.rs            # 配置模块
│   │   ├── error.rs             # 错误处理
│   │   ├── utils.rs             # 工具函数
│   │   └── mod.rs               # 模块声明
│   └── tests/                   # 单元测试
├── tests/                       # 集成测试
│   ├── integration_test.rs      # 集成测试
│   └── common/                  # 测试公共代码
│       └── mod.rs
├── examples/                    # 示例代码
│   ├── basic_usage.rs           # 基础用法
│   └── advanced_usage.rs        # 高级用法
├── benches/                     # 基准测试
│   └── benchmark.rs             # 性能基准
├── docs/                        # 项目文档
├── scripts/                     # 脚本文件
├── target/                      # 构建输出
│   ├── debug/                   # Debug构建
│   ├── release/                 # Release构建
│   └── doc/                     # 文档输出
├── .cargo/                      # Cargo配置
│   └── config.toml              # 本地配置
├── Cargo.toml                   # 项目配置
├── Cargo.lock                   # 依赖锁定
├── build.rs                     # 构建脚本
├── .gitignore                   # Git忽略文件
├── README.md                    # 项目说明
├── LICENSE                      # 许可证
└── CHANGELOG.md                 # 变更日志
```

#### **智能开发和构建**
```bash
# 创建新项目
cargo new my_project
cargo new my_library --lib

# 构建项目
cargo build
cargo build --release

# 运行项目
cargo run
cargo run --bin cli_tool

# 运行测试
cargo test
cargo test --lib
cargo test --integration-test integration_test

# 运行基准测试
cargo bench

# 检查代码
cargo check
cargo clippy

# 格式化代码
cargo fmt

# 生成文档
cargo doc
cargo doc --open

# 发布包
cargo publish

# 更新依赖
cargo update

# 安装工具
cargo install cargo-watch
cargo install cargo-expand
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: Rust系统架构设计和并发模式分析
- **context7**: 动态获取Rust生态最新文档和最佳实践
- **memory**: Rust开发经验自动复用和所有权模式库
- **puppeteer**: Rust Web应用自动化测试和性能监控

#### **全局规则遵守**
- **Rust代码规范**: 自动应用Rust官方风格指南和最佳实践
- **所有权系统**: 内存安全和借用检查器的正确使用
- **错误处理**: Result和Option类型的习惯用法
- **并发安全**: Send和Sync trait的正确理解和应用

#### **Rust专项智能特性**
- **所有权模式**: 借用、生命周期、智能指针的最佳实践
- **错误处理**: ? 操作符、自定义错误类型、错误传播
- **异步编程**: async/await、Future、Stream的正确使用
- **性能优化**: 零分配算法、SIMD、内存布局优化

### **📋 Rust开发建议**

#### **开始开发**
1. 描述项目需求，如："创建高性能Web API服务"
2. 系统会自动选择合适的框架和架构模式
3. 生成符合Rust最佳实践的项目结构

#### **系统编程**
1. 说明系统需求，如："实现并发文件处理工具"
2. 系统会设计安全的并发模式和错误处理
3. 确保内存安全和最佳性能

#### **Web开发**
1. 描述Web应用需求，如："创建RESTful API服务"
2. 系统会选择合适的异步Web框架
3. 实现高性能的请求处理和数据序列化

### **🔧 开发工具集成**

#### **开发环境**
- **Rust 1.70+**: 稳定版Rust工具链
- **Cargo**: 官方包管理和构建工具
- **rustup**: Rust工具链版本管理
- **IDE支持**: VSCode、IntelliJ IDEA、Vim/Neovim

#### **代码质量**
- **clippy**: Rust官方代码检查工具
- **rustfmt**: 自动代码格式化
- **cargo-audit**: 安全漏洞扫描
- **cargo-deny**: 依赖和许可证检查

#### **测试框架**
- **内置测试**: Rust标准库测试支持
- **proptest**: 属性基础测试
- **criterion**: 微基准测试框架
- **mockall**: Mock对象生成

#### **开发工具**
- **cargo-watch**: 文件变化自动重新构建
- **cargo-expand**: 宏展开查看
- **cargo-tree**: 依赖树可视化
- **cargo-udeps**: 未使用依赖检测

### **📈 效率提升**

相比传统系统编程，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: Rust项目结构和常用模式自动生成，提升3-4倍效率
- 🎯 **安全质量**: 编译时内存安全保证和并发安全检查
- 🔄 **模式复用**: 智能的所有权模式和错误处理策略
- 📊 **性能优化**: 零成本抽象和编译器优化指导
- 🧪 **测试覆盖**: 自动生成单元测试、集成测试和基准测试

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **Rust工具链问题**
```bash
# 检查Rust版本
rustc --version
cargo --version

# 更新Rust工具链
rustup update

# 检查已安装工具链
rustup show

# 设置默认工具链
rustup default stable

# 安装特定工具链
rustup install nightly
rustup default nightly

# 检查组件
rustup component list
```

#### **编译问题**
```bash
# 清理构建缓存
cargo clean

# 详细编译输出
cargo build --verbose

# 检查代码不编译
cargo check

# 显示编译器版本
rustc --version --verbose

# 解释编译错误
rustc --explain E0308

# 使用不同版本编译
cargo +nightly build
```

#### **依赖问题**
```bash
# 查看依赖树
cargo tree

# 更新依赖
cargo update

# 添加依赖
cargo add tokio

# 移除依赖
cargo remove tokio

# 检查过时依赖
cargo outdated

# 审计安全漏洞
cargo audit

# 检查未使用依赖
cargo udeps
```

#### **测试问题**
```bash
# 运行所有测试
cargo test

# 运行特定测试
cargo test test_name

# 显示测试输出
cargo test -- --nocapture

# 运行忽略的测试
cargo test -- --ignored

# 单线程运行测试
cargo test -- --test-threads=1

# 运行文档测试
cargo test --doc

# 生成测试覆盖率
cargo tarpaulin
```

#### **性能问题**
```bash
# Release模式构建
cargo build --release

# 运行基准测试
cargo bench

# 性能分析
perf record cargo run --release
perf report

# 内存分析
valgrind --tool=memcheck cargo run

# 代码大小分析
cargo bloat --release

# 编译时间分析
cargo build -Z timings
```

#### **异步编程问题**
```bash
# 检查async依赖
grep -r "async" Cargo.toml

# Tokio运行时调试
RUST_LOG=tokio=debug cargo run

# 异步栈跟踪
cargo install tokio-console
RUSTFLAGS="--cfg tokio_unstable" cargo run

# 死锁检测
cargo install parking_lot
# 使用parking_lot::Mutex替代std::sync::Mutex
```

---

## 🚀 **开始Rust智能开发之旅**

智能Claude Autopilot 2.1专为Rust开发优化！

**直接描述您的Rust项目需求**，系统会自动选择最适合的开发模式：

- 系统工具 → 高性能CLI工具和系统服务
- Web服务 → 异步Web API和微服务架构
- 网络编程 → 高并发网络服务和协议实现
- 嵌入式开发 → no_std环境和实时系统

**享受Rust的内存安全和极致性能！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Rust项目优化*