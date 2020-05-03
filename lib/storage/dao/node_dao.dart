import 'package:flutter_unit/storage/app_storage.dart';

import '../po/node_po.dart';

class NodeDao {

  final  AppStorage storage;

  NodeDao(this.storage);

  Future<int> insert(NodePo widget) async {
    //插入方法
    final db = await storage.db;
    String addSql = //插入数据
        "INSERT INTO "
        "node(widgetId,name,priority,subtitle,code) "
        "VALUES (?,?,?,?,?);";
    return await db.transaction((tran) async => await tran.rawInsert(addSql, [
          widget.widgetId,
          widget.name,
          widget.priority,
          widget.subtitle,
          widget.code
        ]));
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    //插入方法
    final db = await storage.db;
    return await db.rawQuery("SELECT * "
        "FROM node");
  }

  //根据 id 查询组件 node
  Future<List<Map<String, dynamic>>> queryById(int id) async {
    final db = await storage.db;
    return await db.rawQuery(
        "SELECT name,subtitle,code "
        "FROM node "
        "WHERE widgetId = ? ORDER BY priority",
        [id]);
  }
}
