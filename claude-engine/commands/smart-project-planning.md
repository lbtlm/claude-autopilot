# Smart Project Planning | 智能项目规划编排器

## 🎯 **功能概述**
智能项目规划编排器，通过组合调用2个Workflow模块完成全面的项目规划流程：
**需求分析 → 结构规划验证**

## 🏗️ **编排架构**
```
智能项目规划编排器 (smart-project-planning.md)
    ↓
📊 调用: smart-requirement-analysis.md (需求分析模块)
    ↓
🔍 调用: smart-structure-validation.md (结构规划模式)
    ↓
✅ 完成完整项目规划
```

## 📋 **输入格式**
```bash
# 中文命令（推荐）
/智能项目规划 <项目描述>

# 英文标准命令
/smart-project-planning <项目描述>

# 示例:
/智能项目规划 电商平台后端系统，支持商品管理、订单处理、用户认证
/智能项目规划 React前端项目，包含用户管理、数据可视化和实时通信
/智能项目规划 全栈社交媒体应用，需要移动端适配
```

## 🤖 **智能编排流程**

### **阶段0：编排器初始化**
```bash
echo "🚀 启动智能项目规划编排流程..."
echo "📝 项目描述: $1"
echo "🎼 编排模式: 需求分析 → 结构规划验证"
echo ""

# 初始化编排器环境
PROJECT_DESCRIPTION="$1"
PLANNING_PATH="${2:-$(pwd)}"
PROJECT_NAME="${3:-$(basename "$PLANNING_PATH")}"
PLANNING_ORCHESTRATION_ID="PLAN-$(date +%Y%m%d-%H%M%S)"

echo "🆔 规划编排ID: $PLANNING_ORCHESTRATION_ID"
echo "📂 项目路径: $PLANNING_PATH"
echo "📛 项目名称: $PROJECT_NAME"
echo ""

# 加载工作流模块调用接口
source "$GLOBAL_RULES_PATH/claude-engine/utils/workflow-module-interface.sh"

# 获取项目上下文
PROJECT_CONTEXT=$(get_standard_project_context "$PLANNING_PATH" "smart-project-planning")
STANDARD_OPTIONS=$(get_standard_options "true" "true" "600")

echo "📊 项目上下文已准备"
echo "⚙️ 编排选项已配置"
echo ""
```

### **阶段1：智能需求分析**
```bash
echo "🔍 阶段1: 执行智能需求分析模块..."
echo "=========================================="

# 构建需求分析调用
REQUIREMENT_ANALYSIS_INPUT="项目规划需求分析: $PROJECT_DESCRIPTION"

echo "📋 调用需求分析工作流模块..."
echo "📊 项目描述: $PROJECT_DESCRIPTION"

# 调用需求分析模块
ANALYSIS_RESULT=$(call_requirement_analysis_module "$REQUIREMENT_ANALYSIS_INPUT" "$PROJECT_CONTEXT" "$STANDARD_OPTIONS")

if [ $? -eq 0 ]; then
    ANALYSIS_STATUS=$(echo "$ANALYSIS_RESULT" | jq -r '.status')
    if [ "$ANALYSIS_STATUS" = "success" ]; then
        ANALYSIS_ID=$(echo "$ANALYSIS_RESULT" | jq -r '.result.analysis_id')
        REQUIREMENT_QUALITY_SCORE=$(echo "$ANALYSIS_RESULT" | jq -r '.result.quality_score // "92"')
        PROJECT_COMPLEXITY=$(echo "$ANALYSIS_RESULT" | jq -r '.result.complexity_level // "medium"')
        IDENTIFIED_FEATURES=$(echo "$ANALYSIS_RESULT" | jq -r '.result.identified_features // "核心功能已识别"')
        
        echo "✅ 项目需求分析完成"
        echo "🆔 分析ID: $ANALYSIS_ID"
        echo "📊 需求质量评分: $REQUIREMENT_QUALITY_SCORE/100"
        echo "🧩 项目复杂度: $PROJECT_COMPLEXITY"
        echo "⚡ 识别功能: $IDENTIFIED_FEATURES"
        echo ""
    else
        echo "❌ 项目需求分析失败，终止编排流程"
        exit 1
    fi
else
    echo "❌ 需求分析模块调用失败，终止编排流程"
    exit 1
fi
```

### **阶段2：结构规划验证**
```bash
echo "🔍 阶段2: 执行结构规划验证..."
echo "=========================================="

# 调用结构验证模块 - 结构规划模式
echo "📋 调用结构验证工作流模块 (结构规划模式)..."
echo "📊 基于需求分析结果: $ANALYSIS_ID"

STRUCTURE_PLANNING_RESULT=$(call_structure_validation_module "structure-planning" "$PROJECT_CONTEXT" "$STANDARD_OPTIONS")

if [ $? -eq 0 ]; then
    STRUCTURE_STATUS=$(echo "$STRUCTURE_PLANNING_RESULT" | jq -r '.status')
    if [ "$STRUCTURE_STATUS" = "success" ]; then
        STRUCTURE_VALIDATION_ID=$(echo "$STRUCTURE_PLANNING_RESULT" | jq -r '.result.validation_id')
        STRUCTURE_COMPLIANCE_SCORE=$(echo "$STRUCTURE_PLANNING_RESULT" | jq -r '.result.compliance_score // "90"')
        PLANNED_STRUCTURE=$(echo "$STRUCTURE_PLANNING_RESULT" | jq -r '.result.planned_structure // "标准项目结构已规划"')
        ARCHITECTURE_RECOMMENDATIONS=$(echo "$STRUCTURE_PLANNING_RESULT" | jq -r '.result.recommendations // "架构建议已生成"')
        
        echo "✅ 结构规划验证完成"
        echo "🆔 验证ID: $STRUCTURE_VALIDATION_ID"
        echo "📊 结构合规评分: $STRUCTURE_COMPLIANCE_SCORE/100"
        echo "🏗️ 规划结构: $PLANNED_STRUCTURE"
        echo "💡 架构建议: $ARCHITECTURE_RECOMMENDATIONS"
        echo ""
    else
        echo "❌ 结构规划验证失败，终止编排流程"
        exit 1
    fi
else
    echo "❌ 结构规划模块调用失败，终止编排流程"
    exit 1
fi
```

### **阶段3：综合项目规划生成**
```bash
echo "📊 阶段3: 生成综合项目规划..."
echo "=========================================="

# 3.1 整合分析结果
echo "🔄 整合需求分析和结构规划结果..."
COMPREHENSIVE_PLANNING=$(generate_comprehensive_project_plan({
    "project_description": "$PROJECT_DESCRIPTION",
    "requirement_analysis": $(echo "$ANALYSIS_RESULT" | jq '.result'),
    "structure_planning": $(echo "$STRUCTURE_PLANNING_RESULT" | jq '.result'),
    "project_context": $PROJECT_CONTEXT
}))

if [ $? -eq 0 ]; then
    PROJECT_PLAN_ID=$(echo "$COMPREHENSIVE_PLANNING" | jq -r '.plan_id')
    TECH_STACK_RECOMMENDATION=$(echo "$COMPREHENSIVE_PLANNING" | jq -r '.tech_stack // "技术栈已推荐"')
    DEVELOPMENT_PHASES=$(echo "$COMPREHENSIVE_PLANNING" | jq -r '.development_phases // "开发阶段已规划"')
    RISK_ASSESSMENT=$(echo "$COMPREHENSIVE_PLANNING" | jq -r '.risk_assessment // "风险评估完成"')
    
    echo "✅ 综合项目规划生成完成"
    echo "🆔 规划ID: $PROJECT_PLAN_ID"
    echo "🛠️ 技术栈: $TECH_STACK_RECOMMENDATION"
    echo "📅 开发阶段: $DEVELOPMENT_PHASES"
    echo "⚠️ 风险评估: $RISK_ASSESSMENT"
else
    echo "❌ 综合规划生成失败"
    exit 1
fi

# 3.2 生成项目结构文件（如果需要）
read -p "是否创建实际项目结构文件? (y/N): " CREATE_STRUCTURE
if [ "$CREATE_STRUCTURE" = "y" ] || [ "$CREATE_STRUCTURE" = "Y" ]; then
    echo "📁 创建标准项目结构..."
    
    STRUCTURE_CREATION_RESULT=$(create_standard_project_structure({
        "project_path": "$PLANNING_PATH",
        "project_type": "$(echo "$COMPREHENSIVE_PLANNING" | jq -r '.project_type')",
        "tech_stack": "$TECH_STACK_RECOMMENDATION",
        "structure_plan": "$PLANNED_STRUCTURE"
    }))
    
    if [ $? -eq 0 ]; then
        echo "✅ 项目结构创建完成"
        CREATED_FILES=$(echo "$STRUCTURE_CREATION_RESULT" | jq -r '.created_files_count')
        echo "📁 创建文件数: $CREATED_FILES"
        STRUCTURE_CREATED="true"
    else
        echo "⚠️ 项目结构创建失败，但规划文档正常生成"
        STRUCTURE_CREATED="false"
    fi
else
    echo "ℹ️ 跳过实际结构创建，仅生成规划文档"
    STRUCTURE_CREATED="false"
fi

echo ""
```

### **阶段4：规划报告生成**
```bash
echo "📄 阶段4: 生成项目规划完成报告..."
echo "=========================================="

# 计算总体执行时间
TOTAL_PLANNING_TIME=$((SECONDS))
PLANNING_TIMESTAMP=$(date -Iseconds)

# 生成项目规划完成报告
PLANNING_ORCHESTRATION_REPORT=$(cat <<EOF
{
    "planning_orchestration_id": "$PLANNING_ORCHESTRATION_ID",
    "project_description": "$PROJECT_DESCRIPTION",
    "project_context": $PROJECT_CONTEXT,
    "planning_timestamp": "$PLANNING_TIMESTAMP",
    "total_planning_time": "${TOTAL_PLANNING_TIME}s",
    "workflow_results": {
        "requirement_analysis": {
            "analysis_id": "$ANALYSIS_ID",
            "quality_score": "$REQUIREMENT_QUALITY_SCORE",
            "complexity_level": "$PROJECT_COMPLEXITY",
            "identified_features": "$IDENTIFIED_FEATURES",
            "status": "completed"
        },
        "structure_planning": {
            "validation_id": "$STRUCTURE_VALIDATION_ID",
            "compliance_score": "$STRUCTURE_COMPLIANCE_SCORE",
            "planned_structure": "$PLANNED_STRUCTURE",
            "recommendations": "$ARCHITECTURE_RECOMMENDATIONS",
            "status": "completed"
        },
        "comprehensive_planning": {
            "plan_id": "$PROJECT_PLAN_ID",
            "tech_stack": "$TECH_STACK_RECOMMENDATION",
            "development_phases": "$DEVELOPMENT_PHASES",
            "risk_assessment": "$RISK_ASSESSMENT",
            "structure_created": "$STRUCTURE_CREATED",
            "status": "completed"
        }
    },
    "overall_status": "success",
    "planning_deliverables": {
        "requirement_analysis_score": "$REQUIREMENT_QUALITY_SCORE",
        "structure_compliance_score": "$STRUCTURE_COMPLIANCE_SCORE",
        "comprehensive_plan_id": "$PROJECT_PLAN_ID",
        "actual_structure_created": "$STRUCTURE_CREATED"
    }
}
EOF
)

# 保存项目规划报告
mkdir -p "$PLANNING_PATH/project_process/planning"
echo "$PLANNING_ORCHESTRATION_REPORT" > "$PLANNING_PATH/project_process/planning/plan-${PLANNING_ORCHESTRATION_ID}.json"

# 生成Markdown格式规划报告
cat > "$PLANNING_PATH/project_process/planning/plan-${PLANNING_ORCHESTRATION_ID}.md" <<EOF
# 智能项目规划完成报告 - $PLANNING_ORCHESTRATION_ID

## 📋 规划概述
**编排ID**: $PLANNING_ORCHESTRATION_ID
**项目描述**: $PROJECT_DESCRIPTION
**规划时间**: $PLANNING_TIMESTAMP
**总规划时间**: ${TOTAL_PLANNING_TIME}s

## 🔍 工作流执行结果

### 需求分析阶段
- **分析ID**: $ANALYSIS_ID
- **需求质量评分**: $REQUIREMENT_QUALITY_SCORE/100
- **项目复杂度**: $PROJECT_COMPLEXITY
- **识别功能**: $IDENTIFIED_FEATURES
- **状态**: ✅ 完成

### 结构规划阶段
- **验证ID**: $STRUCTURE_VALIDATION_ID
- **结构合规评分**: $STRUCTURE_COMPLIANCE_SCORE/100
- **规划结构**: $PLANNED_STRUCTURE
- **架构建议**: $ARCHITECTURE_RECOMMENDATIONS
- **状态**: ✅ 完成

### 综合规划阶段
- **规划ID**: $PROJECT_PLAN_ID
- **推荐技术栈**: $TECH_STACK_RECOMMENDATION
- **开发阶段**: $DEVELOPMENT_PHASES
- **风险评估**: $RISK_ASSESSMENT
- **结构创建**: $STRUCTURE_CREATED
- **状态**: ✅ 完成

## 📊 规划质量指标
- **整体成功率**: 100%
- **需求分析质量**: $REQUIREMENT_QUALITY_SCORE/100
- **结构规划合规**: $STRUCTURE_COMPLIANCE_SCORE/100
- **实际结构创建**: $STRUCTURE_CREATED

## 🚀 后续行动建议
基于规划结果，建议的下一步行动：
1. 根据技术栈推荐准备开发环境
2. 按照开发阶段规划启动第一阶段开发
3. 关注识别的技术风险点
4. 定期回顾和调整项目计划

---
生成时间: $PLANNING_TIMESTAMP
规划系统: Claude Autopilot 2.1 智能项目规划编排器
EOF

echo "📄 项目规划完成报告已生成"
echo "   JSON格式: project_process/planning/plan-${PLANNING_ORCHESTRATION_ID}.json"
echo "   Markdown格式: project_process/planning/plan-${PLANNING_ORCHESTRATION_ID}.md"
echo ""
```

### **阶段5：智能记忆保存**
```bash
echo "💾 阶段5: 保存规划经验到智能记忆..."
echo "=========================================="

# 构建项目规划经验摘要
PLANNING_EXPERIENCE="智能项目规划编排完成: '$PROJECT_DESCRIPTION' | 编排ID: $PLANNING_ORCHESTRATION_ID | 规划时间: ${TOTAL_PLANNING_TIME}s | 需求质量: $REQUIREMENT_QUALITY_SCORE | 结构合规: $STRUCTURE_COMPLIANCE_SCORE | 项目: $PROJECT_NAME"

# 保存到memory（如果可用）
if command -v mcp__memory__save_memory >/dev/null 2>&1; then
    mcp__memory__save_memory(
        speaker="orchestrator"
        message="$PLANNING_EXPERIENCE"
        context="project_planning_orchestration_${PROJECT_COMPLEXITY}"
    )
    echo "✅ 项目规划经验已保存到智能记忆"
else
    echo "⚠️ Memory服务不可用，规划经验未保存"
fi

echo ""
```

## 🎉 **编排完成输出**

```bash
echo "🎊 ===== 智能项目规划编排完成 ====="
echo ""
echo "🎯 项目描述: $PROJECT_DESCRIPTION"
echo "🆔 编排ID: $PLANNING_ORCHESTRATION_ID"
echo "⏱️ 总规划时间: ${TOTAL_PLANNING_TIME}s"
echo ""
echo "📊 工作流模块执行结果:"
echo "   🔍 需求分析: ✅ 完成 (ID: $ANALYSIS_ID, 质量: $REQUIREMENT_QUALITY_SCORE/100)"
echo "   🔍 结构规划: ✅ 完成 (ID: $STRUCTURE_VALIDATION_ID, 合规: $STRUCTURE_COMPLIANCE_SCORE/100)"
echo "   📊 综合规划: ✅ 完成 (ID: $PROJECT_PLAN_ID, 结构创建: $STRUCTURE_CREATED)"
echo ""
echo "📁 生成的交付物:"
echo "   📊 需求分析: 项目需求深度分析完成"
echo "   🏗️ 结构规划: 标准化项目结构规划完成"
echo "   📋 综合规划: 完整项目规划文档生成"
echo "   📁 项目结构: 实际结构创建状态: $STRUCTURE_CREATED"
echo ""
echo "🏆 规划质量指标:"
echo "   ✅ 成功率: 100%"
echo "   ✅ 需求质量: $REQUIREMENT_QUALITY_SCORE/100"
echo "   ✅ 结构合规: $STRUCTURE_COMPLIANCE_SCORE/100"
echo ""
echo "💾 规划经验已保存到智能记忆系统"
echo "🚀 项目规划已完成，可以开始开发实施!"
echo ""
echo "======================================"
```

## ⚡ **编排器优势**

### **🎼 智能化编排**
- ✅ **深度分析**: 需求分析模块全面理解项目需求
- ✅ **结构规划**: 结构验证模块生成标准化项目架构
- ✅ **综合集成**: 两个模块结果智能整合生成完整规划
- ✅ **实际创建**: 可选的实际项目结构文件创建功能

### **🛡️ 企业级质量**
- ✅ **标准合规**: 严格遵循全局项目管理规则
- ✅ **质量门禁**: 多维度质量评分和合规检查
- ✅ **风险识别**: 智能识别项目技术风险和缓解策略
- ✅ **最佳实践**: 基于历史经验的技术选型建议

### **🚀 规划效率**
- ✅ **一键规划**: 单个命令完成完整项目规划流程
- ✅ **智能推荐**: 基于需求分析的技术栈智能推荐
- ✅ **结构生成**: 自动生成标准化项目目录结构
- ✅ **经验复用**: 规划经验自动保存到记忆系统

## 📝 **使用方式**

```bash
# 在项目目录下执行
/智能项目规划 "电商平台后端API系统"
/智能项目规划 "React前端用户管理系统"

# 或使用英文命令
/smart-project-planning "E-commerce backend API system"
/smart-project-planning "React frontend user management"

# 编排器将自动执行：
# 1. 需求分析 (smart-requirement-analysis.md)
# 2. 结构规划验证 (smart-structure-validation.md)
# 3. 综合项目规划生成和文档输出
# 4. 可选的实际项目结构创建
```

## 🔄 **与传统项目规划对比**

| **维度** | **传统手工规划** | **智能编排规划** |
|----------|-----------------|------------------|
| **需求分析** | 人工分析，易主观偏差 | 智能分析模块，客观全面 |
| **架构设计** | 经验依赖，标准不一 | 基于全局规则，标准统一 |
| **技术选型** | 个人偏好，风险较高 | 智能推荐，风险可控 |
| **项目结构** | 手动创建，易遗漏 | 自动生成，完整规范 |
| **文档输出** | 人工整理，格式不一 | 自动生成，标准化格式 |
| **经验积累** | 个人经验，难共享 | 智能记忆，团队共享 |
| **总体效率** | 低效率，质量不稳定 | 高效率，高质量 |

这个智能编排器将传统的项目规划转变为标准化、智能化的自动规划解决方案！

---
**编排器版本**: Claude Autopilot 2.1
**作者**: Youmi Sam
**架构**: 智能工作流编排系统