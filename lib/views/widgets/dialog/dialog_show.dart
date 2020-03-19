import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'showAlertDialog.dart';
import 'showBottomSheet_.dart';
import 'showCupertinoAlertDialog.dart';
import 'showCupertinoDatePicker_.dart';
import 'showCupertinoPicker_.dart';
import 'showCupertinoTimerPicker_.dart';
import 'showDatePicker_.dart';
import 'showSnackBar.dart';
import 'showSimpleDialog.dart';
import 'showStatefulWidgetDialog.dart';
import 'showTimePicker_.dart';

class DialogShow extends StatefulWidget {
  DialogShow();

  @override
  _DialogShowState createState() => _DialogShowState();
}

class _DialogShowState extends State<DialogShow> {
  @override
  Widget build(BuildContext context) {
    var title = Container(//创建标题
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: AlignmentDirectional.center,
      child: Text("Dialog Unit", style: TextStyle(fontSize: 30),),
    );

    Map<String, Function> itemsInfo = {//条目信息
      "SimpleDialog": showSimpleDialog_,
      "AlertDialog": showAlertDialog_,
      "CupertinoAlertDialog": showCupertinoAlertDialog_,
      "Stateful In Dialog": showStatefulWidgetDialog_,
      "SnackBar": showSnackBar_,
      "BottomSheet": showBottomSheet_,
      "DatePicker": showDatePicker_,
      "TimePicker": showTimePicker_,
      "CupertinoPicker": showCupertinoPicker_,
      "CupertinoDatePicker": showCupertinoDatePicker_,
      "CupertinoTimerPicker": showCupertinoTimerPicker_,
    };

    var gridView = GridView.count(//生成GridView
      padding: EdgeInsets.all(10),
        childAspectRatio: 3,//孩子宽高比
        crossAxisCount: 2,//每行个数
     children: itemsInfo.keys.toList().map((key){//形成孩子列表
       var item = Container(
           alignment: Alignment.center,
           height: 20, width: 20,
           child: Text(key, style: TextStyle(fontSize: 16),));
       return InkWell(
         child: Card(child:item),
         onTap: () {
           itemsInfo[key](context);
         },
       );
     }).toList());

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[title,Expanded(child: gridView,)],),
    );
  }

}
