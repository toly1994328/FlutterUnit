import 'package:equatable/equatable.dart';
import 'package:flutter_unit/model/github/github_user.dart';

part 'g/issue.g.dart';

class Issue extends Equatable {
  final int id;
  final int number;
  final String title;
  final String state;
  final bool locked;

  final int commentNum;

  final DateTime createdAt;

  final  DateTime updatedAt;

  final DateTime closedAt;
  final String body;

  final String bodyHtml;

  final  GithubUser user;

  final String repoUrl;

  final String htmlUrl;

 final GithubUser closeBy;

  Issue(
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

  static Issue fromJson(dynamic json) => _$IssueFromJson(json);

  Map<String, dynamic> toJson() => _$IssueToJson(this);

  @override
  String toString() {
    return 'Issue{id: $id, number: $number, title: $title, state: $state, locked: $locked, commentNum: $commentNum, createdAt: $createdAt, updatedAt: $updatedAt, closedAt: $closedAt, body: $body, bodyHtml: $bodyHtml, user: $user, repoUrl: $repoUrl, htmlUrl: $htmlUrl, closeBy: $closeBy}';
  }

  @override
  List<Object> get props => [
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
