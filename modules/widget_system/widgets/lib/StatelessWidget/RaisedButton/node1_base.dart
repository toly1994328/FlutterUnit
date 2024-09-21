import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({Key? key}) : super(key: key);

  final String info =
      'RaisedButton 按钮于 Flutter3.3 退出历史舞台。取代者为 ElevatedButton 按钮。';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.1),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(info),
    );
  }
}