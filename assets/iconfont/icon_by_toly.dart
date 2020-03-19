import 'dart:io';
import 'package:path/path.dart' as path;
main() async{
  var resDir="assets/iconfont";//资源文件夹
  var outFile='lib/app/style/TolyIcon.dart';//输出文件地址

  var result = """import 'package:flutter/widgets.dart';
//Power By 张风捷特烈--- Generated file. Do not edit.
class TolyIcon {
    TolyIcon._();
""";
  var fileCss = File(path.join(Directory.current.path,"$resDir/iconfont.css"));
  if (! await fileCss.exists()) return;

  var read = await fileCss.readAsString();
  var split = read.split(".icon-");
  split.forEach((str) {
    if (str.contains("before")) {
      var split = str.split(":");
      result += "static const IconData " +
          split[0].replaceAll("-", "_") +
          " = const IconData(" +
          split[2].replaceAll("\"\\", "0x").split("\"")[0] +
          ", fontFamily: \"TolyIcon\");\n";
    }
  });
  result+="}";
  fileCss.delete();//删除css文件
  var fileOut = File(path.join(Directory.current.path,"$outFile"));
  if(! await fileOut.exists()){
    await fileOut.create(recursive: true);
  }
  fileOut.writeAsString(result);//将代码写入dart文件
  var config="""
  fonts:
    - family: TolyIcon
      fonts:
        - asset: """+"$resDir/iconfont.ttf";

  print("build OK:\n $config");
}