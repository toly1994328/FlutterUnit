import 'dart:convert';
import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';
import 'package:path/path.dart' as path;

class AppStartRepository{

  const AppStartRepository();

  Future<void> initSp() async{
    await SpStorage.instance.initSp();
  }

  Future<void> initDb() async{
    DbOpenHelper.setupDatabase();
    //数据库不存在，执行拷贝
    String databasesPath = await DbOpenHelper.getDbDirPath();
    String dbPath = path.join(databasesPath, "flutter.db");
    await SpStorage.instance.initSp();

    bool shouldCopy = await _checkShouldCopy(dbPath, SpStorage.instance.spf);

    if (shouldCopy) {
      await _doCopyAssetsDb(dbPath);
    } else {
      print("=====flutter.db 已存在====");
    }

    await FlutterDbStorage.instance.initDb();
    await AppDbStorage.instance.initDb();
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