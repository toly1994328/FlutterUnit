import 'package:flutter/material.dart';
import 'package:flutter_unit/views/pages/detail/widget_detail_page.dart';
import 'package:flutter_unit/views/pages/nav_page.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/Banner.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/Card.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/Container.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/FlutterLogo.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/Icon.dart';
import 'package:flutter_unit/views/widgets/StatelessWidget/Text.dart';

import 'router_utils.dart';

class Router {
  static const String detail = 'detail';
  static const String home = '/';
  static const String logo = 'logo';
  static const String nav = 'nav';
  static const String widget_detail = 'WidgetDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //根据名称跳转相应页面
      case widget_detail:
        return Right2LeftRouter(child: WidgetDetailPage());
        case nav:
        return NoAnimRouter(child: NavPage());

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
