import 'package:flutter/material.dart';

class CustomVisibility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: <Widget>[
        _buildVisibility(true),
        _buildVisibility(false),
      ],
    );
  }

  _buildVisibility(bool visible) {
    var box = Container(
      height: 30,
      width: 30,
      color: Colors.blue,
    );
    return Container(
      width: 150,
      height: 150 * 0.618,
      color: Colors.cyanAccent.withAlpha(33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          box,
          Visibility(
              visible: visible,
              child: Container(
                alignment: Alignment.center,
                height: 80 * 0.618,
                width: 80,
                color: Colors.red,
                child: Text(
                  "visible\ntrue",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          box,
        ],
      ),
    );
  }
}

class ReplacementVisibility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: <Widget>[
        _buildVisibility(true),
        _buildVisibility(false),
      ],
    );
  }

  _buildVisibility(bool visible) {
    var box = Container(
      height: 30,
      width: 30,
      color: Colors.blue,
    );
    return Container(
      width: 150,
      height: 150 * 0.618,
      color: Colors.cyanAccent.withAlpha(33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          box,
          Visibility(
              visible: visible,
              replacement: Container(
                alignment: Alignment.center,
                height: 80 * 0.618,
                width: 80,
              ),
              child: Container(
                alignment: Alignment.center,
                height: 80 * 0.618,
                width: 80,
                color: Colors.red,
                child: Text(
                  "visible\ntrue",
                  style: TextStyle(fontSize: 20),
                ),
              )),
          box,
        ],
      ),
    );
  }
}

//class VisibilityPage extends StatefulWidget {
//  @override
//  _VisibilityPageState createState() => _VisibilityPageState();
//}
//
//class _VisibilityPageState extends State<VisibilityPage> {
//  @override
//  Widget build(BuildContext context) {
//    var visibility = Visibility(
//        visible: false,
//        replacement: Container(
//          alignment: Alignment.center,
//          height: 100,
//          width: 100,
//        ),
//        child: Container(
//          alignment: Alignment.center,
//          height: 100,
//          width: 100,
//          color: Colors.blue,
//          child: Text(
//            "Visibility",
//            style: TextStyle(fontSize: 20),
//          ),
//        ));
//
//    var radBox = Container(
//      height: 50,
//      width: 50,
//      color: Colors.red,
//    );
//
//    return Container(
//      width: 200,
//      height: 200,
//      child: Row(
//        children: <Widget>[radBox, visibility, radBox],
//      ),
//    );
//  }
//}
