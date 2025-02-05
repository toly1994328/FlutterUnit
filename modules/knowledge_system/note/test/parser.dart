import 'dart:convert';

main(){
  // 示例 JSON 字符串
  final jsonString = '''
  {
    "status": true,
    "msg": "请求成功!",
    "data": {
      "cate_id": 1,
      "name": "匠心空间",
      "cate_type": 0,
      "priority": 0,
      "children": [
        {
          "cate_id": 2,
          "name": "全部笔记",
          "children": [
            {"cate_id":4, "name":"我的随笔"},
            {"cate_id":5, "name":"编程技术"}
          ]
        },
        {
          "cate_id": 3,
          "name": "网络博文",
          "children": [
            {"cate_id":6, "name":"掘金文章"},
            {"cate_id":7, "name":"微信公众号"}
          ]
        }
      ]
    }
  }
  ''';
  // 解析过程
  final Map<String, dynamic> parsedJson = jsonDecode(jsonString);
  final Category category = Category.fromJson(parsedJson['data']);
  print(category);
}

class Category {
  final int cateId;
  final String name;
  final int cateType;
  final int priority;
  final List<Category> children;

  Category({
    required this.cateId,
    required this.name,
    this.cateType = 0,
    this.priority = 0,
    this.children = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      cateId: json['cate_id'] as int,
      name: json['name'] as String,
      cateType: json['cate_type'] as int? ?? 0,
      priority: json['priority'] as int? ?? 0,
      children: (json['children'] as List<dynamic>?)
          ?.map((child) => Category.fromJson(child))
          .toList() ??
          [],
    );
  }
}