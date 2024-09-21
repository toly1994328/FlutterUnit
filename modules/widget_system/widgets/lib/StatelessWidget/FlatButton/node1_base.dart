import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({Key? key}) : super(key: key);

  final String info =
      'FlatButton 按钮于 Flutter3.3 退出历史舞台。取代者为 ElevatedButton 按钮。';

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
