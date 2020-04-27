import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//    {
//      "widgetId": 95,
//      "name": 'Column基本使用',
//      "priority": 1,
//      "subtitle":
//          "【children】 : 组件列表   【List<Widget>】\n"
//          "【mainAxisAlignment】 : 主轴对齐   【MainAxisAlignment】\n"
//          "【crossAxisAlignment】 : 交叉轴对齐   【CrossAxisAlignment】\n"
//          "【textBaseline】 : 文字基线   【TextBaseline】\n"
//          "【verticalDirection】 : 竖直方向   【VerticalDirection】\n"
//          "【mainAxisSize】 : 主轴尺寸   【MainAxisSize】",
//    }

class CustomColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTitle(),
        _buildContent(context),
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
        height: 70,
        color: Color(0x4484FFFF),
        child: Row(
          children: <Widget>[
            Padding(
              child: Icon(
                Icons.add_location,
                size: 30,
                color: Colors.pink,
              ),
              padding: EdgeInsets.only(left: 25, right: 20),
            ),
            Expanded(
              child: Text(
                "附近",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              child: Icon(Icons.keyboard_arrow_right, color: Colors.black38),
              padding: EdgeInsets.only(right: 25),
            ),
          ],
        ));
  }

  Widget _buildContent(ctx) => Container(
        width: MediaQuery.of(ctx).size.width,
        color: Colors.orangeAccent,
        height: 100,
        child: Icon(
          Icons.android,
          size: 50,
          color: Colors.white,
        ),
      );
}
