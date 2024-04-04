import 'package:flutter/material.dart';
// import 'package:iroute/app/res/fx_icon.dart';
//     {
//       'path': '/expanded',
//       'label': '延展布局',
//       // 'icon': Icons.text_fields,
//     },
// {
// 'path': '/holy',
// 'label': '圣杯布局',
// // 'icon': Icons.text_fields,
// },
Map<String, dynamic> get drawMenus => {
  'path': '/multi',
  // 'icon': FxIcon.icon_paint,
  'icon':Icons.multitrack_audio,
  'label': '多子布局',
  'children': [
    {
      'path': '/row_column',
      'label': '行列布局',
      // 'icon': Icons.text_fields,
    },
    {
      'path': '/wrap',
      'label': '包裹布局',
      // 'icon': Icons.text_fields,
    },
    {
      'path': '/stack',
      'label': '堆叠布局',
      // 'icon': Icons.text_fields,
    },

  ]
};
