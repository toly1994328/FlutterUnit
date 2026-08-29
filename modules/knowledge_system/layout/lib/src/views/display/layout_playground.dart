import 'package:flutter/material.dart';

import '../../bloc/display_logic.dart';
import 'playground_bottom_bar.dart';
import 'playground_top_bar.dart';

class LayoutPlayGround extends StatelessWidget {
  /// 当前路由构建的主体内容。
  final Widget content;

  /// 是否使用移动端详情布局。
  final bool mobile;

  const LayoutPlayGround({
    super.key,
    required this.content,
    this.mobile = false,
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
        body: mobile ? _buildMobileBody(context) : _buildDesktopBody(context),
      ),
    );
  }

  Widget _buildDesktopBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const PlaygroundTopBar(),
        const Divider(),
        Expanded(child: _buildExampleFrame(context)),
        const Divider(),
        const PlaygroundBottomBar(),
      ],
    );
  }

  /// 移动端限制案例区高度，避免竖屏时演示画布占满剩余空间。
  Widget _buildMobileBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double frameHeight = constraints.maxHeight * 0.68;
        return ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const PlaygroundTopBar(mobile: true),
            SizedBox(
              height: frameHeight,
              child: _buildExampleFrame(context),
            ),
            const PlaygroundBottomBar(mobile: true),
          ],
        );
      },
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
      padding: EdgeInsets.all(mobile ? 12 : 24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:
              mobile ? Theme.of(context).colorScheme.surfaceContainerLow : null,
          border: mobile
              ? null
              : Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
          borderRadius: mobile ? BorderRadius.circular(14) : null,
        ),
        child: ClipRRect(
          borderRadius: mobile ? BorderRadius.circular(14) : BorderRadius.zero,
          child: content,
        ),
      ),
    );
  }
}
