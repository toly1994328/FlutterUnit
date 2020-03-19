import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-14
/// contact me by email 1981462002@qq.com
/// 说明:

///    {
//      "widgetId": 40,
//      "name": 'Switch基础语法',
//      "priority": 1,
//      "subtitle":
//          "【inactiveThumbColor】 : 未选中小圈颜色   【Color】\n"
//          "【inactiveTrackColor】 : 未选中滑槽颜色   【Color】\n"
//          "【activeColor】 : 选中时小圈颜色   【Color】\n"
//          "【activeTrackColor】 : 选中时滑槽颜色   【Color】\n"
//          "【onChanged】 : 切换回调   【Function(double)】"
//          "  onChanged时,回调true、null、false三种状态",
//    }
class CustomSwitch extends StatefulWidget {
  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) =>
          Switch(
              value: _checked,
              inactiveThumbColor: e,
              inactiveTrackColor: Colors.grey.withAlpha(88),
              activeColor: Colors.green,
              activeTrackColor: Colors.orange,
              onChanged: (v) {
                setState(() => _checked = v);
              }))
          .toList(),
    );
  }
}

//    {
//      "widgetId": 40,
//      "name": 'Switch图片',
//      "priority": 2,
//      "subtitle":
//          "【inactiveThumbImage】 : 未选中小圈图片   【ImageProvider】\n"
//          "【activeThumbImage】 : 选中时滑槽颜色   【ImageProvider】"
//    }
class ImageSwitch extends StatefulWidget {
  @override
  _ImageSwitchState createState() => _ImageSwitchState();
}

class _ImageSwitchState extends State<ImageSwitch> {
  final imgs = [
    "assets/images/head_icon/icon_5.jpg",
    "assets/images/head_icon/icon_6.jpg",
    "assets/images/head_icon/icon_7.jpg",
    "assets/images/head_icon/icon_8.jpg"];
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: imgs
          .map((e) =>
          Switch(
              value: _checked,
              inactiveThumbImage: AssetImage(e),
              activeThumbImage: AssetImage('assets/images/pica.gif'),
              onChanged: (v) {
                setState(() => _checked = v);
              }))
          .toList(),
    );
  }
}

