import 'package:flutter/material.dart';
// import 'package:iroute/app/res/fx_icon.dart';

Map<String, dynamic> get baseMenus => {
  'path': '/base',
  'icon': Icons.layers_rounded,
  'label': '基本布局',
  'children': [
    {
      'path': '/size',
      'label': '布局尺寸',
    },
    {
      'path': '/padding',
      'label': '布局边距',
      // 'icon': Icons.calculate_outlined,
    },
    {
      'path': '/align',
      'label': '布局对齐',
      // 'icon': Icons.calculate_outlined,
    },
    {
      'path': '/positioned',
      'label': '布局定位',
      // 'icon': Icons.calculate_outlined,
    },
    // {
    //   'path': '/parser',
    //   'label': '文字解析器',
    //   'icon': Icons.text_fields,
    // },
  ]
};
