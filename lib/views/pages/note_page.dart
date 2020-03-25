import 'package:flutter/material.dart';

import '../empty_page.dart';

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        EmptyPage(),
        Text("手册"),
      ],
    ));
  }
}
