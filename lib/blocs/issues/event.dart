import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

abstract class IssuesEvent extends Equatable {}

class LoadIssues extends IssuesEvent {
  final String username;
  final String repository;
  final String sort;

  final String direction;
  final int page;
  final int pageSize;

  final String state;

  final String labels;

  LoadIssues(
      {@required this.username,
      @required this.repository,
      this.sort,
      this.direction,
      this.page,
      this.pageSize,
      this.state,
      this.labels});

  @override
  List<Object> get props =>
      [username, repository, sort, direction, page, pageSize, state, labels];

  @override
  String toString() {
    return 'LoadIssues{username: $username, repository: $repository, sort: $sort, direction: $direction, page: $page, pageSize: $pageSize, state: $state, labels: $labels}';
  }
}
