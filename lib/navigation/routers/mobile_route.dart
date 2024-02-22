import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_module/widget_module.dart';

import '../../app/views/about/about_app_page.dart';
import '../../app/views/about/about_me_page.dart';
import '../../app/views/about/version_info.dart';
import '../../app/views/data_manage/data_manage_page.dart';
import '../../app/views/setting/code_style_setting.dart';
import '../../app/views/setting/font_setting.dart';
import '../../app/views/setting/setting_page.dart';
import '../../app/views/setting/theme_color_setting.dart';
import '../../app/views/setting/theme_model_setting.dart';
import '../views/unit_navigation.dart';

final List<RouteBase> appMobileNavRoute = [
  GoRoute(
      path: 'widget',
      builder: (BuildContext context, GoRouterState state) {
        return const UnitPhoneNavigation();
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
            return WidgetDetailPageScope(
              model: model!,
            );
          },
        ),
      ]),
  GoRoute(
    path: 'collection_widgets/:id',
    builder: (BuildContext context, GoRouterState state) {
      Object? extra= state.extra;
      CategoryModel? model;
      if(extra is CategoryModel){
        model = extra;
      }
      return  CategoryShow(
        model: model!,
      );
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
      ]),
  GoRoute(
    path: 'data_manage',
    builder: (BuildContext context, GoRouterState state) {
      return const DataManagePage();
    },
  ),
  GoRoute(
    path: 'collect',
    builder: (BuildContext context, GoRouterState state) {
      return const CollectPageAdapter(
        canPop: true,
      );
    },
  ),

  GoRoute(
    path: 'about_app',
    builder: (BuildContext context, GoRouterState state) {
      return const AboutAppPage();
    },
  ),
  GoRoute(
    path: 'about_me',
    builder: (BuildContext context, GoRouterState state) {
      return const AboutMePage();
    },
  ),
  GoRoute(
    path: 'support_me',
    builder: (BuildContext context, GoRouterState state) {
      return const SupportMe();
    },
  ),
];
