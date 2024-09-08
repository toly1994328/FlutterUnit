import 'package:flutter/material.dart';
// import 'package:iroute/app/res/fx_icon.dart';

Map<String, dynamic> get popableMenus => {
  'path': '/popable',
  'icon': Icons.layers_rounded,
  'label': '菜单浮层',
  'children': [
    {
      'path': '/DropdownButton',
      'label': '下拉按钮',
    },
    {
      'path': '/DropdownMenu',
      'label': '下拉菜单',
      // 'icon': Icons.calculate_outlined,
    },
    {
      'path': '/Autocomplete',
      'label': '自动填充',
      // 'icon': Icons.calculate_outlined,
    },
  ]
};
