//
// import 'dart:convert';
// import 'dart:io';
//
// // import 'package:yaml/yaml.dart';
// import 'package:yaml_modify/yaml_modify.dart';
//
// void main(){
//   final String filePath = r'E:\Projects\Flutter\FlutterUnit\pubspec.yaml';
//   File pubspecFile = File(filePath);
//   final String pubspec = pubspecFile.readAsStringSync();
//   print(pubspec);
//
//   // YamlEditor doc = YamlEditor(pubspec);
//   // print(doc);
//   final doc = loadYaml(pubspec);
//   print(doc);
//
//   YamlList fontsList = doc['flutter']['fonts'] as YamlList;
//
//   final modifiableDoc = getModifiableNode(doc);
//   final modifiableList = getModifiableNode(fontsList);
//   modifiableList.removeWhere((e) => e['family'] == 'TolyIcon');
//   modifiableList.add(
//       YamlMap.wrap({
//         'family': 'TolyIcon3',
//         'fonts':YamlList.wrap([YamlMap.wrap({'asset':'assets/iconfont/iconfont.ttf'})])
//       })
//   );
//   modifiableDoc['flutter']['fonts'] = modifiableList;
//   final strYaml = toYamlString(modifiableDoc);
//   print(modifiableList);
//
//   // // YamlMap flutterNode = doc[];
//   // doc.update('flutter', (value) {
//   //   // YamlList fontsNode = value as YamlList;
//   //   // List<dynamic> filter = fontsNode.where((e) => e['family']!='TolyIcon').toList();
//   //
//   //   return YamlMap.wrap({
//   //     'family': 'TolyIcon3',
//   //     'fonts':YamlList.wrap([YamlMap.wrap({'asset':'assets/iconfont/iconfont.ttf'})])
//   //   });
//   // });
//
//   // YamlList fontsList = doc['flutter']['fonts'] as YamlList;
//   //
//
//   // // doc.
//   print(doc);
//
// }