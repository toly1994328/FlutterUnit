import 'package:flutter/material.dart';

class CommentsEmptyView extends StatelessWidget {
  const CommentsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, color: Colors.grey[400], size: 32),
            SizedBox(height: 8),
            Text('暂无评论', style: TextStyle(color: Colors.grey[600])),
            Text('成为第一个评论的人吧',
                style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
