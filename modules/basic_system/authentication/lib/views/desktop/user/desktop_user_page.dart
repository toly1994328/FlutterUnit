import 'package:flutter/material.dart';

import '../../mobile/user/user_page.dart';

/// 在桌面窗口中承载用户中心，并限制内容宽度以保持信息密度。
class DesktopUserPage extends StatelessWidget {
  const DesktopUserPage({
    super.key,
    this.child = const UserPage(),
  });

  /// 用户中心在桌面端允许使用的最大宽度。
  static const double maxContentWidth = 960;

  /// 由桌面容器承载的用户中心内容。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return ColoredBox(
      color: backgroundColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}
