
import 'package:flutter_unit/model/enums.dart';
import 'package:sqflite/sqflite.dart';

import '../app_start.dart';
import '../bean/widget_po.dart';


class WidgetDao {

 final Database db;

 WidgetDao(this.db);

 Future<int> insert(WidgetPo widget) async {
    //插入方法
    String addSql = //插入数据
        "INSERT INTO "
        "widget(id,name,nameCN,deprecated,family,lever,linkWidget,info) "
        "VALUES (?,?,?,?,?,?,?,?);";
    return await db.transaction((tran) async => await tran.rawInsert(addSql, [
          widget.id,
          widget.name,
          widget.nameCN,
          widget.deprecated,
          widget.family,
          widget.lever,
          widget.linkWidget,
          widget.info
        ]));
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    return await db.rawQuery("SELECT * FROM widget");
  }

  Future<List<Map<String, dynamic>>> queryByFamily(WidgetFamily family) async {
    return await db.rawQuery(
        "SELECT * "
        "FROM widget WHERE family = ? ORDER BY lever DESC",
        [family.index]);
  }

  Future<List<Map<String, dynamic>>> queryByIds(List<int> ids) async {
    if (ids.length == 0) {
      return [];
    }
    String sql = "SELECT * "
        "FROM widget WHERE id in (${'?,' * (ids.length - 1)}?) ";

    return await db.rawQuery(sql, [...ids]);
  }

  Future<List<Map<String, dynamic>>> search(SearchArgs arguments) async {
    return await db.rawQuery(
        "SELECT * "
        "FROM widget WHERE name like ? AND lever IN(?,?,?,?,?) ORDER BY lever DESC",
        ["%${arguments.name}%", ...arguments.stars]);
  }
}

class SearchArgs {
  final String name;
  final List<int> stars;

  const SearchArgs({this.name = '', this.stars = const [-1, -1, -1, -1, -1]});
}
