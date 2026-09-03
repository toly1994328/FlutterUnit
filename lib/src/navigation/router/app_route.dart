import 'package:app/app.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/src/l10n/gen/app_l10n.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
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
    GoRoute(
      path: AppRoute.packages.path,
      builder: (BuildContext context, __) {
        return BlocBuilder<FxUserSessionCubit, FxUserSession>(
          builder: (BuildContext context, FxUserSession session) =>
              PkgPlayerPage(
            config: PkgPlayerConfig(
              isAuthenticated: session is FxAuthed,
              onLoginRequired: _openLogin,
            ),
          ),
        );
      },
      // routes: [
      //   GoRoute(path: AppRoute.collectionDetail.path, builder: collectionDetailBuilder),
      // ],
    ),
    settingsRoute,
    GoRoute(
      path: AppRoute.moreNews.path,
      builder: (ctx, __) => NewsPage(
        title: AppL10n.of(ctx).news,
        coverResolver: _resolveNewsCover,
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

Future<void> _openLogin(BuildContext context) {
  return openUserLogin(context);
}

/// 为“查看更多”页面解析封面地址并附加目标宽度参数。
String _resolveNewsCover(String source, int width) {
  return FlutterUnitHost.resolveImageResource(source, width: width).toString();
}
