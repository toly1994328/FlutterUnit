import 'package:app/app.dart';
import 'package:flutter/material.dart';

import 'catalog.dart';

/// 当前工具的桌面标题栏。
class ToolboxHeader extends StatelessWidget {
  /// 当前打开的工具。
  final DeveloperTool tool;

  /// 创建工具标题栏。
  const ToolboxHeader({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return DragToMoveWrapper(
      child: ColoredBox(
        color: isDark ? const Color(0xff24272c) : Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 58,
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  _ToolTab(tool: tool),
                  const Spacer(),
                  const WindowButtons(),
                ],
              ),
            ),
            Divider(
                height: 1, color: Theme.of(context).colorScheme.outlineVariant),
            SizedBox(
              height: 104,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    _ToolIdentity(tool: tool),
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
}

class _ToolTab extends StatelessWidget {
  /// 当前工具。
  final DeveloperTool tool;

  /// 创建当前工具标签。
  const _ToolTab({required this.tool});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [BoxShadow(color: primaryColor, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Icon(tool.icon, size: 17, color: primaryColor),
          const SizedBox(width: 9),
          Text(tool.label,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(width: 14),
          Icon(Icons.close_rounded,
              size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ],
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
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Icon(tool.icon, color: primaryColor, size: 22),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tool.label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline_rounded, size: 15, color: textColor),
            const SizedBox(width: 6),
            Text('仅在本地解码，不会上传或保存',
                style: TextStyle(fontSize: 11, color: textColor)),
          ],
        ),
      ),
    );
  }
}
