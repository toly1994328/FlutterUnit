
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 261 MergeableMaterial 可合并材料  用于展示 MergeableMaterialItem 的列表，包括 MaterialSlice(主体) 和 MaterialGap(分隔) 。
//    {
//      "widgetId": 261,
//      "name": 'MergeableMaterial基本使用',
//      "priority": 1,
//      "subtitle":
//          "【elevation】 : 影深   【double】\n"
//          "【hasDividers】 : 是否有分隔线   【bool】\n"
//          "【dividerColor】 : 分隔线颜色   【Color】\n"
//          "【mainAxis】 : 轴向   【Axis】\n"
//          "【children】 : 子组件集   【List<MergeableMaterialItem>】",
//    }

class MergeableMaterialDemo extends StatefulWidget {
  const MergeableMaterialDemo({Key? key}) : super(key: key);

  @override
  _MergeableMaterialDemoState createState() => _MergeableMaterialDemoState();
}

class _MergeableMaterialDemoState extends State<MergeableMaterialDemo> {
  List<MergeableMaterialItem> items=[];

  @override
  void initState() {
    super.initState();
    _init(20);
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 300,
      child: SingleChildScrollView(
              child: MergeableMaterial(
                elevation: 1,
                hasDividers: true,
                dividerColor: Colors.red,
                children: items,
              ),
      ),
    );
  }

  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!
  ];

  void _init(int count) {
    for (int i = 0; i < count; i++) {
      items.add(MaterialSlice(
          key: ValueKey(i),
          child: Container(
            alignment: Alignment.center,
            height: 60,
            color: data[i % data.length],
            child: Text(colorString(data[i % data.length])),
          )));
      if(i!=count-1){
        items.add(MaterialGap(
            key: ValueKey(i),
            size: 5));
      }
    }
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
