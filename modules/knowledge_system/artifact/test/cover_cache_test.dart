import 'package:artifact/src/articles/data/exp.dart';
import 'package:artifact/src/articles/view/library/article_card.dart';
import 'package:artifact/src/articles/view/library/collection_cover.dart';
import 'package:artifact/src/articles/view/library/collection_shelf_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'support/reading_image_cache.dart';

const String source = 'https://pc.toly1994.com/oss/o/cover.jpg';
const Columnize collection =
    Columnize(id: 'cache', title: '缓存专栏', cover: source);

void main() {
  setUp(configureReadingImageCache);
  tearDown(resetReadingImageCache);
  testWidgets('文章、桌面和手机专栏封面使用缓存，尺寸参数和点击操作保留', testCovers);
  testWidgets('封面缓存加载失败后显示各自占位', testErrors);
}

Future<void> mountCovers(WidgetTester tester, VoidCallback onTap) async {
  await tester.pumpWidget(MaterialApp(
      home: Scaffold(
          body: Column(children: <Widget>[
    const ArticleCover(url: source, width: 96, height: 96),
    SizedBox(
        width: 300,
        height: 180,
        child: CollectionCover(
            collection: collection,
            fallback: const Text('专栏占位'),
            onTap: onTap)),
    SizedBox(
        width: 300,
        height: 220,
        child: CollectionShelfCard(collection: collection, onTap: onTap)),
  ]))));
}

Future<void> testCovers(WidgetTester tester) async {
  int tapped = 0;
  await mountCovers(tester, () => tapped++);
  final List<Image> images =
      tester.widgetList<Image>(find.byType(Image)).toList();
  expect(images.length, 3);
  for (final Image image in images) {
    expect(image.image, isA<CachedNetworkImageProvider>());
    final Uri uri = Uri.parse((image.image as CachedNetworkImageProvider).url);
    expect(uri.queryParameters['w'], isNotNull);
    expect(uri.queryParameters['h'], isNotNull);
    expect(uri.queryParameters['format'], 'jpeg');
  }
  Future<void> cache(Image image) =>
      precacheImage(image.image, tester.element(find.byType(MaterialApp)));
  Future<void> decode() async => Future.wait<void>(images.map(cache));
  await tester.runAsync(decode);
  await tester.pumpAndSettle();
  await tester.tap(find.descendant(
      of: find.byType(CollectionCover), matching: find.byType(InkWell)));
  await tester.tap(find.descendant(
      of: find.byType(CollectionShelfCard), matching: find.byType(InkWell)));
  expect(tapped, 2);
  expect(tester.takeException(), isNull);
  await tester.pumpWidget(const SizedBox());
}

Future<void> testErrors(WidgetTester tester) async {
  configureReadingImageCache(failVariants: true);
  await mountCovers(tester, () {});
  await tester.pumpAndSettle();
  expect(find.text('专栏占位'), findsOneWidget);
  expect(find.byIcon(Icons.image_outlined), findsOneWidget);
  expect(find.byIcon(Icons.menu_book_outlined), findsOneWidget);
  expect(tester.takeException(), isNull);
  await tester.pumpWidget(const SizedBox());
}
