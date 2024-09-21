import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-16
/// contact me by email 1981462002@qq.com

class CustomExpandIcon extends StatefulWidget {
  const CustomExpandIcon({Key? key}) : super(key: key);

  @override
  _CustomExpandIconState createState() => _CustomExpandIconState();
}

class _CustomExpandIconState extends State<CustomExpandIcon> {
  bool _closed = true;

  @override
  Widget build(BuildContext context) {
    return ExpandIcon(
      isExpanded: _closed,
      padding: const EdgeInsets.all(5),
      size: 30,
      color: Colors.blue,
      expandedColor: Colors.orangeAccent,
      onPressed: (value) => setState(() => _closed = !_closed),
    );
  }
}
