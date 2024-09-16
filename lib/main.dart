import 'dart:async';
import 'src/starter/boot_start.dart';

void main(List<String> args) {
  runZonedGuarded(() => bootStart(args), _globalErrorHandler);
}

/// 处理全局异常
void _globalErrorHandler(Object exception, StackTrace trace) async{
  print(trace);
  // 可处理其他逻辑
}