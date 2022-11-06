
/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 组件信息-数据库-数据模型
///


class WidgetPo {
  final int id;
  final String name;
  final String nameCN;
  final int deprecated;
  final int family;
  final double lever;
  final String info;
  final String linkWidget;

  const WidgetPo({
    required this.id,
    required this.name,
    required this.nameCN,
    required this.deprecated,
    required this.family,
    required this.lever,
    required this.linkWidget,
    required this.info,
  });

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
      "id": id,
      "name": name,
      "nameCN": nameCN,
      "family": family,
      "deprecated": deprecated,
      "lever": lever,
      "linkWidget": linkWidget,
      "info": info
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
