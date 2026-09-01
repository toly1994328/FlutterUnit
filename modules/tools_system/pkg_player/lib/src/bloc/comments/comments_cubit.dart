import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../pkg_player.dart';
import 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final PackageRequest _request;
  final int packageId;
  List<Comment> _allComments = [];
  int _currentPage = 1;
  int _totalComments = 0;
  bool _hasMore = true;

  CommentsCubit(this._request, this.packageId) : super(CommentsInitial());

  Future<void> loadComments({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _allComments.clear();
      _hasMore = true;
    }

    emit(CommentsLoading());

    final result =
        await _request.getPackageComments(packageId, page: _currentPage);
    if (result.success) {
      _totalComments = result.data.total;
      if (isRefresh) {
        _allComments = result.data.data;
      } else {
        _allComments.addAll(result.data.data);
      }

      final commentsResponse = CommentsResponse(
        data: _allComments,
        total: _totalComments,
      );

      emit(CommentsLoaded(commentsResponse));
    } else {
      emit(CommentsError(result.msg));
    }
  }

  Future<bool> loadMore() async {
    if (!_hasMore) return true;

    _currentPage++;
    final result =
        await _request.getPackageComments(packageId, page: _currentPage);

    if (result.success) {
      final newComments = result.data.data;
      _hasMore = newComments.isNotEmpty && _allComments.length < _totalComments;

      if (newComments.isNotEmpty) {
        _allComments.addAll(newComments);
        final commentsResponse = CommentsResponse(
          data: _allComments,
          total: _totalComments,
        );
        emit(CommentsLoaded(commentsResponse));
      }

      return !_hasMore;
    }

    return true;
  }

  Future<void> sendComment(String content, {int? parentId}) async {
    final currentState = state;
    if (UnitEnv.accessToken == null) {
      emit(CommentsError('请先登录后再发布评论'));
      return;
    }
    if (currentState is CommentsLoaded) {
      emit(CommentSending(currentState.comments));

      final result = await _request.sendComment(
        packageId,
        content,
        parentId: parentId,
      );
      if (result.success) {
        await loadComments(isRefresh: true);
      } else {
        emit(CommentsError(result.msg));
      }
    }
  }

  void slice() {
    final currentState = state;
    if (currentState is CommentsLoaded) {
      List<Comment> comments = currentState.comments.data;
      if (comments.length > 10) {
        emit(CommentsLoaded(CommentsResponse(
          data: comments.sublist(0, 10),
          total: currentState.comments.total,
        )));
      }
    }
  }
}
