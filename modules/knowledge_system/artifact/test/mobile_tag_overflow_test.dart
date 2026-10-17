import 'package:artifact/src/articles/data/exp.dart';
import 'package:artifact/src/articles/view/article/markdown_article_page.dart';
import 'package:artifact/src/articles/view/library/article_card.dart';
import 'package:artifact/src/articles/view/library/article_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'support/reading_image_cache.dart';

void main() {
  setUp(configureReadingImageCache);
  tearDown(resetReadingImageCache);
  testWidgets('手机单行标签的数量按钮打开完整标签弹框，不打开文章', testMobileTags);
}

/// 在真实手机卡片的嵌套点击区域中验证数量入口和返回行为。
Future<void> testMobileTags(WidgetTester tester) async {
  tester.view.physicalSize = const Size(360, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  const Article article = Article(
      id: 'mobile-tags',
      type: 2,
      title: '当 AI 遇见 Flutter',
      subtitle: '从组件语义出发，构建可维护的 Widget 专属图标。',
      cover: 'https://example.com/cover.png',
      url: '',
      tags: <ArticleTopic>[
        ArticleTopic(id: '1', name: 'Flutter'),
        ArticleTopic(id: '2', name: 'AI'),
        ArticleTopic(id: '3', name: '组件'),
        ArticleTopic(id: '4', name: '项目实战'),
        ArticleTopic(id: '5', name: 'AI 图像创作'),
      ]);
  await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: SingleChildScrollView(
              child: LibraryArticleCard(article: article, flat: true)))));
  final Image cover = tester.widget<Image>(find.byType(Image));
  Future<void> decodeCover() =>
      precacheImage(cover.image, tester.element(find.byType(MaterialApp)));
  await tester.runAsync(decodeCover);
  await tester.pumpAndSettle();
  final Finder labels = find.descendant(
      of: find.byType(ArticleTags), matching: find.byType(Text));
  final Set<double> rows = <double>{};
  for (final Element element in labels.evaluate()) {
    rows.add(tester.getTopLeft(find.byWidget(element.widget)).dy);
  }
  expect(rows, hasLength(1));
  final Finder more = find.textContaining(RegExp(r'^\+\d+$'));
  expect(more, findsOneWidget);
  await tester.tap(more);
  await tester.pumpAndSettle();
  final Finder sheet = find.byType(BottomSheet);
  expect(sheet, findsOneWidget);
  final Finder surface =
      find.descendant(of: sheet, matching: find.byType(Material)).first;
  expect(tester.getRect(surface).left, 0);
  expect(tester.getRect(surface).right, 360);
  for (final ArticleTopic topic in article.tags) {
    expect(find.descendant(of: sheet, matching: find.text(topic.name)),
        findsOneWidget);
  }
  expect(find.byType(MarkdownArticlePage), findsNothing);
  expect(tester.takeException(), isNull);
  Navigator.of(tester.element(sheet)).pop();
  await tester.pumpAndSettle();
  expect(sheet, findsNothing);
  expect(more, findsOneWidget);
}
