import 'package:flutter/material.dart';
import 'package:flutter_unit/views/components/permanent/circle_image.dart';

import 'page_item.dart';

/// create by 张风捷特烈 on 2020/4/26
/// contact me by email 1981462002@qq.com
/// 说明:

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/sabar_bar.webp',
            fit: BoxFit.cover,
          ),
        ),
        SizedOverflowBox(
          size: Size(0, 0),
          child: Align(
            alignment: Alignment(-0.7, 0),
            child: CircleImage(
              size: 80,
              shadowColor: Theme.of(context).primaryColor.withAlpha(33),
              image: AssetImage("assets/images/icon_head.webp"),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, top: 8),
            child: Text(
              '张风捷特烈',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Expanded(child: MePageItem())
      ],
    ));
  }
}
