import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

void main() async {
  final directoryPath = path.join('test', 'science_server', 'moke', 'output', 'category_packages');
  final directory = Directory(directoryPath);
  final Map<String, String> packageMapping = {};
  
  await for (final file in directory.list()) {
    if (file is File && path.extension(file.path) == '.json') {
      final content = await file.readAsString();
      final List<dynamic> packages = json.decode(content);
      
      for (final package in packages) {
        final name = package['name'] as String;
        final desc = package['desc'] as String? ?? '';
        packageMapping[name] = desc;
      }
    }
  }
  
  final outputPath = path.join('test', 'science_server', 'moke', 'output', 'package_desc_mapping.json');
  final outputFile = File(outputPath);
  await outputFile.writeAsString(json.encode(packageMapping));
  
  print('已分析 ${packageMapping.length} 个包，结果保存到 $outputPath');
}