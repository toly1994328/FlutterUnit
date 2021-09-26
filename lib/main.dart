import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app/views/navigation/bloc_wrapper.dart';
import 'app/views/navigation/flutter_unit.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //滚动性能优化 1.22.0
  GestureBinding.instance?.resamplingEnabled = true;
  runApp(BlocWrapper(child: FlutterUnit()));
}


