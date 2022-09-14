

/// create by 张风捷特烈 on 2020-03-24
/// contact me by email 1981462002@qq.com
/// 说明:
///
//    {
//      "widgetId": 127,
//      "name": 'AlertDialog基本使用',
//      "priority": 1,
//      "subtitle":
//          "【title】 : 顶部组件   【Widget】\n"
//          "【content】 : 内容组件  【Widget】\n"
//          "【titleTextStyle】 : 顶部文字样式  【TextStyle】\n"
//          "【contentTextStyle】 : 内容文字样式  【TextStyle】\n"
//          "【titlePadding】 : 顶部内边距  【EdgeInsetsGeometry】\n"
//          "【contentPadding】 : 内容内边距  【EdgeInsetsGeometry】\n"
//          "【actions】 : 右下角组件列表  【List<Widget>】\n"
//          "【backgroundColor】 : 背景色  【Color】\n"
//          "【elevation】 : 影深  【double】\n"
//          "【shape】 : 形状   【ShapeBorder】",
//    }

import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRaisedButton(context),
        _buildAlertDialog(),
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
      showDialog(context: context, builder: (ctx) => _buildAlertDialog());
    },
    child: const Text(
      'Just Show It !',
      style: TextStyle(color: Colors.white),
    ),
  );

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: _buildTitle(),
      titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
      titlePadding: const EdgeInsets.only(
        top: 5,
        left: 20,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      backgroundColor: Colors.white,
      content: _buildContent(),
      actions: const [
        Icon(Icons.android, color: Colors.blue,),
        Icon(Icons.add, color: Colors.blue,),
        Icon(Icons.g_translate, color: Colors.blue,),
        Icon(Icons.games, color: Colors.blue,),
      ],
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }

  Widget _buildTitle() {
    return Row(
      //标题
      children: <Widget>[
        Image.asset(
          "assets/images/icon_head.webp",
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 10,),
        const Expanded(
            child:  Text(
              "关于",
              style: TextStyle(fontSize: 18),
            )),
        const CloseButton()
      ],
    );
  }

  Widget _buildContent() {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
         Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '      FlutterUnit是【张风捷特烈】的开源项目，'
                '收录Flutter的200+组件，并附加详细介绍以及操作交互，'
                '希望帮助广大编程爱好者入门Flutter。'
                '更多知识可以关注掘金账号、公众号【编程之王】。',
            style: TextStyle(color: Color(0xff999999), fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}