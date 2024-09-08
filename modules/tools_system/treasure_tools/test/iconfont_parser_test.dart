
import 'dart:convert';
import 'dart:io';

import 'package:treasure_tools/src/icon_font_gen/icon_font_class_parser.dart';


void main(){
  final String filePath = r'E:\Download\out\font_1717416_cwm89ioqkfo\iconfont.json';
  File jsonFile = File(filePath);
  final String jsonContent = jsonFile.readAsStringSync();
  IconFontClassParser parser =   IconFontClassParser();
  String result = parser.parser(jsonContent,'TolyIcon');
  print(result);

}