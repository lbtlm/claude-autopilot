#!/bin/bash

# Claude Autopilot 2.1 国际化功能管理器
# 提供中英文双语支持和本地化配置

# 动态检测路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_CE_PATH="$(dirname "$SCRIPT_DIR")"
I18N_CONFIG_FILE="$GLOBAL_CE_PATH/i18n-config.json"
DEFAULT_LANGUAGE="chinese"
SUPPORTED_LANGUAGES=("chinese" "english")

# 初始化国际化管理器
init_internationalization_manager() {
    local project_path="$1"
    local project_type="$2"
    local project_name="$3"
    
    echo "🌍 初始化国际化管理器..."
    
    # 检测用户语言偏好
    detect_user_language_preference "$project_path"
    
    # 创建项目国际化配置
    create_project_i18n_config "$project_path" "$project_name"
    
    # 生成双语README
    generate_bilingual_readme "$project_path" "$project_name" "$project_type"
    
    # 创建多语言脚本别名
    create_multilingual_aliases "$project_path"
    
    echo "✅ 国际化管理器初始化完成"
}

# 检测用户语言偏好
detect_user_language_preference() {
    local project_path="$1"
    
    # 检测系统语言环境
    local system_lang=""
    if [ -n "$LANG" ]; then
        case "$LANG" in
            zh_*|zh-*)
                system_lang="chinese"
                ;;
            en_*|en-*)
                system_lang="english"
                ;;
            *)
                system_lang="english"  # 默认英语
                ;;
        esac
    else
        system_lang="english"
    fi
    
    # 检查是否有用户配置的偏好
    local user_pref="$DEFAULT_LANGUAGE"
    if [ -f "$HOME/.claude-ce-config" ]; then
        local saved_pref=$(grep "language=" "$HOME/.claude-ce-config" | cut -d= -f2)
        if [[ " ${SUPPORTED_LANGUAGES[@]} " =~ " ${saved_pref} " ]]; then
            user_pref="$saved_pref"
        fi
    fi
    
    echo "   🗣️ 检测语言偏好:"
    echo "     系统语言: $system_lang"
    echo "     用户偏好: $user_pref"
    
    # 保存语言配置到项目
    echo "language=$user_pref" > "$project_path/.claude-lang"
}

# 创建项目国际化配置
create_project_i18n_config() {
    local project_path="$1"
    local project_name="$2"
    
    mkdir -p "$project_path/.claude"
    local config_file="$project_path/.claude/i18n-config.json"
    
    cat > "$config_file" << EOF
{
  "version": "2.0.0",
  "project_name": "$project_name",
  "default_language": "$DEFAULT_LANGUAGE",
  "supported_languages": ["chinese", "english"],
  "ui_strings": {
    "chinese": {
      "welcome": "欢迎使用智能Claude Autopilot 2.1",
      "project_initialized": "项目初始化完成",
      "health_check": "项目健康度检查",
      "deployment_ready": "部署就绪",
      "commands": {
        "智能功能开发": "一键式完整功能开发",
        "智能Bug修复": "智能问题诊断和修复",
        "智能代码重构": "基于最佳实践的智能重构",
        "加载全局上下文": "重新加载全局上下文和经验",
        "智能工作总结提交": "智能工作总结和规范提交",
        "智能部署推送Docker": "智能Docker部署推送",
        "智能项目结构校验": "项目结构完整性校验",
        "智能项目规划": "智能项目规划和需求分析"
      },
      "status": {
        "success": "成功",
        "error": "错误",
        "warning": "警告",
        "info": "信息",
        "in_progress": "进行中",
        "completed": "已完成"
      },
      "health_levels": {
        "excellent": "优秀",
        "good": "良好", 
        "fair": "一般",
        "poor": "较差",
        "critical": "危险"
      }
    },
    "english": {
      "welcome": "Welcome to Intelligent Claude Autopilot 2.1",
      "project_initialized": "Project initialization completed",
      "health_check": "Project health assessment",
      "deployment_ready": "Deployment ready",
      "commands": {
        "smart-feature-dev": "One-click complete feature development",
        "smart-bugfix": "Intelligent problem diagnosis and repair",
        "smart-code-refactor": "Smart refactoring based on best practices",
        "load-global-context": "Reload global context and experience",
        "smart-work-summary": "Intelligent work summary and standard submission",
        "smart-docker-deploy": "Smart Docker deployment push",
        "smart-structure-validation": "Project structure integrity validation",
        "smart-project-planning": "Smart project planning and requirements analysis"
      },
      "status": {
        "success": "Success",
        "error": "Error", 
        "warning": "Warning",
        "info": "Info",
        "in_progress": "In Progress",
        "completed": "Completed"
      },
      "health_levels": {
        "excellent": "Excellent",
        "good": "Good",
        "fair": "Fair", 
        "poor": "Poor",
        "critical": "Critical"
      }
    }
  },
  "command_mappings": {
    "智能功能开发": "smart-feature-dev",
    "smart-feature-dev": "smart-feature-dev",
    "智能Bug修复": "smart-bugfix",
    "smart-bugfix": "smart-bugfix",
    "智能代码重构": "smart-code-refactor",
    "smart-code-refactor": "smart-code-refactor",
    "加载全局上下文": "load-global-context",
    "load-global-context": "load-global-context",
    "智能工作总结提交": "smart-work-summary",
    "smart-work-summary": "smart-work-summary",
    "智能部署推送Docker": "smart-docker-deploy",
    "smart-docker-deploy": "smart-docker-deploy",
    "智能项目结构校验": "smart-structure-validation", 
    "smart-structure-validation": "smart-structure-validation",
    "智能项目规划": "smart-project-planning",
    "smart-project-planning": "smart-project-planning"
  },
  "created_at": "$(date -Iseconds)",
  "notes": "Bilingual support for Claude Autopilot 2.1 system"
}
EOF
    
    echo "   ✅ 国际化配置: .claude/i18n-config.json"
}

# 获取本地化字符串
get_localized_string() {
    local key="$1"
    local language="$2"
    local config_file="$3"
    
    # 如果没有指定语言，使用默认语言
    if [ -z "$language" ]; then
        language="$DEFAULT_LANGUAGE"
    fi
    
    # 使用python解析JSON获取本地化字符串（如果可用）
    if command -v python3 &> /dev/null && [ -f "$config_file" ]; then
        local result=$(python3 -c "
import json
try:
    with open('$config_file', 'r', encoding='utf-8') as f:
        data = json.load(f)
    keys = '$key'.split('.')
    value = data.get('ui_strings', {}).get('$language', {})
    for k in keys:
        if isinstance(value, dict):
            value = value.get(k, '$key')
        else:
            value = '$key'
            break
    print(value)
except:
    print('$key')
")
        echo "$result"
    else
        # 降级方案：返回原key
        echo "$key"
    fi
}

# 生成双语README
generate_bilingual_readme() {
    local project_path="$1"
    local project_name="$2" 
    local project_type="$3"
    
    # 如果README.md已存在且内容充实，就不覆盖
    if [ -f "$project_path/README.md" ] && [ $(wc -c < "$project_path/README.md" 2>/dev/null || echo 0) -gt 1000 ]; then
        echo "   ℹ️ README.md已存在且内容充实，跳过生成"
        return
    fi
    
    echo "📝 生成双语README..."
    
    cat > "$project_path/README.md" << EOF
# $project_name

[English](#english) | [中文](#中文)

---

## 中文

智能Claude Autopilot 2.1项目。

### 🚀 快速开始

#### 环境要求
- 适合$project_type项目的运行环境
- Docker (可选，用于容器化部署)

#### 安装依赖
\`\`\`bash
# 安装项目依赖
make install
\`\`\`

#### 环境配置
\`\`\`bash
# 复制环境变量文件并配置
cp .env.example .env
vim .env
\`\`\`

#### 运行项目
\`\`\`bash
# 开发模式
make dev

# 生产模式
make prod
\`\`\`

### 🛠️ 开发

#### 代码质量检查
\`\`\`bash
make lint      # 代码规范检查
make test      # 运行测试
make typecheck # 类型检查（如适用）
\`\`\`

#### 智能开发命令

本项目集成了智能Claude Autopilot 2.1系统，支持以下智能命令：

\`\`\`bash
# 核心开发流程
/智能功能开发 <功能描述>     # 一键式完整功能开发
/智能Bug修复 <问题描述>      # 智能问题诊断和修复  
/智能代码重构 <重构目标>     # 基于最佳实践的智能重构

# 辅助工具
/加载全局上下文              # 重新加载全局上下文和经验
/智能工作总结提交            # 智能工作总结和规范提交
/智能项目结构校验            # 项目结构完整性校验
\`\`\`

### 🚀 部署

#### Docker部署
\`\`\`bash
# 配置Docker环境变量
cp .env.example .env.docker
vim .env.docker

# 使用智能部署命令
/智能部署推送Docker

# 或手动部署
./deployments/scripts/deploy-docker.sh
\`\`\`

#### 生产部署
\`\`\`bash
# 设置镜像仓库和版本
export DOCKER_REGISTRY=your-registry.com
export VERSION=v1.0.0

# 执行生产部署
./deployments/scripts/deploy-production.sh
\`\`\`

### 📚 文档

- [API接口文档](project_docs/API.md)
- [数据库设计文档](project_docs/DATABASE.md) 
- [部署说明文档](project_docs/DEPLOYMENT.md)
- [项目架构文档](project_docs/ARCHITECTURE.md)

### 🤝 参与贡献

1. Fork 本仓库
2. 创建特性分支 (\`git checkout -b feature/AmazingFeature\`)
3. 提交更改 (\`git commit -m 'Add some AmazingFeature'\`)
4. 推送到分支 (\`git push origin feature/AmazingFeature\`)
5. 创建 Pull Request

---

## English

Intelligent Claude Autopilot 2.1 project.

### 🚀 Quick Start

#### Prerequisites
- Runtime environment suitable for $project_type projects
- Docker (optional, for containerized deployment)

#### Install Dependencies
\`\`\`bash
# Install project dependencies
make install
\`\`\`

#### Environment Setup
\`\`\`bash
# Copy and configure environment variables
cp .env.example .env
vim .env
\`\`\`

#### Run Project
\`\`\`bash
# Development mode
make dev

# Production mode  
make prod
\`\`\`

### 🛠️ Development

#### Code Quality Checks
\`\`\`bash
make lint      # Code style check
make test      # Run tests
make typecheck # Type checking (if applicable)
\`\`\`

#### Smart Development Commands

This project integrates the Intelligent Claude Autopilot 2.1 system with the following smart commands:

\`\`\`bash
# Core development workflow
/smart-feature-dev <description>    # One-click complete feature development
/smart-bugfix <problem>             # Intelligent problem diagnosis and repair
/smart-code-refactor <target>       # Smart refactoring based on best practices

# Assistant tools
/load-global-context                # Reload global context and experience
/smart-work-summary                 # Intelligent work summary and standard submission
/smart-structure-validation         # Project structure integrity validation
\`\`\`

### 🚀 Deployment

#### Docker Deployment
\`\`\`bash
# Configure Docker environment variables
cp .env.example .env.docker
vim .env.docker

# Use smart deployment command
/smart-docker-deploy

# Or manual deployment
./deployments/scripts/deploy-docker.sh
\`\`\`

#### Production Deployment
\`\`\`bash
# Set registry and version
export DOCKER_REGISTRY=your-registry.com
export VERSION=v1.0.0

# Execute production deployment
./deployments/scripts/deploy-production.sh
\`\`\`

### 📚 Documentation

- [API Documentation](project_docs/API.md)
- [Database Design](project_docs/DATABASE.md)
- [Deployment Guide](project_docs/DEPLOYMENT.md) 
- [Architecture Documentation](project_docs/ARCHITECTURE.md)

### 🤝 Contributing

1. Fork the repository
2. Create a feature branch (\`git checkout -b feature/AmazingFeature\`)
3. Commit your changes (\`git commit -m 'Add some AmazingFeature'\`)
4. Push to the branch (\`git push origin feature/AmazingFeature\`)
5. Create a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*本项目由智能Claude Autopilot 2.1系统生成 | This project is generated by Intelligent Claude Autopilot 2.1 system*
EOF
    
    echo "   ✅ 双语README: README.md"
}

# 创建多语言脚本别名
create_multilingual_aliases() {
    local project_path="$1"
    
    echo "🔗 创建多语言脚本别名..."
    
    # 创建中文命令脚本目录
    mkdir -p "$project_path/.claude/scripts"
    
    # 创建中文命令包装脚本
    local chinese_wrapper="$project_path/.claude/scripts/chinese-commands.sh"
    cat > "$chinese_wrapper" << 'EOF'
#!/bin/bash

# 中文命令包装脚本
# 将中文命令转换为英文文件名并执行

# 动态检测Claude Autopilot路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_CE_PATH="$(dirname "$SCRIPT_DIR")"
source "$GLOBAL_CE_PATH/utils/alias-resolver.sh"

# 解析中文命令
CHINESE_COMMAND="$1"
shift  # 移除第一个参数，保留其余参数

# 解析为英文文件名
ENGLISH_COMMAND=$(resolve_command_alias "$CHINESE_COMMAND")

if [ "$ENGLISH_COMMAND" = "$CHINESE_COMMAND" ]; then
    echo "⚠️ 未找到命令映射: $CHINESE_COMMAND"
    echo "可用命令请查看: .claude/commands/"
    exit 1
fi

# 查找对应的命令文件
COMMAND_FILE=$(check_command_file_exists "$CHINESE_COMMAND")

if [ $? -ne 0 ]; then
    echo "❌ 命令文件不存在: $CHINESE_COMMAND"
    exit 1
fi

# 显示正在执行的命令
echo "🎯 执行命令: $CHINESE_COMMAND -> $ENGLISH_COMMAND"
echo "📄 文件: $COMMAND_FILE"

# 这里可以添加实际的命令执行逻辑
# 例如：解析markdown文件并执行其中的脚本
echo "✅ 命令映射成功"
EOF
    
    chmod +x "$chinese_wrapper"
    echo "   ✅ 中文命令包装器: .claude/scripts/chinese-commands.sh"
    
    # 创建快捷执行脚本
    local quick_exec="$project_path/.claude/scripts/exec-command.sh"
    cat > "$quick_exec" << 'EOF'
#!/bin/bash

# 快捷命令执行脚本
# 支持中英文命令的统一入口

COMMAND_NAME="$1"
shift

# 检测语言偏好
LANG_PREF="chinese"
if [ -f ".claude-lang" ]; then
    LANG_PREF=$(cat .claude-lang | grep "language=" | cut -d= -f2)
fi

# 根据语言偏好显示消息
if [ "$LANG_PREF" = "chinese" ]; then
    echo "🚀 执行智能命令: $COMMAND_NAME"
    echo "💡 提示: 您也可以使用英文命令名"
else
    echo "🚀 Executing smart command: $COMMAND_NAME" 
    echo "💡 Tip: You can also use Chinese command names"
fi

# 调用命令解析和执行
source .claude/scripts/chinese-commands.sh "$COMMAND_NAME" "$@"
EOF
    
    chmod +x "$quick_exec"
    echo "   ✅ 快捷执行脚本: .claude/scripts/exec-command.sh"
}

# 设置用户语言偏好
set_user_language_preference() {
    local language="$1"
    
    if [[ ! " ${SUPPORTED_LANGUAGES[@]} " =~ " ${language} " ]]; then
        echo "❌ 不支持的语言: $language"
        echo "支持的语言: ${SUPPORTED_LANGUAGES[*]}"
        return 1
    fi
    
    # 保存到用户配置文件
    echo "language=$language" > "$HOME/.claude-ce-config"
    
    echo "✅ 语言偏好已设置为: $language"
    echo "   下次创建项目时将使用此语言偏好"
}

# 获取用户语言偏好
get_user_language_preference() {
    if [ -f "$HOME/.claude-ce-config" ]; then
        grep "language=" "$HOME/.claude-ce-config" | cut -d= -f2
    else
        echo "$DEFAULT_LANGUAGE"
    fi
}

# 显示本地化帮助信息
show_localized_help() {
    local language="${1:-$(get_user_language_preference)}"
    
    if [ "$language" = "chinese" ]; then
        cat << 'EOF'
🌍 Claude Autopilot 2.1 国际化管理器

用法:
  set-language <language>     设置语言偏好 (chinese|english)
  get-language               获取当前语言偏好
  help [language]            显示帮助信息

支持的语言:
  chinese                    中文
  english                    英语

示例:
  set-language chinese       设置为中文
  set-language english       设置为英语

当前语言偏好: $(get_user_language_preference)
EOF
    else
        cat << 'EOF'
🌍 Claude Autopilot 2.1 Internationalization Manager

Usage:
  set-language <language>     Set language preference (chinese|english)
  get-language               Get current language preference  
  help [language]            Show help information

Supported languages:
  chinese                    Chinese
  english                    English

Examples:
  set-language chinese       Set to Chinese
  set-language english       Set to English

Current language preference: $(get_user_language_preference)
EOF
    fi
}

# 主函数 - 如果直接执行此脚本
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    case "${1:-}" in
        "init")
            if [ -z "$2" ]; then
                echo "使用: $0 init <project_path> [project_type] [project_name]"
                exit 1
            fi
            PROJECT_PATH=$(realpath "$2")
            PROJECT_TYPE="${3:-unknown}"
            PROJECT_NAME="${4:-$(basename "$PROJECT_PATH")}"
            init_internationalization_manager "$PROJECT_PATH" "$PROJECT_TYPE" "$PROJECT_NAME"
            ;;
        "set-language")
            if [ -z "$2" ]; then
                echo "使用: $0 set-language <language>"
                exit 1
            fi
            set_user_language_preference "$2"
            ;;
        "get-language")
            get_user_language_preference
            ;;
        "help")
            show_localized_help "$2"
            ;;
        *)
            show_localized_help
            ;;
    esac
fi