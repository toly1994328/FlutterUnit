
#### ::logic::

easy handle app start load future task by implements AppStartRepository
in initApp function, return your AppState.
and fixError to handle start error

```dart
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
```

----

#### ::listen start action::

easy handle app start state  by implements AppStartAction

```dart
class AppStartActionImpl implements AppStartAction<AppState> {

  const AppStartActionImpl();

  @override
  void onLoaded(BuildContext context, int cost, AppState state) {
    debugPrint("App启动耗时:$cost ms");
  }

  @override
  void onStartError(BuildContext context, Object error, StackTrace trace) {
    // TODO go start success
  }

  @override
  void onStartSuccess(BuildContext context,AppState) {
    // TODO go start success
  }
}
```