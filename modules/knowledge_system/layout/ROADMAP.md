# FlutterUnit 布局宝库建设计划

本计划用于持续扩充“知识宝库 → 布局宝库”。目标不是收集孤立 Widget Demo，而是通过可交互、可对比、可阅读源码的案例，系统解释 Flutter 的约束传递、尺寸计算、父级定位和滚动布局。

关联文档：[布局宝库实现说明](README.md)。

## 一、建设原则

每个主题应满足：

- 聚焦一个明确的布局问题，不把多个知识点混在同一帧；
- 优先使用“错误表现 → 原理解释 → 正确方案”的渐进帧；
- 可以交互的属性应提供操作面板，并即时反馈布局变化；
- 标题、说明和源码路径完整，能够从总览和左侧菜单进入；
- 同时检查常规窗口、窄窗口、亮色和暗色模式；
- 菜单路径、路由和 `kDisplayMap` 映射保持一致。

## 二、阶段总览

| 阶段 | 主题 | 计划主题数 | 建议优先级 | 目标 |
|---|---|---:|---:|---|
| P0 | 现有体验收口 | — | 最高 | 稳定导航、主题和测试基础 |
| P1 | 约束与 Flex | 6 | 最高 | 补齐最常见布局误区 |
| P2 | 尺寸与适配 | 5 | 高 | 建立响应式布局能力 |
| P3 | 滚动与 Sliver | 7 | 高 | 从基础滚动升级到复杂滚动 |
| P4 | 高级与自定义布局 | 5 | 中 | 解释 Flutter 布局扩展机制 |
| P5 | 实战布局方案 | 8 | 中 | 沉淀可以直接参考的页面结构 |

## 三、分阶段计划

### P0：现有体验收口

目标：先让现有 15 条路径、22 个演示帧具备可靠的扩展基础。

- [ ] 提取菜单和内容映射共用的路径常量，减少字符串拼写错误；
- [ ] 为上一页、下一页增加明确的禁用状态；
- [ ] 完成所有现有案例的亮色、暗色主题适配；
- [ ] 校验所有 `DisplayFrame.src` 对应的仓库文件存在；
- [ ] 为布局总览补充主题搜索；
- [ ] 增加总览条目点击和默认 `/home` 路由的 Widget 测试；
- [ ] 确认 Windows、macOS 和窄窗口下没有布局溢出。

验收标准：现有路径全部可达，目标文件静态分析无问题，配置一致性测试通过，总览与案例页在亮暗主题下均可读。

### P1：约束与 Flex

目标：覆盖 Flutter 日常开发中最常见的尺寸、空间分配和溢出问题。

状态：首版已完成，共新增 2 条主题路径、10 个演示帧。

#### 1. Expanded / Flexible / Spacer

- [x] `Expanded` 填满剩余空间；
- [x] 多个 `Expanded` 的 `flex` 比例；
- [x] `Flexible.loose` 与 `FlexFit.tight` 对比；
- [x] `Spacer` 实现弹性间距；
- [x] Row 子组件总宽超限的溢出案例；
- [ ] 文本、按钮和输入框组合的正确处理方式。

建议路径：`/multi/flex-space`，交互项包含方向、`flex`、`fit` 和子项尺寸。

#### 2. BoxConstraints 家族

- [x] `ConstrainedBox` 追加约束；
- [x] `UnconstrainedBox` 解除父级约束；
- [x] `LimitedBox` 只在无界约束下生效；
- [x] `OverflowBox` 允许子组件超出父级；
- [x] `BoxConstraints.tight/loose/expand` 对比。

建议路径：`/base/constraints`，每帧直接展示当前 `BoxConstraints` 文本。

验收标准：用户能通过案例回答“约束由谁决定、尺寸为何不生效、剩余空间如何分配”。

### P2：尺寸与响应式适配

目标：展示同一界面如何适应不同父级尺寸和窗口宽度。

- [ ] `LayoutBuilder`：按可用宽度切换单栏和双栏；
- [ ] `MediaQuery`：区分窗口信息与局部约束；
- [ ] `FractionallySizedBox`：按父级比例确定尺寸；
- [ ] `AspectRatio`：保持内容宽高比；
- [ ] `FittedBox`：对比 `contain`、`cover`、`scaleDown`；
- [ ] Master–Detail：窄屏切页、宽屏并排；
- [ ] 桌面侧栏：固定、折叠和自动隐藏三种模式。

建议新增一级分类“响应式布局”，路径前缀使用 `/responsive`。

验收标准：所有响应式案例在 400、700、1000 像素宽度附近切换平稳，不出现无限约束和 Flex 溢出。

### P3：滚动与 Sliver

目标：从普通滚动列表推进到可组合的 Sliver 页面。

- [ ] 横向和纵向 `ListView`；
- [ ] `CustomScrollView + SliverList`；
- [ ] `SliverGrid`；
- [ ] `SliverAppBar` 展开与折叠；
- [ ] `SliverPersistentHeader` 分组吸顶；
- [ ] `SliverFillRemaining` 空态与短内容撑满；
- [ ] `NestedScrollView` 联动页签；
- [ ] 嵌套滚动冲突及正确拆解方式；
- [ ] 分页加载、加载态、空态和错误态的布局结构。

建议保留 `/scroll` 前缀，将当前 List、Grid、Page 案例作为入门主题，新增 Sliver 子主题。

验收标准：滚动案例使用独立 `ScrollController` 时正确释放，Scrollbar 与 ScrollView 共用同一控制器，不触发 PrimaryScrollController 异常。

### P4：高级与自定义布局

目标：解释常规布局组件无法满足需求时，Flutter 提供的扩展点。

- [ ] `Baseline`：多字号文字基线对齐；
- [ ] `IntrinsicWidth / IntrinsicHeight`：效果与性能代价；
- [ ] `Table`：列宽策略和单元格对齐；
- [ ] `Flow`：自定义流式排列和动画；
- [ ] `CustomSingleChildLayout`：单子布局委托；
- [ ] `CustomMultiChildLayout`：多子布局 ID 与委托；
- [ ] 自定义 `RenderBox`：最小双子布局示例。

建议新增一级分类“高级布局”，路径前缀使用 `/advanced`。RenderObject 案例放在本阶段最后，避免读者过早进入底层细节。

验收标准：每个高级案例必须说明适用边界、性能成本，以及为什么不能用更简单的组件替代。

### P5：实战布局方案

目标：把前面阶段的知识组合成可以直接迁移到业务页面的结构。

- [ ] 圣杯布局：左右固定、中间自适应；
- [ ] Dashboard：自适应指标卡与图表区域；
- [ ] 设置页：分组列表与宽屏双栏；
- [ ] 聊天页：消息列表、输入区和键盘避让；
- [ ] 瀑布流图片墙；
- [ ] 时间轴；
- [ ] 标签云；
- [ ] 九宫格菜单；
- [ ] 桌面 Master–Detail 管理页；
- [ ] 空态、加载态、错误态共用页面骨架。

建议新增一级分类“实战布局”，路径前缀使用 `/recipes`。每个案例优先展示完整效果，再拆解关键区域。

验收标准：案例应能独立运行，窗口缩放时结构稳定，并在底部说明中列出所组合的基础布局知识。

## 四、建议实施批次

按照每批 2～3 个主题推进，便于及时审查交互和视觉：

1. `Expanded / Flexible / Spacer`、`BoxConstraints`；
2. `LayoutBuilder`、`AspectRatio / FittedBox`；
3. `SliverList / SliverGrid`、`SliverAppBar`；
4. `SliverPersistentHeader`、`NestedScrollView`；
5. `Baseline / Intrinsic`、`Table`；
6. `Flow`、`CustomMultiChildLayout`；
7. 圣杯布局、Master–Detail、Dashboard；
8. 聊天页、设置页、瀑布流。

每批完成后同步更新：

- `navigation/menu/` 中的菜单配置；
- `navigation/router/desk_router.dart` 中的一级分类路由；
- `data/display_map/` 中的主题帧；
- `views/overview/layout_overview.dart` 中的总览条目；
- `test/layout_test.dart` 中的配置一致性测试；
- [布局宝库实现说明](README.md) 中的路径和帧数统计。

## 五、单个主题完成定义

一个主题只有同时满足以下条件才视为完成：

- [ ] 左侧菜单和布局总览均可进入；
- [ ] 路由路径与 `kDisplayMap` 键完全一致；
- [ ] 至少包含一个可运行演示帧；
- [ ] 标题、中文说明和源码路径完整；
- [ ] 上一页、下一页顺序符合教学逻辑；
- [ ] 窄窗口无 RenderFlex 溢出；
- [ ] 亮色和暗色模式均可读；
- [ ] Dart 格式化与目标文件静态分析通过；
- [ ] 配置一致性测试通过；
- [ ] Windows Debug 构建成功。

## 六、近期里程碑

P1 首版已经完成，布局宝库达到 16 条有效路径、31 个演示帧。原“电梯布局”已迁移为独立绘制作品，不再占用布局案例。下一里程碑建议先完成 P0 的主题与导航收口，再进入 P2 的 `LayoutBuilder` 和 `AspectRatio / FittedBox`。
