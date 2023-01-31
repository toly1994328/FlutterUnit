import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 114,
//      "name": 'DefaultTextStyleTransition基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【textAlign】 : 文字对齐方式  【TextAlign】\n"
//          "【softWrap】 : 是否包裹  【bool】\n"
//          "【maxLines】 : 最大行数  【int】\n"
//          "【overflow】 : 溢出模式  【TextOverflow】\n"
//          "【style】 : 动画   【Animation<TextStyle>】",
//    }
class CustomDefaultTextStyleTransition extends StatefulWidget {
  const CustomDefaultTextStyleTransition({Key? key}) : super(key: key);

  @override
  _CustomDefaultTextStyleTransitionState createState() =>
      _CustomDefaultTextStyleTransitionState();
}

class _CustomDefaultTextStyleTransitionState
    extends State<CustomDefaultTextStyleTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _ctrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _ctrl.reset();
            _ctrl.forward();
          });
        },
        child: Container(
          alignment: Alignment.center,
          width: 300,
          height: 100,
          child: DefaultTextStyleTransition(
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleTween(
                begin: const TextStyle(
                    color: Colors.blue,
                    fontSize: 50,
                    shadows: [
                      Shadow(
                          offset: Offset(1, 1),
                          color: Colors.black,
                          blurRadius: 3)
                    ]),
                end: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          offset: Offset(1, 1),
                          color: Colors.purple,
                          blurRadius: 3)
                    ])).animate(_ctrl),
            child: const Text('张风捷特烈'),
          ),
        ));
  }
}
