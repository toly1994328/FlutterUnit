
import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class TristateCheckBok extends StatefulWidget {
  const TristateCheckBok({Key? key}) : super(key: key);

  @override
  _TristateCheckBokState createState() => _TristateCheckBokState();
}

class _TristateCheckBokState extends State<TristateCheckBok> {
  bool _checked = false;
  final colors = [Colors.red, Colors.yellow, Colors.blue, Colors.green];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors
          .map((e) =>
          Checkbox(
              value: _checked,
              tristate: true,
              checkColor: Colors.white,
              activeColor: e,
              onChanged: (bool? value) {
                print(value);
                setState(() => _checked = value??false);
              }))
          .toList(),
    );
  }
}

