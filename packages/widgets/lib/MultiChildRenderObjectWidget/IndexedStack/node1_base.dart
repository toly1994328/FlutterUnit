import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 161,
//      "name": 'IndexedStack基本使用',
//      "priority":1 ,
//      "subtitle":
//          "【children】 : 子组件列表   【Lis<Widget>】\n"
//          "【alignment】 : 对齐方式   【AlignmentGeometry】\n"
//          "【index】 : 当前显示组件  【int】",
//    }
class CustomIndexedStack extends StatefulWidget {
  const CustomIndexedStack({Key? key}) : super(key: key);

  @override
  _CustomIndexedStackState createState() => _CustomIndexedStackState();
}

class _CustomIndexedStackState extends State<CustomIndexedStack> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        Container(
          width: 200,
          height: 100,
          color: Colors.grey.withAlpha(33),
          child: IndexedStack(
            index: _index,
            children: <Widget>[
              Container(
                color: Colors.red,
                width: 80,
                height: 80
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  color: Colors.blue,
                  width: 80,
                  height: 80,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitch() => Switch(
        value: _index == 0,
        onChanged: (v) => setState(() => _index = v ? 0 : 1),
      );
}
