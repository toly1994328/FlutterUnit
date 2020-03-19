
import 'po/widget_po.dart';

import 'flutter_db.dart';

class WidgetDao {
  Future<int> insert(WidgetPo widget) async {
    //插入方法
    final db = await FlutterDb.db.database;
    String addSql = //插入数据
        "INSERT INTO "
        "widget(id,name,nameCN,childCount,family,lever,image,info) "
        "VALUES (?,?,?,?,?,?,?,?);";
    return await db.transaction((tran) async => await tran.rawInsert(addSql, [
          widget.id,
          widget.name,
          widget.nameCN,
          widget.childCount,
          widget.family,
          widget.lever,
          widget.image,
          widget.info
        ]));
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    //插入方法
    final db = await FlutterDb.db.database;
    return await db.rawQuery("SELECT * "
        "FROM widget");
//    var list = data.map((e)=>WidgetPo.fromJson(e)).toList();
//    return list;
  }
}
