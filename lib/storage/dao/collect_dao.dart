
import '../app_storage.dart';
import '../po/collect_po.dart';


//  static const String sql_create_collect = """
// CREATE TABLE IF NOT EXISTS collect(
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name VARCHAR(64) NOT NULL,
//     color VARCHAR(9) DEFAULT '#FF2196F3',
//     info VARCHAR(256) DEFAULT '这里什么都没有...',
//     created DATETIME NOT NULL,
//     updated DATETIME NOT NULL,
//     priority INTEGER DEFAULT 0,
//     image VARCHAR(128) NULL image DEFAULT ''
//     );""";

class CollectDao {

  final  AppStorage storage;

  CollectDao(this.storage);


  Future<int> insert(CollectPo widget) async {
    //插入方法
    final db = await storage.db;
    String addSql = //插入数据
        "INSERT INTO "
        "collect(name,color,info,priority,image,created,updated) "
        "VALUES (?,?,?,?,?,?,?);";
    return await db.transaction((tran) async => await tran.rawInsert(addSql, [
          widget.name,
          widget.color,
          widget.info,
          widget.priority,
          widget.image,
          widget.created.toIso8601String(),
          widget.updated.toIso8601String(),
        ]));
  }


  Future<List<Map<String, dynamic>>> queryAll() async {
    //插入方法
    final db = await storage.db;
    return await db.rawQuery("SELECT * "
        "FROM collect");
  }

}
