import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:go_router/go_router.dart';
import 'package:l10n/gen_l10n/app_localizations.dart';
import 'package:l10n/l10n.dart';
import 'package:widget_module/widget_module.dart';
import 'package:tolyui/tolyui.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'l10n/gen/app_l10n.dart';
import 'navigation/router/app_route.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: 应用主程序

class FlutterUnit3 extends StatefulWidget {
  const FlutterUnit3({super.key});

  @override
  State<FlutterUnit3> createState() => _FlutterUnit3State();
}

class _FlutterUnit3State extends State<FlutterUnit3> {
  final GoRouter _router = GoRouter(
    initialLocation: AppRoute.splash.url,
    routes: <RouteBase>[appRoute],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go(AppRoute.globalError.url, extra: state.uri.toString());
    },
  );

  @override
  void initState() {
    super.initState();
    _initWeb();
  }

  @override
  Widget build(BuildContext context) {
    AppConfig state = context.watch<AppConfigBloc>().state;
    ThemeData dark = darkTheme(state);
    ThemeData light = lightTheme(state);
    return DefaultTextStyle(
      style: TextStyle(fontFamily: state.fontFamily),
      child: TolyMessage(
        themeMode: state.themeMode,
        darkTheme: dark,
        theme:light,
        child: MaterialApp.router(
          routerConfig: _router,
          showPerformanceOverlay: state.showPerformanceOverlay,
          title: StrUnit.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppL10n.delegate,
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: l10nLocales,
          locale: state.language.locale,
          themeMode: state.themeMode,
          darkTheme: dark,
          theme:light,
        ),
      ),
    );
  }

  void _initWeb() {
    if (!kAppEnv.isWeb) return;
    GoRouter.optionURLReflectsImperativeAPIs = true;
    context.read<WidgetsBloc>().add(const EventTabTap(WidgetFamily.statelessWidget));
  }
}
