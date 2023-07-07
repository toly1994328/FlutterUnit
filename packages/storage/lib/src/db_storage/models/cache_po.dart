class CachePo {
  // 0 专栏数据缓存
  // 1 文章列表数据缓存
  final int id;
  final String filter;
  final String content;
  final int type;
  final int create;
  final int update;

  CachePo({
   required this.id,
   required this.filter,
   required this.content,
   required this.type,
   required this.create,
   required this.update,
  });

  Map<String,dynamic> toJson() => {
    "id": id == -1 ? null : id,
    "filter": filter,
    "content": content,
    "type": type,
    "create": create,
    "update": update,
  };

  factory CachePo.fromJson(Map<String, dynamic> map) {
    return CachePo(
        id: map['id'],
        filter: map['filter'],
        content: map["content"],
        create: map["create"],
        type: map["type"],
        update: map["update"],
       );
  }

}
