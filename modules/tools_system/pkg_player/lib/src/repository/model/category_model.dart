class Category {
  final int id;
  final String key;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.key,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      key: json['key'],
      name: json['name'],
      description: json['description'] ?? '',
    );
  }

  String label(bool isZh) {
    if (isZh) return name;
    return key.replaceAll('_', ' ');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'description': description,
    };
  }
}
