/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 142,
//      "name": 'BottomSheet基本使用',
//      "priority": 1,
//      "subtitle":
//          "【builder】 : 组件构造器   【WidgetBuilder】\n"
//          "【backgroundColor】 : 背景色   【Color】\n"
//          "【elevation】 : 影深   【double】\n"
//          "【shape】 : 形状   【ShapeBorder】\n"
//          "【onClosing】 : 关闭回调  【Function()】",
//    }

import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          opened = !opened;
          opened
              ? Scaffold.of(context).showBottomSheet((_) => _buildBottomSheet())
              : Navigator.of(context).pop();
        },
        child: const Text(
          '点我显隐BottomSheet',
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buildBottomSheet() => BottomSheet(
      enableDrag: true,
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(60),
        topLeft: Radius.circular(60),
      )),
      backgroundColor: Colors.transparent,
      onClosing: () => print('onClosing'),
      builder: (_) => (Container(
        height: 250,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sabar_bar.webp'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  topLeft: Radius.circular(60),
                )),
          )));
}
