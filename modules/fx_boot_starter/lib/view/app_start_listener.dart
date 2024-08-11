import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../bloc/state.dart';
import '../data/action/app_start_action.dart';

class AppStartListener<S> extends StatelessWidget {
  final Widget child;

  const AppStartListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStartBloc<S>, AppStatus>(
      child: child,
      listener: (BuildContext context, AppStatus state) {
        AppStartAction<S> action = context.read<AppStartBloc<S>>().startAction;
        if (state is AppLoadDone<S>) {
          action.onLoaded(context, state.cost, state.data);
        }
        if (state is AppStartSuccess) {
          action.onStartSuccess(context,state.data);
        }

        if (state is AppStartFailed) {
          action.onStartError(context,state.error,state.trace);
        }
      },
    );
  }
}
