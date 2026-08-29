import 'package:app/app.dart';
import 'package:flutter/material.dart';

import 'catalog.dart';

typedef ToolTabSelected = void Function(DeveloperTool tool);
typedef ToolTabClosed = void Function(DeveloperTool tool);

/// 多标签工具工作区的桌面标题栏。
class ToolboxHeader extends StatelessWidget {
  /// 当前已打开的工具标签。
  final List<DeveloperTool> tools;

  /// 当前激活的工具。
  final DeveloperTool selectedTool;

  /// 标签选择回调。
  final ToolTabSelected onSelected;

  /// 标签关闭回调。
  final ToolTabClosed onClosed;

  /// 创建工具标题栏。
  const ToolboxHeader({
    super.key,
    required this.tools,
    required this.selectedTool,
    required this.onSelected,
    required this.onClosed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return DragToMoveWrapper(
      child: ColoredBox(
        color: isDark ? const Color(0xff24272c) : Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 38,
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: tools.map(_buildToolTab).toList()),
                    ),
                  ),
                  const WindowButtons(),
                ],
              ),
            ),
            Divider(
                height: 1, color: Theme.of(context).colorScheme.outlineVariant),
            SizedBox(
              height: 62,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    _ToolIdentity(tool: selectedTool),
                    const Spacer(),
                    const _LocalOnlyBadge(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolTab(DeveloperTool tool) {
    return _ToolTab(
      tool: tool,
      selected: tool == selectedTool,
      closeable: tools.length > 1,
      onSelected: onSelected,
      onClosed: onClosed,
    );
  }
}

class _ToolTab extends StatelessWidget {
  /// 当前工具。
  final DeveloperTool tool;

  /// 是否为当前激活标签。
  final bool selected;

  /// 是否允许关闭当前标签。
  final bool closeable;

  /// 标签选择回调。
  final ToolTabSelected onSelected;

  /// 标签关闭回调。
  final ToolTabClosed onClosed;

  /// 创建当前工具标签。
  const _ToolTab({
    required this.tool,
    required this.selected,
    required this.closeable,
    required this.onSelected,
    required this.onClosed,
  });

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff69a7ff)
        : const Color(0xff2468b4);
    final Color borderColor = Theme.of(context).colorScheme.outlineVariant;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        key: ValueKey<String>('tool-tab-${tool.id}'),
        behavior: HitTestBehavior.opaque,
        onTap: () => onSelected(tool),
        child: Container(
          height: 38,
          constraints: const BoxConstraints(minWidth: 88, maxWidth: 148),
          padding: EdgeInsets.only(left: 8, right: closeable ? 3 : 10),
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.surface
                : Colors.transparent,
            border: Border(
              right: BorderSide(color: borderColor),
              bottom: selected
                  ? BorderSide(color: accentColor, width: 2)
                  : BorderSide(color: borderColor),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                tool.icon,
                size: 15,
                color: selected ? accentColor : null,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  tool.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (closeable) _TabCloseButton(tool: tool, onClosed: onClosed),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabCloseButton extends StatelessWidget {
  /// 当前标签对应的工具。
  final DeveloperTool tool;

  /// 标签关闭回调。
  final ToolTabClosed onClosed;

  /// 创建标签关闭按钮。
  const _TabCloseButton({required this.tool, required this.onClosed});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        key: ValueKey<String>('tool-tab-close-${tool.id}'),
        behavior: HitTestBehavior.opaque,
        onTap: () => onClosed(tool),
        child: const SizedBox.square(
          dimension: 18,
          child: Icon(Icons.close_rounded, size: 13),
        ),
      ),
    );
  }
}

class _ToolIdentity extends StatelessWidget {
  /// 当前工具。
  final DeveloperTool tool;

  /// 创建工具标识。
  const _ToolIdentity({required this.tool});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Icon(tool.icon, color: primaryColor, size: 19),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tool.label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 3),
            Text(
              tool.description,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LocalOnlyBadge extends StatelessWidget {
  /// 创建本地处理提示。
  const _LocalOnlyBadge();

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.lock_outline_rounded, size: 14, color: textColor),
        const SizedBox(width: 5),
        Text('本地处理', style: TextStyle(fontSize: 11, color: textColor)),
      ],
    );
  }
}
