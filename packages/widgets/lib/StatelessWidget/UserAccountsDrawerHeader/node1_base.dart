import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 22,
//      "priority": 1,
//      "name": "该组件的基本表现如下",
//      "subtitle": "【currentAccountPicture】: 上组件   【Widget】\n"
//          "【accountName】: 中组件   【Widget】\n"
//          "【accountEmail】: 下组件   【Widget】\n"
//          "【decoration】: 装饰   【Decoration】",
//    }

class CustomUAGHP extends StatelessWidget {
  const CustomUAGHP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3 * 2,
      child: UserAccountsDrawerHeader(
        accountName: Container(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "张风捷特烈",
            style:
                TextStyle(color: Colors.orangeAccent, fontSize: 22, shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(.5, .5),
                blurRadius: 2,
              ),
            ]),
          ),
        ),
        accountEmail: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("1981462002@qq.com",
              style: TextStyle(color: Colors.white, fontSize: 14, shadows: [
                Shadow(
                    color: Colors.orangeAccent,
                    offset: Offset(.5, .5),
                    blurRadius: 2),
              ])),
        ),
        currentAccountPicture: Container(
          padding: const EdgeInsets.all(15.0),
          child: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon_head.webp"),
          ),
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/caver.webp")),
        ),
      ),
    );
  }
}
