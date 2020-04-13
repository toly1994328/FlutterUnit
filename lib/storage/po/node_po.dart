//persistent object 持久层对象，
// 用于与数据库中记录对用的对象

class NodePo {
  final int id;
  final int widgetId;
  final String name;
  final int priority;
  final String subtitle;
  final String code;

  const NodePo(
      {this.id,
      this.widgetId,
      this.name,
      this.priority,
      this.subtitle,
      this.code});

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
