import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/8/18
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 209,
//      "name": 'DecoratedSliver 基本使用',
//      "priority": 1,
//      "subtitle":
//          "【sliver】 : 孩子组件   【Widget?】\n"
//          "【decoration】 : 装饰对象   【Decoration】\n"
//          "【position】 : 装饰位置   【DecorationPosition】",
//    }
class DecorationSliverDemo extends StatelessWidget {
  const DecorationSliverDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: DecoratedSliver(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xFF111133),
                      blurRadius: 2,
                      offset: Offset(-2, -1))
                ],
                gradient: LinearGradient(
                  colors: const <Color>[
                    Color(0xFFEEEEEE),
                    Color(0xFF111133),
                  ],
                  stops: const <double>[0.1, 1.0],
                ),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                        (_, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                            '张风捷特烈-$index',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          )),
                    ),
                    childCount: 128),
              ),
            ),
          ),
        ],
      ),
    );
  }
}