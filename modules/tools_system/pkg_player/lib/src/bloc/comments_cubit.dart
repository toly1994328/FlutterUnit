import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/api/request.dart';
import '../repository/model/model.dart';
import 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final PackageRequest _request;
  final int packageId;

  CommentsCubit(this._request, this.packageId) : super(CommentsInitial());

  Future<void> loadComments() async {
    emit(CommentsLoading());

    final result = await _request.getPackageComments(packageId);
    if (result.success) {
      emit(CommentsLoaded(result.data));
    } else {
      emit(CommentsError(result.msg));
    }
  }

  Future<void> sendComment(String content,
      {String guestName = '游客', int? parentId}) async {
    final currentState = state;
    if (currentState is CommentsLoaded) {
      emit(CommentSending(currentState.comments));

      final result = await _request.sendComment(
        packageId,
        content,
        guestName,
        parentId: parentId,
      );
      if (result.success) {
        await loadComments();
      } else {
        emit(CommentsError(result.msg));
      }
    }
  }
}
