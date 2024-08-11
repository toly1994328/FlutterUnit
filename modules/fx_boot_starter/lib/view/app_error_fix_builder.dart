
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../bloc/state.dart';

class AppFixErrorBuilder<S> extends StatelessWidget {
  final WidgetBuilder shouldFix;
  final WidgetBuilder loading;
  final WidgetBuilder error;

  const AppFixErrorBuilder({
    super.key,
    required this.shouldFix,
    required this.loading,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStartBloc<S>, AppStatus>(builder: (_,AppStatus state){
      if(state is AppStartFailed){
        if(state.fix==FixType.fixing){
          return loading(context);
        }
        if(state.fix==FixType.fixError){
          return error(context);
        }
      }
      return shouldFix(context);
    });
  }
}
