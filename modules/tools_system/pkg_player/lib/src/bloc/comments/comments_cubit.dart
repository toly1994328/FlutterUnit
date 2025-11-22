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

  Future<void> sendComment(String content,
      {String? username, int? parentId}) async {
    final currentState = state;
    String guestName = username ?? UnitEnv.userName ?? '游客';
    if (currentState is CommentsLoaded) {
      emit(CommentSending(currentState.comments));

      final result = await _request.sendComment(
        packageId,
        content,
        guestName,
        parentId: parentId,
      );
      if (result.success) {
        _updateCommentsInMemory(result.data, content, guestName, parentId);
      } else {
        emit(CommentsError(result.msg));
      }
    }
  }

  void _updateCommentsInMemory(
      dynamic responseData, String content, String guestName, int? parentId) {
    final newComment = Comment(
      id: responseData['data'] ?? DateTime.now().millisecondsSinceEpoch,
      packageId: packageId,
      parentId: parentId,
      userId: responseData['user_id'],
      guestName: guestName,
      content: content,
      contentType: 'text',
      rating: null,
      createAt: responseData['create_at'] ?? DateTime.now().toString(),
      replies: [],
      repliesTotal: 0,
    );

    if (parentId == null || parentId == -1) {
      // 新的一级评论，添加到列表开头
      _allComments.insert(0, newComment);
      _totalComments++;
    } else {
      // 回复评论，找到父评论并添加回复
      for (int i = 0; i < _allComments.length; i++) {
        if (_allComments[i].id == parentId) {
          final parentComment = _allComments[i];
          final updatedReplies = [...parentComment.replies, newComment];
          _allComments[i] = Comment(
            id: parentComment.id,
            packageId: parentComment.packageId,
            parentId: parentComment.parentId,
            userId: parentComment.userId,
            guestName: parentComment.guestName,
            content: parentComment.content,
            contentType: parentComment.contentType,
            rating: parentComment.rating,
            createAt: parentComment.createAt,
            replies: updatedReplies.length > 2
                ? updatedReplies.sublist(0, 2)
                : updatedReplies,
            repliesTotal: parentComment.repliesTotal + 1,
          );
          break;
        }
      }
    }

    final commentsResponse = CommentsResponse(
      data: _allComments,
      total: _totalComments,
    );
    emit(CommentsLoaded(commentsResponse));
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
