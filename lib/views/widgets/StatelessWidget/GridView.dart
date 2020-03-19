import 'package:flutter/material.dart';

import 'package:flutter_unit/app/utils/color_utils.dart';

class GridViewPage extends StatefulWidget {

  @override
  _GridViewGridViewExtentState createState() => _GridViewGridViewExtentState();
}
class _GridViewGridViewExtentState extends State<GridViewPage> {
  List<int> data;

  @override
  void initState() {
    data=List.generate(50, (i)=>i);//生成50个数字
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var builder= GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//网格代理：定交叉轴数目
        crossAxisCount: 4,//条目个数
        mainAxisSpacing: 10,//主轴间距
        crossAxisSpacing: 10,//交叉轴间距
        childAspectRatio:1/0.618,//交叉轴方向item尺寸/主轴方向item尺寸
      ),
      itemBuilder: (_, int position) => Container( alignment: Alignment.center,
            color: ColorUtils.randomColor(limitA: 255),child: Text("$position") ),
      padding: EdgeInsets.all(10),
      scrollDirection: Axis.vertical,//滑动方向
    );
    return builder;
  }
}