import 'package:equatable/equatable.dart';

/// create by 张风捷特烈 on 2020-03-04
/// contact me by email 1981462002@qq.com
/// 说明: 详情页节点-展示-数据模型
///

enum NodeType {
  display,
  newPage,
  description,
  deprecated,
}

class NodeModel extends Equatable {
  final String name;
  final String subtitle;
  final String code;
  final int priority;

  const NodeModel({
    required this.name,
    required this.subtitle,
    required this.code,
    required this.priority,
  });

  @override
  List<Object> get props => [name, subtitle, code, priority];

  NodeType type(String widget, int priority) {
    if (widget == 'PinnedHeaderSliver') {
      return NodeType.newPage;
    }
    if (widget == 'NavigationRail') {
      return NodeType.newPage;
    }
    return NodeType.display;
  }

  factory NodeModel.fromJson(Map<String, dynamic> map, int index) {
    return NodeModel(
        name: map['name'],
        subtitle: map["subtitle"],
        code: map["code"],
        priority: index);
  }

  @override
  String toString() {
    return 'Node{name: $name, subtitle: $subtitle, code: $code}';
  }
}
