import 'package:flutter/material.dart';

abstract class AppFixAction {
  const AppFixAction();

  /// 初始化修复失败
  void onFixError(BuildContext context, Object error, StackTrace trace);

  /// 初始化修复成功
  void onFixSuccess(BuildContext context);
}
