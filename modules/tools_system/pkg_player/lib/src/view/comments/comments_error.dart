import 'package:flutter/material.dart';

class CommentsErrorView extends StatelessWidget {
  final String message;
  const CommentsErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red[400], size: 32),
            SizedBox(height: 8),
            Text('加载失败', style: TextStyle(color: Colors.grey[600])),
            Text(message,
                style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
