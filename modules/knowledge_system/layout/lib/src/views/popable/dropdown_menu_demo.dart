import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 370 DropdownMenu 表单菜单
/// 下拉选择组件，支持文本输入过滤，可自定义菜单项。底层主要依赖 MenuAnchor 和 TextFiled 实现。
/// link: 55
//    {
//      "widgetId": 370,
//      "name": '下拉菜单的简单使用',
//      "priority": 1,
//      "subtitle":
//          "【dropdownMenuEntries】 : 菜单条目列表   【List<DropdownMenuEntry<T>>】\n"
//          "【initialSelection】 : 表单验证回调   【T?】\n"
//          "【onSelected】 : 表单保存回调   【ValueChanged<T?>?】\n"
//          "【menuHeight】 : 菜单高度   【double】\n"
//          "【width】 : 输入框宽度   【double】",
//    }
class DropdownMenuNode1 extends StatefulWidget {
  const DropdownMenuNode1({super.key});

  @override
  State<DropdownMenuNode1> createState() => _DropdownMenuNode1State();
}

class _DropdownMenuNode1State extends State<DropdownMenuNode1> {
  /// 可选学科。
  final List<String> _subjects = <String>[
    '语文',
    '数学',
    '英语',
    '物理',
    '化学',
    '生物',
    '地理',
  ];

  /// 当前选中的学科。
  late String _dropdownValue = _subjects.first;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DropdownMenu<String>(
            width: 240,
            requestFocusOnTap: true,
            enableFilter: true,
            menuHeight: 240,
            initialSelection: _subjects.first,
            label: const Text('选择或搜索学科'),
            onSelected: _onSelect,
            dropdownMenuEntries: _buildMenuList(_subjects),
          ),
          const SizedBox(height: 16),
          Text('你选择的学科是：$_dropdownValue'),
        ],
      ),
    );
  }

  /// 更新当前选择结果。
  void _onSelect(String? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _dropdownValue = value;
    });
  }

  List<DropdownMenuEntry<String>> _buildMenuList(List<String> data) {
    return data.map((String value) {
      return DropdownMenuEntry<String>(value: value, label: value);
    }).toList();
  }
}
