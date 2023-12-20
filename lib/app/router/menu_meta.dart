

import 'package:flutter/material.dart';

class MenuMeta {
  // 标签
  final String label;

  final String? path;

  // 图标数据
  final IconData icon;

  // 图标颜色
  final Color? color;

  const MenuMeta({
    required this.label,
    this.path,
    required this.icon,
    this.color,
  });
}
