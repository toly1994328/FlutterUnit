import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/8/18
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 270,
//      "name": 'SliverConstrainedCrossAxis 基本使用',
//      "priority": 1,
//      "subtitle":
//          "【maxExtent】 : 大小   【double】\n"
//          "【sliver】 : 子组件   【Widget?】",
//    }
class SliverConstrainedCrossAxisDemo extends StatelessWidget {
  const SliverConstrainedCrossAxisDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverCrossAxisGroup(
            slivers: <Widget>[
              SliverConstrainedCrossAxis(
                maxExtent: 100,
                sliver: _SliverColorList(
                  height: 100.0,
                  fontSize: 24,
                  count: 8,
                  color1: Colors.amber[300],
                  color2: Colors.blue[300],
                ),
              ),
              SliverCrossAxisExpanded(
                flex: 1,
                sliver: _SliverColorList(
                  height: 80.0,
                  fontSize: 18,
                  count: 15,
                  color1: Colors.green[300],
                  color2: Colors.red[300],
                ),
              ),
              SliverCrossAxisExpanded(
                  flex: 1,
                  sliver: _SliverColorList(
                    height: 50.0,
                    fontSize: 20,
                    count: 6,
                    color1: Colors.purple[300],
                    color2: Colors.orange[300],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class _SliverColorList extends StatelessWidget {
  final double height;
  final double fontSize;
  final Color? color1;
  final Color? color2;
  final int count;
  const _SliverColorList(
      {super.key,
        required this.height,
        required this.fontSize,
        required this.count,
        this.color1,
        this.color2});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: index.isEven ? color1 : color2,
          height: height,
          child: Center(
            child: Text(
              'Item ${index}',
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        );
      },
      itemCount: count,
    );
  }
}