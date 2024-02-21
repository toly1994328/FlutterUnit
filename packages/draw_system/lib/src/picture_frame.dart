import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'desk_ui/desk_frame.dart';
import 'package:l10n/l10n.dart';
class PictureFrame extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Color? color;
  final Alignment? alignment;
  final EdgeInsetsGeometry? marge;

  const PictureFrame({Key? key, this.child,
    this.width,
    this.height,
    this.alignment,
    this.color = Colors.transparent,
    this.marge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.shortestSide;
    return Container(
      alignment: alignment,
      width: width ?? size,
      height: height ?? size,
      padding: marge ?? const EdgeInsets.all(20),
      child: CustomPaint(
        painter: FramePainter(),
        child: Container(
          margin: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: Colors.black12,
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class FramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..relativeLineTo(0, size.height)..relativeLineTo(size.width, 0)..relativeLineTo(0, -size.height)
      ..close();
    Paint myPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawPath(path, myPaint);
    Path shadowPath = Path()
      ..addRect(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)));
    // canvas.drawShadow(shadowPath, Colors.grey, 1, false);

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(-1, 1);
    canvas.translate(-size.width / 2, -size.height / 2);
    drawCorner(myPaint, canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(1, -1);
    canvas.translate(-size.width / 2, -size.height / 2);
    drawCorner(myPaint, canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(size.width, size.height);
    canvas.scale(-1, -1);
    drawCorner(myPaint, canvas);
    canvas.restore();
    drawCorner(myPaint, canvas);
    canvas.drawShadow(shadowPath, Colors.grey, 1, false);
  }

  void drawCorner(Paint myPaint, Canvas canvas) {
    myPaint
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..strokeCap = StrokeCap.butt;
    canvas.drawPoints(
        PointMode.polygon,
        [
          const Offset(0, 0),
          const Offset(18, 0),
          const Offset(0, 18),
          const Offset(0, 0),
        ],
        myPaint);
    canvas.drawCircle(const Offset(8, 8), 3, myPaint..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FrameShower extends StatelessWidget {
  final String title;
  final String author;
  final String srcUrl;
  final String info;
  final Widget content;

  const FrameShower({Key? key,
    this.title = "",
    this.author = "",
    this.srcUrl = "",
    this.info = "",
    required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDesk = Platform.isMacOS || Platform.isWindows || Platform.isLinux;
    if (isDesk) {
      return DeskFrameShower(
          content: content,
          title: title,
          author: author,
          srcUrl: srcUrl,
          info: info);
    }

    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          PictureFrame(child: content,color: Colors.white,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  "作者:    $author    ",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _launch,
                  child:  Text(
                    "${context.l10n.srcPath}    ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.topLeft,
              child: Text(
                info,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  void _launch() async {
    String url = 'https://github.com/toly1994328/FlutterUnit/tree/master/lib/painter_system$srcUrl';
    if (await canLaunch(url)) {
      await launch(url);
    } else {

    }
  }
}