import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'reading_rule_decoration.dart';

/// 阅读区独立排版，避免展示字体影响长文和代码的可读性。
abstract final class ReadingTheme {
  /// 中文优先使用系统无衬线字体，保留跨平台回退。
  static const List<String> fontFallback = <String>[
    'Microsoft YaHei UI',
    'Microsoft YaHei',
    'PingFang SC',
    'Noto Sans CJK SC',
    'sans-serif',
  ];

  static String fontFamily(TargetPlatform platform) => switch (platform) {
        TargetPlatform.windows => 'Noto Sans SC',
        TargetPlatform.macOS || TargetPlatform.iOS => 'PingFang SC',
        _ => 'Roboto',
      };

  /// 只覆盖阅读页的文字系统，颜色和主题切换沿用应用配置。
  static ThemeData theme(ThemeData base) {
    final String family = fontFamily(base.platform);
    final bool dark = base.brightness == Brightness.dark;
    final ColorScheme colors = base.colorScheme.copyWith(
        primary: dark ? const Color(0xffA5B4FC) : const Color(0xff6366F1),
        surface: dark ? const Color(0xff181B26) : const Color(0xffF8F9FD),
        onSurface: dark ? const Color(0xffE4E4E7) : const Color(0xff18181B),
        onSurfaceVariant:
            dark ? const Color(0xffA1A1AA) : const Color(0xff6B7280),
        outlineVariant:
            dark ? const Color(0xff333747) : const Color(0xffE7E8F0));
    return base.copyWith(
        colorScheme: colors,
        textTheme: base.textTheme
            .apply(fontFamily: family, fontFamilyFallback: fontFallback),
        appBarTheme: base.appBarTheme.copyWith(
            titleTextStyle: TextStyle(
                fontFamily: family,
                fontFamilyFallback: fontFallback,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colors.onSurface)));
  }

  /// 完整定义各级标题、列表、行内代码、引用与表格的层级和间距。
  static MarkdownStyleSheet markdown(BuildContext context, double fontSize) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;
    final bool dark = colors.brightness == Brightness.dark;
    final TextStyle body = TextStyle(
        fontFamily: fontFamily(theme.platform),
        fontFamilyFallback: fontFallback,
        fontSize: fontSize,
        letterSpacing: 0,
        height: 1.8,
        color: colors.onSurface);
    TextStyle heading(double extra) => body.copyWith(
        fontSize: fontSize + extra,
        height: 1.6,
        fontWeight: FontWeight.w700,
        color: colors.onSurface);
    final MarkdownStyleSheet style =
        MarkdownStyleSheet.fromTheme(theme).copyWith(
      p: body,
      a: TextStyle(color: colors.primary),
      strong: TextStyle(fontWeight: FontWeight.w700, color: colors.primary),
      h1: heading(8),
      h2: heading(6),
      h3: heading(4),
      h4: heading(2),
      h5: heading(1),
      h6: heading(0),
      h1Padding: const EdgeInsets.only(top: 8),
      h2Padding: const EdgeInsets.only(top: 8),
      h3Padding: const EdgeInsets.only(top: 8),
      h4Padding: const EdgeInsets.only(top: 8),
      h5Padding: const EdgeInsets.only(top: 8),
      h6Padding: const EdgeInsets.only(top: 8),
      blockSpacing: 8,
      listIndent: 22,
      listBullet: body.copyWith(height: 1.3),
      listBulletPadding: const EdgeInsets.only(right: 6),
      code: TextStyle(
          fontFamily: 'Consolas',
          fontFamilyFallback: const <String>['Menlo', 'monospace'],
          fontSize: fontSize * .85,
          letterSpacing: 0,
          height: 1.65,
          color: colors.onSurface,
          backgroundColor: colors.primary.withValues(alpha: dark ? .16 : .08)),
      // 代码块由专用组件绘制，避免默认 pre 容器再次添加背景和边距。
      codeblockPadding: EdgeInsets.zero,
      codeblockDecoration: const BoxDecoration(),
      blockquote: body.copyWith(color: colors.onSurfaceVariant),
      blockquotePadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      blockquoteDecoration: BoxDecoration(
          color: colors.primary.withValues(alpha: dark ? .12 : .04),
          border: Border(left: BorderSide(color: colors.primary, width: 3))),
      horizontalRuleDecoration: ReadingRuleDecoration(
          color: colors.outlineVariant.withValues(alpha: .85)),
      tableHead:
          body.copyWith(fontSize: fontSize - 1, fontWeight: FontWeight.w600),
      tableBody: body.copyWith(fontSize: fontSize - 1),
      tableHeadAlign: TextAlign.left,
      tableBorder: TableBorder(
          horizontalInside:
              BorderSide(color: colors.outlineVariant, width: .5)),
      tableColumnWidth: const IntrinsicColumnWidth(),
      tableCellsPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      tableCellsDecoration: const BoxDecoration(color: Colors.transparent),
      tablePadding: const EdgeInsets.only(bottom: 8),
    );
    return style;
  }
}
