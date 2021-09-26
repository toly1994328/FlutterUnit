import 'dao/like_dao.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import 'dao/category_dao.dart';
import 'dao/node_dao.dart';
import 'dao/widget_dao.dart';

class LocalDb {
  Database? _database;

  LocalDb._();

  static LocalDb instance = LocalDb._();

  late WidgetDao _widgetDao;
  late CategoryDao _categoryDao;
  late NodeDao _nodeDao;
  late LikeDao _likeDao;

  WidgetDao get widgetDao => _widgetDao;

  CategoryDao get categoryDao => _categoryDao;

  NodeDao get nodeDao => _nodeDao;

  LikeDao get likeDao => _likeDao;

  Database get db => _database!;

  Future<void> initDb({String name = "flutter.db"}) async {
    if (_database != null) return;
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, name);

    _database = await openDatabase(dbPath);

    _widgetDao = WidgetDao(_database!);
    _categoryDao = CategoryDao(_database!);
    _nodeDao = NodeDao(_database!);
    _likeDao = LikeDao(_database!);

    print('初始化数据库....');
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }
}
