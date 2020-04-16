//persistent object 持久层对象，
// 用于与数据库中记录对用的对象

import 'package:equatable/equatable.dart';

class WidgetPo extends Equatable {
  final int id;
  final String name;
  final String nameCN;
  final int collected;
  final int family;
  final double lever;
  final String image;
  final String info;
  final String linkWidget;

  const WidgetPo(
      {this.id,
      this.name,
      this.nameCN,
      this.collected,
      this.family,
      this.lever,
      this.linkWidget,
      this.image,
      this.info});

  factory WidgetPo.fromJson(Map<String, dynamic> map) {
    return WidgetPo(
        id: map['id'],
        name: map['name'],
        nameCN: map["nameCN"],
        family: map["family"],
        collected: map["collected"]??0,
        lever: map["lever"].toDouble(),
        image: map["image"],
        linkWidget: map["linkWidget"],
        info: map["info"]);
  }

  @override
  String toString() {
    return 'WidgetPo{id: $id, name: $name, nameCN: $nameCN, collected: $collected, family: $family, lever: $lever, image: $image, info: $info}';
  }

  @override
  List<Object> get props =>
      [id, name, nameCN, collected, family, lever, image, info];
}
