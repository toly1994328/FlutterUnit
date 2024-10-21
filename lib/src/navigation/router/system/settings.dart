import 'package:app/app.dart';

GoRoute get settingsRoute => GoRoute(
      path: AppRoute.settings.path,
      builder: (_, __) => const SettingPage(),
      routes: [
        GoRoute(
          path: AppRoute.darkModel.path,
          builder: (_, __) => const ThemeModelSetting(),
        ),
        GoRoute(
          path: AppRoute.codeStyle.path,
          builder: (_, __) => const CodeStyleSettingPage(),
        ),
        GoRoute(
          path: AppRoute.themeColor.path,
          builder: (_, __) => const ThemeColorSettingPage(),
        ),
        GoRoute(
          path: AppRoute.fontSetting.path,
          builder: (_, __) => const FontSettingPage(),
        ),
        GoRoute(
          path: AppRoute.version.path,
          builder: (_, __) => const VersionInfo(),
        ),
      ],
    );
