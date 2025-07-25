# /清理残余文件 | /cleanup-project

## 🧹 智能项目清理命令

这是一个智能项目清理命令，能够自动识别和清理项目中的残余文件、临时文件和不符合规范的文件。

## 📋 功能特性

### 🔍 智能文件分析
- **自动识别**：根据项目类型自动识别可删除的文件
- **安全检查**：确保不会删除重要的项目文件
- **规则匹配**：基于全局规则库进行文件合规性检查
- **智能建议**：提供文件清理建议和优化方案

### 🗂️ 清理范围
- **临时文件**：`.tmp`, `.temp`, `~` 结尾的文件
- **编译产物**：`node_modules`, `dist`, `build`, `target` 等
- **IDE文件**：`.vscode` (非标准配置), `.idea` 等
- **日志文件**：`*.log`, `log/` 目录下的旧日志
- **缓存文件**：各种缓存和临时数据文件
- **不规范文件**：不符合项目命名规范的文件

### 🔒 安全机制
- **备份功能**：清理前自动创建备份
- **交互确认**：重要文件删除前需要用户确认
- **撤销功能**：支持恢复误删的文件
- **白名单保护**：重要文件自动加入保护名单

## 🚀 使用方法

### 基础清理
```
/清理残余文件
```
或
```
/cleanup-project
```

### 高级选项
```
/清理残余文件 --deep
/cleanup-project --deep
```
深度清理模式，包含更多文件类型

```
/清理残余文件 --dry-run
/cleanup-project --dry-run
```
预览模式，只显示将要清理的文件，不实际删除

```
/清理残余文件 --backup
/cleanup-project --backup
```
强制创建备份（默认已启用）

```
/清理残余文件 --auto
/cleanup-project --auto
```
自动模式，跳过交互式确认

## 🧠 智能识别规则

### 按项目类型清理

#### Go项目 (gin-microservice, go-general, go-desktop)
- **可删除**：`*.exe`, `*.dll`, `*.so`, `vendor/` (如果使用go modules)
- **编译产物**：`main`, `app`, `server` 等可执行文件
- **测试文件**：`coverage.out`, `*.test`

#### Node.js项目 (vue3-frontend, react-frontend, nodejs-general)
- **依赖目录**：`node_modules/`, `bower_components/`
- **编译产物**：`dist/`, `build/`, `.next/`, `.nuxt/`
- **缓存文件**：`.npm/`, `.yarn/`, `package-lock.json` (可选)

#### Python项目 (python-web, python-desktop, python-general)
- **缓存文件**：`__pycache__/`, `*.pyc`, `*.pyo`
- **虚拟环境**：`venv/`, `env/`, `.venv/`
- **编译产物**：`*.egg-info/`, `dist/`, `build/`

#### Java项目 (java-maven, java-gradle)
- **Maven**：`target/`, `.m2/repository/` (本地)
- **Gradle**：`build/`, `.gradle/`
- **编译产物**：`*.class`, `*.jar` (临时)

### 通用清理规则
- **临时文件**：`*.tmp`, `*.temp`, `*~`, `.DS_Store`
- **日志文件**：`*.log`, `logs/` 目录下超过7天的文件
- **备份文件**：`*.bak`, `*.backup`, `*.old`
- **IDE配置**：非标准的 `.vscode/`, `.idea/` 配置
- **Git临时**：`.git/hooks/` 中的临时文件

## 🔧 实现逻辑

### 工作流程
1. **项目分析**：识别项目类型和技术栈
2. **文件扫描**：根据规则扫描可清理的文件
3. **安全检查**：验证文件是否可以安全删除
4. **用户确认**：显示清理列表，等待用户确认
5. **备份创建**：为重要文件创建备份
6. **执行清理**：删除确认的文件
7. **结果报告**：显示清理结果和统计信息

### 工具调用链
```bash
# 1. 加载项目信息
source "$GLOBAL_CE_PATH/utils/project-detection.sh"

# 2. 执行文件清理
source "$GLOBAL_CE_PATH/utils/file-cleanup-engine.sh"

# 3. 生成清理报告
cleanup_project_files "$PROJECT_PATH" "$PROJECT_TYPE" "$@"
```

## 📊 输出示例

### 扫描结果
```
🧹 智能项目清理器 - 扫描结果
===============================================

📂 项目: my-gin-service (gin-microservice)
🔍 扫描路径: /home/user/projects/my-gin-service

📋 发现可清理文件:

🗂️ 临时文件 (5个文件, 2.3MB):
  ✓ server.tmp
  ✓ debug.log.temp  
  ✓ .DS_Store
  ✓ config.bak
  ✓ main.exe

📦 编译产物 (3个文件, 15.6MB):
  ✓ vendor/ (目录)
  ✓ coverage.out
  ✓ main.test

⚠️ 需要确认的文件 (2个):
  ? logs/application.log (7天前)
  ? .vscode/launch.json (非标准配置)

🔒 受保护文件 (已忽略):
  • go.mod, go.sum
  • .gitignore
  • CLAUDE.md
  • project_process/

💾 总计: 8个文件/目录, 预计释放 17.9MB 空间
```

### 清理确认
```
请确认清理操作:
[y] 清理所有建议的文件
[n] 取消清理
[s] 选择性清理
[d] 查看详细信息

您的选择: s

选择性清理模式:
1. [✓] 临时文件 (5个)
2. [✓] 编译产物 (3个)  
3. [ ] 需确认文件 (2个)

请选择要清理的类别 (1-3, 用空格分隔): 1 2
```

### 清理结果
```
🎉 清理完成！
===============================================

✅ 已删除文件: 8个
📁 已删除目录: 1个
💾 释放空间: 17.9MB
⏱️ 耗时: 0.2秒

📋 清理详情:
  • 临时文件: 5个已删除
  • 编译产物: 3个已删除
  • 跳过确认文件: 2个

🔄 备份位置: project_process/backups/cleanup-20240120-150430/
📝 详细日志: project_process/cleanup-report-20240120-150430.md

💡 建议: 
  - 考虑将 vendor/ 添加到 .gitignore
  - 配置自动清理脚本定期执行
```

## ⚙️ 配置选项

可以通过项目配置文件 `.claude/project.json` 自定义清理规则:

```json
{
  "cleanup_settings": {
    "auto_backup": true,
    "backup_retention_days": 30,
    "excluded_patterns": [
      "*.important",
      "keep_this_folder/"
    ],
    "custom_temp_patterns": [
      "*.custom_temp"
    ],
    "confirm_before_delete": [
      "*.config",
      "logs/"
    ]
  }
}
```

## 🔗 相关命令
- `/项目状态分析` - 分析项目健康度
- `/智能代码重构` - 代码结构优化
- `/提交github` - 清理后提交代码

## 📚 技术实现
- 基于 `file-cleanup-engine.sh` 核心引擎
- 支持可扩展的清理规则
- 集成项目健康度评估
- 自动生成清理报告和统计