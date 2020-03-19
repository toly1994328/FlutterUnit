//persistent object 持久层对象，
// 用于与数据库中记录对用的对象

import 'package:equatable/equatable.dart';

class WidgetPo extends Equatable {
  final int id;
  final String name;
  final String nameCN;
  final int childCount;
  final int family;
  final double lever;
  final String image;
  final String info;

  const WidgetPo(
      {this.id,
      this.name,
      this.nameCN,
      this.childCount,
      this.family,
      this.lever,
      this.image,
      this.info});

  factory WidgetPo.fromJson(Map<String, dynamic> map) {
    return WidgetPo(
        id: map['id'],
        name: map['name'],
        nameCN: map["nameCN"],
        family: map["family"],
        childCount: map["childCount"],
        lever: map["lever"],
        image: map["image"],
        info: map["info"]);
  }

  @override
  String toString() {
    return 'WidgetPo{id: $id, name: $name, nameCN: $nameCN, childCount: $childCount, family: $family, lever: $lever, image: $image, info: $info}';
  }

  @override
  List<Object> get props =>
      [id, name, nameCN, childCount, family, lever, image, info];
}
