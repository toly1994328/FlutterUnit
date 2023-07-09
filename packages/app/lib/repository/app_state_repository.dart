import 'dart:convert';
import 'dart:io';

import 'package:app/model/global_state.dart';
import 'package:app/model/app_style.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

import '../app/cons/cons.dart';
import '../app/cons/sp.dart';

class AppStateRepository {
  SpStorage get sp => SpStorage.instance;

  Future<AppState> initApp() async {
    DbOpenHelper.setupDatabase();
    //数据库不存在，执行拷贝
    String databasesPath = await DbOpenHelper.getDbDirPath();
    String dbPath = path.join(databasesPath, "flutter.db");
    await SpStorage.instance.initSp();
    // 读取配置文件，初始化应用状态
    AppConfigPo po = await sp.appConfig.read();

    bool shouldCopy = await _checkShouldCopy(dbPath, sp.spf);

    if (shouldCopy) {
      await _doCopyAssetsDb(dbPath);
    } else {
      print("=====flutter.db 已存在====");
    }

    await FlutterDbStorage.instance.initDb();
    await AppDbStorage.instance.initDb();

    final ConnectivityResult netConnect =
        await (Connectivity().checkConnectivity());

    return AppState.fromPo(po).copyWith(
      netConnect: netConnect,
      dbPath: dbPath,
    );
  }

  Future<void> _doCopyAssetsDb(String dbPath) async {
    Directory dir = Directory(path.dirname(dbPath));
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    ByteData data = await rootBundle.load("assets/flutter.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
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
