import 'dart:io';
import 'dart:convert';

void main() async {
  // 读取中文描述映射
  final descZhFile = File('test/science_server/moke/output/desc_zh.json');
  final descZhContent = await descZhFile.readAsString();
  final Map<String, dynamic> chineseDescriptions = json.decode(descZhContent);
  
  // 处理所有分类文件
  final directory = Directory('test/science_server/moke/output/category_packages');
  int updatedFiles = 0;
  int updatedPackages = 0;
  
  await for (final file in directory.list()) {
    if (file is File && file.path.endsWith('.json')) {
      final content = await file.readAsString();
      final List<dynamic> packages = json.decode(content);
      bool fileModified = false;
      
      for (final package in packages) {
        final name = package['name'] as String;
        if (chineseDescriptions.containsKey(name)) {
          package['descZh'] = chineseDescriptions[name];
          fileModified = true;
          updatedPackages++;
        }
      }
      
      if (fileModified) {
        final updatedContent = json.encode(packages);
        await file.writeAsString(updatedContent);
        updatedFiles++;
        print('已更新文件: ${file.path.split('/').last}');
      }
    }
  }
  
  print('完成！更新了 $updatedFiles 个文件，$updatedPackages 个包添加了中文描述');
}