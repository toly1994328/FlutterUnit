import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-27
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 163,
//      "name": 'GridView.count构造',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 子组件列表   【List<Widget>】\n"
//          "【crossAxisCount】 : 主轴一行box数量  【int】\n"
//          "【mainAxisSpacing】 : 主轴每行间距  【double】\n"
//          "【crossAxisSpacing】 : 交叉轴每行间距  【double】\n"
//          "【childAspectRatio】 : box主长/交叉轴长  【double】\n"
//          "【crossAxisCount】 : 主轴一行数量  【int】",
//    }
class CustomGridView extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFFFF00FF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1/0.618,
        children: data
            .map((color) => _buildItem(color))
            .toList(),
      ),
    );
  }

  Container _buildItem(Color color) => Container(
                alignment: Alignment.center,
                width: 100,
                height: 30,
                color: color,
                child: Text(
                  colorString(color),
                  style: TextStyle(color: Colors.white, shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(.5, .5),
                        blurRadius: 2)
                  ]),
                ),
              );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}

//    {
//      "widgetId": 163,
//      "name": 'GridView滑动方向',
//      "priority": 2,
//      "subtitle":
//          "【scrollDirection】 : 滑动方向   【Axis】\n"
//          "【reverse】 : 是否反向滑动   【bool】\n"
//          "【shrinkWrap】 : 无边界时是否包裹  【bool】",
//    }
class HorizontalGridView extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF00FFFF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.count(
        scrollDirection: Axis.horizontal,
        reverse: true,
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.618,
        children: data
            .map((color) => _buildItem(color))
            .toList(),
      ),
    );
  }

  Container _buildItem(Color color) => Container(
    alignment: Alignment.center,
    width: 100,
    height: 30,
    color: color,
    child: Text(
      colorString(color),
      style: TextStyle(color: Colors.white, shadows: [
        Shadow(
            color: Colors.black,
            offset: Offset(.5, .5),
            blurRadius: 2)
      ]),
    ),
  );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
//    {
//      "widgetId": 163,
//      "name": 'GridView.extent构造',
//      "priority": 3,
//      "subtitle":
//          "【maxCrossAxisExtent】 : box轴向长度   【double】\n"
//          "【reverse】 : 是否反向滑动   【bool】\n"
//          "【shrinkWrap】 : 无边界时是否包裹  【bool】",
//    }
class ExtentGridView extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF00FFFF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.extent(
        scrollDirection: Axis.horizontal,
        maxCrossAxisExtent: 80.0,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 0.618,
        children: data
            .map((color) => _buildItem(color))
            .toList(),
      ),
    );
  }

  Container _buildItem(Color color) => Container(
    alignment: Alignment.center,
    width: 100,
    height: 30,
    color: color,
    child: Text(
      colorString(color),
      style: TextStyle(color: Colors.white, shadows: [
        Shadow(
            color: Colors.black,
            offset: Offset(.5, .5),
            blurRadius: 2)
      ]),
    ),
  );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}

//    {
//      "widgetId": 163,
//      "name": 'GridView.builder构造',
//      "priority": 4,
//      "subtitle":
//          "【itemCount】 : 条目数量   【int】\n"
//          "【gridDelegate】 : 网格代理   【SliverGridDelegate】\n"
//          "【itemBuilder】 : 条目构造器  【IndexedWidgetBuilder】",
//    }
class BuilderGridView extends StatelessWidget {
  final data = List.generate(128, (i) => Color(0xFF33FFF - 2*i));

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.builder(
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//网格代理：定交叉轴数目
          crossAxisCount: 4,//条目个数
          mainAxisSpacing: 5,//主轴间距
          crossAxisSpacing: 5,//交叉轴间距
          childAspectRatio:1/0.618),
        itemBuilder: (_, int position)=> _buildItem(data[position])
      ),
    );
  }

  Container _buildItem(Color color) => Container(
    alignment: Alignment.center,
    width: 100,
    height: 30,
    color: color,
    child: Text(
      colorString(color),
      style: TextStyle(color: Colors.white, shadows: [
        Shadow(
            color: Colors.black,
            offset: Offset(.5, .5),
            blurRadius: 2)
      ]),
    ),
  );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}