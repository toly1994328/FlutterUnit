import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


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
