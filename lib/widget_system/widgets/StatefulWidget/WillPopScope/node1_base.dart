import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 170,
//      "name": 'WillPopScope使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onWillPop】 : 返回回调  【WillPopCallback】",
//    }
class CustomWillPopScope extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(child: (BackButton()),
          onWillPop: ()=>_willPop(context)),
    );
  }

  Future<bool> _willPop(context) async{
    return await showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title:  Text('提示'),
        content:  Text('你确定要离开此页吗?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:  Text('确定'),
          ),
           FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text('取消'),
          ),

        ],
      ),
    ) ?? false;

  }
}
