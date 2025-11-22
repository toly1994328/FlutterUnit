import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:tolyui_refresh/tolyui_refresh.dart';

import '../../bloc/comments/comment_replies_cubit.dart';
import '../../bloc/comments/comment_replies_state.dart';
import '../home/plugin_item.dart';

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
  late PkgL10n l10n;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = context.pkgL10n;
  }

  @override
  Widget build(BuildContext context) {
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.replyDetails),
      ),
      body: Column(
        children: [
          _buildParentComment(tileColor),
          Expanded(
            child: BlocBuilder<CommentRepliesCubit, CommentRepliesState>(
              builder: (context, state) {
                if (state is CommentRepliesLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is CommentRepliesError) {
                  return Center(
                      child: Text(l10n.loadFailedWithMessage(state.message)));
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
                          child: Center(child: Text(l10n.noReply)),
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
                      itemCount: state.replies.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final reply = state.replies[index];
                        return _buildReplyItem(reply, tileColor);
                      },
                    ),
                  );
                }

                return Center(child: Text(l10n.noComments));
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _showAddReplyDialog(context),
      //   child: Icon(Icons.reply),
      // ),
    );
  }

  Widget _buildParentComment(Color? color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
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
                      formatDate(widget.parentComment.createAt, l10n),
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

  Widget _buildReplyItem(Comment reply, Color? color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
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
                      formatDate(reply.createAt, l10n),
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '回复 @${widget.parentComment.guestName}',
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
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: '写下你的回复...',
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
                      onPressed: () => Navigator.pop(context),
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
                          // TODO: 实现发送回复
                          Navigator.pop(context);
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

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
