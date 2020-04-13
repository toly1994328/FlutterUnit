import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/panel.dart';
import 'package:flutter_unit/views/dialogs/dialog_about.dart';


class PressInputChip extends StatefulWidget {
  @override
  _PressInputChipState createState() => _PressInputChipState();
}

class _PressInputChipState extends State<PressInputChip> {
  bool _delete = false;

  @override
  Widget build(BuildContext context) {
    return InputChip(
        padding: EdgeInsets.all(5),
        labelPadding: EdgeInsets.all(3),
        label: Text(
            !_delete ?
            "This is a InputChip." :
            "You are clicked delete icon."),
        backgroundColor: Colors.grey.withAlpha(66),
        avatar: Image.asset("assets/images/icon_head.png"),
        selectedColor: Colors.orangeAccent.withAlpha(88),
        selectedShadowColor: Colors.blue,
        shadowColor: Colors.orangeAccent,
        elevation: 3,
        onPressed: () => DialogAbout.show(context),
        onDeleted: () => setState(() => _delete = !_delete));
  }
}

class SelectInputChip extends StatefulWidget {
  @override
  _SelectInputChipState createState() => _SelectInputChipState();
}

class _SelectInputChipState extends State<SelectInputChip> {
  bool _select = false;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      selected: _select,
      padding: EdgeInsets.all(5),
      labelPadding: EdgeInsets.all(3),
      label: Text("This is a InputChip."),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: Image.asset("assets/images/icon_head.png"),
      selectedColor: Colors.orangeAccent.withAlpha(88),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      onDeleted: () => DialogAbout.show(context),
      onSelected: (bool value) {
        setState(() {
          _select = value;
        });
        print("onSelected");
      },
    );
  }
}
