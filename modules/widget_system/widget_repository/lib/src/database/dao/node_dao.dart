import 'package:fx_dao/fx_dao.dart';

import '../po/node_po.dart';


class NodeDao with HasDatabase, DbTable {

  @override
  String get createSql => '';

  @override
  String get name => 'node';

  Future<int> insert(NodePo widget) async {
    //插入方法
    String addSql = //插入数据
        "INSERT INTO "
        "node(widgetId,name,priority,subtitle,code) "
        "VALUES (?,?,?,?,?);";
    return await database.transaction((tran) async => await tran.rawInsert(addSql, [
          widget.widgetId,
          widget.name,
          widget.priority,
          widget.subtitle,
          widget.code
        ]));
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    return await database.rawQuery("SELECT * FROM node");
  }

  //根据 id 查询组件 node
  Future<List<Map<String, dynamic>>> queryById(int id) async {
    return await database.rawQuery(
        "SELECT name,subtitle,code,priority "
        "FROM node "
        "WHERE widgetId = ? ORDER BY priority",
        [id]);
  }
}
