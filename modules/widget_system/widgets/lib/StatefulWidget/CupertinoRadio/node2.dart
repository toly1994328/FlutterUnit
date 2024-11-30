import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoRadioDemo2 extends StatefulWidget {
  const CupertinoRadioDemo2({super.key});

  @override
  State<CupertinoRadioDemo2> createState() => _CupertinoRadioDemo2State();
}

class _CupertinoRadioDemo2State extends State<CupertinoRadioDemo2> {
  List<int> data = [0, 1, 2, 3, 4, 5];
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: data
          .map((int value) => CupertinoRadio<int>(
          mouseCursor: SystemMouseCursors.click,
          activeColor: Colors.purple,
          fillColor: Colors.cyanAccent,
          inactiveColor: Colors.cyanAccent.withOpacity(0.05),
          focusColor: Colors.yellow.withOpacity(0.2),
          value: value,
          groupValue: _value,
          onChanged: _onChange))
          .toList(),
    );
  }

  void _onChange(int? value) {
    setState(() => _value = value ?? 0);
  }
}
