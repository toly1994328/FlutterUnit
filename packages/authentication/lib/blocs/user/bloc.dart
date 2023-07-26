import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class UserBloc extends Cubit<UserPerformance> {
  UserBloc():super(UserPerformance.fromJson({}));



}