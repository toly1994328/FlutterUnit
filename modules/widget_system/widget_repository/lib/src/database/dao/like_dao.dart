import 'package:fx_dao/fx_dao.dart';

class LikeDao extends Dao {
  @override
  String get createSql => '';

  @override
  String get name => 'like_widget';

  Future<List<int>> likeWidgetIds() async {
    String sql = """
SELECT cw.widgetId as widget_id
FROM category c 
JOIN category_widget cw ON c.id = cw.categoryId 
WHERE c.type = 1;
    """;
    var result = await database.rawQuery(sql);
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
    String sql = """
INSERT INTO category_widget (categoryId, widgetId)
SELECT id, ? FROM category WHERE type = 1;
    """;

    return await database.rawInsert(sql, [widgetId]);
  }

  Future<void> unlike(int widgetId, {bool check = true}) async {
    if (check) {
      // 如果未 liked_widget_bloc ，直接取消，不执行 unlike 操作
      bool liked = await isLiked(widgetId);
      if (!liked) return;
    }
    String sql = """
DELETE FROM category_widget 
WHERE categoryId IN (SELECT id FROM category WHERE type = 1) 
AND widgetId = ?;
    """;
    await database.execute(sql, [widgetId]);
  }

  // 判断组件是否已 liked
  Future<bool> isLiked(int widgetId) async {
    String sql = """
SELECT EXISTS(
    SELECT 1 
    FROM category c 
    JOIN category_widget cw ON c.id = cw.categoryId 
    WHERE c.type = 1 AND cw.widgetId = ?
) as is_liked;
    """;
    var data = await database.rawQuery(sql, [widgetId]);
    if (data.isNotEmpty) {
      var result = data[0];
      return result['is_liked'] != 0;
    }
    return false;
  }
}
