import 'package:flutter/material.dart';

abstract class AppStartAction<S> {
  const AppStartAction();

  /// 初始化加载失败
  /// 可跳转失败界面, 引导用户处理启动异常
  void onStartError(BuildContext context, Object error, StackTrace trace);

  /// 初始化加载成功
  /// 可在回调中获得异步加载的 App 配置数据处理
  /// 并做一些首页预加载的逻辑
  void onLoaded(BuildContext context, int cost, S state);

  /// 初始化成功，且达到最低延迟毫秒数
  /// 可跳转应用主界面,正常使用应用
  void onStartSuccess(BuildContext context, S state);


}