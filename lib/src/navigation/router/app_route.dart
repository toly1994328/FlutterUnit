import 'package:app/app.dart';
import 'package:flutter/material.dart';
import '../view/desktop/flutter_unit_desk_navigation.dart';

import 'system/app.dart';
import 'system/global.dart';
import 'system/settings.dart';
import 'widgets/collection_route.dart';
import 'widgets/widgets_route.dart';

RouteBase get appRoute {
  List<RouteBase> body = [
    widgetsRoute,
    noteRoute,
    collectRoute,
    settingsRoute,
    ...systemRoutes,
  ];
  return GoRoute(
    path: AppRoute.home.path,
    redirect: (_, __) => null,
    routes: [
      ...globalRoutes,
      if (kAppEnv.isDesktopUI)
        ShellRoute(
          builder: (_, __, Widget child) => AppDeskNavigation(content: child),
          routes: body,
        ),
      if (!kAppEnv.isDesktopUI) ...body,
    ],
  );
}
