import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoCheckboxDemo1 extends StatefulWidget {
  const CupertinoCheckboxDemo1({super.key});

  @override
  State<CupertinoCheckboxDemo1> createState() => _CupertinoCheckboxDemo1State();
}

class _CupertinoCheckboxDemo1State extends State<CupertinoCheckboxDemo1> {
  bool? _active = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        CupertinoCheckbox(
          value: _active,
          onChanged: (bool? value) {
            setState(() {
              _active = value;
            });
          },
        ),

        CupertinoCheckbox(
          value: _active,
          checkColor: Colors.yellow,
          activeColor: Colors.purple,
          onChanged: (bool? value) {
            setState(() {
              _active = value;
            });
          },
        ),
        CupertinoCheckbox(
          value: true,
          inactiveColor: Colors.black.withOpacity(0.2),
          onChanged: null,
        ),
      ],
    );
  }
}
