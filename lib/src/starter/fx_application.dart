import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_module/widget_module.dart';
import 'package:widget_module/blocs/blocs.dart';
import '../flutter_unit.dart';
import '../navigation/view/app_bloc_provider.dart';
import 'start_repository.dart';
import 'package:app_update/app_update.dart';
import 'package:note/note.dart';

export 'view/splash/Flutter_unit_splash.dart';
export 'view/error/app_start_error.dart';

class FxApplication with FxStarter<AppConfig> {
  const FxApplication();

  @override
  Widget get app => const AppBlocProvider(child: FlutterUnit3());

  @override
  AppStartRepository<AppConfig> get repository => const FlutterUnitStartRepo();

  @override
  void onLoaded(BuildContext context, int cost, AppConfig state) async {
    debugPrint("App启动耗时:$cost ms");
    context.read<AppConfigBloc>().init(state);
    context.initWidgetData();
    if (!kAppEnv.isWeb) {
      context.read<LikeWidgetBloc>().loadLikeData();
      context.read<CategoryBloc>().add(const EventLoadCategory());
      context.read<NewsBloc>().load();
    }
  }

  @override
  void onStartSuccess(BuildContext context, AppConfig state) {
    CheckUpdate event = CheckUpdate(appId: 1, locale: state.localeValue);
    context.read<UpgradeBloc>().add(event);
    context.go(AppRoute.widget.url);
    sendEvent(1);
  }

  @override
  void onStartError(BuildContext context, Object error, StackTrace trace) {
    context.go(AppRoute.startError.url, extra: error);
  }

  @override
  void onGlobalError(Object error, StackTrace stack) {
    print(error);
  }
}
