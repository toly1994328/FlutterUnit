import 'package:flutter/material.dart';

import 'color_unit.dart';
import 'size_unit.dart';

/// create by 张风捷特烈 on 2020/11/17
/// contact me by email 1981462002@qq.com
/// 说明:

class TextStyleUnit {
  static const TextStyle hintStyle = TextStyle(
      color: ColorUnit.input_hit_text_color,
      fontSize: SizeUnit.input_hit_text_size);

  static const TextStyle primary = TextStyle(
      color: ColorUnit.text_color, fontSize: SizeUnit.input_text_size);

  static const TextStyle headTextStyle = TextStyle(
      color: ColorUnit.head_text_color, fontSize: SizeUnit.head_text_size);

  static const TextStyle smallSubTextStyle = TextStyle(
      color: ColorUnit.input_hit_text_color,
      fontSize: SizeUnit.small_text_size);

  static const TextStyle bigTextStyle = TextStyle(
      color: ColorUnit.text_color, fontSize: SizeUnit.big_text_size);
}
