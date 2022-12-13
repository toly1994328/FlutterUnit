import 'dart:convert';
import 'dart:io';

import 'package:app_config/model/global_state.dart';
import 'package:app_config/model/app_style.dart';
import 'package:db_storage/db_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

import '../app/cons/cons.dart';
import '../app/cons/sp.dart';

class AppStateRepository{
  late SharedPreferences prefs;

  Future<AppState> initApp() async{
    prefs = await SharedPreferences.getInstance();
    DbOpenHelper.setupDatabase();
    //数据库不存在，执行拷贝
    String databasesPath = await DbOpenHelper.getDbDirPath();
    String dbPath = path.join(databasesPath, "flutter.db");

    bool shouldCopy = await _checkShouldCopy(dbPath,prefs);

    if (shouldCopy) {
      await _doCopyAssetsDb(dbPath);
    } else {
      print("=====flutter.db 已存在====");
    }

    await LocalDb.instance.initDb();

    bool showBg = prefs.getBool(SpKey.showBackground) ?? true;
    bool showTool = prefs.getBool(SpKey.showTool) ?? true;
    int themeIndex = prefs.getInt(SpKey.themeColorIndex) ?? 4;
    int fontIndex = prefs.getInt(SpKey.fontFamily) ?? 1;
    int codeIndex = prefs.getInt(SpKey.codeStyleIndex) ?? 0;
    int itemStyleIndex = prefs.getInt(SpKey.itemStyleIndex) ?? 0;
    int appStyleIndex = prefs.getInt(SpKey.appStyleIndex) ?? 0;

    return AppState(
        showBackGround: showBg,
        themeColor: Cons.kThemeColorSupport.keys.toList()[themeIndex],
        fontFamily: Cons.kFontFamilySupport[fontIndex],
        itemStyleIndex: itemStyleIndex,
        appStyle: Cons.kAppStyleStringMap.keys.toList()[appStyleIndex],
        showOverlayTool: showTool,
        codeStyleIndex: codeIndex);
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

  Future<bool> _checkShouldCopy(String dbPath,SharedPreferences prefs) async {
    bool shouldCopy = false;
    String versionStr = await rootBundle.loadString('assets/version.json');
    int dbVersion = await json.decode(versionStr)['dbVersion'];
    int versionInSP = prefs.getInt(SpKey.dbVersionKey) ?? -1;

    // 版本升级，执行拷贝
    if (dbVersion > versionInSP) {
      shouldCopy = true;
      await prefs.setInt(SpKey.dbVersionKey,dbVersion);
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


  Future<void> saveFontFamily(String family) async {
    int familyIndex = Cons.kFontFamilySupport.indexOf(family);
    await prefs.setInt(SpKey.fontFamily, familyIndex);
  }

  Future<void> saveThemeColor(MaterialColor color) async {
    int themeIndex = Cons.kThemeColorSupport.keys.toList().indexOf(color);
    await prefs.setInt(SpKey.themeColorIndex, themeIndex);
  }

  Future<void> saveShowBg(bool show) async {
    await prefs.setBool(SpKey.showBackground, show);
  }

  Future<void> saveCoderTheme(int index) async {
    await prefs.setInt(SpKey.codeStyleIndex, index);
  }

  Future<void> saveItemStyle(int index) async {
    await prefs.setInt(SpKey.itemStyleIndex, index);
  }

  Future<void> saveChangeAppStyle(AppStyle style) async {
    await prefs.setInt(SpKey.appStyleIndex, style.index);
  }

  Future<void> saveShowTool(bool show) async {
    await prefs.setBool(SpKey.showTool, show);
  }
}