import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/3
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 204,
//      "name": 'PreferredSize调整AppBar高度',
//      "priority": 1,
//      "subtitle": "【preferredSize】 : 尺寸   【Size】",
//    }
class CustomPreferredSize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: AppBar(
            title: Text('PreferredSize'),
          ),
        ),
      ),
    );
  }
}
