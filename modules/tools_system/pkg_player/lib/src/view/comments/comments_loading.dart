import 'package:flutter/material.dart';

class CommentsLoadingView extends StatelessWidget {
  const CommentsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    Color? tileColor = Theme.of(context).listTileTheme.tileColor;

    return Container(
      color: tileColor,
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
            Text('加载评论中...',
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
