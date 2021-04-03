import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/res/sp.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:flutter_unit/repositories/local_db.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'local_storage.dart';

/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 本地存储访问对象,用于读取配置数据，及初始化Database和SharedPreferences

class AppStart {
  // 初始化 App 固化的配置数据
  Future<GlobalState> initApp() async {
    SharedPreferences prefs = await LocalStorage.sp;
    //数据库不存在，执行拷贝
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, "flutter.db");

    bool shouldCopy = await _checkShouldCopy(dbPath);

    if (shouldCopy) {
      await _doCopyAssetsDb(dbPath);
    } else {
      print("=====flutter.db 已存在====");
    }

    await LocalDb.instance.initDb();

    bool showBg = prefs.getBool(SP.showBackground) ?? true;
    int themeIndex = prefs.getInt(SP.themeColorIndex) ?? 4;
    int fontIndex = prefs.getInt(SP.fontFamily) ?? 1;
    int codeIndex = prefs.getInt(SP.codeStyleIndex) ?? 0;
    int itemStyleIndex = prefs.getInt(SP.itemStyleIndex) ?? 0;

    return GlobalState(
        showBackGround: showBg,
        themeColor: Cons.themeColorSupport.keys.toList()[themeIndex],
        fontFamily: Cons.fontFamilySupport[fontIndex],
        itemStyleIndex: itemStyleIndex,
        codeStyleIndex: codeIndex);
  }

  Future<bool> _checkShouldCopy(String dbPath) async {
    bool shouldCopy = false;
    String versionStr = await rootBundle.loadString('assets/version.json');
    int dbVersion = await json.decode(versionStr)['dbVersion'];
    int versionInSP =
        await LocalStorage.getInt(LocalStorage.dbVersionKey) ?? -1;

    // 版本升级，执行拷贝
    if (dbVersion > versionInSP) {
      shouldCopy = true;
      await LocalStorage.saveInt(LocalStorage.dbVersionKey,dbVersion);
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
}
