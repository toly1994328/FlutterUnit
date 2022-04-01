import 'dart:io';

import 'package:path/path.dart' as path;

main() async{
  String fontName ='TolyIcon';
  String fileName ='toly_icon';
  String resDir="assets/iconfont";//资源文件夹
  String outFile='lib/app/res/$fileName.dart';//输出文件地址

  String result = """import 'package:flutter/widgets.dart';
//Power By 张风捷特烈--- Generated file. Do not edit.

class $fontName {

    $fontName._();
""";
  File fileCss = File(path.join(Directory.current.path,"$resDir/iconfont.css"));
  if (! await fileCss.exists()) return;

  String read = await fileCss.readAsString();
  List<String> split = read.split(".icon-");
  for (String str in split) {
    if (str.contains("before")) {
      List<String> split = str.split(":");
      result += "static const IconData " +
          split[0].replaceAll("-", "_") +
          " = IconData(" +
          split[2].replaceAll("\"\\", "0x").split("\"")[0] +
          ", fontFamily: \"$fontName\");\n";
    }
  }
  result+="}";
  fileCss.delete();//删除css文件

  File fileOut = File(path.join(Directory.current.path,outFile));
  if(! await fileOut.exists()){
    await fileOut.create(recursive: true);
  }
  fileOut.writeAsString(result);//将代码写入dart文件

  String config="""
  fonts:
    - family: $fontName
      fonts:
        - asset: $resDir/iconfont.ttf""";

  print("build OK:\n $config");
}