import 'package:flutter/material.dart';

class MultiShower extends StatelessWidget {
  MultiShower(
    this.list,
    this.call, {
    this.width = 110,
    this.height = 110 * 0.618,
    this.info,
    this.color = Colors.cyanAccent,
  });

  final List list;//数据
  final List<String> info;//底部介绍
  final Function call;//回调
  final double width;//单体宽
  final double height;//单体高
  final Color color;//颜色

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(child: Center(
      child: Wrap(
        children: list.map((e) => Column(
          children: <Widget>[
            Card(
              child: Container(
                  margin: EdgeInsets.all(2),
                  color: color,
                  width: width,
                  height: height,
                  child: call(e)),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(_getInfo(list.indexOf(e)),style: TextStyle(fontSize: 12),))
          ],
        )).toList(),
      ),
    ));
  }

  String _getInfo(int index) {
    var result="请添加info属性";
    if(info==null){
     var splits=list[index].toString().split(".");
     if (splits.length>1){
       result= splits[1];
     }
    }else{
      result=info[index];
    }
    return result;
  }
}

///------------测试 ---------
///
var show = MultiShower(
  BlendMode.values,
      (mode) => Image(
    image: AssetImage("assets/images/icon_head.png"),
    color: Colors.blue,
    colorBlendMode: mode,
  ),
  width: 56,
  height: 56,
);
