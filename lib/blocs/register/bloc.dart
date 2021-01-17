import 'package:flutter_bloc/flutter_bloc.dart';

import 'event.dart';
import 'state.dart';

/// create by 张风捷特烈 on 2021/1/17
/// contact me by email 1981462002@qq.com
/// 说明:

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterLoading());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is DoRegister) {
      yield RegisterLoading();
    }
  }
}
