
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-12
/// contact me by email 1981462002@qq.com

class DefaultTextStyleDemo extends StatelessWidget {
  const DefaultTextStyleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
          fontSize: 18,
          color: Colors.blue,
          decoration: TextDecoration.underline),
      child: Wrap(
        spacing: 5,
        children: const[
          Text("Hello,",),
          FlutterLogo(),
          Text("Flutter",style: TextStyle(color: Colors.red),),
          Text("Unit."),
        ],
      ),
    );
  }
}
