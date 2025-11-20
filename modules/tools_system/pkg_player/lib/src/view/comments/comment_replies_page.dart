import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:tolyui_refresh/tolyui_refresh.dart';

import '../../bloc/comments/comment_replies_cubit.dart';
import '../../bloc/comments/comment_replies_state.dart';

class CommentRepliesPage extends StatefulWidget {
  final Comment parentComment;

  const CommentRepliesPage({
    Key? key,
    required this.parentComment,
  }) : super(key: key);

  @override
  _CommentRepliesPageState createState() => _CommentRepliesPageState();
}

class _CommentRepliesPageState extends State<CommentRepliesPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CommentRepliesCubit(PackageRequest(), widget.parentComment.id)
            ..loadReplies(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('回复详情'),
        ),
        body: Column(
          children: [
            _buildParentComment(),
            Expanded(
              child: BlocBuilder<CommentRepliesCubit, CommentRepliesState>(
                builder: (context, state) {
                  if (state is CommentRepliesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is CommentRepliesError) {
                    return Center(child: Text('加载失败: ${state.message}'));
                  }

                  if (state is CommentRepliesLoaded) {
                    if (state.replies.isEmpty) {
                      return TolyRefresh(
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Container(
                            height: MediaQuery.of(context).size.height - 300,
                            child: Center(child: Text('暂无回复')),
                          ),
                        ),
                      );
                    }

                    return TolyRefresh(
                      controller: _refreshController,
                      enablePullUp: true,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView.separated(
                        padding: EdgeInsets.all(16),
                        itemCount: state.replies.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final reply = state.replies[index];
                          return _buildReplyItem(reply);
                        },
                      ),
                    );
                  }

                  return Center(child: Text('暂无回复'));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddReplyDialog(context),
          child: Icon(Icons.reply),
        ),
      ),
    );
  }

  Widget _buildParentComment() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(widget.parentComment.guestName),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.parentComment.guestName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      _formatDate(widget.parentComment.createAt),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  widget.parentComment.content,
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
    );
  }

  Widget _buildReplyItem(Comment reply) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getAvatarColor(reply.guestName).withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                reply.guestName.isNotEmpty
                    ? reply.guestName[0].toUpperCase()
                    : 'U',
                style: TextStyle(
                  color: _getAvatarColor(reply.guestName),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
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
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      _formatDate(reply.createAt),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  reply.content,
                  style: TextStyle(
                    fontSize: 13,
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

  void _onRefresh() async {
    await context.read<CommentRepliesCubit>().loadReplies(isRefresh: true);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    final noMore = await context.read<CommentRepliesCubit>().loadMore();
    if (noMore) {
      _refreshController.loadNoData();
    } else {
      _refreshController.loadComplete();
    }
  }

  void _showAddReplyDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('回复评论'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '写下你的回复...',
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
                // TODO: 实现发送回复
                Navigator.pop(dialogContext);
              }
            },
            child: Text('发送'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
