import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 257 DrawerController  为 Drawer 组件提供交互行为，一般很少使用。在 Scaffold 组件源码中有使用场景。
//    {
//      "widgetId": 257,
//      "name": 'DrawerController基本使用',
//      "priority": 1,
//      "subtitle":
//          "【drawerCallback】 : 事件回调   【DrawerCallback】\n"
//          "【enableOpenDragGesture】 : 是否侧边滑开   【bool】\n"
//          "【alignment】 : 对齐方式   【DrawerAlignment】\n"
//          "【scrimColor】 : 背景颜色   【Color】\n"
//          "【child】 : Drawer组件   【Widget】",
//    }

class DrawerControllerDemo extends StatefulWidget {
  const DrawerControllerDemo({Key? key}) : super(key: key);

  @override
  _DrawerControllerDemoState createState() => _DrawerControllerDemoState();
}

class _DrawerControllerDemoState extends State<DrawerControllerDemo> {
  final GlobalKey<DrawerControllerState> _drawerKey =
      GlobalKey<DrawerControllerState>();

  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: toggleDrawer,
          child: const Text("显隐 Drawer"),
        ),
        SizedBox(
          height: 200,
          child: DrawerController(
            scrimColor: Colors.blue.withAlpha(88),
            enableOpenDragGesture: true,
            key: _drawerKey,
            alignment: DrawerAlignment.start,
            drawerCallback: (value) {
              _open = value;
            },
            child: Drawer(
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                child: const Text(
                  "I am Drawer!",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void toggleDrawer() {
    if (_open) {
      _drawerKey.currentState?.close();
    } else {
      print('---open--$_open-------');
      _drawerKey.currentState?.open();
    }
  }
}
