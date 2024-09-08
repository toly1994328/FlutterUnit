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
//          "【activeThumbImage】 : 选中小圈图片   【ImageProvider】",
//    }
class ImageSwitch extends StatefulWidget {
  const ImageSwitch({Key? key}) : super(key: key);

  @override
  _ImageSwitchState createState() => _ImageSwitchState();
}

class _ImageSwitchState extends State<ImageSwitch> {
  final List<String> imgs = const [
    "assets/images/head_icon/icon_5.webp",
    "assets/images/head_icon/icon_6.webp",
    "assets/images/head_icon/icon_7.webp",
    "assets/images/head_icon/icon_8.webp"
  ];
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
              activeThumbImage: const AssetImage('assets/images/icon_head.webp'),
              onChanged: (v) {
                setState(() => _checked = v);
              }))
          .toList(),
    );
  }
}

