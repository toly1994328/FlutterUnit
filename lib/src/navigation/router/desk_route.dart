import 'package:app/app.dart';
import 'package:artifact/artifact.dart';
import 'package:draw_system/draw_system.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:treasure_tools/treasure_tools.dart';
import 'package:widget_module/widget_module.dart';
import '../views/desktop/flutter_unit_desk_navigation.dart';

final RouteBase appNavRoute = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return FlutterUnitDeskNavigation(content: child);
  },
  routes: <RouteBase>[
    GoRoute(
        path: 'widget',
        builder: (_, __) => const DeskWidgetPanel(),
        routes: [
          GoRoute(
            path: 'detail/:name',
            builder: (BuildContext context, GoRouterState state) {
              Object? extra = state.extra;
              WidgetModel? model;
              if (extra is WidgetModel) {
                model = extra;
              }
              return DeskWidgetDetailPageScope(
                model: model,
                widgetName: state.pathParameters['name'],
              );
            },
          ),
        ]),
    GoRoute(
      path: 'painter',
      builder: (_,__) => const GalleryUnit(),
    ),
    GoRoute(
      path: 'about_app',
      builder:  (_,__) => const AboutAppPage(),
    ),
    GoRoute(
      path: 'knowledge',
      builder:  (_,__) => const DeskKnowledgePage(),
    ),
    GoRoute(
        path: 'collection',
        builder:  (_,__) => const CollectPageAdapter(),
        routes: [
          GoRoute(
            path: 'widgets/:id',
            builder: (BuildContext context, GoRouterState state) {
              Object? extra = state.extra;
              CategoryModel? model;
              if (extra is CategoryModel) {
                model = extra;
              }
              return CategoryShow(model: model!);
            },
          ),
        ]),
    GoRoute(
      path: 'account',
      builder:  (_,__) => const DeskAccountPage(),
    ),
    GoRoute(
      path: 'tools',
      builder:  (_,__) => const CodeGenPage(),
    ),
    GoRoute(
        path: 'settings',
        builder:  (_,__) => const SettingPage(),
        routes: [
          GoRoute(
            path: 'dark_mode',
            builder:  (_,__) => const ThemeModelSetting(),
          ),
          GoRoute(
            path: 'code_style',
            builder:  (_,__) => const CodeStyleSettingPage(),
          ),
          GoRoute(
            path: 'theme_color',
            builder:  (_,__) => const ThemeColorSettingPage(),
          ),
          GoRoute(
            path: 'font_setting',
            builder:  (_,__) => const FontSettingPage(),
          ),
          GoRoute(
            path: 'version',
            builder:  (_,__) => const VersionInfo(),
          ),
        ])
  ],
);
