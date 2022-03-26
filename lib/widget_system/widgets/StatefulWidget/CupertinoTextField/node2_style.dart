import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 245 CupertinoTextField 1 Cupertino风格的输入框,属性和TextField类似,可指定控制器、文字样式、装饰线、行数限制、游标样式等。接收输入变化、完成输入等事件。
//    {
//      "widgetId": 245,
//      "name": 'CupertinoTextField常用样式属性',
//      "priority": 2,
//      "subtitle": "【style】 : 输入文字样式   【TextStyle】\n"
//          "【prefix】: 前缀组件   【Widget】\n"
//          "【prefixMode】: 前缀模式   【OverlayVisibilityMode】\n"
//          "【suffix】: 后缀组件   【Widget】\n"
//          "【suffixMode】: 后缀模式   【OverlayVisibilityMode】\n"
//          "【cursorColor】: 游标颜色   【Color】\n"
//          "【cursorWidth】: 游标宽度   【double】\n"
//          "【cursorRadius】: 游标圆角   【Radius】\n"
//          "【readOnly】: 是否只读    【bool】",
//    }
class CupertinoTextFieldStyle extends StatelessWidget {
  const CupertinoTextFieldStyle({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const CupertinoTextField(
      style: TextStyle(color: Colors.blue),
      prefix: Icon(CupertinoIcons.add),
      prefixMode: OverlayVisibilityMode.notEditing,
      suffix: Icon(CupertinoIcons.clear),
      suffixMode: OverlayVisibilityMode.editing,
      cursorColor: Colors.purple,
      cursorWidth: 4,
      cursorRadius: Radius.circular(2),
      readOnly: false,
      placeholder: '输入用户名',
    );
  }
}
