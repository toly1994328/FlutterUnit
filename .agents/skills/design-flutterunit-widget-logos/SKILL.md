---
name: design-flutterunit-widget-logos
description: Design, review, integrate, and validate native SVG logos for FlutterUnit widgets. Use when creating or revising files in assets/images/widgets, choosing visual metaphors for Flutter components, auditing Widget Logo coverage, updating the widgetLogo mapping, checking SVG consistency, or reviewing logos in the local SVG Gallery.
---

# FlutterUnit Widget Logo 设计

为 FlutterUnit 建立可识别、可维护的组件图鉴。输出原生 SVG，不以位图描摹或自动矢量化代替正式资产。

## 必读上下文

开始设计或审查前：

1. 完整读取 [视觉规范](references/visual-style.md)。
2. 查看目标组件在 `assets/flutter.db` 中的 ID、星级、关联组件和演示节点。
3. 查看 `assets/images/widgets/` 中同族 Logo，避免只参考单个文件。
4. 涉及覆盖率或现状判断时，运行 `scripts/audit_widget_logos.py`，不要沿用文档中的旧数字。

## 工作流

### 1. 理解组件语义

- 优先表达组件最独特的行为、布局关系或视觉结果。
- 在“真实控件缩影、结构示意、内容样例”三种表达方式中选择一种主方式。
- 同族组件复用基础轮廓，通过一个关键符号体现差异。
- 不要只根据组件英文名画一个泛化图标；检查演示代码和 Flutter 语义。

### 2. 设计 SVG

- 使用 `128 × 128` 画布和 `viewBox="0 0 128 128"`。
- 保留透明外层画布，延续白色圆角标本卡和轻描边。
- 将主要信息控制在中央安全区，确保 80px 列表尺寸仍可辨认。
- 使用现有蓝、靛青、淡紫主色，最多增加一种语义强调色。
- 优先使用基础 SVG 元素；避免嵌入位图、外链资源、脚本、复杂滤镜和无必要的文字。
- 为 `defs` 中的渐变、剪裁等 ID 加入组件名前缀，避免合并或内联时冲突。
- 使用 `apply_patch` 创建或修改 `assets/images/widgets/<WidgetName>.svg`。

### 3. 接入运行链路

- 确认数据库组件英文名与文件名大小写完全一致。
- 当前运行时仍由 `modules/widget_system/widget_ui/lib/src/view/widget_tiled/widget_logo.dart` 中的 `widgetLogo` 显式映射；新增正式 Logo 时同步添加映射。
- 不要更新 `modules/widget_system/widget_module/lib/views/components/widget_logo_map.dart` 的重复旧映射；除非任务明确要求清理它。
- 保留 `Widget.svg` 作为未覆盖组件的运行时回退。

### 4. 自动校验

从仓库根目录运行：

```powershell
python .agents/skills/design-flutterunit-widget-logos/scripts/audit_widget_logos.py
```

校验单个组件：

```powershell
python .agents/skills/design-flutterunit-widget-logos/scripts/audit_widget_logos.py --component Image
```

必须修复目标组件的以下问题：文件为空、XML 无法解析、根元素不是 SVG、画布不是 128、`viewBox` 不一致、数据库无对应组件、文件存在但映射遗漏。

### 5. 视觉验收

- 启动 `.local/svg-gallery/server.py`；若工具不存在，先依据项目文档或现状建立等价预览。
- 同时检查“有 SVG”总览和目标组件的单独卡片。
- 至少验证列表 80px、桌面详情 120px、浅色背景和主题色背景。
- 将目标 Logo 与同族 Logo 并排检查视觉重量、留白、对比度和辨识度。
- 视觉验收不能被 XML 校验或截图尺寸检查替代。

## 变更边界

- “设计”默认允许修改目标 SVG；“接入”才修改 Dart 映射。
- 不顺手重绘其他组件，不覆盖用户正在修改的资产。
- 不因 Logo 工作修改数据库组件 ID 或英文名。
- 不把 Gallery、本地预览截图或临时导出物提交为产品资产。
- 若用户要求多个 Logo，优先小批量完成并验收，再继续扩展。

## 交付要求

最终说明：

- 设计或修改了哪些组件及其核心隐喻；
- SVG 和映射的准确路径；
- 自动校验结果与最新覆盖率；
- 80px、120px 和总览验收情况；
- 仍需人工判断的视觉取舍。

