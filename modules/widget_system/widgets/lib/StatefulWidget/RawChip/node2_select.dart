import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com

class SelectRawChip extends StatefulWidget {
  const SelectRawChip({Key? key}) : super(key: key);

  @override
  _SelectRawChipState createState() => _SelectRawChipState();
}

class _SelectRawChipState extends State<SelectRawChip> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return RawChip(
      selected: _selected,
      padding: const EdgeInsets.all(5),
      labelPadding: const EdgeInsets.all(3),
      deleteIconColor: Colors.red,
      selectedColor: Colors.orangeAccent.withAlpha(44),
      label: const Text('张风捷特烈'),
      avatar: Image.asset("assets/images/icon_head.webp"),
      elevation: 3,
      pressElevation: 5,
      shadowColor: Colors.orangeAccent,
      onSelected: (v)=> setState(() => _selected=v),
      onDeleted: () =>  Navigator.of(context).pushNamed('AboutMePage'),
    );
  }
}