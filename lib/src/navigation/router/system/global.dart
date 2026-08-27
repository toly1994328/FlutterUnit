import 'package:app/app.dart';
import 'package:authentication/authentication.dart';

import '../../../starter/fx_application.dart';

List<GoRoute> get globalRoutes => [
      GoRoute(
        path: AppRoute.splash.path,
        builder: (_, __) => const FlutterUnitSplash(),
      ),
      GoRoute(
        path: AppRoute.startError.path,
        builder: (_, GoRouterState state) =>
            AppStartErrorPage(error: state.extra),
      ),
      GoRoute(
        path: AppRoute.globalError.path,
        builder: (_, GoRouterState state) =>
            AppStartErrorPage(error: state.extra),
      ),
      GoRoute(
        path: AppRoute.login.path,
        builder: (_, __) => const LoginPage(),
      ),
    ];
