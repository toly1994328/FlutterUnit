import '../../repository/model/model.dart';

abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsLoaded extends CommentsState {
  final CommentsResponse comments;

  CommentsLoaded(this.comments);
}

class CommentsError extends CommentsState {
  final String message;

  CommentsError(this.message);
}

class CommentSending extends CommentsState {
  final CommentsResponse comments;

  CommentSending(this.comments);
}
