import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pkg_player/pkg_player.dart';
import 'plugin_card.dart';

class PluginCardPage extends StatelessWidget {
  final PluginModel plugin;
  final GlobalKey _cardKey = GlobalKey();

  PluginCardPage({Key? key, required this.plugin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('分享卡片'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareCard(context),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // 卡片预览
              RepaintBoundary(
                key: _cardKey,
                child: Hero(
                  tag: 'plugin_card_${plugin.name}',
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: PluginCard(plugin: plugin)),
                ),
              ),

              SizedBox(height: 32),

              // 操作按钮
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    context,
                    icon: Icons.download,
                    label: '保存图片',
                    onTap: () => _saveCard(context),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.share,
                    label: '分享',
                    onTap: () => _shareCard(context),
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.copy,
                    label: '复制链接',
                    onTap: () => _copyLink(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveCard(BuildContext context) async {
    try {
      // 请求相册权限
      final status = await Permission.photos.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('需要相册权限才能保存图片'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // 获取卡片的RenderRepaintBoundary
      RenderRepaintBoundary boundary =
          _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // 转换为图片
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // 保存到相册
      // final result = await ImageGallerySaver.saveImage(
      //   pngBytes,
      //   name: 'plugin_${plugin.name}_${DateTime.now().millisecondsSinceEpoch}',
      //   quality: 100,
      // );

      // if (result['isSuccess']) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('图片已保存到相册'),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      // } else {
      //   throw Exception('保存失败');
      // }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('保存失败: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _shareCard(BuildContext context) {
    // TODO: 实现分享功能
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('分享功能开发中...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _copyLink(BuildContext context) {
    final link = 'https://pub.dev/packages/${plugin.name}';
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('链接已复制到剪贴板'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
