import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:go_router/go_router.dart';
import 'package:l10n/gen_l10n/app_localizations.dart';
import 'package:l10n/l10n.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:tolyui/app/toly_ui.dart';
import 'package:widget_module/widget_module.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:note/note.dart';
import 'l10n/gen/app_l10n.dart';
import 'l10n/locale_provider.dart';
import 'navigation/router/app_route.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明: 应用主程序

class FlutterUnit3 extends StatefulWidget {
  const FlutterUnit3({super.key});

  @override
  State<FlutterUnit3> createState() => _FlutterUnit3State();
}

class _FlutterUnit3State extends State<FlutterUnit3> with LocalProvider {
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
    return BlocListener<AppConfigBloc, AppConfig>(
      listenWhen: (p, n) => p.language != n.language,
      listener: _onLocaleChange,
      child: DefaultTextStyle(
        style: TextStyle(fontFamily: ''),
        child: TolyUiApp.router(
          routerConfig: _router,
          showPerformanceOverlay: state.showPerformanceOverlay,
          title: StrUnit.appName,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          locale: state.language.locale,
          themeMode: state.themeMode,
          darkTheme: dark,
          theme: light,
        ),
      ),
    );
  }

  void _initWeb() {
    if (!kAppEnv.isWeb) return;
    GoRouter.optionURLReflectsImperativeAPIs = true;
    context.initWidgetData();
  }

  void _onLocaleChange(BuildContext context, AppConfig state) {
    context.read<WidgetsBloc>().changeLocale(state.language.locale);
    FxDio().auth<Unit3Host>(UnitApiAuth(state.language.isZh));
  }

  @override
  Iterable<LocalizationsDelegate>? get localizationsDelegates => const [
        AppL10n.delegate,
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
        PkgL10n.delegate,
      ];

  @override
  List<Locale> get supportedLocales => l10nLocales;
}
