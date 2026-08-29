import 'package:flutter/material.dart';

/// 为工具工作台提供紧凑、低装饰的桌面控件主题。
ThemeData buildToolboxDesktopTheme(BuildContext context) {
  final ThemeData source = Theme.of(context);
  final bool isDark = source.brightness == Brightness.dark;
  final Color accentColor =
      isDark ? const Color(0xff69a7ff) : const Color(0xff2468b4);
  final Color surfaceColor =
      isDark ? const Color(0xff1e2024) : const Color(0xffffffff);
  final Color subtleSurfaceColor =
      isDark ? const Color(0xff25292f) : const Color(0xfff5f7fa);
  final Color borderColor =
      isDark ? const Color(0xff454b54) : const Color(0xffd3d8df);
  final ColorScheme colors = source.colorScheme.copyWith(
    primary: accentColor,
    secondary: accentColor,
    surface: surfaceColor,
    surfaceContainerLow: subtleSurfaceColor,
    surfaceContainer: subtleSurfaceColor,
    outline: isDark ? const Color(0xff69717c) : const Color(0xff9aa3ad),
    outlineVariant: borderColor,
  );
  const BorderRadius controlRadius = BorderRadius.all(Radius.circular(3));
  return source.copyWith(
    colorScheme: colors,
    primaryColor: accentColor,
    scaffoldBackgroundColor: surfaceColor,
    splashFactory: NoSplash.splashFactory,
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    dividerColor: colors.outlineVariant,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      border: OutlineInputBorder(
        borderRadius: controlRadius,
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: controlRadius,
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: controlRadius,
        borderSide: BorderSide(color: colors.primary),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 34),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        shape: const RoundedRectangleBorder(borderRadius: controlRadius),
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(0, 34),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        shape: const RoundedRectangleBorder(borderRadius: controlRadius),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 34),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        side: BorderSide(color: colors.outlineVariant),
        shape: const RoundedRectangleBorder(borderRadius: controlRadius),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(0, 30),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: const RoundedRectangleBorder(borderRadius: controlRadius),
      ),
    ),
    cardTheme: source.cardTheme.copyWith(
      color: surfaceColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: controlRadius,
        side: BorderSide(color: colors.outlineVariant),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size(28, 28),
        maximumSize: const Size(28, 28),
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: controlRadius),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accentColor,
      selectionColor: accentColor.withValues(alpha: 0.2),
      selectionHandleColor: accentColor,
    ),
    tooltipTheme: source.tooltipTheme.copyWith(
      waitDuration: const Duration(milliseconds: 350),
      showDuration: const Duration(seconds: 2),
      textStyle: const TextStyle(fontSize: 11, color: Colors.white),
      decoration: const BoxDecoration(color: Color(0xff30343b)),
    ),
  );
}
