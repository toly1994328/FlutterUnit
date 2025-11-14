import 'package:pkg_player/pkg_player.dart';
import 'package:sqflite/sqflite.dart';

class PackageDao {
  Future<int> insert(Map<String, dynamic> package) async {
    final db = await PkgDatabaseHelper().database;
    return await db.insert('t_pkg_packages', package);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await PkgDatabaseHelper().database;
    return await db.query('t_pkg_packages');
  }

  Future<Map<String, dynamic>?> getByName(String name) async {
    final db = await PkgDatabaseHelper().database;
    final result =
        await db.query('t_pkg_packages', where: 'name = ?', whereArgs: [name]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getByCategory(int categoryId) async {
    final db = await PkgDatabaseHelper().database;
    return await db.rawQuery('''
      SELECT p.* FROM t_pkg_packages p
      JOIN t_pkg_package_categories pc ON p.id = pc.package_id
      WHERE pc.category_id = ?
    ''', [categoryId]);
  }

  Future<int> update(int id, Map<String, dynamic> package) async {
    final db = await PkgDatabaseHelper().database;
    return await db
        .update('t_pkg_packages', package, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    final db = await PkgDatabaseHelper().database;
    return await db.delete('t_pkg_packages', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await PkgDatabaseHelper().database;
    await db.delete('t_pkg_packages');
  }

  Future<void> insertTags(int packageId, List<String> tags) async {
    final db = await PkgDatabaseHelper().database;
    final batch = db.batch();
    for (String tag in tags) {
      // 先获取或创建标签ID
      final result =
          await db.query('t_pkg_tags', where: 'name = ?', whereArgs: [tag]);
      int tagId;
      if (result.isNotEmpty) {
        tagId = result.first['id'] as int;
      } else {
        tagId = await db.insert('t_pkg_tags', {'name': tag});
      }
      batch.insert(
          't_pkg_package_tags', {'package_id': packageId, 'tag_id': tagId});
    }
    await batch.commit();
  }

  Future<void> insertTopics(int packageId, List<String> topics) async {
    final db = await PkgDatabaseHelper().database;
    final batch = db.batch();
    for (String topic in topics) {
      // 先获取或创建主题ID
      final result =
          await db.query('t_pkg_topics', where: 'name = ?', whereArgs: [topic]);
      int topicId;
      if (result.isNotEmpty) {
        topicId = result.first['id'] as int;
      } else {
        topicId = await db.insert('t_pkg_topics', {'name': topic});
      }
      batch.insert('t_pkg_package_topics',
          {'package_id': packageId, 'topic_id': topicId});
    }
    await batch.commit();
  }

  Future<void> insertDependencies(
      int packageId, Map<String, dynamic> dependencies) async {
    final db = await PkgDatabaseHelper().database;
    final batch = db.batch();
    dependencies.forEach((name, version) {
      batch.insert('t_pkg_package_dependencies', {
        'package_id': packageId,
        'dependency_name': name,
        'version_constraint': version?.toString() ?? '',
      });
    });
    await batch.commit();
  }

  Future<List<String>> getTags(int packageId) async {
    final db = await PkgDatabaseHelper().database;
    final result = await db.rawQuery('''
      SELECT t.name FROM t_pkg_tags t
      JOIN t_pkg_package_tags pt ON t.id = pt.tag_id
      WHERE pt.package_id = ?
    ''', [packageId]);
    return result.map((row) => row['name'] as String).toList();
  }

  Future<List<String>> getTopics(int packageId) async {
    final db = await PkgDatabaseHelper().database;
    final result = await db.rawQuery('''
      SELECT t.name FROM t_pkg_topics t
      JOIN t_pkg_package_topics pt ON t.id = pt.topic_id
      WHERE pt.package_id = ?
    ''', [packageId]);
    return result.map((row) => row['name'] as String).toList();
  }

  Future<Map<String, String>> getDependencies(int packageId) async {
    final db = await PkgDatabaseHelper().database;
    final result = await db.query('t_pkg_package_dependencies',
        where: 'package_id = ?', whereArgs: [packageId]);
    return Map.fromEntries(result.map((row) => MapEntry(
        row['dependency_name'] as String,
        row['version_constraint'] as String)));
  }

  Future<void> insertPackageCategory(int packageId, int categoryId) async {
    final db = await PkgDatabaseHelper().database;
    await db.insert('t_pkg_package_categories', {
      'package_id': packageId,
      'category_id': categoryId,
    });
  }
}
