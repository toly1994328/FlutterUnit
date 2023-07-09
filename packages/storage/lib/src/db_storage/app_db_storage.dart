import 'dart:async';
import 'dart:io';

import 'package:storage/storage.dart';

import 'dao/cache_dao.dart';
import 'helper/db_open_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'update/db_updater.dart';


class AppDbStorage {
  Database? _database;

  AppDbStorage._();

  static AppDbStorage instance = AppDbStorage._();

  late CacheDao _cacheDao;

  CacheDao get cacheDao => _cacheDao;

  Database get db => _database!;

  Future<void> initDb({String name = "flutter_unit.db"}) async {
    if (_database != null) return;
    String databasesPath = await DbOpenHelper.getDbDirPath();
    String dbPath = path.join(databasesPath, name);

    if (Platform.isWindows||Platform.isLinux) {
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      _database = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
            version: DbUpdater.version,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onOpen: _onOpen
        ),
      );
    }else{
      _database = await openDatabase(dbPath,
      version:  DbUpdater.version ,
      onCreate: _onCreate,
          onUpgrade: _onUpgrade,
        onOpen: _onOpen,
      );
    }

  }

  DbUpdater updater = DbUpdater();

  FutureOr<void> _onCreate(Database db, int version) async {
    print('数据库创建:flutter_unit....');
    await Future.wait([
      CacheDao.createDb(db),
      updater.update(db, 1, DbUpdater.version)
    ]);
  }

  FutureOr<void> _onOpen(Database db) {
    print('数据库打开:flutter_unit....');
    _database = db;
    _cacheDao = CacheDao(db);
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('数据库更新:flutter_unit....$oldVersion -> $newVersion');
    await updater.update(db, oldVersion, newVersion);
  }

}
