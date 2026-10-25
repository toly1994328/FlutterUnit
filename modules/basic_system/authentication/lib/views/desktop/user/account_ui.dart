import 'package:flutter/material.dart';

/// 账号页共用的轻边线面板。
class AccountSurface extends StatelessWidget {
  const AccountSurface(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(18)});

  /// 面板承载的内容。
  final Widget child;

  /// 面板内边距。
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: colors.outlineVariant.withValues(alpha: 0.45))),
        padding: padding,
        child: child);
  }
}

/// 面板标题与轻量导航链接。
class AccountHeading extends StatelessWidget {
  const AccountHeading(
      {super.key, required this.title, this.action, this.onAction, this.icon});

  /// 标题前的功能图标。
  final IconData? icon;

  /// 面板标题。
  final String title;

  /// 右侧操作的文字。
  final String? action;

  /// 标题操作回调。
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      if (icon != null) ...<Widget>[
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
      ],
      Expanded(
          child: Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
      if (action != null)
        TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
                padding: const EdgeInsets.only(left: 8),
                minimumSize: const Size(0, 30),
                textStyle: const TextStyle(fontSize: 12)),
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(action!),
              const SizedBox(width: 2),
              const Icon(Icons.chevron_right_rounded, size: 15),
            ])),
    ]);
  }
}

/// 简洁的入口行，保留鼠标和键盘交互。
class AccountEntry extends StatelessWidget {
  const AccountEntry(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap,
      this.description});

  /// 入口的语义图标。
  final IconData icon;

  /// 入口名称。
  final String label;

  /// 点击后执行的导航操作。
  final VoidCallback onTap;

  /// 可选的功能说明。
  final String? description;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              child: Row(children: <Widget>[
                Icon(icon, color: colors.primary, size: 21),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(label,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                      if (description != null) ...<Widget>[
                        const SizedBox(height: 5),
                        Text(description!,
                            style: TextStyle(
                                fontSize: 11, color: colors.onSurfaceVariant),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis)
                      ],
                    ])),
                const SizedBox(width: 6),
                Icon(Icons.chevron_right_rounded,
                    color: colors.onSurfaceVariant, size: 16),
              ])),
        ));
  }
}
