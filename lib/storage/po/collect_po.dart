import 'package:equatable/equatable.dart';

/// create by 张风捷特烈 on 2020-04-17
/// contact me by email 1981462002@qq.com
/// 说明:

//  static const String sql_create_collect = """
// CREATE TABLE IF NOT EXISTS category_widget(
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name VARCHAR(64) NOT NULL,
//     color VARCHAR(9) DEFAULT '#FF2196F3',
//     info VARCHAR(256) DEFAULT '这里什么都没有...',
//     created DATETIME NOT NULL,
//     updated DATETIME NOT NULL,
//     priority INTEGER DEFAULT 0,
//     image VARCHAR(128) NULL image DEFAULT ''
//     );"""; //建表语句

class CollectPo extends Equatable {
  final int id;
  final String name;
  final int color;
  final String info;
  final DateTime created;
  final DateTime updated;
  final String image;
  final int priority;

  const CollectPo({this.id, this.name, this.color, this.created, this.updated,this.priority,this.info,this.image});

  factory CollectPo.fromJson(Map<String, dynamic> map) {
    return CollectPo(
        id: map['id'],
        name: map['name'],
        color: map["color"],
        created: map["created"],
        image: map["image"],
        priority: map["priority"],
        updated: map["updated"],
        info: map["info"]);
  }


  @override
  String toString() {
    return 'CollectPo{id: $id, name: $name, color: $color, info: $info, created: $created, updated: $updated, image: $image, priority: $priority}';
  }

  @override
  List<Object> get props =>
      [id, name, color, created, image, info,updated,priority];
}
