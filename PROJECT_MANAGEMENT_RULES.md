# 项目统一管理规则

## 📋 **规则体系概述**

基于 Claude Code 主导的七维度项目管理体系，为多个项目建立统一的管理标准。

**核心目标：**
- 🧠 降低认知负荷 - 统一标准减少决策疲劳
- 🤖 AI 主导开发 - Claude Code + VSCode + Copilot 三件套
- 🔄 跨平台一致 - Windows(公司) + macOS(家) 无缝切换
- 📚 知识积累复用 - Memory MCP 实现项目间智慧共享

---

## 🔴 **全局强制规则（不可违反）**

### **版本控制强制规则**
- ✅ 每个项目必须使用 Git 版本控制
- ✅ 提交信息必须使用 Conventional Commits 格式
- ✅ 禁止提交到 main/master 分支（除非是个人项目）
- ✅ 每个项目必须有 .gitignore 文件
- ✅ 项目提交必须移出 claude code 签名,替换为 Youmi Sam 签名


### **项目结构强制规则**
- ✅ 每个项目必须包含 CLAUDE.md 文件
- ✅ 每个项目必须包含 project_process 目录
- ✅ 每个项目必须包含 .editorconfig 文件
- ✅ 每个项目必须有明确的目录结构和命名规范

### **安全强制规则**
- ✅ 所有敏感信息必须使用环境变量
- ✅ 每个项目必须有 .env.example 文件
- ✅ 生产环境密钥禁止出现在代码中
- ✅ 每个项目必须定期更新依赖
- ✅ 生产部署前必须通过安全检查

---

## ❌ **全局禁止规则（绝对不能做）**

### **安全禁令**
- 🚫 禁止硬编码 API 密钥、数据库密码、JWT Secret
- 🚫 禁止提交 .env 文件到版本控制
- 🚫 禁止在日志中记录敏感信息
- 🚫 禁止使用弱密码或默认密码
- 🚫 禁止在生产环境开启调试模式
- 🚫 禁止跳过 SQL 参数化查询（防 SQL 注入）

### **代码质量禁令**
- 🚫 禁止提交未格式化的代码
- 🚫 禁止提交有 lint 错误的代码
- 🚫 禁止提交明显的 TODO/FIXME 到主分支
- 🚫 禁止直接修改第三方库源码
- 🚫 禁止使用已废弃的 API 或库
- 🚫 禁止复制粘贴超过 20 行重复代码

### **版本控制禁令**
- 🚫 禁止强制推送到共享分支（git push -f）
- 🚫 禁止提交大文件（>10MB）到 Git
- 🚫 禁止提交 node_modules、dist、build 等目录
- 🚫 禁止无意义的提交信息（如"fix"、"update"）
- 🚫 禁止合并未经测试的代码
- 🚫 禁止删除他人的代码而不留备注

### **部署禁令**
- 🚫 禁止直接在生产环境修改代码
- 🚫 禁止无备份直接更新生产数据库
- 🚫 禁止在工作时间进行高风险部署
- 🚫 禁止跳过部署前检查清单
- 🚫 禁止使用开发环境配置部署生产
- 🚫 禁止生产环境使用 debug 或 test 数据

### **项目管理禁令**
- 🚫 禁止创建项目时不建立 CLAUDE.md
- 🚫 禁止开发时不记录 project_process
- 🚫 禁止重大技术决策时不记录原因
- 🚫 禁止抛弃项目时不做归档整理
- 🚫 禁止重复造轮子而不检查现有解决方案
- 🚫 禁止独立开发时不考虑后续维护性

---

## 🤖 **Claude Code 智能工作流程标准**

### **智能项目启动流程**
1. **执行命令**: `claude code`
2. **自动读取**: CLAUDE.md → 了解项目背景
3. **智能分析**: 使用 sequential-thinking 分析项目状态和任务复杂度
4. **记忆回调**: memory.recall_memory_abstract() → 获取相关历史经验
5. **文档查询**: context7 获取相关技术栈最新文档（如需要）
6. **状态报告**: 综合分析生成项目状态和建议任务
7. **任务确认**: 与用户确定本次开发任务

### **增强的开发过程记录标准**
**开发前:**
- **任务分解**: sequential-thinking 进行复杂任务分解和风险分析
- **技术调研**: context7 获取相关技术文档和最佳实践
- **经验搜索**: memory 搜索相似问题的历史解决方案

**开发中:**
- **代码理解**: filesystem 智能代码搜索和模式匹配
- **实时记录**: 每次操作自动更新 project_process
- **错误处理**: 优先搜索 memory 中的解决方案
- **决策记录**: 重要技术决策记录到 decisions.md

**开发后:**
- **功能验证**: puppeteer 自动化测试和截图验证（Web项目）
- **质量检查**: make lint + make test
- **经验保存**: memory 保存关键经验和解决方案



### **智能代码质量检查流程**
1. **预检查**: filesystem 搜索潜在问题代码模式
2. **自动检查**: `make lint` + `make test`
3. **结果分析**: sequential-thinking 分析失败原因
4. **解决方案**: 结合 memory 和 context7 的最佳实践
5. **修复验证**: puppeteer 回归测试（Web项目）
6. **提交生成**: 自动生成规范的提交信息
7. **记录更新**: 更新开发记录和项目状态

### **智能项目总结流程**
1. **成果分析**: sequential-thinking 分析开发成果和经验
2. **当日总结**: 生成开发总结保存到 daily/
3. **关键经验**: memory.save_memory() 保存技术决策和解决方案
4. **文档更新**: 更新 summary.md 项目状态
5. **改进建议**: 基于分析生成下次开发优化建议
6. **提交推送**: 提交推送到GitHub,符合标准

---

## 💾 **智能 MCP 工具使用规范**

### **Sequential-thinking 使用规范**
**适用场景:**
- 复杂架构设计决策
- 多步骤任务分解
- 技术方案对比分析
- 问题根因分析
- 风险评估和预案制定

**使用标准:**
```bash
# 复杂任务分析
sequential-thinking.analyze({
  problem: "具体问题描述",
  context: "项目背景和约束条件",
  expected_outcome: "期望的分析结果"
})
```

**记录要求:**
- 分析结果必须保存到 decisions.md
- 重要决策过程保存到 memory
- 复杂方案对比记录完整思考链

### **Context7 使用规范**
**项目启动时:**
```bash
# 获取主要技术栈文档
context7.resolve-library-id("项目主要框架")
context7.get-library-docs(libraryID, tokens=15000)
```

**遇到技术问题时:**
```bash
# 针对性获取解决方案
context7.get-library-docs(libraryID, topic="具体问题", tokens=10000)
```

**最佳实践:**
- 优先查询项目已使用的技术栈
- 获取的文档要与 memory 中的经验结合
- 新学到的重要信息保存到 memory
- 定期更新技术栈的最新最佳实践

### **Memory 增强使用规范**
**分类保存系统:**
```bash
# 按项目类型分类保存
memory.save_memory(
  speaker="developer",
  message="经验描述",
  context="项目类型_技术栈" # 如: "web_golang", "mobile_flutter"
)
```

**智能检索:**
```bash
# 获取相关经验
memory.recall_memory_abstract(
  context="相关项目类型",
  force_refresh=true # 获取最新经验
)
```

**知识体系分类:**
- **技术解决方案**: context="tech_solutions"
- **架构设计模式**: context="architecture_patterns" 
- **项目管理经验**: context="project_management"
- **工具使用技巧**: context="tool_tips"
- **错误处理方案**: context="error_solutions"

### **Puppeteer 使用规范**
**Web项目必用场景:**
- 新功能开发完成后的视觉验证
- API接口的前端展示测试
- 响应式设计的多尺寸截图
- 用户交互流程的自动化测试
- 回归测试的自动化执行

**使用标准:**
```bash
# 基础操作
puppeteer.navigate("http://localhost:8080")
puppeteer.screenshot(name="feature_test", width=1200, height=800)
puppeteer.click("button.submit")
puppeteer.fill("input[name='username']", "test_user")

# 交互测试
puppeteer.hover(".menu-item")
puppeteer.select("select[name='category']", "option-value")
puppeteer.evaluate("document.querySelector('.result').textContent")
```

**截图管理:**
- 截图保存到 project_process/screenshots/
- 重要界面变化对比记录
- 不同屏幕尺寸的响应式测试截图

### **Filesystem 工具使用规范**
**代码搜索优先级:**
1. **精确搜索**: Grep 查找具体函数或类
2. **模式搜索**: Glob 查找文件类型和路径
3. **广泛搜索**: Task 进行复杂的多轮搜索

**使用场景:**
- **理解项目架构**: 搜索配置文件和入口文件
- **查找相似实现**: 搜索类似功能的代码
- **检查依赖关系**: 搜索 import 和 require
- **代码质量检查**: 搜索 TODO、FIXME、console.log
- **安全检查**: 搜索硬编码密钥、SQL注入风险

---

## 📁 **标准项目结构**

### **通用基础结构**
```
project-name/
├── CLAUDE.md              # Claude Code 操作指南
├── .vscode/              # VSCode 统一配置
├── .editorconfig         # 编辑器规范
├── .gitignore           # Git 忽略规则
├── Makefile             # 统一构建命令
├── project_docs/         # 项目文档
└── project_process/      # 开发过程记录
    ├── daily/           # 每日记录
    ├── summary.md       # 项目状态摘要
    └── decisions.md     # 重要决策记录
```

### **按项目类型扩展**
详见 `project_types/` 目录中的具体规范。
严格遵守 `project_types/` 目录中的具体规范。

---

## 🌐 **API 设计规范（最高优先级）**

### **统一路径规则**
基于 gin_middleware_oss 项目的成功实践，所有项目必须遵循以下路径规范：

```
/health                     # 健康检查接口
/ping                      # 心跳检查接口
/swagger/*any              # Swagger API文档
/api/{service}/{action}    # 业务API路径

示例：
GET    /api/user/list              # 获取用户列表
POST   /api/user/create            # 创建用户
GET    /api/user/detail/:id        # 获取用户详情
PUT    /api/user/update/:id        # 更新用户
DELETE /api/user/delete/:id        # 删除用户
POST   /api/oss/upload             # 文件上传
GET    /api/oss/download/*path     # 文件下载（支持多级路径）
```

### **统一响应格式**
所有API响应必须使用以下标准JSON格式：

```json
{
    "code": 200,           // HTTP状态码
    "message": "操作成功",  // 提示信息
    "data": {}            // 响应数据（可选）
}
```

**响应示例:**
```json
// 成功响应示例
{
    "code": 200,
    "message": "操作成功",
    "data": {
        "id": 123,
        "name": "张三"
    }
}

// 错误响应示例
{
    "code": 400,
    "message": "参数错误：用户名不能为空"
}

// 列表响应示例
{
    "code": 200,
    "message": "获取成功",
    "data": {
        "items": [...],
        "total": 100,
        "page": 1,
        "page_size": 20
    }
}
```

### **HTTP 状态码规范**
- **200**: 成功（GET、PUT）
- **201**: 创建成功（POST）
- **204**: 删除成功（DELETE）
- **400**: 请求参数错误
- **401**: 未认证/token失效
- **403**: 无权限访问
- **404**: 资源不存在
- **500**: 服务器内部错误

### **API 版本控制**
- 暂不强制要求版本控制

---

## 🗄️ **数据库管理规范**

### **命名规范**
```sql
-- 表名：小写 + 下划线 + 复数形式
users                      -- 用户表
user_orders               -- 用户订单表
product_categories        -- 产品分类表

-- 字段名：小写 + 下划线
user_name                 -- 用户名
created_at                -- 创建时间
is_active                 -- 是否激活

-- 索引名：idx_{表名}_{字段名}
idx_users_email           -- 用户邮箱索引
idx_users_created_at      -- 创建时间索引

-- 外键名：fk_{表名}_{关联表名}
fk_user_orders_users      -- 订单表关联用户表
```

### **必须字段**
每个数据表必须包含以下标准字段：

```sql
-- 通用字段（所有数据库适用）
id         PRIMARY KEY,                     -- 主键（类型根据数据库而定）
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 创建时间
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 更新时间  
deleted_at TIMESTAMP NULL,                  -- 软删除时间（可选）

-- 示例表结构
CREATE TABLE users (
    id         BIGINT PRIMARY KEY AUTO_INCREMENT,  -- MySQL/PostgreSQL
    -- id      SERIAL PRIMARY KEY,                 -- PostgreSQL 替代方案
    -- id      INTEGER PRIMARY KEY AUTOINCREMENT,  -- SQLite
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    -- 其他业务字段
    username   VARCHAR(50) NOT NULL,
    email      VARCHAR(100) UNIQUE
);
```

### **迁移管理**
- **文件命名**: `{序号}_{操作}_{表名}.sql`
  - 示例: `001_create_users.sql`, `002_add_email_to_users.sql`
- **迁移原则**:
  - ✅ 只允许前向迁移，禁止修改已执行的迁移文件
  - ✅ 每个迁移必须是幂等的（可重复执行）
  - ✅ 迁移文件必须包含回滚语句（注释形式）
- **存放位置**: `migrations/` 或 `database/migrations/`

### **备份策略**
- **开发环境**: 每日自动备份
- **生产环境**: 
  - 每日全量备份
  - 保留最近30天备份

---

## 📝 **统一日志规范**

### **日志架构**
采用双日志器架构，分离HTTP请求日志和业务日志：

```
项目根目录/
└── Logs/
    ├── http.log    # HTTP请求日志
    └── app.log     # 应用业务日志
```

### **日志级别使用**
- **ERROR**: 需要立即处理的错误（数据库连接失败、关键服务不可用）
- **WARN**: 潜在问题，需要关注（请求频率过高、内存使用率高）
- **INFO**: 重要业务流程（用户登录、订单创建、支付完成）
- **DEBUG**: 开发调试信息（仅在开发环境启用）

### **日志格式标准**
使用结构化日志格式（JSON格式，支持各种日志库）：

```json
// HTTP访问日志格式
{
    "timestamp": "2024-01-20T15:04:05Z",
    "level": "INFO",
    "type": "access",
    "method": "POST",
    "path": "/api/user/login",
    "status": 200,
    "latency": "125ms",
    "client_ip": "192.168.1.100",
    "user_agent": "Mozilla/5.0...",
    "request_id": "req-uuid-123"
}

// 业务日志格式
{
    "timestamp": "2024-01-20T15:04:05Z",
    "level": "INFO",
    "type": "business",
    "service": "user-service",
    "action": "login",
    "user_id": "123",
    "message": "用户登录成功",
    "request_id": "req-uuid-123",
    "details": {
        "ip": "192.168.1.100",
        "device": "mobile"
    }
}
```

**不同语言的日志库推荐：**
- **Node.js**: winston, pino
- **Python**: structlog, loguru
- **Java**: logback, slf4j + jackson
- **Go**: logrus, zap
- **PHP**: monolog
- **C#**: Serilog, NLog

### **日志中间件集成**
**各框架的日志中间件配置示例：**

```javascript
// Node.js + Express
app.use(morgan('combined'));                    // HTTP日志
app.use(errorHandler);                          // 异常处理
app.use(cors());                               // CORS处理

// Python + FastAPI
app.add_middleware(LoggingMiddleware)          // HTTP日志
app.add_middleware(ExceptionMiddleware)        // 异常处理
app.add_middleware(CORSMiddleware)            // CORS处理

// Go + Gin
router.Use(middleware.LoggerMiddleware())      // HTTP日志
router.Use(gin.Recovery())                     // 异常恢复
router.Use(middleware.CORSMiddleware())        // CORS处理

// Java + Spring Boot
// 通过 application.yml 配置日志
// 使用 @ControllerAdvice 处理异常
// 使用 @CrossOrigin 或 WebMvcConfigurer 配置CORS
```

---

## 📚 **项目文档规范**

### **文档目录结构**
所有项目文档必须放在 `project_docs/` 目录下：

```
project_docs/
├── API.md              # API接口文档
├── DATABASE.md         # 数据库设计文档
├── ARCHITECTURE.md     # 系统架构文档
├── DEPLOYMENT.md       # 部署说明文档
├── TROUBLESHOOTING.md  # 故障排查文档
├── CHANGELOG.md        # 版本更新日志
└── images/            # 文档图片资源
```

### **在线swagger文档**
所有微服务,fastapi,gin 等web框架必须生成在线swagger 文档,方便调试!

### **必须文档及内容要求**

#### **API.md - API接口文档**
- 接口概览（按模块分组）
- 每个接口包含：
  - 请求方法和路径
  - 请求参数说明
  - 响应示例（成功/失败）
  - 错误码列表
- 认证方式说明
- 通用规范说明

#### **DATABASE.md - 数据库设计文档**
- 数据库基本信息（类型、版本）
- 表结构设计（包含字段说明）
- 索引设计说明
- 表关系图（ER图）
- 数据字典

#### **ARCHITECTURE.md - 系统架构文档**
- 系统架构图
- 技术栈说明
- 核心模块介绍
- 数据流程图

### **文档维护规则**
- ✅ 功能变更时同步更新文档
- ✅ 每个版本发布前检查文档完整性
- ✅ 使用 Markdown 格式，支持 Mermaid 图表
- ✅ 重要变更在 CHANGELOG.md 中记录

---

## ❌ **错误处理规范**

### **统一错误响应**
使用统一的响应处理方式（根据项目语言选择合适的实现）：

**响应处理模式:**
```javascript
// 成功响应
response.success("操作成功")
response.successWithData(data)

// 错误响应  
response.badRequest("参数错误：用户名不能为空")
response.unauthorized("请先登录")
response.forbidden("无权限访问该资源")
response.notFound("用户不存在")
response.internalError("服务器繁忙，请稍后重试")
```

**各语言实现参考:**
- **Node.js**: 创建 ResponseHelper 类或使用 express-response-helper
- **Python**: 创建 response_utils.py 或使用 FastAPI Response 模型
- **Java**: 创建 ResponseUtil 类或使用 Spring ResponseEntity
- **Go**: 创建 utils 包中的统一响应函数
- **PHP**: 创建 ResponseHelper 类或使用 Laravel Response

### **业务错误码设计**
当需要更细粒度的错误区分时，可以使用业务错误码：

**错误码格式**: `模块(2位) + 错误类型(2位) + 具体错误(2位)`

```json
// 错误码定义示例
{
    "USER_MODULE": {
        "USER_NOT_FOUND": 100401,     // 用户不存在
        "USER_DISABLED": 100403,      // 用户已禁用  
        "PASSWORD_WRONG": 100402,     // 密码错误
        "EMAIL_EXISTS": 100409        // 邮箱已存在
    },
    "ORDER_MODULE": {
        "ORDER_NOT_FOUND": 200401,    // 订单不存在
        "ORDER_PAID": 200402,         // 订单已支付
        "ORDER_EXPIRED": 200403       // 订单已过期
    },
    "PAYMENT_MODULE": {
        "PAYMENT_FAILED": 300401,     // 支付失败
        "INSUFFICIENT_BALANCE": 300402 // 余额不足
    }
}
```

**各语言实现方式:**
- **JavaScript**: 使用 enum 对象或常量对象
- **Python**: 使用 Enum 类或常量字典
- **Java**: 使用 enum 或常量类
- **Go**: 使用 const 常量定义
- **PHP**: 使用类常量或配置数组

### **错误信息原则**
- ✅ 用户友好：避免技术术语，使用用户能理解的语言
- ✅ 可操作性：告诉用户如何解决问题
- ✅ 安全性：不暴露系统内部信息
- ❌ 避免：`"内部错误"`, `"操作失败"`
- ✅ 推荐：`"用户名或密码错误，请重新输入"`, `"该邮箱已被注册，请使用其他邮箱"`

### **错误日志记录**
记录错误时必须包含完整的上下文信息：

```json
// 错误日志格式
{
    "timestamp": "2024-01-20T15:04:05Z",
    "level": "ERROR", 
    "type": "business",
    "service": "order-service",
    "action": "create_order",
    "user_id": "12345",
    "request_id": "req-uuid-123",
    "error": {
        "message": "数据库连接失败",
        "code": "DB_CONNECTION_ERROR",
        "stack": "Error stack trace..."
    },
    "context": {
        "order_data": {...},
        "client_ip": "192.168.1.100"
    }
}
```

**各语言日志记录示例:**
```javascript
// Node.js
logger.error('创建订单失败', {
    user_id: userId,
    action: 'create_order', 
    error: err.message,
    trace_id: traceId
});

// Python
logger.error('创建订单失败', extra={
    'user_id': user_id,
    'action': 'create_order',
    'error': str(err),
    'trace_id': trace_id
});

// Go  
logger.WithFields(logrus.Fields{
    "user_id": userID,
    "action": "create_order",
    "error": err.Error(),
    "trace_id": traceID,
}).Error("创建订单失败")
```

---

## 🔄 **智能 MCP 工具协作模式**

### **复杂任务处理模式**
**适用场景**: 新功能开发、架构设计、技术选型

**协作流程:**
```
1. sequential-thinking → 任务分解和风险评估
   - 分析需求复杂度
   - 识别技术难点
   - 评估开发风险

2. context7 → 获取相关技术文档
   - 查询最新技术规范
   - 获取最佳实践指南
   - 学习成功案例

3. memory → 搜索历史经验
   - 查找相似项目经验
   - 获取经验教训
   - 复用成功方案

4. filesystem → 理解现有代码结构
   - 分析项目架构
   - 查找可复用组件
   - 理解现有模式

5. 开发实现 → 基于分析结果编码

6. puppeteer → 功能验证（Web项目）
   - 自动化功能测试
   - 界面截图对比
   - 用户流程验证

7. memory → 保存新经验和方案
```

### **问题解决模式**
**适用场景**: Bug修复、性能优化、错误排查

**协作流程:**
```
1. filesystem → 定位问题相关代码
   - 搜索错误信息
   - 定位相关文件
   - 分析代码逻辑

2. memory → 搜索相似问题解决方案
   - 查询历史Bug修复
   - 获取排查思路
   - 复用解决方案

3. context7 → 查找官方文档和最佳实践
   - 查询官方修复指南
   - 获取调试技巧
   - 学习预防措施

4. sequential-thinking → 分析多种解决方案
   - 对比解决方案优劣
   - 评估修复风险
   - 制定实施计划

5. 实施解决方案 → 修复问题

6. puppeteer → 回归测试验证（Web项目）

7. memory → 保存解决过程和预防经验
```

### **学习研究模式**
**适用场景**: 技术调研、新技术学习、方案评估

**协作流程:**
```
1. context7 → 获取最新技术文档
   - 学习新技术特性
   - 了解使用场景
   - 掌握配置方法

2. sequential-thinking → 分析技术适用性
   - 评估技术优势
   - 分析集成难度
   - 对比现有方案

3. filesystem → 搜索现有技术实现
   - 了解当前技术栈
   - 分析迁移成本
   - 查找集成点

4. memory → 记录学习成果
   - 保存关键知识点
   - 记录使用心得
   - 积累最佳实践

5. puppeteer → 实验验证（Web相关技术）
```

## 📋 **场景化智能工作流程模板**

### **新功能开发模板**
```
📋 启动阶段:
├── sequential-thinking: 分解功能需求和技术难点
├── memory: 搜索相似功能的实现经验
└── context7: 获取相关技术栈的设计模式文档

💻 设计阶段:
├── filesystem: 分析现有代码架构和可复用组件
├── sequential-thinking: 设计方案对比和技术选型
└── memory: 记录重要设计决策

🔨 编码阶段:
├── filesystem: 搜索现有相似实现参考
├── context7: 查询具体API使用方法
└── 实时记录开发过程到 project_process

🧪 测试阶段:
├── puppeteer: 自动化功能测试和截图对比
├── 质量检查: make lint + make test
└── filesystem: 搜索潜在的测试遗漏

📚 总结阶段:
├── memory: 保存开发经验和踩坑记录
├── sequential-thinking: 分析开发过程的改进点
└── 更新项目文档和决策记录
```

### **Bug修复模板**
```
🔍 问题定位:
├── filesystem: 搜索错误相关的代码和日志
├── sequential-thinking: 分析错误根因和影响范围
└── memory: 查找相似Bug的修复历史

📖 方案研究:
├── context7: 查询官方文档的错误处理指南
├── memory: 获取相关错误处理的最佳实践
└── sequential-thinking: 对比多种修复方案

🛠️ 修复实施:
├── 基于分析结果实施修复
├── filesystem: 搜索可能的相关影响代码
└── 记录修复过程到 decisions.md

✅ 验证确认:
├── puppeteer: 回归测试确保功能正常
├── 质量检查: 确保修复不引入新问题
└── memory: 保存修复方案和预防措施
```

### **代码重构模板**
```
📊 现状分析:
├── filesystem: 全面搜索需重构的代码模式
├── sequential-thinking: 分析重构的收益和风险
└── memory: 查找重构相关的历史经验

📐 方案设计:
├── context7: 获取重构最佳实践和设计模式
├── sequential-thinking: 制定渐进式重构计划
└── memory: 记录重构决策和设计思路

🔧 渐进重构:
├── filesystem: 搜索所有相关代码位置
├── 分模块执行重构，保持功能完整性
└── 每个阶段都进行测试验证

🧪 全面验证:
├── puppeteer: 完整的回归测试流程
├── 性能测试: 验证重构的性能改进
└── memory: 总结重构经验和注意事项
```

### **技术调研模板**
```
📚 文档研究:
├── context7: 获取技术官方文档和教程
├── sequential-thinking: 分析技术特性和适用场景
└── memory: 记录学习过程中的关键信息

🔬 实验验证:
├── filesystem: 了解现有技术栈的集成情况
├── 创建Demo项目验证技术可行性
└── puppeteer: 测试技术在实际场景中的表现

📋 方案对比:
├── sequential-thinking: 对比多种技术方案的优劣
├── memory: 查询团队对类似技术的使用经验
└── 制定技术选型建议和实施计划

💾 知识沉淀:
├── memory: 保存调研结果和技术评估
├── 更新技术选型文档
└── 为团队提供技术分享和培训材料
```

---
