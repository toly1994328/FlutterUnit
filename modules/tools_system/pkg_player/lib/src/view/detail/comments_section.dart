import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';
import '../../bloc/comments_cubit.dart';
import '../../bloc/comments_state.dart';
import '../comments/comments_empty.dart';
import '../comments/comments_error.dart';
import '../comments/comments_loading.dart';
import '../comments/comments_with_data.dart';

class CommentsSection extends StatelessWidget {
  final int? packageId;
  final OnReplay onReplay;

  const CommentsSection({
    super.key,
    required this.packageId,
    required this.onReplay,
  });

  @override
  Widget build(BuildContext context) {
    CommentsCubit cubit = context.watch<CommentsCubit>();

    if (packageId == null) {
      return SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }
    CommentsState state = cubit.state;
    if (state is CommentsLoading) {
      return SliverToBoxAdapter(
        child: CommentsLoadingView(),
      );
    }
    if (state is CommentsLoaded) {
      if (state.comments.data.isEmpty) {
        return SliverToBoxAdapter(
          child: CommentsEmptyView(),
        );
      }
      return SliverCommentsWithData(
        comments: state.comments.data,
        onReplay: onReplay,
      );
    }

    if (state is CommentsError) {
      return SliverToBoxAdapter(
        child: CommentsErrorView(message: state.message),
      );
    }

    return SliverToBoxAdapter(
      child: SizedBox.shrink(),
    );
  }

// void _sendComment({int? parentId}) {
//   if (_commentController.text.trim().isEmpty) return;
//
//   if (widget.onSendComment != null) {
//     widget.onSendComment!(_commentController.text.trim(), parentId: parentId);
//   }
//   Navigator.pop(context);
// }
}
