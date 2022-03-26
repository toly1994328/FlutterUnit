import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 49,
//      "name": 'RefreshIndicator基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子(可滑动)   【Widget】\n"
//          "【displacement】 : 指示器悬浮高度   【double】\n"
//          "【color】 : 指示器颜色   【Color】\n",
//          "【backgroundColor】 : 指示器背景色   【Color】\n"
//          "【onRefresh】 : 异步函数   【Future<void> Function()】"
//    }
class CustomRefreshIndicator extends StatefulWidget {
  const CustomRefreshIndicator({Key? key}) : super(key: key);

  @override
  _CustomRefreshIndicatorState createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends State<CustomRefreshIndicator> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: RefreshIndicator(
        onRefresh: _increment,
        displacement: 20,
        color: Colors.orange,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 300,
            color: Colors.blue,
            child: Text('$_count',style: const TextStyle(color: Colors.white,fontSize: 40)),
          ),
        ),
      ),
    );
  }

  Future<void> _increment() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _count++;
    });
  }
}
