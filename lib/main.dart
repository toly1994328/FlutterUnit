import 'package:app/app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'app/bloc_wrapper.dart';
import 'app/flutter_unit.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //滚动性能优化 1.22.0
  GestureBinding.instance.resamplingEnabled = true;
  runApp( BlocWrapper(child: FlutterUnit3()));
  WindowsAdapter.setSize();
}

