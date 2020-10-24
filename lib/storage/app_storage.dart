import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/res/sp.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 本地存储访问对象,用于读取配置数据，及初始化Database和SharedPreferences

class AppStorage {
  SharedPreferences _sp;
  Database _database;

  Future<SharedPreferences> get sp async {
    _sp = _sp ?? await SharedPreferences.getInstance();
    return _sp;
  }

  Future<Database> get db async {
    _database = _database ?? await initDb();
    return _database;
  }

  // 初始化 App 固化的配置数据
  Future<GlobalState> initApp() async {
    SharedPreferences prefs = await sp;
    _database = await initDb();

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

  // 初始化数据库
  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, "flutter.db");
    bool exists = await databaseExists(dbPath);
    const isPro = bool.fromEnvironment('dart.vm.product'); //是否release模式

    if (!isPro) {
      if (!exists) {
        await Directory(path.dirname(dbPath)).create(recursive: true);
      }
      ByteData data = await rootBundle.load(path.join("assets", "flutter.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
      print("==== debug ===== assets ======拷贝完成====");
      return await openDatabase(dbPath, readOnly: false);
    }

    if (!exists) {
      await Directory(path.dirname(dbPath)).create(recursive: true);
      ByteData data = await rootBundle.load(path.join("assets", "flutter.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
      print("==== release ===== assets ======拷贝完成====");
    } else {
      print("========= 数据库 ======已存在====");
    }
    return await openDatabase(dbPath, readOnly: false);
  }
}
