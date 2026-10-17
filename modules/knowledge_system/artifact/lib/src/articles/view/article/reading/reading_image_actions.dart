import 'package:flutter/material.dart';

/// 正文图片长按后支持的原图操作。
enum ReadingImageAction { save, copyLink, zoom }

/// 移动端使用全宽底部菜单，关闭后再执行操作，避免弹层相互遮挡。
Future<ReadingImageAction?> showReadingImageActions(BuildContext context) {
  Widget sheet(BuildContext context) => SafeArea(
      top: false,
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        ListTile(
            leading: const Icon(Icons.download_outlined),
            title: const Text('保存图片'),
            onTap: () => Navigator.pop(context, ReadingImageAction.save)),
        ListTile(
            leading: const Icon(Icons.link),
            title: const Text('复制链接'),
            onTap: () => Navigator.pop(context, ReadingImageAction.copyLink)),
        ListTile(
            leading: const Icon(Icons.fullscreen),
            title: const Text('查看大图'),
            onTap: () => Navigator.pop(context, ReadingImageAction.zoom)),
        const SizedBox(height: 8),
      ]));
  return showModalBottomSheet<ReadingImageAction>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: sheet);
}
