


import 'github_user.dart';

class IssueComment{
  int? id;
  GithubUser? user;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? authorAssociation;
  String? body;

  String? bodyHtml;
  String? type;
  String? htmlUrl;

  IssueComment(
    this.id,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.authorAssociation,
    this.body,
    this.bodyHtml,
    this.type,
    this.htmlUrl,
  );

  factory IssueComment.fromJson(Map<String, dynamic> json) => IssueComment(
    json['id'] as int?,
    json['user'] == null
        ? null
        : GithubUser.fromJson(json['user'] as Map<String, dynamic>),
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    json['author_association'] as String?,
    json['body'] as String?,
    json['body_html'] as String?,
    json['event'] as String?,
    json['html_url'] as String?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'user': user,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'author_association': authorAssociation,
    'body': body,
    'body_html': bodyHtml,
    'event': type,
    'html_url': htmlUrl,
  };
}
