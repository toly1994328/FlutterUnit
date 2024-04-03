import 'package:flutter/material.dart';
// import 'package:iroute/app/res/fx_icon.dart';

Map<String, dynamic> get drawMenus => {
  'path': '/flex',
  // 'icon': FxIcon.icon_paint,
  'icon':Icons.local_florist,
  'label': '行列布局',
  'children': [
    {
      'path': '/row',
      'label': '行布局',
      // 'icon': Icons.text_fields,
    },
    {
      'path': '/column',
      'label': '列布局',
      // 'icon': Icons.text_fields,
    },
    {
      'path': '/expanded',
      'label': '延展布局',
      // 'icon': Icons.text_fields,
    },
    {
      'path': '/holy',
      'label': '圣杯布局',
      // 'icon': Icons.text_fields,
    },
  ]
};
