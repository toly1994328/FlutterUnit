import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

void main() async {
  // 读取已翻译的包
  final descZhPath = path.join('test', 'science_server', 'moke', 'output', 'desc_zh.json');
  final descZhFile = File(descZhPath);
  final descZhContent = await descZhFile.readAsString();
  final Map<String, dynamic> translatedPackages = json.decode(descZhContent);
  
  // 读取所有包的映射
  final mappingPath = path.join('test', 'science_server', 'moke', 'output', 'package_desc_mapping.json');
  final mappingFile = File(mappingPath);
  final mappingContent = await mappingFile.readAsString();
  final Map<String, dynamic> allPackages = json.decode(mappingContent);
  
  // 找出未翻译的包
  final Map<String, String> untranslatedPackages = {};
  
  allPackages.forEach((name, desc) {
    if (!translatedPackages.containsKey(name)) {
      untranslatedPackages[name] = desc.toString();
    }
  });
  
  final outputPath = path.join('test', 'science_server', 'moke', 'output', 'translation_todo.json');
  final outputFile = File(outputPath);
  await outputFile.writeAsString(json.encode(untranslatedPackages));
  
  print('发现 ${untranslatedPackages.length} 个未翻译的包，保存到 $outputPath');
}