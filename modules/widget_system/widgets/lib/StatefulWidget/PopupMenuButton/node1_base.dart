import 'package:flutter/material.dart';
import 'package:widgets/utils/dialog_about.dart';


/// create by 张风捷特烈 on 2020-03-16
/// contact me by email 1981462002@qq.com

class CustomPopupMenuButton extends StatefulWidget {
  const CustomPopupMenuButton({Key? key}) : super(key: key);

  @override
  _CustomPopupMenuButtonState createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  final Map<String, IconData> map = const {
    "关于": Icons.info_outline,
    "帮助": Icons.help_outline,
    "问题反馈": Icons.add_comment,
  };

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => buildItems(),
      offset: const Offset(0, 50),
      color: const Color(0xffF4FFFA),
      elevation: 1,
      shape: const RoundedRectangleBorder(
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
                Icon(map[e], color: Colors.blue),
                Text(e),
              ],
            )))
        .toList();
  }
}
