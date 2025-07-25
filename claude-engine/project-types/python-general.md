# CLAUDE.md - Python通用项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Python通用项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Python通用项目
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

### **🐍 Python通用开发特色功能**

#### **Python核心特性**
- **现代Python语法**: Python 3.9+特性，类型注解和数据类
- **包管理**: pip、Poetry、conda多种包管理工具支持
- **虚拟环境**: venv、virtualenv、conda环境隔离
- **异步编程**: asyncio、异步生成器和上下文管理器

#### **项目类型覆盖**
- **命令行工具**: Click、Typer、argparse构建CLI应用
- **数据处理**: pandas、numpy、scipy科学计算工具
- **自动化脚本**: 系统管理、文件处理、定时任务
- **库和包开发**: 可重用代码模块和分发包

#### **现代开发实践**
- **类型检查**: mypy、PyRight静态类型验证
- **代码质量**: flake8、pylint、black、ruff代码检查
- **测试驱动**: pytest、unittest、doctest测试框架
- **文档生成**: Sphinx、MkDocs自动化文档

#### **标准Python通用项目结构支持**
```
python-general项目/
├── src/
│   ├── core/                    # 核心模块
│   │   ├── __init__.py          # 包初始化
│   │   ├── config.py            # 配置管理
│   │   ├── exceptions.py        # 自定义异常
│   │   └── constants.py         # 常量定义
│   ├── utils/                   # 工具函数
│   │   ├── __init__.py
│   │   ├── helpers.py           # 助手函数
│   │   ├── decorators.py        # 装饰器
│   │   └── validators.py        # 验证函数
│   ├── models/                  # 数据模型
│   │   ├── __init__.py
│   │   └── base.py              # 基础模型
│   ├── services/                # 业务逻辑
│   │   ├── __init__.py
│   │   └── base_service.py      # 基础服务
│   └── main.py                  # 主程序入口
├── tests/                       # 测试文件
│   ├── unit/                    # 单元测试
│   ├── integration/             # 集成测试
│   ├── fixtures/                # 测试夹具
│   └── conftest.py              # pytest配置
├── scripts/                     # 脚本文件
│   ├── setup.py                 # 设置脚本
│   ├── build.py                 # 构建脚本
│   └── deploy.py                # 部署脚本
├── docs/                        # 项目文档
│   ├── source/                  # Sphinx源文件
│   ├── build/                   # 构建输出
│   └── requirements.txt         # 文档依赖
├── examples/                    # 示例代码
├── data/                        # 数据文件
├── config/                      # 配置文件
│   ├── development.yaml         # 开发配置
│   ├── production.yaml          # 生产配置
│   └── logging.yaml             # 日志配置
├── requirements/                # 依赖管理
│   ├── base.txt                 # 基础依赖
│   ├── dev.txt                  # 开发依赖
│   ├── test.txt                 # 测试依赖
│   └── prod.txt                 # 生产依赖
├── .env.example                 # 环境变量模板
├── .gitignore                   # Git忽略文件
├── pyproject.toml              # 项目配置
├── setup.py                    # 包安装脚本
├── requirements.txt            # 主要依赖
├── README.md                   # 项目说明
├── CHANGELOG.md                # 变更日志
└── LICENSE                     # 许可证
```

#### **智能开发和构建**
```bash
# 创建虚拟环境
python -m venv venv
source venv/bin/activate  # Linux/macOS
venv\Scripts\activate     # Windows

# 安装依赖
pip install -r requirements.txt
pip install -r requirements/dev.txt

# 运行主程序
python src/main.py
python -m src.main

# 运行测试
pytest tests/ -v
python -m pytest tests/ --cov=src

# 代码质量检查
ruff check src/
ruff format src/
mypy src/
pylint src/

# 构建分发包
python setup.py sdist bdist_wheel
python -m build

# 安装本地包
pip install -e .

# 生成文档
sphinx-build -b html docs/source docs/build
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: Python项目架构设计和算法逻辑分析
- **context7**: 动态获取Python生态最新文档和最佳实践
- **memory**: Python开发经验自动复用和设计模式库
- **puppeteer**: Python应用自动化测试和CLI工具测试

#### **全局规则遵守**
- **Python代码规范**: 自动应用PEP 8和PEP 257最佳实践
- **包管理规范**: 依赖锁定、版本控制、安全更新
- **测试覆盖**: 单元测试、集成测试、文档测试
- **文档标准**: 类型注解、docstring、API文档自动生成

#### **Python通用专项智能特性**
- **包结构设计**: 模块化设计和命名空间管理
- **异常处理**: 异常层次结构和错误传播模式
- **配置管理**: 多环境配置和敏感信息保护
- **性能优化**: 内存管理、算法优化、并发编程

### **📋 Python通用开发建议**

#### **开始开发**
1. 描述项目需求，如："创建数据处理和分析工具"
2. 系统会自动设计模块结构和依赖关系
3. 生成符合Python最佳实践的项目框架

#### **模块开发**
1. 说明功能需求，如："实现文件批处理功能"
2. 系统会设计类和函数结构，处理异常和配置
3. 自动生成类型注解、文档字符串和测试用例

#### **工具开发**
1. 描述工具需求，如："创建命令行数据转换工具"
2. 系统会设计CLI接口和参数解析
3. 确保跨平台兼容性和用户友好的输出

### **🔧 开发工具集成**

#### **开发环境**
- **Python 3.9+**: 现代Python运行时环境
- **Poetry**: 现代依赖管理和打包工具
- **pipenv**: 依赖管理和虚拟环境
- **pyenv**: Python版本管理

#### **代码质量**
- **Ruff**: 极速Python代码检查和格式化
- **mypy**: 静态类型检查
- **pylint**: 代码质量分析
- **black**: 代码自动格式化

#### **测试框架**
- **pytest**: 现代Python测试框架
- **unittest**: Python标准库测试框架
- **doctest**: 文档测试
- **coverage**: 代码覆盖率分析

#### **构建和发布**
- **setuptools**: 包构建和分发
- **wheel**: 现代Python包格式
- **twine**: PyPI包上传工具
- **build**: PEP 517构建工具

### **📈 效率提升**

相比传统Python开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: 模块结构和函数框架自动生成，提升3-4倍效率
- 🎯 **代码质量**: 基于Python最佳实践的高质量代码生成
- 🔄 **模式复用**: 智能识别可复用的代码模式和设计模式
- 📊 **性能优化**: 自动应用Python性能优化技巧
- 🧪 **测试覆盖**: 自动生成完整的测试用例和文档

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **开发环境问题**
```bash
# 检查Python版本
python --version
python3 --version

# 创建虚拟环境
python -m venv venv
python3 -m venv venv

# 激活虚拟环境
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# 检查虚拟环境
which python
pip list
```

#### **依赖问题**
```bash
# 更新pip和工具
python -m pip install --upgrade pip
pip install --upgrade setuptools wheel

# 清理pip缓存
pip cache purge

# 重新安装依赖
pip uninstall -y -r requirements.txt
pip install -r requirements.txt

# 检查依赖冲突
pip check
pipdeptree --warn conflict

# 更新过时包
pip list --outdated
pip install --upgrade <package_name>
```

#### **包管理问题**
```bash
# Poetry问题
poetry install
poetry update
poetry lock --no-update
poetry env info

# 检查pyproject.toml
poetry check

# 重建Poetry环境
poetry env remove python
poetry install

# 包导入问题
python -c "import sys; print(sys.path)"
python -c "import <module_name>; print(<module_name>.__file__)"
```

#### **测试问题**
```bash
# pytest问题调试
pytest --collect-only
pytest -v --tb=short
pytest --lf  # 只运行失败的测试

# 测试发现问题
pytest --ignore=venv
python -m pytest tests/

# 覆盖率问题
pytest --cov=src tests/
coverage run -m pytest tests/
coverage report
coverage html

# 测试环境问题
pytest --no-cov  # 禁用覆盖率
pytest -p no:warnings  # 禁用警告
```

#### **代码质量问题**
```bash
# Ruff使用
ruff check src/
ruff format src/
ruff --fix src/

# mypy类型检查
mypy src/
mypy --install-types
mypy --config-file mypy.ini src/

# pylint使用
pylint src/
pylint --generate-rcfile > .pylintrc

# 修复常见问题
autopep8 --in-place --recursive src/
isort src/
```

#### **包构建问题**
```bash
# 检查setup.py/pyproject.toml
python setup.py check
python -m build --sdist --wheel

# 安装本地包
pip install -e .
pip install .

# 检查包内容
python setup.py egg_info
python -c "import <package>; print(<package>.__version__)"

# 分发检查
twine check dist/*
python -m pip install --index-url https://test.pypi.org/simple/ <package>
```

---

## 🚀 **开始Python智能开发之旅**

智能Claude Autopilot 2.1专为Python通用开发优化！

**直接描述您的Python项目需求**，系统会自动选择最适合的开发模式：

- 数据处理 → 基于pandas和numpy的数据科学工具
- 命令行工具 → 基于Click或Typer的用户友好CLI
- 自动化脚本 → 系统管理和任务自动化脚本
- 库开发 → 可重用的Python包和模块

**享受Python生态的强大开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Python通用项目优化*