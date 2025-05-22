import 'package:fx_dao/fx_dao.dart';
import 'package:intl/intl.dart';

DateFormat _noteTimeShort = DateFormat('yyyy/M/d');
DateFormat _noteTimeLong = DateFormat('yyyy/M/d HH:mm:ss');
Duration offset = DateTime.now().timeZoneOffset;

enum ArticleType {
  net,
  custom,
}

class ArticlePo implements Po {
  final String title;
  final String? subtitle;
  final String url;
  final String? cover;
  final int create;
  final int update;
  final int id;
  final int status;
  final int type;

  ArticlePo({
    required this.title,
    this.subtitle = '',
    required this.url,
    this.cover = '',
    this.update = 0,
    this.create = 0,
    this.status = 0,
    this.type = 0,
    this.id = -1,
  });

  String get updateDate {
    return _noteTimeLong
        .format(DateTime.fromMillisecondsSinceEpoch(update).add(offset));
  }

  String get createDate => _noteTimeShort
      .format(DateTime.fromMillisecondsSinceEpoch(create).add(offset));

  factory ArticlePo.fromApi(dynamic map) => ArticlePo(
        id: map['article_id'] ?? 0,
        title: map['title'] ?? '',
        type: map['type'] ?? '',
        status: map['status'] ?? '',
        create: DateTime.parse(map['create_at']).millisecondsSinceEpoch,
        update: DateTime.parse(map['update_at']).millisecondsSinceEpoch,
        subtitle: map['subtitle'] ?? '',
        url: map['url'] ?? '',
        cover: map['cover'] ?? '',
      );

  factory ArticlePo.fromCache(dynamic map) => ArticlePo(
        id: map['article_id'] ?? 0,
        title: map['title'] ?? '',
        type: map['type'] ?? '',
        status: map['status'] ?? '',
        create: map['create_at'],
        update: map['update'],
        subtitle: map['subtitle'] ?? '',
        url: map['url'] ?? '',
        cover: map['cover'] ?? '',
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'article_id': id,
      'title': title,
      'type': type,
      'status': status,
      'create_at': create,
      'update': update,
      'url': url,
      'cover': cover,
    };
  }
}

class ArticleCreatePayload {
  final String subtitle;
  final String title;
  final String url;
  final int type;
  final String cover;
  final String createAt;

  ArticleCreatePayload({
    required this.subtitle,
    required this.title,
    required this.url,
    required this.type,
    required this.cover,
    required this.createAt,
  });

  Map<String, dynamic> get apiData => {
        "title": title,
        "create_at": createAt,
        "subtitle": subtitle,
        "url": url,
        "type": type,
        "cover": cover,
      };

  Map<String, dynamic> toJson() => apiData;
}

class ArticleUpdatePayload {
  final String? subtitle;
  final String? title;
  final String? url;
  final String? cover;

  ArticleUpdatePayload({
    this.subtitle,
    this.title,
    this.url,
    this.cover,
  });

  Map<String, dynamic> get apiData {
    Map<String, dynamic> ret = {};
    if (title != null) {
      ret['title'] = title;
    }
    if (url != null) {
      ret['url'] = title;
    }
    if (subtitle != null) {
      ret['subtitle'] = title;
    }
    if (cover != null) {
      ret['cover'] = title;
    }
    return ret;
  }

  Map<String, dynamic> toJson() => apiData;
}
