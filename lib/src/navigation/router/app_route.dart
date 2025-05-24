import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/src/l10n/gen/app_l10n.dart';
import '../view/desktop/flutter_unit_desk_navigation.dart';

import 'system/app.dart';
import 'system/global.dart';
import 'system/settings.dart';
import 'widgets/collection_route.dart';
import 'widgets/widgets_route.dart';
import 'package:note/note.dart';

RouteBase get appRoute {
  List<RouteBase> body = [
    widgetsRoute,
    noteRoute,
    collectRoute,
    settingsRoute,
    GoRoute(
      path: AppRoute.moreNews.path,
      builder: (ctx, __) => NewsPage(
        title: AppL10n.of(ctx).news,
      ),
    ),
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
