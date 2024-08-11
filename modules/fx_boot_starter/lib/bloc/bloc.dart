import 'package:flutter_bloc/flutter_bloc.dart';

import '../fx_boot_starter.dart';
import 'state.dart';

class AppStartBloc<S> extends Cubit<AppStatus> {
  final int minStartDurationMs;

  final AppStartRepository<S> repository;
  final AppStartAction<S> startAction;
  final AppFixAction? fixAction;

  AppStartBloc({
    required this.repository,
    required this.startAction,
    this.fixAction,
    this.minStartDurationMs = 600,
  }) : super(const AppStarting());

  int _timeRecord = 0;

  void startApp() async {
    _timeRecord = DateTime.now().millisecondsSinceEpoch;
    emit(const AppStarting());
    S data;
    try {
      /// 处理初始化异步任务
      data = await repository.initApp();
    } catch (e, s) {
      emit(AppStartFailed(e, s, FixType.none));
      return;
    }

    /// 计算初始化的耗时时长
    int cost = DateTime.now().millisecondsSinceEpoch - _timeRecord;
    int waitTime = minStartDurationMs - cost;
    if (waitTime > 0) {
      /// 说明启动时间小于 [minStartDurationMs], 等待时间差
      emit(AppLoadDone(cost, data));
      await Future.delayed(Duration(milliseconds: waitTime));
    } else {
      /// 说明启动时间超过 [minStartDurationMs],给一点预加载的时间
      emit(AppLoadDone(cost, data));
      await Future.delayed(const Duration(milliseconds: 50));
    }
    emit( AppStartSuccess(data));
  }

  void fixError() async {
    if (state is AppStartFailed) {
      AppStartFailed s = state as AppStartFailed;
      emit(AppStartFailed(s.error, s.trace, FixType.fixing));
      try {
        /// 处理初始化异步任务
        await repository.fixError(s.error, extra: s.trace);
        emit(AppStartFailed(s.error, s.trace, FixType.fixed));
        startApp();
      } catch (e, s) {
        emit(AppStartFailed(e, s,  FixType.fixError));
        return;
      }
    }
  }
}
