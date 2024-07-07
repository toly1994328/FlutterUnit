import 'package:flutter/material.dart';

Map<String, dynamic> get findingMenus => {
  'path': '/finding',
  'icon': Icons.pages_outlined,
  'label': '寻路算法',
  'children': [
    {
      'path': '/BFS',
      'label': '广度优先搜索',
    },
    {
      'path': '/DFS',
      'label': '深度优先搜索',
    },
    {
      'path': '/AStar',
      'label': 'A* 寻路算法',
    },
    {
      'path': '/BestFS',
      'label': '最佳优先算法',
    },
    {
      'path': '/dijkstra',
      'label': 'Dijkstra 算法',
    },
  ]
};