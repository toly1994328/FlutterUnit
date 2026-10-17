import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tolyui_message/tolyui_message.dart';

/// 全局消息展示参数：移动端从底部出现，桌面端保持顶部出现。
TolyMessageShowTheme get messageShowTheme => TolyMessageShowTheme(
      duration: const Duration(seconds: 3),
      animaDuration: const Duration(milliseconds: 250),
      messagePosition: kIsDesk ? MessagePosition.top : MessagePosition.bottom,
      offset: const Offset(0, 16),
      gap: 12,
    );

ThemeData darkTheme(AppConfig state) {
  final ColorScheme colors = unitColorScheme(
    activeColor: state.themeColor.color,
    brightness: Brightness.dark,
  );

  SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xff181818));

  final ThemeData theme = ThemeData(
    extensions: [messageShowTheme],
    colorScheme: colors,
    scaffoldBackgroundColor: colors.surfaceContainer,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: SlidePageTransitionsBuilder(),
      TargetPlatform.iOS: SlidePageTransitionsBuilder(),
      TargetPlatform.macOS: FadePageTransitionsBuilder(),
      TargetPlatform.windows: FadePageTransitionsBuilder(),
      TargetPlatform.linux: FadePageTransitionsBuilder(),
    }),
    tabBarTheme: const TabBarThemeData(
      dividerColor: Colors.transparent,
    ),
    fontFamily: kAppEnv.isWindows
        ? WindowsFontController.instance.resolveFamily(state.fontFamily)
        : state.fontFamily,
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: colors.primary,
    listTileTheme: ListTileThemeData(
      tileColor: colors.surface,
      textColor: colors.onSurface,
    ),
    dialogTheme: const DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    ///设置选中的文本颜色
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: colors.primary.withValues(alpha: 0.3),
    ),
    appBarTheme: AppBarTheme(
        systemOverlayStyle: overlayStyle,
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.surface,
        iconTheme: IconThemeData(color: colors.onSurfaceVariant),
        titleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colors.onSurface)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: colors.onPrimary,
      backgroundColor: colors.primary,
    ),
    dividerTheme: DividerThemeData(
      color: colors.outlineVariant,
      space: px1,
      thickness: divHeight,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.surface,
      selectedItemColor: colors.primary,
    ),
  );
  return _zeroLetterSpacing(theme);
}

double get divHeight {
  if (kAppEnv.isAndroid) {
    return 0.2;
  }
  return px1;
}

ThemeData lightTheme(AppConfig state) {
  final ColorScheme colors = unitColorScheme(
    activeColor: state.themeColor.color,
    brightness: Brightness.light,
  );
  SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent);

  final String fontFamily =
      WindowsFontController.instance.resolveFamily(state.fontFamily);

  final ThemeData theme = ThemeData(
    extensions: [messageShowTheme],
    colorScheme: colors,
    fontFamily: kAppEnv.isWindows ? fontFamily : '',
    primaryColor: colors.primary,
    scaffoldBackgroundColor: colors.surfaceContainer,
    useMaterial3: true,
    // Android 使用 Material3
    chipTheme:
        const ChipThemeData(padding: EdgeInsets.symmetric(horizontal: 10)),
    listTileTheme: ListTileThemeData(
      tileColor: colors.surface,
      textColor: colors.onSurface,
    ),
    dialogTheme: const DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    ///设置选中的文本颜色
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: colors.primary.withValues(alpha: 0.3),
    ),
    dividerTheme: DividerThemeData(
      color: colors.outlineVariant,
      space: px1,
      thickness: divHeight,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: SlidePageTransitionsBuilder(),
      TargetPlatform.iOS: SlidePageTransitionsBuilder(),
      TargetPlatform.macOS: FadePageTransitionsBuilder(),
      TargetPlatform.windows: FadePageTransitionsBuilder(),
      TargetPlatform.linux: FadePageTransitionsBuilder(),
    }),
    tabBarTheme: TabBarThemeData(
      dividerColor: Colors.transparent,
      // labelStyle: TextStyle(fontFamily: fontFamily),
      // unselectedLabelStyle: TextStyle(fontFamily: fontFamily),

      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return states.contains(WidgetState.focused)
              ? null
              : Colors.transparent;
        },
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.surface,
      selectedItemColor: colors.primary,
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: overlayStyle,
      elevation: 0,
      centerTitle: true,
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: colors.onSurface,
        fontFamily: fontFamily,
      ),
    ),
  );
  return _zeroLetterSpacing(theme);
}

/// 统一深浅主题的正文、标题、按钮和强调文字字间距。
ThemeData _zeroLetterSpacing(ThemeData theme) {
  // 直接覆盖字距，避免未本地化的基础样式中 letterSpacing 为空时触发断言。
  const TextStyle style = TextStyle(letterSpacing: 0);
  const TextTheme spacing = TextTheme(
      displayLarge: style,
      displayMedium: style,
      displaySmall: style,
      headlineLarge: style,
      headlineMedium: style,
      headlineSmall: style,
      titleLarge: style,
      titleMedium: style,
      titleSmall: style,
      bodyLarge: style,
      bodyMedium: style,
      bodySmall: style,
      labelLarge: style,
      labelMedium: style,
      labelSmall: style);
  return theme.copyWith(
      textTheme: theme.textTheme.merge(spacing),
      primaryTextTheme: theme.primaryTextTheme.merge(spacing));
}
