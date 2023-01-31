import 'package:flutter/material.dart';



/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 206 TabPageSelectorIndicator 一个有边线的圆形组件，可指定大小、颜色、边线色。是TabPageSelector的部分之一，一般不单独使用。

//    {
//      "widgetId": 206,
//      "name": "TabPageSelectorIndicator基本使用",
//      "priority": 1,
//      "subtitle": "【size】: 大小   【double】\n"
//          "【backgroundColor】: 背景色   【Color】\n"
//          "【borderColor】: 边线色    【Color】",
//    }

class TabPageSelectorIndicatorDemo extends StatelessWidget {
  const TabPageSelectorIndicatorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:const [
        TabPageSelectorIndicator(
          backgroundColor: Colors.greenAccent,
          borderColor: Colors.deepPurpleAccent,
          size: 15,
        ),
        TabPageSelectorIndicator(
          backgroundColor: Colors.blue,
          borderColor: Colors.grey,
          size: 20,
        ),
        TabPageSelectorIndicator(
          backgroundColor: Colors.green,
          borderColor: Colors.red,
          size: 25,
        ),
        TabPageSelectorIndicator(
          backgroundColor: Colors.yellow,
          borderColor: Colors.brown,
          size: 30,
        ),
        TabPageSelectorIndicator(
          backgroundColor: Colors.amber,
          borderColor: Colors.purpleAccent,
          size: 35,
        ),
      ],
    );
  }

}

