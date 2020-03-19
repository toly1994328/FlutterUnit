import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/cons.dart';
import '../dialogs/dialog_about.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      //创建按钮菜单
      itemBuilder: (context) => Cons.MENU_INFO
          .map((e) => //根据字符串列表映射按钮菜单子项列表
              PopupMenuItem(value: Cons.MENU_INFO.indexOf(e), child: Text(e)))
          .toList(),
      onSelected: (i) {
        switch (i) {
          case 0:
            showDialog(context: context, builder: (context) => DialogAbout());
            break;
        }
      }, //选中时回调
    );
  }
}
