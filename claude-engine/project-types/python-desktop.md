# CLAUDE.md - Python桌面应用项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Python桌面应用项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Python桌面应用项目
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

### **🖥️ Python桌面开发特色功能**

#### **主流GUI框架支持**
- **Tkinter**: Python内置GUI库，简单易用，跨平台兼容性好
- **PyQt5/6**: 功能强大的Qt绑定，专业级桌面应用开发
- **PySide2/6**: Qt官方Python绑定，商业友好的开源许可
- **Kivy**: 现代触屏友好的跨平台GUI框架

#### **现代桌面应用特性**
- **原生样式**: 自动适配操作系统原生外观和感觉
- **多线程处理**: GUI线程与业务逻辑线程分离，保证界面响应
- **文件关联**: 支持文件类型关联和系统集成
- **系统托盘**: 后台运行和系统托盘图标支持

#### **跨平台部署**
- **Windows**: exe可执行文件打包和MSI安装包
- **macOS**: .app应用包和DMG分发包
- **Linux**: AppImage、Flatpak、Snap通用包格式
- **一次开发**: 多平台自动化构建和发布

#### **标准Python桌面项目结构支持**
```
python-desktop项目/
├── src/
│   ├── ui/                      # 用户界面模块
│   │   ├── windows/             # 窗口定义
│   │   ├── widgets/             # 自定义组件
│   │   ├── dialogs/             # 对话框
│   │   └── styles/              # 样式和主题
│   ├── core/                    # 核心业务逻辑
│   │   ├── models/              # 数据模型
│   │   ├── services/            # 业务服务
│   │   └── utils/               # 工具函数
│   ├── resources/               # 资源文件
│   │   ├── icons/               # 图标文件
│   │   ├── images/              # 图片资源
│   │   ├── fonts/               # 字体文件
│   │   └── data/                # 数据文件
│   ├── config/                  # 配置管理
│   │   ├── settings.py          # 应用设置
│   │   └── constants.py         # 常量定义
│   └── main.py                  # 应用入口
├── tests/                       # 测试文件
│   ├── unit/                    # 单元测试
│   ├── integration/             # 集成测试
│   └── ui/                      # UI测试
├── assets/                      # 静态资源
│   ├── icons/                   # 应用图标
│   ├── images/                  # 图片资源
│   └── themes/                  # 主题文件
├── build/                       # 构建输出
│   ├── windows/                 # Windows构建
│   ├── macos/                   # macOS构建
│   └── linux/                   # Linux构建
├── dist/                        # 发布包
├── docs/                        # 项目文档
├── scripts/                     # 构建脚本
│   ├── build_windows.py         # Windows构建脚本
│   ├── build_macos.py           # macOS构建脚本
│   └── build_linux.py           # Linux构建脚本
├── requirements.txt             # 依赖包列表
├── requirements-dev.txt         # 开发依赖
├── setup.py                     # 安装脚本
├── pyproject.toml              # 项目配置
├── app.spec                     # PyInstaller配置
└── .spec                        # 平台特定配置
```

#### **智能开发和构建**
```bash
# 启动开发环境
python src/main.py

# 运行测试
python -m pytest tests/

# 代码检查
python -m flake8 src/
python -m pylint src/

# 类型检查
python -m mypy src/

# 构建Windows可执行文件
python scripts/build_windows.py

# 构建macOS应用包
python scripts/build_macos.py

# 构建Linux应用包
python scripts/build_linux.py

# 一键构建所有平台
python scripts/build_all.py

# 创建安装包
python setup.py bdist_msi  # Windows MSI
python setup.py bdist_dmg  # macOS DMG
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: GUI架构设计和用户交互流程分析
- **context7**: 动态获取Python GUI框架最新文档和最佳实践
- **memory**: Python桌面开发经验自动复用和UI设计模式库
- **puppeteer**: 桌面应用自动化测试和UI回归测试

#### **全局规则遵守**
- **Python代码规范**: 自动应用PEP 8代码风格和最佳实践
- **GUI设计原则**: 响应式界面、无障碍访问、用户体验优化
- **跨平台兼容**: 操作系统特定功能的抽象和适配
- **性能优化**: GUI线程管理、内存优化、启动速度优化

#### **Python桌面专项智能特性**
- **GUI框架选择**: 根据项目需求智能推荐最适合的GUI框架
- **界面布局设计**: 自动生成响应式布局和组件层次结构
- **事件处理模式**: 信号槽机制、回调函数的正确使用
- **数据绑定**: Model-View架构和数据自动同步

### **📋 Python桌面开发建议**

#### **开始开发**
1. 描述应用需求，如："创建文本编辑器应用"
2. 系统会自动选择最适合的GUI框架和架构模式
3. 生成符合Python最佳实践的桌面应用框架代码

#### **界面开发**
1. 说明界面需求，如："创建多标签页文档编辑界面"
2. 系统会设计组件层次结构和布局管理器
3. 自动处理事件绑定、状态管理和界面响应

#### **功能实现**
1. 描述功能需求，如："实现文件拖拽和自动保存"
2. 系统会实现业务逻辑和GUI交互的分离
3. 确保跨平台兼容性和用户体验一致性

### **🔧 开发工具集成**

#### **开发环境**
- **Python 3.8+**: 现代Python运行时环境
- **Virtual Environment**: 项目依赖隔离和管理
- **IDE支持**: PyCharm、VSCode、Spyder集成配置
- **GUI设计器**: Qt Designer、Tkinter Designer可视化设计

#### **代码质量**
- **flake8**: Python代码风格检查
- **pylint**: 代码质量和错误检测
- **black**: 自动代码格式化
- **mypy**: 静态类型检查

#### **测试框架**
- **pytest**: 现代Python测试框架
- **unittest**: Python标准库测试框架
- **pytest-qt**: Qt应用专用测试插件
- **coverage**: 代码覆盖率分析

#### **构建和打包**
- **PyInstaller**: 跨平台Python应用打包
- **cx_Freeze**: 多平台可执行文件生成
- **py2app**: macOS专用应用打包工具
- **Nuitka**: Python到C++编译器，性能优化

### **📈 效率提升**

相比传统Python桌面开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: GUI界面和业务逻辑自动生成，提升3-4倍效率
- 🎯 **架构质量**: 基于MVC/MVP模式的可维护架构设计
- 🔄 **跨平台优化**: 自动处理操作系统差异和原生集成
- 📊 **性能优化**: GUI线程优化和内存管理最佳实践
- 🧪 **测试覆盖**: 自动生成UI测试用例和功能测试

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
pip install -r requirements.txt
pip install -r requirements-dev.txt

# 更新pip和工具
pip install --upgrade pip setuptools wheel
```

#### **GUI框架问题**
```bash
# Tkinter问题（通常预装）
python -m tkinter

# PyQt5安装
pip install PyQt5 PyQt5-tools

# PyQt6安装
pip install PyQt6 PyQt6-tools

# PySide6安装
pip install PySide6

# Kivy安装
pip install kivy[base,media,dev]

# 检查GUI框架
python -c "import tkinter; print('Tkinter OK')"
python -c "import PyQt5; print('PyQt5 OK')"
```

#### **打包问题**
```bash
# PyInstaller问题诊断
pyinstaller --onefile --windowed src/main.py

# 查看详细输出
pyinstaller --onefile --windowed --debug=all src/main.py

# 清理构建缓存
rm -rf build/ dist/ __pycache__/
rm *.spec

# 检查依赖
pip list
pip check

# 修复缺失模块
pyinstaller --hidden-import=模块名 src/main.py
```

#### **跨平台问题**
```bash
# 检查平台特定问题
python -c "import sys; print(sys.platform)"

# Windows路径问题
# 使用pathlib而不是os.path
from pathlib import Path

# macOS权限问题
# 在Info.plist中添加权限声明

# Linux依赖问题
sudo apt-get install python3-tk python3-dev
sudo apt-get install qt5-default  # PyQt5
```

#### **性能优化问题**
```bash
# GUI响应性分析
python -m cProfile src/main.py

# 内存使用分析
python -m memory_profiler src/main.py

# 启动时间优化
# 延迟导入非必要模块
# 使用懒加载模式
# 优化资源文件大小

# 多线程GUI
# 使用QThread或threading模块
# 避免在GUI线程中执行耗时操作
```

---

## 🚀 **开始Python桌面智能开发之旅**

智能Claude Autopilot 2.1专为Python桌面应用开发优化！

**直接描述您的桌面应用需求**，系统会自动选择最适合的开发模式：

- 工具类应用 → 基于Tkinter的轻量级工具开发
- 专业软件 → 基于PyQt/PySide的企业级应用架构
- 游戏应用 → 基于Kivy的交互式游戏开发
- 科学计算 → 集成matplotlib、numpy的数据可视化应用

**享受Python生态的现代化桌面开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Python桌面应用项目优化*