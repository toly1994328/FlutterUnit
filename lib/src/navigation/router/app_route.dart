import 'package:app/app.dart';
import 'package:go_router/go_router.dart';

import '../../starter/boot_start.dart';
import 'desk_route.dart';
import 'mobile_route.dart';

final RouteBase deskAppRoute = GoRoute(
  path: '/',
  redirect: (_, __) => null,
  routes: [
    GoRoute(
      path: 'splash',
      builder: (_, __) => const FlutterUnitSplash(),
    ),
    GoRoute(
      path: 'start_error',
      builder: (_, GoRouterState state) => AppStartErrorPage(error: state.extra),
    ),
    if (isDesk) appNavRoute,
    if (!isDesk) ...appMobileNavRoute
  ],
);
