import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'unit_paint.dart';
import 'package:flutter_unit/app/router.dart';

/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明: app 闪屏页

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

  @override
  void initState() {
//    SystemUiOverlayStyle systemUiOverlayStyle =
//    SystemUiOverlayStyle(statusBarColor: Colors.red);
//    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//    SystemChrome.setSystemUIOverlayStyle(
//        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//      systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent);
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

    final shadowStyle = TextStyle(
      fontSize: 45,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          //阴影
          color: Colors.grey,
          offset: Offset(1.0, 1.0), blurRadius: 1.0,
        )
      ],
    );

    return
//      GestureDetector(
//      onTap: () {
//        _controller.reset();
//        _controller.forward();
//      },
//      child:
      Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildLogo(Colors.blue),
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
                  child: Text(
                    'Flutter',
                    style: shadowStyle,
                  )),
            ),
            buildHead(),
            Positioned(
              top: winH / 1.4 * (0.1 * _bouncAnim.value + 0.9),
              left: winW * 0.55,
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _animEnd ? 1.0 : 0.0,
                  child: Text(
                    'Unit',
                    style: shadowStyle,
                  )),
            ),
            buildPower(),
          ],
        ),
//      ),
    );
  }

  Widget buildLogo(Color primaryColor) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 0),
        end: Offset(0, -4),
      ).animate(_controller),
      child: RotationTransition(
          turns: _controller,
          child: ScaleTransition(
            scale: Tween(begin: 2.0, end: 1.0).animate(_controller),
            child: FadeTransition(
                opacity: _controller,
                child: FlutterLogo(
                  colors: primaryColor,
                  size: 45,
                )),
          )),
    );
  }

  Widget buildHead() {
    return SlideTransition(
        position: Tween<Offset>(
          end: Offset(0, 0),
          begin: Offset(0, -5),
        ).animate(_controller),
        child: Container(
          height: 45,
          width: 45,
          child: Image.asset('assets/images/icon_head.png'),
        ));
  }

  Widget buildPower() {
    return Positioned(
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
    );
  }
}
