# CLAUDE.md - PHP项目智能协作指南

## 🚀 **智能Claude Autopilot 2.1 已激活**

本项目已集成智能Claude Autopilot 2.1系统，专为PHP项目优化的完整智能开发工作流程。

### **📊 项目信息**
- **项目名称**: $PROJECT_NAME
- **项目类型**: PHP项目
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

### **🐘 PHP开发特色功能**

#### **现代PHP特性**
- **PHP 8.0+**: 现代语言特性，JIT编译器和性能优化
- **类型声明**: 严格类型模式和联合类型支持
- **命名空间**: PSR-4自动加载和现代包管理
- **OOP特性**: 接口、trait、抽象类的现代应用

#### **主流框架支持**
- **Laravel**: 全栈Web应用框架，Eloquent ORM
- **Symfony**: 企业级组件化框架和微服务
- **CodeIgniter**: 轻量级MVC框架
- **Slim**: 微框架和API开发

#### **现代开发实践**
- **Composer**: 依赖管理和自动加载
- **PSR标准**: 代码风格、日志、缓存等标准规范
- **测试驱动**: PHPUnit、Pest、Behat测试框架
- **静态分析**: PHPStan、Psalm代码质量检查

#### **标准PHP项目结构支持**
```
php-project/
├── src/                         # 源代码
│   ├── Controller/              # 控制器
│   ├── Model/                   # 模型
│   ├── Service/                 # 服务层
│   ├── Repository/              # 数据访问层
│   ├── Entity/                  # 实体类
│   ├── DTO/                     # 数据传输对象
│   ├── Exception/               # 异常处理
│   ├── Middleware/              # 中间件
│   └── Utility/                 # 工具类
├── public/                      # 公共文件
│   ├── index.php                # 入口文件
│   ├── assets/                  # 静态资源
│   │   ├── css/                 # 样式文件
│   │   ├── js/                  # JavaScript文件
│   │   └── images/              # 图片资源
│   └── .htaccess                # Apache配置
├── config/                      # 配置文件
│   ├── app.php                  # 应用配置
│   ├── database.php             # 数据库配置
│   ├── cache.php                # 缓存配置
│   └── services.php             # 服务配置
├── storage/                     # 存储目录
│   ├── logs/                    # 日志文件
│   ├── cache/                   # 缓存文件
│   ├── sessions/                # 会话文件
│   └── uploads/                 # 上传文件
├── templates/                   # 模板文件
│   ├── layouts/                 # 布局模板
│   ├── pages/                   # 页面模板
│   └── components/              # 组件模板
├── tests/                       # 测试文件
│   ├── Unit/                    # 单元测试
│   ├── Integration/             # 集成测试
│   ├── Feature/                 # 功能测试
│   └── fixtures/                # 测试数据
├── database/                    # 数据库相关
│   ├── migrations/              # 数据库迁移
│   ├── seeds/                   # 数据填充
│   └── factories/               # 数据工厂
├── vendor/                      # Composer依赖
├── docs/                        # 项目文档
├── scripts/                     # 脚本文件
├── docker/                      # Docker配置
├── composer.json                # Composer配置
├── composer.lock                # 依赖锁定
├── .env.example                 # 环境变量模板
├── .gitignore                   # Git忽略文件
├── phpunit.xml                  # PHPUnit配置
├── phpstan.neon                 # PHPStan配置
└── README.md                    # 项目说明
```

#### **智能开发和构建**
```bash
# 安装依赖
composer install
composer install --no-dev

# 更新依赖
composer update

# 添加依赖
composer require monolog/monolog
composer require --dev phpunit/phpunit

# 自动加载
composer dump-autoload

# 运行开发服务器
php -S localhost:8000 -t public/

# 运行测试
./vendor/bin/phpunit
./vendor/bin/pest

# 代码质量检查
./vendor/bin/phpstan analyse
./vendor/bin/psalm

# 代码风格检查
./vendor/bin/php-cs-fixer fix

# 生成文档
./vendor/bin/phpdoc

# 数据库迁移
php artisan migrate  # Laravel
bin/console doctrine:migrations:migrate  # Symfony
```

### **🧠 智能能力**

#### **MCP工具链集成**
- **sequential-thinking**: PHP Web架构设计和业务逻辑分析
- **context7**: 动态获取PHP生态最新文档和最佳实践
- **memory**: PHP开发经验自动复用和设计模式库
- **puppeteer**: PHP Web应用自动化测试和功能测试

#### **全局规则遵守**
- **PHP代码规范**: 自动应用PSR-1、PSR-2、PSR-12代码风格标准
- **架构模式**: MVC、Repository、Service层的正确实现
- **安全编程**: SQL注入防护、XSS防护、CSRF保护
- **性能优化**: OPcache、查询优化、缓存策略

#### **PHP专项智能特性**
- **现代PHP特性**: 类型声明、属性、枚举的正确使用
- **框架最佳实践**: Laravel、Symfony框架的规范使用
- **数据库设计**: Eloquent ORM、Doctrine ORM最佳实践
- **API开发**: RESTful API、GraphQL、认证授权

### **📋 PHP开发建议**

#### **开始开发**
1. 描述Web应用需求，如："创建电商管理系统"
2. 系统会自动选择合适的PHP框架和架构模式
3. 生成符合PSR标准的现代PHP项目结构

#### **Web开发**
1. 说明功能需求，如："实现用户认证和权限管理"
2. 系统会设计控制器、服务、仓库层架构
3. 自动处理安全验证、数据验证和错误处理

#### **API开发**
1. 描述API需求，如："创建RESTful产品管理API"
2. 系统会设计API路由、资源控制器和响应格式
3. 确保API安全性、版本控制和文档生成

### **🔧 开发工具集成**

#### **开发环境**
- **PHP 8.0+**: 现代PHP运行时环境
- **Composer**: 依赖管理和自动加载
- **Web服务器**: Apache、Nginx、PHP内置服务器
- **IDE支持**: PhpStorm、VSCode、Sublime Text

#### **代码质量**
- **PHPStan**: 静态分析和类型检查
- **Psalm**: 静态分析和类型安全
- **PHP CS Fixer**: 自动代码格式化
- **PHPMD**: 代码复杂度和坏味道检测

#### **测试框架**
- **PHPUnit**: 经典PHP测试框架
- **Pest**: 现代PHP测试框架
- **Behat**: 行为驱动开发测试
- **Codeception**: 全栈测试框架

#### **开发工具**
- **Xdebug**: 调试和性能分析
- **Blackfire**: 性能分析和优化
- **PHPDoc**: 文档生成
- **Deployer**: 自动化部署工具

### **📈 效率提升**

相比传统PHP开发，智能Claude Autopilot 2.1提供：
- ⚡ **开发效率**: MVC架构和常用功能自动生成，提升3-4倍效率
- 🎯 **代码质量**: 基于PSR标准和现代PHP最佳实践
- 🔄 **模式复用**: 智能的设计模式和框架使用建议
- 📊 **性能优化**: 数据库查询优化、缓存策略、OPcache配置
- 🧪 **测试覆盖**: 自动生成单元测试、集成测试和功能测试

### **🆘 故障排除**

#### **命令不可用**
```bash
# 重新加载全局上下文 / Reload Global Context
/加载全局上下文 --force-refresh
# OR /load-global-context --force-refresh
```

#### **PHP环境问题**
```bash
# 检查PHP版本
php --version
php -m  # 查看已安装模块

# 检查PHP配置
php --ini
php -i | grep "memory_limit"

# 安装PHP扩展
# Ubuntu/Debian:
sudo apt-get install php-mysql php-curl php-gd php-mbstring
# CentOS/RHEL:
sudo yum install php-mysql php-curl php-gd php-mbstring

# 检查Web服务器配置
apache2 -v  # Apache版本
nginx -v    # Nginx版本
```

#### **Composer问题**
```bash
# 安装Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# 清理Composer缓存
composer clear-cache

# 重新安装依赖
rm -rf vendor/ composer.lock
composer install

# 检查依赖冲突
composer why-not php 8.1

# 更新Composer自身
composer self-update

# 验证composer.json
composer validate
```

#### **框架问题**
```bash
# Laravel问题
php artisan --version
php artisan config:clear
php artisan cache:clear
php artisan route:clear

# 检查Laravel要求
composer check-platform-reqs

# Symfony问题
bin/console --version
bin/console cache:clear
bin/console debug:router

# 权限问题
sudo chown -R www-data:www-data storage/
sudo chmod -R 755 storage/
```

#### **数据库问题**
```bash
# 检查数据库连接
php -r "new PDO('mysql:host=localhost;dbname=test', 'user', 'pass');"

# MySQL连接测试
mysql -u username -p -h localhost database_name

# Laravel数据库问题
php artisan migrate:status
php artisan migrate:refresh --seed

# 查看数据库配置
cat .env | grep DB_

# 数据库权限
GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'localhost';
FLUSH PRIVILEGES;
```

#### **性能问题**
```bash
# 启用OPcache
# 在php.ini中:
opcache.enable=1
opcache.memory_consumption=128
opcache.max_accelerated_files=4000

# 检查OPcache状态
php -r "var_dump(opcache_get_status());"

# 性能分析
composer require --dev symfony/var-dumper
dd($variable);  # Laravel
dump($variable);  # Symfony

# 内存使用分析
echo memory_get_peak_usage(true) . " bytes\n";

# 慢查询日志
# MySQL配置:
slow_query_log = 1
long_query_time = 2
```

#### **安全问题**
```bash
# 检查PHP安全配置
php -i | grep "expose_php"
php -i | grep "allow_url_include"

# 文件权限安全
find . -name "*.php" -exec chmod 644 {} \;
chmod 755 public/

# 环境变量安全
chmod 600 .env

# SSL证书检查
openssl x509 -in certificate.crt -text -noout

# SQL注入检测
grep -r "mysql_query\|mysql_real_escape_string" src/
```

---

## 🚀 **开始PHP智能开发之旅**

智能Claude Autopilot 2.1专为PHP开发优化！

**直接描述您的PHP项目需求**，系统会自动选择最适合的开发模式：

- Web应用 → 基于Laravel/Symfony的现代Web应用开发
- API服务 → RESTful API和GraphQL服务开发
- 电商系统 → 完整的电商平台和支付集成
- 内容管理 → CMS系统和内容发布平台

**享受PHP生态的快速开发体验！** ✨

---

**Claude Autopilot路径**: $GLOBAL_CE_PATH  
**项目配置**: .claude/project.json  
**最后同步**: $TIMESTAMP  
**CE版本**: v$SCRIPT_VERSION

*本文件由Claude Autopilot注入脚本自动生成，专为PHP项目优化*