import 'package:flutter/cupertino.dart';

class CupertinoRadioDemo3 extends StatefulWidget {
  const CupertinoRadioDemo3({super.key});

  @override
  State<CupertinoRadioDemo3> createState() => _CupertinoRadioDemo3State();
}

class _CupertinoRadioDemo3State extends State<CupertinoRadioDemo3> {
  List<int> data = [0, 1, 2, 3, 4, 5];
  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: data
          .map((int value) => CupertinoRadio<int>(
          mouseCursor: SystemMouseCursors.click,
          toggleable: true,
          value: value,
          groupValue: _value,
          onChanged: _onChange))
          .toList(),
    );
  }

  void _onChange(int? value) {
    setState(() => _value = value);
  }
}
