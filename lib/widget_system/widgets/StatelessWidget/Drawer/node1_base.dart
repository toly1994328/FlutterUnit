
/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 154,
//      "name": 'Drawer基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【elevation】 : 影深  【double】",
//    }
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

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
    children: const <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
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
      ),
      ListTile(
        leading: Icon(
          Icons.star,
          color: Colors.blue,
        ),
        title: Text('我的收藏'),
      ),
      ListTile(
        leading: Icon(
          Icons.palette,
          color: Colors.orangeAccent,
        ),
        title: Text('我的绘画'),
      ),
      ListTile(
        leading: Icon(
          Icons.insert_drive_file,
          color: Colors.green,
        ),
        title: Text('我的文件'),
      ),
    ],
  );
}
