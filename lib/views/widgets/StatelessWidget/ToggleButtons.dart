import 'package:flutter/material.dart';
import 'package:flutter_unit/components/panel/panel.dart';

class CustomToggleButtons extends StatefulWidget {
  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  var _isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderRadius: BorderRadius.circular(10),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected = _isSelected.map((e) => false).toList();
        _isSelected[value] = true;
      }),
    );

  }
}

class ColorToggleButtons extends StatefulWidget {
  @override
  _ColorToggleButtonsState createState() => _ColorToggleButtonsState();
}

class _ColorToggleButtonsState extends State<ColorToggleButtons> {
  var _isSelected = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderColor: Colors.orangeAccent,
      selectedBorderColor: Colors.blue,
      splashColor: Colors.purple.withAlpha(66),
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.red,
      fillColor: Colors.green.withAlpha(11),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected = _isSelected.map((e) => false).toList();
        _isSelected[value] = true;
      }),
    );
  }
}

class ProToggleButtons extends StatefulWidget {
  @override
  _ProToggleButtonsState createState() => _ProToggleButtonsState();
}

class _ProToggleButtonsState extends State<ProToggleButtons> {
  var _isSelected = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: <Widget>[
        Icon(Icons.skip_previous),
        Icon(Icons.pause),
        Icon(Icons.skip_next),
      ],
      borderWidth: 1,
      borderColor: Colors.blue,
      selectedBorderColor: Colors.orangeAccent,
      splashColor: Colors.purple.withAlpha(66),
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.red,
      fillColor: Colors.green.withAlpha(11),
      isSelected: _isSelected,
      onPressed: (value) => setState(() {
        _isSelected[value] = !_isSelected[value];
      }),
    );
  }
}


