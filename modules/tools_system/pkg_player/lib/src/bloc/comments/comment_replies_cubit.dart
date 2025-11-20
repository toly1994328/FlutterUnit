import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../pkg_player.dart';
import 'comment_replies_state.dart';

class CommentRepliesCubit extends Cubit<CommentRepliesState> {
  final PackageRequest _request;
  final int commentId;
  List<Comment> _allReplies = [];
  int _currentPage = 1;
  bool _hasMore = true;

  CommentRepliesCubit(this._request, this.commentId) : super(CommentRepliesInitial());

  Future<void> loadReplies({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _allReplies.clear();
      _hasMore = true;
    }
    
    emit(CommentRepliesLoading());

    final result = await _request.getCommentReplies(commentId, page: _currentPage);
    if (result.success) {
      if (isRefresh) {
        _allReplies = result.data;
      } else {
        _allReplies.addAll(result.data);
      }
      
      emit(CommentRepliesLoaded(_allReplies));
    } else {
      emit(CommentRepliesError(result.msg));
    }
  }

  Future<bool> loadMore() async {
    if (!_hasMore) return true;
    
    _currentPage++;
    final result = await _request.getCommentReplies(commentId, page: _currentPage);
    
    if (result.success) {
      final newReplies = result.data;
      _hasMore = newReplies.isNotEmpty;
      
      if (newReplies.isNotEmpty) {
        _allReplies.addAll(newReplies);
        emit(CommentRepliesLoaded(_allReplies));
      }
      
      return !_hasMore;
    }
    
    return true;
  }
}