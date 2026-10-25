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

/// 四个知识入口共享胶囊选中态。
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

typedef _KnowledgeHeading = ({
  String title,
  String subtitle,
  IconData icon,
  Color accent,
});

/// 用主题图标和简短说明区分各知识入口，保持顶部高度一致。
class MobileKnowledgeTitle extends StatelessWidget {
  /// 当前知识入口，文库搜索栏由父页面单独构建。
  final int index;

  const MobileKnowledgeTitle({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final _KnowledgeHeading heading = switch (index) {
      1 => (
          title: context.l10n.knowledgeTabLayout,
          subtitle: context.l10n.knowledgeLayoutSubtitle,
          icon: Icons.dashboard_customize_outlined,
          accent: const Color(0xff3979cf),
        ),
      2 => (
          title: context.l10n.paintCollection,
          subtitle: context.l10n.knowledgePaintSubtitle,
          icon: Icons.draw_outlined,
          accent: const Color(0xff8560cf),
        ),
      _ => (
          title: context.l10n.knowledgeTabAlgo,
          subtitle: context.l10n.knowledgeAlgoSubtitle,
          icon: Icons.stacked_bar_chart_rounded,
          accent: const Color(0xffb87924),
        ),
    };
    final Color accent = colors.brightness == Brightness.dark
        ? Color.lerp(heading.accent, Colors.white, .3)!
        : heading.accent;
    return Row(children: <Widget>[
      Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: .09),
          border: Border.all(color: accent.withValues(alpha: .12)),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(heading.icon, size: 24, color: accent),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(heading.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface)),
            const SizedBox(height: 3),
            Text(heading.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11,
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: colors.onSurfaceVariant)),
          ],
        ),
      ),
    ]);
  }
}
