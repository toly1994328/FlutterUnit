import 'package:flutter/cupertino.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 48,
//      "name": 'CupertinoActivityIndicator基本使用',
//      "priority": 1,
//      "subtitle":
//          "【animating】 : 是否loading动画   【bool】\n"
//          "【radius】 : 半径   【double】",
//    }
class CustomCupertinoActivityIndicator extends StatelessWidget {
  const CustomCupertinoActivityIndicator({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 20,
      children: const [
        CupertinoActivityIndicator(
          animating: true,
          radius: 25,
        ),
        CupertinoActivityIndicator(
          animating: false,
          radius: 25,
        )
      ],
    );
  }
}
