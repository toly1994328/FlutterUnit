import 'package:flutter/material.dart';
// import 'package:iroute/app/res/fx_icon.dart';

Map<String, dynamic> get calcMenus => {
  'path': '/scroll',
  'icon': Icons.touch_app_outlined,
  'label': '滑动布局',
  'children': [
    {
      'path': '/list',
      'label': '列表布局',
      // 'icon': Icons.list_alt,
    },
    {
      'path': '/grid',
      'label': '网格布局',
      // 'icon': Icons.grid_on_sharp,
    },
  ]
};
