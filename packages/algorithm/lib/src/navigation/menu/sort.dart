import 'package:flutter/material.dart';

Map<String, dynamic> get sortMenus => {
  'path': '/sort',
  'icon': Icons.sort,
  'label': '排序算法',
  'children': [
    {
      'path': '/insertion',
      'label': '插入排序',
    },
    {
      'path': '/bubble',
      'label': '冒泡排序',
    },
    {
      'path': '/cocktail',
      'label': '鸡尾酒排序',
    },
    {
      'path': '/comb',
      'label': '梳排序',
    },
    {
      'path': '/pigeonHole',
      'label': '鸽巢排序',
    },
    {
      'path': '/shell',
      'label': '希尔排序',
    },
    {
      'path': '/selection',
      'label': '选择排序',
    },
    {
      'path': '/gnome',
      'label': '侏儒排序',
    },
    {
      'path': '/cycle',
      'label': '循环排序',
    },
    {
      'path': '/heap',
      'label': '堆排序',
    },
    {
      'path': '/quick',
      'label': '快速排序',
    },
    {
      'path': '/merge',
      'label': '归并排序',
    },
  ]
};