# Go桌面应用项目规范

## 📋 项目特征

- **适用场景**: 跨平台桌面应用、系统工具、企业内部软件、原生GUI应用
- **技术栈**: Go 1.22+ + Fyne 2.5/Wails 3.0 + SQLite + 现代GUI框架
- **开发模式**: 原生性能 + 单一代码库跨平台 + Material Design/Web UI
- **部署方式**: 🚀 单一可执行文件 + 系统安装包 + 应用商店分发
- **特点**: 高性能、零依赖、跨平台、现代UI、95%桌面应用覆盖

## 🔧 2025年技术栈标准

### **现代Go桌面开发特性**

**Go 1.22+ 最新特性 (基于官方文档)**
- **Go 1.22+** - 改进的性能和内存管理
- **原生跨平台** - 单一代码库支持Windows、macOS、Linux
- **现代GUI框架** - Fyne 2.5、Wails 3.0成熟稳定
- **零依赖部署** - 静态编译，无需运行时环境

**GUI框架选择 (基于2025年生态状况)**
- **Fyne 2.5+** - Material Design风格，活跃维护
- **Wails 3.0+** - HTML/CSS/JS + Go后端，现代Web UI
- **Gio UI** - 即时模式GUI，轻量级高性能  
- **原生绑定** - 仅在特殊需求时考虑

### **框架依赖配置 (go.mod)**

**Fyne项目依赖**
```go
module myapp

go 1.22

require (
    fyne.io/fyne/v2 v2.5.0
    github.com/mattn/go-sqlite3 v1.14.22
    github.com/golang-migrate/migrate/v4 v4.17.0
)

require (
    fyne.io/systray v1.11.0 // 系统托盘
    github.com/gen2brain/beeep v0.0.0-20230907135156-1a38885e97fc // 通知
    github.com/spf13/viper v1.18.2 // 配置管理
)
```

**Wails项目依赖**
```go
module myapp

go 1.22

require (
    github.com/wailsapp/wails/v2 v2.9.0
    context
    github.com/mattn/go-sqlite3 v1.14.22
)
```

## 🏗️ 通用标准项目结构（基于Go官方最佳实践）

```
go-desktop项目/
├── cmd/
│   └── app/
│       └── main.go                  # 🚀 应用程序入口 (Go标准layout)
├── internal/                        # 🔒 内部包 (Go 1.4+推荐)
│   ├── ui/                          # 🎨 用户界面层
│   │   ├── windows/                 # 窗口组件
│   │   │   ├── main_window.go       # 主窗口
│   │   │   ├── settings.go          # 设置窗口
│   │   │   └── about.go             # 关于对话框
│   │   ├── components/              # UI组件库
│   │   │   ├── toolbar.go           # 工具栏
│   │   │   ├── statusbar.go         # 状态栏
│   │   │   └── widgets.go           # 自定义组件
│   │   └── themes/                  # 主题系统
│   │       ├── light.go
│   │       └── dark.go
│   ├── app/                         # 🧠 应用核心
│   │   ├── config/                  # 配置管理
│   │   │   └── config.go
│   │   ├── services/                # 业务服务
│   │   │   ├── file_service.go
│   │   │   └── data_service.go
│   │   └── handlers/                # 事件处理
│   │       └── events.go
│   └── storage/                     # 💾 数据存储
│       ├── sqlite.go                # SQLite数据库
│       └── models.go                # 数据模型
├── pkg/                             # 📦 可导出包
│   ├── models/                      # 公共数据模型
│   └── utils/                       # 工具函数
├── assets/                          # 📁 静态资源
│   ├── icons/                       # 图标资源
│   ├── images/                      # 图片资源
│   └── fonts/                       # 字体文件
├── build/                           # 🔨 构建脚本
│   ├── windows/
│   ├── macos/
│   └── linux/
├── scripts/                         # 📜 脚本文件
├── .gitignore                       # Git配置
├── go.mod                           # Go模块定义
├── go.sum                           # 依赖校验和
├── Makefile                         # 构建工具
├── app.toml                         # 应用配置
└── README.md                        # 项目文档
```

## 📝 核心代码文件示例

### **主应用入口 (cmd/app/main.go)**
```go
package main

import (
	"log"
	"myapp/internal/app"
	"myapp/internal/ui/windows"
	
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/widget"
)

func main() {
	// 创建应用实例
	myApp := app.New()
	myApp.SetIcon(app.LoadResourceFromPath("assets/icon.png"))
	
	// 初始化核心服务
	appCore := app.NewCore()
	if err := appCore.Initialize(); err != nil {
		log.Fatal("应用初始化失败:", err)
	}
	
	// 创建主窗口
	mainWindow := windows.NewMainWindow(myApp, appCore)
	mainWindow.ShowAndRun()
}
```

### **Fyne主窗口示例 (internal/ui/windows/main_window.go)**
```go
package windows

import (
	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/widget"
)

type MainWindow struct {
	app    fyne.App
	window fyne.Window
	core   *app.Core
}

func NewMainWindow(app fyne.App, core *app.Core) *MainWindow {
	window := app.NewWindow("我的Go桌面应用")
	window.Resize(fyne.NewSize(800, 600))
	window.SetMaster()
	
	mw := &MainWindow{
		app:    app,
		window: window,
		core:   core,
	}
	
	mw.setupUI()
	return mw
}

func (mw *MainWindow) setupUI() {
	// 创建菜单栏
	menuBar := mw.createMenuBar()
	
	// 创建工具栏
	toolbar := mw.createToolbar()
	
	// 创建主内容区域
	content := widget.NewLabel("欢迎使用Go桌面应用！")
	content.Alignment = fyne.TextAlignCenter
	
	// 创建状态栏
	statusBar := widget.NewLabel("就绪")
	
	// 组合布局
	layout := container.NewBorder(
		container.NewVBox(menuBar, toolbar), // 顶部
		statusBar,                           // 底部
		nil,                                 // 左侧
		nil,                                 // 右侧
		content,                             // 中心
	)
	
	mw.window.SetContent(layout)
}

func (mw *MainWindow) ShowAndRun() {
	mw.window.ShowAndRun()
}
```

```makefile
.PHONY: dev build test package clean help

APP_NAME = myapp
VERSION = 1.0.0

help:
	@echo "🚀 Go桌面应用开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  dev           - 启动开发环境"
	@echo "  test          - 运行测试"
	@echo ""
	@echo "🏗️  跨平台构建:"
	@echo "  build-all     - 所有平台构建"
	@echo "  build-windows - Windows构建"
	@echo "  build-macos   - macOS构建"
	@echo "  build-linux   - Linux构建"
	@echo ""
	@echo "📦 打包部署:"
	@echo "  package       - 创建安装包"
	@echo "  clean         - 清理构建文件"

dev:
	@echo "🚀 启动开发环境..."
	go run cmd/app/main.go

build-all: build-windows build-macos build-linux

build-windows:
	@echo "🪟 Windows构建..."
	GOOS=windows GOARCH=amd64 go build -o dist/$(APP_NAME)-windows.exe cmd/app/main.go

build-macos:
	@echo "🍎 macOS构建..."
	GOOS=darwin GOARCH=amd64 go build -o dist/$(APP_NAME)-macos cmd/app/main.go

build-linux:
	@echo "🐧 Linux构建..."
	GOOS=linux GOARCH=amd64 go build -o dist/$(APP_NAME)-linux cmd/app/main.go

test:
	@echo "🧪 运行测试..."
	go test -v ./...

package:
	@echo "📦 创建安装包..."
	fyne package -os windows -icon assets/icon.png
	
clean:
	@echo "🧹 清理构建文件..."
	rm -rf bin/ dist/
```

## 🚀 现代化开发流程

### **项目初始化**

```bash
# 1. 创建Go模块
go mod init myapp

# 2. 安装Fyne框架
go get fyne.io/fyne/v2/app
go get fyne.io/fyne/v2/widget

# 3. 创建项目结构
mkdir -p cmd/app internal/{ui,app,storage} pkg assets

# 4. 开始开发
make dev
```

### **开发工作流**

```bash
# 🔧 开发环境管理
make dev           # 启动开发环境
go run cmd/app/main.go  # 直接运行
go mod tidy        # 整理依赖

# 🧪 测试和质量检查
make test          # 运行所有测试
go test ./internal/... # 测试内部包
go vet ./...       # 代码检查

# 📦 构建和部署
make build-all     # 所有平台构建
make package       # 创建安装包
fyne bundle -o bundled.go icon.png  # 资源打包
```

---

**✨ 这个模板基于Go官方文档和2025年桌面应用最佳实践，为Go桌面项目提供完整的跨平台开发解决方案。**

### **开发依赖 (Fyne示例)**
```json
{
  "devDependencies": {
    "fyne": "fyne package tool for resource bundling",
    "go-bindata": "Asset embedding tool",
    "upx": "Executable compression tool",
    "nsis": "Windows installer creator", 
    "create-dmg": "macOS DMG creator",
    "appimage-builder": "Linux AppImage creator"
  }
}
```

## 📜 2025年标准化 Makefile

```makefile
.PHONY: install dev build test lint bundle package clean help

# 项目配置
PROJECT_NAME = myapp
BINARY_NAME = $(PROJECT_NAME)
VERSION = 1.0.0
BUILD_DIR = build
DIST_DIR = dist

# 平台检测
ifeq ($(OS),Windows_NT)
    PLATFORM = windows
    BINARY_EXT = .exe
    ICON_EXT = .ico
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        PLATFORM = linux
        BINARY_EXT = 
        ICON_EXT = .png
    endif
    ifeq ($(UNAME_S),Darwin)
        PLATFORM = darwin
        BINARY_EXT = 
        ICON_EXT = .icns
    endif
endif

help:
	@echo "🖥️ Go桌面应用项目开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  install       - 安装项目依赖"
	@echo "  dev           - 启动开发模式"
	@echo "  bundle        - 打包资源文件"
	@echo "  test          - 运行测试"
	@echo "  lint          - 代码质量检查"
	@echo ""
	@echo "🏗️  构建部署:"
	@echo "  build         - 构建当前平台"
	@echo "  build-all     - 构建所有平台"
	@echo "  build-windows - 构建Windows版本"
	@echo "  build-macos   - 构建macOS版本"  
	@echo "  build-linux   - 构建Linux版本"
	@echo ""
	@echo "📦 打包分发:"
	@echo "  package       - 创建安装包"
	@echo "  package-all   - 创建所有平台安装包"
	@echo "  release       - 创建发布版本"
	@echo ""
	@echo "🧹 维护:"
	@echo "  clean         - 清理构建文件"
	@echo "  health-check  - 项目健康检查"

install:
	@echo "📦 安装项目依赖..."
	go mod download
	go mod tidy
	@echo "✅ 依赖安装完成!"

dev:
	@echo "🚀 启动开发模式..."
	go run cmd/app/main.go

bundle:
	@echo "📦 打包资源文件..."
	fyne bundle -o internal/ui/resources.go assets/icon.png
	go generate ./...
	@echo "✅ 资源打包完成!"

test:
	@echo "🧪 运行测试..."
	go test -v ./...
	@echo "✅ 测试完成!"

lint:
	@echo "🔍 代码质量检查..."
	go fmt ./...
	go vet ./...
	golangci-lint run
	@echo "✅ 代码检查完成!"

build:
	@echo "🏗️ 构建当前平台..."
	mkdir -p $(BUILD_DIR)
	go build -ldflags="-s -w -X main.version=$(VERSION)" -o $(BUILD_DIR)/$(BINARY_NAME)$(BINARY_EXT) cmd/app/main.go
	@echo "✅ 构建完成!"

build-all: build-windows build-macos build-linux
	@echo "✅ 所有平台构建完成!"

build-windows:
	@echo "🏗️ 构建Windows版本..."
	mkdir -p $(BUILD_DIR)/windows
	GOOS=windows GOARCH=amd64 go build -ldflags="-s -w -X main.version=$(VERSION)" -o $(BUILD_DIR)/windows/$(BINARY_NAME).exe cmd/app/main.go
	@echo "✅ Windows构建完成!"

build-macos:
	@echo "🏗️ 构建macOS版本..."
	mkdir -p $(BUILD_DIR)/darwin
	GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w -X main.version=$(VERSION)" -o $(BUILD_DIR)/darwin/$(BINARY_NAME) cmd/app/main.go
	GOOS=darwin GOARCH=arm64 go build -ldflags="-s -w -X main.version=$(VERSION)" -o $(BUILD_DIR)/darwin/$(BINARY_NAME)-arm64 cmd/app/main.go
	@echo "✅ macOS构建完成!"

build-linux:
	@echo "🏗️ 构建Linux版本..."
	mkdir -p $(BUILD_DIR)/linux
	GOOS=linux GOARCH=amd64 go build -ldflags="-s -w -X main.version=$(VERSION)" -o $(BUILD_DIR)/linux/$(BINARY_NAME) cmd/app/main.go
	GOOS=linux GOARCH=arm64 go build -ldflags="-s -w -X main.version=$(VERSION)" -o $(BUILD_DIR)/linux/$(BINARY_NAME)-arm64 cmd/app/main.go
	@echo "✅ Linux构建完成!"

package:
	@echo "📦 创建安装包..."
	mkdir -p $(DIST_DIR)
ifeq ($(PLATFORM),windows)
	# Windows NSIS安装包
	makensis /DVERSION=$(VERSION) build/windows/installer.nsi
	mv build/windows/$(PROJECT_NAME)-$(VERSION).exe $(DIST_DIR)/
endif
ifeq ($(PLATFORM),darwin)
	# macOS应用包和DMG
	./build/macos/create-app-bundle.sh $(BUILD_DIR)/darwin/$(BINARY_NAME) $(VERSION)
	./build/macos/create-dmg.sh $(DIST_DIR)/$(PROJECT_NAME)-$(VERSION).dmg build/macos/$(PROJECT_NAME).app
endif
ifeq ($(PLATFORM),linux)
	# Linux AppImage
	./build/linux/create-appimage.sh $(BUILD_DIR)/linux/$(BINARY_NAME) $(VERSION)
	mv build/linux/$(PROJECT_NAME)-$(VERSION).AppImage $(DIST_DIR)/
endif
	@echo "✅ 安装包创建完成!"

package-all:
	@echo "📦 创建所有平台安装包..."
	$(MAKE) build-all
	# Windows
	makensis /DVERSION=$(VERSION) build/windows/installer.nsi
	mv build/windows/$(PROJECT_NAME)-$(VERSION).exe $(DIST_DIR)/
	# macOS  
	./build/macos/create-app-bundle.sh $(BUILD_DIR)/darwin/$(BINARY_NAME) $(VERSION)
	./build/macos/create-dmg.sh $(DIST_DIR)/$(PROJECT_NAME)-$(VERSION).dmg build/macos/$(PROJECT_NAME).app
	# Linux
	./build/linux/create-appimage.sh $(BUILD_DIR)/linux/$(BINARY_NAME) $(VERSION)
	mv build/linux/$(PROJECT_NAME)-$(VERSION).AppImage $(DIST_DIR)/
	@echo "✅ 所有平台安装包创建完成!"

release:
	@echo "🚀 创建发布版本..."
	$(MAKE) test
	$(MAKE) lint  
	$(MAKE) package-all
	@echo "✅ 发布版本创建完成!"

clean:
	@echo "🧹 清理构建文件..."
	rm -rf $(BUILD_DIR)
	rm -rf $(DIST_DIR)
	go clean -cache
	@echo "✅ 清理完成!"

health-check:
	@echo "🏥 项目健康检查..."
	go mod verify
	go vet ./...
	go test -short ./...
	@echo "✅ 健康检查完成!"

# 依赖管理
update-deps:
	@echo "⬆️ 更新依赖..."
	go get -u ./...
	go mod tidy
	@echo "✅ 依赖更新完成!"

# 代码生成
generate:
	@echo "🔄 生成代码..."
	go generate ./...
	@echo "✅ 代码生成完成!"
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