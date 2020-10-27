import 'package:flutter/material.dart';
import 'package:flutter_unit/views/app/navigation/unit_navigation.dart';
import 'package:flutter_unit/views/pages/about/about_me_page.dart';
import 'package:flutter_unit/views/pages/about/about_app_page.dart';
import 'package:flutter_unit/views/pages/about/version_info.dart';
import 'package:flutter_unit/views/pages/category/category_detail.dart';
import 'package:flutter_unit/views/pages/category/collect_page.dart';
import 'package:flutter_unit/views/pages/gallery/gallery_page.dart';
import 'package:flutter_unit/views/pages/issues_point/issues_detail.dart';
import 'package:flutter_unit/views/pages/issues_point/issues_point_page.dart';
import 'package:flutter_unit/views/pages/login/login_page.dart';
import 'package:flutter_unit/views/pages/search/serach_page.dart';
import 'package:flutter_unit/views/pages/setting/code_style_setting.dart';
import 'package:flutter_unit/views/pages/setting/font_setting.dart';
import 'package:flutter_unit/views/pages/setting/item_style_setting.dart';
import 'package:flutter_unit/views/pages/setting/theme_color_setting.dart';
import 'package:flutter_unit/views/pages/unit_todo/attr_unit_page.dart';
import 'package:flutter_unit/views/pages/unit_todo/point_unit_page.dart';

import 'package:flutter_unit/views/pages/widget_detail/widget_detail_page.dart';
import 'package:flutter_unit/views/pages/unit_todo/layout_unit_page.dart';
import 'package:flutter_unit/views/pages/setting/setting_page.dart';

import 'utils/router_utils.dart';

class UnitRouter {
  static const String detail = 'detail';
  static const String home = '/';
  static const String logo = 'logo';
  static const String search = 'search';
  static const String nav = 'nav';
  static const String widget_detail = 'WidgetDetail';
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
  static const String galley = 'GalleryPage';
  static const String layout = 'LayoutUnitPage';
  static const String about_me = 'AboutMePage';
  static const String about_app = 'AboutAppPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //根据名称跳转相应页面
      case widget_detail:
        return Right2LeftRouter(
            child: WidgetDetailPage(
          model: settings.arguments,
        ));
      case search:
        return Right2LeftRouter(child: SearchPage());
      case collect:
        return Right2LeftRouter(child: CollectPage());
      case nav:
        return Left2RightRouter(child: UnitNavigation());
      case setting:
        return Right2LeftRouter(child: SettingPage());
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
      case issues_point:
        return Right2LeftRouter(child: IssuesPointPage());

      case login:
        return Right2LeftRouter(child: LoginPage());

      case attr:
        return Right2LeftRouter(child: AttrUnitPage());
      case bug:
        return Right2LeftRouter(child: BugUnitPage());
      case galley:
        return Right2LeftRouter(child: GalleryPage());
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
          model: settings.arguments,
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
