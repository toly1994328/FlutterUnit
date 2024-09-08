import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/25
/// contact me by email 1981462002@qq.com
/// 说明: 

class NoMoreWidget extends StatelessWidget {
  const NoMoreWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).padding.bottom;

    return SizedBox(height: bottom);
  }

}
