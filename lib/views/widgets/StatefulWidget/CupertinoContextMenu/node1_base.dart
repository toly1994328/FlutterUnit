
/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 143,
//      "name": 'CupertinoContextMenu基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【actions】 : 行为组件集   【List<Widget>】\n"
//          "【previewBuilder】 : 动画构造器  【ContextMenuPreviewBuilder】",
//    }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoContextMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildCupertinoContextMenu(context),
    );
  }

  final info= ['保存图片','立刻呼叫','添加到收藏夹'];

  Widget _buildCupertinoContextMenu(context) => Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/sabar_bar.webp'),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(50))),
    width: 100,
    height: 100,
    child: CupertinoContextMenu(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sabar_bar.webp'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
          actions: info.map((e)=>CupertinoContextMenuAction(
            child: Center(child: Text(e)),
            onPressed: () => Navigator.pop(context),
          )).toList())
  );
}
