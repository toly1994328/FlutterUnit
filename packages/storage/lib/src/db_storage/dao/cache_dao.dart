import 'package:sqflite/sqflite.dart';

import '../models/cache_po.dart';

class CacheDao {
  final Database database;

  CacheDao(this.database);

  // 表名
  static const String kTableName = 'app_cache';

  static const String createTable = """
CREATE TABLE IF NOT EXISTS `$kTableName` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT,
`filter` TEXT,
`content` TEXT,
`update` INTEGER,
`create` INTEGER,  
`type` INTEGER
)""";

  static Future<void> createDb(Database db) => db.execute(createTable);

  Future<int> insert(CachePo po) => database.insert(
        kTableName,
        po.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  Future<int> insertOrUpdate(CachePo po) async {
    bool canUpdate = await shouldUpdate(po.id, po.update);
    return database.insert(
      kTableName,
      po.toJson(),
      conflictAlgorithm:
          canUpdate ? ConflictAlgorithm.replace : ConflictAlgorithm.ignore,
    );
  }

  /// 当前数据是否需要更新
  Future<bool> shouldUpdate(int id, int updateAt) async {
    List<Map<String, dynamic>> data = await database
        .rawQuery("SELECT `update` FROM $kTableName WHERE id = ?", [id]);
    // 没有数据，可以更新
    if (data.isEmpty) {
      return true;
    }
    // 服务器中数据更新时间，大于本地数据库内容，可以更新
    return updateAt > data.first['update'];
  }

  Future<List<CachePo>> query({
    required int type,
    int page = 1,
    int pageSize = 20,
    String? filter,
  }) async {
    String queryArgs = '';
    List<dynamic> args = [type];
    queryArgs = "WHERE type = ? ";
    if(filter!=null){
      queryArgs+="AND filter = ? ";
      args.add(filter);
    }
    queryArgs += 'LIMIT ? OFFSET ?';
    args.addAll([pageSize, (page - 1) * pageSize]);

    List<Map<String, dynamic>> data = await database.rawQuery(
      "SELECT * FROM $kTableName $queryArgs",
      args,
    );

    List<CachePo> result = data.map((e) => CachePo.fromJson(e)).toList();
    return result;
  }
}

//  final String id;
//   final String title;
//   final String content;
//   final int type;
//   final int create;
//   final int update;
