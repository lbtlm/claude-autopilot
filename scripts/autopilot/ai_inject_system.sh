#!/bin/bash

# 智能Claude Autopilot 2.1项目注入脚本
# 功能：为项目配置轻量级Claude Autopilot环境，避免文件重复
# 版本：2.0.0 - 增强版本，支持智能项目类型检测

set -e

# 设置正确的编码环境
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8

# 显示使用帮助
show_usage() {
    echo "📖 使用说明:"
    echo "   $0 [项目路径] [项目类型]"
    echo ""
    echo "📋 参数说明:"
    echo "   项目路径    - 可选，默认为当前目录"
    echo "   项目类型    - 新项目必需，现有项目可选（会覆盖智能检测）"
    echo ""
    echo "🆕 新项目模式 (空目录):"
    echo "   必须指定项目类型，例如:"
    echo "   $0 /path/to/new/project gin-microservice"
    echo ""
    echo "📁 现有项目模式 (非空目录):"
    echo "   自动智能检测项目类型，例如:"
    echo "   $0 /path/to/existing/project"
    echo ""
    echo "🏷️ 支持的项目类型:"
    echo "   gin-microservice  - Go + Gin微服务"
    echo "   gin-vue3         - Go + Gin + Vue3全栈"
    echo "   go-desktop       - Go桌面应用"
    echo "   go-general       - Go通用项目"
    echo "   vue3-frontend    - Vue3前端项目"
    echo "   vue2-frontend    - Vue2前端项目"
    echo "   react-frontend   - React前端项目"
    echo "   nextjs-frontend  - Next.js前端项目"
    echo "   nodejs-general   - Node.js通用项目"
    echo "   python-desktop   - Python桌面应用"
    echo "   python-web       - Python Web应用"
    echo "   python-general   - Python通用项目"
    echo "   bash-scripts     - Bash脚本项目"
    echo "   java-maven       - Java Maven项目"
    echo "   java-gradle      - Java Gradle项目"
    echo "   rust-project     - Rust项目"
    echo "   php-project      - PHP项目"
    echo ""
}

# 检查帮助参数
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_usage
    exit 0
fi

echo "🚀 智能Claude Autopilot 2.1 项目注入器"
echo "================================================"

# 动态检测脚本路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_RULES_PATH="$(cd "$SCRIPT_DIR/../.." && pwd)"
GLOBAL_CE_PATH="$GLOBAL_RULES_PATH/claude-engine"
SCRIPT_VERSION="2.0.0"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# 获取项目路径和类型
if [ -n "$1" ]; then
    if [ ! -d "$1" ]; then
        echo "❌ 错误: 指定的项目路径不存在或不是目录: $1"
        echo ""
        show_usage
        exit 1
    fi
    PROJECT_PATH=$(realpath "$1")
else
    PROJECT_PATH=$(pwd)
fi

# 获取项目类型参数 (可选)
FORCE_PROJECT_TYPE="$2"

echo "📂 项目路径: $PROJECT_PATH"
echo "🔧 Claude Autopilot路径: $GLOBAL_CE_PATH"
echo ""

# 检测目录是否为空（除了隐藏文件）
is_directory_empty() {
    local dir="$1"
    # 检查是否存在非隐藏文件或目录
    if [ -z "$(find "$dir" -maxdepth 1 -not -path "$dir" -not -name ".*" -print -quit)" ]; then
        return 0  # 目录为空
    else
        return 1  # 目录非空
    fi
}

# 新项目检测逻辑
IS_NEW_PROJECT=false
if is_directory_empty "$PROJECT_PATH"; then
    IS_NEW_PROJECT=true
    echo "🆕 检测到新项目（空目录）"
    
    # 新项目必须提供项目类型参数
    if [ -z "$FORCE_PROJECT_TYPE" ]; then
        echo "❌ 错误: 新项目必须指定项目类型参数"
        echo ""
        show_usage
        exit 1
    fi
    
    # 验证项目类型参数的有效性
    valid_types="gin-microservice gin-vue3 go-desktop go-general vue3-frontend vue2-frontend react-frontend nextjs-frontend nodejs-general python-desktop python-web python-general java-maven java-gradle rust-project php-project"
    if ! echo "$valid_types" | grep -wq "$FORCE_PROJECT_TYPE"; then
        echo "❌ 错误: 无效的项目类型 '$FORCE_PROJECT_TYPE'"
        echo ""
        show_usage
        exit 1
    fi
    
    echo "   🎯 指定项目类型: $FORCE_PROJECT_TYPE"
else
    echo "📁 检测到现有项目（非空目录）"
    if [ -n "$FORCE_PROJECT_TYPE" ]; then
        echo "   ⚠️ 警告: 现有项目将使用智能检测，忽略强制类型参数"
        FORCE_PROJECT_TYPE=""  # 清空强制类型，使用智能检测
    fi
fi
echo ""

# 检查Claude Autopilot是否存在
if [ ! -d "$GLOBAL_CE_PATH" ]; then
    echo "❌ 错误: 全局Context Engine路径不存在"
    echo "   路径: $GLOBAL_CE_PATH"
    echo "   请先运行Claude Autopilot系统安装"
    exit 1
fi

# 加载工具脚本
source "$GLOBAL_CE_PATH/utils/project-health-assessment.sh"
source "$GLOBAL_CE_PATH/utils/alias-resolver.sh"
source "$GLOBAL_CE_PATH/utils/project-structure-creator.sh"
source "$GLOBAL_CE_PATH/utils/deployment-strategy-manager.sh"
source "$GLOBAL_CE_PATH/utils/internationalization-manager.sh"

# 检测项目类型
detect_project_type() {
    local path="$1"
    
    # 检查是否为gin_vue3全栈项目（既有Go又有Vue）
    if ( [ -f "$path/go.mod" ] || [ -f "$path/backend/go.mod" ] ) && ( [ -f "$path/package.json" ] || [ -f "$path/frontend/package.json" ] ); then
        # 检查是否有gin依赖
        if grep -q "gin-gonic/gin" "$path/go.mod" "$path/backend/go.mod" 2>/dev/null; then
            echo "gin-vue3"
            return
        fi
    fi
    
    # 检查纯Go项目
    if [ -f "$path/go.mod" ] || [ -f "$path/backend/go.mod" ]; then
        local go_mod_file="$path/go.mod"
        [ -f "$path/backend/go.mod" ] && go_mod_file="$path/backend/go.mod"
        
        if grep -q "gin-gonic/gin" "$go_mod_file" 2>/dev/null; then
            echo "gin-microservice"
        elif grep -q "fyne" "$go_mod_file" 2>/dev/null; then
            echo "go-desktop"
        else
            echo "go-general"
        fi
    elif [ -f "$path/package.json" ] || [ -f "$path/frontend/package.json" ]; then
        local package_json_file="$path/package.json"
        [ -f "$path/frontend/package.json" ] && package_json_file="$path/frontend/package.json"
        
        if grep -q "vue" "$package_json_file" 2>/dev/null; then
            if grep -q "\"vue\": \"^3" "$package_json_file" 2>/dev/null; then
                echo "vue3-frontend"
            else
                echo "vue2-frontend"
            fi
        elif grep -q "react" "$package_json_file" 2>/dev/null; then
            echo "react-frontend"
        elif grep -q "next" "$package_json_file" 2>/dev/null; then
            echo "nextjs-frontend"
        else
            echo "nodejs-general"
        fi
    elif [ -f "$path/requirements.txt" ] || [ -f "$path/pyproject.toml" ] || [ -f "$path/setup.py" ]; then
        if find "$path" -name "*.py" -exec grep -l "tkinter\|PyQt\|PySide\|wxPython" {} \; 2>/dev/null | head -1 | grep -q .; then
            echo "python-desktop"
        elif find "$path" -name "*.py" -exec grep -l "fastapi\|flask\|django" {} \; 2>/dev/null | head -1 | grep -q .; then
            echo "python-web"
        else
            echo "python-general"
        fi
    elif [ -f "$path/pom.xml" ]; then
        echo "java-maven"
    elif [ -f "$path/build.gradle" ]; then
        echo "java-gradle"
    elif [ -f "$path/Cargo.toml" ]; then
        echo "rust-project"
    elif [ -f "$path/composer.json" ]; then
        echo "php-project"
    else
        echo "unknown"
    fi
}

# 检测技术栈
detect_tech_stack() {
    local path="$1"
    local project_type="$2"
    local tech_stack=""
    
    case "$project_type" in
        "gin-microservice")
            tech_stack="Go + Gin"
            if [ -f "$path/go.mod" ]; then
                if grep -q "gorm" "$path/go.mod"; then
                    tech_stack="$tech_stack + GORM"
                fi
                if grep -q "redis" "$path/go.mod"; then
                    tech_stack="$tech_stack + Redis"
                fi
            fi
            ;;
        "vue3-frontend")
            tech_stack="Vue3 + TypeScript"
            if [ -f "$path/package.json" ]; then
                if grep -q "vite" "$path/package.json"; then
                    tech_stack="$tech_stack + Vite"
                fi
                if grep -q "pinia" "$path/package.json"; then
                    tech_stack="$tech_stack + Pinia"
                fi
            fi
            ;;
        "python-desktop")
            tech_stack="Python"
            if find "$path" -name "*.py" -exec grep -l "tkinter" {} \; 2>/dev/null | head -1 | grep -q .; then
                tech_stack="$tech_stack + Tkinter"
            fi
            if find "$path" -name "*.py" -exec grep -l "PyQt" {} \; 2>/dev/null | head -1 | grep -q .; then
                tech_stack="$tech_stack + PyQt"
            fi
            ;;
        *)
            tech_stack="$project_type"
            ;;
    esac
    
    echo "$tech_stack"
}

# 执行项目检测
echo "🔍 智能项目检测..."
if [ "$IS_NEW_PROJECT" = true ]; then
    echo "   🎯 新项目类型: $FORCE_PROJECT_TYPE"
    PROJECT_TYPE="$FORCE_PROJECT_TYPE"
else
    PROJECT_TYPE=$(detect_project_type "$PROJECT_PATH")
    # 如果检测结果为unknown，提供交互式选择
    if [ "$PROJECT_TYPE" = "unknown" ]; then
        echo "   ⚠️ 无法自动识别项目类型"
        echo "   📋 请手动选择项目类型："
        echo "     1) gin-microservice    (Go + Gin微服务)"
        echo "     2) gin-vue3           (Go + Gin + Vue3全栈)"
        echo "     3) go-desktop         (Go桌面应用)"
        echo "     4) go-general         (Go通用项目)"
        echo "     5) vue3-frontend      (Vue3前端项目)"
        echo "     6) vue2-frontend      (Vue2前端项目)"
        echo "     7) react-frontend     (React前端项目)"
        echo "     8) nextjs-frontend    (Next.js前端项目)"
        echo "     9) nodejs-general     (Node.js通用项目)"
        echo "    10) python-desktop     (Python桌面应用)"
        echo "    11) python-web         (Python Web应用)"
        echo "    12) python-general     (Python通用项目)"
        echo "    13) java-maven         (Java Maven项目)"
        echo "    14) java-gradle        (Java Gradle项目)"
        echo "    15) rust-project       (Rust项目)"
        echo "    16) php-project        (PHP项目)"
        echo ""
        read -p "请输入选项编号 (1-16): " choice
        
        case "$choice" in
            1) PROJECT_TYPE="gin-microservice" ;;
            2) PROJECT_TYPE="gin-vue3" ;;
            3) PROJECT_TYPE="go-desktop" ;;
            4) PROJECT_TYPE="go-general" ;;
            5) PROJECT_TYPE="vue3-frontend" ;;
            6) PROJECT_TYPE="vue2-frontend" ;;
            7) PROJECT_TYPE="react-frontend" ;;
            8) PROJECT_TYPE="nextjs-frontend" ;;
            9) PROJECT_TYPE="nodejs-general" ;;
            10) PROJECT_TYPE="python-desktop" ;;
            11) PROJECT_TYPE="python-web" ;;
            12) PROJECT_TYPE="python-general" ;;
            13) PROJECT_TYPE="java-maven" ;;
            14) PROJECT_TYPE="java-gradle" ;;
            15) PROJECT_TYPE="rust-project" ;;
            16) PROJECT_TYPE="php-project" ;;
            *)
                echo "❌ 无效选择，退出"
                exit 1
                ;;
        esac
        echo "   ✅ 已选择项目类型: $PROJECT_TYPE"
    fi
fi
TECH_STACK=$(detect_tech_stack "$PROJECT_PATH" "$PROJECT_TYPE")
PROJECT_NAME=$(basename "$PROJECT_PATH")

echo "   📦 项目名称: $PROJECT_NAME"
echo "   🏷️ 项目类型: $PROJECT_TYPE"
echo "   🔧 技术栈: $TECH_STACK"
echo ""

# 执行项目健康度评估
if [ "$IS_NEW_PROJECT" = true ]; then
    echo "🏗️ 新项目创建模式，跳过健康度评估..."
    HEALTH_PERCENTAGE=0
else
    echo "🏥 执行项目健康度评估..."
    # 将健康度评估的诊断输出重定向到当前标准输出，只获取数字结果
    HEALTH_PERCENTAGE=$(assess_project_health "$PROJECT_PATH" "$PROJECT_TYPE" 2>&1 | tail -1)
    echo ""
    echo "📊 项目健康度: $HEALTH_PERCENTAGE%"
fi

# 根据健康度给出建议 (跳过新项目)
if [ "$IS_NEW_PROJECT" = false ]; then
    if [ "$HEALTH_PERCENTAGE" -lt 70 ]; then
        echo "⚠️  项目健康度较低，建议在注入CE前先改善项目结构"
        echo "   查看详细评估报告: project_process/health-assessment-*.md"
        echo ""
        read -p "是否继续注入CE系统？(y/N): " continue_injection
        if [[ ! "$continue_injection" =~ ^[Yy]$ ]]; then
            echo "❌ 注入已取消。请改善项目健康度后重试。"
            exit 1
        fi
    elif [ "$HEALTH_PERCENTAGE" -lt 90 ]; then
        echo "💡 项目健康度良好，但仍有改进空间"
        echo "   查看详细评估报告: project_process/health-assessment-*.md"
    fi
    echo ""
fi

# 创建标准项目结构（基于健康度评估结果或新项目）
if [ "$IS_NEW_PROJECT" = true ] || [ "$HEALTH_PERCENTAGE" -lt 80 ]; then
    if [ "$IS_NEW_PROJECT" = true ]; then
        echo "🏗️ 创建 $PROJECT_TYPE 标准项目结构..."
    else
        echo "🏗️ 项目结构不够完善，开始创建标准项目结构..."
    fi
    create_standard_project_structure "$PROJECT_PATH" "$PROJECT_TYPE" "$PROJECT_NAME"
    echo ""
elif [ "$HEALTH_PERCENTAGE" -lt 95 ]; then
    echo "🔧 完善项目结构..."
    # 只创建缺失的关键部分，不覆盖现有结构
    create_universal_structure "$PROJECT_PATH" "$PROJECT_NAME"
    echo ""
else
    echo "✅ 项目结构已经很完善，跳过结构创建"
    echo ""
fi

# 初始化部署策略管理
echo "🚀 初始化智能部署策略..."
init_deployment_strategy_manager "$PROJECT_PATH" "$PROJECT_TYPE" "$PROJECT_NAME"
echo ""

# 初始化国际化功能
echo "🌍 初始化国际化功能..."
init_internationalization_manager "$PROJECT_PATH" "$PROJECT_TYPE" "$PROJECT_NAME"
echo ""

# 创建.claude目录结构
echo "📁 创建Claude Code配置目录..."
mkdir -p "$PROJECT_PATH/.claude"

# 生成项目配置文件
echo "⚙️ 生成项目配置文件..."
cat > "$PROJECT_PATH/.claude/project.json" << EOF
{
  "project_name": "$PROJECT_NAME",
  "project_type": "$PROJECT_TYPE",
  "tech_stack": "$TECH_STACK",
  "global_ce_path": "$GLOBAL_CE_PATH",
  "auto_load_context": true,
  "enabled_workflows": [
    "smart-feature-dev",
    "smart-bugfix",
    "smart-code-refactor"
  ],
  "enabled_commands": [
    "load-global-context",
    "smart-feature-dev",
    "smart-bugfix", 
    "smart-code-refactor",
    "project-status-analysis",
    "cleanup-project",
    "commit-github"
  ],
  "quality_gates": {
    "lint_command": "make lint",
    "test_command": "make test",
    "typecheck_command": "make typecheck",
    "security_command": "make security-scan"
  },
  "memory_context": "${PROJECT_TYPE}_${PROJECT_NAME}",
  "ce_version": "$SCRIPT_VERSION",
  "created_at": "$TIMESTAMP",
  "last_sync": "$TIMESTAMP"
}
EOF

echo "   ✅ 项目配置文件: .claude/project.json"

# 创建符号链接到全局commands（可选方案）
echo "🔗 创建全局命令链接..."
if [ ! -L "$PROJECT_PATH/.claude/commands" ]; then
    ln -sf "$GLOBAL_CE_PATH/commands" "$PROJECT_PATH/.claude/commands"
    echo "   ✅ 全局命令链接: .claude/commands -> $GLOBAL_CE_PATH/commands"
else
    echo "   ℹ️ 命令链接已存在"
fi

# 生成轻量级CLAUDE.md
echo "📄 生成轻量级CLAUDE.md..."

# 检查项目类型模板是否存在
PROJECT_TYPE_TEMPLATE="$GLOBAL_CE_PATH/project-types/${PROJECT_TYPE}.md"
if [ -f "$PROJECT_TYPE_TEMPLATE" ]; then
    # 使用项目类型专用模板，并替换变量
    sed -e "s/\$PROJECT_NAME/$PROJECT_NAME/g" \
        -e "s/\$TECH_STACK/$TECH_STACK/g" \
        -e "s/\$SCRIPT_VERSION/$SCRIPT_VERSION/g" \
        -e "s/\$TIMESTAMP/$TIMESTAMP/g" \
        -e "s|\$GLOBAL_CE_PATH|$GLOBAL_CE_PATH|g" \
        "$PROJECT_TYPE_TEMPLATE" > "$PROJECT_PATH/CLAUDE.md"
    echo "   ✅ 使用项目类型模板: ${PROJECT_TYPE}.md"
else
    # 项目类型未定义，生成带提醒的通用模板
    echo "   ⚠️ 项目类型 '$PROJECT_TYPE' 未在 project_types/ 中定义"
    echo "   📝 生成注释模板，请手动完善项目类型定义"
    
cat > "$PROJECT_PATH/CLAUDE.md" << EOF
# CLAUDE.md - 智能AI协作指南

## ⚠️ **项目类型未定义提醒**

**重要**: 项目类型 \`$PROJECT_TYPE\` 尚未在 \`project_types/\` 目录中定义专用模板。

**下一步操作**:
1. 创建文件: \`${GLOBAL_CE_PATH}/project-types/${PROJECT_TYPE}.md\`
2. 参考现有模板（如 \`gin_microservice.md\`）编写项目类型规范
3. 重新运行注入脚本以应用专用模板

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，支持完整的智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: $PROJECT_TYPE ⚠️ (未定义)
- **技术栈**: $TECH_STACK
- **CE版本**: $SCRIPT_VERSION
- **配置时间**: $TIMESTAMP

<!-- 
注意: 以下是通用模板，当项目类型模板定义后将被替换
如需自定义，请创建项目类型模板文件
-->

### **🎯 智能命令**

#### **核心开发流程**
\`\`\`bash
# 一键式完整功能开发 / Smart Feature Development
/智能功能开发 <功能需求描述>
# OR /smart-feature-dev <feature description>

# 智能问题诊断和修复 / Smart Bug Fix
/智能Bug修复 <问题描述>
# OR /smart-bugfix <problem description>

# 基于最佳实践的智能重构 / Smart Code Refactor  
/智能代码重构 <重构目标>
# OR /smart-code-refactor <refactor target>
\`\`\`

#### **辅助工具命令**
\`\`\`bash
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
\`\`\`

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: 复杂任务智能分解和风险评估
- **context7**: 动态获取最新技术文档和最佳实践  
- **memory**: 历史开发经验自动复用
- **puppeteer**: Web项目自动化测试验证

#### **全局规则遵守**
- **强制规则**: 自动应用安全、质量、API设计规范
- **禁止规则**: 自动检测和阻止违规操作
- **质量门**: 多层次自动验证确保代码质量

#### **智能化特性**
- **需求智能分析**: 复杂度评估+风险预测+工作量估算
- **方案智能生成**: 基于历史经验+最新技术的最优方案
- **代码智能实现**: 模式复用+自动纠错+质量验证
- **经验智能积累**: 开发过程自动保存，团队知识共享

### **📋 使用建议**

#### **开始开发**
1. 直接描述你的需求，如："添加用户登录功能"
2. 系统会自动执行完整的智能开发流程
3. 享受一次性实现成功的开发体验

#### **遇到问题**
1. 描述具体问题，如："登录接口偶尔返回500错误"  
2. 系统会智能诊断根因并自动修复
3. 修复经验会自动保存供后续复用

#### **代码优化**
1. 说明优化目标，如："优化用户服务性能"
2. 系统会基于最佳实践进行智能重构
3. 确保重构后质量和功能完整性

### **🔗 技术架构**

#### **集中式管理**
- **全局规则**: $GLOBAL_CE_PATH
- **智能工作流**: 零重复，一处更新全局生效
- **模式库**: 分类管理，智能匹配适用模式
- **经验库**: 跨项目共享，持续积累改进

#### **轻量化部署**  
- **本项目配置**: .claude/project.json (项目特定配置)
- **命令链接**: .claude/commands (指向全局命令)
- **无文件重复**: 所有CE资源集中管理
- **自动同步**: 全局更新自动应用到项目

### **📈 效率提升**

相比传统开发方式，Claude Autopilot 2.0提供：
- ⚡ **开发效率**: 提升3-5倍
- 🎯 **一次成功率**: 95%+
- 📊 **代码质量**: A级标准
- 🧠 **知识复用**: 团队经验自动积累
- 🔒 **质量保证**: 多层次自动验证

### **🆘 故障排除**

#### **命令不可用**
\`\`\`bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
\`\`\`

#### **规则不生效**  
检查Claude Autopilot路径是否正确：$GLOBAL_CE_PATH

#### **获取帮助**
查看Claude Autopilot文档：$GLOBAL_CE_PATH/README.md

---

## 🚀 **开始智能开发之旅**

智能Claude Autopilot 2.1已为您准备就绪！

**直接描述您的需求**，系统会自动选择最适合的智能工作流程：

- 功能开发 → 自动执行智能功能开发流程
- 问题修复 → 自动执行智能Bug修复流程  
- 代码优化 → 自动执行智能重构流程

**享受一次性成功的智能开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，请勿手动修改核心配置部分*
EOF
fi

echo "   ✅ 轻量级CLAUDE.md文件已生成"

# 创建project_process目录结构
echo "📁 创建项目过程跟踪目录..."
mkdir -p "$PROJECT_PATH/project_process"/{daily,reports,prps,bugfixes,analysis}

cat > "$PROJECT_PATH/project_process/README.md" << EOF
# 项目过程记录

这个目录用于智能Claude Autopilot 2.1系统自动记录开发过程。

## 目录说明
- \`daily/\` - 每日开发记录
- \`reports/\` - 完成报告和分析
- \`prps/\` - 智能PRP方案文档
- \`bugfixes/\` - Bug修复记录
- \`analysis/\` - 需求分析结果

## 自动生成
所有文件由Claude Autopilot系统自动生成，记录开发过程和经验。
EOF

echo "   ✅ 项目过程目录结构已创建"

# 创建其他全局基础结构
echo "📁 创建全局基础结构..."

# 创建project_docs目录
if [ ! -d "$PROJECT_PATH/project_docs" ]; then
    mkdir -p "$PROJECT_PATH/project_docs"
    echo "   ✅ 创建目录: project_docs/"
fi

# 创建.vscode目录和配置
if [ ! -d "$PROJECT_PATH/.vscode" ]; then
    mkdir -p "$PROJECT_PATH/.vscode"
    
    # VSCode settings.json
    cat > "$PROJECT_PATH/.vscode/settings.json" << 'EOF'
{
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.formatOnSave": true,
    "files.autoSave": "onFocusChange",
    "files.exclude": {
        "**/node_modules": true,
        "**/dist": true,
        "**/*.pyc": true,
        "**/__pycache__": true
    }
}
EOF

    echo "   ✅ 创建文件: .vscode/settings.json"
fi

# 创建.editorconfig
if [ ! -f "$PROJECT_PATH/.editorconfig" ]; then
    cat > "$PROJECT_PATH/.editorconfig" << 'EOF'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.md]
trim_trailing_whitespace = false

[*.{py,go}]
indent_size = 4

[Makefile]
indent_style = tab
EOF

    echo "   ✅ 创建文件: .editorconfig"
fi

# 创建基础Makefile（如果不存在）
if [ ! -f "$PROJECT_PATH/Makefile" ]; then
    cat > "$PROJECT_PATH/Makefile" << 'EOF'
.PHONY: help init dev build test lint clean deploy

help:
	@echo "可用命令:"
	@echo "  init    - 初始化开发环境"
	@echo "  dev     - 启动开发环境"
	@echo "  build   - 构建项目"
	@echo "  test    - 运行测试"
	@echo "  lint    - 代码检查"
	@echo "  clean   - 清理临时文件"
	@echo "  deploy  - 部署项目"

init:
	@echo "🔧 初始化开发环境..."
	@echo "请根据项目类型安装相应依赖"

dev:
	@echo "🚀 启动开发环境..."
	@echo "请根据项目类型配置开发服务器"

build:
	@echo "📦 构建项目..."
	@echo "请根据项目类型配置构建命令"

test:
	@echo "🧪 运行测试..."
	@echo "请根据项目类型配置测试命令"

lint:
	@echo "🔍 代码检查..."
	@echo "请根据项目类型配置代码检查命令"

clean:
	@echo "🧹 清理临时文件..."
	@echo "请根据项目类型配置清理命令"

deploy:
	@echo "🚀 部署项目..."
	@echo "请根据项目类型配置部署命令"
EOF

    echo "   ✅ 创建文件: Makefile"
fi

echo "   ✅ 全局基础结构创建完成"

# 检查现有CLAUDE.md是否需要备份
if [ -f "$PROJECT_PATH/CLAUDE.md.backup" ]; then
    echo "ℹ️ 发现现有CLAUDE.md备份文件"
fi

# 验证配置
echo "✅ 验证Claude Autopilot配置..."

# 检查Claude Autopilot系统
echo "🔍 验证Claude Autopilot系统..."
WORKFLOWS_COUNT=$(find "$GLOBAL_CE_PATH/workflows" -name "*.md" 2>/dev/null | wc -l)
COMMANDS_COUNT=$(find "$GLOBAL_CE_PATH/commands" -name "*.md" 2>/dev/null | wc -l)  
TEMPLATES_COUNT=$(find "$GLOBAL_CE_PATH/templates" -name "*.md" 2>/dev/null | wc -l)

echo "   📋 智能工作流程: $WORKFLOWS_COUNT 个"
echo "   🛠️ 智能命令: $COMMANDS_COUNT 个"  
echo "   📄 智能模板: $TEMPLATES_COUNT 个"

# 检查项目配置完整性
echo "🔍 验证项目配置完整性..."
if [ -f "$PROJECT_PATH/.claude/project.json" ]; then
    echo "   ✅ 项目配置文件存在"
else
    echo "   ❌ 项目配置文件缺失"
    exit 1
fi

if [ -L "$PROJECT_PATH/.claude/commands" ]; then
    echo "   ✅ 全局命令链接正常"
else
    echo "   ⚠️ 全局命令链接可能有问题"
fi

if [ -f "$PROJECT_PATH/CLAUDE.md" ]; then
    echo "   ✅ CLAUDE.md文件已生成"
else
    echo "   ❌ CLAUDE.md文件生成失败"
    exit 1
fi

echo ""
echo "🎊 智能Claude Autopilot 2.1注入完成！"
echo "================================================"
echo ""
echo "📊 **注入摘要**:"
echo "   📂 项目: $PROJECT_NAME ($PROJECT_TYPE)"
echo "   🔧 技术栈: $TECH_STACK"
echo "   🏥 健康度: $HEALTH_PERCENTAGE%"
echo "   ⚙️ 配置文件: .claude/project.json"
echo "   📄 指南文件: CLAUDE.md"
echo "   🔗 命令链接: .claude/commands"
echo "   📁 过程目录: project_process/"
echo ""
echo "🚀 **可用的智能命令 / Available Commands**:"
echo "   • /智能功能开发 (/smart-feature-dev) <功能描述>"
echo "   • /智能Bug修复 (/smart-bugfix) <问题描述>"  
echo "   • /智能代码重构 (/smart-code-refactor) <重构目标>"
echo "   • /加载全局上下文 (/load-global-context)"
echo "   • /清理残余文件 (/cleanup-project)"
echo "   • /提交github (/commit-github)"
echo ""
echo "💡 **开始使用**:"
echo "   1. 进入项目目录: cd $PROJECT_PATH"
echo "   2. 启动Claude Code: claude code"
echo "   3. 直接描述需求开始智能开发！"
echo ""
echo "📚 **获取帮助**:"
echo "   - 全局文档: $GLOBAL_CE_PATH/README.md"
echo "   - 项目指南: CLAUDE.md"
echo ""
echo "✨ **享受智能开发体验！**"

# 给脚本添加执行权限
# chmod +x "$GLOBAL_RULES_PATH/scripts/Claude Autopilot注入.sh"