# Smart PRP Base Template | 智能PRP基础模板 v2.0

## 📋 **模板说明**
这是集成了MCP工具能力的智能化PRP模板，专为中国开发者优化，支持完整的智能开发工作流程。

## 🎯 **项目目标**
**功能名称**: {FEATURE_NAME}
**需求描述**: {REQUIREMENTS_DESCRIPTION}
**业务价值**: {BUSINESS_VALUE}
**用户影响**: {USER_IMPACT}

## 📊 **智能分析结果**
**PRP ID**: {PRP_ID}
**生成时间**: {GENERATION_TIMESTAMP}
**复杂度评分**: {COMPLEXITY_SCORE}/10
**预估成功率**: {SUCCESS_PROBABILITY}%
**预估工作量**: {ESTIMATED_HOURS} 小时
**风险等级**: {RISK_LEVEL}

## 🧠 **智能上下文集成**

### **MCP工具链结果**
```yaml
Memory智能回忆:
  相关经验: {MEMORY_EXPERIENCES_COUNT}条
  成功案例: {SUCCESSFUL_CASES}
  历史踩坑: {KNOWN_PITFALLS}
  最佳实践: {BEST_PRACTICES}

Context7技术文档:
  主要技术栈: {TECH_STACK}
  API文档: {API_DOCUMENTATION_URLS}
  最佳实践: {TECHNICAL_BEST_PRACTICES}
  常见问题: {COMMON_ISSUES_SOLUTIONS}

Sequential-thinking分析:
  任务分解: {TASK_BREAKDOWN}
  风险评估: {RISK_ASSESSMENT}  
  实施策略: {IMPLEMENTATION_STRATEGY}
  验证计划: {VALIDATION_PLAN}

项目内参考:
  相似实现: {SIMILAR_IMPLEMENTATIONS}
  可复用组件: {REUSABLE_COMPONENTS}
  现有模式: {EXISTING_PATTERNS}
```

### **全局规则适用**
```yaml
强制规则遵守:
  - 代码规范: {CODING_STANDARDS_APPLIED}
  - API设计: {API_DESIGN_STANDARDS}
  - 数据库规范: {DATABASE_STANDARDS}
  - 安全要求: {SECURITY_REQUIREMENTS}
  - 日志规范: {LOGGING_STANDARDS}

禁止规则检查:
  - 硬编码敏感信息: 严格禁止
  - 跳过测试: 严格禁止
  - 违反API规范: 严格禁止
  - 忽略安全检查: 严格禁止
```

## 🏗️ **智能架构设计**

### **整体架构方案**
基于智能分析的架构建议：
```
{ARCHITECTURE_OVERVIEW}
```

### **数据模型设计**
```python
# 基于全局数据库规范的智能数据模型设计
{DATA_MODEL_DESIGN}

# 必须字段（遵循全局规范）
class BaseModel:
    id: int = Field(primary_key=True)
    created_at: datetime = Field(default_factory=datetime.now)
    updated_at: datetime = Field(default_factory=datetime.now)
    # deleted_at: Optional[datetime] = None  # 软删除（可选）

# 业务模型
{BUSINESS_MODELS}
```

### **API接口设计**  
```python
# 遵循全局API规范的接口设计
{API_INTERFACE_DESIGN}

# 统一响应格式（强制要求）
class StandardResponse:
    code: int = 200
    message: str = "操作成功"
    data: Optional[Any] = None
    
# 业务接口
{BUSINESS_API_ENDPOINTS}
```

### **核心业务逻辑架构**
```python
# 核心业务逻辑设计框架
{CORE_BUSINESS_LOGIC}
```

## 📋 **智能实施蓝图**

### **Phase 1: 基础设施准备** (预计 {PHASE1_HOURS} 小时)
```yaml
Task 1.1: 数据模型实现
  文件: src/models/{model_name}.py
  依赖: 数据库连接、ORM配置
  参考: {SIMILAR_MODEL_REFERENCE}
  验证: 模型创建和基础操作测试

Task 1.2: 数据库迁移
  文件: migrations/{timestamp}_create_{table_name}.sql
  依赖: 数据模型定义
  注意: 遵循全局数据库命名规范
  验证: 迁移执行成功，表结构正确

Task 1.3: 基础配置
  文件: config/settings.py
  依赖: 环境变量配置
  安全: 敏感配置必须使用环境变量
  验证: 配置加载和验证功能
```

### **Phase 2: 核心功能实现** (预计 {PHASE2_HOURS} 小时)  
```yaml
Task 2.1: 业务逻辑实现
  文件: src/services/{service_name}.py
  模式: {BUSINESS_LOGIC_PATTERN}
  参考: {SIMILAR_SERVICE_REFERENCE}
  验证: 单元测试全覆盖

Task 2.2: API端点实现
  文件: src/api/{api_module}.py
  规范: 严格遵循全局API设计规范
  安全: 输入验证、权限检查、错误处理
  验证: API测试和文档生成

Task 2.3: 错误处理
  模式: {ERROR_HANDLING_PATTERN}
  参考: {ERROR_HANDLING_REFERENCE}
  要求: 统一错误响应格式
  验证: 异常情况测试
```

### **Phase 3: 集成和优化** (预计 {PHASE3_HOURS} 小时)
```yaml  
Task 3.1: 前端集成 (如适用)
  文件: {FRONTEND_FILES}
  框架: {FRONTEND_FRAMEWORK}
  模式: {UI_PATTERNS}
  验证: Puppeteer自动化测试

Task 3.2: 性能优化
  焦点: {PERFORMANCE_FOCUS_AREAS}
  基准: {PERFORMANCE_BENCHMARKS}
  优化: {OPTIMIZATION_STRATEGIES}
  验证: 性能指标测试

Task 3.3: 安全加固
  检查: {SECURITY_CHECKLIST}
  措施: {SECURITY_MEASURES}
  验证: 安全扫描和渗透测试
```

## ✅ **多层次智能验证门**

### **Level 1: 代码质量验证**
```bash
# 强制执行的代码质量检查
make lint          # 代码规范检查
make typecheck     # 类型检查
make security-scan # 安全扫描

# 期望结果: 100%通过，零警告
# 失败处理: 自动修复 + 智能建议
```

### **Level 2: 单元测试验证**
```python
# 智能生成的单元测试用例
{UNIT_TEST_CASES}

# 测试覆盖要求
class TestCoverage:
    minimum_coverage = 80  # 最低覆盖率
    critical_paths = 100   # 关键路径必须100%覆盖
```

```bash
# 单元测试执行
make test
# 期望结果: 100%通过，覆盖率 >= 80%
# 失败处理: 智能分析 + 自动修复
```

### **Level 3: 集成测试验证**
```python
# 集成测试场景设计
{INTEGRATION_TEST_SCENARIOS}
```

```bash
# 集成测试执行
make test-integration
# 期望结果: 所有集成点正常工作
# 失败处理: 接口兼容性检查 + 智能修复
```

### **Level 4: 端到端验证** (Web项目)
```javascript
// Puppeteer自动化测试场景
{PUPPETEER_TEST_SCENARIOS}
```

```bash
# 端到端测试执行
make test-e2e
# 期望结果: 用户完整流程测试通过
# 失败处理: 界面自动回归 + 交互修复
```

### **Level 5: 性能和安全验证**
```bash
# 性能基准测试
make benchmark
# 期望: {PERFORMANCE_TARGETS}

# 安全漏洞扫描  
make security-audit
# 期望: 零高危漏洞，低风险可接受
```

## 🎯 **智能成功标准**

### **功能完整性检查清单**
- [ ] 核心功能100%实现: {CORE_FEATURES_LIST}
- [ ] 错误处理覆盖所有场景: {ERROR_SCENARIOS}  
- [ ] API接口符合全局规范: {API_COMPLIANCE_CHECKLIST}
- [ ] 数据模型遵循命名约定: {DATA_MODEL_COMPLIANCE}
- [ ] 安全措施全部到位: {SECURITY_MEASURES_CHECKLIST}

### **质量标准检查清单**
- [ ] 代码规范检查: 100%通过
- [ ] 类型检查: 100%通过  
- [ ] 单元测试覆盖率: >= 80%
- [ ] 集成测试: 100%通过
- [ ] 性能基准: 达到{PERFORMANCE_TARGETS}
- [ ] 安全扫描: 无高危漏洞
- [ ] 文档完整性: API文档自动生成

### **用户体验检查清单**
- [ ] 界面响应时间: < {UI_RESPONSE_TIME}ms
- [ ] 错误提示友好: {ERROR_MESSAGE_EXAMPLES}
- [ ] 移动端适配: {MOBILE_COMPATIBILITY_REQUIREMENTS}
- [ ] 无障碍支持: {ACCESSIBILITY_REQUIREMENTS}

## 🚨 **风险缓解和应急预案**

### **识别的高风险项**
```yaml
{HIGH_RISK_ITEMS}
```

### **风险缓解策略**
```yaml
{RISK_MITIGATION_STRATEGIES}
```

### **应急回滚计划**
```yaml
回滚触发条件:
  - 核心功能无法正常工作
  - 性能严重下降 (> {PERFORMANCE_DEGRADATION_THRESHOLD}%)
  - 发现安全漏洞
  - 用户体验严重受影响

回滚步骤:
  1. 停止新功能访问
  2. 恢复数据库到备份点: {BACKUP_RESTORE_PROCEDURE}
  3. 回滚代码到稳定版本: {CODE_ROLLBACK_PROCEDURE}  
  4. 验证系统稳定性
  5. 通知相关人员
```

## 💡 **智能优化建议**

### **性能优化机会**
```yaml
{PERFORMANCE_OPTIMIZATION_OPPORTUNITIES}
```

### **可扩展性考虑**
```yaml
{SCALABILITY_CONSIDERATIONS}
```

### **技术债务预防**
```yaml
{TECHNICAL_DEBT_PREVENTION}
```

## 📚 **知识转移和文档**

### **自动生成文档**
- API文档: Swagger/OpenAPI自动生成
- 数据库文档: 基于模型自动生成
- 部署文档: 基于配置自动生成

### **团队知识分享**
```yaml
知识分享清单:
  - 新功能架构设计分享
  - 关键技术决策说明  
  - 踩坑经验和解决方案
  - 测试策略和用例设计
  - 监控和告警配置
```

## 🎊 **完成验收标准**

### **技术验收**
- ✅ 所有验证门100%通过
- ✅ 代码审查完成并通过
- ✅ 部署脚本测试成功
- ✅ 监控指标配置完成
- ✅ 文档自动生成并审核

### **业务验收**  
- ✅ 功能演示成功
- ✅ 用户体验测试通过
- ✅ 业务场景全覆盖
- ✅ 性能指标达标
- ✅ 安全审计通过

### **运维验收**
- ✅ 部署流程验证
- ✅ 监控告警测试
- ✅ 备份恢复测试  
- ✅ 日志收集配置
- ✅ 运维文档完整

---

## 🚀 **执行建议**

**预估成功率**: {SUCCESS_PROBABILITY}%
**关键成功因素**: {SUCCESS_FACTORS}
**建议执行时间**: {RECOMMENDED_EXECUTION_TIME}
**资源需求**: {RESOURCE_REQUIREMENTS}

**下一步操作**: 执行 `/智能代码实现 {PRP_ID}`

---

*本智能PRP由Claude Autopilot 2.1系统自动生成，集成了MCP工具链的全部智能能力*