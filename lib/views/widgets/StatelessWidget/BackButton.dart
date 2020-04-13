import 'package:flutter/material.dart';


class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [Colors.red,Colors.yellow,Colors.blue,Colors.green];
    return Wrap(
      spacing: 10,
      children: data.map((e)=>BackButton(
        color: e,
      )).toList()
    );
  }
}
