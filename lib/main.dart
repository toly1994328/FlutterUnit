import 'dart:async';
import 'src/stater/boot_start.dart';

void main(List<String> args) {
  runZonedGuarded(() => bootStart(args), _globalErrorHandler);
}

void _globalErrorHandler(Object exception, StackTrace trace) async{
  print(trace);
  // 可自定义处理全局异常
}