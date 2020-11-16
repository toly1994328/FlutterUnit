import 'package:flutter/material.dart';

import 'color_unit.dart';
import 'size_unit.dart';

/// create by 张风捷特烈 on 2020/11/17
/// contact me by email 1981462002@qq.com
/// 说明:

class TextStyleUnit {
  static const TextStyle hintStyle = const TextStyle(
      color: ColorUnit.input_hit_text_color,
      fontSize: SizeUnit.input_hit_text_size);

  static const TextStyle primary = const TextStyle(
      color: ColorUnit.text_color, fontSize: SizeUnit.input_text_size);

  static const TextStyle headTextStyle = const TextStyle(
      color: ColorUnit.head_text_color, fontSize: SizeUnit.head_text_size);

  static const TextStyle smallSubTextStyle = const TextStyle(
      color: ColorUnit.input_hit_text_color,
      fontSize: SizeUnit.small_text_size);

  static const TextStyle bigTextStyle = const TextStyle(
      color: ColorUnit.text_color, fontSize: SizeUnit.big_text_size);
}
