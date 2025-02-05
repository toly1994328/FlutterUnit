class Hierarchy {
  final int cateId;
  final String name;
  final int cateType;
  final int priority;
  final List<Hierarchy> children;

  Hierarchy({
    required this.cateId,
    required this.name,
    this.cateType = 0,
    this.priority = 0,
    this.children = const [],
  });

  factory Hierarchy.fromJson(Map<String, dynamic> json) {
    return Hierarchy(
      cateId: json['cate_id'] as int,
      name: json['name'] as String,
      cateType: json['cate_type'] as int? ?? 0,
      priority: json['priority'] as int? ?? 0,
      children: (json['children'] as List<dynamic>?)
          ?.map((child) => Hierarchy.fromJson(child))
          .toList() ??
          [],
    );
  }
}