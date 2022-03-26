import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

/// create by 张风捷特烈 on 2020/10/10
/// contact me by email 1981462002@qq.com
/// 说明:

class DrawPicture extends StatefulWidget {
  const DrawPicture({Key? key}) : super(key: key);

  @override
  _DrawPictureState createState() => _DrawPictureState();
}

class _DrawPictureState extends State<DrawPicture> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/images/sabar.webp');
    if (mounted) setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(Uint8List.fromList(bytes));
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.shortestSide;
    return CustomPaint(size: Size(size, size), painter: PaperPainter(_image));
  }
}

class PaperPainter extends CustomPainter {
  final Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final ui.Image? image;

  PaperPainter(this.image)
      : _paint = Paint()
          ..filterQuality = FilterQuality.high
          ..color = Colors.black.withAlpha(180);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    _drawImage(canvas, size);
    _drawLine(size, canvas);
  }

  void _drawLine(Size size, Canvas canvas) {
    _paint.color = const Color(0xFFF0F0F0);
    double step = 10.0;
    for (int i = 1; i <= size.height / step; i++) {
      canvas.drawLine(Offset(step * i, 0), Offset(0, step * i), _paint);
      canvas.drawLine(
          Offset(step * i, size.height), Offset(size.width, step * i), _paint);
    }
  }

  void _drawImage(Canvas canvas, Size size) {
    if (image != null) {
      canvas.drawImageRect(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height / 2),
              width: image!.width * 1.0,
              height: image!.width * 1.0),
          Rect.fromLTRB(0, 0, size.width, size.height),
          _paint);
    }
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => oldDelegate.image != image;
}
