import 'package:flutter/material.dart';

class CustomGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            child: Image.asset(
              "assets/images/wy_300x200.jpg",
              fit: BoxFit.cover,
            )));
  }
}

class DivisionsGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        child: GridPaper(
            color: Colors.red,
            interval: 50,
            divisions: 4,
            subdivisions: 4,
            child: Image.asset(
              "assets/images/wy_300x200.jpg",
              fit: BoxFit.cover,
            )));
  }
}
