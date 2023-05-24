import 'package:flutter/material.dart';

import '../theme/size_unit.dart';
import 'unit_color.dart';

///文本样式
class UnitTextStyle {

  // 标题加黑
  static const labelBold = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  // 闪屏页文字阴影样式
  static const splashShadows = TextStyle(
      color: Colors.grey,
      shadows: [
        Shadow(
            color: Colors.black,
            blurRadius: 1,
            offset: Offset(0.1, 0.1))
      ],
      fontSize: 12);

  static const shadowTextStyle = TextStyle(color: Colors.grey, shadows: [
    Shadow(color: Colors.white, offset: Offset(.5, .5), blurRadius: .5)
  ]);


  // 过时文字样式
  static const deprecatedChip = TextStyle(
    fontSize: 12,
    color: Colors.white,
    decoration:  TextDecoration.lineThrough,
    decorationThickness: 2,
  );

  static const commonChip = TextStyle(
    fontSize: 12,
    color: Colors.white,
  );

  static const TextStyle hintStyle = TextStyle(
      color: UnitColor.input_hit_text_color,
      fontSize: SizeUnit.input_hit_text_size);

  static const TextStyle primary = TextStyle(
      color: UnitColor.text_color, fontSize: SizeUnit.input_text_size);

  static const TextStyle headTextStyle = TextStyle(
      color: UnitColor.head_text_color, fontSize: SizeUnit.head_text_size);

  static const TextStyle smallSubTextStyle = TextStyle(
      color: UnitColor.input_hit_text_color,
      fontSize: SizeUnit.small_text_size);

  static const TextStyle bigTextStyle = TextStyle(
      color: UnitColor.text_color, fontSize: SizeUnit.big_text_size);
}
