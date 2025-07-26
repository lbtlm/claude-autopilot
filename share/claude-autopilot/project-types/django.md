# Django Web项目规范

## 📋 项目特征

- **适用场景**: 全栈Web应用、CMS、电商平台、企业级应用、管理系统、博客平台
- **后端技术栈**: Django 5.1 + Django REST Framework + PostgreSQL + Redis + Celery
- **前端集成**: Django Templates + HTMX / SPA (Vue3/React) / Admin界面
- **部署方式**: 🚀 Docker标准化部署 + 多架构支持 + 智能服务管理
- **特点**: 官方标准结构、快速开发、强大Admin、完整生态、95%项目覆盖

## 🏗️ 通用标准项目结构（适用于所有Django项目）

```
django-web-project/
├── manage.py                         # Django管理脚本
├── myproject/                        # 🎯 主项目配置包
│   ├── __init__.py
│   ├── settings/                     # 分环境配置 (2025最佳实践)
│   │   ├── __init__.py
│   │   ├── base.py                   # 基础配置
│   │   ├── development.py            # 开发环境
│   │   ├── production.py             # 生产环境
│   │   └── testing.py                # 测试环境
│   ├── urls.py                       # URL根配置
│   ├── wsgi.py                       # WSGI入口
│   └── asgi.py                       # ASGI入口 (异步支持)
├── apps/                             # 🚀 Django应用集合
│   ├── __init__.py
│   ├── blog/                         # 示例：博客应用
│   │   ├── __init__.py
│   │   ├── models.py                 # 数据模型
│   │   ├── views.py                  # 视图逻辑
│   │   ├── urls.py                   # 应用URL配置
│   │   ├── admin.py                  # 管理后台配置
│   │   ├── serializers.py            # DRF序列化器
│   │   ├── tests.py                  # 测试文件
│   │   ├── forms.py                  # 表单定义
│   │   ├── managers.py               # 模型管理器
│   │   ├── signals.py                # Django信号
│   │   ├── migrations/               # 数据库迁移
│   │   ├── templates/blog/           # 应用模板
│   │   └── static/blog/              # 应用静态文件
│   ├── users/                        # 用户管理应用
│   │   ├── models.py                 # 用户模型
│   │   ├── views.py                  # 用户视图
│   │   ├── serializers.py            # 用户API序列化
│   │   └── admin.py                  # 用户管理后台
│   └── core/                         # 核心功能应用
│       ├── models.py                 # 核心模型
│       ├── utils.py                  # 工具函数
│       └── middleware.py             # 自定义中间件
├── templates/                        # 🎨 全局模板
│   ├── base.html                     # 基础模板
│   ├── includes/                     # 包含模板
│   └── registration/                 # 认证模板
├── static/                           # 📦 全局静态文件
│   ├── css/                          # 样式文件
│   ├── js/                           # JavaScript文件
│   ├── img/                          # 图片资源
│   └── admin/                        # Admin样式覆盖
├── media/                            # 📸 用户上传文件
├── locale/                           # 🌐 国际化文件
├── tests/                            # 🧪 项目级测试
│   ├── test_models.py                # 模型测试
│   ├── test_views.py                 # 视图测试
│   └── test_integration.py           # 集成测试
├── requirements/                     # 📋 分环境依赖
│   ├── base.txt                      # 基础依赖
│   ├── development.txt               # 开发依赖
│   ├── production.txt                # 生产依赖
│   └── testing.txt                   # 测试依赖
├── config/                           # ⚙️ 配置文件
│   ├── gunicorn.conf.py              # Gunicorn配置
│   └── celery.py                     # Celery配置
├── deployments/                      # 🚀 部署配置 (保持现有标准)
│   ├── docker-compose.yml            # 开发环境编排
│   ├── docker-compose.prod.yml       # 生产环境编排
│   └── production-safe-deploy.sh     # 生产安全部署脚本
├── scripts/                          # 📜 管理脚本 (保持现有标准)
│   ├── multi-arch-build.sh           # 多架构构建脚本
│   ├── init_db.py                    # 数据库初始化
│   └── seed_data.py                  # 数据填充
├── docs/                             # 📚 项目文档
├── .env.example                      # 环境变量示例
├── .gitignore                        # Git忽略文件
├── .editorconfig                     # 编辑器配置
├── Makefile                          # 构建和开发工具
└── README.md                         # 项目文档
```

## 🔧 2025年技术栈标准

### **现代Django技术栈特性**

**核心框架 (基于官方文档和最佳实践)**
- **Django 5.1** - 最新LTS版本，完整异步支持
- **Python 3.11+** - 现代Python版本特性
- **Django REST Framework 3.15+** - 强大的API构建工具
- **django-extensions** - 开发辅助工具集

**数据层技术栈 (基于用户偏好)**
- **PostgreSQL 15+** - 主数据库选择
- **Redis 7+** - 缓存和会话存储
- **Celery + Redis** - 异步任务队列
- **django-redis** - Django Redis缓存后端

### **后端依赖配置 (requirements/base.txt)**
```txt
# Django 核心
Django==5.1.0
djangorestframework==3.15.0
python-decouple==3.8

# 数据库
psycopg2-binary==2.9.9
django-redis==5.4.0

# 异步任务
celery[redis]==5.3.0
redis==5.0.0

# 安全和认证
django-cors-headers==4.4.0
django-allauth==0.58.0
PyJWT==2.8.0

# 开发工具
django-extensions==3.2.3
django-debug-toolbar==4.2.0

# 媒体文件
Pillow==10.4.0
whitenoise==6.7.0

# API文档
drf-spectacular==0.27.0
```

### **开发依赖 (requirements/development.txt)**
```txt
-r base.txt

# 代码质量
ruff==0.6.0
black==24.8.0
isort==5.13.0
mypy==1.11.0
django-stubs==5.1.0

# 测试
pytest==8.3.0
pytest-django==4.8.0
pytest-cov==5.0.0
factory-boy==3.3.0
model-bakery==1.19.0

# 调试
ipython==8.26.0
django-debug-toolbar==4.2.0
```

## 🚀 标准化Docker部署流程（强制规范）

### ⭐ 基于Gateway项目验证的部署标准

采用与FastAPI+Vue3项目相同的标准化部署流程，确保一致的部署体验：

#### 部署命令标准

```bash
# 1. 本地多架构构建
./scripts/multi-arch-build.sh

# 2. 开发环境智能部署
./deployments/smart-redis-deploy.sh

# 3. 生产环境安全部署
./deployments/production-safe-deploy.sh
```

#### 关键特性

- **数据保护**: 绝不删除现有数据卷
- **智能检测**: Redis连接优先级（远程>本地>Docker>内置）
- **健康检查**: 自动验证Django `/health/` 端点
- **多架构**: 同时支持ARM64和AMD64
- **安全部署**: 生产环境数据保护机制

## 📜 2025年标准化 Makefile

```makefile
.PHONY: install dev migrate test lint collectstatic deploy clean help

# 项目配置
PROJECT_NAME = django-web-project
DOCKER_USER = your-dockerhub-username
IMAGE_NAME = $(DOCKER_USER)/$(PROJECT_NAME)

help:
	@echo "🚀 Django 5.1 Web项目开发命令:"
	@echo ""
	@echo "📦 开发环境:"
	@echo "  install       - 安装开发依赖"
	@echo "  dev           - 启动开发环境"
	@echo "  migrate       - 数据库迁移"
	@echo "  test          - 运行所有测试"
	@echo "  lint          - 代码质量检查"
	@echo ""
	@echo "🏗️  构建部署:"
	@echo "  collectstatic - 收集静态文件"
	@echo "  build         - 构建项目"
	@echo "  deploy-dev    - 开发环境部署"
	@echo "  deploy-prod   - 生产安全部署 ⭐"
	@echo ""
	@echo "🧹 维护:"
	@echo "  clean         - 清理临时文件"
	@echo "  health-check  - 项目健康检查"

install:
	@echo "🔧 安装开发依赖..."
	pip install -r requirements/development.txt
	@echo "✅ 依赖安装完成!"

dev:
	@echo "🚀 启动开发环境..."
	python manage.py runserver 0.0.0.0:8000

migrate:
	@echo "📊 执行数据库迁移..."
	python manage.py makemigrations
	python manage.py migrate
	@echo "✅ 迁移完成!"

test:
	@echo "🧪 运行所有测试..."
	pytest apps/ tests/ -v --cov=apps --cov-report=html
	@echo "✅ 测试完成!"

lint:
	@echo "🔍 代码质量检查..."
	ruff check apps/ myproject/
	black --check apps/ myproject/
	isort --check-only apps/ myproject/
	mypy apps/
	@echo "✅ 代码检查完成!"

collectstatic:
	@echo "📦 收集静态文件..."
	python manage.py collectstatic --noinput
	@echo "✅ 静态文件收集完成!"

build:
	@echo "📦 构建项目..."
	make collectstatic
	docker build -t $(IMAGE_NAME):latest .
	@echo "✅ 构建完成!"

deploy-dev:
	@echo "🚀 开发环境部署..."
	docker compose -f deployments/docker-compose.yml up -d
	@echo "✅ 开发环境启动完成!"

deploy-prod:
	@echo "🔒 生产安全部署..."
	./deployments/production-safe-deploy.sh
	@echo "✅ 生产部署完成!"

clean:
	@echo "🧹 清理临时文件..."
	find . -type d -name __pycache__ -delete
	find . -name "*.pyc" -delete
	find . -name "*.pyo" -delete
	rm -rf .pytest_cache/
	rm -rf htmlcov/
	@echo "✅ 清理完成!"

health-check:
	@echo "🏥 项目健康检查..."
	python manage.py check --deploy
	python manage.py test apps/ --keepdb
	@echo "✅ 健康检查完成!"

# 数据库操作
createsuperuser:
	@echo "👤 创建超级用户..."
	python manage.py createsuperuser

shell:
	@echo "🐚 启动Django Shell..."
	python manage.py shell_plus

# 开发辅助
makemigrations:
	@echo "📝 生成迁移文件..."
	python manage.py makemigrations $(app)

loaddata:
	@echo "📊 加载测试数据..."
	python manage.py loaddata fixtures/*.json
```

## 🔒 安全规范

### Django内置安全特性
- ✅ CSRF保护 - Django内置CSRF防护机制
- ✅ SQL注入防护 - ORM自动防护SQL注入
- ✅ XSS防护 - 模板系统自动HTML转义
- ✅ Clickjacking防护 - X-Frame-Options头设置
- ✅ HTTPS强制 - SECURE_SSL_REDIRECT配置
- ✅ 安全Cookie - Session和CSRF cookie安全设置

### 用户认证和权限
- ✅ 完整认证系统 - Django内置用户认证
- ✅ 权限控制 - 基于用户、组和权限的访问控制
- ✅ 密码安全 - 强密码验证和安全存储
- ✅ 社交登录 - django-allauth集成
- ✅ JWT Token - DRF Token认证
- ✅ API权限 - DRF权限类和节流

## 📝 核心配置文件示例

### **Django 分环境配置 (settings/base.py)**
```python
"""
Django 5.1 项目基础配置
基于官方文档和2025年最佳实践
"""
import os
from pathlib import Path
from decouple import config
from django.core.management.utils import get_random_secret_key

# 项目路径配置
BASE_DIR = Path(__file__).resolve().parent.parent.parent

# 安全配置
SECRET_KEY = config('SECRET_KEY', default=get_random_secret_key())
DEBUG = False
ALLOWED_HOSTS = []

# 应用配置 (遵循Django官方推荐结构)
DJANGO_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
]

THIRD_PARTY_APPS = [
    'rest_framework',
    'corsheaders',
    'allauth',
    'allauth.account',
    'drf_spectacular',
]

LOCAL_APPS = [
    'apps.core',
    'apps.users',
    'apps.blog',
]

INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + LOCAL_APPS

# 中间件配置
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'myproject.urls'

# 模板配置
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# 数据库配置 (PostgreSQL优先)
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': config('DB_NAME', default='django_db'),
        'USER': config('DB_USER', default='postgres'),
        'PASSWORD': config('DB_PASSWORD', default='password'),
        'HOST': config('DB_HOST', default='localhost'),
        'PORT': config('DB_PORT', default='5432'),
        'OPTIONS': {
            'connect_timeout': 60,
        },
    }
}

# Django REST Framework配置
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.TokenAuthentication',
    ],
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ],
    'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 20,
}

# API文档配置
SPECTACULAR_SETTINGS = {
    'TITLE': 'Django Web API',
    'DESCRIPTION': 'Django 5.1 现代Web应用API文档',
    'VERSION': '1.0.0',
    'SERVE_INCLUDE_SCHEMA': False,
}

# 国际化
LANGUAGE_CODE = 'zh-hans'
TIME_ZONE = 'Asia/Shanghai'
USE_I18N = True
USE_TZ = True

# 静态文件配置
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'
STATICFILES_DIRS = [BASE_DIR / 'static']

# 媒体文件配置
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# 缓存配置 (Redis)
CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': config('REDIS_URL', default='redis://127.0.0.1:6379/1'),
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        }
    }
}

# Celery配置
CELERY_BROKER_URL = config('REDIS_URL', default='redis://127.0.0.1:6379/0')
CELERY_RESULT_BACKEND = config('REDIS_URL', default='redis://127.0.0.1:6379/0')

# 站点配置
SITE_ID = 1

# 默认主键字段类型
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
```

### **现代化Django模型示例**
```python
# apps/blog/models.py
from django.db import models
from django.contrib.auth.models import User
from django.urls import reverse
from django.utils.text import slugify


class TimestampedModel(models.Model):
    """带时间戳的抽象基类模型"""
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='更新时间')
    
    class Meta:
        abstract = True


class PublishedManager(models.Manager):
    """已发布文章管理器"""
    def get_queryset(self):
        return super().get_queryset().filter(status='published')


class Post(TimestampedModel):
    """博客文章模型"""
    STATUS_CHOICES = [
        ('draft', '草稿'),
        ('published', '已发布'),
    ]
    
    title = models.CharField(max_length=200, verbose_name='标题')
    slug = models.SlugField(max_length=200, unique=True, verbose_name='URL别名')
    author = models.ForeignKey(
        User, 
        on_delete=models.CASCADE,
        related_name='posts',
        verbose_name='作者'
    )
    content = models.TextField(verbose_name='内容')
    status = models.CharField(
        max_length=10,
        choices=STATUS_CHOICES,
        default='draft',
        verbose_name='状态'
    )
    
    # 管理器
    objects = models.Manager()  # 默认管理器
    published = PublishedManager()  # 自定义管理器
    
    class Meta:
        verbose_name = '文章'
        verbose_name_plural = '文章'
        ordering = ['-created_at']
        indexes = [
            models.Index(fields=['status', 'created_at']),
            models.Index(fields=['author', 'status']),
        ]
    
    def __str__(self):
        return self.title
    
    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title)
        super().save(*args, **kwargs)
    
    def get_absolute_url(self):
        return reverse('blog:post_detail', kwargs={'slug': self.slug})
```

### **Django REST Framework API视图**
```python
# apps/blog/views.py
from rest_framework import generics, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters import rest_framework as filters
from .models import Post
from .serializers import PostSerializer


class PostFilter(filters.FilterSet):
    """文章过滤器"""
    title = filters.CharFilter(lookup_expr='icontains')
    author = filters.CharFilter(field_name='author__username', lookup_expr='icontains')
    created_after = filters.DateFilter(field_name='created_at', lookup_expr='gte')
    
    class Meta:
        model = Post
        fields = ['status', 'title', 'author', 'created_after']


class PostListCreateAPIView(generics.ListCreateAPIView):
    """文章列表和创建API"""
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    filterset_class = PostFilter
    search_fields = ['title', 'content']
    ordering_fields = ['created_at', 'updated_at']
    ordering = ['-created_at']
    
    def perform_create(self, serializer):
        serializer.save(author=self.request.user)


class PostDetailAPIView(generics.RetrieveUpdateDestroyAPIView):
    """文章详情API"""
    queryset = Post.objects.all()
    serializer_class = PostSerializer
    lookup_field = 'slug'
    
    def get_permissions(self):
        if self.request.method in ['PUT', 'PATCH', 'DELETE']:
            return [permissions.IsAuthenticated()]
        return [permissions.AllowAny()]
```

### **Pydantic风格的DRF序列化器**
```python
# apps/blog/serializers.py
from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Post


class AuthorSerializer(serializers.ModelSerializer):
    """作者序列化器"""
    class Meta:
        model = User
        fields = ['id', 'username', 'first_name', 'last_name']


class PostSerializer(serializers.ModelSerializer):
    """文章序列化器"""
    author = AuthorSerializer(read_only=True)
    author_id = serializers.IntegerField(write_only=True, required=False)
    
    class Meta:
        model = Post
        fields = [
            'id', 'title', 'slug', 'content', 'status',
            'author', 'author_id', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']
    
    def validate_title(self, value):
        if len(value) < 5:
            raise serializers.ValidationError('标题至少需要5个字符')
        return value
    
    def create(self, validated_data):
        # 自动设置当前用户为作者
        validated_data['author'] = self.context['request'].user
        return super().create(validated_data)
```

## 💾 数据库设计规范

### PostgreSQL 最佳实践
- 使用UUID作为主键（适合分布式）或BigAutoField
- 添加created_at和updated_at时间戳字段
- 建立适当的数据库索引
- 使用外键约束保证数据完整性
- 定期数据库备份和性能监控

### Django迁移管理
```python
# 创建新迁移
python manage.py makemigrations apps_name

# 查看迁移SQL
python manage.py sqlmigrate apps_name 0001

# 执行迁移
python manage.py migrate

# 回滚迁移
python manage.py migrate apps_name 0001
```

### **智能Docker配置**

**开发环境 (deployments/docker-compose.yml)**
```yaml
services:
  django:
    build: 
      context: .
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    volumes:
      - .:/app
      - /app/staticfiles
    environment:
      - DJANGO_SETTINGS_MODULE=myproject.settings.development
      - DATABASE_URL=postgresql://django:django123@postgres:5432/django_db
      - REDIS_URL=redis://redis:6379/0
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_started
    healthcheck:
      test: ["CMD", "python", "manage.py", "check", "--deploy"]
      interval: 30s
      timeout: 10s
      retries: 5

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: django_db
      POSTGRES_USER: django
      POSTGRES_PASSWORD: django123
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U django"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    command: redis-server --appendonly yes
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  celery:
    build: .
    command: celery -A myproject worker -l info
    environment:
      - DJANGO_SETTINGS_MODULE=myproject.settings.development
      - DATABASE_URL=postgresql://django:django123@postgres:5432/django_db
      - REDIS_URL=redis://redis:6379/0
    depends_on:
      - postgres
      - redis
    volumes:
      - .:/app

volumes:
  postgres_data:
  redis_data:
```

**生产环境 (deployments/docker-compose.prod.yml)**
```yaml
services:
  django:
    image: ${DOCKER_USER}/${PROJECT_NAME}:latest
    ports:
      - "8000:8000"
    environment:
      - DJANGO_SETTINGS_MODULE=myproject.settings.production
      - DATABASE_URL=${DATABASE_URL}
      - REDIS_URL=${REDIS_URL}
      - SECRET_KEY=${SECRET_KEY}
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "python", "manage.py", "check", "--deploy"]
      interval: 30s
      timeout: 10s
      retries: 5

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - django
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:
```

### **现代化测试策略**

**Django测试 (Pytest + Django)**
```python
# tests/test_models.py
import pytest
from django.contrib.auth.models import User
from apps.blog.models import Post


@pytest.mark.django_db
class TestPostModel:
    def test_post_creation(self):
        user = User.objects.create_user(
            username='testuser',
            email='test@example.com',
            password='testpass123'
        )
        post = Post.objects.create(
            title='Test Post',
            content='This is a test post content.',
            author=user,
            status='published'
        )
        
        assert post.title == 'Test Post'
        assert post.slug == 'test-post'
        assert post.author == user
        assert str(post) == 'Test Post'

    def test_published_manager(self):
        user = User.objects.create_user(username='author', password='pass')
        
        # 创建已发布和草稿文章
        Post.objects.create(
            title='Published Post',
            content='Content',
            author=user,
            status='published'
        )
        Post.objects.create(
            title='Draft Post',
            content='Content',
            author=user,
            status='draft'
        )
        
        # 测试自定义管理器
        assert Post.objects.count() == 2
        assert Post.published.count() == 1
```

**API测试 (Django REST Framework)**
```python
# tests/test_api.py
import pytest
from django.urls import reverse
from rest_framework.test import APIClient
from rest_framework import status
from django.contrib.auth.models import User
from apps.blog.models import Post


@pytest.mark.django_db
class TestPostAPI:
    def setup_method(self):
        self.client = APIClient()
        self.user = User.objects.create_user(
            username='testuser',
            password='testpass123'
        )
    
    def test_get_post_list(self):
        """测试获取文章列表"""
        Post.objects.create(
            title='Test Post',
            content='Content',
            author=self.user,
            status='published'
        )
        
        url = reverse('blog:post-list')
        response = self.client.get(url)
        
        assert response.status_code == status.HTTP_200_OK
        assert len(response.data['results']) == 1
    
    def test_create_post_authenticated(self):
        """测试认证用户创建文章"""
        self.client.force_authenticate(user=self.user)
        
        url = reverse('blog:post-list')
        data = {
            'title': 'New Post',
            'content': 'This is new content.',
            'status': 'draft'
        }
        response = self.client.post(url, data)
        
        assert response.status_code == status.HTTP_201_CREATED
        assert Post.objects.count() == 1
        assert Post.objects.first().author == self.user
```

## 🚀 现代化开发流程

### **项目初始化**

```bash
# 1. 创建项目结构
mkdir django-web-project && cd django-web-project
mkdir -p apps/{core,users,blog} templates static media locale tests \
         requirements config deployments scripts docs

# 2. 初始化Django项目
django-admin startproject myproject .
cd apps && python ../manage.py startapp core
python ../manage.py startapp users
python ../manage.py startapp blog

# 3. 设置开发环境
make install
make migrate

# 4. 创建超级用户
make createsuperuser

# 5. 启动开发服务器
make dev
```

### **日常开发工作流**

```bash
# 🔧 开发环境管理
make dev           # 启动Django开发服务器
make shell         # Django Shell (IPython增强)
make migrate       # 数据库迁移
make test          # 运行所有测试

# 🧪 测试和质量检查
make lint          # 代码质量检查 (ruff + black + mypy)
make test          # 运行测试套件
make health-check  # 完整项目健康检查

# 📦 构建和部署
make collectstatic # 收集静态文件
make build         # Docker镜像构建
make deploy-dev    # 开发环境部署
make deploy-prod   # 生产安全部署

# 🗃️ 数据库操作
make makemigrations app=blog  # 生成迁移文件
make loaddata      # 加载测试数据
```

### **性能优化**

- **数据库优化**: QuerySet优化、select_related、prefetch_related、数据库索引
- **缓存策略**: Redis缓存、模板缓存、视图缓存、会话缓存
- **静态文件**: WhiteNoise静态文件服务、CDN集成、文件压缩
- **异步任务**: Celery后台任务、定时任务、任务监控

### **安全规范**

- **数据保护**: CSRF保护、XSS防护、SQL注入防护
- **认证授权**: Django认证系统、权限控制、API Token认证
- **HTTPS配置**: SSL/TLS配置、安全头设置、Cookie安全
- **敏感信息**: 环境变量管理、密钥轮换、日志脱敏

### **开发工具链**

- **后端工具**: Django + DRF + Celery + PostgreSQL + Redis
- **代码质量**: Ruff (检查+格式化) + MyPy (类型检查) + Black (格式化)
- **测试框架**: Pytest + Django Test + Factory Boy + Coverage
- **CI/CD**: Docker 自动化构建 + 多架构支持 + 健康检查

## 📚 2025年Django参考资源

### **官方文档**

- [Django 5.1 官方文档](https://docs.djangoproject.com/)
- [Django REST Framework 文档](https://www.django-rest-framework.org/)
- [Celery 文档](https://docs.celeryproject.org/)
- [PostgreSQL 文档](https://www.postgresql.org/docs/)

### **最佳实践指南**

- Django官方项目结构和应用设计原则
- DRF API设计和序列化器最佳实践
- 现代化Docker容器部署和多架构支持
- 95%Django项目需求覆盖的通用架构模式

---

**✨ 这个模板基于Django官方文档和2025年最佳实践，为Django Web项目提供完整的全栈开发解决方案。**