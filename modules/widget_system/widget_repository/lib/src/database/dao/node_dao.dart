import 'package:fx_dao/fx_dao.dart';

import '../po/node_po.dart';

class NodeDao with HasDatabase, DbTable {
  @override
  String get createSql => '';

  @override
  String get name => 'node';

  Future<int> insert(NodePo widget) async {
    String addSql = "INSERT INTO "
        "node(widgetId,name,priority,subtitle,code) "
        "VALUES (?,?,?,?,?);";
    return await database.transaction((tran) async => await tran.rawInsert(
            addSql, [
          widget.widgetId,
          widget.name,
          widget.priority,
          widget.subtitle,
          widget.code
        ]));
  }

  Future<List<Map<String, dynamic>>> queryAll() async =>
      database.rawQuery("SELECT * FROM node");

  //根据 id 查询组件 node
  Future<List<Map<String, dynamic>>> queryById(int id, {String? locale}) async {
    String sql = """
SELECT 
  node.priority,
  node.code,
  node_desc.name, 
  node_desc.subtitle 
FROM node 
INNER JOIN node_desc 
  ON node.id = node_desc.node_id
WHERE node_desc.locale = ? 
AND node.widgetId = ?  
ORDER BY priority
""";

    return await database.rawQuery(sql, [locale ?? 'zh-cn', id]);
  }
}
