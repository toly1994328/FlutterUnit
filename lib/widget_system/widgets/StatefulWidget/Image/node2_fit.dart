import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 38,
//      "name": '图片的适应模式',
//      "priority": 2,
//      "subtitle": "【fit】 : 适应模式*7   【BoxFit】\n",
//    },

class FitImage extends StatefulWidget {
  const FitImage({Key? key}) : super(key: key);

  @override
  _FitImageState createState() => _FitImageState();
}

class _FitImageState extends State<FitImage> {
  bool _smallImage = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> imageLi = BoxFit.values
        .toList()
        .map((mode) => Column(children:[
      Container(
          margin: const EdgeInsets.all(5),
          width: 100,
          height: 80,
          color: Colors.grey.withAlpha(88),
          child: Image(
              image: AssetImage(!_smallImage
                  ? "assets/images/wy_300x200.webp"
                  : "assets/images/wy_30x20.webp"),
              fit: mode)),
      Text(mode.toString().split(".")[1])
    ])).toList();

    return Wrap(
      children: [...imageLi, _buildSwitch()],
    );
  }

  Widget _buildSwitch() {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          const Text("使用小图"),
          Switch(
              value: _smallImage,
              onChanged: (b) => setState(() => _smallImage = b)),
        ],
      ),
    );
  }
}
