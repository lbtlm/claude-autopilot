# CLAUDE.md - Java Gradle项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为Java Gradle项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: Java Gradle项目
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

### **🐘 Java Gradle开发特色功能**

#### **Gradle核心特性**
- **声明式构建**: Groovy/Kotlin DSL灵活的构建脚本
- **增量构建**: 智能缓存和增量编译提升构建效率
- **并行执行**: 多项目并行构建和任务执行优化
- **插件生态**: 丰富的官方和社区插件支持

#### **现代Java特性**
- **Java 17+ LTS**: 最新Java语言特性和性能优化
- **Spring Boot**: 快速应用开发和自动配置
- **Kotlin支持**: Java和Kotlin混合开发支持
- **模块化**: Java 9+模块系统集成

#### **企业级开发**
- **微服务架构**: Spring Cloud和服务网格支持
- **容器化**: Docker和Kubernetes集成
- **云原生**: GraalVM Native Image和Quarkus支持
- **DevOps**: CI/CD管道和自动化部署

#### **标准Java Gradle项目结构支持**
```
java-gradle项目/
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
│   │   │       └── Application.java # 主类
│   │   ├── kotlin/              # Kotlin源码（可选）
│   │   └── resources/           # 资源文件
│   │       ├── application.yml  # 应用配置
│   │       ├── application-dev.yml
│   │       ├── application-prod.yml
│   │       └── logback-spring.xml
│   └── test/
│       ├── java/                # 测试代码
│       ├── kotlin/              # Kotlin测试（可选）
│       └── resources/           # 测试资源
├── build/                       # 构建输出
├── gradle/                      # Gradle Wrapper
│   └── wrapper/
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── docs/                        # 项目文档
├── scripts/                     # 脚本文件
├── docker/                      # Docker配置
├── gradlew                      # Gradle Wrapper (Unix)
├── gradlew.bat                  # Gradle Wrapper (Windows)
├── build.gradle                 # Gradle构建脚本 (Groovy)
├── build.gradle.kts             # Gradle构建脚本 (Kotlin)
├── settings.gradle              # 项目设置
├── gradle.properties            # Gradle属性
├── .gitignore                   # Git忽略文件
└── README.md                    # 项目说明
```

#### **智能开发和构建**
```bash
# 编译项目
./gradlew compileJava

# 运行测试
./gradlew test

# 构建项目
./gradlew build

# 清理构建
./gradlew clean

# 完整重新构建
./gradlew clean build

# 运行应用
./gradlew bootRun

# 生成JAR包
./gradlew jar

# 生成可执行JAR
./gradlew bootJar

# 依赖分析
./gradlew dependencies
./gradlew dependencyInsight --dependency spring-boot

# 任务列表
./gradlew tasks

# 构建性能报告
./gradlew build --profile
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: Java应用架构设计和构建流程优化
- **context7**: 动态获取Gradle和Java生态最新文档
- **memory**: Java开发经验自动复用和Gradle配置模式库
- **puppeteer**: Java Web应用自动化测试和性能监控

#### **全局规则遵守**
- **Java代码规范**: 自动应用Google Java Style和最佳实践
- **Gradle约定**: 标准项目布局和任务配置
- **Spring规范**: Spring Boot最佳实践和配置管理
- **构建优化**: 增量构建、并行执行、缓存策略

#### **Java Gradle专项智能特性**
- **构建脚本优化**: DSL最佳实践和性能调优
- **依赖管理**: 版本目录、依赖锁定和冲突解决
- **插件配置**: 常用插件的最佳配置实践
- **多项目构建**: 复合构建和模块化项目结构

### **📋 Java Gradle开发建议**

#### **开始开发**
1. 描述应用需求，如："创建Spring Boot微服务应用"
2. 系统会自动生成Gradle构建脚本和项目结构
3. 应用Gradle最佳实践和Spring Boot配置

#### **构建配置**
1. 说明构建需求，如："配置多模块项目构建"
2. 系统会设计模块依赖关系和构建配置
3. 优化构建性能和缓存策略

#### **部署优化**
1. 描述部署需求，如："配置Docker容器化构建"
2. 系统会集成Gradle Docker插件和最佳实践
3. 确保构建产物的安全性和可重现性

### **🔧 开发工具集成**

#### **开发环境**
- **Java 17+ LTS**: 现代Java运行时环境
- **Gradle 8.0+**: 最新构建工具和性能优化
- **Spring Boot**: 企业级应用开发框架
- **IDE支持**: IntelliJ IDEA、Eclipse、VSCode完整支持

#### **代码质量**
- **SpotBugs**: 静态代码分析和Bug检测
- **Checkstyle**: Java代码风格检查
- **JaCoCo**: 代码覆盖率分析和报告
- **Gradle质量插件**: 集成质量检查到构建流程

#### **测试框架**
- **JUnit 5**: 现代Java测试框架
- **Spock**: Groovy测试框架和BDD支持
- **TestContainers**: 集成测试容器化
- **Gradle测试插件**: 测试执行和报告

#### **构建插件**
- **Spring Boot Plugin**: Spring Boot应用构建
- **Shadow Plugin**: Fat JAR打包
- **Docker Plugin**: 容器镜像构建
- **JMH Plugin**: 微基准测试

### **📈 效率提升**

相比传统Java开发，智能Claude Autopilot 2.1提供：
- ⚡ **构建效率**: Gradle增量构建和缓存，提升5-10倍构建速度
- 🎯 **配置质量**: 基于Gradle最佳实践的高效构建脚本
- 🔄 **模块复用**: 智能的多项目构建和依赖管理
- 📊 **性能优化**: JVM参数调优、并行构建、构建缓存
- 🧪 **测试效率**: 并行测试执行和智能测试选择

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **Gradle问题**
```bash
# 检查Gradle版本
./gradlew --version

# 刷新依赖
./gradlew --refresh-dependencies

# 清理Gradle缓存
rm -rf ~/.gradle/caches/
./gradlew clean build

# 查看构建扫描
./gradlew build --scan

# 调试构建
./gradlew build --debug

# 检查项目信息
./gradlew projects
./gradlew properties
```

#### **依赖问题**
```bash
# 查看依赖树
./gradlew dependencies

# 查看特定配置依赖
./gradlew dependencies --configuration runtimeClasspath

# 依赖洞察
./gradlew dependencyInsight --dependency spring-core

# 检查依赖冲突
./gradlew dependencyInsight --dependency slf4j-api

# 生成依赖报告
./gradlew htmlDependencyReport
```

#### **构建性能问题**
```bash
# 启用并行构建
echo "org.gradle.parallel=true" >> gradle.properties

# 增加内存
echo "org.gradle.jvmargs=-Xmx4g -XX:MaxMetaspaceSize=1g" >> gradle.properties

# 启用守护进程
echo "org.gradle.daemon=true" >> gradle.properties

# 启用配置缓存
./gradlew build --configuration-cache

# 构建性能分析
./gradlew build --profile

# 查看构建缓存
./gradlew build --build-cache
```

#### **测试问题**
```bash
# 运行单个测试
./gradlew test --tests UserServiceTest

# 并行测试
./gradlew test --parallel

# 测试调试
./gradlew test --debug-jvm

# 生成测试报告
./gradlew test jacocoTestReport

# 持续测试
./gradlew test --continuous

# 清理测试缓存
./gradlew cleanTest test
```

#### **Spring Boot问题**
```bash
# 运行Spring Boot应用
./gradlew bootRun

# 生成可执行JAR
./gradlew bootJar

# 查看Spring Boot信息
./gradlew bootBuildInfo

# 开发工具热重载
./gradlew bootRun --args='--spring.devtools.restart.enabled=true'

# 检查应用属性
./gradlew bootRun --args='--spring.config.location=classpath:application-dev.yml'
```

#### **多项目构建问题**
```bash
# 构建所有子项目
./gradlew build

# 构建特定子项目
./gradlew :subproject:build

# 查看项目结构
./gradlew projects

# 生成项目依赖图
./gradlew htmlDependencyReport

# 并行构建子项目
./gradlew build --parallel --max-workers=4
```

---

## 🚀 **开始Java Gradle智能开发之旅**

智能Claude Autopilot 2.1专为Java Gradle开发优化！

**直接描述您的Java项目需求**，系统会自动选择最适合的开发模式：

- 现代应用 → 基于Gradle和Spring Boot的高性能应用
- 多模块项目 → 复合构建和模块化架构
- 云原生应用 → 容器化和微服务架构
- 高性能应用 → GraalVM Native Image和响应式编程

**享受Gradle生态的灵活高效开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为Java Gradle项目优化*