# FlutterUnit 架构设计文档

## 项目概述

FlutterUnit 是一个全平台的 Flutter 组件展示和学习应用，支持 Android、iOS、Web、Windows、macOS 和 Linux 平台。项目采用模块化架构，提供了 300+ Flutter 组件的详细展示、代码示例和交互演示。

## 技术栈

- **框架**: Flutter 3.35.1
- **状态管理**: flutter_bloc (BLoC 模式)
- **路由管理**: go_router
- **数据库**: SQLite (本地数据存储)
- **网络请求**: dio
- **国际化**: flutter_localizations
- **UI组件**: 自研 TolyUI 组件库

## 整体架构

### 分层架构

```
┌─────────────────────────────────────┐
│           Presentation Layer         │  ← UI层 (Views/Pages)
├─────────────────────────────────────┤
│           Business Logic Layer       │  ← 业务逻辑层 (BLoC)
├─────────────────────────────────────┤
│           Repository Layer           │  ← 仓储层 (Repository)
├─────────────────────────────────────┤
│           Data Source Layer          │  ← 数据源层 (Database/API)
└─────────────────────────────────────┘
```

### 模块化设计

```
FlutterUnit/
├── modules/
│   ├── basic_system/           # 基础系统模块
│   │   ├── app/               # 应用核心配置
│   │   ├── app_update/        # 应用更新
│   │   ├── authentication/    # 用户认证
│   │   ├── components/        # 通用组件
│   │   ├── l10n/             # 国际化
│   │   ├── storage/          # 数据存储
│   │   ├── toly_ui/          # UI组件库
│   │   └── utils/            # 工具类
│   ├── widget_system/         # 组件系统模块
│   │   ├── widget_module/     # 组件业务逻辑
│   │   ├── widget_repository/ # 组件数据仓储
│   │   └── widget_ui/        # 组件UI展示
│   ├── knowledge_system/      # 知识系统模块
│   │   ├── algorithm/        # 算法相关
│   │   ├── artifact/         # 工件管理
│   │   ├── awesome/          # 精选内容
│   │   ├── layout/           # 布局相关
│   │   └── note/             # 笔记功能
│   ├── painting_system/       # 绘制系统模块
│   │   └── draw_system/      # 自定义绘制
│   └── tools_system/          # 工具系统模块
│       └── treasure_tools/   # 实用工具集
└── lib/
    ├── src/
    │   ├── navigation/       # 路由导航
    │   ├── l10n/            # 本地化
    │   └── starter/         # 应用启动
    └── main.dart
```

## 核心架构组件

### 1. 应用启动器 (FxApplication)

```dart
class FxApplication with FxStarter<AppConfig> {
  @override
  Widget get app => const AppBlocProvider(child: FlutterUnit3());
  
  @override
  AppStartRepository<AppConfig> get repository => const FlutterUnitStartRepo();
}
```

**职责**:
- 应用启动流程管理
- 全局配置初始化
- 错误处理和监控

### 2. 状态管理 (BLoC 模式)

```
Event → BLoC → State → UI
  ↑                    ↓
  └── User Interaction ┘
```

**主要 BLoC**:
- `AppConfigBloc`: 应用配置管理
- `WidgetsBloc`: 组件数据管理
- `CategoryBloc`: 分类管理
- `LikeWidgetBloc`: 收藏功能

### 3. 路由架构

```dart
GoRoute(
  path: AppRoute.home.path,
  routes: [
    if (kAppEnv.isDesktopUI)
      ShellRoute(
        builder: (_, __, Widget child) => AppDeskNavigation(content: child),
        routes: body,
      ),
    if (!kAppEnv.isDesktopUI) ...body,
  ],
)
```

**特点**:
- 支持桌面端和移动端不同导航
- 声明式路由配置
- 深度链接支持

### 4. 数据层架构

#### Repository 模式

```dart
abstract class WidgetRepository {
  Future<List<WidgetModel>> loadWidgets();
  Future<WidgetModel?> findWidget(int id);
  Future<List<NodeModel>> loadNodeByWidgetId(int widgetId);
}
```

**实现层**:
- `WidgetDbRepository`: 数据库实现
- `MemoryWidgetRepository`: 内存缓存实现

#### 数据库设计

**核心表**:
- `widget`: Widget基本信息
- `node`: 示例代码节点
- `category`: Widget分类

详见: [数据表结构总览](../modules/widget_system/widget_repository/doc/tables_overview.md)

## 平台适配

### 平台检测

```dart
class kAppEnv {
  static bool get isWeb;
  static bool get isDesktopUI;
  static bool get isMobile;
}
```

### 响应式设计

- **移动端**: 底部导航 + 侧滑菜单
- **桌面端**: 侧边栏导航 + 多窗口布局
- **Web端**: 响应式布局适配

## 核心功能

### 1. 组件展示系统

- 300+ Flutter组件收录
- 实时代码演示
- 交互式组件体验
- 组件关联跳转

### 2. 搜索与过滤

- 组件名称搜索
- 星级过滤
- 分类筛选

### 3. 收藏系统

- 自定义收藏集
- 收藏集管理
- 批量操作

### 4. 主题系统

- 明暗主题切换
- 8种预设颜色主题
- 6种字体选择
- 自定义代码高亮

## 性能优化

### 1. 数据缓存
- 内存缓存: 热点数据常驻内存
- 数据库缓存: 本地SQLite存储

### 2. 懒加载
- 路由懒加载: 按需加载页面
- 组件懒加载: 滚动时动态加载

### 3. 构建优化
- 代码分割: 模块化打包
- 资源优化: 图片压缩、字体子集化

## 构建与部署

### 多平台构建

```bash
# Android
flutter build apk --target-platform --split-per-abi

# iOS  
flutter build ios

# Web
flutter build web

# Desktop
flutter build windows
flutter build macos
flutter build linux
```

### 发布渠道

- Android: APK 直接下载
- iOS: App Store
- Web: 在线访问
- Desktop: 可执行文件下载

## 开发规范

### 代码规范
- 遵循 Dart 官方代码规范
- 使用 `flutter_lints` 进行代码检查

### 模块规范
- 每个模块独立的 `pubspec.yaml`
- 清晰的模块边界和依赖关系

### 测试规范
- 单元测试覆盖核心业务逻辑
- Widget测试验证UI行为