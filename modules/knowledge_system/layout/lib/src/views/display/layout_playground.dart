import 'package:flutter/material.dart';

import '../../bloc/display_logic.dart';
import 'playground_bottom_bar.dart';
import 'playground_top_bar.dart';

class LayoutPlayGround extends StatelessWidget {
  /// 当前路由构建的主体内容。
  final Widget content;

  const LayoutPlayGround({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOverview = DisplayScope.of(context).state.router == '/home';
    if (isOverview) {
      return ColoredBox(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff1f2125)
            : Colors.white,
        child: content,
      );
    }
    final ThemeData neutralTheme = _buildNeutralTheme(context);
    return Theme(
      data: neutralTheme,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const PlaygroundTopBar(),
            const Divider(),
            Expanded(child: _buildExampleFrame(context)),
            const Divider(),
            const PlaygroundBottomBar(),
          ],
        ),
      ),
    );
  }

  /// 为布局案例提供不受品牌种子色影响的中性色面板主题。
  ThemeData _buildNeutralTheme(BuildContext context) {
    final ThemeData source = Theme.of(context);
    final bool isDark = source.brightness == Brightness.dark;
    final Color background = isDark ? const Color(0xff1f2125) : Colors.white;
    final Color container =
        isDark ? const Color(0xff282b30) : const Color(0xfff7f8fa);
    final Color outline =
        isDark ? const Color(0xff454950) : const Color(0xffd9dce1);
    final ColorScheme colors = source.colorScheme.copyWith(
      surface: background,
      surfaceContainerLowest: background,
      surfaceContainerLow: container,
      surfaceContainer: container,
      surfaceContainerHigh: container,
      surfaceContainerHighest: container,
      outlineVariant: outline,
    );
    return source.copyWith(
      colorScheme: colors,
      scaffoldBackgroundColor: background,
      cardColor: container,
      dividerColor: outline,
    );
  }

  Widget _buildExampleFrame(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: content,
      ),
    );
  }
}
