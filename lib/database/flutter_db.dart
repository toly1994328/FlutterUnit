import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FlutterDb {
  FlutterDb._(); //私有化构造
  static final FlutterDb db = FlutterDb._(); //提供实例

  static const db_name = "flutter.db"; //数据库名
  Database _database; //数据库
  Future<Database> get database async {
    //获取数据库对象
    _database = _database ?? await initDB();
    return _database;
  }

  static const String sql_create_widget = """
 CREATE TABLE IF NOT EXISTS widget(
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     name VARCHAR(64) NOT NULL UNIQUE,
     nameCN VARCHAR(12) NOT NULL,
     childCount INTEGER NOT NULL DEFAULT 0,
     family INTEGER NOT NULL,
     lever FLOAT(2) NOT NULL,
     image VARCHAR(128) NOT NULL,
     linkWidget TEXT DEFAULT '',
     info VARCHAR(256) NOT NULL
     );"""; //建表语句

  static const String sql_create_node = """
 CREATE TABLE IF NOT EXISTS node(
     id INTEGER PRIMARY KEY AUTOINCREMENT,
     widgetId INTEGER NOT NULL,
     name VARCHAR(64) NOT NULL,
     priority INTEGER DEFAULT 0,
     subtitle TEXT NOT NULL,
     code TEXT NOT NULL
     );"""; //建表语句

  Future<Database> initDB() async {
    //初始化数据库
    WidgetsFlutterBinding.ensureInitialized(); //初始化绑定
    String path = join(await getDatabasesPath(), db_name); //获取数据库路径
    return await openDatabase(
      //打开数据库
      path, //路径
      version: 1, //版本
      onOpen: (db) => print("数据库-------onOpen"),
      onUpgrade: (db, old, now) => print("数据库-------onUpgrade"),
      onCreate: (Database db, int version) async {
        print("数据库-------onCreate");
        await db.execute(sql_create_widget);
        await db.execute(sql_create_node);
      },
    );
  }
}