//
// import 'dart:convert';
// import 'dart:io';
//
// // import 'package:yaml/yaml.dart';
// import 'package:yaml_modify/yaml_modify.dart';
//
// void main(){
//   String familyName = 'TolyIcon';
//   String fontAssetsDist = 'assets/iconfont/iconfont.ttf';
//
//   // final String filePath = r'E:\Projects\Flutter\FlutterUnit\pubspec.yaml';
//   final String filePath = r'E:\Projects\Flutter\Work\toly_image_edit\pubspec.yaml';
//   File pubspecFile = File(filePath);
//
//   List<String> lines = pubspecFile.readAsLinesSync();
//
//   RegExp fontsRegex = RegExp(r'^  fonts:',multiLine: true);
//   bool hasFonts = fontsRegex.hasMatch(lines.join('\n'));
//
//   if(!hasFonts){
//     // 当前没有 fonts 节点，需要添加到 flutter 节点下
//     int index = lines.indexWhere((e) => e.startsWith('flutter:'));
//
//     List<String> fonts = [
//       '  fonts:',
//       '    - family: TolyIcon',
//       '      fonts:',
//       '        - asset: assets/iconfont/iconfont.ttf',
//     ];
//
//     lines.insertAll(index+1, fonts);
//     print(lines);
//     pubspecFile.writeAsStringSync(lines.join('\n'));
//     return;
//   }
//   // 存在 fonts 节点，查询 family ，有没有当前字体图标
//   bool hasTargetFamily = false;
//   RegExp regExp = RegExp(r'^ +- family: +(\w+)');
//
//   for(int i=0;i<lines.length;i++){
//     String line = lines[i];
//     if(line.startsWith(regExp)){
//       String family = regExp.allMatches(line).first.group(1)??'';
//       if(family == familyName){
//         hasTargetFamily = true;
//         break;
//       }
//     }
//   }
//   if(!hasTargetFamily){
//     int index = lines.indexWhere((e) => e.startsWith(fontsRegex));
//     List<String> fonts = [
//       '    - family: TolyIcon',
//       '      fonts:',
//       '        - asset: $fontAssetsDist',
//     ];
//     lines.insertAll(index+1, fonts);
//     print(lines);
//     pubspecFile.writeAsStringSync(lines.join('\n'));
//     return;
//   }
//
// }