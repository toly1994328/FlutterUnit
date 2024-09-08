
/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明: 

//    {
//      "widgetId": 155,
//      "name": 'DrawerHeader基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【decoration】 : 装饰   【Decoration】\n"
//          "【margin】 : 外边距   【EdgeInsetsGeometry】\n"
//          "【padding】 : 内边距   【EdgeInsetsGeometry】",
//    }

import 'package:flutter/material.dart';
class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Unit'),
        ),
        drawer: Drawer(
          elevation: 3,
          child: _buildChild(),
        ),
      ),
    );
  }

  Widget _buildChild() => ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      _buildHeader(),
      const ListTile(
        leading: Icon(
          Icons.star,
          color: Colors.blue,
        ),
        title: Text('我的收藏'),
      ),
      const ListTile(
        leading: Icon(
          Icons.palette,
          color: Colors.orangeAccent,
        ),
        title: Text('我的绘画'),
      ),
      const ListTile(
        leading: Icon(
          Icons.insert_drive_file,
          color: Colors.green,
        ),
        title: Text('我的文件'),
      ),
    ],
  );

  Widget _buildHeader() => const DrawerHeader(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20,top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft:Radius.circular(40),
            topRight:Radius.circular(40)
        ),
        image: DecorationImage(
            image: AssetImage('assets/images/caver.webp'),
            fit: BoxFit.cover),
      ),
      child: Text(
        '张风捷特烈',
        style: TextStyle(fontSize: 24, color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 3)
        ]),
      ),
    );
}