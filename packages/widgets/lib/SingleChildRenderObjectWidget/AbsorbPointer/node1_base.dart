import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-19
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 295,
//      "name": 'AbsorbPointer基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 孩子组件   【Widget】\n"
//          "【absorbing】 : 是否吸收事件   【bool】\n"
//          "如下,Switch选中时absorbing为true，按钮事件将被吸收，无法点击。",
//    }

class CustomAbsorbPointer extends StatefulWidget {
  const CustomAbsorbPointer({Key? key}) : super(key: key);

  @override
  _CustomAbsorbPointerState createState() => _CustomAbsorbPointerState();
}

class _CustomAbsorbPointerState extends State<CustomAbsorbPointer> {
  bool _absorbing = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            print('AbsorbPointer');
          },
          child: AbsorbPointer(
            absorbing: _absorbing,
            child: _buildButton(),
          ),
        ),
        _buildSwitch(),
        Text(!_absorbing ? '允许点击' : '事件已被吸收')
      ],
    );
  }

  Widget _buildButton() => ElevatedButton(
      child: const Text(
        'To About',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () => Navigator.of(context).pushNamed('AboutMePage'));

  Widget _buildSwitch() => Switch(
      value: _absorbing,
      onChanged: (v) {
        setState(() {
          _absorbing = v;
        });
      });
}
