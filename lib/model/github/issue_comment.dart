import 'package:flutter_unit/model/github/github_user.dart';

part 'g/issue_comment.g.dart';


class IssueComment{
  int id;
  GithubUser user;

  DateTime createdAt;

  DateTime updatedAt;

  String authorAssociation;
  String body;

  String bodyHtml;
  String type;
  String htmlUrl;

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

  factory IssueComment.fromJson(Map<String, dynamic> json) => _$IssueEventFromJson(json);

  Map<String, dynamic> toJson() => _$IssueEventToJson(this);
}
