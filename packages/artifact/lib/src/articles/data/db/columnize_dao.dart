import 'package:sqflite/sqflite.dart';

import '../exp.dart';



class ColumnizeDao {
  final Database database;

  ColumnizeDao(this.database);

  // 表名
  static const String kTableName = 'columnize';

  Future<int> insert(Columnize po) => database.insert(
    kTableName,
    po.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  Future<int> insertOrUpdate(Columnize po) async {
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

  Future<List<Columnize>> query({
    int page = 1,
    int pageSize = 20,
    String? filter,
  }) async {
    String queryArgs = '';
    List<dynamic> args = [];
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

    List<Columnize> result = data.map(Columnize.fromDb).toList();
    return result;
  }
}
