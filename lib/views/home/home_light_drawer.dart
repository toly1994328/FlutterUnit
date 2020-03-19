import 'package:flutter/material.dart';

class HomeRightDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 5, //影深
        child: Container(
          color: Colors.cyanAccent.withAlpha(55),
        ));
  }
}
