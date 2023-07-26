import 'dart:convert';

class Columnize {
  final String? username;
  final String title;
  final String subtitle;
  final String? url;
  final String? cover;
  final int create;
  final int update;
  final int count;
  final int userId;
  final int id;

  Columnize({
    this.username = '',
    required this.title,
    this.subtitle = '',
    required this.url,
    this.cover = '',
    this.update = 0,
    this.create = 0,
    this.count = 0,
    this.id = -1,
    this.userId = -1,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
        "title": title,
        "createAt": create,
        "subtitle": subtitle,
        "userId": userId,
        "url": url,
        "cover": cover,
        "updateAt": update,
        "count": count,
      };

  factory Columnize.fromMap(dynamic map) => Columnize(
        username: map['userName'] ?? '',
        title: map['title'] ?? '',
        create: DateTime.parse(map['createAt']).millisecondsSinceEpoch,
        update: DateTime.parse(map['updateAt']).millisecondsSinceEpoch,
        subtitle: map['subtitle'] ?? '',
        url: map['url'] ?? '',
        cover: map['caver'] ?? '',
        count: map['count'] ?? 0,
        userId: map['userId'] ?? 0,
        id: map['columnizeId'] ?? -1,
      );

  factory Columnize.fromDb(dynamic map)=>
      Columnize(
        id: map['id'] ?? '',
        username: map['username'] ?? '',
        userId: map['userId'] ?? '',
        title: map['title'] ?? '',
        create: map['createAt'] ?? 0 ,
        count: map['count'] ?? 0 ,
        update: map['updateAt'] ?? 0,
        subtitle: map['subtitle'] ?? '',
        url: map['url'] ?? '',
        cover: map['cover'] ?? '',
      );

  @override
  String toString() {
    return 'Columnize{username: $username, title: $title, subtitle: $subtitle, url: $url, cover: $cover, create: $create, update: $update, count: $count}';
  }
}
