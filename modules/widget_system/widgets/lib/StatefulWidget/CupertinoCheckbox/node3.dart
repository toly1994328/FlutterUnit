import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoCheckboxDemo3 extends StatefulWidget {
  const CupertinoCheckboxDemo3({super.key});

  @override
  State<CupertinoCheckboxDemo3> createState() => _CupertinoCheckboxDemo3State();
}

class _CupertinoCheckboxDemo3State extends State<CupertinoCheckboxDemo3> {
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
          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          side: const BorderSide(color: Colors.black12),
          value: _active,
          onChanged: (bool? value) {
            setState(() {
              _active = value;
            });
          },
        ),
        CupertinoCheckbox(
          shape: const StadiumBorder(),
          side: const BorderSide(color: Colors.black12),
          value: _active,
          onChanged: (bool? value) {
            setState(() {
              _active = value;
            });
          },
        ),
      ],
    );
  }
}
