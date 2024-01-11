
import 'package:sqflite/sqflite.dart';
import 'package:widget_module/widget_module.dart';


import '../models/widget_po.dart';


class WidgetDao {

 final Database db;

 WidgetDao(this.db);

 Future<int> insert(WidgetPo widget) async {
    //插入方法
    String addSql = //插入数据
        "INSERT INTO "
        "widget(id,name,nameCN,deprecated,family,lever,linkWidget,info) "
        "VALUES (?,?,?,?,?,?,?,?);";
    return db.transaction((tran) async => await tran.rawInsert(addSql, [
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
    return db.rawQuery("SELECT * FROM widget");
  }

  Future<List<Map<String, dynamic>>> queryByFamily(WidgetFamily family) async {
    return db.rawQuery(
        "SELECT * "
        "FROM widget WHERE family = ? ORDER BY lever DESC",
        [family.index]);
  }

  Future<List<Map<String, dynamic>>> queryByIds(List<int> ids) async {
    if (ids.isEmpty) {
      return [];
    }
    String sql = "SELECT * "
        "FROM widget WHERE id in (${'?,' * (ids.length - 1)}?) ";

    return db.rawQuery(sql, [...ids]);
  }

  Future<List<Map<String, dynamic>>> search(WidgetFilter arguments) async {
    // 保证 name 参数为空时，不进行搜索
    if (arguments.name.isEmpty) {
      return [];
    }

    // _表示 name 任意
    String name = arguments.name == '*' ? '' : arguments.name;
    bool hasFamily = arguments.family != null;
    String familySql = hasFamily ? ' AND family = ?' : '';
    List<int> familyArg = hasFamily ? [arguments.family!.index] : [];
    List<int> starArg = arguments.stars;
    // 保证在星级参数是 [-1,-1,-1,-1,-1] 时，搜索全星级
    if (arguments.stars.reduce((a, b) => a + b) == -5) {
      starArg = [1, 2, 3, 4, 5];
    }
    return db.rawQuery(
        "SELECT * "
        "FROM widget WHERE name like ?$familySql AND lever IN(?,?,?,?,?) ORDER BY lever DESC LIMIT ? OFFSET ?",
        ["%$name%", ...familyArg, ...starArg, arguments.pageSize, arguments.offset]);
  }

  Future<int> total(WidgetFilter args) async{
    bool hasFamily = args.family != null;
    String familySql = hasFamily ? 'family = ?' : '';
    List<int> familyArg = hasFamily ? [args.family!.index] : [];

    String sql = "SELECT count(id) as `count` FROM widget WHERE $familySql";

    List<Map<String, Object?>> result = await db.rawQuery(sql,familyArg);
    if(result.isNotEmpty){
      return result.first['count'] as int ??0;
    }
    return 0;

  }

 Future<Map<String, dynamic>?> queryWidgetByName(String name) async{
   String sql = "SELECT * FROM widget WHERE name = ?";
   List<Map<String, Object?>> result = await db.rawQuery(sql, [name]);
   if(result.isNotEmpty){
     return result.first;
   }
   return null;
 }
}


