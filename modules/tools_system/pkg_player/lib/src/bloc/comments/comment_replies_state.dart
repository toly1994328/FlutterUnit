import 'package:equatable/equatable.dart';
import '../../repository/model/model.dart';

abstract class CommentRepliesState extends Equatable {
  const CommentRepliesState();
}

class CommentRepliesInitial extends CommentRepliesState {
  @override
  List<Object?> get props => [];
}

class CommentRepliesLoading extends CommentRepliesState {
  @override
  List<Object?> get props => [];
}

class CommentRepliesLoaded extends CommentRepliesState {
  final List<Comment> replies;

  const CommentRepliesLoaded(this.replies);

  @override
  List<Object?> get props => [replies];
}

class CommentRepliesError extends CommentRepliesState {
  final String message;

  const CommentRepliesError(this.message);

  @override
  List<Object?> get props => [message];
}