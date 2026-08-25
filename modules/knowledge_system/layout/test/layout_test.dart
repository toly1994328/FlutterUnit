import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout/src/bloc/display_logic.dart';
import 'package:layout/src/bloc/display_state.dart';
import 'package:layout/src/data/display_map/display_map.dart';
import 'package:layout/src/data/model/display_frame.dart';
import 'package:layout/src/navigation/menu/menu_repository_impl.dart';

void main() {
  test('所有叶子菜单都有演示帧映射', () {
    final Set<String> menuPaths = _collectLeafPaths(layoutMenus);
    final Set<String> displayPaths = kDisplayMap.keys.toSet();

    expect(displayPaths, containsAll(menuPaths));
  });

  test('所有演示帧都有标题、说明和源码路径', () {
    for (final MapEntry<String, List<DisplayFrame>> entry
        in kDisplayMap.entries) {
      expect(entry.value, isNotEmpty, reason: '${entry.key} 没有演示帧');
      for (final DisplayFrame frame in entry.value) {
        expect(frame.title, isNotEmpty, reason: '${entry.key} 缺少标题');
        expect(frame.desc, isNotEmpty, reason: '${entry.key} 缺少说明');
        expect(frame.src, isNotEmpty, reason: '${entry.key} 缺少源码路径');
      }
    }
  });

  test('切换主题后回到第一帧并更新总数', () {
    final DisplayLogic logic = DisplayLogic(
      DisplayState(router: '/base/size', activeIndex: 2, total: 3),
    );

    logic.active('/multi/flex');

    expect(logic.state.router, '/multi/flex');
    expect(logic.state.activeIndex, 0);
    expect(logic.state.total, kDisplayMap['/multi/flex']!.length);
    logic.dispose();
  });

  test('未知路径不会破坏当前状态', () {
    final DisplayLogic logic = DisplayLogic(
      DisplayState(router: '/base/size', activeIndex: 0, total: 3),
    );

    logic.active('/missing');

    expect(logic.state.router, '/base/size');
    logic.dispose();
  });

  testWidgets('新增约束与 Flex 案例可在窄窗口渲染', _testNewLayoutFrames);
}

Future<void> _testNewLayoutFrames(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(520, 640));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  final List<DisplayFrame> frames = <DisplayFrame>[
    ...kDisplayMap['/base/constraints']!,
    ...kDisplayMap['/multi/flex-space']!,
  ];

  for (final DisplayFrame frame in frames) {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Builder(builder: frame.display)),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull, reason: '${frame.title} 渲染异常');
  }
}

Set<String> _collectLeafPaths(Map<String, dynamic> root) {
  final Set<String> paths = <String>{};
  final List<dynamic> children =
      root['children'] as List<dynamic>? ?? <dynamic>[];
  for (final dynamic child in children) {
    _collectNodePaths(
      child as Map<String, dynamic>,
      '',
      paths,
    );
  }
  return paths;
}

void _collectNodePaths(
  Map<String, dynamic> node,
  String parentPath,
  Set<String> paths,
) {
  final String nodePath = node['path'] as String? ?? '';
  final String fullPath = '$parentPath$nodePath';
  final List<dynamic>? children = node['children'] as List<dynamic>?;
  if (children == null || children.isEmpty) {
    paths.add(fullPath);
    return;
  }
  for (final dynamic child in children) {
    _collectNodePaths(
      child as Map<String, dynamic>,
      fullPath,
      paths,
    );
  }
}
