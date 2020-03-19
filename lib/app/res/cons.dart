import 'package:flutter/material.dart';

class Cons {
  static const TABS = <String>[
    "Stateless", "Statefule", "Single", "Multi",
  ]; //标题列表
  static const MENU_INFO = <String>[
    "关于", "帮助", "问题反馈"];//菜单栏
  static const ICONS_MAP = { //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };

  static const rainbow =<int>[0xffff0000,0xffFF7F00,0xffFFFF00,0xff00FF00,0xff00FFFF,0xff0000FF,0xff8B00FF];
  static const rainbowInfo =<String>["红色","橙色","黄色","绿色","青色","蓝色","紫色"];

}