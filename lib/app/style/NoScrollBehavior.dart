import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/6/16
/// contact me by email 1981462002@qq.com
/// 说明: 

class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) => child;
}