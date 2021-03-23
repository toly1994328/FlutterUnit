import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/style/unit_text_style.dart';

class SplashBottom extends StatefulWidget {
  @override
  _SplashBottomState createState() => _SplashBottomState();
}

class _SplashBottomState extends State<SplashBottom> {
  bool _animStart = false;

  final Duration delayTime = const Duration(milliseconds: 600);
  final Duration animTime = const Duration(milliseconds: 800);
  final String logoPath = 'assets/images/icon_head.webp';

  @override
  void initState() {
    super.initState();
    // 延迟 600 ms 后开启动画
    Future.delayed(delayTime).then(startAnim);
  }

  FutureOr<Null> startAnim(value){
    setState(() {
      _animStart = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        duration: animTime,
        opacity: _animStart ? 1.0 : 0.0,
        child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text("Power By 张风捷特烈", style: TStyleUnit.splashShadows),
                const Text("· 2021 ·  @编程之王 ", style: TStyleUnit.splashShadows),
              ],
        ));
  }
}
