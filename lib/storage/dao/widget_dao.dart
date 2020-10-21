import 'package:flutter_unit/storage/app_storage.dart';
import 'package:flutter_unit/app/enums.dart';

import '../po/widget_po.dart';


class WidgetDao {

 final  AppStorage storage;


 WidgetDao(this.storage);

 Future<int> insert(WidgetPo widget) async {
    //插入方法
    final db = await storage.db;
    String addSql = //插入数据
        "INSERT INTO "
        "widget(id,name,nameCN,collected,family,lever,image,linkWidget,info) "
        "VALUES (?,?,?,?,?,?,?,?,?);";
    return await db.transaction((tran) async => await tran.rawInsert(addSql, [
          widget.id,
          widget.name,
          widget.nameCN,
          widget.collected,
          widget.family,
          widget.lever,
          widget.image,
          widget.linkWidget,
          widget.info
        ]));
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await storage.db;
    return await db.rawQuery("SELECT * "
        "FROM widget");
  }

  Future<List<Map<String, dynamic>>> queryByFamily(WidgetFamily family) async {
    final db = await storage.db;
    return await db.rawQuery(
        "SELECT * "
        "FROM widget WHERE family = ? ORDER BY lever DESC",
        [family.index]);
  }

  Future<List<Map<String, dynamic>>> queryByIds(List<int> ids) async {
    if (ids.length == 0) {
      return [];
    }
    final db = await storage.db;

    String sql = "SELECT * "
        "FROM widget WHERE id in (${'?,' * (ids.length - 1)}?) ";

    return await db.rawQuery(sql, [...ids]);
  }

  Future<List<Map<String, dynamic>>> search(SearchArgs arguments) async {
    final db = await storage.db;
    return await db.rawQuery(
        "SELECT * "
        "FROM widget WHERE name like ? AND lever IN(?,?,?,?,?) ORDER BY lever DESC",
        ["%${arguments.name}%", ...arguments.stars]);
  }

  Future<List<Map<String, dynamic>>> toggleCollect(int id) async {
    final db = await storage.db;
    List<Map<String, dynamic>> data = await db.rawQuery('SELECT collected FROM widget WHERE id = ?', [id]);
    bool collected = data.toList()[0]['collected']==1;
    return await db.rawQuery(
        "UPDATE widget SET collected = ? "
        "WHERE id = ?",
        [collected ? 0 : 1, id]);
  }

  Future<List<Map<String, dynamic>>> queryCollect() async {
    final db = await storage.db;
    return await db.rawQuery("SELECT * "
        "FROM widget WHERE collected = 1 ORDER BY family,lever DESC");
  }

 Future<bool> collected(int id) async {
   final db = await storage.db;
   List<Map<String, dynamic>> data = await db.rawQuery("SELECT collected "
       "FROM widget WHERE id = ?");

   if(data.length>0){
     return data[0]['collected'] == 1;
   }
   return false;
 }

}

class SearchArgs {
  final String name;
  final List<int> stars;

  const SearchArgs({this.name = '', this.stars = const [-1, -1, -1, -1, -1]});
}
