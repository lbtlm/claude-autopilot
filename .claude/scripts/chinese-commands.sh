#!/bin/bash

# Claude Autopilot 中文命令包装器
# 提供中文别名命令支持

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 显示可用的中文命令
show_chinese_commands() {
    echo -e "${CYAN}🇨🇳 Claude Autopilot 中文智能命令${NC}"
    echo "================================================"
    echo ""
    echo -e "${GREEN}📋 核心开发命令：${NC}"
    echo "  /智能功能开发 <功能描述>        - 完整功能开发流程"
    echo "  /智能Bug修复 <问题描述>         - 智能问题诊断和修复"  
    echo "  /智能代码重构 <重构目标>       - 基于最佳实践的重构"
    echo ""
    echo -e "${GREEN}🛠️ 项目管理命令：${NC}"
    echo "  /加载全局上下文               - 重新加载项目上下文"
    echo "  /项目状态分析                 - 全面项目健康度分析"
    echo "  /清理残余文件                 - 智能清理项目文件"
    echo "  /提交github                   - 智能Git提交"
    echo ""
    echo -e "${GREEN}🚀 高级功能命令：${NC}"
    echo "  /智能Docker部署               - Docker容器化部署"
    echo "  /智能项目规划                 - 项目架构规划"
    echo "  /智能结构验证                 - 项目结构验证"
    echo "  /智能工作总结                 - 生成工作报告"
    echo ""
    echo -e "${YELLOW}💡 使用提示：${NC}"
    echo "  - 直接在Claude Code中输入中文命令即可"
    echo "  - 例如：/智能功能开发 用户登录功能"
    echo "  - 所有命令都支持详细的中文描述"
    echo ""
}

# 主函数
main() {
    case "$1" in
        "help"|"帮助"|"")
            show_chinese_commands
            ;;
        *)
            show_chinese_commands
            ;;
    esac
}

# 如果作为脚本直接运行
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi