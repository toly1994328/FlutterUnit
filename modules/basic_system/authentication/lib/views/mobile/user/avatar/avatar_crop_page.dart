import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import 'avatar_crop_view.dart';

/// 移动端全屏头像裁剪页。
class AvatarCropPage extends StatefulWidget {
  /// 待裁剪图片字节。
  final Uint8List imageBytes;

  const AvatarCropPage({super.key, required this.imageBytes});

  /// 以全屏覆盖层打开裁剪器，取消时返回空值。
  static Future<Uint8List?> open(
    BuildContext context, {
    required Uint8List imageBytes,
  }) {
    return showGeneralDialog<Uint8List>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return AvatarCropPage(imageBytes: imageBytes);
      },
    );
  }

  @override
  State<AvatarCropPage> createState() => _AvatarCropPageState();
}

class _AvatarCropPageState extends State<AvatarCropPage> {
  /// 裁剪核心组件状态。
  final GlobalKey<AvatarCropViewState> _cropKey = GlobalKey();

  /// 是否正在导出裁剪结果。
  bool _exporting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(context.l10n.cropAvatar),
        actions: <Widget>[_buildConfirmButton()],
      ),
      body: AvatarCropView(
        key: _cropKey,
        image: MemoryImage(widget.imageBytes),
      ),
    );
  }

  Widget _buildConfirmButton() {
    if (_exporting) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: CupertinoActivityIndicator(color: Colors.white),
      );
    }
    return IconButton(
      onPressed: _confirm,
      icon: const Icon(Icons.check),
    );
  }

  /// 导出正方形头像并返回账户资料页。
  Future<void> _confirm() async {
    setState(() => _exporting = true);
    final Uint8List? bytes = await _cropKey.currentState?.exportCroppedBytes();
    if (!mounted) return;
    setState(() => _exporting = false);
    Navigator.of(context).pop(bytes);
  }
}
