import 'dart:math';

import 'package:flutter/material.dart';

import 'random_provider.dart';

//Color randomColor(){/// 用来返回一个随机色
//var random=Random();
//var a = random.nextInt(256);//透明度值
//var r = random.nextInt(256);//红值
//var g = random.nextInt(256);//绿值
//var b = random.nextInt(256);//蓝值
//return Color.fromARGB(a, r, g, b);//生成argb模式的颜色
//}

//Color randomColor(int limitA){
//  var random=Random();
//  var a = limitA+random.nextInt(256-limitA);//透明度值
//  var r = random.nextInt(256);//红值
//  var g = random.nextInt(256);//绿值
//  var b = random.nextInt(256);//蓝值
//  return Color.fromARGB(a, r, g, b);//生成argb模式的颜色
//}

class ColorUtils {
  static Color randomColor({
    int limitA = 120,
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
    var random = RandomProvider.random;
    var a = limitA + random.nextInt(256 - limitA); //透明度值
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(a, r, g, b); //生成argb模式的颜色
  }


  /// 使用方法:
  /// var color1=ColorUtils.parse("#33428A43");
  /// var color2=ColorUtils.parse("33428A43");
  /// var color3=ColorUtils.parse("#428A43");
  ///var color4=ColorUtils.parse("428A43");
  ///
  static Color parse(String code) {
    Color result =Colors.red;
    var value = 0 ;
    if (code.contains("#")) {
      try {
        value = int.parse(code.substring(1), radix: 16);
      } catch (e) {
        print(e);
      }
      switch (code.length) {
        case 1 + 6://6位
          result = Color(value + 0xFF000000);
          break;
        case 1 + 8://8位
          result = Color(value);
          break;
        default:
          result =Colors.red;
      }
    }else {
      try {
        value = int.parse(code, radix: 16);
      } catch (e) {
        print(e);
      }
      switch (code.length) {
        case  6:
          result = Color(value + 0xFF000000);
          break;
        case  8:
          result = Color(value);
          break;
        default:
          result =Colors.red;
      }
    }
    return result;
  }

  static String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}

