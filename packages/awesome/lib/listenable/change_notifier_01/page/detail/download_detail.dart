import 'package:flutter/material.dart';

import 'detail_progress_view.dart';

class DownloadDetailPage extends StatelessWidget {
  const DownloadDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('下载详情页'),
      ),
      body: Center(child: DetailProgressView()),
    );
  }
}
