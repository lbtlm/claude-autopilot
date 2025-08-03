#!/bin/bash

# 项目健康度检查脚本
# 用于检查Claude Autopilot项目的健康状态

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查参数
PROJECT_PATH="${1:-$(pwd)}"

echo -e "${BLUE}🏥 项目健康度检查工具${NC}"
echo "================================================"
echo "检查项目: $PROJECT_PATH"
echo ""

# 检查项目是否存在
if [ ! -d "$PROJECT_PATH" ]; then
    echo -e "${RED}❌ 错误: 项目目录不存在: $PROJECT_PATH${NC}"
    exit 1
fi

cd "$PROJECT_PATH"

# 检查基本文件结构
echo -e "${YELLOW}📁 检查基本文件结构...${NC}"

check_count=0
success_count=0

# 检查CLAUDE.md
check_count=$((check_count + 1))
if [ -f "CLAUDE.md" ]; then
    echo -e "${GREEN}✅ CLAUDE.md 存在${NC}"
    success_count=$((success_count + 1))
else
    echo -e "${RED}❌ CLAUDE.md 缺失${NC}"
fi

# 检查.claude目录
check_count=$((check_count + 1))
if [ -d ".claude" ]; then
    echo -e "${GREEN}✅ .claude/ 目录存在${NC}"
    success_count=$((success_count + 1))
else
    echo -e "${RED}❌ .claude/ 目录缺失${NC}"
fi

# 检查project.json
check_count=$((check_count + 1))
if [ -f ".claude/project.json" ]; then
    echo -e "${GREEN}✅ .claude/project.json 存在${NC}"
    success_count=$((success_count + 1))
else
    echo -e "${RED}❌ .claude/project.json 缺失${NC}"
fi

# 检查Makefile
check_count=$((check_count + 1))
if [ -f "Makefile" ]; then
    echo -e "${GREEN}✅ Makefile 存在${NC}"
    success_count=$((success_count + 1))
else
    echo -e "${YELLOW}⚠️ Makefile 缺失（某些项目类型不需要）${NC}"
fi

# 检查项目类型特定文件
echo ""
echo -e "${YELLOW}📦 检查项目类型特定文件...${NC}"

# Go项目检查
if [ -f "go.mod" ]; then
    echo -e "${BLUE}🔍 检测到 Go 项目${NC}"
    check_count=$((check_count + 1))
    if [ -f "main.go" ] || [ -d "cmd" ] || [ -d "internal" ]; then
        echo -e "${GREEN}✅ Go 项目结构正常${NC}"
        success_count=$((success_count + 1))
    else
        echo -e "${YELLOW}⚠️ Go 项目结构可能不完整${NC}"
    fi
fi

# Node.js项目检查
if [ -f "package.json" ]; then
    echo -e "${BLUE}🔍 检测到 Node.js 项目${NC}"
    check_count=$((check_count + 1))
    if [ -d "node_modules" ] || [ -f "package-lock.json" ] || [ -f "yarn.lock" ]; then
        echo -e "${GREEN}✅ Node.js 依赖已安装${NC}"
        success_count=$((success_count + 1))
    else
        echo -e "${YELLOW}⚠️ Node.js 依赖未安装，运行 npm install${NC}"
    fi
fi

# Python项目检查
if [ -f "requirements.txt" ] || [ -f "pyproject.toml" ] || [ -f "setup.py" ]; then
    echo -e "${BLUE}🔍 检测到 Python 项目${NC}"
    check_count=$((check_count + 1))
    if [ -d "venv" ] || [ -d ".venv" ] || [ -n "$VIRTUAL_ENV" ]; then
        echo -e "${GREEN}✅ Python 虚拟环境已配置${NC}"
        success_count=$((success_count + 1))
    else
        echo -e "${YELLOW}⚠️ 建议创建 Python 虚拟环境${NC}"
    fi
fi

# Bash脚本项目检查
if [ -f "bin/claude-autopilot" ] || ls *.sh >/dev/null 2>&1; then
    echo -e "${BLUE}🔍 检测到 Bash 脚本项目${NC}"
    check_count=$((check_count + 1))
    
    # 检查脚本权限
    script_permissions_ok=true
    # 检查当前目录的.sh文件
    for script in *.sh; do
        if [ -f "$script" ] && [ ! -x "$script" ]; then
            script_permissions_ok=false
            break
        fi
    done 2>/dev/null
    # 检查bin目录的.sh文件
    for script in bin/*.sh; do
        if [ -f "$script" ] && [ ! -x "$script" ]; then
            script_permissions_ok=false
            break
        fi
    done 2>/dev/null
    
    if $script_permissions_ok; then
        echo -e "${GREEN}✅ 脚本权限正常${NC}"
        success_count=$((success_count + 1))
    else
        echo -e "${YELLOW}⚠️ 某些脚本缺少执行权限${NC}"
    fi
fi

# Git检查
echo ""
echo -e "${YELLOW}🗂️ Git 仓库检查...${NC}"

check_count=$((check_count + 1))
if [ -d ".git" ]; then
    echo -e "${GREEN}✅ Git 仓库已初始化${NC}"
    success_count=$((success_count + 1))
    
    # 检查远程仓库
    if git remote -v >/dev/null 2>&1 && [ -n "$(git remote)" ]; then
        echo -e "${GREEN}✅ 远程仓库已配置${NC}"
    else
        echo -e "${YELLOW}⚠️ 未配置远程仓库${NC}"
    fi
    
    # 检查未提交的更改
    if ! git diff-index --quiet HEAD 2>/dev/null; then
        echo -e "${YELLOW}⚠️ 有未提交的更改${NC}"
    else
        echo -e "${GREEN}✅ 工作目录干净${NC}"
    fi
else
    echo -e "${RED}❌ Git 仓库未初始化${NC}"
fi

# 计算健康度分数
echo ""
echo "================================================"
echo -e "${BLUE}📊 健康度报告${NC}"
echo "================================================"

if [ $check_count -gt 0 ]; then
    health_score=$((success_count * 100 / check_count))
else
    health_score=0
fi

echo "检查项目: $check_count"
echo "通过项目: $success_count"
echo "健康度评分: $health_score%"
echo ""

if [ $health_score -ge 80 ]; then
    echo -e "${GREEN}🎉 项目健康状况良好！${NC}"
elif [ $health_score -ge 60 ]; then
    echo -e "${YELLOW}⚠️ 项目健康状况一般，建议优化${NC}"
else
    echo -e "${RED}🚨 项目需要立即优化${NC}"
fi

echo ""
echo -e "${BLUE}💡 建议：${NC}"
echo "- 如果健康度较低，运行 'make inject' 重新配置"
echo "- 确保所有必要的依赖都已安装"
echo "- 定期提交代码到Git仓库"

exit 0