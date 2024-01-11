import 'dart:math';

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;


import 'flutter_unit_text.dart';

/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明: app 闪屏页
class FlutterUnitSplash extends StatelessWidget {
  const FlutterUnitSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Material(
        child: _SplashBody(),
      ),
    );
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    const TextStyle shadowStyle = UnitTextStyle.splashShadows;
    const TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold);

    return Column(
      children: [
        const SplashTopBar(
          leading: Text('Flutter Unit',style: titleStyle),
          logo: CircleAvatar(
            backgroundImage: AssetImage('assets/images/icon_head.webp'),
            radius: 14,
          ),
        ),
        const Spacer(),
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Stack(children: [ColorfulText(), FlutterLogo(size: 60)]),
            const SizedBox(height: 20),
            FlutterUnitText(
              text: StrUnit.appName,
              color: color,
            ),
          ],
        )),
        const Expanded(
            child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                bottom: 15,
                child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text("Power By 张风捷特烈", style: shadowStyle),
                    Text("· 2021 ·  @编程之王 ", style: shadowStyle),
                  ],
                )),
          ],
        ))
      ],
    );
  }
}

class ColorfulText extends StatelessWidget {
  const ColorfulText({super.key});

  @override
  Widget build(BuildContext context) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        const Offset(22, 0),
        [Colors.red, Colors.yellow, Colors.blue, Colors.green],
        [1 / 4, 2 / 4, 3 / 4, 1],
        TileMode.mirror,
        Matrix4.rotationZ(pi / 4).storage,
      );
    return Text(
      "U",
      style: TextStyle(
          fontSize: 26,
          height: 1,
          fontWeight: FontWeight.bold,
          foreground: paint),
    );
  }
}

class SplashTopBar extends StatelessWidget {
  final Widget? leading;
  final Widget? logo;

  const SplashTopBar({super.key, this.leading,this.logo});

  @override
  Widget build(BuildContext context) {
    if(!isDesk) return const SizedBox.shrink();
    return DragToMoveAreaNoDouble(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
            child: Row(
              children: [
                if (leading != null) Row(
                  children: [
                    if(logo!=null)logo!,
                    const SizedBox(width: 8,),
                    leading!,
                  ],
                ),
                const Spacer(),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Positioned(

              right: 0,
              child: const WindowButtons())
        ],
      ),
    );
  }
}
