import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoCheckboxDemo2 extends StatefulWidget {
  const CupertinoCheckboxDemo2({super.key});

  @override
  State<CupertinoCheckboxDemo2> createState() => _CupertinoCheckboxDemo2State();
}

class _CupertinoCheckboxDemo2State extends State<CupertinoCheckboxDemo2> {
  bool? _active = false;

  @override
  Widget build(BuildContext context) {
    return
    CupertinoCheckbox(
      value: _active,
      tristate: true,
      onChanged: (bool? value) {
        setState(() {
          _active = value;
        });
      },
    );
  }
}
