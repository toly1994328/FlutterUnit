
import 'package:sqflite/sqflite.dart';
import '../models/category_po.dart';

//"""
// CREATE TABLE IF NOT EXISTS category_widget(
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name VARCHAR(64) NOT NULL,
//     color VARCHAR(9) DEFAULT '#FF2196F3',
//     info VARCHAR(256) DEFAULT '这里什么都没有...',
//     created DATETIME NOT NULL,
//     updated DATETIME NOT NULL,
//     priority INTEGER DEFAULT 0,
//     image VARCHAR(128) NULL image DEFAULT ''
//     );
//""";

class CategoryDao {
  final Database db;

  CategoryDao(this.db);



  Future<int> insert(CategoryPo category) async {
    //插入方法
    String addSql = //插入数据
        "INSERT INTO "
        "category(id,name,color,info,priority,image,created,updated) "
        "VALUES (?,?,?,?,?,?,?,?);";
    return await db.transaction((tran) async => await tran.rawInsert(addSql, [
      category.id,
          category.name,
          category.color,
          category.info,
          category.priority,
          category.image,
          category.created?.toIso8601String(),
          category.updated.toIso8601String(),
        ]));
  }

  Future<int> update(CategoryPo widget) async {
    //插入方法
    String updateSql = //插入数据
        "UPDATE category SET name=? , color=? ,info=?, priority=?,image=?,updated=? "
        "WHERE id = ?";

    return await db.transaction((tran) async =>
    await tran.rawUpdate(updateSql, [
      widget.name,
      widget.color,
      widget.info,
      widget.priority,
      widget.image,
      widget.updated.toIso8601String(),
      widget.id,
    ]));
  }



  Future<int> addWidget(int categoryId,int widgetId,) async {
    String addSql = //插入数据
        "INSERT INTO "
        "category_widget(widgetId,categoryId) "
        "VALUES (?,?);";
    return await db.transaction((tran) async => await tran.rawInsert(addSql, [
      widgetId,
      categoryId,
    ]));
  }

  Future<int> addWidgets(int categoryId,List<dynamic> widgetIds) async {
    String addSql = //插入数据
        "INSERT INTO "
        "category_widget(widgetId,categoryId) VALUES ";

    String args = '';

    for(int i=0;i< widgetIds.length;i++){
      args+= "(${widgetIds[i]},$categoryId)";
      if(i==widgetIds.length-1){
        args+=";";
      }else{
        args+=",";
      }
    }
    addSql += args;
    return await db.transaction((tran) async => await tran.rawInsert(addSql));
  }

  Future<bool> existByName(String name) async {
    String sql = //插入数据
        "SELECT COUNT(name) as count FROM category "
        "WHERE name = ?";
    List<Map<String, dynamic>> rawData = await db.rawQuery(sql, [name]);
    if (rawData.isNotEmpty) {
      return rawData[0]['count'] > 0;
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    List<Map<String, dynamic>> data = await db.rawQuery(
        "SELECT c.id,c.name,c.info,c.color,c.image,c.created,c.updated,c.priority,COUNT(cw.categoryId) as `count`"
            "FROM category AS c "
            "LEFT JOIN category_widget AS cw "
            "ON c.id = cw.categoryId GROUP BY c.id "
            "ORDER BY priority DESC,created DESC",
        []);
    return data;
  }

  Future<List<int>> categoryWidgetIds(int id) async {
    List<Map<String, dynamic>> data = await db.rawQuery(
        "SELECT categoryId FROM `category_widget`"
            "WHERE widgetId = ?",
        [id]);
    return data.toList().map<int>((e)=>e["categoryId"]).toList();
  }



  Future<void> deleteCollect(int id) async {
    await db.execute(
        "DELETE FROM category_widget "
            "WHERE categoryId = ?",
        [id]);
    return await db.execute(
        "DELETE FROM category "
            "WHERE id = ?",
        [id]);
  }

  Future<void> clear() async {
    await db.execute(
        "DELETE FROM category_widget "
            "WHERE categoryId >0");
    return await db.execute(
        "DELETE FROM category "
            "WHERE id > 0");
  }

  Future<int> removeWidget(int categoryId, int widgetId) async {
    //插入方法
    String deleteSql = //插入数据
        "DELETE FROM "
        "category_widget WHERE categoryId = ? AND widgetId = ? ";
    return await db
        .transaction((tran) async => await tran.rawInsert(deleteSql, [
      categoryId,
      widgetId,
    ]));
  }

  Future<bool> existWidgetInCollect(int categoryId, int widgetId) async {
    String sql = //插入数据
        "SELECT COUNT(id) as count FROM category_widget "
        "WHERE categoryId = ? AND widgetId = ?";
    List<Map<String, dynamic>> rawData = await db.rawQuery(sql, [categoryId, widgetId]);
    if (rawData.isNotEmpty) {
      return rawData[0]['count'] > 0;
    }
    return false;
  }

  Future<void> toggleCollect(int categoryId, int widgetId) async {
    if (await existWidgetInCollect(categoryId, widgetId)) {
      //已存在: 移除
      await removeWidget(categoryId, widgetId);
    } else {
      await addWidget(categoryId, widgetId);
    }
  }

  Future<void> toggleCollectDefault(int widgetId) async {
    await toggleCollect(1, widgetId);
  }

  Future<List<Map<String, dynamic>>> loadCollectWidgets(int categoryId) async{
    String querySql = //插入数据
        "SELECT * FROM widget "
        "WHERE id IN (SELECT widgetId FROM category_widget WHERE categoryId = ?) "
        "ORDER BY lever DESC";

    return await db.rawQuery(querySql,[categoryId]);
  }

  Future<List<int>> loadCollectWidgetIds(int categoryId) async{
    String querySql = //插入数据
        "SELECT id FROM widget "
        "WHERE id IN (SELECT widgetId FROM category_widget WHERE categoryId = ?) "
        "ORDER BY lever DESC";

    var data = await db.rawQuery(querySql,[categoryId]);
    return data.map<int>((e) => e["id"] as int).toList();
  }
}
