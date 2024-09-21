import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com

class DropdownMenuNode1 extends StatefulWidget {
  const DropdownMenuNode1({super.key});

  @override
  State<DropdownMenuNode1> createState() => _DropdownMenuNode1State();
}

class _DropdownMenuNode1State extends State<DropdownMenuNode1> {
  final List<String> data = ['语文', '数学', '英语', '物理', '化学', '生物', '地理'];
  late String _dropdownValue = data.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownMenu<String>(
          menuHeight: 200,
          initialSelection: data.first,
          onSelected: _onSelect,
          dropdownMenuEntries: _buildMenuList(data),
        ),
        const SizedBox(height: 8,),
        Text('你选择的学科是: $_dropdownValue')
      ],
    );
  }

  void _onSelect(String? value) {
    setState(() {
      _dropdownValue = value!;
    });
  }

  List<DropdownMenuEntry<String>> _buildMenuList(List<String> data) {
    return data.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }
}
