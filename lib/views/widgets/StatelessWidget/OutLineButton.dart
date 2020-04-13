import 'package:flutter/material.dart';


class CustomOutlineButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(//边线按钮
      onPressed: () {},
      child: Text("OutlineButton"),
      padding: EdgeInsets.all(8),
      splashColor: Colors.green,
      highlightColor: Colors.orangeAccent,
      highlightedBorderColor: Colors.grey,
      textColor: Color(0xff000000),
      borderSide: BorderSide(color: Color(0xff0A66F8), width: 2),
    );
  }
}
