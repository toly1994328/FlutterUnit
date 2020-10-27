import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/8/16
/// contact me by email 1981462002@qq.com
/// 说明: 234 WidgetInspector 该组件可以让你很方便地查看子组件层级结构,是Flutter Inspector插件的功能之一。
//    {
//      "widgetId": 234,
//      "name": "WidgetInspector基本使用",
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【selectButtonBuilder】: *选择按钮构造器   【InspectorSelectButtonBuilder】",
//    }
class WidgetInspectorDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: WidgetInspector(
        child: HomePage(),
        selectButtonBuilder: _selectButtonBuilder,
      ),
    );
  }

  Widget _selectButtonBuilder(BuildContext context, onPressed) {
    onPressed();
    return Container();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment(0, 0.7),
        child: Text(
          '你点击了$_count次',
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
      ),
    );
  }
}
