import 'package:flutter/material.dart';

import '../../data/exp.dart';
import '../library/article_browser.dart';

class ColumnDetailPage extends StatelessWidget {
  /// 当前专栏标题、简介和计数。
  final Columnize columnize;

  const ColumnDetailPage({super.key, required this.columnize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(columnize.title),
      ),
      body: ArticleBrowser(collection: columnize),
    );
  }
}
