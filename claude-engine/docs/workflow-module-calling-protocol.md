# Claude Autopilot 2.1 工作流模块调用协议
# Workflow Module Calling Protocol

## 📋 **协议概述**

本文档定义了Claude Autopilot 2.1智能编排系统中工作流模块的标准调用协议，确保所有编排器与工作流模块间的通信一致性和互操作性。

### **设计原则**
- ✅ **统一接口**: 所有模块使用相同的输入输出格式
- ✅ **JSON标准**: 基于JSON的结构化数据交换
- ✅ **错误一致性**: 统一的错误处理和报告格式
- ✅ **可扩展性**: 支持未来模块的无缝扩展
- ✅ **向后兼容**: 保持与现有系统的兼容性

## 🔧 **标准调用接口定义**

### **输入格式规范**

所有工作流模块必须接受以下标准JSON格式的输入：

```json
{
    "input_data": "string - 主要输入数据或任务描述",
    "context": {
        "project_path": "string - 项目绝对路径", 
        "project_name": "string - 项目名称",
        "project_type": "string - 项目类型标识",
        "tech_stack": "string - 技术栈信息", 
        "git_branch": "string - 当前Git分支",
        "git_uncommitted_changes": "number - 未提交更改数量",
        "calling_module": "string - 调用者标识",
        "context_timestamp": "string - 上下文时间戳(ISO 8601)"
    },
    "options": {
        "enable_memory": "boolean - 是否启用记忆系统",
        "enable_sequential_thinking": "boolean - 是否启用sequential-thinking",
        "timeout_seconds": "number - 超时时间(秒)",
        "priority": "string - 优先级(high/medium/low)", 
        "orchestration_level": "string - 编排级别"
    }
}
```

### **输出格式规范**

所有工作流模块必须返回以下标准JSON格式的输出：

```json
{
    "status": "string - 执行状态(success/error/partial/warning)",
    "exit_code": "number - 退出代码(0为成功)",
    "result": {
        "module_specific_data": "object - 模块特定的结果数据",
        "quality_score": "number - 质量评分(0-100)",
        "execution_summary": "string - 执行摘要"
    },
    "execution_info": {
        "module_name": "string - 模块名称",
        "execution_time": "number - 执行时间(秒)",
        "timestamp": "string - 执行完成时间戳(ISO 8601)",
        "version": "string - 模块版本"
    },
    "logs": [
        "array of strings - 执行过程日志"
    ],
    "error_details": "string - 错误详情(仅当status为error时)",
    "warnings": [
        "array of strings - 警告信息"
    ],
    "next_steps": [
        "array of strings - 建议的后续步骤"
    ]
}
```

## 🎯 **各模块特定接口**

### **1. 需求分析模块 (smart-requirement-analysis)**

**调用函数**: `call_requirement_analysis_module(input_data, project_context, options)`

**特定输入**:
```json
{
    "input_data": "需求描述或问题陈述",
    "analysis_mode": "comprehensive|quick|targeted",
    "focus_areas": ["functionality", "performance", "security", "usability"]
}
```

**特定输出**:
```json
{
    "result": {
        "analysis_id": "REQ-20240122-001", 
        "requirements": ["需求1", "需求2"],
        "analysis_depth": "详细程度评分",
        "complexity_assessment": "复杂度评估",
        "recommended_approach": "推荐方法"
    }
}
```

### **2. 解决方案生成模块 (smart-solution-generation)**

**调用函数**: `call_solution_generation_module(input_data, project_context, options)`

**特定输入**:
```json
{
    "input_data": "需求分析结果或问题描述",
    "solution_mode": "comprehensive|quick|innovative|conservative",
    "constraints": ["时间", "资源", "技术栈限制"]
}
```

**特定输出**:
```json
{
    "result": {
        "solution_id": "SOL-20240122-001",
        "primary_solution": "主要解决方案",
        "alternative_solutions": ["备选方案1", "备选方案2"],
        "implementation_plan": "实施计划",
        "success_probability": "成功概率(0-100)",
        "risk_assessment": "风险评估"
    }
}
```

### **3. 代码实现模块 (smart-code-implementation)**

**调用函数**: `call_code_implementation_module(input_data, project_context, options)`

**特定输入**:
```json
{
    "input_data": "解决方案或实现需求",
    "implementation_mode": "standard|bug-fix|feature|optimization",
    "quality_requirements": ["性能", "安全性", "可维护性"]
}
```

**特定输出**:
```json
{
    "result": {
        "implementation_id": "IMPL-20240122-001",
        "files_modified": ["文件列表"],
        "lines_changed": "代码行数统计",
        "quality_gates_passed": "质量门禁通过情况",
        "test_coverage": "测试覆盖率",
        "performance_impact": "性能影响评估"
    }
}
```

### **4. 项目结构校验模块 (smart-structure-validation)**

**调用函数**: `call_structure_validation_module(validation_mode, project_context, options)`

**特定输入**:
```json
{
    "input_data": "校验需求描述",
    "validation_mode": "comprehensive|quick|deep|pre-deploy|quality-check|structure-planning|fix-verification",
    "validation_scope": ["文件结构", "配置文件", "依赖关系", "安全性"]
}
```

**特定输出**:
```json
{
    "result": {
        "validation_id": "STRUCT-20240122-001",
        "compliance_score": "合规评分(0-100)",
        "issues_found": "发现的问题数量",
        "issues_fixed": "自动修复的问题数量",
        "validation_report": "详细校验报告",
        "recommendations": "改进建议"
    }
}
```

### **5. 工作总结模块 (smart-work-summary)**

**调用函数**: `call_work_summary_module(input_data, project_context, options)`

**特定输入**:
```json
{
    "input_data": "工作内容描述",
    "summary_mode": "auto-detection|manual-description|comprehensive",
    "include_metrics": ["代码质量", "时间消耗", "问题解决"]
}
```

**特定输出**:
```json
{
    "result": {
        "summary_id": "SUMM-20240122-001",
        "work_summary": "工作总结内容",
        "achievements": ["成就列表"],
        "quality_metrics": "质量指标",
        "commit_message": "生成的提交信息",
        "next_steps": "后续步骤建议"
    }
}
```

### **6. 项目规划模块 (smart-project-planning)**

**调用函数**: `call_project_planning_module(input_data, project_context, options)`

**特定输入**:
```json
{
    "input_data": "项目规划需求",
    "planning_mode": "comprehensive|quick|milestone-focused",
    "planning_scope": ["架构设计", "开发计划", "资源分配"]
}
```

**特定输出**:
```json
{
    "result": {
        "planning_id": "PLAN-20240122-001", 
        "project_timeline": "项目时间线",
        "milestones": ["里程碑列表"],
        "resource_requirements": "资源需求",
        "risk_mitigation": "风险缓解措施"
    }
}
```

### **7. Docker部署模块 (smart-docker-deployment)**

**调用函数**: `call_docker_deployment_module(input_data, project_context, options)`

**特定输入**:
```json
{
    "input_data": "部署配置需求",
    "deployment_mode": "production|test|development",
    "deployment_options": ["安全扫描", "性能监控", "自动扩展"]
}
```

**特定输出**:
```json
{
    "result": {
        "deployment_id": "DEPLOY-20240122-001",
        "container_status": "容器运行状态",
        "deployment_health": "部署健康度",
        "service_url": "服务访问地址",
        "security_scan_result": "安全扫描结果"
    }
}
```

## 🛠️ **辅助工具函数协议**

### **项目上下文生成**

**函数**: `get_standard_project_context(project_path, calling_module)`

**返回格式**:
```json
{
    "project_path": "/absolute/path/to/project",
    "project_name": "project-name", 
    "project_type": "golang_web_backend",
    "tech_stack": "Go,Gin,PostgreSQL,Docker",
    "git_branch": "main",
    "git_uncommitted_changes": 0,
    "calling_module": "smart-bugfix",
    "context_timestamp": "2024-01-22T15:30:45Z"
}
```

### **标准选项生成**

**函数**: `get_standard_options(enable_memory, enable_sequential_thinking, timeout, priority)`

**返回格式**:
```json
{
    "enable_memory": true,
    "enable_sequential_thinking": true,
    "timeout_seconds": 300,
    "priority": "medium",
    "orchestration_level": "standard"
}
```

## 🔍 **错误处理协议**

### **错误分类**

1. **系统错误**: 模块文件不存在、权限问题、系统资源不足
2. **输入错误**: JSON格式错误、必需参数缺失、参数值无效
3. **执行错误**: 模块内部逻辑错误、超时、依赖服务不可用
4. **输出错误**: 结果格式错误、质量门禁失败

### **错误响应格式**

```json
{
    "status": "error",
    "exit_code": "非0错误码",
    "error_details": "详细错误描述",
    "error_category": "system|input|execution|output",
    "error_context": {
        "module_name": "出错的模块名",
        "error_location": "错误发生位置",
        "input_received": "收到的输入数据摘要"
    },
    "recovery_suggestions": [
        "恢复建议1",
        "恢复建议2" 
    ],
    "execution_info": {
        "timestamp": "错误发生时间",
        "execution_time": "执行时间(到错误发生)"
    }
}
```

### **状态码定义**

- **0**: 成功完成
- **1**: 一般错误
- **2**: 输入参数错误
- **3**: 权限或访问错误  
- **4**: 资源不足错误
- **5**: 超时错误
- **6**: 依赖服务不可用
- **7**: 质量门禁失败
- **8**: 输出格式错误

## 📊 **调用监控协议**

### **调用统计记录**

每次模块调用都应记录以下统计信息：

```json
{
    "call_id": "CALL-20240122-15:30:45-001",
    "module_name": "smart-requirement-analysis",
    "orchestrator": "smart-bugfix", 
    "start_time": "2024-01-22T15:30:45Z",
    "end_time": "2024-01-22T15:31:15Z",
    "execution_time": 30,
    "status": "success",
    "input_size": 1024,
    "output_size": 2048,
    "memory_usage": "128MB",
    "cpu_usage": "15%"
}
```

### **性能基准**

各模块的性能基准参考：

| 模块名称 | 预期执行时间 | 内存使用 | CPU使用 |
|---------|-------------|----------|---------|
| smart-requirement-analysis | 30-60s | <256MB | <30% |
| smart-solution-generation | 45-90s | <512MB | <50% |
| smart-code-implementation | 60-120s | <1GB | <70% |
| smart-structure-validation | 15-45s | <256MB | <25% |
| smart-work-summary | 20-40s | <128MB | <20% |
| smart-project-planning | 30-60s | <256MB | <30% |
| smart-docker-deployment | 120-300s | <512MB | <40% |

## 🔄 **版本控制协议**

### **协议版本控制**

- **主版本**: 不兼容的API变更
- **次版本**: 向后兼容的功能添加
- **补丁版本**: 向后兼容的bug修复

**当前协议版本**: `2.0.0`

### **模块版本控制**

每个工作流模块应在输出中包含版本信息：

```json
{
    "execution_info": {
        "module_name": "smart-requirement-analysis",
        "module_version": "2.1.0",
        "protocol_version": "2.0.0",
        "api_compatibility": "2.0.x"
    }
}
```

### **向后兼容支持**

系统提供`legacy_module_call()`函数支持旧版本模块调用，但建议尽快升级到新协议。

## 📋 **实施指南**

### **编排器实施检查清单**

- [ ] 使用`workflow-module-interface.sh`工具集
- [ ] 调用前准备标准项目上下文
- [ ] 使用标准选项配置
- [ ] 实施错误处理和重试机制
- [ ] 记录调用统计和性能指标
- [ ] 验证模块输出格式
- [ ] 保存执行结果到记忆系统

### **工作流模块实施检查清单**

- [ ] 实现标准化输入解析
- [ ] 提供完整的JSON输出格式
- [ ] 包含详细的错误处理
- [ ] 记录执行日志和性能指标
- [ ] 支持超时和中断处理
- [ ] 实现质量门禁检查
- [ ] 提供版本信息

### **测试验证协议**

1. **单元测试**: 每个模块的接口合规性测试
2. **集成测试**: 编排器与模块间的协作测试
3. **性能测试**: 执行时间和资源使用测试
4. **错误处理测试**: 各种异常情况的处理测试
5. **兼容性测试**: 新旧版本间的兼容性测试

## 🎯 **最佳实践**

### **编排器最佳实践**

1. **输入验证**: 始终验证模块输入的完整性和正确性
2. **超时处理**: 为所有模块调用设置合理的超时时间
3. **重试机制**: 对暂时性失败实施指数退避重试
4. **结果缓存**: 缓存重复调用的结果以提高性能
5. **日志记录**: 详细记录调用过程和结果

### **工作流模块最佳实践**

1. **幂等性**: 确保模块调用是幂等的
2. **原子性**: 保证操作的原子性，避免部分完成状态
3. **进度报告**: 对长时间运行的操作提供进度反馈
4. **资源清理**: 确保异常情况下的资源正确释放
5. **质量保证**: 实施内置的质量检查和验证

---

**文档版本**: 2.0.0  
**最后更新**: 2024-01-22  
**维护者**: Youmi Sam  
**协议状态**: 正式发布