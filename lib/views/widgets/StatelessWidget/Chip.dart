import 'package:flutter/material.dart';
import 'package:flutter_unit/views/dialogs/dialog_about.dart';

class CustomChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        Chip(
          avatar: Image.asset("assets/images/icon_head.png"),
          label: Text("张风捷特烈"),
          padding: EdgeInsets.all(5),
          labelPadding: EdgeInsets.all(5),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundImage:
              AssetImage("assets/images/wy_200x300.jpg")),
          label: Text("百里巫缨"),
          padding: EdgeInsets.all(8),
          labelPadding: EdgeInsets.all(6),
        ),
      ],
    );
  }
}

class ColorOfChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        Chip(
          avatar: Image.asset("assets/images/icon_head.png"),
          label: Text("张风捷特烈"),
          padding: EdgeInsets.all(5),
          labelPadding: EdgeInsets.all(5),
          backgroundColor: Colors.grey.withAlpha(66),
          shadowColor: Colors.orangeAccent,
          elevation: 3,
        ),
        Chip(
          avatar: Image.asset("assets/images/icon_head.png"),
          label: Text("张风捷特烈"),
          padding: EdgeInsets.all(5),
          labelPadding: EdgeInsets.all(5),
          backgroundColor: Colors.cyanAccent.withAlpha(11),
          shadowColor: Colors.blue.withAlpha(88),
          elevation: 4,
        ),
      ],
    );
  }
}

class DeleteOfChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Image.asset("assets/images/icon_head.png"),
      label: Text("张风捷特烈"),
      padding: EdgeInsets.all(5),
      labelPadding: EdgeInsets.all(3),
      backgroundColor: Colors.grey.withAlpha(66),
      shadowColor: Colors.orangeAccent,
//      deleteIcon: Icon(Icons.close,size: 18),
      deleteIconColor: Colors.red,
      onDeleted: () => DialogAbout.show(context),
      elevation: 3,
    );
  }
}