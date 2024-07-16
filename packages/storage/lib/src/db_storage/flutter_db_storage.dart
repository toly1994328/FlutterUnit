import 'dart:io';

import 'package:artifact/artifact.dart';
import 'package:flutter/foundation.dart';
import 'package:storage/storage.dart';

import 'helper/db_open_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class FlutterDbStorage {
  Database? _database;

  FlutterDbStorage._() {
    setupDatabase();
  }

  static FlutterDbStorage? _instance;

  static FlutterDbStorage get instance {
    _instance ??= FlutterDbStorage._();
    return _instance!;
  }

  void setupDatabase() {
    if (kIsWeb) return;
    if (Platform.isWindows || Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }

  late WidgetDao _widgetDao;
  late CategoryDao _categoryDao;
  late NodeDao _nodeDao;
  late LikeDao _likeDao;
  late ArticleDao _articleDao;
  late ColumnizeDao _columnizeDao;

  WidgetDao get widgetDao => _widgetDao;

  CategoryDao get categoryDao => _categoryDao;

  NodeDao get nodeDao => _nodeDao;

  LikeDao get likeDao => _likeDao;

  ArticleDao get articleDao => _articleDao;

  ColumnizeDao get columnizeDao => _columnizeDao;

  Database get db => _database!;

  Future<void> initDb({String name = "flutter.db"}) async {
    if (_database != null) return;
    String databasesPath = await DbOpenHelper.getDbDirPath();
    String dbPath = path.join(databasesPath, name);
    _database = await openDatabase(dbPath);
    _widgetDao = WidgetDao(_database!);
    _categoryDao = CategoryDao(_database!);
    _nodeDao = NodeDao(_database!);
    _likeDao = LikeDao(_database!);
    _articleDao = ArticleDao(_database!);
    _columnizeDao = ColumnizeDao(_database!);

    print('初始化数据库....');
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }
}
