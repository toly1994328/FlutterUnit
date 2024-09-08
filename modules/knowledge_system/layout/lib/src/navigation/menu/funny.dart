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
Map<String, dynamic> get funnyMenus => {
      'path': '/funny',
      'icon': Icons.multitrack_audio,
      'label': '趣味布局',
      'children': [
        {
          'path': '/elevator',
          'label': '电梯布局',
        },

      ]
    };
