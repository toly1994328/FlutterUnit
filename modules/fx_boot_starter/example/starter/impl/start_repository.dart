import 'package:fx_boot_starter/data/repository.dart';

import '../data/app_state.dart';

bool _isErrorDebug = true;

class AppStartRepositoryImpl implements AppStartRepository<AppState> {
  const AppStartRepositoryImpl();

  @override
  Future<AppState> initApp() async {

    /// 可以处理异步加载任务
    /// 返回初始化的 AppState
    await Future.delayed(const Duration(seconds: 1));
    if (_isErrorDebug) {
      // throw "App 初始化异常";
    }
    return AppState(0);
  }

  @override
  Future<void> fixError(Object error, {Object? extra}) async {
    await Future.delayed(const Duration(seconds: 1));
    // throw "App 无法修复";
    _isErrorDebug = false;
    return;
  }
}
