import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 152,
//      "name": 'Ink.image图片水波纹',
//      "priority": 2,
//      "subtitle": "    其中属性与Image组件一致，详见Image组件",
//    }

class InkImage extends StatelessWidget {
  const InkImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[800],
      child: Center(
        child: Ink.image(
          image: const AssetImage('assets/images/sabar.webp'),
          fit: BoxFit.cover,
          width: 300.0,
          height: 200.0,
          child: InkWell(
              onTap: () {},
              child: const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Chaos',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, color: Colors.black)),
                ),
              )),
        ),
      ),
    );
  }
}
