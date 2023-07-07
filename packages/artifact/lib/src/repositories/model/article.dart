
import 'dart:convert';

import 'package:storage/storage.dart';

class Article {
  final String? username;
  final String title;
  final String? subtitle;
  final String url;
  final String? cover;
  final int create;
  final int update;
  final int id;
  final int groupId;

  Article({
    this.username = '',
    required this.title,
    this.subtitle = '',
    required this.url,
    this.cover = '',
    this.update = 0,
    this.create = 0,
    this.id = -1,
    required this.groupId,

  });

  Map<String, dynamic> toJson() =>
      {
        "username": username,
        "title": title,
        "create": create,
        "subtitle": subtitle,
        "url": url,
        "cover": cover,
        "update": update,
      };

  factory Article.fromMap(dynamic map)=>
      Article(
        username: map['userName'] ?? '',
        title: map['title'] ?? '',
        create: DateTime.parse(map['createAt']).millisecondsSinceEpoch,
        update:  DateTime.parse(map['updateAt']).millisecondsSinceEpoch,
        subtitle: map['subtitle'] ?? '',
        url: map['url'] ?? '',
        groupId: map['groupId'] ?? 1,
        cover: map['caver'] ?? '',
      );

  // 通过 Columnize 对象生成 数据库缓存对象
  factory Article.fromCache(CachePo cache) {
    dynamic map = json.decode(cache.content);
    return Article(
      username: map['username'] ?? '',
      title: map['title'] ?? '',
      create: map['create']??0,
      update: map['update']??0,
      groupId: int.tryParse(cache.filter)??1,
      subtitle: map['subtitle'] ?? '',
      url: map['url'] ?? '',
      cover: map['caver'] ?? '',
      id: map['id'] ?? -1,
    );
  }

  CachePo get toCache => CachePo(
    id: id,
    filter: groupId.toString(),
    content: json.encode(this),
    update: update,
    create: create,
    type: 0,
  );
}