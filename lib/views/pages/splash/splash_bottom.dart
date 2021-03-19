import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/style/gap_unit.dart';
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
        child: Row(
          children: [
            Image.asset(logoPath, height: 20, width: 20),
            GapUnit.W5,
            Wrap(
              direction: Axis.vertical,
              children: [
                const Text("张风捷特烈技术支持", style: TStyleUnit.splashShadows),
                const Text("@编程之王 2021", style: TStyleUnit.splashShadows),
              ],
            ),
          ],
        ));
  }
}
