import 'package:flutter/material.dart';

class HomeLeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 5, //影深
        child: Container(
          color: Colors.blue.withAlpha(55),
        ));
  }
}
