import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../bloc/state.dart';
import '../data/action/app_fix_action.dart';



class AppStartFixListener<S> extends StatelessWidget {
  final Widget child;

  const AppStartFixListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStartBloc<S>, AppStatus>(
      listenWhen: (p, n) =>
          (p is AppStartFailed && p.fix == FixType.fixing) &&
          (n is AppStartFailed),
      child: child,
      listener: (BuildContext context, AppStatus state) {
        if (state is AppStartFailed) {
          AppFixAction? action = context.read<AppStartBloc<S>>().fixAction;

          if (state.fix == FixType.fixed) {

            action?.onFixSuccess(context);
          }
          if (state.fix == FixType.fixError) {
            action?.onFixError(context, state.error, state.trace);
          }
        }
      },
    );
  }
}
