# Python通用项目规范

## 📋 项目特征

- **适用场景**: 库开发、命令行工具、数据处理脚本、企业级应用、科学计算、API开发
- **技术栈**: Python 3.11+ + pyproject.toml + src布局 + 现代工具链
- **架构模式**: 模块化设计 + 声明式配置 + 标准化打包
- **部署方式**: 🚀 PyPI分发 + Docker容器化 + 多平台支持
- **特点**: 官方标准结构、现代配置、完整生态、95%项目覆盖

## 🏗️ 通用标准项目结构（基于2025年最佳实践）

```
python-general-project/
├── src/                          # 📁 源代码(src布局-2025推荐)
│   └── mypackage/                # 包目录
│       ├── __init__.py           # 包初始化
│       ├── main.py               # 主模块/CLI入口
│       ├── core/                 # 核心业务逻辑
│       │   ├── __init__.py
│       │   ├── models.py         # 数据模型
│       │   ├── services.py       # 业务服务
│       │   └── utils.py          # 工具函数
│       ├── api/                  # API接口层(可选)
│       │   ├── __init__.py
│       │   ├── routes.py         # 路由定义
│       │   └── handlers.py       # 请求处理
│       ├── data/                 # 数据访问层
│       │   ├── __init__.py
│       │   ├── database.py       # 数据库操作
│       │   └── repositories.py   # 数据仓库
│       ├── config/               # 配置管理
│       │   ├── __init__.py
│       │   ├── settings.py       # 应用设置
│       │   └── constants.py      # 常量定义
│       └── cli/                  # 命令行接口(可选)
│           ├── __init__.py
│           ├── commands.py       # CLI命令
│           └── parsers.py        # 参数解析
├── tests/                        # 🧪 测试文件
│   ├── __init__.py
│   ├── unit/                     # 单元测试
│   │   ├── test_models.py
│   │   ├── test_services.py
│   │   └── test_utils.py
│   ├── integration/              # 集成测试
│   │   ├── test_api.py
│   │   └── test_database.py
│   ├── fixtures/                 # 测试数据
│   │   ├── data.json
│   │   └── mock_data.py
│   └── conftest.py               # pytest配置
├── docs/                         # 📚 项目文档
│   ├── source/                   # Sphinx源文件
│   ├── _build/                   # 构建输出
│   ├── api.md                    # API文档
│   ├── usage.md                  # 使用指南
│   └── contributing.md           # 贡献指南
├── scripts/                      # 📜 辅助脚本
│   ├── build.py                  # 构建脚本
│   ├── test.py                   # 测试脚本
│   └── deploy.py                 # 部署脚本
├── .github/                      # GitHub配置
│   ├── workflows/                # GitHub Actions
│   │   ├── ci.yml                # 持续集成
│   │   └── publish.yml           # 发布流程
│   └── ISSUE_TEMPLATE.md         # 问题模板
├── pyproject.toml                # 🔧 现代Python项目配置
├── README.md                     # 项目说明
├── CHANGELOG.md                  # 更新日志
├── LICENSE                       # 开源许可
├── .gitignore                    # Git忽略文件
├── .editorconfig                 # 编辑器配置
├── requirements.txt              # 📋 基础依赖(兼容性)
├── requirements-dev.txt          # 开发依赖
└── Makefile                      # 🛠️ 构建工具
```

## 🔧 2025年技术栈标准

### **现代Python配置特性**

**Python 3.11+ 最新特性**
- **Python 3.11+** - 性能提升、错误信息改进、类型系统增强
- **pyproject.toml** - PEP 518标准配置，替代setup.py
- **src布局** - 避免导入路径问题，提升打包可靠性
- **类型注解** - 完整的类型提示和静态检查支持

**现代化构建和依赖管理**
- **setuptools 70+** - 现代化构建后端
- **wheel** - 二进制分发格式
- **pip 23+** - 最新包管理器
- **uv** - 超快速Python包管理器(可选)

### **pyproject.toml配置示例**

```toml
[build-system]
requires = ["setuptools>=70.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "mypackage"
version = "0.1.0"
description = "A modern Python project"
readme = "README.md"
license = {text = "MIT"}
authors = [
    {name = "Your Name", email = "your.email@example.com"}
]
maintainers = [
    {name = "Your Name", email = "your.email@example.com"}
]
classifiers = [
    "Development Status :: 3 - Alpha",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
]
requires-python = ">=3.11"
dependencies = [
    "requests>=2.31.0",
    "click>=8.1.0",
    "pydantic>=2.5.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.4.0",
    "pytest-cov>=4.1.0",
    "ruff>=0.1.0",
    "black>=23.0.0",
    "mypy>=1.7.0",
]
docs = [
    "sphinx>=7.0.0",
    "sphinx-rtd-theme>=1.3.0",
]
test = [
    "pytest>=7.4.0",
    "pytest-cov>=4.1.0",
    "pytest-mock>=3.12.0",
]

[project.scripts]
mypackage = "mypackage.main:cli"

[project.urls]
Homepage = "https://github.com/username/mypackage"
Documentation = "https://mypackage.readthedocs.io"
Repository = "https://github.com/username/mypackage.git"
Issues = "https://github.com/username/mypackage/issues"

[tool.setuptools.packages.find]
where = ["src"]

[tool.ruff]
line-length = 88
target-version = "py311"
select = [
    "E",  # pycodestyle errors
    "W",  # pycodestyle warnings
    "F",  # pyflakes
    "I",  # isort
    "B",  # flake8-bugbear
    "C4", # flake8-comprehensions
    "UP", # pyupgrade
]

[tool.black]
line-length = 88
target-version = ['py311']
include = '\.pyi?$'

[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
check_untyped_defs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = [
    "--strict-markers",
    "--strict-config",
    "--cov=src",
    "--cov-report=term-missing",
    "--cov-report=html",
]

[tool.coverage.run]
source = ["src"]
omit = ["*/tests/*"]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise AssertionError",
    "raise NotImplementedError",
]
```

## 📜 2025年标准化 Makefile

```makefile
.PHONY: install dev test lint format type-check build clean publish help

# 项目配置
PROJECT_NAME = mypackage
PYTHON_VERSION = 3.11

help:
	@echo "🐍 Python通用项目开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  install       - 安装项目依赖"
	@echo "  dev           - 安装开发环境"
	@echo "  test          - 运行测试"
	@echo "  lint          - 代码质量检查"
	@echo "  format        - 代码格式化"
	@echo "  type-check    - 类型检查"
	@echo ""
	@echo "🏗️  构建发布:"
	@echo "  build         - 构建分发包"
	@echo "  publish       - 发布到PyPI"
	@echo "  clean         - 清理构建文件"
	@echo ""
	@echo "🧹 维护:"
	@echo "  health-check  - 项目健康检查"

install:
	@echo "📦 安装项目依赖..."
	pip install -e .
	@echo "✅ 依赖安装完成!"

dev:
	@echo "🔧 安装开发环境..."
	pip install -e ".[dev,test,docs]"
	pre-commit install
	@echo "✅ 开发环境设置完成!"

test:
	@echo "🧪 运行测试..."
	pytest
	@echo "✅ 测试完成!"

lint:
	@echo "🔍 代码质量检查..."
	ruff check src/ tests/
	@echo "✅ 代码检查完成!"

format:
	@echo "✨ 代码格式化..."
	black src/ tests/
	ruff check --fix src/ tests/
	@echo "✅ 格式化完成!"

type-check:
	@echo "📝 类型检查..."
	mypy src/
	@echo "✅ 类型检查完成!"

build:
	@echo "🏗️ 构建分发包..."
	python -m build
	@echo "✅ 构建完成!"

publish:
	@echo "📡 发布到PyPI..."
	python -m twine upload dist/*
	@echo "✅ 发布完成!"

clean:
	@echo "🧹 清理构建文件..."
	rm -rf build/ dist/ *.egg-info/
	find . -type d -name __pycache__ -delete
	find . -name "*.pyc" -delete
	rm -rf .pytest_cache/ .coverage htmlcov/
	@echo "✅ 清理完成!"

health-check:
	@echo "🏥 项目健康检查..."
	python -m py_compile src/$(PROJECT_NAME)/*.py
	ruff check src/ tests/
	mypy src/
	pytest tests/ -x
	@echo "✅ 健康检查完成!"

# 虚拟环境管理
venv:
	@echo "🐍 创建虚拟环境..."
	python -m venv .venv
	@echo "📝 请运行: source .venv/bin/activate"

# 依赖管理
freeze:
	@echo "❄️ 锁定依赖版本..."
	pip freeze > requirements.txt
	@echo "✅ 依赖版本已锁定!"

upgrade:
	@echo "⬆️ 升级依赖..."
	pip install --upgrade pip setuptools wheel
	pip install --upgrade -e ".[dev,test,docs]"
	@echo "✅ 依赖升级完成!"
```

## 📝 核心代码文件示例

### **现代化包入口 (src/mypackage/__init__.py)**

```python
"""
MyPackage - 现代Python通用项目
基于2025年最佳实践设计的Python包
"""

from importlib.metadata import version, PackageNotFoundError

try:
    __version__ = version("mypackage")
except PackageNotFoundError:
    # 开发环境中包未安装时的回退
    __version__ = "dev"

__all__ = [
    "__version__",
    "main",
    "core",
]

# 暴露主要模块
from . import core
from .main import main

# 类型检查支持
if __name__ == "__main__":
    from typing import TYPE_CHECKING
    if TYPE_CHECKING:
        pass
```

### **命令行接口 (src/mypackage/main.py)**

```python
#!/usr/bin/env python3
"""
主应用程序入口和CLI接口
基于Click的现代命令行应用
"""

import sys
import logging
from pathlib import Path
from typing import Optional

import click
from pydantic import ValidationError

from .core.services import AppService
from .config.settings import AppSettings
from .core.exceptions import AppError


def setup_logging(level: str = "INFO") -> None:
    """配置日志系统"""
    logging.basicConfig(
        level=getattr(logging, level.upper()),
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(sys.stdout),
        ]
    )


@click.group()
@click.version_option()
@click.option(
    "--config", 
    "-c",
    type=click.Path(exists=True, path_type=Path),
    help="配置文件路径"
)
@click.option(
    "--log-level",
    default="INFO",
    type=click.Choice(["DEBUG", "INFO", "WARNING", "ERROR"]),
    help="日志级别"
)
@click.pass_context
def cli(ctx: click.Context, config: Optional[Path], log_level: str) -> None:
    """MyPackage - 现代Python应用程序"""
    setup_logging(log_level)
    
    try:
        # 加载配置
        if config:
            settings = AppSettings.from_file(config)
        else:
            settings = AppSettings()
        
        # 初始化服务
        service = AppService(settings)
        
        # 传递给子命令
        ctx.ensure_object(dict)
        ctx.obj["service"] = service
        ctx.obj["settings"] = settings
        
    except ValidationError as e:
        click.echo(f"配置错误: {e}", err=True)
        sys.exit(1)
    except Exception as e:
        click.echo(f"初始化失败: {e}", err=True)
        sys.exit(1)


@cli.command()
@click.argument("input_file", type=click.Path(exists=True, path_type=Path))
@click.option("--output", "-o", type=click.Path(path_type=Path), help="输出文件")
@click.option("--format", default="json", help="输出格式")
@click.pass_context
def process(
    ctx: click.Context, 
    input_file: Path, 
    output: Optional[Path],
    format: str
) -> None:
    """处理输入文件"""
    service: AppService = ctx.obj["service"]
    
    try:
        result = service.process_file(input_file, format=format)
        
        if output:
            output.write_text(result)
            click.echo(f"结果已保存到: {output}")
        else:
            click.echo(result)
            
    except AppError as e:
        click.echo(f"处理错误: {e}", err=True)
        sys.exit(1)


def main() -> int:
    """应用程序入口点"""
    try:
        cli()
        return 0
    except KeyboardInterrupt:
        click.echo("\n中断操作", err=True)
        return 130
    except Exception as e:
        click.echo(f"未预期错误: {e}", err=True)
        return 1


if __name__ == "__main__":
    sys.exit(main())
```

### **配置管理 (src/mypackage/config/settings.py)**

```python
"""
应用程序配置管理
基于Pydantic的现代配置管理
"""

import os
import json
from pathlib import Path
from typing import Optional, Dict, Any

from pydantic import BaseModel, Field, validator
from pydantic_settings import BaseSettings


class AppSettings(BaseSettings):
    """应用程序设置"""
    
    # 基本信息
    app_name: str = "MyPackage"
    version: str = "0.1.0"
    debug: bool = False
    
    # 文件路径
    data_dir: Path = Field(default_factory=lambda: Path.home() / ".mypackage")
    config_file: Optional[Path] = None
    
    # 功能开关
    enable_cache: bool = True
    cache_ttl: int = 3600
    
    class Config:
        env_prefix = "MYPACKAGE_"
        case_sensitive = False
        
    @validator("data_dir")
    def ensure_data_dir(cls, v: Path) -> Path:
        """确保数据目录存在"""
        v.mkdir(parents=True, exist_ok=True)
        return v
    
    @classmethod
    def from_file(cls, config_file: Path) -> "AppSettings":
        """从配置文件加载设置"""
        if not config_file.exists():
            raise FileNotFoundError(f"配置文件不存在: {config_file}")
        
        with open(config_file, 'r', encoding='utf-8') as f:
            config_data = json.load(f)
        
        config_data['config_file'] = config_file
        return cls(**config_data)
```

## 🚀 现代化开发流程

### **项目初始化**

```bash
# 1. 创建项目目录
mkdir mypackage && cd mypackage

# 2. 创建虚拟环境
python -m venv .venv
source .venv/bin/activate  # Linux/macOS

# 3. 创建src布局结构
mkdir -p src/mypackage tests docs scripts

# 4. 初始化pyproject.toml
touch pyproject.toml README.md .gitignore

# 5. 安装开发环境
make dev
```

### **日常开发工作流**

```bash
# 🔧 开发环境管理
make dev           # 安装开发依赖
make test          # 运行测试套件
make lint          # 代码质量检查
make format        # 代码格式化

# 🧪 测试和质量检查
make type-check    # MyPy类型检查
make health-check  # 完整项目健康检查

# 📦 构建和发布
make build         # 构建wheel和源码包
make publish       # 发布到PyPI
make clean         # 清理构建文件
```

## 📚 2025年Python参考资源

### **官方文档**

- [Python 3.11+ 官方文档](https://docs.python.org/3/) - 最权威的Python学习资源
- [Python包装用户指南](https://packaging.python.org/) - 现代Python打包最佳实践
- [PEP 518 - pyproject.toml](https://peps.python.org/pep-0518/) - 现代构建系统标准
- [PEP 621 - 项目元数据](https://peps.python.org/pep-0621/) - pyproject.toml项目配置

### **最佳实践指南**

- src布局vs平铺布局的选择和实施建议
- pyproject.toml声明式配置和现代化项目管理
- 现代化Python工具链(Ruff+Black+MyPy)集成方案
- 95%Python通用项目需求覆盖的标准化架构模式

---

**✨ 这个模板基于Python官方文档和2025年最佳实践，为Python通用项目提供完整的现代化开发解决方案。**