import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: ()=>{},
      padding: EdgeInsets.all(8),
      splashColor: Colors.green,
      child: Text("FlatButton"),
      textColor: Color(0xffFfffff),
      color: Colors.blue,
      highlightColor: Color(0xffF88B0A),
    );
  }
}
