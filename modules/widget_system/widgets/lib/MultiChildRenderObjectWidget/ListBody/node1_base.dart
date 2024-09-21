import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/8/2
/// contact me by email 1981462002@qq.com


class ListBodyDemo extends StatelessWidget {
  const ListBodyDemo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
          children: <Widget>[
            ListBody(
              mainAxis: Axis.vertical,
              reverse: false,
              children: <Widget>[
                Container(color: Colors.red,  height: 50.0,),
                Container(color: Colors.orange, height: 50.0,),
                Container(color: Colors.yellow,  height: 50.0,),
              ],
            ),
            Container(color: Colors.green,  height: 80.0,),
            ListBody(
              mainAxis: Axis.vertical,
              reverse: false,
              children: <Widget>[
                Container(color: Colors.blue, height: 50.0,),
                Container(color: Colors.indigo,  height: 50.0,),
                Container(color: Colors.purple, height: 50.0,),
              ],
            )
          ]
      ),
    );
  }
}
