import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/class.dart';


class ClassGenBloc extends Cubit<Class>{
  ClassGenBloc():super(Class(fields: [], name: ''));
}