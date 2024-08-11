import 'dart:convert';
import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:fx_app_env/fx_app_env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';
import 'package:path/path.dart' as path;

class AppStartRepositoryImpl implements AppStartRepository<AppConfigState> {
  const AppStartRepositoryImpl();

  /// 初始化 app 的异步任务
  /// 返回本地持久化的 AppConfigState 对象
  @override
  Future<AppConfigState> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    //滚动性能优化 1.22.0
    GestureBinding.instance.resamplingEnabled = true;
    WindowsAdapter.setSize();
    await SpStorage.instance.initSp();
    if (!kAppEnv.isWeb) await initDb();
    AppConfigPo po = await SpStorage.instance.appConfig.read();
    List<ConnectivityResult> netConnect = await (Connectivity().checkConnectivity());
    AppConfigState state = AppConfigState.fromPo(po);
    if (netConnect.isNotEmpty) {
      state = state.copyWith(netConnect: netConnect.first);
    }
    return state;
  }

  @override
  Future<void> fixError(Object error, {Object? extra}) async {
    await Future.delayed(const Duration(seconds: 1));
    // throw "App 无法修复";
    return;
  }

  Future<void> initDb() async {
    //数据库不存在，执行拷贝
    String dbPath = await AppStorage().flutter.dbpath;
    await SpStorage.instance.initSp();

    bool shouldCopy = await _checkShouldCopy(dbPath, SpStorage.instance.spf);

    if (shouldCopy) {
      await _doCopyAssetsDb(dbPath);
    } else {
      print("=====flutter.db 已存在====");
    }
    await AppStorage().init();
  }

  Future<void> _doCopyAssetsDb(String dbPath) async {
    Directory dir = Directory(path.dirname(dbPath));
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    ByteData data = await rootBundle.load("assets/flutter.db");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes, flush: true);

    print("=====flutter.db==== assets ======拷贝完成====");
  }

  Future<bool> _checkShouldCopy(String dbPath, SharedPreferences prefs) async {
    bool shouldCopy = false;
    String versionStr = await rootBundle.loadString('assets/version.json');
    int dbVersion = await json.decode(versionStr)['dbVersion'];
    int versionInSP = prefs.getInt(SpKey.dbVersionKey) ?? -1;

    // 版本升级，执行拷贝
    if (dbVersion > versionInSP) {
      shouldCopy = true;
      await prefs.setInt(SpKey.dbVersionKey, dbVersion);
    }

    //非 release模式，执行拷贝
    const isPro = bool.fromEnvironment('dart.vm.product');
    if (!isPro) {
      shouldCopy = true;
    }

    //数据库不存在，执行拷贝
    if (!File(dbPath).existsSync()) {
      shouldCopy = true;
    }

    return shouldCopy;
  }
}
