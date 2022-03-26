import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020/4/27
/// contact me by email 1981462002@qq.com
/// 说明:

//     {
//      "widgetId": 21,
//      "priority": 1,
//      "name": "GridTile的基本表现如下",
//      "subtitle": "【header】: 头组件   【Widget】\n"
//          "【child】: 子组件   【Widget】\n"
//          "【footer】: 脚组件   【Widget】",
//      }

class CustomGridTile extends StatelessWidget {
  const CustomGridTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: GridTile(
        header: GridTileBar(
          backgroundColor: Colors.blue.withAlpha(120),
          trailing: const Icon(Icons.star, color: Colors.red),
          leading: const CircleAvatar(
            backgroundImage: AssetImage("assets/images/wy_200x300.webp"),
          ),
          title: const Text("百里·巫缨"),
          subtitle: const Text("倾国必倾城"),
        ),
        child: Opacity(
          opacity: 0.5,
          child: Image.asset("assets/images/sabar.webp", fit: BoxFit.cover),
        ),
        footer: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "ID:z\$ySX32&29",
            style: TextStyle(
              shadows: [
                Shadow(
                    color: Colors.blue, offset: Offset(.1, .1), blurRadius: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
