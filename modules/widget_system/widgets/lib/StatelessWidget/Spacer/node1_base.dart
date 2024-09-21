import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com

class OneSpacer extends StatelessWidget {
  const OneSpacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Colors.grey.withAlpha(33),
        child: Row(children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 100,
            height: 50,
            color: Colors.red,
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            width: 60,
            height: 50,
            color: Colors.blue,
          ),
        ],),
      );
  }
}