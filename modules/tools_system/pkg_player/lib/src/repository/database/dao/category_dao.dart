import 'package:pkg_player/pkg_player.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDao {
  Future<int> insert(String key, String name, String description) async {
    final db = await PkgDatabaseHelper().database;
    return await db.insert('t_pkg_categories', {
      'key': key,
      'name': name,
      'description': description,
    });
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await PkgDatabaseHelper().database;
    return await db.query('t_pkg_categories');
  }

  Future<Map<String, dynamic>?> getByKey(String key) async {
    final db = await PkgDatabaseHelper().database;
    final result = await db.query('t_pkg_categories', where: 'key = ?', whereArgs: [key]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> update(int id, String key, String name, String description) async {
    final db = await PkgDatabaseHelper().database;
    return await db.update('t_pkg_categories', {
      'key': key,
      'name': name,
      'description': description,
    }, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    final db = await PkgDatabaseHelper().database;
    return await db.delete('t_pkg_categories', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await PkgDatabaseHelper().database;
    await db.delete('t_pkg_categories');
  }
}