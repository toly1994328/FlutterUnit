
/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 组件信息-数据库-数据模型
///
import 'package:equatable/equatable.dart';

class WidgetPo extends Equatable {
  final int id;
  final String name;
  final String nameCN;
  final int deprecated;
  final int family;
  final double lever;
  final String info;
  final String linkWidget;

  const WidgetPo(
      {this.id,
      this.name,
      this.nameCN,
      this.deprecated,
      this.family,
      this.lever,
      this.linkWidget,
      this.info});

  factory WidgetPo.fromJson(Map<String, dynamic> map) {
    return WidgetPo(
        id: map['id'],
        name: map['name'],
        nameCN: map["nameCN"],
        family: map["family"],
        deprecated: map["deprecated"] ?? 0,
        lever: map["lever"].toDouble(),
        linkWidget: map["linkWidget"],
        info: map["info"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "nameCN": this.nameCN,
      "family": this.family,
      "deprecated": this.deprecated,
      "lever": this.lever,
      "linkWidget": this.linkWidget,
      "info": this.info
    };
  }

  @override
  String toString() {
    return 'WidgetPo{id: $id, name: $name, nameCN: $nameCN, deprecated: $deprecated, family: $family, lever: $lever,  info: $info}';
  }

  @override
  List<Object> get props =>
      [id, name, nameCN, deprecated, family, linkWidget, lever, info];
}
