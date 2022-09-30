import 'package:sqflite/sqflite.dart';

class LikeDao {
  final Database db;

  LikeDao(this.db);

  Future<List<int>> likeWidgetIds() async {
    var result = await db.rawQuery("SELECT widget_id FROM like_widget");
    var ids = result.map<int>((e) => e['widget_id'] as int).toList();
    return ids;
  }

  // 如果已喜欢，取消喜欢
  // 如果未喜欢，设为喜欢
  Future<void> toggleCollect(int widgetId) async {
    bool liked = await isLiked(widgetId);

    if (liked) {
      await unlike(widgetId, check: false);
    } else {
      await like(widgetId, check: false);
    }
  }

  Future<int> like(int widgetId, {bool check = true}) async {
    if (check) {
      // 如果 liked_widget_bloc ，直接取消，不执行 liked_widget_bloc 操作
      bool liked = await isLiked(widgetId);
      if (liked) return 0;
    }

    return await db.rawInsert(
        "INSERT INTO "
        "like_widget(widget_id) "
        "VALUES (?);",
        [widgetId]);
  }

  Future<void> unlike(int widgetId, {bool check = true}) async {
    if (check) {
      // 如果未 liked_widget_bloc ，直接取消，不执行 unlike 操作
      bool liked = await isLiked(widgetId);
      if (!liked) return;
    }
    await db.execute(
        "DELETE FROM like_widget "
        "WHERE widget_id = ?",
        [widgetId]);
  }

  // 判断组件是否已 liked
  Future<bool> isLiked(int widgetId) async {
    var data = await db.rawQuery(
        "Select count(id) as `count` FROM like_widget "
        "WHERE widget_id = ?",
        [widgetId]);
    if (data.isNotEmpty) {
      var result = data[0];
      return result['count'] as int > 0;
    }
    return false;
  }
}
