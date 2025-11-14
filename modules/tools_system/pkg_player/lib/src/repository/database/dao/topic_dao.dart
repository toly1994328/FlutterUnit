import 'package:pkg_player/pkg_player.dart';
import 'package:sqflite/sqflite.dart';

class TopicDao {
  Future<int> insertOrGet(String topicName) async {
    final db = await PkgDatabaseHelper().database;

    // 先查询是否存在
    final result = await db
        .query('t_pkg_topics', where: 'name = ?', whereArgs: [topicName]);
    if (result.isNotEmpty) {
      return result.first['id'] as int;
    }

    // 不存在则插入
    return await db.insert('t_pkg_topics', {'name': topicName});
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await PkgDatabaseHelper().database;
    return await db.query('t_pkg_topics');
  }

  Future<void> deleteAll() async {
    final db = await PkgDatabaseHelper().database;
    await db.delete('t_pkg_topics');
  }
}
