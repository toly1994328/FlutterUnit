import 'dart:convert';
import 'dart:io';
import 'package:note/note.dart';
import 'package:app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fx_boot_starter/fx_boot_starter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';
import 'package:path/path.dart' as path;
import 'package:utils/utils.dart';
import 'package:path/path.dart' as p;
import 'bridge/unit_bridge.dart';
import 'package:widget_module/widget_module.dart';

class FlutterUnitStartRepo implements AppStartRepository<AppConfig> {
  const FlutterUnitStartRepo();

  /// 初始化 app 的异步任务
  /// 返回本地持久化的 AppConfig 对象
  @override
  Future<AppConfig> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 滚动性能优化 1.22.0
    GestureBinding.instance.resamplingEnabled = true;
    WindowSizeAdapter.setSize();
    await SpStorage().initSp();
    await initAppMeta();

    registerHttpClient();
    NoteEnv().attachBridge(UnitNoteBridge());
    if (!kAppEnv.isWeb) await initDb();
    await initWidgetStatistics(); // 加载统计数据

    HttpUtil.instance.rebase(PathUnit.baseUrl);
    AppConfigPo po = await SpStorage().appConfig.read();
    AppConfig state = AppConfig.fromPo(po);
    return state;
  }

  Future<void> initDb() async {
    //数据库不存在，执行拷贝
    String dbPath = await AppStorage().flutter.dbpath;
    bool shouldCopy = await _checkShouldCopy(dbPath, SpStorage().spf);
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
    {
      ByteData data = await rootBundle.load("assets/flutter.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
    }
    {
      ByteData data = await rootBundle.load("assets/article.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(p.join(dir.path, 'article.db'))
          .writeAsBytes(bytes, flush: true);
    }
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
    if (kDebugMode) {
      shouldCopy = true;
    }

    //数据库不存在，执行拷贝
    if (!File(dbPath).existsSync()) {
      shouldCopy = true;
    }

    return shouldCopy;
  }
}
