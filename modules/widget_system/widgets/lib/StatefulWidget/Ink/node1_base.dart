import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com

class CustomInk extends StatelessWidget {
  const CustomInk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orangeAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Ink(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: 200.0,
            height: 100.0,
            child: InkWell(
              onTap: () {},
              child: const Center(child: Text('Hello')),
            ),
          ),
        ),
      ),
    );
  }
}

