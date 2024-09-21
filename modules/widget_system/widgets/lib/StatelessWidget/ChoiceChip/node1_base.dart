
/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com


import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  const CustomChoiceChip({Key? key}) : super(key: key);

  @override
  _CustomChoiceChipState createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  bool _select = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: _select,
      padding: const EdgeInsets.all(5),
      labelPadding: const EdgeInsets.all(5),
      label: Text(
        _select ?
        "You are selected it." :
        "This is a ChoiceChip.",
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: Image.asset("assets/images/icon_head.webp"),
      selectedColor: Colors.orangeAccent.withAlpha(44),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      onSelected: (value) => setState(() => _select = value),
    );
  }
}