import 'package:artifact/src/articles/data/exp.dart';
import 'package:artifact/src/articles/view/article/markdown_article_page.dart';
import 'package:artifact/src/articles/view/article/reading/document_markdown.dart';
import 'package:artifact/src/articles/view/article/reading/reading_code.dart';
import 'package:artifact/src/articles/view/article/reading/reading_content.dart';
import 'package:artifact/src/articles/view/article/reading/reading_inline_code.dart';
import 'package:artifact/src/articles/view/article/reading/reading_theme.dart';
import 'package:artifact/src/articles/view/article/reading/reading_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// 同时包含导出元信息、深级标题、长代码和表格的阅读样本。
class ReadingRepository extends ArticleRepository {
  /// 复制必须保持原样的代码，包含缩进、尖括号、实体符号和长行。
  static const String code = 'void main() {\n'
      '  const value = "<tag>&";\n'
      '  print("这是一条保留原样的长代码行 abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz");\n'
      '}\n';

  @override
  Future<MarkdownArticle> openMarkdown(String id) async =>
      const MarkdownArticle(
          title: '阅读测试',
          sourceUrl: 'https://example.com/article',
          content: '# 阅读测试\n\n'
              '> 作者：张风捷特烈\n> 创建时间：2026-10-15\n'
              '> 原文：[来源](https://example.com/article)\n\n'
              '#### 四级章节\n\n标题后的普通正文。\n\n##### 五级小节\n\n'
              '正文含有 `inline_code` 和 **强调文字**。\n\n'
              '---\n\n'
              '```dart\n$code```\n\n'
              '| 名称 | 用途 |\n| --- | --- |\n| 路径 | 读取文件目录 |\n');
}

void main() {
  test('重复导出抬头仅在同名首标题之后收起', testExportHeader);
  test('正文引用和围栏代码保持原样', testOrdinaryBody);
  testWidgets('窄屏代码可横向滚动且复制保留完整原文', testCompactCode);
  testWidgets('深色宽屏支持系统文字缩放与完整标题层级', testDarkTypography);
  testWidgets('行内代码有圆角及左右内边距，正文仍可选择复制', testInlineCode);
  testWidgets('简单列表使用独立紧凑行高，实际项高不被正文撑大', testCompactList);
}

Future<void> testCompactList(WidgetTester tester) async {
  final ReadingNavigation navigation = ReadingNavigation();
  addTearDown(navigation.dispose);
  Widget list(BuildContext context) => Scaffold(
      body: DocumentMarkdown(
          navigation: navigation,
          header: const SizedBox(),
          data: '- 组件 Logo；\n- 组件英文名；\n- 数据库 ID；\n- 星级；\n- 当前是否存在有效 SVG。',
          styleSheet: ReadingTheme.markdown(context, 14)));
  await tester.pumpWidget(MaterialApp(home: Builder(builder: list)));
  await tester.pumpAndSettle();
  final double first = tester.getTopLeft(find.text('组件 Logo；')).dy;
  final double second = tester.getTopLeft(find.text('组件英文名；')).dy;
  expect(second - first, lessThanOrEqualTo(27));
  expect(tester.takeException(), isNull);
}

Future<void> testInlineCode(WidgetTester tester) async {
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
  await mountReader(tester, const Size(360, 800), Brightness.light);
  final Finder inline = find.byType(ReadingInlineCode);
  expect(inline, findsOneWidget);
  final DecoratedBox background = tester.widget<DecoratedBox>(
      find.descendant(of: inline, matching: find.byType(DecoratedBox)));
  expect((background.decoration as BoxDecoration).borderRadius,
      BorderRadius.circular(4));
  final Padding padding = tester.widget<Padding>(
      find.descendant(of: inline, matching: find.byType(Padding)));
  expect((padding.padding as EdgeInsets).left, 6);
  expect((padding.padding as EdgeInsets).right, 6);
  await tester.tap(find.text('inline_code'));
  await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
  await tester.sendKeyEvent(LogicalKeyboardKey.keyA);
  await tester.sendKeyEvent(LogicalKeyboardKey.keyC);
  await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
  await tester.pump();
  expect(copied, contains('inline_code'));
  expect(copied, contains('正文含有'));
  expect(tester.takeException(), isNull);
}

void testExportHeader() {
  const String original = '# 标题\n\n> 作者：作者\n> 创建时间：时间\n'
      '> 原文：[来源](https://example.com)\n\n正文';
  expect(readingBody(original, '标题'), '正文');
  expect(readingBody(original.replaceAll('\n', '\r\n'), '标题'), '正文');
  expect(readingBody(original, '其他标题'), original);
}

void testOrdinaryBody() {
  expect(readingBody('# 标题\n\n    int value = 1;\n', '标题'),
      '    int value = 1;\n');
  const String original = '# 标题\n\n> 一条需要保留的引用\n\n'
      '```markdown\n# 标题\n> 作者：示例\n```\n';
  expect(readingBody(original, '标题'),
      '> 一条需要保留的引用\n\n```markdown\n# 标题\n> 作者：示例\n```\n');
}

Future<void> mountReader(
    WidgetTester tester, Size size, Brightness brightness) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(MaterialApp(
      theme:
          ThemeData(brightness: brightness, platform: TargetPlatform.windows),
      home: MarkdownArticlePage(
          article: const Article(
              id: 'reading', title: '阅读测试', url: 'https://example.com/article'),
          repository: ReadingRepository())));
  await tester.pumpAndSettle();
}

Future<void> testCompactCode(WidgetTester tester) async {
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
  await mountReader(tester, const Size(360, 800), Brightness.light);
  final ReadingCode code = tester.widget<ReadingCode>(find.byType(ReadingCode));
  expect(code.source, ReadingRepository.code);
  expect(find.text('DART'), findsOneWidget);
  await tester.ensureVisible(find.byTooltip('复制代码'));
  await tester.tap(find.byTooltip('复制代码'));
  await tester.pumpAndSettle();
  expect(copied, ReadingRepository.code);
  expect(find.text('代码已复制'), findsOneWidget);
  final Finder horizontal = find.descendant(
      of: find.byType(ReadingCode),
      matching: find.byType(SingleChildScrollView));
  final SingleChildScrollView scroll = tester.widget(horizontal);
  expect(scroll.controller!.position.maxScrollExtent, greaterThan(0));
  expect(tester.takeException(), isNull);
}

Future<void> testDarkTypography(WidgetTester tester) async {
  tester.platformDispatcher.textScaleFactorTestValue = 1.4;
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  await mountReader(tester, const Size(1200, 900), Brightness.dark);
  final DocumentMarkdown document =
      tester.widget<DocumentMarkdown>(find.byType(DocumentMarkdown));
  expect(document.styleSheet!.h4!.fontSize,
      greaterThan(document.styleSheet!.p!.fontSize!));
  expect(document.styleSheet!.h5!.fontSize,
      greaterThan(document.styleSheet!.p!.fontSize!));
  expect(document.styleSheet!.p!.fontSize, 14);
  final Text paragraph = tester.widget<Text>(find.byWidgetPredicate(
      (Widget widget) =>
          widget is Text && widget.textSpan?.toPlainText() == '标题后的普通正文。'));
  expect(paragraph.textSpan!.style!.fontSize, 14);
  expect(paragraph.textSpan!.style!.fontWeight, isNot(FontWeight.w700));
  expect(find.byType(SelectionArea), findsOneWidget);
  expect(document.data, isNot(contains('> 作者：')));
  expect(tester.getSize(find.byType(DocumentMarkdown)).width,
      lessThanOrEqualTo(880));
  expect(tester.takeException(), isNull);
}
