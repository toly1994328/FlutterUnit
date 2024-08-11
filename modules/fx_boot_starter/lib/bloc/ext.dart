import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

extension FixContext on BuildContext {
  void fixStartError<S>() => read<AppStartBloc<S>>().fixError();
}
