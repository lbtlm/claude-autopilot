# CLAUDE.md - Java Maven项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Java Maven项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Java Maven项目
- **技术栈**: $TECH_STACK  
- **CE版本**: $SCRIPT_VERSION
- **配置时间**: $TIMESTAMP

### **🎯 智能命令**

#### **核心开发流程**
```bash
# 一键式完整功能开发 / Smart Feature Development
/智能功能开发 <功能需求描述>
# OR /smart-feature-dev <feature description>

# 智能问题诊断和修复 / Smart Bug Fix
/智能Bug修复 <问题描述>
# OR /smart-bugfix <problem description>

# 基于最佳实践的智能重构 / Smart Code Refactor  
/智能代码重构 <重构目标>
# OR /smart-code-refactor <refactor target>
```

#### **辅助工具命令**
```bash
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
```

### **☕ Java Maven开发特色功能**

#### **Maven核心特性**
- **依赖管理**: 自动化依赖解析和传递性依赖管理
- **标准化构建**: 约定优于配置的项目结构和生命周期
- **插件生态**: 丰富的Maven插件支持各种构建任务
- **多模块支持**: 大型项目的模块化管理和聚合构建

#### **Java企业级特性**
- **Spring框架**: Spring Boot、Spring MVC、Spring Data集成
- **微服务架构**: Spring Cloud、Docker、Kubernetes支持
- **数据库集成**: JPA、Hibernate、MyBatis ORM框架
- **测试框架**: JUnit 5、Mockito、TestContainers集成测试

#### **现代Java开发**
- **Java 17+ LTS**: 现代Java语言特性和性能优化
- **响应式编程**: Spring WebFlux、Reactor响应式框架
- **云原生**: 微服务、容器化、服务网格
- **DevOps集成**: CI/CD、监控、日志聚合

#### **标准Java Maven项目结构支持**
```
java-maven项目/
├── src/
│   ├── main/
│   │   ├── java/                # Java源码
│   │   │   └── com/example/app/ # 包结构
│   │   │       ├── config/      # 配置类
│   │   │       ├── controller/  # 控制器
│   │   │       ├── service/     # 服务层
│   │   │       ├── repository/  # 数据访问层
│   │   │       ├── model/       # 数据模型
│   │   │       ├── dto/         # 数据传输对象
│   │   │       ├── exception/   # 异常处理
│   │   │       └── Application.java # 主类
│   │   └── resources/           # 资源文件
│   │       ├── application.yml  # 应用配置
│   │       ├── application-dev.yml # 开发环境配置
│   │       ├── application-prod.yml # 生产环境配置
│   │       ├── logback.xml      # 日志配置
│   │       └── static/          # 静态资源
│   └── test/
│       ├── java/                # 测试代码
│       │   └── com/example/app/ # 测试包结构
│       │       ├── controller/  # 控制器测试
│       │       ├── service/     # 服务测试
│       │       ├── repository/  # 仓库测试
│       │       └── integration/ # 集成测试
│       └── resources/           # 测试资源
│           ├── application-test.yml # 测试配置
│           └── test-data/       # 测试数据
├── target/                      # 构建输出
├── docs/                        # 项目文档
├── scripts/                     # 脚本文件
├── docker/                      # Docker配置
│   ├── Dockerfile              # 应用镜像
│   └── docker-compose.yml      # 服务编排
├── .mvn/                       # Maven Wrapper
├── mvnw                        # Maven Wrapper脚本 (Unix)
├── mvnw.cmd                    # Maven Wrapper脚本 (Windows)
├── pom.xml                     # Maven配置文件
├── .gitignore                  # Git忽略文件
└── README.md                   # 项目说明
```

#### **智能开发和构建**
```bash
# 编译项目
mvn compile

# 运行测试
mvn test

# 打包应用
mvn package

# 安装到本地仓库
mvn install

# 清理构建
mvn clean

# 完整构建流程
mvn clean install

# 运行Spring Boot应用
mvn spring-boot:run

# 生成项目报告
mvn site

# 依赖分析
mvn dependency:tree
mvn dependency:analyze

# 代码质量检查
mvn spotbugs:check
mvn checkstyle:check
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: Java企业级架构设计和业务逻辑分析
- **context7**: 动态获取Java生态最新文档和最佳实践
- **memory**: Java开发经验自动复用和设计模式库
- **puppeteer**: Java Web应用自动化测试和集成测试

#### **全局规则遵守**
- **Java代码规范**: 自动应用Oracle Java编码标准和最佳实践
- **Maven约定**: 标准目录结构、生命周期和插件使用
- **Spring规范**: Spring Boot自动配置和依赖注入最佳实践
- **企业级模式**: 分层架构、异常处理、事务管理

#### **Java Maven专项智能特性**
- **依赖管理**: 版本冲突解决和安全漏洞检测
- **分层架构**: Controller-Service-Repository模式实现
- **配置管理**: Spring Profiles和外部化配置
- **测试策略**: 单元测试、集成测试、端到端测试

### **📋 Java Maven开发建议**

#### **开始开发**
1. 描述应用需求，如："创建RESTful用户管理系统"
2. 系统会自动设计Spring Boot架构和Maven依赖
3. 生成符合Java最佳实践的企业级应用框架

#### **业务开发**
1. 说明业务需求，如："实现订单处理工作流"
2. 系统会设计完整的分层架构和数据模型
3. 自动处理事务管理、异常处理和数据验证

#### **微服务开发**
1. 描述服务需求，如："创建产品目录微服务"
2. 系统会设计Spring Cloud微服务架构
3. 确保服务发现、配置管理和熔断保护

### **🔧 开发工具集成**

#### **开发环境**
- **Java 17+ LTS**: 现代Java运行时环境
- **Maven 3.8+**: 构建和依赖管理工具
- **Spring Boot**: 快速应用开发框架
- **IDE支持**: IntelliJ IDEA、Eclipse、VSCode

#### **代码质量**
- **Checkstyle**: Java代码风格检查
- **SpotBugs**: 静态代码分析和Bug检测
- **JaCoCo**: 代码覆盖率分析
- **SonarQube**: 代码质量和安全分析

#### **测试框架**
- **JUnit 5**: 现代Java测试框架
- **Mockito**: Mock对象和测试替身
- **TestContainers**: 集成测试的容器化
- **Spring Boot Test**: Spring应用测试支持

#### **构建和部署**
- **Maven Surefire**: 单元测试执行
- **Maven Failsafe**: 集成测试执行
- **Spring Boot Maven Plugin**: Spring Boot应用打包
- **Docker Maven Plugin**: 容器化构建

### **📈 效率提升**

相比传统Java开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: Spring Boot配置和分层架构自动生成，提升3-4倍效率
- 🎯 **架构质量**: 基于Spring最佳实践的企业级架构设计
- 🔄 **代码复用**: 智能识别可复用的服务组件和工具类
- 📊 **性能优化**: JVM调优、数据库优化、缓存策略
- 🧪 **测试覆盖**: 自动生成完整的测试套件和Mock对象

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **Maven问题**
```bash
# 检查Maven安装
mvn --version

# 清理Maven缓存
mvn dependency:purge-local-repository

# 重新下载依赖
mvn clean install -U

# 检查依赖树
mvn dependency:tree

# 分析依赖冲突
mvn dependency:analyze
mvn dependency:analyze-duplicate

# 检查Maven设置
mvn help:effective-settings
mvn help:effective-pom
```

#### **编译问题**
```bash
# 清理并重新编译
mvn clean compile

# 检查Java版本
java --version
mvn help:system

# 设置Java版本
export JAVA_HOME=/path/to/java17
mvn compile -Dmaven.compiler.source=17 -Dmaven.compiler.target=17

# 跳过测试编译
mvn compile -DskipTests

# 详细编译输出
mvn compile -X
```

#### **测试问题**
```bash
# 运行单个测试
mvn test -Dtest=UserServiceTest

# 跳过测试
mvn package -DskipTests

# 运行集成测试
mvn verify

# 测试调试
mvn test -Dmaven.surefire.debug

# 查看测试报告
open target/site/jacoco/index.html
open target/surefire-reports/index.html
```

#### **Spring Boot问题**
```bash
# 检查Spring Boot版本
mvn dependency:tree | grep spring-boot

# 查看自动配置
mvn spring-boot:run -Ddebug

# 检查应用属性
mvn spring-boot:run -Dspring.config.location=classpath:application-dev.yml

# 生成应用信息
mvn spring-boot:build-info

# 健康检查
curl http://localhost:8080/actuator/health
curl http://localhost:8080/actuator/info
```

#### **依赖问题**
```bash
# 更新所有依赖
mvn versions:display-dependency-updates

# 更新插件
mvn versions:display-plugin-updates

# 检查安全漏洞
mvn org.owasp:dependency-check-maven:check

# 排除传递依赖
# 在pom.xml中使用<exclusions>

# 强制依赖版本
mvn install -Dspring-boot.version=2.7.0
```

#### **性能问题**
```bash
# JVM性能调优
export MAVEN_OPTS="-Xmx2G -XX:+UseG1GC"

# 并行构建
mvn clean install -T 4

# 离线模式
mvn clean install -o

# 跳过不必要的阶段
mvn package -DskipTests -Dcheckstyle.skip -Dspotbugs.skip

# 构建性能分析
mvn clean install -Dtime
```

---

## 🚀 **开始Java Maven智能开发之旅**

智能Claude Autopilot 2.1专为Java Maven开发优化！

**直接描述您的Java应用需求**，系统会自动选择最适合的开发模式：

- 企业应用 → 基于Spring Boot的微服务架构
- Web应用 → Spring MVC + Thymeleaf全栈开发
- API服务 → RESTful API和GraphQL服务开发
- 批处理 → Spring Batch大数据处理应用

**享受Java生态的强大企业级开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Java Maven项目优化*