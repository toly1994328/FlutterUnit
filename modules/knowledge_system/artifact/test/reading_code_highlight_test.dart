import 'package:artifact/src/articles/view/article/reading/reading_code_highlight.dart';
import 'package:artifact/src/articles/view/article/reading/reading_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('常见语言及别名生成不同语法颜色，保留所有源码字符', testLanguages);
  test('未标语言识别 Flutter 代码，纯文本及未知语言保留原样', testDetection);
  testWidgets('代码来源改变后同步更新语言和高亮内容', testSourceUpdate);
  testWidgets('行号与空行对齐、横向滚动固定，复制保留原源码', testLineNumbers);
}

Set<Color> colors(TextSpan span) {
  final Set<Color> result = <Color>{};
  bool collect(InlineSpan node) {
    final Color? color = node.style?.color;
    if (color != null && color != const Color(0xffABB2BF)) result.add(color);
    return true;
  }

  collect(span);
  span.visitChildren(collect);
  return result;
}

void testLanguages() {
  const Map<String, String> samples = <String, String>{
    'Dart': 'void main() { final text = "<tag>&"; print(text); }\r\n',
    'ts': 'const count: number = 42; // 中文注释\n',
    'js': 'function hello() { return "hello"; }\n',
    'json': '{"count": 42, "enabled": true}\n',
    'yml': 'name: FlutterUnit\nversion: 1\n',
    'sh': 'echo "hello"\n',
    'ps1': 'Get-ChildItem -Path "C:/temp"\n',
    'java': 'public class Main { private int count = 42; }\n',
    'kt': 'fun main() { val count = 42 }\n',
    'swift': 'let count = 42\nprint("hello")\n',
    'py': 'def main():\n  return "hello"\n',
    'rs': 'fn main() { let count = 42; }\n',
    'c': 'int main() { return 0; }\n',
    'c++': '#include <iostream>\nint main() { return 0; }\n',
    'c#': 'public class Main { private int count = 42; }\n',
    'sql': 'SELECT id FROM articles WHERE id = 1;\n',
    'svg': '<svg width="24"><path d="M0 0"/></svg>\n',
    'css': '.title { color: red; width: 24px; }\n',
    'glsl': 'void main() { gl_Position = vec4(1.0); }\n',
    'toml': '[server]\nport = 9602\n',
    'cmake': 'project(FlutterUnit)\nset(VERSION "1.0")\n',
    'diff': '@@ -1 +1 @@\n-old\n+new\n',
    'http': 'GET / HTTP/1.1\r\nHost: example.com\r\n',
  };
  for (final MapEntry<String, String> sample in samples.entries) {
    final ReadingCodeHighlight result =
        highlightReadingCode(sample.value, sample.key);
    expect(result.span.toPlainText(),
        sample.value.replaceFirst(RegExp(r'\r?\n$'), ''),
        reason: sample.key);
    expect(colors(result.span), isNotEmpty, reason: sample.key);
  }
}

void testDetection() {
  const String dart =
      'class Page extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) => const Text("hello");\n}\n';
  final ReadingCodeHighlight detected = highlightReadingCode(dart, '');
  expect(detected.language, 'dart');
  expect(colors(detected.span), isNotEmpty);
  for (final String language in <String>[
    'text',
    'plaintext',
    'mermaid',
    'unknown'
  ]) {
    final ReadingCodeHighlight plain = highlightReadingCode(dart, language);
    expect(plain.span.toPlainText(), dart.trimRight());
    expect(colors(plain.span), isEmpty);
  }
  final ReadingCodeHighlight ordinary = highlightReadingCode('这是一段普通说明文字。', '');
  expect(ordinary.language, 'text');
  expect(colors(ordinary.span), isEmpty);
}

Future<void> testSourceUpdate(WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: ReadingCode(
              source: '{"count": 42}\n', language: 'json', fontSize: 11))));
  expect(find.text('JSON'), findsOneWidget);
  final SelectableText json =
      tester.widget<SelectableText>(find.byType(SelectableText));
  expect(json.style!.fontSize, 11);
  expect(colors(json.textSpan!), isNotEmpty);
  await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: ReadingCode(
              source: 'print("hello")\n', language: 'python', fontSize: 11))));
  expect(find.text('PYTHON'), findsOneWidget);
  final SelectableText python =
      tester.widget<SelectableText>(find.byType(SelectableText));
  expect(python.textSpan!.toPlainText(), 'print("hello")');
  expect(tester.takeException(), isNull);
}

Future<void> testLineNumbers(WidgetTester tester) async {
  final String source =
      '// 中文注释 ${'long content ' * 30}\r\n\r\nvoid main() {}\r\n';
  String? copied;
  Future<Object?> clipboard(MethodCall call) async {
    if (call.method == 'Clipboard.setData') {
      copied = call.arguments['text'] as String;
    }
    return null;
  }

  tester.binding.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, clipboard);
  await tester.pumpWidget(MaterialApp(
      home: Scaffold(
          body: Center(
              child: SizedBox(
                  width: 320,
                  child: ReadingCode(
                      source: source, language: 'dart', fontSize: 11))))));
  final Finder numbers = find.text('1\n2\n3');
  final Finder code = find.byType(SelectableText);
  expect(numbers, findsOneWidget);
  expect(
      tester.getSize(numbers).height, closeTo(tester.getSize(code).height, 1));
  final Offset origin = tester.getTopLeft(numbers);
  final SingleChildScrollView scroll =
      tester.widget<SingleChildScrollView>(find.byType(SingleChildScrollView));
  expect(scroll.controller!.position.maxScrollExtent, greaterThan(200));
  final double codeLeft = tester.getTopLeft(code).dx;
  scroll.controller!.jumpTo(200);
  await tester.pump();
  expect(tester.getTopLeft(numbers), origin);
  expect(tester.getTopLeft(code).dx, closeTo(codeLeft - 200, 1));
  await tester.tap(find.byIcon(Icons.copy_outlined));
  await tester.pump();
  expect(copied, source);
  expect(tester.takeException(), isNull);
  tester.binding.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, null);
}
