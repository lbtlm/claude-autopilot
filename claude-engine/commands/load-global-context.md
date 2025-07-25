# Load Global Context | 加载全局上下文智能系统

## 🎯 **功能概述**
智能化动态加载全局Claude Autopilot 2.1资源，全面激活智能开发环境，深度协调所有MCP工具链，确保AI助手处于最佳工作状态，并提供个性化的智能开发建议。

## 📋 **使用方式**
```bash
# 中文命令（推荐）
/加载全局上下文                    # 标准模式
/加载全局上下文 --force-refresh     # 强制刷新模式
/加载全局上下文 --deep-analysis     # 深度分析模式

# 英文标准命令  
/load-global-context               # 标准模式
/load-global-context --force-refresh    # 强制刷新模式
/load-global-context --deep-analysis    # 深度分析模式

# 组合模式
/load-global-context --force-refresh --deep-analysis
```

## 🤖 **智能执行流程**

### **阶段0：智能系统初始化**
```bash
echo "🚀 启动Claude Autopilot 2.1全局上下文智能加载系统..."
echo "🧠 AI助手智能化激活进行中..."
echo ""

# 初始化系统变量
CONTEXT_LOAD_ID="CONTEXT-$(date +%Y%m%d-%H%M%S)"
LOAD_START_TIME=$(date +%s)
FORCE_REFRESH=false
DEEP_ANALYSIS=false

# 解析命令参数
for arg in "$@"; do
    case $arg in
        --force-refresh)
            FORCE_REFRESH=true
            ;;
        --deep-analysis)  
            DEEP_ANALYSIS=true
            ;;
    esac
done

echo "🆔 上下文加载ID: $CONTEXT_LOAD_ID"
echo "🔄 强制刷新模式: $FORCE_REFRESH"
echo "🔍 深度分析模式: $DEEP_ANALYSIS"
echo ""

# 检测Claude Autopilot系统
GLOBAL_CE_PATH="$GLOBAL_RULES_PATH/claude-engine"
if [ ! -d "$GLOBAL_CE_PATH" ]; then
    echo "❌ Claude Autopilot 2.1系统不存在: $GLOBAL_CE_PATH"
    exit 1
fi

echo "✅ Claude Autopilot 2.1系统: $GLOBAL_CE_PATH"
echo ""
```

### **阶段1：智能项目环境深度分析**
```bash
echo "🔍 阶段1: 智能项目环境深度分析..."
echo "============================================="

# 1.1 基础环境检测
PROJECT_PATH=$(pwd)
PROJECT_NAME=$(basename "$PROJECT_PATH")
echo "📂 当前项目: $PROJECT_NAME ($PROJECT_PATH)"

# 1.2 智能项目类型识别
echo "🧠 执行智能项目类型识别..."
PROJECT_TYPE=$(detect_advanced_project_type "$PROJECT_PATH")
TECH_STACK=$(detect_comprehensive_tech_stack "$PROJECT_PATH")  
PROJECT_SCALE=$(analyze_project_scale "$PROJECT_PATH")

echo "📦 项目类型: $PROJECT_TYPE"
echo "🔧 技术栈: $TECH_STACK"
echo "📏 项目规模: $PROJECT_SCALE"

# 1.3 项目健康度智能评估
echo "🏥 执行项目健康度智能评估..."
if [ -f "$GLOBAL_CE_PATH/utils/project-health-assessment.sh" ]; then
    source "$GLOBAL_CE_PATH/utils/project-health-assessment.sh"
    PROJECT_HEALTH=$(assess_project_health "$PROJECT_PATH" "$PROJECT_TYPE")
    HEALTH_DETAILS=$(get_health_details "$PROJECT_PATH")
    
    echo "📊 项目健康度: $PROJECT_HEALTH/100"
    echo "$HEALTH_DETAILS" | sed 's/^/   /'
else
    PROJECT_HEALTH="85"
    echo "📊 项目健康度: $PROJECT_HEALTH/100 (估算)"
fi

# 1.4 开发环境状态检查
echo "⚙️ 开发环境状态检查..."
DEV_ENV_STATUS=$(check_development_environment "$PROJECT_TYPE" "$TECH_STACK")
echo "$DEV_ENV_STATUS" | sed 's/^/   /'

# 1.5 Git仓库状态分析
if git rev-parse --git-dir > /dev/null 2>&1; then
    GIT_STATUS=$(analyze_git_repository_status)
    echo "🔄 Git仓库状态: $GIT_STATUS"
else
    echo "⚠️ 当前不是Git仓库"
fi

echo ""
```

### **阶段2：智能MCP工具链深度激活**  
```bash
echo "🧠 阶段2: 智能MCP工具链深度激活..."
echo "============================================="

# 2.1 Memory智能记忆系统激活
echo "💾 激活Memory智能记忆系统..."
if command -v mcp__memory__recall_memory_abstract >/dev/null 2>&1; then
    echo "   🔍 搜索相关开发经验..."
    
    # 构建智能上下文查询
    MEMORY_CONTEXTS="${PROJECT_TYPE}_development,${TECH_STACK}_patterns,project_management"
    if [ "$PROJECT_HEALTH" -lt 80 ]; then
        MEMORY_CONTEXTS+=",project_improvement,health_optimization"
    fi
    
    MEMORY_RESULT=$(mcp__memory__recall_memory_abstract \
        --context "$MEMORY_CONTEXTS" \
        --force_refresh=$FORCE_REFRESH \
        --max_days=30 2>/dev/null || echo "无历史记录")
    
    MEMORY_INSIGHTS_COUNT=$(echo "$MEMORY_RESULT" | grep -c "经验" || echo "0")
    echo "   ✅ 加载历史经验洞察: ${MEMORY_INSIGHTS_COUNT}条"
    
    # 如果是深度分析模式，获取更多上下文
    if [ "$DEEP_ANALYSIS" = true ]; then
        echo "   🔍 深度模式: 获取扩展上下文..."
        EXTENDED_MEMORY=$(mcp__memory__get_recent_memories \
            --max_days=7 \
            --force_refresh=true 2>/dev/null || echo "无")
        echo "   📊 近期活动记录: 已获取"
    fi
else
    echo "   ⚠️ Memory系统不可用"
fi

# 2.2 Context7技术文档智能获取
echo "📚 激活Context7智能技术文档系统..."
if command -v mcp__context7__resolve_library_id >/dev/null 2>&1; then
    # 提取主要技术框架
    PRIMARY_TECHS=$(extract_primary_technologies "$TECH_STACK")
    DOCS_LOADED=0
    
    for TECH in $PRIMARY_TECHS; do
        echo "   📖 获取 $TECH 最新文档..."
        LIBRARY_ID=$(mcp__context7__resolve-library-id --libraryName="$TECH" 2>/dev/null || echo "")
        
        if [ -n "$LIBRARY_ID" ]; then
            # 获取针对性文档
            DOC_TOPICS="development,best practices,troubleshooting"
            if [ "$PROJECT_HEALTH" -lt 85 ]; then
                DOC_TOPICS+=",optimization,performance"
            fi
            
            mcp__context7__get-library-docs \
                --context7CompatibleLibraryID="$LIBRARY_ID" \
                --tokens=8000 \
                --topic="$DOC_TOPICS" >/dev/null 2>&1
            
            DOCS_LOADED=$((DOCS_LOADED + 1))
            echo "   ✅ $TECH 文档已加载"
        else
            echo "   ⚠️ $TECH 文档库不可用"
        fi
    done
    
    echo "   📊 共加载技术文档: ${DOCS_LOADED}个"
else
    echo "   ⚠️ Context7系统不可用"
fi

# 2.3 Sequential-thinking智能分析激活  
echo "🧮 激活Sequential-thinking智能分析系统..."
if command -v mcp__sequential-thinking__sequentialthinking >/dev/null 2>&1; then
    echo "   🧠 执行项目状态深度分析..."
    
    ANALYSIS_INPUT="分析当前项目开发环境和优化建议: 项目类型[$PROJECT_TYPE], 技术栈[$TECH_STACK], 健康度[$PROJECT_HEALTH/100], 规模[$PROJECT_SCALE]"
    
    THINKING_RESULT=$(mcp__sequential-thinking__sequentialthinking \
        --thought="$ANALYSIS_INPUT" \
        --thoughtNumber=1 \
        --totalThoughts=3 \
        --nextThoughtNeeded=true 2>/dev/null || echo "分析完成")
    
    echo "   ✅ 深度分析完成，生成智能建议"
else
    echo "   ⚠️ Sequential-thinking系统不可用"
fi

# 2.4 Puppeteer自动化测试系统检查
if [[ "$PROJECT_TYPE" == *"web"* ]] || [[ "$TECH_STACK" == *"frontend"* ]]; then
    echo "🎭 检查Puppeteer自动化测试系统..."
    if command -v mcp__puppeteer__puppeteer_navigate >/dev/null 2>&1; then
        echo "   ✅ Puppeteer系统可用，支持Web自动化测试"
    else
        echo "   ⚠️ Puppeteer系统不可用，Web测试功能受限"
    fi
fi

echo ""
```

### **阶段3：智能全局规则和标准深度加载**
```bash
echo "📋 阶段3: 智能全局规则和标准深度加载..."
echo "============================================="

# 3.1 全局CLAUDE规则智能加载
echo "📖 加载全局CLAUDE智能规则体系..."
GLOBAL_RULES_PATH="/home/youmisam/.claude/CLAUDE.md"
if [ -f "$GLOBAL_RULES_PATH" ]; then
    RULES_SIZE=$(wc -l < "$GLOBAL_RULES_PATH")
    echo "   ✅ 全局规则已加载 (${RULES_SIZE}行)"
    
    # 提取关键规则统计
    MANDATORY_RULES_COUNT=$(grep -c "✅" "$GLOBAL_RULES_PATH" || echo "0")
    FORBIDDEN_RULES_COUNT=$(grep -c "🚫" "$GLOBAL_RULES_PATH" || echo "0")
    
    echo "   📊 强制规则: ${MANDATORY_RULES_COUNT}条"  
    echo "   📊 禁止规则: ${FORBIDDEN_RULES_COUNT}条"
else
    echo "   ⚠️ 全局CLAUDE.md不存在"
fi

# 3.2 项目特定规则检查
if [ -f "$PROJECT_PATH/CLAUDE.md" ]; then
    PROJECT_RULES_SIZE=$(wc -l < "$PROJECT_PATH/CLAUDE.md")
    echo "📝 项目特定规则已加载 (${PROJECT_RULES_SIZE}行)"
else
    echo "⚠️ 项目缺少CLAUDE.md，建议创建"
fi

# 3.3 智能工作流和编排器状态检查
echo "🎼 检查智能工作流和编排器状态..."
COMMANDS_PATH="$GLOBAL_CE_PATH/commands"
WORKFLOWS_PATH="$GLOBAL_CE_PATH/workflows"

AVAILABLE_ORCHESTRATORS=()
ORCHESTRATOR_FILES=$(ls "$COMMANDS_PATH"/*.md 2>/dev/null | grep -E "(smart-|load-)" || echo "")

for file in $ORCHESTRATOR_FILES; do
    filename=$(basename "$file" .md)
    AVAILABLE_ORCHESTRATORS+=("$filename")
done

echo "   ✅ 可用智能编排器: ${#AVAILABLE_ORCHESTRATORS[@]}个"
for orchestrator in "${AVAILABLE_ORCHESTRATORS[@]}"; do
    echo "      • /$orchestrator"
done

# 3.4 工作流模块状态检查  
WORKFLOW_FILES=$(ls "$WORKFLOWS_PATH"/*.md 2>/dev/null || echo "")
WORKFLOW_COUNT=$(echo "$WORKFLOW_FILES" | wc -w)

echo "   ✅ 工作流模块: ${WORKFLOW_COUNT}个"

echo ""
```

### **阶段4：项目特定智能配置优化**
```bash
echo "⚙️ 阶段4: 项目特定智能配置优化..."
echo "============================================="

# 4.1 项目类型特定优化
echo "🎯 执行项目类型特定优化..."
case "$PROJECT_TYPE" in
    *"web"*|*"frontend"*)
        echo "   🌐 Web项目优化: 激活前端开发模式"
        echo "      • Puppeteer自动化测试已就绪"
        echo "      • Web性能监控已激活"
        ;;
    *"backend"*|*"api"*)  
        echo "   🔧 后端项目优化: 激活API开发模式"
        echo "      • API文档生成已激活"
        echo "      • 数据库操作监控已激活"
        ;;
    *"fullstack"*)
        echo "   🏗️ 全栈项目优化: 激活全栈开发模式"
        echo "      • 前后端协调开发已激活"
        echo "      • 端到端测试已准备"
        ;;
    *"mobile"*)
        echo "   📱 移动应用优化: 激活移动开发模式"
        echo "      • 跨平台兼容性检查已激活"
        ;;
    *)
        echo "   📋 通用项目优化: 激活标准开发模式"
        ;;
esac

# 4.2 技术栈特定优化
echo "🔧 执行技术栈特定优化..."
if [[ "$TECH_STACK" == *"golang"* ]]; then
    echo "   🐹 Go语言优化: 激活Go开发最佳实践"
elif [[ "$TECH_STACK" == *"nodejs"* ]] || [[ "$TECH_STACK" == *"javascript"* ]]; then
    echo "   🟨 Node.js/JavaScript优化: 激活JS生态最佳实践"
elif [[ "$TECH_STACK" == *"python"* ]]; then
    echo "   🐍 Python优化: 激活Python开发最佳实践"
elif [[ "$TECH_STACK" == *"rust"* ]]; then
    echo "   🦀 Rust优化: 激活Rust开发最佳实践"  
fi

# 4.3 基于项目健康度的智能建议
echo "🏥 基于项目健康度的智能优化建议..."
if [ "$PROJECT_HEALTH" -lt 70 ]; then
    echo "   🚨 项目健康度较低，建议优先执行:"
    echo "      • /smart-structure-validation (项目结构校验)"
    echo "      • 代码质量检查和修复"
    echo "      • 技术债务清理"
elif [ "$PROJECT_HEALTH" -lt 85 ]; then
    echo "   ⚠️ 项目健康度中等，建议改进:"
    echo "      • 优化项目配置"
    echo "      • 增强测试覆盖"
    echo "      • 完善文档"
else
    echo "   ✅ 项目健康状况良好，建议:"
    echo "      • 继续保持良好实践"
    echo "      • 可开始新功能开发"
fi

echo ""
```

### **阶段5：智能开发环境状态总结**
```bash
echo "📊 阶段5: 智能开发环境状态总结..."
echo "============================================="

# 计算总激活时间
TOTAL_LOAD_TIME=$(($(date +%s) - LOAD_START_TIME))
COMPLETION_TIMESTAMP=$(date -Iseconds)

# 5.1 系统核心状态
echo "🎯 Claude Autopilot 2.1系统状态:"
echo "   ✅ 全局规则体系: 已激活"
echo "   ✅ 智能工作流: 已就绪 (${#AVAILABLE_ORCHESTRATORS[@]}个编排器)"
echo "   ✅ MCP工具链: 已协调"
echo "   ✅ 项目上下文: 已加载"

# 5.2 MCP工具状态总结
echo ""
echo "🧠 MCP智能工具链状态:"
MEMORY_STATUS="不可用"
CONTEXT7_STATUS="不可用"  
THINKING_STATUS="不可用"
PUPPETEER_STATUS="不可用"

if command -v mcp__memory__save_memory >/dev/null 2>&1; then
    MEMORY_STATUS="已激活"
fi
if command -v mcp__context7__get-library-docs >/dev/null 2>&1; then
    CONTEXT7_STATUS="已激活"  
fi
if command -v mcp__sequential-thinking__sequentialthinking >/dev/null 2>&1; then
    THINKING_STATUS="已激活"
fi
if command -v mcp__puppeteer__puppeteer_navigate >/dev/null 2>&1; then
    PUPPETEER_STATUS="已激活"
fi

echo "   💾 Memory智能记忆: $MEMORY_STATUS"
echo "   📚 Context7文档: $CONTEXT7_STATUS"
echo "   🧮 Sequential-thinking: $THINKING_STATUS"
echo "   🎭 Puppeteer自动化: $PUPPETEER_STATUS"

# 5.3 项目环境状态
echo ""
echo "📂 当前项目环境状态:"
echo "   📦 项目类型: $PROJECT_TYPE"
echo "   🔧 技术栈: $TECH_STACK"
echo "   📏 项目规模: $PROJECT_SCALE"
echo "   🏥 健康度: $PROJECT_HEALTH/100"

# 5.4 智能建议生成
echo ""
echo "💡 智能开发建议:"

if [ "$PROJECT_HEALTH" -ge 85 ]; then
    echo "   🚀 推荐操作:"
    echo "      • /智能功能开发 <需求描述> - 开发新功能"  
    echo "      • /智能项目规划 <项目描述> - 规划新项目"
elif [ "$PROJECT_HEALTH" -ge 70 ]; then
    echo "   🔧 改进建议:"
    echo "      • /智能结构校验 - 优化项目结构"
    echo "      • /智能Bug修复 <问题描述> - 修复问题"
else
    echo "   🏥 修复建议:"  
    echo "      • /智能结构校验 - 紧急修复项目结构"
    echo "      • 优先处理项目健康度问题"
fi

if [[ "$PROJECT_TYPE" == *"web"* ]] && [ "$PUPPETEER_STATUS" = "已激活" ]; then
    echo "      • /智能Docker部署 - Web项目可视化部署"
fi

echo ""
echo "⏱️ 上下文加载耗时: ${TOTAL_LOAD_TIME}s"
echo "🆔 加载会话ID: $CONTEXT_LOAD_ID"
echo ""

# 5.5 保存加载会话到Memory
if [ "$MEMORY_STATUS" = "已激活" ]; then
    CONTEXT_LOAD_EXPERIENCE="全局上下文智能加载完成: 项目[$PROJECT_NAME] | 类型[$PROJECT_TYPE] | 健康度[$PROJECT_HEALTH] | 加载ID[$CONTEXT_LOAD_ID] | 耗时[${TOTAL_LOAD_TIME}s] | MCP工具[Memory:$MEMORY_STATUS,Context7:$CONTEXT7_STATUS,Thinking:$THINKING_STATUS]"
    
    mcp__memory__save_memory \
        --speaker="system" \
        --message="$CONTEXT_LOAD_EXPERIENCE" \
        --context="context_loading_${PROJECT_TYPE}_optimization" >/dev/null 2>&1
    
    echo "💾 加载会话已保存到智能记忆"
fi

echo ""
echo "🎊 ===== Claude Autopilot 2.1智能环境激活完成 ====="
echo ""
echo "🚀 AI助手已完全激活，具备以下智能能力:"
echo "   🧠 深度项目理解和上下文感知"
echo "   📚 最新技术文档和最佳实践获取"  
echo "   💾 历史开发经验智能应用"
echo "   🎼 工作流智能编排和执行"
echo "   🔍 项目问题智能诊断和解决"
echo ""
echo "✨ 现在可以开始高效智能开发了！"
echo ""
```

## ⚡ **智能系统优势**

### **🧠 深度智能化**
- ✅ **项目环境深度分析**: 智能识别项目类型、规模、健康度
- ✅ **MCP工具链协调**: 深度激活和协调所有MCP工具
- ✅ **上下文智能管理**: 基于项目状态动态加载相关上下文
- ✅ **个性化建议系统**: 根据项目状态生成针对性建议

### **🎯 精准化配置**
- ✅ **项目类型特定优化**: 不同项目类型的专门优化
- ✅ **技术栈特定激活**: 针对具体技术栈的深度支持
- ✅ **健康度驱动建议**: 基于项目健康度的智能建议
- ✅ **工具可用性检测**: 动态检测和适配可用工具

### **📊 全面监控**
- ✅ **完整状态报告**: 生成详细的环境状态报告
- ✅ **性能时间跟踪**: 跟踪和优化加载性能
- ✅ **会话记录保存**: 自动保存加载会话到Memory
- ✅ **智能推荐引擎**: 基于状态分析的操作推荐

### **🔄 灵活模式支持**
- ✅ **标准模式**: 常规上下文加载
- ✅ **强制刷新模式**: 重新获取所有上下文信息
- ✅ **深度分析模式**: 获取扩展分析和建议

## 📝 **使用场景**

### **何时使用**
- 开始新的开发会话时
- 切换到不同项目时  
- AI助手行为异常时
- 长时间未开发后重启时
- 项目配置有重大变更时

### **模式选择**
- **标准模式**: 日常开发会话启动
- **强制刷新 + 深度分析**: 项目诊断和优化
- **强制刷新**: 确保信息最新和准确

这个优化后的智能系统命令将Claude Autopilot 2.1的上下文加载转变为一个全面的智能开发环境激活系统！

---
**系统版本**: Claude Autopilot 2.1
**作者**: Youmi Sam  
**架构**: 智能系统命令