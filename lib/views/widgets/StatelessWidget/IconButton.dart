import 'package:flutter/material.dart';


class CustomIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        padding: EdgeInsets.only(),
        onPressed: () {},
        icon: Icon(Icons.android, size: 40, color: Colors.green),
        tooltip: "android",
        highlightColor: Colors.orangeAccent,
        splashColor: Colors.blue,
      ),
    );
  }
}
