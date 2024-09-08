import 'package:app/app.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_module/widget_module.dart';

import '../views/mobile/unit_navigation.dart';

final List<RouteBase> appMobileNavRoute = [
  GoRoute(
    path: 'widget',
    builder: (_, __) => const UnitPhoneNavigation(),
    routes: [
      GoRoute(
        path: 'detail/:name',
        builder: (BuildContext context, GoRouterState state) {
          Object? extra = state.extra;
          WidgetModel? model;
          if (extra is WidgetModel) {
            model = extra;
          }
          return WidgetDetailPageScope(model: model!);
        },
      ),
    ],
  ),
  GoRoute(
    path: 'collection_widgets/:id',
    builder: (BuildContext context, GoRouterState state) {
      Object? extra = state.extra;
      CategoryModel? model;
      if (extra is CategoryModel) {
        model = extra;
      }
      return CategoryShow(model: model!);
    },
  ),
  GoRoute(
      path: 'settings',
      builder: (_, __) => const SettingPage(),
      routes: [
        GoRoute(
          path: 'dark_mode',
          builder: (_, __) => const ThemeModelSetting(),
        ),
        GoRoute(
          path: 'code_style',
          builder: (_, __) => const CodeStyleSettingPage(),
        ),
        GoRoute(
          path: 'theme_color',
          builder: (_, __) => const ThemeColorSettingPage(),
        ),
        GoRoute(
          path: 'font_setting',
          builder: (_, __) => const FontSettingPage(),
        ),
        GoRoute(
          path: 'version',
          builder: (_, __) => const VersionInfo(),
        ),
      ]),
  GoRoute(
    path: 'data_manage',
    builder: (_, __) => const DataManagePage(),
  ),
  GoRoute(
    path: 'collect',
    builder: (_, __) => const CollectPageAdapter(canPop: true),
  ),
  GoRoute(
    path: 'about_app',
    builder: (_, __) => const AboutAppPage(),
  ),
  GoRoute(
    path: 'about_me',
    builder: (_, __) => const AboutMePage(),
  ),
  GoRoute(
    path: 'support_me',
    builder: (_, __) => const SupportMe(),
  ),
];
