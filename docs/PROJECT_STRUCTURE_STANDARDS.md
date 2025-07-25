# 项目结构标准化规范

## 📋 **概述**

本文档定义了所有项目类型的标准化目录结构，结合全局统一管理规则和各技术栈的最佳实践。

## 🏗️ **全局统一结构**

所有项目必须包含以下统一结构：

```
project-name/
├── CLAUDE.md                    # Claude Code 操作指南
├── .vscode/                     # VSCode 统一配置
│   ├── settings.json           # 编辑器设置
│   ├── extensions.json         # 推荐扩展
│   └── tasks.json              # 任务配置
├── .editorconfig               # 编辑器规范
├── .gitignore                  # Git 忽略规则
├── Makefile                    # 统一构建命令
├── README.md                   # 项目说明
├── project_docs/               # 项目文档
│   ├── API.md                  # API接口文档
│   ├── DATABASE.md             # 数据库设计文档
│   ├── ARCHITECTURE.md         # 系统架构文档
│   ├── DEPLOYMENT.md           # 部署说明文档
│   └── TROUBLESHOOTING.md      # 故障排查文档
└── project_process/            # 开发过程记录
    ├── daily/                  # 每日记录
    ├── summary.md              # 项目状态摘要
    └── decisions.md            # 重要决策记录
```

## 🎯 **各技术栈标准结构**

### **Gin微服务项目 (gin-microservice)**

```
gin-microservice/
├── [全局统一结构]
├── cmd/
│   └── server/
│       └── main.go             # 服务入口
├── internal/
│   ├── handler/                # HTTP处理器
│   ├── service/                # 业务逻辑层
│   ├── repository/             # 数据访问层
│   ├── middleware/             # 自定义中间件
│   └── config/                 # 配置管理
├── pkg/
│   ├── logger/                 # 日志组件
│   ├── database/               # 数据库连接
│   ├── redis/                  # Redis客户端
│   └── utils/                  # 工具函数
├── api/
│   └── proto/                  # Protocol Buffers定义
├── migrations/                 # 数据库迁移
├── deployments/                # 部署配置
│   ├── docker/                 # Docker配置
│   └── k8s/                    # Kubernetes配置
├── scripts/                    # 构建和部署脚本
├── docker-compose.yml          # 本地开发环境
├── Dockerfile                  # 容器化配置
└── go.mod                      # Go模块文件
```

### **Gin + Vue3全栈项目 (gin-vue3)**

```
gin-vue3/
├── [全局统一结构]
├── backend/                    # Go后端
│   ├── cmd/
│   ├── internal/
│   ├── pkg/
│   ├── api/
│   ├── migrations/
│   └── go.mod
├── frontend/                   # Vue3前端
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── views/
│   │   ├── router/
│   │   ├── stores/
│   │   ├── assets/
│   │   ├── utils/
│   │   └── main.ts
│   ├── package.json
│   ├── vite.config.ts
│   └── tsconfig.json
├── deployments/
│   ├── docker/
│   └── k8s/
├── docker-compose.yml
└── Dockerfile
```

### **Go桌面应用项目 (go-desktop)**

```
go-desktop/
├── [全局统一结构]
├── cmd/
│   └── app/
│       └── main.go             # 应用程序入口
├── internal/
│   ├── ui/
│   │   ├── windows/            # 窗口组件
│   │   ├── widgets/            # 自定义组件
│   │   └── themes/             # 主题定义
│   ├── logic/                  # 业务逻辑
│   ├── storage/                # 数据存储
│   └── config/                 # 配置管理
├── pkg/
│   ├── utils/                  # 工具函数
│   └── models/                 # 数据模型
├── assets/
│   ├── icons/                  # 图标资源
│   ├── images/                 # 图片资源
│   └── fonts/                  # 字体文件
├── build/
│   ├── windows/                # Windows构建脚本
│   ├── macos/                  # macOS构建脚本
│   └── linux/                  # Linux构建脚本
├── configs/                    # 配置文件模板
├── fyne-bundle.json           # Fyne资源配置
└── go.mod
```

### **Go通用项目 (go-general)**

```
go-general/
├── [全局统一结构]
├── cmd/
│   └── main.go                 # 程序入口
├── internal/
│   ├── handler/                # 处理器
│   ├── service/                # 服务层
│   └── config/                 # 配置
├── pkg/
│   ├── utils/                  # 工具函数
│   └── models/                 # 数据模型
├── tests/                      # 测试文件
├── scripts/                    # 脚本文件
├── configs/                    # 配置文件
└── go.mod
```

### **Vue3前端项目 (vue3-frontend)**

```
vue3-frontend/
├── [全局统一结构]
├── public/
│   ├── index.html              # HTML模板
│   └── favicon.ico             # 网站图标
├── src/
│   ├── components/             # 通用组件
│   ├── views/                  # 页面组件
│   ├── router/                 # 路由配置
│   ├── stores/                 # Pinia状态管理
│   ├── assets/                 # 静态资源
│   ├── utils/                  # 工具函数
│   ├── api/                    # API接口
│   ├── composables/            # 组合式函数
│   ├── types/                  # TypeScript类型定义
│   └── main.ts                 # 应用入口
├── tests/
│   ├── unit/                   # 单元测试
│   └── e2e/                    # 端到端测试
├── dist/                       # 构建输出
├── node_modules/              # 依赖包
├── package.json               # 项目配置
├── vite.config.ts             # Vite配置
├── tsconfig.json              # TypeScript配置
└── vitest.config.ts           # 测试配置
```

### **Vue2前端项目 (vue2-frontend)**

```
vue2-frontend/
├── [全局统一结构]
├── public/
│   ├── index.html
│   └── favicon.ico
├── src/
│   ├── components/             # 通用组件
│   ├── views/                  # 页面组件
│   ├── router/                 # Vue Router配置
│   ├── store/                  # Vuex状态管理
│   ├── assets/                 # 静态资源
│   ├── utils/                  # 工具函数
│   ├── api/                    # API接口
│   ├── mixins/                 # 混入
│   └── main.js                 # 应用入口
├── tests/
│   ├── unit/
│   └── e2e/
├── dist/
├── node_modules/
├── package.json
├── vue.config.js              # Vue CLI配置
├── babel.config.js            # Babel配置
└── .eslintrc.js               # ESLint配置
```

### **React前端项目 (react-frontend)**

```
react-frontend/
├── [全局统一结构]
├── public/
│   ├── index.html
│   └── favicon.ico
├── src/
│   ├── components/             # 通用组件
│   ├── pages/                  # 页面组件
│   ├── hooks/                  # 自定义Hook
│   ├── context/                # React Context
│   ├── services/               # API服务
│   ├── utils/                  # 工具函数
│   ├── types/                  # TypeScript类型
│   ├── styles/                 # 样式文件
│   └── index.tsx               # 应用入口
├── tests/
├── build/                      # 构建输出
├── node_modules/
├── package.json
├── tsconfig.json
└── craco.config.js            # CRACO配置（如使用）
```

### **Next.js前端项目 (nextjs-frontend)**

```
nextjs-frontend/
├── [全局统一结构]
├── pages/                      # 页面路由（App Router或Pages Router）
│   ├── api/                    # API路由
│   └── _app.tsx               # 应用入口
├── app/                        # App Router目录（Next.js 13+）
│   ├── layout.tsx             # 根布局
│   └── page.tsx               # 首页
├── components/                 # 组件
├── lib/                        # 工具库
├── hooks/                      # 自定义Hook
├── types/                      # TypeScript类型
├── styles/                     # 样式文件
├── public/                     # 静态资源
├── .next/                      # 构建输出
├── node_modules/
├── package.json
├── next.config.js             # Next.js配置
└── tsconfig.json
```

### **Node.js通用项目 (nodejs-general)**

```
nodejs-general/
├── [全局统一结构]
├── src/
│   ├── controllers/            # 控制器
│   ├── services/               # 服务层
│   ├── models/                 # 数据模型
│   ├── middleware/             # 中间件
│   ├── routes/                 # 路由
│   ├── utils/                  # 工具函数
│   ├── config/                 # 配置
│   └── app.js                  # 应用入口
├── tests/
├── scripts/                    # 脚本文件
├── docs/                       # 文档
├── node_modules/
├── package.json
├── .eslintrc.js
└── .prettierrc
```

### **Python Web项目 (python-web)**

```
python-web/
├── [全局统一结构]
├── app/
│   ├── api/                    # API路由
│   ├── core/                   # 核心配置
│   ├── models/                 # 数据模型
│   ├── schemas/                # Pydantic模式
│   ├── services/               # 业务逻辑
│   ├── utils/                  # 工具函数
│   └── main.py                 # 应用入口
├── tests/
├── alembic/                    # 数据库迁移（如使用Alembic）
├── scripts/                    # 脚本文件
├── requirements.txt            # 依赖包
├── pyproject.toml             # 项目配置
├── Dockerfile
└── docker-compose.yml
```

### **Python桌面应用项目 (python-desktop)**

```
python-desktop/
├── [全局统一结构]
├── src/
│   ├── ui/                     # 用户界面
│   ├── core/                   # 核心逻辑
│   ├── utils/                  # 工具函数
│   ├── resources/              # 资源文件
│   └── main.py                 # 应用入口
├── tests/
├── assets/                     # 静态资源
├── build/                      # 构建输出
├── dist/                       # 分发包
├── requirements.txt
├── setup.py                    # 安装脚本
└── pyproject.toml
```

### **Python通用项目 (python-general)**

```
python-general/
├── [全局统一结构]
├── src/
│   ├── core/                   # 核心模块
│   ├── utils/                  # 工具函数
│   └── main.py                 # 主程序
├── tests/
├── scripts/                    # 脚本文件
├── requirements.txt
├── pyproject.toml
└── setup.py
```

### **Bash脚本项目 (bash-scripts)**

```
bash-scripts/
├── [全局统一结构]
├── bin/                        # 可执行脚本
├── lib/                        # 库函数和公共模块
│   └── utils/                  # 工具函数
├── config/                     # 配置文件和模板
├── tests/                      # 测试脚本
├── examples/                   # 示例脚本
├── scripts/                    # 辅助脚本
│   ├── install.sh             # 安装脚本
│   ├── setup.sh               # 环境设置
│   └── deploy.sh              # 部署脚本
├── .shellcheckrc              # ShellCheck配置
└── VERSION                    # 版本信息
```

### **Java Maven项目 (java-maven)**

```
java-maven/
├── [全局统一结构]
├── src/
│   ├── main/
│   │   ├── java/              # Java源码
│   │   └── resources/         # 资源文件
│   └── test/
│       ├── java/              # 测试代码
│       └── resources/         # 测试资源
├── target/                     # 构建输出
├── docs/                       # 文档
├── scripts/                    # 脚本文件
├── pom.xml                     # Maven配置
└── .mvn/                       # Maven包装器
```

### **Java Gradle项目 (java-gradle)**

```
java-gradle/
├── [全局统一结构]
├── src/
│   ├── main/
│   │   ├── java/
│   │   └── resources/
│   └── test/
│       ├── java/
│       └── resources/
├── build/                      # 构建输出
├── gradle/                     # Gradle包装器
├── docs/
├── scripts/
├── build.gradle               # Gradle构建脚本
├── settings.gradle            # Gradle设置
└── gradlew                    # Gradle包装器脚本
```

### **Rust项目 (rust-project)**

```
rust-project/
├── [全局统一结构]
├── src/
│   ├── bin/                   # 二进制目标
│   ├── lib.rs                 # 库入口
│   └── main.rs                # 主程序入口
├── tests/                     # 集成测试
├── examples/                  # 示例代码
├── benches/                   # 基准测试
├── target/                    # 构建输出
├── Cargo.toml                 # Cargo配置
└── Cargo.lock                 # 锁定文件
```

### **PHP项目 (php-project)**

```
php-project/
├── [全局统一结构]
├── src/                       # 源代码
├── tests/                     # 测试文件
├── vendor/                    # Composer依赖
├── public/                    # 公共文件
│   └── index.php             # 入口文件
├── config/                    # 配置文件
├── storage/                   # 存储目录
├── bootstrap/                 # 启动文件
├── composer.json              # Composer配置
└── composer.lock              # 锁定文件
```

## 📝 **配置文件标准**

### **.editorconfig**
```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.{go,java,rs}]
indent_size = 4

[*.{py}]
indent_size = 4

[*.md]
trim_trailing_whitespace = false
```

### **.gitignore 基础模板**
```
# 系统文件
.DS_Store
Thumbs.db

# IDE 文件
.vscode/settings.json
.idea/
*.swp
*.swo

# 临时文件
*.log
*.tmp
.env
.env.local

# 构建输出
dist/
build/
target/
*.exe
*.dll
*.so
*.dylib

# 依赖包
node_modules/
vendor/
__pycache__/
*.pyc
```

### **Makefile 基础模板**
```makefile
# 项目基本信息
PROJECT_NAME := $(shell basename $(PWD))
VERSION := $(shell cat VERSION 2>/dev/null || echo "1.0.0")

# 默认目标
.PHONY: all
all: lint test build

# 代码质量检查
.PHONY: lint
lint:
	@echo "🔍 运行代码检查..."
	# 根据项目类型添加相应的lint命令

# 运行测试
.PHONY: test
test:
	@echo "🧪 运行测试..."
	# 根据项目类型添加相应的test命令

# 构建项目
.PHONY: build
build:
	@echo "🔨 构建项目..."
	# 根据项目类型添加相应的build命令

# 清理
.PHONY: clean
clean:
	@echo "🧹 清理构建文件..."
	# 根据项目类型添加相应的clean命令

# 帮助信息
.PHONY: help
help:
	@echo "📖 $(PROJECT_NAME) v$(VERSION)"
	@echo ""
	@echo "可用命令:"
	@echo "  all      - 运行 lint, test, build"
	@echo "  lint     - 代码质量检查"
	@echo "  test     - 运行测试"
	@echo "  build    - 构建项目"
	@echo "  clean    - 清理构建文件"
	@echo "  help     - 显示帮助信息"
```

## 🔧 **遵循原则**

1. **一致性**: 所有项目必须遵循全局统一结构
2. **技术栈特异性**: 在统一结构基础上添加技术栈特定目录
3. **可扩展性**: 结构设计考虑项目增长和复杂度提升
4. **工具友好**: 与现代开发工具和CI/CD流水线良好集成
5. **文档完整**: 每个项目都有完整的文档和过程记录

## ✅ **验证清单**

- [ ] 包含所有全局统一文件和目录
- [ ] 技术栈特定结构符合最佳实践
- [ ] .gitignore 文件配置正确
- [ ] Makefile 包含标准命令
- [ ] 文档结构完整
- [ ] 开发过程记录目录存在

这个标准化结构确保了项目的一致性、可维护性和团队协作效率。