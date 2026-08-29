import 'package:flutter_test/flutter_test.dart';
import 'package:widget_repository/src/database/po/category_po.dart';

void main() {
  group('CategoryPo 云端快照', () {
    test('历史收藏集缺少 type 时恢复为系统收藏类型', () {
      final CategoryPo category = CategoryPo.fromNetJson({
        'id': 1,
        'name': '收藏集',
        'color': '#FFF2F2F2',
        'created': 1755964304725,
        'updated': 1755964304725,
        'image': '',
        'priority': 0,
        'count': 12,
        'info': '收藏的组件',
      });

      expect(category.type, 1);
      expect(category.toJson()['type'], 1);
    });

    test('普通历史分类缺少 type 时保持普通类型', () {
      final CategoryPo category = CategoryPo.fromNetJson({
        'id': 12,
        'name': '布局集',
        'color': '#FF4CAF50',
        'created': 1755964304722,
        'updated': 1755964304722,
        'image': '',
        'priority': 0,
        'count': 38,
        'info': '布局组件',
      });

      expect(category.type, 0);
    });
  });
}
