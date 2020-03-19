import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      splashColor: Colors.green,
      onPressed: () {},
      child: Text("RaisedButton"),
      textColor: Color(0xffFfffff),
      padding: EdgeInsets.all(8),
      elevation: 5,
      highlightColor: Color(0xffF88B0A),
    );
  }
}
