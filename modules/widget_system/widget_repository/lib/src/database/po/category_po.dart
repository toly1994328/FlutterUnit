/// create by 张风捷特烈 on 2020-04-17
/// contact me by email 1981462002@qq.com
/// 说明: 收藏夹数据库-数据模型
///
/// """
/// CREATE TABLE IF NOT EXISTS category(
///     id INTEGER PRIMARY KEY AUTOINCREMENT,
///     name VARCHAR(64) NOT NULL,
///     color VARCHAR(9) DEFAULT '#FF2196F3',
///     info VARCHAR(256) DEFAULT '这里什么都没有...',
///     created DATETIME NOT NULL,
///     updated DATETIME NOT NULL,
///     priority INTEGER DEFAULT 0,
///     image VARCHAR(128) NULL image DEFAULT ''
///     );"""; //建表语句
///
class CategoryPo {
  /// 分类记录 ID。
  final int? id;

  /// 分类名称。
  final String name;

  /// 分类类型，`1` 表示系统收藏集。
  final int type;

  /// 分类主题色。
  final String color;

  /// 分类说明。
  final String info;

  /// 创建时间。
  final DateTime? created;

  /// 最后更新时间。
  final DateTime updated;

  /// 分类图片地址。
  final String image;

  /// 分类中的组件数量。
  final int count;

  /// 分类排序值。
  final int priority;

  const CategoryPo({
    this.id,
    required this.name,
    this.type = 0,
    this.color = '#FFF2F2F2',
    this.created,
    required this.updated,
    this.count = 0,
    this.priority = 0,
    this.info = '这里什么都没有...',
    this.image = '',
  });

  factory CategoryPo.fromJson(Map<String, dynamic> map) {
    return CategoryPo(
        id: map['id'],
        name: map['name'],
        type: map['type'] ?? 0,
        color: map["color"],
        created: DateTime.parse(map["created"]),
        image: map["image"],
        priority: map["priority"],
        count: map["count"],
        updated: DateTime.parse(map["updated"]),
        info: map["info"]);
  }

  factory CategoryPo.fromNetJson(Map<String, dynamic> map) {
    final int? id = map['id'] as int?;
    final String name = map['name'] as String;
    return CategoryPo(
        id: id,
        name: name,
        type: map['type'] as int? ?? _legacyCategoryType(id, name),
        color: map["color"],
        created: DateTime.fromMillisecondsSinceEpoch(map["created"]),
        image: map["image"],
        priority: map["priority"],
        count: map["count"],
        updated: DateTime.fromMillisecondsSinceEpoch(map["updated"]),
        info: map["info"]);
  }

  Map toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "info": info,
        "created": created?.millisecondsSinceEpoch,
        "updated": updated.millisecondsSinceEpoch,
        "image": image,
        "count": count,
        "color": color,
        "priority": priority,
      };

  @override
  String toString() {
    return 'CategoryPo{id: $id, name: $name, color: $color, info: $info, created: $created, updated: $updated, image: $image, count: $count, priority: $priority}';
  }

  List<Object?> get props =>
      [id, name, type, color, created, image, info, updated, priority, count];
}

/// 兼容尚未携带 `type` 字段的历史云端快照。
int _legacyCategoryType(int? id, String name) {
  return id == 1 || name == '收藏集' ? 1 : 0;
}
