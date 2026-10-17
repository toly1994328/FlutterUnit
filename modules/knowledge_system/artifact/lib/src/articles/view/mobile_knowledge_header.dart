import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

/// 手机知识模块共用的浅色阅读画布，深色模式沿用应用主题。
ThemeData mobileKnowledgeTheme(ThemeData base) {
  if (base.brightness == Brightness.dark) return base;
  final ColorScheme colors = base.colorScheme.copyWith(
      primary: const Color(0xff3e4fc1),
      surface: Colors.white,
      onSurface: const Color(0xff111827),
      onSurfaceVariant: const Color(0xff667085),
      surfaceContainer: const Color(0xfff4f8fc),
      outlineVariant: const Color(0xffe1e7ef));
  return base.copyWith(
      colorScheme: colors,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.surfaceContainer,
      textTheme: base.textTheme.apply(fontFamily: 'Roboto'),
      primaryTextTheme: base.primaryTextTheme.apply(fontFamily: 'Roboto'),
      listTileTheme: base.listTileTheme.copyWith(tileColor: colors.surface));
}

/// 四个知识入口共享胶囊选中态，不再使用渐变抬头和二级说明。
class MobileKnowledgeTabs extends StatelessWidget
    implements PreferredSizeWidget {
  /// 与知识内容页保持同步的标签控制器。
  final TabController controller;
  const MobileKnowledgeTabs({super.key, required this.controller});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return TabBar(
        controller: controller,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        labelPadding: const EdgeInsets.symmetric(horizontal: 2),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        dividerColor: Colors.transparent,
        labelColor: colors.primary,
        unselectedLabelColor: colors.onSurfaceVariant,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        unselectedLabelStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        indicator: BoxDecoration(
            color: colors.primary.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(14)),
        tabs: <Widget>[
          Tab(text: context.l10n.knowledgeTabToly),
          Tab(text: context.l10n.knowledgeTabLayout),
          Tab(text: context.l10n.paintCollection),
          Tab(text: context.l10n.knowledgeTabAlgo),
        ]);
  }
}
