import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-24
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 128,
//      "name": 'SimpleDialog基本使用',
//      "priority": 1,
//      "subtitle":
//          "【title】 : 顶部组件   【Widget】\n"
//          "【children】 : 子组件列表  【List<Widget>】\n"
//          "【titlePadding】 : 顶部内边距  【EdgeInsetsGeometry】\n"
//          "【contentPadding】 : 内容内边距  【EdgeInsetsGeometry】\n"
//          "【backgroundColor】 : 背景色  【Color】\n"
//          "【elevation】 : 影深  【double】\n"
//          "【shape】 : 形状   【ShapeBorder】",
//    }
class CustomSimpleDialog extends StatelessWidget {
  const CustomSimpleDialog({Key? key}) : super(key: key);

  final List<String> info = const [
    '性别:    男     未婚',
    '微信:    zdl1994328',
    "掘金:    张风捷特烈",
    "github:    toly1994328",
    "邮箱:    1981462008@qq.com",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildSimpleDialog(context),
        Positioned(
            top: 70,
            right: 30,
            child: _buildRaisedButton(context)),

      ],
    );
  }
  Widget _buildRaisedButton(BuildContext context) => ElevatedButton(
    style: TextButton.styleFrom(
      backgroundColor: Colors.blue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    onPressed: () {
      showDialog(context: context, builder: (ctx) => _buildSimpleDialog(ctx));
    },
    child: const Text(
          'Just Show It',
          style: TextStyle(color: Colors.white),
        ),
  );

  SimpleDialog _buildSimpleDialog(BuildContext context) {
    return SimpleDialog(
      title: _buildTitle(),
      titlePadding: const EdgeInsets.only(
        top: 5,
        left: 20,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      children: _buildChild(context),
      backgroundColor: Colors.white,
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  List<Column> _buildChild(BuildContext context) {
    return info
        .map((str) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () => print(str),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      str,
                      style: const TextStyle(
                          color: Color(0xff999999), fontSize: 16),
                    ),
                  ),
                ),
                Divider(
                  indent: 20,
                  height: 12,
                  color: info.indexOf(str) == info.length - 1
                      ? Colors.transparent
                      : Theme.of(context).dividerColor,
                )
              ],
            ))
        .toList();
  }

  Widget _buildTitle() {
    return Row(//标题
      children: <Widget>[
        Image.asset(
          "assets/images/icon_head.webp",
          width: 30,
          height: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        const Expanded(
            child: Text(
          "张风捷特烈",
          style: TextStyle(fontSize: 18),
        )),
        const CloseButton()
      ],
    );
  }
}
