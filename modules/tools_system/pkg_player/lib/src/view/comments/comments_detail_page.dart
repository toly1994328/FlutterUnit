import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:tolyui_refresh/tolyui_refresh.dart';

import '../../bloc/comments/comments_cubit.dart';
import '../../bloc/comments/comments_state.dart';
import 'comment_replies_page.dart';

class CommentsDetailPage extends StatefulWidget {
  final int packageId;
  final String packageName;

  const CommentsDetailPage({
    Key? key,
    required this.packageId,
    required this.packageName,
  }) : super(key: key);

  @override
  _CommentsDetailPageState createState() => _CommentsDetailPageState();
}

class _CommentsDetailPageState extends State<CommentsDetailPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.packageName} 的评论'),
      ),
      body: BlocBuilder<CommentsCubit, CommentsState>(
        builder: (context, state) {
          if (state is CommentsLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CommentsError) {
            return Center(child: Text('加载失败: ${state.message}'));
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
                    child: Center(child: Text('暂无评论')),
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
                padding: EdgeInsets.all(16),
                itemCount: comments.data.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final comment = comments.data[index];
                  return _buildCommentCard(comment);
                },
              ),
            );
          }

          return Center(child: Text('暂无评论'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCommentDialog(context),
        child: Icon(Icons.add_comment),
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

  Widget _buildCommentCard(Comment comment) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
                          _formatDate(comment.createAt),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
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
            _buildReplies(comment),
          ],
          if (comment.repliesTotal > 2) ...[
            SizedBox(height: 8),
            GestureDetector(
              onTap: () => _onViewMoreReplies(context, comment),
              child: Text(
                '查看更多 ${comment.repliesTotal - 2} 条回复',
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

  Widget _buildReplies(Comment comment) {
    return Container(
      margin: EdgeInsets.only(left: 48),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...comment.replies.map((reply) => _buildReplyItem(reply)).toList(),
        ],
      ),
    );
  }

  Widget _buildReplyItem(Comment reply) {
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
                      _formatDate(reply.createAt),
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

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr.replaceAll(' ', 'T'));
      final now = DateTime.now();
      final diff = now.difference(date);

      if (diff.inMinutes < 1) return '刚刚';
      if (diff.inHours < 1) return '${diff.inMinutes}分钟前';
      if (diff.inDays < 1) return '${diff.inHours}小时前';
      if (diff.inDays < 7) return '${diff.inDays}天前';
      if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}周前';
      return dateStr.split(' ')[0];
    } catch (e) {
      return dateStr;
    }
  }

  void _showAddCommentDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('添加评论'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '写下你的评论...',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context
                    .read<CommentsCubit>()
                    .sendComment(controller.text.trim());
                Navigator.pop(dialogContext);
              }
            },
            child: Text('发送'),
          ),
        ],
      ),
    );
  }

  void _onViewMoreReplies(BuildContext context, Comment comment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentRepliesPage(
          parentComment: comment,
        ),
      ),
    );
  }
}
