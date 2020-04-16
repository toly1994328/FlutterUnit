import 'package:equatable/equatable.dart';

/// create by 张风捷特烈 on 2020-04-17
/// contact me by email 1981462002@qq.com
/// 说明:

//1  动画组件集 ff000000 收录动画相关组件  2020-04-17

class CollectPo extends Equatable {
  final int id;
  final String name;
  final int color;
  final String info;
  final DateTime created;
  final String image;

  const CollectPo({this.id, this.name, this.color, this.created, this.info,this.image});

  factory CollectPo.fromJson(Map<String, dynamic> map) {
    return CollectPo(
        id: map['id'],
        name: map['name'],
        color: map["color"],
        created: map["created"],
        image: map["image"],
        info: map["info"]);
  }


  @override
  String toString() {
    return 'CollectPo{id: $id, name: $name, color: $color, info: $info, created: $created, image: $image}';
  }

  @override
  List<Object> get props =>
      [id, name, color, created, image, info];
}
