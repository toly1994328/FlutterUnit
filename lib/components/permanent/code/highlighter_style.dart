/// create by 张风捷特烈 on 2020-04-15
/// contact me by email 1981462002@qq.com
/// 说明: 

import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明:

class HighlighterStyle {
  //句法高亮样式
  const HighlighterStyle(
      { //构造函数
        this.baseStyle, //基础样式
        this.numberStyle, //数字的样式
        this.commentStyle, //注释样式
        this.keywordStyle, //关键字样式
        this.stringStyle, //字符串样式
        this.punctuationStyle, //标点符号样式
        this.classStyle, //类名
        this.backgroundColor,
        this.constantStyle});

  static List<int> get lightColor => [
    0xFF000000, //基础
    0xFF00b0e8, //数字
    0xFF9E9E9E, //注释
    0xFF9C27B0, //关键
    0xFF43A047, //字符串
    0xFF000000, //标点符号
    0xFF3D62F5, //类名
    0xFF795548, //常量
    0xffF6F8FA, //背景
  ];

  static List<int> get darkColor => [
    0xFFFFFFFF, //基础
    0xFFDF935F, //数字
    0xFF9E9E9E, //注释
    0xFF80CBC4, //关键字
    0xFFB9CA4A, //字符串
    0xFFFFFFFF, //标点符号
    0xFF7AA6DA, //类名
    0xFF795548, //常量
    0xFF1D1F21, //背景
  ];

  static List<int> get gitHub =>
      [
        0xFF333333, //基础
        0xFF008081, //数字
        0xFF9D9D8D, //注释
        0xFF009999, //关键字
        0xFFDD1045, //字符串
        0xFF333333, //标点符号
        0xFF6F42C1, //类名
        0xFF795548, //常量
        0xFFF8F8F8, //背景
      ];

  static List<int> get zenburn => [
    0xFFDCDCDC, //普通字
    0xFF87C5C8, //数字
    0xFF8F8F8F, //注释
    0xFFE4CEAB, //关键字
    0xFFCC9493, //字符串
    0xFFDCDCDC, //标点符号
    0xFFEFEF90, //类名
    0xFFEF5350, //常量
    0xFF3F3F3F, //背景
  ];

  static List<int> get mf =>[
    0xFF707D95, //基础
    0xFF6897BB, //数字
    0xFF629755, //注释
    0xFFCC7832, //关键
    0xFFF14E9F, //字符串
    0xFFFFBB33, //标点符号
    0xFF66CCFF, //类名
    0xFF9876AA, //常量
    0xFF2B2B2B  //背景
  ];

  static List<int> get solarized =>[
    0xFF657B83,  // 普通字
    0xFFD33682,  // 数字
    0xFF93A1A1,  // 注释
    0xFF859900,  // 关键字
    0xFF2AA198,  // 字符串
    0xFF859900,  // 标点符号
    0xFF268BD2,  // 类名
    0xFF268BD2,  //常量
    0xFFDDD6C1,  // 背景
  ];

  factory HighlighterStyle.fromColors(List<int> colors) => HighlighterStyle(
    baseStyle: TextStyle(
      color: Color(colors[0]),
    ),
    numberStyle: TextStyle(
      color: Color(colors[1]),
    ),
    commentStyle: TextStyle(
        color: Color(
          colors[2],
        ),
        fontStyle: FontStyle.italic),
    keywordStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(
        colors[3],
      ),
    ),
    stringStyle: TextStyle(
      color: Color(colors[4]),
    ),
    punctuationStyle: TextStyle(
      color: Color(colors[5]),
    ),
    classStyle: TextStyle(
      color: Color(colors[6]),
    ),
    constantStyle: TextStyle(
      color: Color(colors[7]),
    ),
    backgroundColor: Color(colors[8]),
  );
  final TextStyle? baseStyle;
  final TextStyle? numberStyle;
  final TextStyle? commentStyle;
  final TextStyle? keywordStyle;
  final TextStyle? stringStyle;
  final TextStyle? punctuationStyle;
  final TextStyle? classStyle;
  final TextStyle? constantStyle;
  final Color? backgroundColor;
}