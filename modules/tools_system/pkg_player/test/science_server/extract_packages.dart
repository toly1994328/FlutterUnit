import 'dart:io';
import 'dart:convert';

void main() async {
  final directory = Directory('test/science_server/moke/output/category_packages');
  final Map<String, String> nameDescMap = {};
  
  await for (final file in directory.list()) {
    if (file is File && file.path.endsWith('.json')) {
      final content = await file.readAsString();
      final List<dynamic> packages = json.decode(content);
      
      for (final package in packages) {
        final name = package['name'] as String;
        final desc = package['desc'] as String? ?? '';
        nameDescMap[name] = desc;
      }
    }
  }
  
  // 输出为JSON格式到文件
  final jsonOutput = json.encode(nameDescMap);
  final outputFile = File('packages_mapping.json');
  await outputFile.writeAsString(jsonOutput);
  print('已提取 ${nameDescMap.length} 个包的信息到 packages_mapping.json');
}