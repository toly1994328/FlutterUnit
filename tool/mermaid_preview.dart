import 'dart:convert';
import 'dart:io';

import 'package:artifact/src/articles/view/article/reading/reading_code_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fx_platform_adapter/fx_platform_adapter.dart';

/// 使用真实文章中的图表单独预览，不改动线上文章和应用默认入口。
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowSizeAdapter.setSize(size: const Size(1113, 829.5));
  final List<dynamic> samples = jsonDecode(File(
          'modules/knowledge_system/artifact/test/fixtures/mermaid_samples.json')
      .readAsStringSync()) as List<dynamic>;
  final StringBuffer content = StringBuffer('# Mermaid 阅读效果\n\n');
  for (final dynamic sample in samples) {
    final Map<String, dynamic> item = sample as Map<String, dynamic>;
    content.writeln('## ${item['type']}\n\n${item['title']}\n');
    content.writeln('```mermaid\n${item['source']}```\n');
  }
  runApp(MermaidPreview(markdown: content.toString()));
}

class MermaidPreview extends StatefulWidget {
  /// 与文章阅读页使用相同围栏构建器的预览正文。
  final String markdown;

  const MermaidPreview({super.key, required this.markdown});

  @override
  State<MermaidPreview> createState() => _MermaidPreviewState();
}

class _MermaidPreviewState extends State<MermaidPreview> {
  /// 可快速对比图表在明暗背景中的表现。
  bool _dark = false;

  /// 桌面窗口也能检查移动端正文宽度。
  bool _compact = false;

  void _toggleTheme() => setState(() => _dark = !_dark);
  void _toggleWidth() => setState(() => _compact = !_compact);

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: _dark ? Brightness.dark : Brightness.light,
          colorSchemeSeed: const Color(0xff454cbd)),
      home: Scaffold(
          appBar: AppBar(
              title: const Text('FlutterUnit · Mermaid 预览'),
              actions: <Widget>[
                TextButton(
                    onPressed: _toggleWidth,
                    child: Text(_compact ? '桌面宽度' : '手机宽度')),
                TextButton(
                    onPressed: _toggleTheme, child: Text(_dark ? '浅色' : '深色')),
              ]),
          body: Center(
              child: SizedBox(
                  width: _compact ? 360 : 880,
                  child: Markdown(
                      data: widget.markdown,
                      padding: const EdgeInsets.all(20),
                      builders: <String, MarkdownElementBuilder>{
                        'pre': ReadingCodeBuilder(fontSize: 11),
                      })))));
}
