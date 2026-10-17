import 'package:artifact/src/articles/data/exp.dart';
import 'package:artifact/src/articles/view/article/markdown_article_page.dart';
import 'package:artifact/src/articles/view/article/reading/document_markdown.dart';
import 'package:artifact/src/articles/view/article/reading/outline_entry.dart';
import 'package:artifact/src/articles/view/article/reading/reading_navigation.dart';
import 'package:artifact/src/articles/view/article/reading/reading_outline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// 远处章节在首屏没有构建，且含代码井号、引用标题、重名及 Setext 标题。
class NavigationRepository extends ArticleRepository {
  @override
  Future<MarkdownArticle> openMarkdown(String id) async {
    final StringBuffer body = StringBuffer('# 目录测试\n\n## 一、基础\n\n'
        '> ## 引用中的标题\n\n'
        '```markdown\n# 代码中的标题\n```\n\n');
    for (int index = 0; index < 80; index++) {
      body.writeln('长文段落 $index：用于验证未构建章节跳转，正文保留惰性加载。'
          '使用相同正文模拟多页内容，不依赖估算行高或固定图片尺寸。\n');
    }
    body.writeln('### 相同标题\n\n中间小节。\n\n'
        '### 相同标题\n\n另一个重名小节。\n\n'
        'Setext 章节\n------------\n');
    for (int index = 0; index < 20; index++) {
      body.writeln('末章段落 $index，留出足够滚动空间以核对标题在阅读区顶部。\n');
    }
    return MarkdownArticle(
        title: '目录测试',
        content: body.toString(),
        sourceUrl: 'https://example.com/navigation');
  }
}

/// 无章节正文不占用目录侧栏空间。
class PlainNavigationRepository extends ArticleRepository {
  @override
  Future<MarkdownArticle> openMarkdown(String id) async =>
      const MarkdownArticle(
          title: '无章节文章',
          content: '只有普通段落的正文。',
          sourceUrl: 'https://example.com/plain');
}

void main() {
  test('目录片段兼容中文标点与百分号编码前的原始标题', testFragments);
  testWidgets('抽屉目录跳到未构建的远处章节并能返回前文', testLongJump);
  testWidgets('宽屏常驻目录，系统缩放和窗口变化后仍可定位重名标题', testWideNavigation);
  testWidgets('没有章节时隐藏侧栏，顶部不显示操作按钮', testNoHeadings);
}

void testFragments() {
  expect(outlineFragment('一、基础：Dart & Flutter'), '一基础dart-flutter');
  expect(outlineFragment('重复 标题'), '重复-标题');
}

Future<ReadingNavigation> mountNavigation(WidgetTester tester, Size size,
    {ArticleRepository? repository}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(MaterialApp(
      home: MarkdownArticlePage(
          article: const Article(
              id: 'navigation',
              title: '目录测试',
              url: 'https://example.com/navigation'),
          repository: repository ?? NavigationRepository())));
  await tester.pumpAndSettle();
  final DocumentMarkdown document =
      tester.widget<DocumentMarkdown>(find.byType(DocumentMarkdown));
  return document.navigation;
}

Future<void> testNoHeadings(WidgetTester tester) async {
  final ReadingNavigation navigation = await mountNavigation(
      tester, const Size(1400, 900),
      repository: PlainNavigationRepository());
  expect(navigation.entries.value, isEmpty);
  expect(find.byType(ReadingOutline), findsNothing);
  expect(
      find.descendant(
          of: find.byType(AppBar), matching: find.byType(IconButton)),
      findsNothing);
  expect(tester.takeException(), isNull);
}

Future<void> testLongJump(WidgetTester tester) async {
  final ReadingNavigation navigation =
      await mountNavigation(tester, const Size(420, 800));
  final List<OutlineEntry> entries = navigation.entries.value;
  expect(entries.map((OutlineEntry entry) => entry.title),
      <String>['一、基础', '相同标题', '相同标题', 'Setext 章节']);
  expect(entries.map((OutlineEntry entry) => entry.level), <int>[2, 3, 3, 2]);
  expect(entries[1].fragment, isNot(entries[2].fragment));
  final Finder target =
      find.byKey(ValueKey<String>('reading-heading-${entries.last.id}'));
  expect(target, findsNothing);
  await openOutline(tester);
  await tester
      .tap(find.byKey(ValueKey<String>('outline-entry-${entries.last.id}')));
  await tester.pumpAndSettle();
  expect(target, findsOneWidget);
  expect(navigation.active.value, entries.last.id);
  final Rect paper = tester.getRect(find.byType(DocumentMarkdown));
  expect(
      tester.getTopLeft(target).dy, inInclusiveRange(paper.top, paper.bottom));
  expect(tester.getTopLeft(target).dy,
      greaterThanOrEqualTo(tester.getBottomLeft(find.byType(AppBar)).dy));
  await openOutline(tester);
  await tester
      .tap(find.byKey(ValueKey<String>('outline-entry-${entries.first.id}')));
  await tester.pumpAndSettle();
  expect(navigation.active.value, entries.first.id);
  expect(find.byKey(ValueKey<String>('reading-heading-${entries.first.id}')),
      findsOneWidget);
  expect(tester.takeException(), isNull);
}

Future<void> testWideNavigation(WidgetTester tester) async {
  final ReadingNavigation navigation =
      await mountNavigation(tester, const Size(950, 900));
  expect(find.byType(ReadingOutline), findsOneWidget);
  final OutlineEntry duplicate = navigation.entries.value[2];
  await tester
      .tap(find.byKey(ValueKey<String>('outline-entry-${duplicate.id}')));
  await tester.pumpAndSettle();
  expect(navigation.active.value, duplicate.id);
  tester.platformDispatcher.textScaleFactorTestValue = 1.4;
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  await tester.pumpAndSettle();
  expect(navigation.entries.value[2].fragment, duplicate.fragment);
  final Future<bool> jump = navigation.openFragment(
      Uri.encodeComponent(navigation.entries.value.first.fragment));
  await tester.pumpAndSettle();
  expect(await jump, isTrue);
  expect(navigation.active.value, navigation.entries.value.first.id);
  navigation.scroll
      .jumpTo(index: navigation.entries.value.last.blockIndex, alignment: .04);
  await tester.pumpAndSettle();
  expect(navigation.active.value, navigation.entries.value.last.id);
  tester.view.physicalSize = const Size(380, 800);
  await tester.pumpAndSettle();
  expect(find.byType(ReadingOutline), findsNothing);
  expect(navigation.entries.value.length, 4);
  await openOutline(tester);
  expect(find.byType(ReadingOutline), findsOneWidget);
  expect(tester.takeException(), isNull);
}

/// 窄屏通过右侧边缘滑入目录，不依赖已经移除的顶部按钮。
Future<void> openOutline(WidgetTester tester) async {
  await tester.dragFrom(
      Offset(tester.view.physicalSize.width - 1, 400), const Offset(-280, 0));
  await tester.pumpAndSettle();
}
