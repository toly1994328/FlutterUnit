import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/components/colorful_text.dart';
import 'package:flutter_unit/components/flutter_text.dart';

/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明:

class UnitSplash extends StatefulWidget {
  final double size;

  UnitSplash({this.size = 200});

  @override
  _UnitSplashState createState() => _UnitSplashState();
}

class _UnitSplashState extends State<UnitSplash> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _secondController;
  double _factor;
  double _secondFactor = 0.0;
  Animation _curveAnim;
  Animation _curveAnim2;
  Animation _bouncAnim;
  bool _animEnd = false;

  final Widget flutter = ColorfulText("Flutter");
  final Widget unit = ColorfulText(" Unit");

  @override
  void initState() {
//    SystemUiOverlayStyle systemUiOverlayStyle =
//    SystemUiOverlayStyle(statusBarColor: Colors.red);
//    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(
//      systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//    SystemChrome.setEnabledSystemUIOverlays([]);



    _controller =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addListener(() => setState(() {
                return _factor = _curveAnim.value;
              }))
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) {
              setState(() {
                _animEnd = true;
                _secondController.forward();
              });
            }
          });
    _secondController =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addListener(() => setState(() {
                return _secondFactor = _curveAnim2.value;
              }))
          ..addStatusListener((s) {
            if (s == AnimationStatus.completed) {
              Navigator.of(context).pushReplacementNamed(Router.nav);
            }
          });
    _curveAnim =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _bouncAnim =
        CurvedAnimation(parent: _secondController, curve: Curves.bounceOut);
    _curveAnim2 =
        CurvedAnimation(parent: _secondController, curve: Curves.fastOutSlowIn);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var winH = MediaQuery.of(context).size.height;
    var winW = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        _controller.reset();
        _controller.forward();
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            RotationTransition(
              turns: _controller,
              child: ScaleTransition(
                scale: Tween(begin: 2.0, end: 1.0).animate(_controller),
                child: FadeTransition(
                    opacity: _controller,
                    child: FlutterLogo(
                      size: 35,
                    )),
              ),
            ),
            Container(
              width: winW,
              height: winH,
              child: CustomPaint(
                painter: UnitPainter(factor: _factor),
              ),
            ),
            Positioned(
              top: winH / 1.4,
              left: winW * 0.18 * (_secondFactor * 1.5 - 0.5),
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _animEnd ? 1.0 : 0.0,
                  child: flutter),
            ),
            Positioned(
              top: winH / 1.4 * (0.4 * _bouncAnim.value + 0.6),
              left: winW * 0.55,
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _animEnd ? 1.0 : 0.0,
                  child: unit),
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _animEnd ? 1.0 : 0.0,
                  child: Text("Power By 张风捷特烈",
                      style: TextStyle(
                          color: Colors.grey,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                blurRadius: 1,
                                offset: Offset(0.3, 0.3))
                          ],
                          fontSize: 16))),
            ),
          ],
        ),
      ),
    );
  }
}

class UnitPainter extends CustomPainter {
  Paint _paint;
  double width;
  double factor;
  Path _path1 = Path();
  Path _path2 = Path();
  Path _path3 = Path();
  Path _path4 = Path();

  UnitPainter({this.width = 200.0, this.factor}) {
    _paint = Paint()
      ..color = Colors.black
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(
        size.width / 2 - width * 0.5, size.height / 2 - width * 0.5);

    canvas.save();
    canvas.translate(
        -size.width / 2 * (1 - factor), -size.width / 2 * (1 - factor));
    drawColor1(canvas);
    canvas.restore();

    canvas.save();

    canvas.translate(
        size.width / 2 * (1 - factor), -size.width / 2 * (1 - factor));
    drawColor2(canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(
        size.width / 2 * (1 - factor), size.width / 2 * (1 - factor));
    drawColor3(canvas);
    canvas.restore();

    canvas.save();
    canvas.translate(
        -size.width / 2 * (1 - factor), size.width / 2 * (1 - factor));
    drawColor4(canvas);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void drawColor1(Canvas canvas) {
    _path1.moveTo(0, 0);
    _path1.lineTo(width * 0.618 * factor - 1, 0);
    _path1.lineTo(width * 0.5 - 1, width * 0.5 - 1);
    _path1.lineTo(0, width * (1 - 0.618) * factor - 1);

    canvas.drawPath(_clipAngle(_path1), _paint..color = Colors.red);
  }

  void drawColor2(Canvas canvas) {
    _path2.moveTo(width * 0.618 * factor, 0);
    _path2.lineTo(width, 0);
    _path2.lineTo(width, width * 0.618 * factor);
    _path2.lineTo(width * 0.5, width * 0.5);

    canvas.drawPath(_clipAngle(_path2), _paint..color = Colors.blue);
  }

  void drawColor3(Canvas canvas) {
    _path3.moveTo(width * 0.5 + 1, width * 0.5 + 1);
    _path3.lineTo(width, width * 0.618 * factor + 1);
    _path3.lineTo(width, width);
    _path3.lineTo(width * (1 - 0.618) * factor + 1, width);
    canvas.drawPath(_clipAngle(_path3), _paint..color = Colors.green);
  }

  void drawColor4(Canvas canvas) {
    _path4.moveTo(0, width * (1 - 0.618) * factor);
    _path4.lineTo(width * 0.5, width * 0.5);
    _path4.lineTo(width * (1 - 0.618) * factor, width);
    _path4.lineTo(0, width);
    canvas.drawPath(_clipAngle(_path4), _paint..color = Colors.yellow);
  }

  Path _clipAngle(Path path) {
    return Path.combine(
        PathOperation.difference,
        path,
        Path()
          ..addOval(Rect.fromCircle(
              center: Offset(width * 0.5, width * 0.5), radius: 25.0)));
  }
}
