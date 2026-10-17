import 'package:app/app.dart';
import 'package:flutter/material.dart';

/// 展示 Windows 在线字体的下载进度、缓存状态和重试入口。
class WindowsFontStatusCard extends StatelessWidget {
  const WindowsFontStatusCard({super.key});

  @override
  Widget build(BuildContext context) => ListenableBuilder(
      listenable: WindowsFontController.instance, builder: _buildStatus);

  Widget _buildStatus(BuildContext context, Widget? child) {
    final WindowsFontController font = WindowsFontController.instance;
    final String status = font.ready
        ? '已下载到本地，启动时自动加载；离线可用'
        : font.loading
            ? '正在下载并加载字体 ${(font.progress * 100).round()}%'
            : font.error ?? '首次使用下载约 16.4 MB';
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 16, 12, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              const Icon(Icons.font_download_outlined),
              const SizedBox(width: 12),
              const Expanded(child: Text('霞鹜文楷 · 在线字体')),
              if (!font.ready && !font.loading)
                TextButton(
                    onPressed: font.ensureLoaded,
                    child: Text(font.error == null ? '下载' : '重试')),
            ]),
            const SizedBox(height: 8),
            Text(status, style: Theme.of(context).textTheme.bodySmall),
            if (font.loading) ...<Widget>[
              const SizedBox(height: 12),
              LinearProgressIndicator(value: font.progress),
            ],
          ],
        ),
      ),
    );
  }
}
