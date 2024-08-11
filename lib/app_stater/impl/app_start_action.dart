import 'package:app/app.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_app_env/fx_app_env.dart';
import 'package:go_router/go_router.dart';
import 'package:storage/storage.dart';
import 'package:utils/utils.dart';
import 'package:widget_module/blocs/blocs.dart';

class AppStartActionImpl implements AppStartAction<AppConfigState> {

  const AppStartActionImpl();

  @override
  void onLoaded(BuildContext context, int cost, AppConfigState state) {
    debugPrint("App启动耗时:$cost ms");
    HttpUtil.instance.rebase(PathUnit.baseUrl);
    context.read<AppConfigBloc>().init(state);
    context.read<WidgetsBloc>().add(const EventTabTap(WidgetFamily.statelessWidget));
    if(!kAppEnv.isWeb){
      context.read<LikeWidgetBloc>().add(const EventLoadLikeData());
      context.read<CategoryBloc>().add(const EventLoadCategory());
    }
  }

  @override
  void onStartError(BuildContext context, Object error, StackTrace trace) {
    context.go('/start_error',extra: error);
  }

  @override
  void onStartSuccess(BuildContext context,AppConfigState state) {
    context.go('/widget');
  }
}
