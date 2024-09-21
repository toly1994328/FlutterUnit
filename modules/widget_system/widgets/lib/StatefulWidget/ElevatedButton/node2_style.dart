import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class ElevatedButtonStyleDemo extends StatelessWidget {
  const ElevatedButtonStyleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 10,
        children: [
          ElevatedButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: Colors.orangeAccent),
            child: const Text('ElevatedButton样式'),
            onPressed: _onPressed,
            onLongPress: _onLongPress,
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.blue,width: 1),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                // elevation: 2,
                shadowColor: Colors.orangeAccent),
            child: const Text('ElevatedButton边线'),
            autofocus: false,
            onPressed: _onPressed,
            onLongPress: _onLongPress,
          ),
        ],
      ),
    );
  }

  void _onPressed() {}

  void _onLongPress() {}
}
