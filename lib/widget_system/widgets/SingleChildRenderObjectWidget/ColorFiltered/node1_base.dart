import 'package:flutter/material.dart';
import '../../../../app/utils/color_utils.dart';
/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 88,
//      "name": 'ColorFiltered基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 孩子组件   【Widget】\n"
//          "【colorFilter】 : 滤色器   【ColorFilter】",
//    }
class CustomColorFiltered extends StatefulWidget {
  @override
  _CustomColorFilteredState createState() => _CustomColorFilteredState();
}

class _CustomColorFilteredState extends State<CustomColorFiltered> {
  Color _color = Colors.blue.withAlpha(88);

  @override
  Widget build(BuildContext context) {
    _color = ColorUtils.randomColor();
    return Column(
      children: <Widget>[
        Wrap(spacing: 10, runSpacing: 10, children: [
          _buildRandomColor(),
          ...BlendMode.values
              .map((mode) => Column(
                    children: <Widget>[
                      _buildChild(mode),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        mode.toString().split('.')[1],
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ))
              .toList()
        ]),
      ],
    );
  }

  Widget _buildChild(m) => Container(
        width: 58,
        height: 58,
        child: ColorFiltered(
            child: Image(image: AssetImage("assets/images/icon_head.webp")),
            colorFilter: ColorFilter.mode(_color, m)),
      );

  Widget _buildRandomColor() => GestureDetector(
        onTap: () => setState(() {}),
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          child: Text('点我'),
        ),
      );
}
