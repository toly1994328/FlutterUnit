
class Article {
  final String? username;
  final String title;
  final String? subtitle;
  final String url;
  final String? cover;
  final int create;
  final int update;
  final int id;
  final int userId;
  final int groupId;

  Article({
    this.username = '',
    required this.title,
    this.subtitle = '',
    required this.url,
    this.cover = '',
    this.update = 0,
    this.create = 0,
    required this.userId,
    this.id = -1,
    required this.groupId,

  });

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "userId": userId,
        "groupId": groupId,
        "username": username,
        "title": title,
        "createAt": create,
        "subtitle": subtitle,
        "url": url,
        "cover": cover,
        "updateAt": update,
      };

  factory Article.fromMap(dynamic map)=>
      Article(
        id: map['articleId'] ?? '',
        username: map['userName'] ?? '',
        userId: map['userId'] ?? '',
        title: map['title'] ?? '',
        create: DateTime.parse(map['createAt']).millisecondsSinceEpoch,
        update:  DateTime.parse(map['updateAt']).millisecondsSinceEpoch,
        subtitle: map['subtitle'] ?? '',
        url: map['url'] ?? '',
        groupId: map['groupId'] ?? 1,
        cover: map['caver'] ?? '',
      );

  factory Article.fromDb(dynamic map)=>
      Article(
        id: map['id'] ?? '',
        username: map['username'] ?? '',
        userId: map['userId'] ?? '',
        title: map['title'] ?? '',
        create: map['createAt'] ?? 0 ,
        update: map['updateAt'] ?? 0,
        subtitle: map['subtitle'] ?? '',
        url: map['url'] ?? '',
        groupId: map['groupId'] ?? 1,
        cover: map['cover'] ?? '',
      );
}

class ArticleFilter{
  final String? filter;
  final int? groupId;
  final int page;
  final int pageSize;

  const ArticleFilter({
    this.filter,
    this.groupId,
    this.page = 1,
    this.pageSize = 20,
  });

  int get offset =>pageSize*(page-1);

  ArticleFilter copyWith({
    String? filter,
    int? groupId,
    int? page,
  }) {
    return ArticleFilter(
      filter: filter ?? this.filter,
      groupId: groupId ?? this.groupId,
      page: page ?? this.page,
      pageSize: pageSize
    );
  }

  @override
  String toString() {
    return 'ArticleFilter{filter: $filter, groupId: $groupId, page: $page, pageSize: $pageSize}';
  }
}