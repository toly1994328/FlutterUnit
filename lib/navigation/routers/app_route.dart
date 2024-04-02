import 'package:app/app.dart';
import 'package:app_boot_starter/app_boot_starter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_stater/view/error/app_start_error.dart';
import '../../app_stater/view/splash/standard_unit_splash.dart';

import 'desk_route.dart';
import 'mobile_route.dart';

final RouteBase deskAppRoute = GoRoute(
  path: '/',
  redirect: (_, __) => null,
  routes: [
    GoRoute(
      path: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const AppStartListener<AppConfigState>(
          child: FlutterUnitSplash(),
        );
      },
    ),
    GoRoute(
      path: 'start_error',
      builder: (BuildContext context, GoRouterState state) {
        return AppStartErrorPage(
          error: state.extra,
        );
      },
    ),
    // isDesk ?  :
    if (isDesk) appNavRoute,
    if (!isDesk) ...appMobileNavRoute
  ],
);
