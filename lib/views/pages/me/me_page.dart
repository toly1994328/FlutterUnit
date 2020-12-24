
import 'package:flutter/material.dart';

import 'home_drawer.dart';

/// create by 张风捷特烈 on 2020/4/26
/// contact me by email 1981462002@qq.com
/// 说明: 

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text('我的账号'),),
      body: HomeDrawer(),
    );
  }
}
