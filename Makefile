# Claude Autopilot 2.1 - Makefile
# 版本: 2.1.0
# 项目: 智能开发环境自动配置工具

# 基本变量
VERSION := 2.1.0
BUILD_DIR := build
INSTALL_PREFIX := /usr/local
BIN_DIR := $(INSTALL_PREFIX)/bin
CONFIG_DIR := $(INSTALL_PREFIX)/share/claude-ce
LIB_DIR := $(INSTALL_PREFIX)/lib/claude-ce

# 脚本文件
MAIN_SCRIPT := bin/claude-autopilot
SETUP_SCRIPT := bin/setup.sh
QUICK_SETUP_SCRIPT := bin/quick-setup.sh
SCRIPTS := $(wildcard bin/*.sh lib/*.sh)
UTILS := $(wildcard lib/*.sh)
CONFIGS := $(wildcard share/claude-autopilot/**/*.md)

# 默认目标
.PHONY: all
all: lint test

# 代码质量检查
.PHONY: lint
lint:
	@echo "🔍 运行ShellCheck代码检查..."
	@if command -v shellcheck >/dev/null 2>&1; then \
		echo "使用ShellCheck进行静态分析..."; \
		shellcheck bin/claude-autopilot || echo "⚠️ claude-autopilot 有警告"; \
		for file in lib/*.sh; do \
			shellcheck "$$file" || echo "⚠️ $$file 有警告"; \
		done; \
		for file in bin/*.sh; do \
			shellcheck "$$file" || echo "⚠️ $$file 有警告"; \
		done; \
		echo "✅ ShellCheck检查完成"; \
	else \
		echo "⚠️  ShellCheck未安装，跳过静态分析"; \
		echo "   安装方法: sudo apt install shellcheck  # Ubuntu/Debian"; \
		echo "           brew install shellcheck      # macOS"; \
		echo "💡 进行基本语法检查..."; \
		bash -n bin/claude-autopilot && echo "✅ claude-autopilot语法检查通过"; \
		for file in lib/*.sh; do \
			bash -n "$$file" && echo "✅ $$file语法检查通过"; \
		done; \
		for file in bin/*.sh; do \
			bash -n "$$file" && echo "✅ $$file语法检查通过"; \
		done; \
	fi

# 运行测试
.PHONY: test
test:
	@echo "🧪 运行项目测试..."
	@if [ -f tests/run-tests.sh ]; then \
		chmod +x tests/run-tests.sh && \
		./tests/run-tests.sh; \
	else \
		echo "⚠️  测试框架未找到，建议手动验证功能"; \
		echo "✅ 可以使用 make quick-setup 测试基本功能"; \
	fi

# 安装到系统
.PHONY: install
install: lint
	@echo "📦 安装Claude Autopilot 2.1系统..."
	@mkdir -p $(BIN_DIR) $(CONFIG_DIR) $(LIB_DIR)
	@cp -r bin/* $(BIN_DIR)/
	@cp -r share/claude-autopilot $(CONFIG_DIR)/
	@chmod +x $(BIN_DIR)/*
	@echo "✅ 安装完成"
	@echo "   可执行文件: $(BIN_DIR)/"
	@echo "   配置文件: $(CONFIG_DIR)"
	@echo "   使用方法: claude-autopilot [项目路径] [项目类型]"
	@echo "   或者: setup.sh (交互式配置)"

# 卸载系统
.PHONY: uninstall
uninstall:
	@echo "🗑️  卸载Claude Autopilot 2.1系统..."
	@rm -f $(BIN_DIR)/claude-autopilot
	@rm -f $(BIN_DIR)/setup.sh
	@rm -f $(BIN_DIR)/quick-setup.sh
	@rm -rf $(CONFIG_DIR)
	@rm -rf $(LIB_DIR)
	@echo "✅ 卸载完成"

# 清理构建文件
.PHONY: clean
clean:
	@echo "🧹 清理构建文件..."
	@rm -rf $(BUILD_DIR)
	@find . -name "*.bak" -delete 2>/dev/null || true
	@find . -name "*~" -delete 2>/dev/null || true
	@echo "✅ 清理完成"

# 创建发布包
.PHONY: package
package: lint test
	@echo "📦 创建发布包..."
	@mkdir -p $(BUILD_DIR)
	@tar -czf $(BUILD_DIR)/claude-autopilot-v$(VERSION).tar.gz \
		--exclude='.git' \
		--exclude='$(BUILD_DIR)' \
		--exclude='memory.sqlite' \
		--exclude='*.bak' \
		bin/ lib/ share/ README.md CLAUDE.md Makefile share/claude-autopilot/VERSION
	@echo "✅ 发布包已创建: $(BUILD_DIR)/claude-autopilot-v$(VERSION).tar.gz"

# 本地开发环境设置
.PHONY: dev-setup
dev-setup:
	@echo "🔧 设置开发环境..."
	@chmod +x bin/claude-autopilot
	@chmod +x bin/*.sh
	@chmod +x lib/*.sh
	@chmod +x tests/*.sh 2>/dev/null || true
	@chmod +x scripts/quality-check/*.sh 2>/dev/null || true
	@echo "✅ 开发环境设置完成"

# 项目健康度检查
.PHONY: health-check
health-check:
	@echo "🏥 项目健康度检查..."
	@if [ -f scripts/quality-check/health-check.sh ]; then \
		chmod +x scripts/quality-check/health-check.sh && \
		scripts/quality-check/health-check.sh .; \
	else \
		echo "⚠️ 健康检查脚本未找到"; \
	fi

# 交互式配置（新手友好）
.PHONY: setup
setup:
	@echo "🚀 启动交互式智能开发环境配置..."
	@chmod +x $(SETUP_SCRIPT)
	@$(SETUP_SCRIPT)

# 快速配置（熟练用户）
.PHONY: quick-setup
quick-setup:
	@echo "⚡ 快速配置智能开发环境..."
	@chmod +x $(QUICK_SETUP_SCRIPT)
	@$(QUICK_SETUP_SCRIPT) $(PROJECT) $(TYPE)

# 应用智能注入到当前项目
.PHONY: self-inject
self-inject:
	@echo "🎯 对当前项目应用智能注入..."
	@chmod +x $(MAIN_SCRIPT)
	@$(MAIN_SCRIPT) --target_dir . --project_type bash-scripts
	@echo "✅ 智能注入完成"

# 快速注入到指定项目 - 自动检测项目类型
.PHONY: inject
inject:
	@if [ -z "$(PROJECT)" ]; then \
		echo "❌ 错误: 请指定PROJECT参数"; \
		echo "   用法: make inject PROJECT=/path/to/project"; \
		echo "   示例: make inject PROJECT=~/go_projects/test_gateway"; \
		exit 1; \
	fi
	@echo "🎯 智能注入到项目: $(PROJECT)"
	@chmod +x $(MAIN_SCRIPT)
	@$(MAIN_SCRIPT) --target_dir "$(PROJECT)"
	@echo "✅ 注入完成"

# 快速注入到指定项目并指定类型
.PHONY: inject-type
inject-type:
	@if [ -z "$(PROJECT)" ] || [ -z "$(TYPE)" ]; then \
		echo "❌ 错误: 请指定PROJECT和TYPE参数"; \
		echo "   用法: make inject-type PROJECT=/path/to/project TYPE=project-type"; \
		echo "   示例: make inject-type PROJECT=~/new-go-app TYPE=go-general"; \
		echo ""; \
		echo "🏷️ 支持的项目类型:"; \
		echo "   gin-microservice, gin-vue3, go-desktop, go-general"; \
		echo "   vue3-frontend, vue2-frontend, react-frontend, nextjs-frontend"; \
		echo "   nodejs-general, python-desktop, python-web, python-general"; \
		echo "   bash-scripts, java-maven, java-gradle, rust-project, php-project"; \
		exit 1; \
	fi
	@echo "🎯 注入项目: $(PROJECT) (类型: $(TYPE))"
	@chmod +x $(MAIN_SCRIPT)
	@$(MAIN_SCRIPT) --target_dir "$(PROJECT)" --project_type "$(TYPE)"
	@echo "✅ 注入完成"

# 批量注入到多个项目
.PHONY: inject-batch
inject-batch:
	@if [ -z "$(PROJECTS_DIR)" ]; then \
		echo "❌ 错误: 请指定PROJECTS_DIR参数"; \
		echo "   用法: make inject-batch PROJECTS_DIR=/path/to/projects"; \
		echo "   示例: make inject-batch PROJECTS_DIR=~/go_projects"; \
		exit 1; \
	fi
	@echo "🔄 批量注入到目录: $(PROJECTS_DIR)"
	@chmod +x $(MAIN_SCRIPT)
	@for project in "$(PROJECTS_DIR)"/*; do \
		if [ -d "$$project" ]; then \
			echo ""; \
			echo "📂 处理项目: $$project"; \
			$(MAIN_SCRIPT) --target_dir "$project" || echo "⚠️ 跳过: $project"; \
		fi; \
	done
	@echo "✅ 批量注入完成"

# 显示帮助信息
.PHONY: help
help:
	@echo "📖 Claude Autopilot 2.1 - 智能开发环境自动配置工具"
	@echo ""
	@echo "🚀 快速开始（推荐）:"
	@echo "  setup            - 交互式配置（新手友好）"
	@echo "  quick-setup      - 快速配置当前目录"
	@echo ""
	@echo "🎯 主要目标:"
	@echo "  all              - 运行lint和test（默认）"
	@echo "  lint             - 运行ShellCheck代码检查"
	@echo "  test             - 运行项目测试套件"
	@echo ""
	@echo "📦 安装和部署:"
	@echo "  install          - 安装到系统 (需要sudo)"
	@echo "  uninstall        - 从系统卸载 (需要sudo)"
	@echo "  package          - 创建发布包"
	@echo ""
	@echo "🔧 开发工具:"
	@echo "  dev-setup        - 设置开发环境"
	@echo "  self-inject      - 对当前项目应用智能注入"
	@echo "  health-check     - 检查项目健康度"
	@echo "  clean            - 清理构建文件"
	@echo ""
	@echo "🎯 高级注入功能:"
	@echo "  inject           - 注入到指定项目 (自动检测类型)"
	@echo "  inject-type      - 注入到指定项目并指定类型"
	@echo "  inject-batch     - 批量注入到目录下所有项目"
	@echo ""
	@echo "📚 快速使用示例:"
	@echo "  make setup                                           # 交互式配置"
	@echo "  make quick-setup                                     # 配置当前目录"
	@echo "  make quick-setup PROJECT=/path/to/project            # 配置指定目录"
	@echo "  make inject PROJECT=~/go_projects/test_gateway       # 自动检测类型"
	@echo "  make inject-type PROJECT=~/new-app TYPE=go-general   # 指定类型"
	@echo ""
	@echo "📦 系统安装:"
	@echo "  sudo make install                                    # 系统安装"
	@echo "  make package                                         # 创建发布包"
	@echo ""
	@echo "🌟 Claude Autopilot 版本: $(VERSION)"

# 默认目标提示
.DEFAULT_GOAL := help