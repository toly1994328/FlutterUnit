import 'package:fx_dao/fx_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../model/article.dart';

class ArticleDao extends Dao {
  @override
  String get createSql => '';

  @override
  String get name => 'article';

  Future<int> insert(Article po) => database.insert(
        name,
        po.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  Future<int> insertOrUpdate(Article po) async {
    bool canUpdate = await shouldUpdate(po.id, po.update);
    return database.insert(
      name,
      po.toJson(),
      conflictAlgorithm:
          canUpdate ? ConflictAlgorithm.replace : ConflictAlgorithm.ignore,
    );
  }

  /// 当前数据是否需要更新
  Future<bool> shouldUpdate(int id, int updateAt) async {
    List<Map<String, dynamic>> data = await database
        .rawQuery("SELECT `update` FROM $name WHERE id = ?", [id]);
    // 没有数据，可以更新
    if (data.isEmpty) {
      return true;
    }
    // 服务器中数据更新时间，大于本地数据库内容，可以更新
    return updateAt > data.first['update'];
  }

  Future<List<Article>> query(ArticleFilter filter) async {
    String queryArgs = '';
    List<dynamic> args = [];
    if (filter.filter != null) {
      queryArgs += "AND filter = ? ";
      args.add(filter.filter);
    }
    if (filter.groupId != null) {
      if (queryArgs.isEmpty) {
        queryArgs += 'WHERE groupId = ? ';
      } else {
        queryArgs += "AND groupId = ? ";
      }
      args.add(filter.groupId);
    }
    queryArgs += 'LIMIT ? OFFSET ?';
    args.addAll([filter.pageSize, filter.offset]);

    List<Map<String, dynamic>> data = await database.rawQuery(
      "SELECT * FROM $name $queryArgs",
      args,
    );

    List<Article> result = data.map(Article.fromDb).toList();
    return result;
  }

  Future<int> total(ArticleFilter filter) async {
    bool hasGroupId = filter.groupId != null;
    String familySql = hasGroupId ? 'WHERE groupId = ?' : '';
    List<int> familyArg = hasGroupId ? [filter.groupId!] : [];

    String sql = "SELECT count(id) as `count` FROM article $familySql";

    List<Map<String, Object?>> result = await database.rawQuery(sql, familyArg);
    if (result.isNotEmpty) {
      return result.first['count'] as int ?? 0;
    }
    return 0;
  }

  @override
  Convertor<Article> get convertor => Article.fromDb;

  @override
  Future<int> update(String id, Article frame) async {
    return 0;
  }
}
