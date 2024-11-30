import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoRadioDemo1 extends StatefulWidget {
  const CupertinoRadioDemo1({super.key});

  @override
  State<CupertinoRadioDemo1> createState() => _CupertinoRadioDemo1State();
}

class _CupertinoRadioDemo1State extends State<CupertinoRadioDemo1> {
  List<int> data = [0, 1, 2, 3, 4, 5];
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: data
          .map((int value) => CupertinoRadio<int>(
                value: value,
                groupValue: _value,
                onChanged: _onChange,
              ))
          .toList(),
    );
  }

  void _onChange(int? value) {
    setState(() => _value = value ?? 0);
  }
}
