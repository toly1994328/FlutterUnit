import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:utils/utils.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_module/widget_module.dart';

import '../bloc/bloc.dart';
import '../bloc/state.dart';

class AppStartListener extends StatelessWidget {
  final Widget child;
  const AppStartListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStartBloc, AppStatus>(
        listener: _listenAppStart,
        child:child);
  }

  // 监听资源加载完毕，启动，触发事件
  void _listenAppStart(BuildContext context, AppStatus state) {
    if (state is AppLoadDone) {
      print('::AppLoadDone::启动耗时${state.cost}');
      HttpUtil.instance.rebase(PathUnit.baseUrl);
      context.read<AppConfigBloc>().initApp();
      context.read<WidgetsBloc>().add(const EventTabTap(WidgetFamily.statelessWidget));
      context.read<LikeWidgetBloc>().add(const EventLoadLikeData());
      context.read<CategoryBloc>().add(const EventLoadCategory());
    }

    if (state is AppStartSuccess) {
      context.go('/widget');
    }
  }
}
