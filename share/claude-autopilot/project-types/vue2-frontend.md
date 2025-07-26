# Vue2前端项目规范 ⚠️ 已淘汰

## 📋 项目特征

- **⚠️ 注意**: Vue 2 已于2023年12月31日停止维护，强烈建议迁移到Vue 3
- **适用场景**: 遗留系统维护、渐进式迁移项目、特定版本兼容性要求
- **技术栈**: Vue 2.7 + Vuex + Vue Router + Element UI + Webpack 
- **开发模式**: Options API + 混入 + 渐进式升级策略
- **部署方式**: 🚀 静态部署 + CDN加速 + 容器化支持
- **特点**: 成熟生态、平滑迁移路径、遗留项目支持

## 🚨 迁移建议

### **Vue 3 迁移优势**
- **性能提升**: 20-30%渲染性能提升，更好的Tree-shaking
- **现代特性**: Composition API、Teleport、Fragments
- **TypeScript支持**: 原生TypeScript支持和更好的类型推断
- **生态活跃**: 活跃维护、定期更新、长期支持

### **迁移策略**
1. **评估项目复杂度**: 分析组件数量、第三方依赖兼容性
2. **渐进式迁移**: 使用@vue/compat兼容模式逐步迁移
3. **测试覆盖**: 确保关键功能测试覆盖，降低迁移风险
4. **团队培训**: 学习Vue 3新特性和最佳实践

## 🏗️ Vue2项目结构（仅供维护参考）

```
vue2-frontend项目/ ⚠️ 遗留项目结构
├── public/
│   ├── index.html               # HTML模板
│   └── favicon.ico             # 网站图标
├── src/
│   ├── components/             # 通用组件 (Options API)
│   ├── views/                  # 页面组件
│   ├── router/                 # Vue Router 3.x
│   ├── store/                  # Vuex 3.x状态管理
│   ├── assets/                 # 静态资源
│   ├── utils/                  # 工具函数
│   ├── api/                    # API接口
│   ├── mixins/                 # 混入 (已废弃模式)
│   └── main.js                 # 应用入口
├── package.json               # 项目配置
├── vue.config.js              # Vue CLI配置
└── .eslintrc.js               # ESLint配置
```

## 📜 Vue2依赖配置（最终版本）

```json
{
  "name": "vue2-legacy-project",
  "version": "1.0.0", 
  "dependencies": {
    "vue": "^2.7.16",
    "vuex": "^3.6.2",
    "vue-router": "^3.6.5",
    "element-ui": "^2.15.14",
    "axios": "^1.7.0"
  },
  "devDependencies": {
    "@vue/cli-service": "^5.0.8",
    "@vue/test-utils": "^1.3.6",
    "vue-template-compiler": "^2.7.16",
    "webpack": "^5.90.0",
    "eslint": "^8.57.0",
    "prettier": "^3.3.0"
  }
}
```

## ⚠️ 维护模式开发

### **仅限维护的基本工作流**

```bash
# 安全依赖管理
npm audit fix                    # 修复安全漏洞
npm outdated                     # 检查过时依赖
npm run serve                    # 开发服务器
npm run build                    # 生产构建
npm run lint                     # 代码检查
```

### **Vue2组件示例（遗留模式）**

```vue
<template>
  <div class="user-profile">
    <h3>{{ displayName }}</h3>
    <p>{{ user.email }}</p>
  </div>
</template>

<script>
// Options API - Vue2传统模式
export default {
  name: 'UserProfile',
  props: {
    userId: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      user: null,
      loading: false
    }
  },
  computed: {
    displayName() {
      return this.user 
        ? `${this.user.firstName} ${this.user.lastName}` 
        : '未知用户'
    }
  },
  async mounted() {
    await this.fetchUser()
  },
  methods: {
    async fetchUser() {
      this.loading = true
      try {
        const response = await this.$http.get(`/users/${this.userId}`)
        this.user = response.data
      } catch (error) {
        this.$message.error('获取用户信息失败')
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
```

## 🚨 安全和维护警告

### **已知限制**
- **安全更新**: 不再接收安全补丁
- **浏览器兼容性**: 新浏览器特性不支持
- **生态系统**: 第三方库逐步停止Vue2支持
- **性能**: 相比Vue3性能差距逐渐扩大

### **建议行动**
1. **立即规划迁移**: 制定Vue3迁移时间表
2. **冻结新功能**: 避免在Vue2项目中添加新功能
3. **加强测试**: 确保现有功能稳定性
4. **监控依赖**: 定期检查依赖安全问题

---

**⚠️ 重要提醒**: Vue 2已停止维护，本模板仅用于遗留项目维护。强烈建议迁移到Vue 3以获得更好的性能、安全性和生态支持。

参考Vue 3模板: [vue3-frontend.md](./vue3-frontend.md)