
/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 详情页节点-数据库-数据模型
///
class NodePo {
  final int id;
  final int widgetId;
  final String name;
  final int priority;
  final String subtitle;
  final String code;

  const NodePo({
    required this.id,
    required this.widgetId,
    required this.name,
    required this.priority,
    required this.subtitle,
    required this.code,
  });

  factory NodePo.fromJson(Map<String, dynamic> map) {
    return NodePo(
        id: map['id'],
        name: map['name'],
        widgetId: map["widgetId"],
        priority: map["priority"],
        subtitle: map["subtitle"],
        code: map["code"]);
  }

  @override
  String toString() {
    return 'NodePo{id: $id, widgetId: $widgetId, name: $name, priority: $priority, subtitle: $subtitle, code: $code}';
  }

}
