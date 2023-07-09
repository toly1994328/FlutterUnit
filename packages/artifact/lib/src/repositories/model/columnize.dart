import 'dart:convert';

import 'package:storage/storage.dart';

class Columnize {
  final String? username;
  final String title;
  final String subtitle;
  final String? url;
  final String? cover;
  final int create;
  final int update;
  final int count;
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
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "title": title,
        "create": create,
        "subtitle": subtitle,
        "url": url,
        "cover": cover,
        "update": update,
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
        id: map['columnizeId'] ?? -1,
      );

  // 通过 Columnize 对象生成 数据库缓存对象
  factory Columnize.fromCache(CachePo cache) {
   dynamic map = json.decode(cache.content);
    return Columnize(
      username: map['username'] ?? '',
      title: map['title'] ?? '',
      create: map['create']??0,
      update: map['update']??0,
      subtitle: map['subtitle'] ?? '',
      url: map['url'] ?? '',
      cover: map['caver'] ?? '',
      count: map['count'] ?? 0,
      id: map['id'] ?? -1,
    );
  }
  CachePo get toCache => CachePo(
        id: id,
        filter: '',
        content: json.encode(this),
        update: update,
        create: create,
        type: 0,
      );

  @override
  String toString() {
    return 'Columnize{username: $username, title: $title, subtitle: $subtitle, url: $url, cover: $cover, create: $create, update: $update, count: $count}';
  }
}
