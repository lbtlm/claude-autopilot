#!/bin/bash
# Workflow Module Interface | 工作流模块调用接口工具集
# Claude Autopilot 2.1 - 标准化模块调用协议
# Author: Youmi Sam

# 动态检测路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_CE_PATH="$(dirname "$SCRIPT_DIR")"

## 🎯 **工具集概述**
# 为智能编排器提供标准化的工作流模块调用接口
# 确保所有编排器都使用统一的调用协议和数据格式

## 🔧 **核心调用函数**

### **1. 需求分析模块调用函数**
call_requirement_analysis_module() {
    local input_data="$1"
    local project_context="$2" 
    local options="$3"
    
    local input_json=$(cat <<EOF
{
    "input_data": "$input_data",
    "context": $project_context,
    "options": $options
}
EOF
)
    
    echo "🔍 调用需求分析模块..." >&2
    
    # 调用workflow模块的标准化接口
    if source "$GLOBAL_CE_PATH/workflows/smart-requirement-analysis.md" 2>/dev/null; then
        execute_requirement_analysis_workflow "$input_json"
    else
        # 返回标准格式的错误
        cat <<EOF
{
    "status": "error",
    "error": "需求分析模块不可用",
    "module": "smart-requirement-analysis"
}
EOF
    fi
}

### **2. 解决方案生成模块调用函数**
call_solution_generation_module() {
    local input_data="$1"
    local project_context="$2"
    local options="$3"
    
    local input_json=$(cat <<EOF
{
    "input_data": "$input_data", 
    "context": $project_context,
    "options": $options
}
EOF
)
    
    echo "🎯 调用解决方案生成模块..." >&2
    
    if source "$GLOBAL_CE_PATH/workflows/smart-solution-generation.md" 2>/dev/null; then
        execute_solution_generation_workflow "$input_json"
    else
        cat <<EOF
{
    "status": "error",
    "error": "解决方案生成模块不可用",
    "module": "smart-solution-generation"
}
EOF
    fi
}

### **3. 代码实现模块调用函数**  
call_code_implementation_module() {
    local input_data="$1"
    local project_context="$2"
    local options="$3"
    
    local input_json=$(cat <<EOF
{
    "input_data": "$input_data",
    "context": $project_context, 
    "options": $options
}
EOF
)
    
    echo "💻 调用代码实现模块..." >&2
    
    if source "$GLOBAL_CE_PATH/workflows/smart-code-implementation.md" 2>/dev/null; then
        execute_code_implementation_workflow "$input_json"
    else
        cat <<EOF
{
    "status": "error",
    "error": "代码实现模块不可用", 
    "module": "smart-code-implementation"
}
EOF
    fi
}

### **4. 项目结构校验模块调用函数**
call_structure_validation_module() {
    local validation_mode="$1"
    local project_context="$2"
    local options="$3"
    
    local input_json=$(cat <<EOF
{
    "input_data": "${validation_mode}模式项目结构校验",
    "validation_mode": "$validation_mode",
    "context": $project_context,
    "options": $options
}
EOF
)
    
    echo "🔍 调用项目结构校验模块..." >&2
    
    if source "$GLOBAL_CE_PATH/workflows/smart-structure-validation.md" 2>/dev/null; then
        execute_structure_validation_workflow "$input_json"
    else
        cat <<EOF
{
    "status": "error",
    "error": "项目结构校验模块不可用",
    "module": "smart-structure-validation"  
}
EOF
    fi
}

### **5. 工作总结模块调用函数**
call_work_summary_module() {
    local input_data="$1"
    local project_context="$2" 
    local options="$3"
    
    local input_json=$(cat <<EOF
{
    "input_data": "$input_data",
    "context": $project_context,
    "options": $options
}
EOF
)
    
    echo "📊 调用工作总结模块..." >&2
    
    if source "$GLOBAL_CE_PATH/workflows/smart-work-summary.md" 2>/dev/null; then
        execute_work_summary_workflow "$input_json"
    else
        cat <<EOF
{
    "status": "error",
    "error": "工作总结模块不可用",
    "module": "smart-work-summary"
}
EOF
    fi
}

### **6. 项目规划模块调用函数**
call_project_planning_module() {
    local input_data="$1"
    local project_context="$2"
    local options="$3"
    
    local input_json=$(cat <<EOF
{
    "input_data": "$input_data",
    "context": $project_context,
    "options": $options  
}
EOF
)
    
    echo "📋 调用项目规划模块..." >&2
    
    if source "$GLOBAL_CE_PATH/workflows/smart-project-planning.md" 2>/dev/null; then
        execute_project_planning_workflow "$input_json"
    else
        cat <<EOF
{
    "status": "error", 
    "error": "项目规划模块不可用",
    "module": "smart-project-planning"
}
EOF
    fi
}

### **7. Docker部署模块调用函数**
call_docker_deployment_module() {
    local input_data="$1"
    local project_context="$2"
    local options="$3"
    
    local input_json=$(cat <<EOF
{
    "input_data": "$input_data",
    "context": $project_context,
    "options": $options
}
EOF
)
    
    echo "🐳 调用Docker部署模块..." >&2
    
    if source "$GLOBAL_CE_PATH/workflows/smart-docker-deployment.md" 2>/dev/null; then
        execute_docker_deployment_workflow "$input_json"
    else
        cat <<EOF
{
    "status": "error",
    "error": "Docker部署模块不可用", 
    "module": "smart-docker-deployment"
}
EOF
    fi
}

## 🛠️ **辅助工具函数**

### **标准项目上下文生成**
get_standard_project_context() {
    local project_path="${1:-.}"
    local calling_module="${2:-unknown}"
    
    local project_name=$(basename "$project_path")
    local project_type=$(detect_project_type_advanced "$project_path")
    local tech_stack=$(detect_tech_stack_comprehensive "$project_path") 
    local git_branch=$(cd "$project_path" && git branch --show-current 2>/dev/null || echo "none")
    local git_status=$(cd "$project_path" && git status --porcelain 2>/dev/null | wc -l || echo "0")
    
    cat <<EOF
{
    "project_path": "$project_path",
    "project_name": "$project_name", 
    "project_type": "$project_type",
    "tech_stack": "$tech_stack",
    "git_branch": "$git_branch",
    "git_uncommitted_changes": $git_status,
    "calling_module": "$calling_module",
    "context_timestamp": "$(date -Iseconds)"
}
EOF
}

### **标准选项配置生成**
get_standard_options() {
    local enable_memory="${1:-true}"
    local enable_sequential_thinking="${2:-true}"  
    local timeout="${3:-300}"
    local priority="${4:-medium}"
    
    cat <<EOF
{
    "enable_memory": $enable_memory,
    "enable_sequential_thinking": $enable_sequential_thinking,
    "timeout_seconds": $timeout,
    "priority": "$priority",
    "orchestration_level": "standard"
}
EOF
}

### **高级项目类型检测**
detect_project_type_advanced() {
    local project_path="${1:-.}"
    
    # 检查关键文件和目录
    if [ -f "$project_path/package.json" ] && [ -f "$project_path/next.config.js" ]; then
        echo "nextjs_web_frontend"
    elif [ -f "$project_path/package.json" ] && grep -q "react" "$project_path/package.json"; then
        echo "react_web_frontend" 
    elif [ -f "$project_path/package.json" ] && grep -q "express\|fastify\|koa" "$project_path/package.json"; then
        echo "nodejs_web_backend"
    elif [ -f "$project_path/go.mod" ] && grep -q "gin\|echo\|fiber" "$project_path/go.mod"; then
        echo "golang_web_backend"
    elif [ -f "$project_path/requirements.txt" ] && grep -q "fastapi\|django\|flask" "$project_path/requirements.txt"; then
        echo "python_web_backend"
    elif [ -f "$project_path/Cargo.toml" ] && grep -q "axum\|warp\|actix" "$project_path/Cargo.toml"; then
        echo "rust_web_backend"
    elif [ -f "$project_path/docker-compose.yml" ]; then
        echo "containerized_fullstack"
    elif [ -f "$project_path/go.mod" ]; then
        echo "golang_cli_tool"
    elif [ -f "$project_path/package.json" ]; then
        echo "nodejs_application"
    elif [ -f "$project_path/requirements.txt" ]; then
        echo "python_application"
    elif [ -f "$project_path/Cargo.toml" ]; then
        echo "rust_application"
    else
        echo "general_project"
    fi
}

### **综合技术栈检测**
detect_tech_stack_comprehensive() {
    local project_path="${1:-.}"
    local tech_components=()
    
    # 前端框架检测
    if [ -f "$project_path/package.json" ]; then
        local package_content=$(cat "$project_path/package.json" 2>/dev/null || echo "{}")
        
        if echo "$package_content" | grep -q "next"; then
            tech_components+=("NextJS")
        fi
        if echo "$package_content" | grep -q "react"; then
            tech_components+=("React") 
        fi
        if echo "$package_content" | grep -q "vue"; then
            tech_components+=("Vue")
        fi
        if echo "$package_content" | grep -q "typescript"; then
            tech_components+=("TypeScript")
        fi
        if echo "$package_content" | grep -q "tailwindcss"; then
            tech_components+=("TailwindCSS")
        fi
    fi
    
    # 后端框架检测
    if [ -f "$project_path/go.mod" ]; then
        local go_content=$(cat "$project_path/go.mod" 2>/dev/null || echo "")
        tech_components+=("Go")
        
        if echo "$go_content" | grep -q "gin"; then
            tech_components+=("Gin")
        fi
        if echo "$go_content" | grep -q "gorm"; then
            tech_components+=("GORM")
        fi
    fi
    
    if [ -f "$project_path/requirements.txt" ]; then
        local python_deps=$(cat "$project_path/requirements.txt" 2>/dev/null || echo "")
        tech_components+=("Python")
        
        if echo "$python_deps" | grep -q "fastapi"; then
            tech_components+=("FastAPI")
        elif echo "$python_deps" | grep -q "django"; then
            tech_components+=("Django") 
        elif echo "$python_deps" | grep -q "flask"; then
            tech_components+=("Flask")
        fi
    fi
    
    # 数据库检测
    if [ -f "$project_path/docker-compose.yml" ]; then
        local compose_content=$(cat "$project_path/docker-compose.yml" 2>/dev/null || echo "")
        
        if echo "$compose_content" | grep -q "postgres"; then
            tech_components+=("PostgreSQL")
        fi
        if echo "$compose_content" | grep -q "mysql"; then
            tech_components+=("MySQL")
        fi
        if echo "$compose_content" | grep -q "redis"; then
            tech_components+=("Redis")
        fi
    fi
    
    # 容器化检测
    if [ -f "$project_path/Dockerfile" ]; then
        tech_components+=("Docker")
    fi
    
    if [ -f "$project_path/docker-compose.yml" ]; then
        tech_components+=("Docker-Compose")
    fi
    
    # 输出技术栈
    if [ ${#tech_components[@]} -gt 0 ]; then
        IFS=","
        echo "${tech_components[*]}"
    else
        echo "Unknown"
    fi
}

### **调用结果状态检查**
check_module_call_result() {
    local result_json="$1" 
    local module_name="$2"
    
    if [ -z "$result_json" ]; then
        echo "❌ $module_name 模块无响应" >&2
        return 1
    fi
    
    local status=$(echo "$result_json" | jq -r '.status // "unknown"' 2>/dev/null || echo "parse_error")
    
    case "$status" in
        "success")
            echo "✅ $module_name 模块执行成功" >&2
            return 0
            ;;
        "error")
            local error_msg=$(echo "$result_json" | jq -r '.error // "未知错误"' 2>/dev/null || echo "解析错误")
            echo "❌ $module_name 模块执行失败: $error_msg" >&2
            return 1
            ;;
        "partial")
            local warning_msg=$(echo "$result_json" | jq -r '.warning // "部分完成"' 2>/dev/null || echo "部分完成")
            echo "⚠️ $module_name 模块部分完成: $warning_msg" >&2
            return 0
            ;;
        *)
            echo "⚠️ $module_name 模块状态未知: $status" >&2
            return 1
            ;;
    esac
}

### **模块调用错误处理**
handle_module_call_error() {
    local module_name="$1"
    local error_code="$2"
    local context="$3"
    
    echo "🚨 模块调用错误处理: $module_name (错误码: $error_code)" >&2
    
    case "$error_code" in
        1)
            echo "   原因: 模块文件不存在或不可访问" >&2
            echo "   建议: 检查模块路径和权限" >&2
            ;;
        2)
            echo "   原因: 模块执行失败" >&2  
            echo "   建议: 检查输入参数和模块内部逻辑" >&2
            ;;
        3)
            echo "   原因: 输出格式错误" >&2
            echo "   建议: 检查模块输出JSON格式" >&2
            ;;
        *)
            echo "   原因: 未知错误" >&2
            echo "   建议: 检查系统日志和模块状态" >&2
            ;;
    esac
    
    # 可选: 保存错误信息到记忆系统
    if command -v mcp__memory__save_memory >/dev/null 2>&1; then
        local error_record="模块调用错误: $module_name 在上下文 $context 中失败，错误码 $error_code"
        mcp__memory__save_memory \
            --speaker="system" \
            --message="$error_record" \
            --context="module_call_errors" >/dev/null 2>&1 || true
    fi
}

## 📊 **模块调用统计和监控**

### **调用统计记录**
record_module_call_stats() {
    local module_name="$1"
    local status="$2"
    local execution_time="$3"
    local orchestrator="$4"
    
    local stats_dir="$GLOBAL_CE_PATH/stats"
    local stats_file="$stats_dir/module_call_stats.json"
    
    # 创建统计目录
    mkdir -p "$stats_dir"
    
    # 如果统计文件不存在，创建基础结构
    if [ ! -f "$stats_file" ]; then
        echo '{"daily_stats": {}, "module_stats": {}, "orchestrator_stats": {}}' > "$stats_file"
    fi
    
    # 记录调用统计（简化版本，实际实现可能需要更复杂的逻辑）
    local today=$(date +%Y-%m-%d)
    local timestamp=$(date -Iseconds)
    
    # 这里可以添加实际的统计记录逻辑
    echo "📊 统计记录: $module_name | $status | ${execution_time}s | $orchestrator | $timestamp" >> "$stats_dir/call_log.txt"
}

## 🔄 **版本兼容性支持**

### **向后兼容调用支持**
legacy_module_call() {
    local module_name="$1"
    local input_data="$2"
    
    echo "⚠️ 使用遗留模式调用: $module_name" >&2
    echo "🔄 建议升级到标准化调用协议" >&2
    
    # 提供基础的向后兼容支持
    case "$module_name" in
        "smart-bugfix")
            call_requirement_analysis_module "$input_data" "{}" "{}"
            ;;
        "smart-feature-dev") 
            call_solution_generation_module "$input_data" "{}" "{}"
            ;;
        *)
            echo "❌ 不支持的遗留模块: $module_name" >&2
            return 1
            ;;
    esac
}

## 📋 **使用说明和示例**

### **标准调用示例**
# 在编排器中的使用示例:
#
# ```bash
# # 加载接口工具集
# source "$GLOBAL_CE_PATH/utils/workflow-module-interface.sh"
#
# # 准备标准输入
# PROJECT_CONTEXT=$(get_standard_project_context "$(pwd)" "smart-bugfix")
# STANDARD_OPTIONS=$(get_standard_options "true" "true" "300")
#
# # 调用需求分析模块
# ANALYSIS_RESULT=$(call_requirement_analysis_module "分析Bug原因" "$PROJECT_CONTEXT" "$STANDARD_OPTIONS")
#
# # 检查调用结果
# if check_module_call_result "$ANALYSIS_RESULT" "需求分析"; then
#     echo "分析成功，继续后续步骤"
# else
#     handle_module_call_error "需求分析" $? "bug修复流程"
#     exit 1
# fi
# ```

echo "✅ Claude Autopilot 2.1 工作流模块调用接口工具集已加载"
echo "🎯 支持7个核心工作流模块的标准化调用"
echo "🛠️ 提供完整的错误处理和统计监控功能"