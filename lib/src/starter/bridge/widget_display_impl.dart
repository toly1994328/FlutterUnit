import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/icon_data.dart';
import 'package:unit_widgets_display/unit_widgets_display.dart';
import 'package:app/app.dart';

class WidgetDisplayImpl implements DisplayAbility {
  Random _random = Random();

  @override
  String get appVersion => '3.2.2+2004';

  @override
  List<IconData> get myIcon =>
      [TolyIcon.dark, TolyIcon.icon_fork, TolyIcon.icon_artifact];

  @override
  Color get randomColor {
    int limitA = 120;
    int limitR = 0;
    int limitG = 0;
    int limitB = 0;
    Random random = _random;
    int a = limitA + random.nextInt(256 - limitA); //透明度值
    int r = limitR + random.nextInt(256 - limitR); //红值
    int g = limitG + random.nextInt(256 - limitG); //绿值
    int b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(a, r, g, b); //生成argb模式的颜色
  }

  @override
  Future showAbout(BuildContext context) {
    return DialogAbout.show(context);
  }
}

class DialogAbout extends StatelessWidget {
  const DialogAbout({Key? key}) : super(key: key);

  static show(BuildContext context) {
    showDialog(
        //内置方法，创建对话弹框
        context: context,
        builder: (_) => const DialogAbout());
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Row(
      //标题
      children: <Widget>[
        Image.asset(
          "assets/images/icon_head.webp",
          width: 30,
          height: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        const Expanded(
            child: Text(
          "关于",
          style: TextStyle(fontSize: 18),
        )),
        InkWell(
          child: const Icon(Icons.close),
          onTap: () => Navigator.of(context).pop(),
        )
      ],
    );
    Widget content = Column(
        //内容
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          FlutterLogo(
            size: 50,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Flutter Unit ${StrUnit.version}",
          ),
        ]);
    return AlertDialog(title: title, content: content, actions: <Widget>[
      //左下角
      Padding(
          padding: const EdgeInsets.only(right: 15.0, bottom: 10, top: 10),
          child: Column(
            children: const [
              Text(
                "Power By GF·J·Toly\n张风捷特烈",
                textAlign: TextAlign.center,
              ),
            ],
          ))
    ]);
  }
}
