import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-14
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 40,
//      "name": 'Switch图片',
//      "priority": 2,
//      "subtitle":
//          "【inactiveThumbImage】 : 未选中小圈图片   【ImageProvider】\n"
//          "【activeThumbImage】 : 选中时滑槽颜色   【ImageProvider】",
//    }
class ImageSwitch extends StatefulWidget {
  @override
  _ImageSwitchState createState() => _ImageSwitchState();
}

class _ImageSwitchState extends State<ImageSwitch> {
  final imgs = [
    "assets/images/head_icon/icon_5.webp",
    "assets/images/head_icon/icon_6.webp",
    "assets/images/head_icon/icon_7.webp",
    "assets/images/head_icon/icon_8.webp"];
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

