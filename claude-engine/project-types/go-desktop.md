# CLAUDE.md - Go桌面应用智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Go桌面应用项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Go桌面应用项目
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

### **🖥️ Go桌面应用开发特色功能**

#### **GUI框架优化**
- **Fyne框架集成**: 现代化的跨平台GUI开发
- **Walk框架支持**: Windows原生GUI应用开发
- **响应式设计**: 自适应布局和界面组件
- **主题系统**: 自定义主题和深色模式支持

#### **桌面应用特性**
- **系统集成**: 系统托盘、通知、快捷键支持
- **文件操作**: 文件对话框、拖拽、文件关联
- **多窗口管理**: 窗口状态保存、多显示器支持
- **本地数据存储**: SQLite、JSON配置文件管理

#### **跨平台部署**
- **Windows打包**: exe文件生成和MSI安装包
- **macOS打包**: app bundle和DMG镜像制作
- **Linux打包**: AppImage、deb、rpm包管理
- **自动更新**: 应用程序自动更新机制

#### **标准桌面应用项目结构支持**
```
go-desktop项目/
├── cmd/
│   └── app/
│       └── main.go              # 应用程序入口
├── internal/
│   ├── ui/
│   │   ├── windows/             # 窗口组件
│   │   ├── widgets/             # 自定义组件
│   │   └── themes/              # 主题定义
│   ├── logic/                   # 业务逻辑
│   ├── storage/                 # 数据存储
│   └── config/                  # 配置管理
├── pkg/
│   ├── utils/                   # 工具函数
│   └── models/                  # 数据模型
├── assets/
│   ├── icons/                   # 图标资源
│   ├── images/                  # 图片资源
│   └── fonts/                   # 字体文件
├── build/
│   ├── windows/                 # Windows构建脚本
│   ├── macos/                   # macOS构建脚本
│   └── linux/                   # Linux构建脚本
├── configs/                     # 配置文件模板
├── docs/                        # 文档
├── Makefile                     # 构建脚本
├── fyne-bundle.json            # Fyne资源配置
└── go.mod                      # Go模块文件
```

#### **智能构建和打包**
```bash
# 本地开发运行
make dev

# 资源文件打包
make bundle

# 跨平台构建
make build-all

# Windows构建
make build-windows

# macOS构建
make build-macos

# Linux构建
make build-linux

# 创建安装包
make package

# 运行测试
make test

# 查看帮助
make help
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: 桌面应用架构设计和用户体验优化
- **context7**: 动态获取Fyne、Walk等GUI框架最新文档
- **memory**: 桌面应用开发经验自动复用和设计模式
- **puppeteer**: 自动化UI测试（通过截图对比）

#### **全局规则遵守**
- **Go代码规范**: 自动应用gofmt、golint规则和GUI最佳实践
- **UI设计规范**: 一致的界面风格和用户体验准则
- **跨平台兼容**: 确保在不同操作系统下的一致性
- **性能优化**: 内存管理、CPU使用优化

#### **桌面应用专项智能特性**
- **UI组件设计**: 基于平台规范的界面组件选择
- **用户体验优化**: 交互流程和响应式设计建议
- **性能分析**: GUI渲染性能和资源使用优化
- **打包优化**: 应用体积优化和依赖管理

### **📋 桌面应用开发建议**

#### **开始开发**
1. 描述应用需求，如："创建图片管理桌面应用"
2. 系统会自动设计应用架构和界面布局
3. 生成符合平台规范的桌面应用代码

#### **界面开发**
1. 说明界面需求，如："创建设置对话框"
2. 系统会自动选择合适的GUI组件和布局
3. 确保界面设计符合各平台设计规范

#### **功能实现**
1. 描述功能需求，如："实现文件拖拽功能"
2. 系统会使用最佳实践实现桌面应用特性
3. 自动处理跨平台兼容性问题

### **🔧 开发工具集成**

#### **GUI开发工具**
- **Fyne**: 现代跨平台GUI框架
- **Walk**: Windows原生GUI开发
- **GoQt**: Qt绑定的跨平台解决方案
- **Wails**: Web技术构建桌面应用

#### **构建和打包工具**
- **fyne package**: Fyne应用打包工具
- **go-winres**: Windows资源文件处理
- **create-dmg**: macOS DMG镜像制作
- **AppImage**: Linux便携应用打包

#### **测试和调试**
- **go test**: 单元测试
- **Delve**: Go调试器
- **Memory Profiler**: 内存分析工具
- **CPU Profiler**: 性能分析工具

#### **设计和资源**
- **Figma**: UI设计工具
- **IconFinder**: 图标资源
- **Google Fonts**: 字体资源
- **Unsplash**: 免费图片资源

### **📈 效率提升**

相比传统桌面应用开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: GUI组件和布局自动生成，提升3-5倍效率
- 🎯 **界面质量**: 基于平台设计规范的专业界面
- 🔄 **跨平台一致**: 自动处理平台差异和兼容性
- 📦 **打包简化**: 一键生成各平台安装包
- 🧠 **用户体验**: AI辅助的交互设计优化

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **构建问题**
```bash
# 清理构建缓存
make clean

# 检查依赖
go mod tidy

# 重新构建
make build

# 查看构建日志
make build-verbose
```

#### **GUI问题**
```bash
# 检查GUI框架版本
go list -m fyne.io/fyne/v2

# 测试GUI组件
make test-ui

# 资源文件检查
make bundle-check
```

#### **打包问题**
```bash
# 检查打包工具
fyne version

# 清理打包缓存
make package-clean

# 重新打包
make package-rebuild
```

---

## 🚀 **开始桌面应用智能开发之旅**

智能Claude Autopilot 2.1专为Go桌面应用开发优化！

**直接描述您的桌面应用开发需求**，系统会自动选择最适合的开发模式：

- 应用架构 → 自动设计桌面应用整体架构
- 界面设计 → 智能生成符合平台规范的GUI
- 功能实现 → 基于最佳实践的功能开发
- 跨平台打包 → 一键生成各平台安装包

**享受现代化桌面应用的一次性成功开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Go桌面应用项目优化*