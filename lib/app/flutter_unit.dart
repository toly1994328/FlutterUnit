import 'package:algorithm/algorithm.dart';
import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_unit/navigation/routers/app_route.dart';
import 'package:go_router/go_router.dart';
import 'package:l10n/l10n.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: 主程序

class FlutterUnit3 extends StatelessWidget {
  FlutterUnit3({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    routes: <RouteBase>[deskAppRoute],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go('/404', extra: state.uri.toString());
    },
  );

  @override
  Widget build(BuildContext context) {
    AppConfigState state = context.watch<AppConfigBloc>().state;
    return SortStateScope(
      notifier: SortState(),
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: state.fontFamily),
        child: MaterialApp.router(
          routerConfig: _router,
          showPerformanceOverlay: state.showPerformanceOverlay,
          title: StrUnit.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: l10nDelegates,
          supportedLocales: l10nLocales,
          locale: state.language.locale,
          themeMode: state.themeMode,
          darkTheme: AppTheme.darkTheme(state),
          theme: AppTheme.lightTheme(state),
        ),
      ),
    );
  }
}
