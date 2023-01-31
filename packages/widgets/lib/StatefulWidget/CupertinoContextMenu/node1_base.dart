import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 143,
//      "name": 'CupertinoContextMenu基本使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【actions】 : 行为组件集   【List<Widget>】\n"
//          "【previewBuilder】 : 动画构造器  【ContextMenuPreviewBuilder】",
//    }
class CustomCupertinoContextMenu extends StatelessWidget {
  const CustomCupertinoContextMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: DecoratedBox(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/sabar_bar.webp'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: _buildCupertinoContextMenu(context)),
    );
  }

  final List<String> info = const ['保存图片', '立刻呼叫', '添加到收藏夹'];

  Widget _buildCupertinoContextMenu(context) => CupertinoContextMenu(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/sabar_bar.webp'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
      actions: info
          .map((e) => CupertinoContextMenuAction(
                child: Center(child: Text(e)),
                onPressed: () => Navigator.pop(context),
              ))
          .toList());
}
