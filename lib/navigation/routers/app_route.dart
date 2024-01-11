import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_stater/view/app_start_listener.dart';
import '../../app_stater/view/standard_unit_splash.dart';

import 'desk_route.dart';
import 'mobile_route.dart';

final RouteBase deskAppRoute = GoRoute(
  path: '/',
  redirect: (_, __) => null,
  routes: [
    GoRoute(
      path: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const AppStartListener(child: FlutterUnitSplash());
      },
    ),
    // isDesk ?  :
    if(isDesk)
      appNavRoute,
    if(!isDesk)
    ...appMobileNavRoute
  ],
);
