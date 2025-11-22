import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkg_player/pkg_player.dart';

import '../../bloc/comments/comments_cubit.dart';
import '../../bloc/comments/comments_state.dart';

class CommentsTopBar extends StatelessWidget {
  final VoidCallback onTapComment;

  const CommentsTopBar({
    super.key,
    required this.onTapComment,
  });

  @override
  Widget build(BuildContext context) {
    int total = context.select((CommentsCubit bloc) {
      CommentsState state = bloc.state;
      if (state is CommentsLoaded) {
        return state.comments.total;
      }
      return -1;
    });
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;

    return Container(
      color: tileColor,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Text(context.pkgL10n.allComments,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          if (total > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$total',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Spacer(),
          GestureDetector(
            onTap: onTapComment,
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
                    context.pkgL10n.writeComment,
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
      ),
    );
  }
}
