import 'package:flutter/material.dart';
import 'package:flutter_unit/components/panel/panel.dart';
import 'package:flutter_unit/views/dialogs/dialog_about.dart';


class CustomActionChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: EdgeInsets.all(5),
      labelPadding: EdgeInsets.all(3),
      label: Text("This is a ActionChip."),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: Image.asset("assets/images/icon_head.png"),
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      pressElevation: 5,
      onPressed: ()=> DialogAbout.show(context),
    );
  }
}

