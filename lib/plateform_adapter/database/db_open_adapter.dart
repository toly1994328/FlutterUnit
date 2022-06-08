import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

mixin DbOpenAdapter{
  Database? _database;

  Future<void> initDb({String name = "flutter.db"}) async {
    if (_database != null) return;
    if(Platform.isAndroid||Platform.isMacOS||Platform.isIOS){
      String databasesPath = await getDatabasesPath();
      String dbPath = path.join(databasesPath, name);
      _database = await openDatabase(dbPath);

    }

    if(Platform.isWindows||Platform.isLinux){
      // Directory current = await getApplicationSupportDirectory();
      // databasesPath = path.join(
      //   current.parent.path,
      //   'example',
      //   'myap',
      // );
      // print(databasesPath);
      // DatabaseFactory databaseFactory = databaseFactoryFfi;
      // dbPath = path.join(databasesPath, name);
      //
      // _database = await databaseFactory.openDatabase(
      //   dbPath,
      //   options: OpenDatabaseOptions(
      //       version: DbUpdater.VERSION,
      //       onCreate: _onCreate,
      //       onUpgrade: _onUpgrade,
      //       onOpen: _onOpen),
      // );
    }

    print('初始化数据库....');
  }

}