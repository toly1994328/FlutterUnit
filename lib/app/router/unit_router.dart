import 'package:flutter/material.dart';
import 'package:flutter_unit/app/views/about/about_app_page.dart';
import 'package:flutter_unit/app/views/about/about_me_page.dart';
import 'package:flutter_unit/app/views/about/version_info.dart';
import 'package:flutter_unit/app/views/data_manage/data_manage_page.dart';
import 'package:flutter_unit/app/views/navigation/unit_navigation.dart';
import 'package:flutter_unit/app/views/setting/code_style_setting.dart';
import 'package:flutter_unit/app/views/setting/font_setting.dart';
import 'package:flutter_unit/app/views/setting/item_style_setting.dart';
import 'package:flutter_unit/app/views/setting/setting_page.dart';
import 'package:flutter_unit/app/views/setting/theme_color_setting.dart';
import 'package:flutter_unit/app/views/unit_todo/attr_unit_page.dart';
import 'package:flutter_unit/app/views/unit_todo/layout_unit_page.dart';
import 'package:flutter_unit/app/views/unit_todo/point_unit_page.dart';
import 'package:flutter_unit/point_system/views/issues_point/issues_detail.dart';
import 'package:flutter_unit/point_system/views/issues_point/issues_point_page.dart';
import 'package:flutter_unit/user_system/pages/login/login_page.dart';
import 'package:flutter_unit/user_system/pages/register/register_page.dart';
import 'package:flutter_unit/widget_system/repositories/model/category_model.dart';
import 'package:flutter_unit/widget_system/repositories/model/widget_model.dart';
import 'package:flutter_unit/widget_system/views/widget_system_view.dart';

import 'router_utils.dart';

class UnitRouter {
  static const String widget_detail = '/widget_detail';

  static const String detail = 'detail';
  static const String search = 'search_bloc';
  static const String nav = 'nav';

  static const String collect = 'CollectPage';
  static const String point = 'IssuesPointPage';
  static const String point_detail = 'IssuesDetailPage';

  static const String setting = 'SettingPage';
  static const String font_setting = 'FountSettingPage';
  static const String theme_color_setting = 'ThemeColorSettingPage';
  static const String code_style_setting = 'CodeStyleSettingPage';
  static const String item_style_setting = 'ItemStyleSettingPage';
  static const String version_info = 'VersionInfo';
  static const String login = 'login';

  static const String category_show = 'CategoryShow';
  static const String issues_point = 'IssuesPointPage';

  static const String attr = 'AttrUnitPage';
  static const String bug = 'BugUnitPage';
  static const String layout = 'LayoutUnitPage';
  static const String about_me = 'AboutMePage';
  static const String about_app = 'AboutAppPage';
  static const String register = 'register';

  static const String data_manage = 'DataManagePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //
      case nav:
        return Left2RightRouter(child: const UnitNavigation());

      // 组件详情页
      case widget_detail:
        return Right2LeftRouter(
            child: WidgetDetailPage(model: settings.arguments as WidgetModel));

      case search:
        return Right2LeftRouter(child: SearchPage());
      case collect:
        return Right2LeftRouter(child: CollectPage());

      case setting:
        return Right2LeftRouter(child: SettingPage());
      case data_manage:
        return Right2LeftRouter(child: DataManagePage());
      case font_setting:
        return Right2LeftRouter(child: FontSettingPage());
      case theme_color_setting:
        return Right2LeftRouter(child: ThemeColorSettingPage());
      case code_style_setting:
        return Right2LeftRouter(child: CodeStyleSettingPage());
      case item_style_setting:
        return Right2LeftRouter(child: ItemStyleSettingPage());

      case version_info:
        return Right2LeftRouter(child: VersionInfo());

      case version_info:
        return Right2LeftRouter(child: VersionInfo());

      case issues_point:
        return Right2LeftRouter(child: IssuesPointPage());
      case login:
        return Right2LeftRouter(child: LoginPage());

      case register:
        return Right2LeftRouter(child: RegisterPage());

      case attr:
        return Right2LeftRouter(child: AttrUnitPage());
      case bug:
        return Right2LeftRouter(child: BugUnitPage());
      case layout:
        return Right2LeftRouter(child: LayoutUnitPage());
      case about_app:
        return Right2LeftRouter(child: AboutAppPage());
      case about_me:
        return Right2LeftRouter(child: AboutMePage());

      case point_detail:
        return Right2LeftRouter(child: IssuesDetailPage());

      case category_show:
        return Right2LeftRouter(
            child: CategoryShow(
          model: settings.arguments as CategoryModel,
        ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
