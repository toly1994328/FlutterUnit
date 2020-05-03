import 'package:flutter/material.dart';
import '../../../dialogs/dialog_about.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 174,
//      "name": 'PopupMenuDivider基本使用',
//      "priority": 1,
//      "subtitle":
//          "【height】 : 高度  【double】",
//    }
class CustomPopupMenuDivider extends StatelessWidget {
  final map = {
    "关于": Icons.info_outline,
    "帮助": Icons.help_outline,
    "问题反馈": Icons.add_comment,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildPopupMenuButton(context),
          PopupMenuDivider(),
        ],
      ),
    );
  }

  PopupMenuButton<String> _buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
          itemBuilder: (context) => [
            ...buildItems().sublist(0, 2),
            PopupMenuDivider(),
            ...buildItems().sublist(2, 3)
          ],
          offset: Offset(0, 50),
          color: Color(0xffF4FFFA),
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          )),
          onSelected: (e) {
            print(e);
            if (e == '关于') {
              DialogAbout.show(context);
            }
          },
          onCanceled: () => print('onCanceled'),
        );
  }

  List<PopupMenuItem<String>> buildItems() {
    return map.keys
        .toList()
        .map((e) => PopupMenuItem<String>(
            value: e,
            child: Wrap(
              spacing: 10,
              children: <Widget>[
                Icon(
                  map[e],
                  color: Colors.blue,
                ),
                Text(e),
              ],
            )))
        .toList();
  }
}
