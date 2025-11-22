import 'package:flutter/material.dart';
import 'package:pkg_player/pkg_player.dart';

import '../home/plugin_item.dart';

typedef OnReplay = void Function(int commentId);

class SliverCommentsWithData extends StatelessWidget {
  final List<Comment> comments;
  final VoidCallback onViewAll;
  final int total;
  final OnReplay onReplay;
  final ValueChanged<int> onViewMoreDetail;

  const SliverCommentsWithData({
    super.key,
    required this.comments,
    required this.onReplay,
    required this.total,
    required this.onViewAll,
    required this.onViewMoreDetail,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    bool hasMore = total > 10;
    int length = comments.length;
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;
    PkgL10n l10n = context.pkgL10n;
    return DecoratedSliver(
      decoration: BoxDecoration(color: tileColor),
      sliver: SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        sliver: SliverList.separated(
            separatorBuilder: (_, __) => SizedBox(height: 10),
            itemCount: hasMore ? length + 1 : length,
            itemBuilder: (_, index) {
              if (hasMore && index == length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: color),
                      onPressed: onViewAll,
                      icon: Icon(
                        Icons.view_kanban,
                        color: Colors.white,
                      ),
                      label: Text(
                        l10n.viewAll,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                );
              }
              return CommentItemView(
                l10n: l10n,
                comment: comments[index],
                theme: color,
                onReplay: onReplay,
                onViewMoreDetail: onViewMoreDetail,
              );
            }),
      ),
    );
  }
}

class CommentItemView extends StatelessWidget {
  final Comment comment;
  final Color theme;
  final OnReplay onReplay;
  final PkgL10n l10n;
  final ValueChanged<int> onViewMoreDetail;

  const CommentItemView({
    super.key,
    required this.comment,
    required this.theme,
    required this.l10n,
    required this.onReplay,
    required this.onViewMoreDetail,
  });

  @override
  Widget build(BuildContext context) {
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;
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
                      Expanded(
                        child: Text(
                          comment.guestName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      if (comment.rating == 100)
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              l10n.highlightAnswer,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ))
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
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        formatDate(comment.createAt, l10n),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onReplay(comment.id),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            l10n.reply,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (comment.replies.isNotEmpty) ...[
          SizedBox(height: 12),
          _buildReplies(comment, tileColor),
        ],
      ],
    );
  }

  Widget _buildAvatar(String name) {
    return Container(
      width: 32,
      height: 32,
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

  Widget _buildReplies(Comment comment, Color? tileColor) {
    final displayReplies = comment.replies.take(2).toList();
    final hasMore = comment.repliesTotal > 2;

    return Container(
      margin: EdgeInsets.only(left: 36),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...displayReplies.asMap().entries.map((entry) {
            final index = entry.key;
            final reply = entry.value;
            return Column(
              children: [
                _buildReplyItem(reply),
                if (index < displayReplies.length - 1) SizedBox(height: 8),
              ],
            );
          }).toList(),
          if (hasMore) ...[
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                onViewMoreDetail(comment.id);
              },
              child: Text(
                l10n.viewMoreReplies(comment.repliesTotal - 2),
                style: TextStyle(
                  color: theme,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
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
    );
  }
}
