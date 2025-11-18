import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';

class CommentsSection extends StatefulWidget {
  final int? packageId;

  const CommentsSection({Key? key, required this.packageId}) : super(key: key);

  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  CommentsResponse? _comments;
  bool _loadingComments = false;
  final TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    if (widget.packageId == null) return;
    
    setState(() {
      _loadingComments = true;
    });
    
    try {
      PackageRequest request = PackageRequest();
      ApiRet<CommentsResponse> ret = await request.getPackageComments(widget.packageId!);
      if (ret.success) {
        setState(() {
          _comments = ret.data;
        });
      }
    } catch (e) {
      print('加载评论失败: $e');
    } finally {
      setState(() {
        _loadingComments = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 12),
        _buildContent(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(Icons.comment_outlined, color: Theme.of(context).primaryColor, size: 20),
        SizedBox(width: 8),
        Text('用户评论', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (_comments != null) ...[
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_comments!.total}',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        Spacer(),
        GestureDetector(
          onTap: _showCommentInput,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text(
                  '写评论',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: _loadingComments
          ? _buildLoadingState()
          : _comments == null || _comments!.data.isEmpty
              ? _buildEmptyState()
              : _buildCommentsList(),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(height: 8),
            Text('加载评论中...', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, color: Colors.grey[400], size: 32),
            SizedBox(height: 8),
            Text('暂无评论', style: TextStyle(color: Colors.grey[600])),
            Text('成为第一个评论的人吧', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsList() {
    return Column(
      children: _comments!.data.asMap().entries.map((entry) {
        final index = entry.key;
        final comment = entry.value;
        return Column(
          children: [
            _buildCommentItem(comment),
            if (index < _comments!.data.length - 1)
              SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCommentItem(Comment comment) {
    return Column(
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
                          _formatCommentDate(comment.createAt),
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
            _buildReplies(comment.replies),
          ],
        ],
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

  Widget _buildReplies(List<Comment> replies) {
    return Container(
      margin: EdgeInsets.only(left: 48),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: replies.asMap().entries.map((entry) {
          final index = entry.key;
          final reply = entry.value;
          return Column(
            children: [
              _buildReplyItem(reply),
              if (index < replies.length - 1)
                SizedBox(height: 8),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReplyItem(Comment reply) {
    return Row(
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
              reply.guestName.isNotEmpty ? reply.guestName[0].toUpperCase() : 'U',
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
                    _formatCommentDate(reply.createAt),
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
    );
  }

  String _formatCommentDate(String dateStr) {
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

  void _showCommentInput() {
    setState(() {
      _isCommenting = true;
    });
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: '写下你的评论...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  maxLines: null,
                ),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: _sendComment,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      setState(() {
        _isCommenting = false;
      });
      _commentController.clear();
    });
  }

  void _sendComment() {
    if (_commentController.text.trim().isEmpty) return;
    
    // TODO: 实现发送评论逻辑
    print('发送评论: ${_commentController.text}');
    
    Navigator.pop(context);
  }
}