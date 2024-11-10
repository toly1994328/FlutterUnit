import 'package:artifact/src/points/repository/api/point_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/github_model.dart';
import 'package:equatable/equatable.dart';

/// create by 张风捷特烈 on 2020-09-03
/// contact me by email 1981462002@qq.com
/// 说明:

class PointCommentBloc extends Cubit<PointCommentState> {
  final PointApi api = PointApiImpl();

  PointCommentBloc() : super(const PointCommentInitial());

  void loadPointComment(Issue point) async {
    emit(PointCommentLoading(point));
    if (point.number == null) {
      emit(const PointCommentLoadFailure('point_bloc id 为空'));
    }
    try {
      final List<IssueComment> comments = await api.getIssuesComment(point.number!);
      comments.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      emit(PointCommentLoaded(point, comments));
    } catch (err) {
      print(err);
      emit(PointCommentLoadFailure(err.toString()));
    }
  }
}

sealed class PointCommentState extends Equatable {
  const PointCommentState();
}

class PointCommentInitial extends PointCommentState {
  const PointCommentInitial();

  @override
  List<Object> get props => [];
}

class PointCommentLoading extends PointCommentState {
  final Issue issue;

  const PointCommentLoading(this.issue);

  @override
  List<Object> get props => [issue];
}

class PointCommentLoaded extends PointCommentState {
  final Issue issue;
  final List<IssueComment> comments;

  const PointCommentLoaded(this.issue, this.comments);

  @override
  List<Object> get props => [issue, comments];

  @override
  String toString() {
    return 'PointCommentLoaded{issue: $issue, comments: $comments}';
  }
}

class PointCommentLoadFailure extends PointCommentState {
  final String error;

  const PointCommentLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
