import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasure_tools/src/code_gen_page.dart';

void main() {
  testWidgets('侧栏工具以多标签方式打开、切换和关闭', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: CodeGenPage()),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey<String>('tool-tab-jwt-debugger')),
        findsOneWidget);

    await tester.tap(find.text('JSON 解析').first);
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey<String>('tool-tab-jwt-debugger')),
        findsOneWidget);
    expect(find.byKey(const ValueKey<String>('tool-tab-json-parser')),
        findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey<String>('tool-tab-close-json-parser')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey<String>('tool-tab-json-parser')),
        findsNothing);
    expect(find.byKey(const ValueKey<String>('tool-tab-jwt-debugger')),
        findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
