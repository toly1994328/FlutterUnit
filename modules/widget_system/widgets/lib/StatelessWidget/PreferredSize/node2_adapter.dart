import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/5/3
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 204,
//      "name": 'PreferredSize的转化使用',
//      "priority": 2,
//      "subtitle": "【PreferredSize将普通组件转化为PreferredSizeWidget",
//    }
class AdapterPreferredSize extends StatelessWidget {
  const AdapterPreferredSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: AppBar(
            title: const Text('PreferredSize'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Container(
                height: 40,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
