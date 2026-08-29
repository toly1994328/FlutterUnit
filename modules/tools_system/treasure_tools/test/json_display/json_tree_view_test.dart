import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treasure_tools/src/view/json_display/json_display.dart';

void main() {
  testWidgets('移动端 JSON 根节点撑满结构预览宽度', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 700));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(home: JsonAnalysisTool()),
    );
    await tester.pump();

    final Finder rootNode = find
        .ancestor(
          of: find.text('{').first,
          matching: find.byType(InkWell),
        )
        .first;
    expect(tester.getSize(rootNode).width, greaterThan(350));
    expect(tester.takeException(), isNull);
  });
}
