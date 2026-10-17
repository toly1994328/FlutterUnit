import 'package:artifact/src/articles/data/model/article.dart';
import 'package:artifact/src/articles/view/library/topic_filter_button.dart';
import 'package:artifact/src/articles/view/library/topic_options.dart';
import 'package:artifact/src/articles/view/library/topic_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const List<ArticleTopic> topics = <ArticleTopic>[
  ArticleTopic(id: '1', name: 'Flutter', group: '语言与框架', count: 83),
  ArticleTopic(id: '2', name: 'Dart', group: '语言与框架', count: 29),
  ArticleTopic(id: '3', name: 'Canvas', group: '图形技术', count: 61),
];

void main() {
  testWidgets('悬浮面板锚定按钮，草稿取消与外部点击均不提交', testDismiss);
  testWidgets('搜索匹配分组且忽略大小写，应用后显示所选数量', testSearchAndApply);
  testWidgets('窄窗口深色面板不溢出，加载失败可原地重试', testRetry);
  testWidgets('达到 20 项上限仍可移除，移除后允许添加', testSelectionLimit);
}

Future<List<ArticleTopic>> loadTopics() async => topics;

Future<void> mount(WidgetTester tester,
    {Size size = const Size(1000, 800),
    TopicLoader loader = loadTopics}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          body: Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: FilterHarness(loader: loader))))));
  await tester.pumpAndSettle();
  await tester.tap(find.text('主题筛选'));
  await tester.pumpAndSettle();
}

Future<void> testDismiss(WidgetTester tester) async {
  await mount(tester);
  expect(find.byType(Dialog), findsNothing);
  expect(tester.getTopLeft(find.byType(TopicPicker)).dy,
      greaterThan(tester.getBottomRight(find.byType(TopicFilterButton)).dy));
  await tester.tap(find.byKey(const ValueKey<String>('topic-option-1')));
  await tester.pumpAndSettle();
  expect(find.text('已选 1 / 20'), findsOneWidget);
  expect(find.text('提交 0 次'), findsOneWidget);
  await tester.tap(find.text('取消'));
  await tester.pumpAndSettle();
  expect(find.byType(TopicPicker), findsNothing);
  await tester.tap(find.text('主题筛选'));
  await tester.pumpAndSettle();
  expect(find.text('已选 0 / 20'), findsOneWidget);
  await tester.tapAt(const Offset(100, 700));
  await tester.pumpAndSettle();
  expect(find.byType(TopicPicker), findsNothing);
  expect(find.text('提交 0 次'), findsOneWidget);
}

Future<void> testSearchAndApply(WidgetTester tester) async {
  await mount(tester);
  await tester.enterText(find.byType(TextField), '图形技术');
  await tester.pumpAndSettle();
  expect(
      find.descendant(
          of: find.byType(TopicOptions), matching: find.text('Canvas')),
      findsOneWidget);
  expect(
      find.descendant(
          of: find.byType(TopicOptions), matching: find.text('Flutter')),
      findsNothing);
  await tester.enterText(find.byType(TextField), 'cAnVaS');
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey<String>('topic-option-3')));
  await tester.pumpAndSettle();
  expect(find.byType(InputChip), findsOneWidget);
  await tester.tap(find.text('应用筛选（1）'));
  await tester.pumpAndSettle();
  expect(find.text('已选 1 个主题'), findsOneWidget);
  expect(find.text('提交 1 次'), findsOneWidget);
  await tester.tap(find.text('已选 1 个主题'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('清除选择'));
  await tester.pumpAndSettle();
  expect(find.byType(InputChip), findsNothing);
  await tester.sendKeyEvent(LogicalKeyboardKey.escape);
  await tester.pumpAndSettle();
  expect(find.byType(TopicPicker), findsNothing);
  expect(find.text('已选 1 个主题'), findsOneWidget);
}

Future<void> testRetry(WidgetTester tester) async {
  int attempts = 0;
  Future<List<ArticleTopic>> retryTopics() async {
    if (attempts++ == 0) throw StateError('offline');
    return topics;
  }

  await mount(tester, size: const Size(360, 760), loader: retryTopics);
  expect(find.text('主题加载失败'), findsOneWidget);
  await tester.tap(find.text('重新加载'));
  await tester.pumpAndSettle();
  expect(find.text('语言与框架'), findsOneWidget);
  expect(find.text('图形技术'), findsOneWidget);
  expect(tester.takeException(), isNull);
  await tester.tap(find.text('查看全部文章'));
  await tester.pumpAndSettle();
  expect(find.text('提交 1 次'), findsOneWidget);
}

Future<void> testSelectionLimit(WidgetTester tester) async {
  final List<ArticleTopic> many = List<ArticleTopic>.generate(
      21,
      (int index) =>
          ArticleTopic(id: '$index', name: '主题 $index', group: '主题'));
  Future<List<ArticleTopic>> loader() async => many;
  final List<String> initial =
      List<String>.generate(20, (int index) => '$index');
  await tester.pumpWidget(MaterialApp(
      home: Scaffold(
          body: Center(
              child: SizedBox(
                  width: 520,
                  height: 600,
                  child: TopicPicker(
                      loadTopics: loader,
                      selected: initial,
                      onApply: (List<String> selected) {},
                      onCancel: () {}))))));
  await tester.pumpAndSettle();
  final Finder last = find.byKey(const ValueKey<String>('topic-option-20'));
  await tester.ensureVisible(last);
  await tester.tap(last);
  await tester.pumpAndSettle();
  expect(find.text('已选 20 / 20'), findsOneWidget);
  final Finder first = find.byKey(const ValueKey<String>('topic-option-0'));
  await tester.ensureVisible(first);
  await tester.tap(first);
  await tester.pumpAndSettle();
  expect(find.text('已选 19 / 20'), findsOneWidget);
  await tester.ensureVisible(last);
  await tester.tap(last);
  await tester.pumpAndSettle();
  expect(find.text('已选 20 / 20'), findsOneWidget);
  expect(tester.takeException(), isNull);
}

/// 模拟父页面只在确认筛选后更新已生效条件。
class FilterHarness extends StatefulWidget {
  const FilterHarness({super.key, required this.loader});

  /// 可替换的主题请求。
  final TopicLoader loader;
  @override
  State<FilterHarness> createState() => _FilterHarnessState();
}

class _FilterHarnessState extends State<FilterHarness> {
  /// 已提交的主题标识。
  List<String> _selected = <String>[];

  /// 文章查询应触发的次数。
  int _submissions = 0;
  void _apply(List<String> selected) {
    setState(() {
      _selected = selected;
      _submissions++;
    });
  }

  @override
  Widget build(BuildContext context) =>
      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        TopicFilterButton(
            selected: _selected, loadTopics: widget.loader, onApply: _apply),
        Text('提交 $_submissions 次'),
      ]);
}
