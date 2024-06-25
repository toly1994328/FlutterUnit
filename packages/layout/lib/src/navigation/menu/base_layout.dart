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
        },
        {
          'path': '/align',
          'label': '布局对齐',
        },
        {
          'path': '/positioned',
          'label': '布局定位',
        },
      ]
    };
