import 'package:equatable/equatable.dart';
import 'github_user.dart';

class Issue extends Equatable {
  final int? id;
  final int? number;
  final String? title;
  final String? state;
  final bool? locked;

  final int? commentNum;

  final DateTime? createdAt;

  final  DateTime? updatedAt;

  final DateTime? closedAt;
  final String? body;

  final String? bodyHtml;

  final  GithubUser? user;

  final String? repoUrl;

  final String? htmlUrl;

 final GithubUser? closeBy;

  const Issue(
    this.id,
    this.number,
    this.title,
    this.state,
    this.locked,
    this.commentNum,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.body,
    this.bodyHtml,
    this.user,
    this.repoUrl,
    this.htmlUrl,
    this.closeBy,
  );

  static Issue fromJson(dynamic json) => Issue(
    json['id'] as int?,
    json['number'] as int?,
    json['title'] as String?,
    json['state'] as String?,
    json['locked'] as bool?,
    json['comments'] as int?,
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    json['closed_at'] == null
        ? null
        : DateTime.parse(json['closed_at'] as String),
    json['body'] as String?,
    json['body_html'] as String?,
    json['user'] == null
        ? null
        : GithubUser.fromJson(json['user'] as Map<String, dynamic>),
    json['repository_url'] as String?,
    json['html_url'] as String?,
    json['closed_by'] == null
        ? null
        : GithubUser.fromJson(json['closed_by'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'number': number,
    'title': title,
    'state': state,
    'locked': locked,
    'comments': commentNum,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'closed_at': closedAt?.toIso8601String(),
    'body': body,
    'body_html': bodyHtml,
    'user': user,
    'repository_url': repoUrl,
    'html_url': htmlUrl,
    'closed_by': closeBy,
  };

  @override
  String toString() {
    return 'Issue{id: $id, number: $number, title: $title, state: $state, locked: $locked, commentNum: $commentNum, createdAt: $createdAt, updatedAt: $updatedAt, closedAt: $closedAt, body: $body, bodyHtml: $bodyHtml, user: $user, repoUrl: $repoUrl, htmlUrl: $htmlUrl, closeBy: $closeBy}';
  }

  @override
  List<Object?> get props => [
        id,
        number,
        title,
        state,
        locked,
        commentNum,
        createdAt,
        updatedAt,
        closedAt,
        body,
        bodyHtml,
        user,
        repoUrl,
        htmlUrl,
        closeBy,
      ];
}
