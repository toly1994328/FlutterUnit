import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com

class ModalBarrierDemo extends StatelessWidget {
  const ModalBarrierDemo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Stack(alignment: Alignment.center, children: [
        ModalBarrier(
          dismissible: true,
          color: Colors.grey.withOpacity(0.3),
        ),
        const Text('点击背景返回')
      ]),
    );
  }
}
