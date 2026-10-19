import 'dart:convert';
import 'dart:io';

import 'package:artifact/src/articles/view/article/reading/mermaid/reading_mermaid.dart';
import 'package:artifact/src/articles/view/article/reading/mermaid/reading_mermaid_viewer.dart';
import 'package:artifact/src/articles/view/article/reading/reading_code.dart';
import 'package:artifact/src/articles/view/article/reading/reading_code_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mermaid_flutter/mermaid_flutter.dart';

const String source = 'flowchart LR\n  A[文章] --> B[图表]\n';

void main() {
  testWidgets('Mermaid 围栏渲染为图表，其余代码仍使用高亮', testMarkdownDispatch);
  testWidgets('窄屏适配并能打开缩放视口，源码复制保留原文', testViewerAndSource);
  testWidgets('语法错误可回退源码，更新后不保留旧图表', testInvalidSource);
  testWidgets('现有文章的五类图表在明暗主题均可绘制', testArticleSamples);
}

Future<void> testMarkdownDispatch(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
      home: Scaffold(
          body: MarkdownBody(
              data: '```mermaid\n$source```\n\n```dart\nvoid main() {}\n```',
              builders: <String, MarkdownElementBuilder>{
        'pre': ReadingCodeBuilder(fontSize: 11),
      }))));
  await tester.pumpAndSettle();
  expect(find.byType(ReadingMermaid), findsOneWidget);
  expect(find.byType(MermaidDiagram), findsOneWidget);
  expect(find.byType(ReadingCode), findsOneWidget);
  expect(find.textContaining('暂时无法渲染'), findsNothing);
  expect(tester.takeException(), isNull);
}

Future<void> mountDiagram(WidgetTester tester, String text,
    {Brightness brightness = Brightness.light}) async {
  await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
          body: SingleChildScrollView(
              child: ReadingMermaid(source: text, fontSize: 11)))));
  await tester.pumpAndSettle();
}

Future<void> testViewerAndSource(WidgetTester tester) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(360, 800);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  String? copied;
  Future<Object?> clipboard(MethodCall call) async {
    if (call.method == 'Clipboard.setData') {
      copied = (call.arguments as Map<dynamic, dynamic>)['text'] as String;
    }
    return null;
  }

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, clipboard);
  addTearDown(() => TestDefaultBinaryMessengerBinding
      .instance.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, null));
  await mountDiagram(tester, source);
  expect(tester.getSize(find.byType(ReadingMermaid)).width, 360);
  await tester.tap(find.byIcon(Icons.open_in_full));
  await tester.pumpAndSettle();
  expect(find.byType(ReadingMermaidViewer), findsOneWidget);
  expect(find.byType(MermaidView), findsOneWidget);
  await tester.tap(find.text('适应窗口'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('复制源码'));
  await tester.pump();
  expect(copied, source);
  await tester.tap(find.byType(CloseButton));
  await tester.pumpAndSettle();
  await tester.tap(find.text('源码'));
  await tester.pumpAndSettle();
  expect(tester.widget<ReadingCode>(find.byType(ReadingCode)).source, source);
  await tester.tap(find.text('图表'));
  await tester.pumpAndSettle();
  expect(find.byType(MermaidDiagram), findsOneWidget);
  expect(tester.takeException(), isNull);
}

Future<void> testInvalidSource(WidgetTester tester) async {
  await mountDiagram(tester, source);
  await mountDiagram(tester, 'not-a-real-diagram\ninvalid');
  expect(find.textContaining('暂时无法渲染'), findsOneWidget);
  await tester.tap(find.text('源码'));
  await tester.pumpAndSettle();
  expect(tester.widget<ReadingCode>(find.byType(ReadingCode)).source,
      'not-a-real-diagram\ninvalid');
  expect(tester.takeException(), isNull);
}

Future<void> testArticleSamples(WidgetTester tester) async {
  // 兼容从工作区根目录和 artifact 子包目录运行测试。
  final File localFixture = File('test/fixtures/mermaid_samples.json');
  final File fixture = localFixture.existsSync()
      ? localFixture
      : File(
          'modules/knowledge_system/artifact/test/fixtures/mermaid_samples.json');
  final List<dynamic> samples =
      jsonDecode(fixture.readAsStringSync()) as List<dynamic>;
  for (final Brightness brightness in Brightness.values) {
    for (final dynamic sample in samples) {
      final Map<String, dynamic> item = sample as Map<String, dynamic>;
      await mountDiagram(tester, item['source'] as String,
          brightness: brightness);
      expect(find.textContaining('暂时无法渲染'), findsNothing,
          reason: '${item['type']} / $brightness');
      expect(tester.takeException(), isNull);
    }
  }
}
