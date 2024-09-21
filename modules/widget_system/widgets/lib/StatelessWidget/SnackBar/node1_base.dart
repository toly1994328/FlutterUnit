import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com

class CustomSnackBar extends StatefulWidget {
  const CustomSnackBar({Key? key}) : super(key: key);

  @override
  _CustomSnackBarState createState() => _CustomSnackBarState();
}

class _CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () =>
            ScaffoldMessenger.of(context).showSnackBar(_buildSnackBar()),
        child: const Text(
          '点我弹出SnackBar',
          style: TextStyle(color: Colors.white),
        ));
  }

  SnackBar _buildSnackBar() {
    return SnackBar(
      elevation: 3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      content: const Text('Wellcome to for join Flutter Unit!'),
      duration: const Duration(seconds: 3),
      //持续时间
      backgroundColor: Colors.red,
      onVisible: () => print('onVisible'),
      action: SnackBarAction(
          textColor: Colors.white, label: '确定', onPressed: () {}),
    );
  }
}
