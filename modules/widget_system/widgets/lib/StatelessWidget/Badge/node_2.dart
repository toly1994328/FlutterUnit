import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2023/01/27
/// contact me by email 1981462002@qq.com


class BadgeLabelDemo extends StatelessWidget {
  const BadgeLabelDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Badge(
      backgroundColor: Colors.red,
      label: Text('99'),
      textStyle: TextStyle(fontSize: 8,color: Colors.red),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
      largeSize: 14,
      child: Icon(Icons.message,size: 36,color: Colors.indigo,),
    );
  }
}

