# Vue 微信小程序 - Flutter插件库

基于 uni-app + Vue 3 + TypeScript 开发的微信小程序版本。

## 项目结构

```
vue-wx-app/
├── src/
│   ├── pages/           # 页面
│   │   ├── index/       # 主页
│   │   ├── detail/      # 详情页
│   │   ├── comments/    # 评论页
│   │   └── recommend/   # 推荐页
│   ├── components/      # 组件
│   │   ├── PackageCard/ # 插件卡片
│   │   └── SortPicker/  # 排序选择器
│   ├── store/          # 状态管理
│   │   ├── category.ts  # 分类状态
│   │   └── package.ts   # 插件状态
│   ├── api/            # API接口
│   ├── utils/          # 工具函数
│   └── static/         # 静态资源
├── package.json
├── vite.config.ts
└── tsconfig.json
```

## 开发环境

### 安装依赖
```bash
npm install
```

### 开发运行
```bash
npm run dev
```

### 构建发布
```bash
npm run build
```

## 功能特性

### ✅ 已实现
- [x] 项目架构搭建
- [x] 主页布局和导航
- [x] 分类标签切换
- [x] 插件列表展示
- [x] 插件卡片组件
- [x] 排序功能
- [x] 推荐功能
- [x] 状态管理 (Pinia)
- [x] API接口封装
- [x] TypeScript支持

### 🚧 待实现
- [ ] 插件详情页
- [ ] 评论系统
- [ ] 下拉刷新优化
- [ ] 上拉加载更多
- [ ] 错误处理优化
- [ ] 缓存策略
- [ ] 性能优化

## 技术栈

- **框架**: uni-app + Vue 3
- **语言**: TypeScript
- **状态管理**: Pinia
- **构建工具**: Vite
- **样式**: SCSS

## 开发指南

### 页面开发
1. 在 `src/pages/` 下创建页面目录
2. 在 `src/pages.json` 中配置页面路由
3. 使用 Vue 3 Composition API 开发

### 组件开发
1. 在 `src/components/` 下创建组件目录
2. 使用 TypeScript 定义 Props 和 Emits
3. 遵循 uni-app 组件规范

### 状态管理
1. 使用 Pinia 管理全局状态
2. 按功能模块划分 Store
3. 支持 TypeScript 类型推导

### API接口
1. 统一在 `src/api/` 中定义接口
2. 使用 TypeScript 定义数据类型
3. 统一错误处理和响应格式

## 部署说明

### 微信小程序
1. 在微信开发者工具中导入项目
2. 配置 `src/manifest.json` 中的 appid
3. 构建并上传代码

### 配置要求
- Node.js >= 16
- 微信开发者工具
- uni-app 开发环境

## 注意事项

1. **API地址**: 需要配置正确的后端API地址
2. **小程序权限**: 需要配置网络请求域名白名单
3. **图标资源**: 需要准备 tabBar 图标资源
4. **测试**: 建议在真机上测试完整功能

## 下一步计划

1. 完善插件详情页面
2. 实现完整的评论系统
3. 添加搜索功能
4. 优化用户体验
5. 性能优化和缓存策略