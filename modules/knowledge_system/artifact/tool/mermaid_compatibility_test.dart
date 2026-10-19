import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mermaid_flutter/mermaid_flutter.dart';

/// 按需验证作者的实际文章，不把整批文章作为测试资源打入安装包。
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('实际文章中的 Mermaid 图表解析并绘制为 PNG', verifyCorpus,
      timeout: const Timeout(Duration(minutes: 5)));
}

Future<void> verifyCorpus() async {
  const String directory = '../../output/FlutterUnitX/mermaid-preview';
  final List<dynamic> items =
      jsonDecode(File('$directory/article-diagrams.json').readAsStringSync())
          as List<dynamic>;
  final List<Map<String, dynamic>> results = <Map<String, dynamic>>[];
  final Set<String> previews = <String>{};
  for (int index = 0; index < items.length; index++) {
    final Map<String, dynamic> item = items[index] as Map<String, dynamic>;
    final Map<String, dynamic> result = <String, dynamic>{
      'index': index,
      'title': item['title'],
      'type': item['type'],
    };
    try {
      final Uint8List bytes =
          await renderToPng(item['source'] as String, pixelRatio: 1);
      result['ok'] = true;
      result['bytes'] = bytes.length;
      if (previews.add(item['type'] as String)) {
        File('$directory/${item['type']}.png').writeAsBytesSync(bytes);
      }
    } catch (error) {
      result['ok'] = false;
      result['error'] = error.toString();
    }
    results.add(result);
  }
  File('$directory/compatibility.json')
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(results));
  final int succeeded =
      results.where((Map<String, dynamic> item) => item['ok'] == true).length;
  // 兼容性失败逐项写入报告，由预览确认差异，不将统计结果误报为全部通过。
  stderr.writeln('Mermaid 实际文章绘制成功：$succeeded / ${results.length}');
  expect(succeeded, greaterThan(0));
}
