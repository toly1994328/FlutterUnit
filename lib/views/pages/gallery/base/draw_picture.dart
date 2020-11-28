import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// create by 张风捷特烈 on 2020/10/10
/// contact me by email 1981462002@qq.com
/// 说明:

class DrawPicture extends StatefulWidget {
  @override
  _DrawPictureState createState() => _DrawPictureState();
}

class _DrawPictureState extends State<DrawPicture> {
  ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageByProvider(AssetImage('assets/images/sabar.webp'));
    setState(() {

    });
  }

  //通过ImageProvider读取Image
  Future<ui.Image> loadImageByProvider(
    ImageProvider provider, {
    ImageConfiguration config = ImageConfiguration.empty,
  }) async {
    Completer<ui.Image> completer = Completer<ui.Image>(); //完成的回调
    ImageStreamListener listener;
    ImageStream stream = provider.resolve(config); //获取图片流
    listener = ImageStreamListener((ImageInfo frame, bool sync) {//监听
      final ui.Image image = frame.image;
      completer.complete(image); //完成
      stream.removeListener(listener); //移除监听
    });
    stream.addListener(listener); //添加监听
    return completer.future; //返回
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: PaperPainter(_image));
  }
}

class PaperPainter extends CustomPainter {
  Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final ui.Image image;

  PaperPainter(this.image) {
    _paint = Paint()
      ..filterQuality = FilterQuality.high
    ..color=Colors.black.withAlpha(180)
    ;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));
    _drawImage(canvas, size);
    _drawLine(size, canvas);
  }

  void _drawLine(Size size, Canvas canvas) {
      _paint..color = Color(0xFFF0F0F0);
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
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2, image.height / 2),
              width: image.width * 1.0,
              height: image.width * 1.0),
          Rect.fromLTRB(0, 0, size.width, size.height),
          _paint);
    }
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => oldDelegate.image!=image;
}
