import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com

class CustomSnackBarAction extends StatelessWidget {
  const CustomSnackBarAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBarAction(
      disabledTextColor: Colors.red,
      textColor: Colors.blue,
      label: '确定',
      onPressed: () => print('onPressed'),
    );
  }
}
