import 'package:algorithm/algorithm.dart';
import 'package:artifact/artifact.dart';
import 'package:draw_system/draw_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/views/account/desk/desk_account_page.dart';
import 'package:flutter_unit/app/views/setting/setting_page.dart';
import 'package:go_router/go_router.dart';
import 'package:treasure_tools/treasure_tools.dart';
import 'package:widget_module/widget_module.dart';

import '../../app/views/about/about_app_page.dart';
import '../../app/views/about/version_info.dart';
import '../../app/views/setting/code_style_setting.dart';
import '../../app/views/setting/font_setting.dart';
import '../../app/views/setting/theme_color_setting.dart';
import '../../app/views/setting/theme_model_setting.dart';
import '../views/desk/flutter_unit_desk_navigation.dart';

final RouteBase appNavRoute = ShellRoute(
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return FlutterUnitDeskNavigation(content: child);
  },
  routes: <RouteBase>[
    GoRoute(
        path: 'widget',
        builder: (BuildContext context, GoRouterState state) {
          return DeskWidgetPanel();
        },
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
      builder: (BuildContext context, GoRouterState state) {
        return GalleryUnit();
      },
    ),    GoRoute(
      path: 'about_app',
      builder: (BuildContext context, GoRouterState state) {
        return AboutAppPage();
      },
    ),
    GoRoute(
      path: 'knowledge',
      builder: (BuildContext context, GoRouterState state) {
        // return DeskPointPage();
        return DeskKnowledgePage();
      },
    ),
    GoRoute(
        path: 'collection',
        builder: (BuildContext context, GoRouterState state) {
          return CollectPageAdapter();
        },
        routes: [
          GoRoute(
            path: 'widgets/:id',
            builder: (BuildContext context, GoRouterState state) {
              Object? extra = state.extra;
              CategoryModel? model;
              if (extra is CategoryModel) {
                model = extra;
              }
              return CategoryShow(
                model: model!,
              );
            },
          ),
        ]),
    GoRoute(
      path: 'account',
      builder: (BuildContext context, GoRouterState state) {
        return DeskAccountPage();
      },
    ),
    GoRoute(
      path: 'tools',
      builder: (BuildContext context, GoRouterState state) {
        return CodeGenPage();
      },
    ),
    GoRoute(
        path: 'settings',
        builder: (BuildContext context, GoRouterState state) {
          return const SettingPage();
        },
        routes: [
          GoRoute(
            path: 'dark_mode',
            builder: (BuildContext context, GoRouterState state) {
              return const ThemeModelSetting();
            },
          ),
          GoRoute(
            path: 'code_style',
            builder: (BuildContext context, GoRouterState state) {
              return const CodeStyleSettingPage();
            },
          ),
          GoRoute(
            path: 'theme_color',
            builder: (BuildContext context, GoRouterState state) {
              return const ThemeColorSettingPage();
            },
          ),
          GoRoute(
            path: 'font_setting',
            builder: (BuildContext context, GoRouterState state) {
              return const FontSettingPage();
            },
          ),
          GoRoute(
            path: 'version',
            builder: (BuildContext context, GoRouterState state) {
              return const VersionInfo();
            },
          ),
        ])
  ],
);
