import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:tolyui_refresh/tolyui_refresh.dart';

import '../../bloc/comments/comment_replies_cubit.dart';
import '../../bloc/comments/comments_cubit.dart';
import '../../bloc/comments/comments_state.dart';
import '../../l10n/l10n.dart';
import '../home/plugin_item.dart';
import 'comment_replies_page.dart';

typedef OnCommentAction = void Function(String content, [int? commentId]);

class CommentsDetailPage extends StatefulWidget {
  final int packageId;
  final String packageName;
  final OnCommentAction onCommentAction;

  const CommentsDetailPage({
    Key? key,
    required this.packageId,
    required this.packageName,
    required this.onCommentAction,
  }) : super(key: key);

  @override
  _CommentsDetailPageState createState() => _CommentsDetailPageState();
}

class _CommentsDetailPageState extends State<CommentsDetailPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;
    PkgL10n l10n = context.pkgL10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.commentsOfPackage(widget.packageName)),
      ),
      body: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          if (state is CommentsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CommentsError) {
            return Center(
                child: Text(l10n.loadFailedWithMessage(state.message)));
          }

          if (state is CommentsLoaded || state is CommentSending) {
            final comments = state is CommentsLoaded
                ? state.comments
                : (state as CommentSending).comments;

            if (comments.data.isEmpty) {
              return TolyRefresh(
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(child: Text(l10n.noComments)),
                  ),
                ),
              );
            }
            return TolyRefresh(
              controller: _refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.separated(
                padding: EdgeInsets.all(12),
                itemCount: comments.data.length,
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final comment = comments.data[index];
                  return _buildCommentCard(comment, tileColor, l10n);
                },
              ),
            );
          }

          return Center(child: Text(l10n.noComments));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCommentDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _onRefresh() async {
    await context.read<CommentsCubit>().loadComments(isRefresh: true);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    final noMore = await context.read<CommentsCubit>().loadMore();
    if (noMore) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Widget _buildCommentCard(Comment comment, Color? color, PkgL10n l10n) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(comment.guestName),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          comment.guestName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          formatDate(comment.createAt, l10n),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => _showReplyDialog(context, comment),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.reply,
                                  size: 16, color: Colors.grey[600]),
                              SizedBox(width: 4),
                              Text(
                                l10n.reply,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      comment.content,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (comment.replies.isNotEmpty) ...[
            SizedBox(height: 12),
            _buildReplies(comment, color, l10n),
          ],
          if (comment.repliesTotal > 2) ...[
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => _onViewMoreReplies(context, comment),
              child: Text(
                l10n.viewMoreReplies(comment.repliesTotal - 2),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvatar(String name) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getAvatarColor(name).withOpacity(0.8),
            _getAvatarColor(name),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : 'U',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildReplies(Comment comment, Color? color, PkgL10n l10n) {
    return Container(
      margin: EdgeInsets.only(left: 48),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...comment.replies
              .map((reply) => _buildReplyItem(reply, l10n))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildReplyItem(Comment reply, PkgL10n l10n) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _getAvatarColor(reply.guestName).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                reply.guestName.isNotEmpty
                    ? reply.guestName[0].toUpperCase()
                    : 'U',
                style: TextStyle(
                  color: _getAvatarColor(reply.guestName),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      reply.guestName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      formatDate(reply.createAt, l10n),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  reply.content,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getAvatarColor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return colors[name.hashCode % colors.length];
  }

  void _showAddCommentDialog(BuildContext context) {
    final controller = TextEditingController();
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    context.pkgL10n.addComment,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: context.pkgL10n.writeCommentHint,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  maxLines: 4,
                  minLines: 3,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('取消'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          context
                              .read<CommentsCubit>()
                              .sendComment(controller.text.trim());
                          Navigator.pop(ctx);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('发送'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReplyDialog(BuildContext context, Comment comment) {
    final controller = TextEditingController();
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    context.pkgL10n.replyToGuest(comment.guestName),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: tileColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: context.pkgL10n.writeReplyHint,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                  maxLines: 4,
                  minLines: 3,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('取消'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          context.read<CommentsCubit>().sendComment(
                              controller.text.trim(),
                              parentId: comment.id);
                          Navigator.pop(ctx);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('发送'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onViewMoreReplies(BuildContext context, Comment comment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              CommentRepliesCubit(PackageRequest(), comment.id)..loadReplies(),
          child: CommentRepliesPage(
            parentComment: comment,
          ),
        ),
      ),
    );
  }
}
