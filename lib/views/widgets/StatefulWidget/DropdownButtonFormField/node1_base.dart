import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 223 DropdownButtonFormField 表单下拉框
/// 底层依赖 DropdownButton 实现，所以基本属性类似。但拥有 FormField 的特性，可以回调 onSaved、validator 方法。
/// link: 55,222
///
//    {
//      "widgetId": 223,
//      "name": '表单下拉框简单使用',
//      "priority": 1,
//      "subtitle":
//          "【items】 : 子组件列表   【List<DropdownMenuItem<T>>】\n"
//          "【validator】 : 表单验证回调   【FormFieldValidator<T>】\n"
//          "【onSaved】 : 表单保存回调   【FormFieldSetter<T>】\n"
//          "其他属性详见 DropdownButton，表单校验特性详见 FormField。",
//    }

class DropdownButtonFormFieldDemo extends StatefulWidget {
  @override
  _DropdownButtonFormFieldDemoState createState() => _DropdownButtonFormFieldDemoState();
}

class _DropdownButtonFormFieldDemoState extends State<DropdownButtonFormFieldDemo> {
  Color _color;
  final _colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  final _info = ["红色", "黄色", "蓝色", "绿色"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 50,
          height: 50,
          color: _color??_colors[0],
        ),

        SizedBox(
          width: 80,
          child: DropdownButtonFormField<Color>(
              value: _color,
              elevation: 1,
              hint: Text('选择颜色',style: TextStyle(fontSize: 12),),
              icon: Icon(
                Icons.expand_more,
                size: 20,
                color: _color,
              ),
            items: _buildItems(),
              onChanged: (v) => setState(() => _color = v)
          ),
        )

      ],
    );
  }

  List<DropdownMenuItem<Color>> _buildItems() => _colors
      .map((e) => DropdownMenuItem<Color>(
      value: e,
      child: Text(
        _info[_colors.indexOf(e)],
        style: TextStyle(color: e),
      )))
      .toList();
}