import 'package:equatable/equatable.dart';
import 'package:flutter_unit/model/github/issue.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明: 

abstract class IssuesState extends Equatable{

}

class IssuesLoading extends IssuesState{
  @override
  List<Object> get props =>[];

  @override
  String toString() {
    return 'IssuesLoading{}';
  }
}

class IssuesLoaded extends IssuesState{
 final List<Issue> issues;

  IssuesLoaded(this.issues);

  @override
  List<Object> get props => [issues];

 @override
  String toString() {
    return 'IssuesLoaded{issues: $issues}';
 }
}

class IssuesLoadFailure extends IssuesState{
  final String error;

  IssuesLoadFailure(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'IssuesLoadFailure{error: $error}';
  }
}