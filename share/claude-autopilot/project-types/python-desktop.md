# Python桌面应用规范

## 📋 项目特征

- **适用场景**: 桌面工具、企业应用、数据可视化、系统管理工具、科学计算界面
- **技术栈**: Python 3.11+ + PySide6/Tkinter + PyInstaller + SQLite
- **架构模式**: 🏗️ MVP/MVVM + 模块化设计 + 组件化开发
- **部署方式**: 🚀 跨平台打包 + 多架构支持 + 自动化分发
- **特点**: 零配置启动、原生界面、95%桌面应用需求覆盖

## 🏗️ 通用标准项目结构（适用于所有Python桌面项目）

```
python-desktop项目/
├── src/                          # 📁 源代码目录（遵循用户偏好）
│   ├── ui/                       # 🎨 用户界面层（MVP架构）
│   │   ├── __init__.py
│   │   ├── main_window.py        # 主窗口
│   │   ├── dialogs/              # 对话框组件
│   │   │   ├── __init__.py
│   │   │   ├── about_dialog.py   # 关于对话框
│   │   │   ├── settings_dialog.py # 设置对话框
│   │   │   └── file_dialog.py    # 文件操作对话框
│   │   ├── widgets/              # 自定义组件
│   │   │   ├── __init__.py
│   │   │   ├── custom_button.py  # 自定义按钮
│   │   │   ├── progress_bar.py   # 进度条组件
│   │   │   └── status_bar.py     # 状态栏组件
│   │   ├── layouts/              # 布局管理器
│   │   │   ├── __init__.py
│   │   │   ├── main_layout.py    # 主布局
│   │   │   └── responsive_layout.py # 响应式布局
│   │   └── styles/               # 样式和主题
│   │       ├── __init__.py
│   │       ├── themes.py         # 主题定义
│   │       ├── dark_theme.py     # 暗色主题
│   │       └── light_theme.py    # 亮色主题
│   ├── core/                     # 🧠 核心业务逻辑层
│   │   ├── __init__.py
│   │   ├── models/               # 数据模型（MVVM）
│   │   │   ├── __init__.py
│   │   │   ├── base_model.py     # 基础模型类
│   │   │   ├── user_model.py     # 用户数据模型
│   │   │   └── settings_model.py # 设置数据模型
│   │   ├── services/             # 业务服务层
│   │   │   ├── __init__.py
│   │   │   ├── file_service.py   # 文件操作服务
│   │   │   ├── data_service.py   # 数据处理服务
│   │   │   ├── export_service.py # 导出服务
│   │   │   └── validation_service.py # 数据验证服务
│   │   ├── controllers/          # 控制器（MVP）
│   │   │   ├── __init__.py
│   │   │   ├── main_controller.py # 主控制器
│   │   │   ├── file_controller.py # 文件控制器
│   │   │   └── settings_controller.py # 设置控制器
│   │   └── utils/                # 工具函数库
│   │       ├── __init__.py
│   │       ├── file_utils.py     # 文件工具
│   │       ├── string_utils.py   # 字符串工具
│   │       ├── date_utils.py     # 日期工具
│   │       └── validation_utils.py # 验证工具
│   ├── data/                     # 💾 数据访问层
│   │   ├── __init__.py
│   │   ├── database/             # 数据库操作
│   │   │   ├── __init__.py
│   │   │   ├── connection.py     # 数据库连接
│   │   │   ├── models.py         # SQLite数据模型
│   │   │   ├── migrations.py     # 数据库迁移
│   │   │   └── repositories.py   # 数据仓库
│   │   ├── cache/                # 缓存管理
│   │   │   ├── __init__.py
│   │   │   ├── memory_cache.py   # 内存缓存
│   │   │   └── file_cache.py     # 文件缓存
│   │   └── storage/              # 文件存储
│   │       ├── __init__.py
│       │   ├── local_storage.py  # 本地存储
│       │   └── temp_storage.py   # 临时存储
│   ├── resources/                # 📦 资源文件管理
│   │   ├── __init__.py
│   │   ├── icons/                # 图标资源
│   │   │   ├── app_icon.ico      # 应用图标
│   │   │   ├── toolbar/          # 工具栏图标
│   │   │   └── buttons/          # 按钮图标
│   │   ├── images/               # 图片资源
│   │   │   ├── splash.png        # 启动画面
│   │   │   ├── logos/            # 标识图片
│   │   │   └── backgrounds/      # 背景图片
│   │   ├── fonts/                # 字体文件
│   │   │   ├── default.ttf       # 默认字体
│   │   │   └── mono.ttf          # 等宽字体
│   │   ├── sounds/               # 音频资源
│   │   │   ├── notification.wav  # 通知音效
│   │   │   └── alerts/           # 警告音效
│   │   └── data/                 # 数据文件
│   │       ├── config.json       # 配置数据
│   │       ├── templates/        # 模板文件
│   │       └── samples/          # 示例数据
│   ├── config/                   # ⚙️ 配置管理
│   │   ├── __init__.py
│   │   ├── settings.py           # 应用设置
│   │   ├── constants.py          # 常量定义
│   │   ├── paths.py              # 路径配置
│   │   ├── logging_config.py     # 日志配置
│   │   └── environment.py        # 环境变量
│   ├── plugins/                  # 🔌 插件系统（可选）
│   │   ├── __init__.py
│   │   ├── plugin_manager.py     # 插件管理器
│   │   ├── base_plugin.py        # 插件基类
│   │   └── builtin/              # 内置插件
│   │       ├── __init__.py
│   │       └── export_plugin.py  # 导出插件
│   ├── exceptions/               # 🚨 异常处理
│   │   ├── __init__.py
│   │   ├── base_exceptions.py    # 基础异常类
│   │   ├── ui_exceptions.py      # UI异常
│   │   ├── data_exceptions.py    # 数据异常
│   │   └── file_exceptions.py    # 文件异常
│   └── main.py                   # 🚀 应用程序入口
├── tests/                        # 🧪 测试文件（pytest框架）
│   ├── __init__.py
│   ├── unit/                     # 单元测试
│   │   ├── __init__.py
│   │   ├── test_models.py        # 模型测试
│   │   ├── test_services.py      # 服务测试
│   │   ├── test_utils.py         # 工具函数测试
│   │   └── test_controllers.py   # 控制器测试
│   ├── integration/              # 集成测试
│   │   ├── __init__.py
│   │   ├── test_database.py      # 数据库集成测试
│   │   ├── test_file_operations.py # 文件操作测试
│   │   └── test_workflow.py      # 工作流测试
│   ├── ui/                       # UI测试
│   │   ├── __init__.py
│   │   ├── test_main_window.py   # 主窗口测试
│   │   ├── test_dialogs.py       # 对话框测试
│   │   └── test_widgets.py       # 组件测试
│   ├── fixtures/                 # 测试数据
│   │   ├── __init__.py
│   │   ├── sample_data.json      # 示例数据
│   │   ├── test_files/           # 测试文件
│   │   └── mock_data.py          # 模拟数据
│   └── conftest.py               # pytest配置
├── assets/                       # 📁 静态资源（构建用）
│   ├── icons/                    # 应用图标
│   │   ├── app.ico               # Windows图标
│   │   ├── app.icns              # macOS图标
│   │   └── app.png               # Linux图标
│   ├── images/                   # 图片资源
│   │   ├── splash.png            # 启动画面
│   │   └── screenshots/          # 应用截图
│   ├── sounds/                   # 音频文件
│   │   └── notification.wav      # 通知音效
│   └── themes/                   # 主题文件
│       ├── dark.qss              # Qt暗色主题
│       └── light.qss             # Qt亮色主题
├── scripts/                      # 📜 构建和部署脚本
│   ├── __init__.py
│   ├── build/                    # 构建脚本
│   │   ├── __init__.py
│   │   ├── multi_arch_build.py   # 多架构构建脚本
│   │   ├── build_windows.py      # Windows构建
│   │   ├── build_macos.py        # macOS构建
│   │   └── build_linux.py        # Linux构建
│   ├── package/                  # 打包脚本
│   │   ├── __init__.py
│   │   ├── create_installer.py   # 安装包创建
│   │   ├── msi_builder.py        # Windows MSI构建
│   │   ├── dmg_builder.py        # macOS DMG构建
│   │   └── appimage_builder.py   # Linux AppImage构建
│   ├── deploy/                   # 部署脚本
│   │   ├── __init__.py
│   │   ├── release_manager.py    # 发布管理
│   │   └── version_bump.py       # 版本更新
│   └── utils/                    # 构建工具
│       ├── __init__.py
│       ├── file_utils.py         # 文件处理工具
│       └── platform_utils.py     # 平台检测工具
├── docs/                         # 📚 项目文档
│   ├── README.md                 # 项目说明
│   ├── CHANGELOG.md              # 更新日志
│   ├── CONTRIBUTING.md           # 贡献指南
│   ├── api/                      # API文档
│   ├── user_guide/               # 用户指南
│   ├── developer_guide/          # 开发者指南
│   └── screenshots/              # 应用截图
├── dist/                         # 🏗️ 构建输出目录
│   ├── windows/                  # Windows构建产物
│   ├── macos/                    # macOS构建产物
│   └── linux/                    # Linux构建产物
├── build/                        # 🔧 临时构建文件
├── venv/                         # 🐍 虚拟环境（开发用）
├── .env.example                  # 环境变量示例
├── .gitignore                    # Git忽略文件
├── .editorconfig                 # 编辑器配置
├── requirements.txt              # 📋 依赖包列表（用户偏好）
├── requirements-dev.txt          # 开发依赖包
├── pyproject.toml                # 🔧 现代Python项目配置
├── setup.py                      # 安装脚本（向下兼容）
├── app.spec                      # PyInstaller配置文件
├── pytest.ini                    # pytest配置
├── mypy.ini                      # 类型检查配置
├── Makefile                      # 🛠️ 构建工具（用户偏好）
├── VERSION                       # 版本信息
└── README.md                     # 项目文档
```

## 🔧 2025年技术栈标准

### **现代Python桌面技术栈特性**

**核心框架 (基于2025年最佳实践和用户偏好)**
- **Python 3.11+** - 现代Python运行时，性能提升和类型系统增强
- **PySide6 6.9+** - **主推荐**，Qt官方Python绑定，LGPL许可，商业友好
- **Tkinter + CustomTkinter** - **用户偏好**，轻量级解决方案，零外部依赖
- **PyInstaller 6.14+** - **用户偏好**，跨平台打包，多架构支持

**数据存储技术栈 (基于用户偏好)**
- **SQLite 3.40+** - **用户偏好**，嵌入式数据库，零配置
- **Dataclasses + Type Hints** - 现代Python数据模型
- **Pydantic** - 数据验证和设置管理
- **pathlib** - 现代路径操作API

### **依赖配置 (requirements.txt)**
```txt
# GUI框架选择（二选一）
# 选项1: PySide6 (推荐用于现代应用)
PySide6==6.9.1
PySide6-Addons==6.9.1
PySide6-Essentials==6.9.1

# 选项2: CustomTkinter (推荐用于简单应用)
customtkinter==5.2.2

# 数据处理和验证
pydantic==2.10.4
python-dateutil==2.9.0

# 文件处理
Pillow==11.2.1
openpyxl==3.1.5

# 日志和配置
loguru==0.7.2
python-decouple==3.8

# 打包和分发
PyInstaller==6.14.1
```

### **开发依赖 (requirements-dev.txt)**
```txt
-r requirements.txt

# 代码质量和格式化（现代化工具链）
ruff==0.8.0
black==24.10.0
mypy==1.13.0

# 测试框架
pytest==8.3.4
pytest-cov==6.0.0
pytest-mock==3.14.0
pytest-qt==4.4.0
coverage==7.6.9

# 类型检查
types-Pillow==10.2.0
types-python-dateutil==2.9.0

# 开发工具
pre-commit==4.0.1
```

## 🚀 标准化开发流程

### ⭐ 基于2025年Python最佳实践的开发流程

遵循现代Python开发标准和用户偏好的开发模式：

#### 项目初始化命令

```bash
# 1. 创建项目目录结构
mkdir python-desktop-app && cd python-desktop-app

# 2. 创建虚拟环境（用户偏好）
python -m venv venv
source venv/bin/activate  # Linux/macOS
# 或
venv\Scripts\activate     # Windows

# 3. 安装依赖
pip install -r requirements.txt
pip install -r requirements-dev.txt

# 4. 初始化项目结构
python scripts/init_project.py
```

## 📜 2025年标准化 Makefile

```makefile
.PHONY: install dev test lint build package clean help

# 项目配置（基于用户偏好）
PROJECT_NAME = python-desktop-app
PYTHON_VERSION = 3.11
MAIN_SCRIPT = src/main.py

help:
	@echo "🐍 Python桌面应用开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  install       - 安装项目依赖"
	@echo "  dev           - 启动开发环境"
	@echo "  test          - 运行所有测试"
	@echo "  lint          - 代码质量检查"
	@echo "  format        - 代码格式化"
	@echo ""
	@echo "🏗️  构建部署:"
	@echo "  build         - 构建应用程序"
	@echo "  build-all     - 构建所有平台版本"
	@echo "  package       - 创建安装包"
	@echo "  package-all   - 创建所有平台安装包"
	@echo ""
	@echo "🧹 维护:"
	@echo "  clean         - 清理构建文件"
	@echo "  health-check  - 项目健康检查"

install:
	@echo "📦 安装项目依赖..."
	pip install -r requirements.txt
	pip install -r requirements-dev.txt
	@echo "✅ 依赖安装完成!"

dev:
	@echo "🚀 启动开发环境..."
	python $(MAIN_SCRIPT)

test:
	@echo "🧪 运行所有测试..."
	pytest tests/ -v --cov=src --cov-report=html --cov-report=term
	@echo "✅ 测试完成!"

lint:
	@echo "🔍 代码质量检查..."
	ruff check src/ tests/
	mypy src/
	@echo "✅ 代码检查完成!"

format:
	@echo "✨ 代码格式化..."
	black src/ tests/
	ruff format src/ tests/
	@echo "✅ 格式化完成!"

build:
	@echo "🏗️ 构建应用程序..."
	python scripts/build/multi_arch_build.py --platform=current
	@echo "✅ 构建完成!"

build-all:
	@echo "🌍 构建所有平台版本..."
	python scripts/build/multi_arch_build.py --platform=all
	@echo "✅ 多平台构建完成!"

package:
	@echo "📦 创建安装包..."
	python scripts/package/create_installer.py --platform=current
	@echo "✅ 安装包创建完成!"

package-all:
	@echo "🌍 创建所有平台安装包..."
	python scripts/package/create_installer.py --platform=all
	@echo "✅ 多平台安装包创建完成!"

clean:
	@echo "🧹 清理构建文件..."
	rm -rf build/ dist/ *.spec
	find . -type d -name __pycache__ -delete
	find . -name "*.pyc" -delete
	find . -name "*.pyo" -delete
	rm -rf .pytest_cache/ htmlcov/ .coverage
	@echo "✅ 清理完成!"

health-check:
	@echo "🏥 项目健康检查..."
	python -m py_compile $(MAIN_SCRIPT)
	python scripts/utils/health_check.py
	pytest tests/unit/ --tb=short
	@echo "✅ 健康检查完成!"

# 开发辅助命令
setup-venv:
	@echo "🐍 创建虚拟环境..."
	python -m venv venv
	@echo "✅ 虚拟环境创建完成!"
	@echo "📝 请运行: source venv/bin/activate (Linux/macOS) 或 venv\\Scripts\\activate (Windows)"

init-project:
	@echo "🏗️ 初始化项目结构..."
	python scripts/init_project.py
	@echo "✅ 项目结构初始化完成!"

# 打包辅助
build-windows:
	@echo "🪟 构建Windows版本..."
	python scripts/build/build_windows.py
	@echo "✅ Windows版本构建完成!"

build-macos:
	@echo "🍎 构建macOS版本..."
	python scripts/build/build_macos.py
	@echo "✅ macOS版本构建完成!"

build-linux:
	@echo "🐧 构建Linux版本..."
	python scripts/build/build_linux.py
	@echo "✅ Linux版本构建完成!"

# 依赖管理
upgrade-deps:
	@echo "⬆️ 升级依赖包..."
	pip install --upgrade pip
	pip-review --auto
	@echo "✅ 依赖升级完成!"

freeze-deps:
	@echo "❄️ 锁定依赖版本..."
	pip freeze > requirements-lock.txt
	@echo "✅ 依赖版本已锁定!"
```

## 📝 核心代码文件示例

### **现代化应用入口 (src/main.py)**
```python
#!/usr/bin/env python3
"""
Python桌面应用程序主入口
基于2025年最佳实践和用户偏好设计
"""
import sys
import logging
from pathlib import Path
from typing import Optional

# 添加src目录到Python路径
sys.path.insert(0, str(Path(__file__).parent))

from config.logging_config import setup_logging
from config.settings import AppSettings
from ui.main_window import MainWindow

# 支持多种GUI框架（基于用户偏好）
try:
    # 优先使用PySide6（现代化选择）
    from PySide6.QtWidgets import QApplication
    from PySide6.QtCore import Qt
    from PySide6.QtGui import QIcon
    GUI_FRAMEWORK = "PySide6"
except ImportError:
    try:
        # 备选CustomTkinter（用户偏好）
        import customtkinter as ctk
        GUI_FRAMEWORK = "CustomTkinter"
    except ImportError:
        # 最后使用Tkinter（Python内置）
        import tkinter as tk
        GUI_FRAMEWORK = "Tkinter"


class DesktopApplication:
    """桌面应用程序主类"""
    
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        self.settings = AppSettings()
        self.main_window: Optional[MainWindow] = None
        self.app = None
        
    def initialize(self) -> bool:
        """初始化应用程序"""
        try:
            # 设置日志
            setup_logging(self.settings.log_level)
            self.logger.info(f"启动应用程序 - GUI框架: {GUI_FRAMEWORK}")
            
            # 初始化GUI应用
            if GUI_FRAMEWORK == "PySide6":
                self.app = QApplication(sys.argv)
                self.app.setApplicationName(self.settings.app_name)
                self.app.setApplicationVersion(self.settings.version)
                self.app.setOrganizationName(self.settings.organization)
                
                # 设置应用图标
                icon_path = Path(__file__).parent / "resources" / "icons" / "app_icon.ico"
                if icon_path.exists():
                    self.app.setWindowIcon(QIcon(str(icon_path)))
                    
            elif GUI_FRAMEWORK == "CustomTkinter":
                ctk.set_appearance_mode(self.settings.theme)
                ctk.set_default_color_theme("blue")
                
            else:  # Tkinter
                import tkinter as tk
                self.app = tk.Tk()
                self.app.withdraw()  # 隐藏默认窗口
            
            # 创建主窗口
            self.main_window = MainWindow(self.settings)
            
            self.logger.info("应用程序初始化完成")
            return True
            
        except Exception as e:
            self.logger.error(f"应用程序初始化失败: {e}")
            return False
    
    def run(self) -> int:
        """运行应用程序"""
        if not self.initialize():
            return 1
            
        try:
            self.logger.info("启动应用程序主循环")
            
            if GUI_FRAMEWORK == "PySide6":
                self.main_window.show()
                return self.app.exec()
            
            elif GUI_FRAMEWORK == "CustomTkinter":
                self.main_window.mainloop()
                return 0
                
            else:  # Tkinter
                self.main_window.mainloop()
                return 0
                
        except KeyboardInterrupt:
            self.logger.info("用户中断应用程序")
            return 0
        except Exception as e:
            self.logger.error(f"应用程序运行时错误: {e}")
            return 1
        finally:
            self.cleanup()
    
    def cleanup(self):
        """清理资源"""
        self.logger.info("清理应用程序资源")
        if self.main_window:
            self.main_window.cleanup()


def main() -> int:
    """应用程序入口函数"""
    app = DesktopApplication()
    return app.run()


if __name__ == "__main__":
    # 支持PyInstaller打包检测
    import multiprocessing
    multiprocessing.freeze_support()
    
    sys.exit(main())
```

### **现代化应用设置 (src/config/settings.py)**
```python
"""
应用程序设置管理
基于Pydantic的现代化配置管理
"""
import os
from pathlib import Path
from typing import Optional, Literal
from pydantic import BaseSettings, Field
from decouple import config


class AppSettings(BaseSettings):
    """应用程序设置类"""
    
    # 应用基本信息
    app_name: str = Field(default="Python桌面应用", description="应用程序名称")
    version: str = Field(default="1.0.0", description="应用程序版本")
    organization: str = Field(default="我的组织", description="组织名称")
    
    # UI设置
    theme: Literal["light", "dark", "auto"] = Field(default="auto", description="界面主题")
    window_width: int = Field(default=1200, ge=800, description="窗口宽度")
    window_height: int = Field(default=800, ge=600, description="窗口高度")
    remember_window_state: bool = Field(default=True, description="记住窗口状态")
    
    # 文件和路径设置
    data_dir: Path = Field(
        default_factory=lambda: Path.home() / ".python-desktop-app",
        description="数据目录"
    )
    cache_dir: Path = Field(
        default_factory=lambda: Path.home() / ".python-desktop-app" / "cache",
        description="缓存目录"
    )
    log_dir: Path = Field(
        default_factory=lambda: Path.home() / ".python-desktop-app" / "logs",
        description="日志目录"
    )
    
    # 数据库设置（SQLite - 用户偏好）
    database_url: str = Field(
        default_factory=lambda: f"sqlite:///{Path.home() / '.python-desktop-app' / 'app.db'}",
        description="数据库连接URL"
    )
    backup_enabled: bool = Field(default=True, description="启用数据库备份")
    backup_interval_hours: int = Field(default=24, ge=1, description="备份间隔（小时）")
    
    # 日志设置
    log_level: Literal["DEBUG", "INFO", "WARNING", "ERROR"] = Field(
        default="INFO", 
        description="日志级别"
    )
    log_file_max_size: int = Field(default=10, description="日志文件最大大小(MB)")
    log_file_backup_count: int = Field(default=5, description="日志文件备份数量")
    
    # 性能设置
    enable_threading: bool = Field(default=True, description="启用多线程")
    max_worker_threads: int = Field(default=4, ge=1, le=16, description="最大工作线程数")
    cache_size_mb: int = Field(default=100, ge=10, description="缓存大小(MB)")
    
    # 功能设置
    auto_save_enabled: bool = Field(default=True, description="启用自动保存")
    auto_save_interval_minutes: int = Field(default=5, ge=1, description="自动保存间隔（分钟）")
    check_updates: bool = Field(default=True, description="检查更新")
    send_analytics: bool = Field(default=False, description="发送使用统计")
    
    # 开发设置
    debug_mode: bool = Field(default=False, description="调试模式")
    enable_console: bool = Field(default=False, description="启用控制台")
    profile_performance: bool = Field(default=False, description="性能分析")
    
    class Config:
        env_prefix = "APP_"
        case_sensitive = False
        
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.ensure_directories()
    
    def ensure_directories(self):
        """确保必要的目录存在"""
        for dir_path in [self.data_dir, self.cache_dir, self.log_dir]:
            dir_path.mkdir(parents=True, exist_ok=True)
    
    @classmethod
    def load_from_file(cls, config_file: Optional[Path] = None) -> "AppSettings":
        """从配置文件加载设置"""
        if config_file is None:
            config_file = Path.home() / ".python-desktop-app" / "config.json"
        
        if config_file.exists():
            import json
            with open(config_file, 'r', encoding='utf-8') as f:
                config_data = json.load(f)
            return cls(**config_data)
        
        return cls()
    
    def save_to_file(self, config_file: Optional[Path] = None):
        """保存设置到配置文件"""
        if config_file is None:
            config_file = self.data_dir / "config.json"
        
        config_file.parent.mkdir(parents=True, exist_ok=True)
        
        import json
        with open(config_file, 'w', encoding='utf-8') as f:
            json.dump(self.dict(), f, indent=2, ensure_ascii=False, default=str)
```

### **MVP架构主窗口 (src/ui/main_window.py)**
```python
"""
主窗口实现 - MVP架构模式
支持多种GUI框架的统一接口
"""
import logging
from typing import Optional, Protocol
from pathlib import Path

# 导入配置
from config.settings import AppSettings
from core.controllers.main_controller import MainController

# GUI框架自适应导入
try:
    from PySide6.QtWidgets import QMainWindow, QVBoxLayout, QWidget, QMenuBar, QStatusBar
    from PySide6.QtCore import Qt, QTimer
    from PySide6.QtGui import QAction, QKeySequence
    GUI_FRAMEWORK = "PySide6"
except ImportError:
    try:
        import customtkinter as ctk
        GUI_FRAMEWORK = "CustomTkinter"
    except ImportError:
        import tkinter as tk
        from tkinter import ttk, messagebox
        GUI_FRAMEWORK = "Tkinter"


class MainWindowView(Protocol):
    """主窗口视图接口"""
    def show_status_message(self, message: str, timeout: int = 0) -> None: ...
    def show_error_dialog(self, title: str, message: str) -> None: ...
    def show_info_dialog(self, title: str, message: str) -> None: ...
    def update_window_title(self, title: str) -> None: ...


if GUI_FRAMEWORK == "PySide6":
    class MainWindow(QMainWindow, MainWindowView):
        """PySide6主窗口实现"""
        
        def __init__(self, settings: AppSettings):
            super().__init__()
            self.settings = settings
            self.logger = logging.getLogger(__name__)
            self.controller = MainController(self, settings)
            
            self.setup_ui()
            self.setup_connections()
            self.restore_window_state()
        
        def setup_ui(self):
            """设置用户界面"""
            # 窗口基本设置
            self.setWindowTitle(self.settings.app_name)
            self.resize(self.settings.window_width, self.settings.window_height)
            
            # 中央控件
            central_widget = QWidget()
            self.setCentralWidget(central_widget)
            layout = QVBoxLayout(central_widget)
            
            # 创建菜单栏
            self.create_menu_bar()
            
            # 创建状态栏
            self.status_bar = self.statusBar()
            self.status_bar.showMessage("就绪")
            
            # 加载主题
            self.apply_theme()
        
        def create_menu_bar(self):
            """创建菜单栏"""
            menubar = self.menuBar()
            
            # 文件菜单
            file_menu = menubar.addMenu("文件(&F)")
            
            new_action = QAction("新建(&N)", self)
            new_action.setShortcut(QKeySequence.StandardKey.New)
            new_action.triggered.connect(self.controller.new_file)
            file_menu.addAction(new_action)
            
            open_action = QAction("打开(&O)", self)
            open_action.setShortcut(QKeySequence.StandardKey.Open)
            open_action.triggered.connect(self.controller.open_file)
            file_menu.addAction(open_action)
            
            save_action = QAction("保存(&S)", self)
            save_action.setShortcut(QKeySequence.StandardKey.Save)
            save_action.triggered.connect(self.controller.save_file)
            file_menu.addAction(save_action)
            
            file_menu.addSeparator()
            
            exit_action = QAction("退出(&X)", self)
            exit_action.setShortcut(QKeySequence.StandardKey.Quit)
            exit_action.triggered.connect(self.close)
            file_menu.addAction(exit_action)
            
            # 帮助菜单
            help_menu = menubar.addMenu("帮助(&H)")
            
            about_action = QAction("关于(&A)", self)
            about_action.triggered.connect(self.controller.show_about)
            help_menu.addAction(about_action)
        
        def apply_theme(self):
            """应用主题"""
            if self.settings.theme == "dark":
                self.setStyleSheet("""
                    QMainWindow {
                        background-color: #2b2b2b;
                        color: #ffffff;
                    }
                    QMenuBar {
                        background-color: #3c3c3c;
                        color: #ffffff;
                    }
                    QMenuBar::item:selected {
                        background-color: #5c5c5c;
                    }
                """)
        
        def show_status_message(self, message: str, timeout: int = 0) -> None:
            """显示状态栏消息"""
            self.status_bar.showMessage(message, timeout)
        
        def show_error_dialog(self, title: str, message: str) -> None:
            """显示错误对话框"""
            from PySide6.QtWidgets import QMessageBox
            QMessageBox.critical(self, title, message)
        
        def show_info_dialog(self, title: str, message: str) -> None:
            """显示信息对话框"""
            from PySide6.QtWidgets import QMessageBox
            QMessageBox.information(self, title, message)
        
        def update_window_title(self, title: str) -> None:
            """更新窗口标题"""
            self.setWindowTitle(f"{title} - {self.settings.app_name}")
        
        def restore_window_state(self):
            """恢复窗口状态"""
            if self.settings.remember_window_state:
                # 这里可以从配置文件读取窗口状态
                pass
        
        def closeEvent(self, event):
            """窗口关闭事件"""
            self.controller.on_window_closing()
            event.accept()
        
        def cleanup(self):
            """清理资源"""
            if hasattr(self, 'controller'):
                self.controller.cleanup()

elif GUI_FRAMEWORK == "CustomTkinter":
    class MainWindow(ctk.CTk, MainWindowView):
        """CustomTkinter主窗口实现"""
        
        def __init__(self, settings: AppSettings):
            super().__init__()
            self.settings = settings
            self.logger = logging.getLogger(__name__)
            self.controller = MainController(self, settings)
            
            self.setup_ui()
            self.setup_connections()
        
        def setup_ui(self):
            """设置用户界面"""
            # 窗口基本设置
            self.title(self.settings.app_name)
            self.geometry(f"{self.settings.window_width}x{self.settings.window_height}")
            
            # 创建主框架
            self.main_frame = ctk.CTkFrame(self)
            self.main_frame.pack(fill="both", expand=True, padx=10, pady=10)
            
            # 创建菜单栏（CustomTkinter样式）
            self.create_menu_frame()
            
            # 状态栏
            self.status_label = ctk.CTkLabel(self, text="就绪")
            self.status_label.pack(side="bottom", fill="x", padx=5, pady=2)
        
        def create_menu_frame(self):
            """创建菜单框架"""
            menu_frame = ctk.CTkFrame(self.main_frame)
            menu_frame.pack(fill="x", padx=5, pady=5)
            
            # 文件操作按钮
            new_btn = ctk.CTkButton(menu_frame, text="新建", command=self.controller.new_file)
            new_btn.pack(side="left", padx=5)
            
            open_btn = ctk.CTkButton(menu_frame, text="打开", command=self.controller.open_file)
            open_btn.pack(side="left", padx=5)
            
            save_btn = ctk.CTkButton(menu_frame, text="保存", command=self.controller.save_file)
            save_btn.pack(side="left", padx=5)
        
        def show_status_message(self, message: str, timeout: int = 0) -> None:
            """显示状态栏消息"""
            self.status_label.configure(text=message)
            if timeout > 0:
                self.after(timeout, lambda: self.status_label.configure(text="就绪"))
        
        def show_error_dialog(self, title: str, message: str) -> None:
            """显示错误对话框"""
            import tkinter.messagebox as msgbox
            msgbox.showerror(title, message)
        
        def show_info_dialog(self, title: str, message: str) -> None:
            """显示信息对话框"""
            import tkinter.messagebox as msgbox
            msgbox.showinfo(title, message)
        
        def update_window_title(self, title: str) -> None:
            """更新窗口标题"""
            self.title(f"{title} - {self.settings.app_name}")
        
        def setup_connections(self):
            """设置事件连接"""
            self.protocol("WM_DELETE_WINDOW", self.on_closing)
        
        def on_closing(self):
            """窗口关闭处理"""
            self.controller.on_window_closing()
            self.destroy()
        
        def cleanup(self):
            """清理资源"""
            if hasattr(self, 'controller'):
                self.controller.cleanup()

else:  # Tkinter
    class MainWindow(tk.Tk, MainWindowView):
        """Tkinter主窗口实现"""
        
        def __init__(self, settings: AppSettings):
            super().__init__()
            self.settings = settings
            self.logger = logging.getLogger(__name__)
            self.controller = MainController(self, settings)
            
            self.setup_ui()
            self.setup_connections()
        
        def setup_ui(self):
            """设置用户界面"""
            # 窗口基本设置
            self.title(self.settings.app_name)
            self.geometry(f"{self.settings.window_width}x{self.settings.window_height}")
            
            # 创建菜单栏
            self.create_menu_bar()
            
            # 主框架
            self.main_frame = ttk.Frame(self)
            self.main_frame.pack(fill="both", expand=True, padx=5, pady=5)
            
            # 状态栏
            self.status_var = tk.StringVar(value="就绪")
            self.status_bar = ttk.Label(self, textvariable=self.status_var, relief="sunken")
            self.status_bar.pack(side="bottom", fill="x")
        
        def create_menu_bar(self):
            """创建菜单栏"""
            menubar = tk.Menu(self)
            self.config(menu=menubar)
            
            # 文件菜单
            file_menu = tk.Menu(menubar, tearoff=0)
            menubar.add_cascade(label="文件", menu=file_menu)
            
            file_menu.add_command(label="新建", accelerator="Ctrl+N", command=self.controller.new_file)
            file_menu.add_command(label="打开", accelerator="Ctrl+O", command=self.controller.open_file)
            file_menu.add_command(label="保存", accelerator="Ctrl+S", command=self.controller.save_file)
            file_menu.add_separator()
            file_menu.add_command(label="退出", command=self.quit)
            
            # 帮助菜单
            help_menu = tk.Menu(menubar, tearoff=0)
            menubar.add_cascade(label="帮助", menu=help_menu)
            help_menu.add_command(label="关于", command=self.controller.show_about)
        
        def show_status_message(self, message: str, timeout: int = 0) -> None:
            """显示状态栏消息"""
            self.status_var.set(message)
            if timeout > 0:
                self.after(timeout, lambda: self.status_var.set("就绪"))
        
        def show_error_dialog(self, title: str, message: str) -> None:
            """显示错误对话框"""
            messagebox.showerror(title, message)
        
        def show_info_dialog(self, title: str, message: str) -> None:
            """显示信息对话框"""
            messagebox.showinfo(title, message)
        
        def update_window_title(self, title: str) -> None:
            """更新窗口标题"""
            self.title(f"{title} - {self.settings.app_name}")
        
        def setup_connections(self):
            """设置事件连接"""
            self.protocol("WM_DELETE_WINDOW", self.on_closing)
        
        def on_closing(self):
            """窗口关闭处理"""
            self.controller.on_window_closing()
            self.destroy()
        
        def cleanup(self):
            """清理资源"""
            if hasattr(self, 'controller'):
                self.controller.cleanup()
```

### **数据库模型 (src/data/database/models.py)**
```python
"""
SQLite数据库模型
基于用户偏好的SQLite嵌入式数据库
"""
import sqlite3
from pathlib import Path
from typing import Optional, List, Dict, Any
from dataclasses import dataclass, field
from datetime import datetime
import json
import logging


@dataclass
class DatabaseModel:
    """数据库模型基类"""
    id: Optional[int] = None
    created_at: Optional[datetime] = field(default_factory=datetime.now)
    updated_at: Optional[datetime] = field(default_factory=datetime.now)
    
    def to_dict(self) -> Dict[str, Any]:
        """转换为字典"""
        result = {}
        for key, value in self.__dict__.items():
            if isinstance(value, datetime):
                result[key] = value.isoformat()
            else:
                result[key] = value
        return result
    
    @classmethod
    def from_dict(cls, data: Dict[str, Any]):
        """从字典创建实例"""
        # 处理datetime字段
        for key, value in data.items():
            if key.endswith('_at') and isinstance(value, str):
                try:
                    data[key] = datetime.fromisoformat(value)
                except ValueError:
                    pass
        return cls(**data)


@dataclass
class UserModel(DatabaseModel):
    """用户数据模型"""
    username: str = ""
    email: str = ""
    preferences: Dict[str, Any] = field(default_factory=dict)
    is_active: bool = True


@dataclass
class SettingsModel(DatabaseModel):
    """设置数据模型"""
    key: str = ""
    value: str = ""
    category: str = "general"
    description: str = ""


class DatabaseConnection:
    """SQLite数据库连接管理器"""
    
    def __init__(self, db_path: Path):
        self.db_path = db_path
        self.logger = logging.getLogger(__name__)
        self._connection: Optional[sqlite3.Connection] = None
        
        # 确保数据库目录存在
        db_path.parent.mkdir(parents=True, exist_ok=True)
        
        # 初始化数据库
        self.initialize_database()
    
    @property
    def connection(self) -> sqlite3.Connection:
        """获取数据库连接"""
        if self._connection is None:
            self._connection = sqlite3.connect(
                self.db_path,
                check_same_thread=False,
                timeout=30.0
            )
            self._connection.row_factory = sqlite3.Row
            # 启用外键约束
            self._connection.execute("PRAGMA foreign_keys = ON")
        return self._connection
    
    def initialize_database(self):
        """初始化数据库表结构"""
        try:
            with self.connection:
                # 用户表
                self.connection.execute("""
                    CREATE TABLE IF NOT EXISTS users (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        username TEXT UNIQUE NOT NULL,
                        email TEXT UNIQUE NOT NULL,
                        preferences TEXT DEFAULT '{}',
                        is_active BOOLEAN DEFAULT 1,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                    )
                """)
                
                # 设置表
                self.connection.execute("""
                    CREATE TABLE IF NOT EXISTS settings (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        key TEXT UNIQUE NOT NULL,
                        value TEXT NOT NULL,
                        category TEXT DEFAULT 'general',
                        description TEXT DEFAULT '',
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                    )
                """)
                
                # 创建索引
                self.connection.execute("""
                    CREATE INDEX IF NOT EXISTS idx_settings_category 
                    ON settings(category)
                """)
                
                # 创建触发器自动更新 updated_at
                self.connection.execute("""
                    CREATE TRIGGER IF NOT EXISTS update_users_timestamp 
                    AFTER UPDATE ON users
                    BEGIN
                        UPDATE users SET updated_at = CURRENT_TIMESTAMP 
                        WHERE id = NEW.id;
                    END
                """)
                
                self.connection.execute("""
                    CREATE TRIGGER IF NOT EXISTS update_settings_timestamp 
                    AFTER UPDATE ON settings
                    BEGIN
                        UPDATE settings SET updated_at = CURRENT_TIMESTAMP 
                        WHERE id = NEW.id;
                    END
                """)
                
            self.logger.info("数据库初始化完成")
            
        except Exception as e:
            self.logger.error(f"数据库初始化失败: {e}")
            raise
    
    def close(self):
        """关闭数据库连接"""
        if self._connection:
            self._connection.close()
            self._connection = None


class Repository:
    """数据仓库基类"""
    
    def __init__(self, db_connection: DatabaseConnection):
        self.db = db_connection
        self.logger = logging.getLogger(__name__)
    
    def execute_query(self, query: str, params: tuple = ()) -> List[sqlite3.Row]:
        """执行查询"""
        try:
            cursor = self.db.connection.execute(query, params)
            return cursor.fetchall()
        except Exception as e:
            self.logger.error(f"查询执行失败: {e}")
            raise
    
    def execute_command(self, command: str, params: tuple = ()) -> int:
        """执行命令"""
        try:
            with self.db.connection:
                cursor = self.db.connection.execute(command, params)
                return cursor.lastrowid or cursor.rowcount
        except Exception as e:
            self.logger.error(f"命令执行失败: {e}")
            raise


class UserRepository(Repository):
    """用户数据仓库"""
    
    def create_user(self, user: UserModel) -> int:
        """创建用户"""
        command = """
            INSERT INTO users (username, email, preferences, is_active)
            VALUES (?, ?, ?, ?)
        """
        params = (
            user.username,
            user.email,
            json.dumps(user.preferences),
            user.is_active
        )
        return self.execute_command(command, params)
    
    def get_user_by_id(self, user_id: int) -> Optional[UserModel]:
        """根据ID获取用户"""
        query = "SELECT * FROM users WHERE id = ?"
        rows = self.execute_query(query, (user_id,))
        
        if rows:
            row = rows[0]
            return UserModel(
                id=row['id'],
                username=row['username'],
                email=row['email'],
                preferences=json.loads(row['preferences']),
                is_active=bool(row['is_active']),
                created_at=datetime.fromisoformat(row['created_at']),
                updated_at=datetime.fromisoformat(row['updated_at'])
            )
        return None
    
    def get_user_by_username(self, username: str) -> Optional[UserModel]:
        """根据用户名获取用户"""
        query = "SELECT * FROM users WHERE username = ?"
        rows = self.execute_query(query, (username,))
        
        if rows:
            row = rows[0]
            return UserModel(
                id=row['id'],
                username=row['username'],
                email=row['email'],
                preferences=json.loads(row['preferences']),
                is_active=bool(row['is_active']),
                created_at=datetime.fromisoformat(row['created_at']),
                updated_at=datetime.fromisoformat(row['updated_at'])
            )
        return None
    
    def update_user(self, user: UserModel) -> bool:
        """更新用户"""
        command = """
            UPDATE users 
            SET username = ?, email = ?, preferences = ?, is_active = ?
            WHERE id = ?
        """
        params = (
            user.username,
            user.email,
            json.dumps(user.preferences),
            user.is_active,
            user.id
        )
        return self.execute_command(command, params) > 0
    
    def delete_user(self, user_id: int) -> bool:
        """删除用户"""
        command = "DELETE FROM users WHERE id = ?"
        return self.execute_command(command, (user_id,)) > 0


class SettingsRepository(Repository):
    """设置数据仓库"""
    
    def set_setting(self, key: str, value: str, category: str = "general", description: str = "") -> None:
        """设置配置项"""
        command = """
            INSERT OR REPLACE INTO settings (key, value, category, description)
            VALUES (?, ?, ?, ?)
        """
        self.execute_command(command, (key, value, category, description))
    
    def get_setting(self, key: str, default_value: str = "") -> str:
        """获取配置项"""
        query = "SELECT value FROM settings WHERE key = ?"
        rows = self.execute_query(query, (key,))
        return rows[0]['value'] if rows else default_value
    
    def get_settings_by_category(self, category: str) -> Dict[str, str]:
        """根据分类获取配置项"""
        query = "SELECT key, value FROM settings WHERE category = ?"
        rows = self.execute_query(query, (category,))
        return {row['key']: row['value'] for row in rows}
    
    def delete_setting(self, key: str) -> bool:
        """删除配置项"""
        command = "DELETE FROM settings WHERE key = ?"
        return self.execute_command(command, (key,)) > 0
```

## 💾 现代化测试策略

### **pytest单元测试配置**
```python
# tests/conftest.py
import pytest
import tempfile
from pathlib import Path
from unittest.mock import Mock

from src.config.settings import AppSettings
from src.data.database.models import DatabaseConnection


@pytest.fixture
def app_settings():
    """测试用的应用设置"""
    with tempfile.TemporaryDirectory() as temp_dir:
        temp_path = Path(temp_dir)
        settings = AppSettings(
            data_dir=temp_path / "data",
            cache_dir=temp_path / "cache",
            log_dir=temp_path / "logs",
            database_url=f"sqlite:///{temp_path / 'test.db'}",
            debug_mode=True
        )
        yield settings


@pytest.fixture
def mock_main_window():
    """模拟主窗口"""
    window = Mock()
    window.show_status_message = Mock()
    window.show_error_dialog = Mock()
    window.show_info_dialog = Mock()
    window.update_window_title = Mock()
    return window


@pytest.fixture
def test_database(app_settings):
    """测试数据库"""
    db_path = Path(app_settings.database_url.replace("sqlite:///", ""))
    db = DatabaseConnection(db_path)
    yield db
    db.close()
```

### **组件测试示例**
```python
# tests/unit/test_settings.py
import pytest
import json
from pathlib import Path

from src.config.settings import AppSettings


class TestAppSettings:
    """应用设置测试"""
    
    def test_default_settings(self):
        """测试默认设置"""
        settings = AppSettings()
        assert settings.app_name == "Python桌面应用"
        assert settings.version == "1.0.0"
        assert settings.theme == "auto"
        assert settings.window_width >= 800
        assert settings.window_height >= 600
    
    def test_settings_validation(self):
        """测试设置验证"""
        # 测试窗口尺寸最小值
        settings = AppSettings(window_width=500, window_height=400)
        assert settings.window_width == 800  # 应该被调整为最小值
        assert settings.window_height == 600
    
    def test_settings_directories_creation(self, tmp_path):
        """测试目录创建"""
        data_dir = tmp_path / "test_app"
        settings = AppSettings(data_dir=data_dir)
        
        assert settings.data_dir.exists()
        assert settings.cache_dir.exists()
        assert settings.log_dir.exists()
    
    def test_settings_save_load(self, tmp_path):
        """测试设置保存和加载"""
        config_file = tmp_path / "config.json"
        
        # 创建设置并保存
        original_settings = AppSettings(
            app_name="测试应用",
            theme="dark",
            window_width=1000
        )
        original_settings.save_to_file(config_file)
        
        # 从文件加载设置
        loaded_settings = AppSettings.load_from_file(config_file)
        
        assert loaded_settings.app_name == "测试应用"
        assert loaded_settings.theme == "dark"
        assert loaded_settings.window_width == 1000


# tests/unit/test_database.py
import pytest
from datetime import datetime

from src.data.database.models import DatabaseConnection, UserRepository, UserModel


class TestDatabase:
    """数据库测试"""
    
    def test_database_initialization(self, test_database):
        """测试数据库初始化"""
        # 检查表是否存在
        tables = test_database.execute_query(
            "SELECT name FROM sqlite_master WHERE type='table'"
        )
        table_names = [row['name'] for row in tables]
        
        assert 'users' in table_names
        assert 'settings' in table_names
    
    def test_user_repository_crud(self, test_database):
        """测试用户仓库CRUD操作"""
        repo = UserRepository(test_database)
        
        # 创建用户
        user = UserModel(
            username="testuser",
            email="test@example.com",
            preferences={"theme": "dark"},
            is_active=True
        )
        user_id = repo.create_user(user)
        assert user_id > 0
        
        # 读取用户
        retrieved_user = repo.get_user_by_id(user_id)
        assert retrieved_user is not None
        assert retrieved_user.username == "testuser"
        assert retrieved_user.email == "test@example.com"
        assert retrieved_user.preferences["theme"] == "dark"
        
        # 更新用户
        retrieved_user.email = "updated@example.com"
        assert repo.update_user(retrieved_user) is True
        
        # 验证更新
        updated_user = repo.get_user_by_id(user_id)
        assert updated_user.email == "updated@example.com"
        
        # 删除用户
        assert repo.delete_user(user_id) is True
        assert repo.get_user_by_id(user_id) is None


# tests/ui/test_main_window.py
import pytest
from unittest.mock import Mock, patch

try:
    from src.ui.main_window import MainWindow
    GUI_AVAILABLE = True
except ImportError:
    GUI_AVAILABLE = False


@pytest.mark.skipif(not GUI_AVAILABLE, reason="GUI framework not available")
class TestMainWindow:
    """主窗口测试"""
    
    @patch('src.ui.main_window.MainController')
    def test_main_window_creation(self, mock_controller, app_settings):
        """测试主窗口创建"""
        window = MainWindow(app_settings)
        
        assert window.settings == app_settings
        assert mock_controller.called
    
    @patch('src.ui.main_window.MainController')
    def test_status_message(self, mock_controller, app_settings):
        """测试状态消息显示"""
        window = MainWindow(app_settings)
        
        # 测试状态消息功能
        window.show_status_message("测试消息")
        # 这里可以验证状态栏是否正确显示消息
    
    @patch('src.ui.main_window.MainController')
    def test_window_title_update(self, mock_controller, app_settings):
        """测试窗口标题更新"""
        window = MainWindow(app_settings)
        
        window.update_window_title("新标题")
        # 验证窗口标题是否正确更新
```

## 🚀 现代化构建流程

### **多架构构建脚本 (scripts/build/multi_arch_build.py)**
```python
#!/usr/bin/env python3
"""
多架构构建脚本
支持Windows/macOS/Linux的AMD64和ARM64架构
基于PyInstaller和用户的多架构部署经验
"""
import os
import sys
import subprocess
import platform
import argparse
from pathlib import Path
from typing import List, Dict, Optional
import logging


class MultiArchBuilder:
    """多架构构建器"""
    
    PLATFORMS = {
        'windows': ['amd64', 'arm64'],
        'macos': ['amd64', 'arm64'], 
        'linux': ['amd64', 'arm64']
    }
    
    def __init__(self, project_root: Path):
        self.project_root = project_root
        self.logger = self._setup_logging()
        self.dist_dir = project_root / "dist"
        self.build_dir = project_root / "build"
        
    def _setup_logging(self) -> logging.Logger:
        """设置日志"""
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s'
        )
        return logging.getLogger(__name__)
    
    def get_current_platform(self) -> str:
        """获取当前平台"""
        system = platform.system().lower()
        if system == 'darwin':
            return 'macos'
        return system
    
    def get_current_arch(self) -> str:
        """获取当前架构"""
        machine = platform.machine().lower()
        if machine in ['x86_64', 'amd64']:
            return 'amd64'
        elif machine in ['arm64', 'aarch64']:
            return 'arm64'
        else:
            return 'amd64'  # 默认
    
    def clean_build_dirs(self):
        """清理构建目录"""
        self.logger.info("清理构建目录...")
        
        import shutil
        for dir_path in [self.build_dir, self.dist_dir]:
            if dir_path.exists():
                shutil.rmtree(dir_path)
        
        # 清理spec文件
        for spec_file in self.project_root.glob("*.spec"):
            spec_file.unlink()
    
    def create_pyinstaller_spec(self, platform: str, arch: str) -> Path:
        """创建PyInstaller规范文件"""
        spec_content = f'''
# -*- mode: python ; coding: utf-8 -*-
import sys
from pathlib import Path

# 项目路径
project_root = Path(__file__).parent
src_path = project_root / "src"

a = Analysis(
    [str(src_path / "main.py")],
    pathex=[str(project_root)],
    binaries=[],
    datas=[
        (str(src_path / "resources"), "resources"),
        (str(project_root / "assets"), "assets"),
    ],
    hiddenimports=[
        "PySide6.QtCore",
        "PySide6.QtGui", 
        "PySide6.QtWidgets",
        "sqlite3",
        "json",
        "logging",
    ],
    hookspath=[],
    hooksconfig={{}},
    runtime_hooks=[],
    excludes=[
        "tkinter",
        "test",
        "unittest",
        "pytest",
    ],
    noarchive=False,
    optimize=0,
)

pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name="python-desktop-app",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,  # GUI应用
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch="{arch}",
    codesign_identity=None,
    entitlements_file=None,
    icon=str(project_root / "assets" / "icons" / "app.{'ico' if platform == 'windows' else 'icns' if platform == 'macos' else 'png'}"),
)

# macOS应用包
{"app = BUNDLE(exe, name='python-desktop-app.app', icon=None, bundle_identifier='com.example.python-desktop-app')" if platform == 'macos' else ""}
'''
        
        spec_file = self.project_root / f"app_{platform}_{arch}.spec"
        spec_file.write_text(spec_content)
        return spec_file
    
    def build_for_platform_arch(self, platform: str, arch: str) -> bool:
        """为特定平台和架构构建"""
        self.logger.info(f"构建 {platform}-{arch}...")
        
        try:
            # 创建规范文件
            spec_file = self.create_pyinstaller_spec(platform, arch)
            
            # PyInstaller命令
            cmd = [
                sys.executable, "-m", "PyInstaller",
                "--clean",
                "--noconfirm",
                f"--distpath={self.dist_dir / platform / arch}",
                f"--workpath={self.build_dir / platform / arch}",
                str(spec_file)
            ]
            
            # 执行构建
            result = subprocess.run(
                cmd,
                cwd=self.project_root,
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                self.logger.info(f"✅ {platform}-{arch} 构建成功")
                return True
            else:
                self.logger.error(f"❌ {platform}-{arch} 构建失败:")
                self.logger.error(result.stderr)
                return False
                
        except Exception as e:
            self.logger.error(f"❌ {platform}-{arch} 构建异常: {e}")
            return False
        finally:
            # 清理spec文件
            if 'spec_file' in locals():
                spec_file.unlink(missing_ok=True)
    
    def build_current_platform(self) -> bool:
        """构建当前平台"""
        platform = self.get_current_platform()
        arch = self.get_current_arch()
        return self.build_for_platform_arch(platform, arch)
    
    def build_all_platforms(self) -> Dict[str, bool]:
        """构建所有平台（仅适用于CI环境）"""
        results = {}
        current_platform = self.get_current_platform()
        
        # 只构建当前平台的不同架构
        for arch in self.PLATFORMS[current_platform]:
            results[f"{current_platform}-{arch}"] = self.build_for_platform_arch(current_platform, arch)
        
        return results
    
    def verify_build(self, platform: str, arch: str) -> bool:
        """验证构建结果"""
        build_path = self.dist_dir / platform / arch
        
        if platform == "windows":
            exe_path = build_path / "python-desktop-app.exe"
        elif platform == "macos":
            exe_path = build_path / "python-desktop-app.app"
        else:  # linux
            exe_path = build_path / "python-desktop-app"
        
        return exe_path.exists()


def main():
    parser = argparse.ArgumentParser(description="多架构构建脚本")
    parser.add_argument(
        "--platform",
        choices=["current", "all"],
        default="current",
        help="构建平台"
    )
    parser.add_argument(
        "--clean",
        action="store_true",
        help="构建前清理"
    )
    parser.add_argument(
        "--verify",
        action="store_true",
        help="验证构建结果"
    )
    
    args = parser.parse_args()
    
    # 项目根目录
    project_root = Path(__file__).parent.parent.parent
    builder = MultiArchBuilder(project_root)
    
    # 清理构建目录
    if args.clean:
        builder.clean_build_dirs()
    
    # 执行构建
    if args.platform == "current":
        success = builder.build_current_platform()
        if success:
            print("✅ 当前平台构建成功")
            
            if args.verify:
                platform = builder.get_current_platform()
                arch = builder.get_current_arch()
                if builder.verify_build(platform, arch):
                    print("✅ 构建验证通过")
                else:
                    print("❌ 构建验证失败")
                    return 1
        else:
            print("❌ 构建失败")
            return 1
    
    elif args.platform == "all":
        results = builder.build_all_platforms()
        success_count = sum(1 for success in results.values() if success)
        total_count = len(results)
        
        print(f"构建完成: {success_count}/{total_count} 成功")
        for target, success in results.items():
            status = "✅" if success else "❌"
            print(f"  {status} {target}")
        
        if success_count < total_count:
            return 1
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

## 💾 数据存储和缓存规范

### SQLite最佳实践
- 使用WAL模式提高并发性能
- 建立适当的索引优化查询
- 实现自动备份和恢复机制
- 支持数据库迁移和版本管理

### 缓存策略
```python
# src/data/cache/memory_cache.py
from typing import Any, Optional, Dict
from datetime import datetime, timedelta
import threading


class MemoryCache:
    """内存缓存实现"""
    
    def __init__(self, max_size: int = 1000, default_ttl: int = 3600):
        self.max_size = max_size
        self.default_ttl = default_ttl
        self._cache: Dict[str, Dict] = {}
        self._lock = threading.Lock()
    
    def get(self, key: str) -> Optional[Any]:
        """获取缓存值"""
        with self._lock:
            if key in self._cache:
                item = self._cache[key]
                if datetime.now() < item['expires']:
                    return item['value']
                else:
                    del self._cache[key]
            return None
    
    def set(self, key: str, value: Any, ttl: Optional[int] = None) -> None:
        """设置缓存值"""
        if ttl is None:
            ttl = self.default_ttl
        
        expires = datetime.now() + timedelta(seconds=ttl)
        
        with self._lock:
            # 如果缓存已满，删除最旧的项
            if len(self._cache) >= self.max_size:
                oldest_key = min(self._cache.keys(), key=lambda k: self._cache[k]['created'])
                del self._cache[oldest_key]
            
            self._cache[key] = {
                'value': value,
                'created': datetime.now(),
                'expires': expires
            }
    
    def delete(self, key: str) -> bool:
        """删除缓存项"""
        with self._lock:
            if key in self._cache:
                del self._cache[key]
                return True
            return False
    
    def clear(self) -> None:
        """清空所有缓存"""
        with self._lock:
            self._cache.clear()
    
    def cleanup_expired(self) -> int:
        """清理过期缓存"""
        now = datetime.now()
        expired_keys = []
        
        with self._lock:
            for key, item in self._cache.items():
                if now >= item['expires']:
                    expired_keys.append(key)
            
            for key in expired_keys:
                del self._cache[key]
        
        return len(expired_keys)
```

## 🚀 现代化部署和分发

### **跨平台打包配置**

**Windows (scripts/package/msi_builder.py)**
```python
#!/usr/bin/env python3
"""
Windows MSI安装包构建器
"""
import subprocess
from pathlib import Path


def create_msi_installer(app_path: Path, output_dir: Path) -> bool:
    """创建MSI安装包"""
    # 使用WiX工具集创建MSI
    # 这里需要预先安装WiX工具集
    wix_template = f"""
    <?xml version="1.0" encoding="UTF-8"?>
    <Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
        <Product Id="*" Name="Python桌面应用" Language="1033" 
                 Version="1.0.0" Manufacturer="我的组织" 
                 UpgradeCode="{{12345678-1234-1234-1234-123456789012}}">
            <Package InstallerVersion="200" Compressed="yes" InstallScope="perMachine" />
            
            <MajorUpgrade DowngradeErrorMessage="A newer version is already installed." />
            <MediaTemplate EmbedCab="yes" />
            
            <Feature Id="ProductFeature" Title="应用程序" Level="1">
                <ComponentGroupRef Id="ProductComponents" />
            </Feature>
        </Product>
        
        <Fragment>
            <Directory Id="TARGETDIR" Name="SourceDir">
                <Directory Id="ProgramFilesFolder">
                    <Directory Id="INSTALLFOLDER" Name="Python桌面应用" />
                </Directory>
            </Directory>
        </Fragment>
        
        <Fragment>
            <ComponentGroup Id="ProductComponents" Directory="INSTALLFOLDER">
                <Component Id="MainExecutable">
                    <File Source="{app_path}" />
                </Component>
            </ComponentGroup>
        </Fragment>
    </Wix>
    """
    
    # 实现MSI构建逻辑
    return True
```

### **自动化发布流程**

基于用户的多架构部署经验，集成自动化发布：

```bash
# 完整发布流程
make clean
make build-all
make package-all
make deploy
```

## 📚 2025年Python桌面开发参考资源

### **官方文档**

- [Python 3.11+ 官方文档](https://docs.python.org/3.11/) - 现代Python语言特性
- [PySide6 官方文档](https://doc.qt.io/qtforpython/) - Qt官方Python绑定
- [PyInstaller 文档](https://pyinstaller.readthedocs.io/) - 跨平台应用打包
- [SQLite 文档](https://www.sqlite.org/docs.html) - 嵌入式数据库

### **最佳实践指南**

- PySide6现代GUI开发模式和MVP/MVVM架构实现
- PyInstaller多架构打包和分发的完整流程
- 现代化Python项目结构和依赖管理最佳实践
- 95%Python桌面应用需求覆盖的通用架构模式

---

**✨ 这个模板基于PyInstaller官方文档、2025年Python最佳实践和用户技术偏好，为Python桌面应用项目提供完整的现代化开发解决方案。**