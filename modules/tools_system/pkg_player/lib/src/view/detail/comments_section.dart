import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../pkg_player.dart';
import '../../bloc/comments/comments_cubit.dart';
import '../../bloc/comments/comments_state.dart';
import '../comments/comments_empty.dart';
import '../comments/comments_error.dart';
import '../comments/comments_loading.dart';
import '../comments/comments_with_data.dart';
import '../comments/comments_detail_page.dart';

class CommentsSection extends StatelessWidget {
  final int? packageId;
  final String? packageName;
  final OnReplay onReplay;
  final ValueChanged<int> onViewMoreDetail;

  const CommentsSection({
    super.key,
    required this.packageId,
    this.packageName,
    required this.onReplay,
    required this.onViewMoreDetail,
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
        total: state.comments.total,
        comments: state.comments.data,
        onViewAll: () => _onViewAll(context),
        onReplay: onReplay,
        onViewMoreDetail: onViewMoreDetail,
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

  void _onViewAll(BuildContext context) {
    if (packageId == null) return;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                CommentsCubit(PackageRequest(), packageId!)..loadComments(),
            child: CommentsDetailPage(
              packageId: packageId!,
              packageName: packageName ?? '插件',
            ),
          ),
        ));
  }
}
