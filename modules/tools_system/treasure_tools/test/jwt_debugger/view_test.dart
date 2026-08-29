import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treasure_tools/src/jwt_debugger/view.dart';

void main() {
  testWidgets('JWT 调试器在移动端使用上下结构', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(488, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: JwtDebuggerTool())),
    );
    await tester.pump();

    expect(find.text('输入 JWT'), findsOneWidget);
    final Finder headerSection = find.textContaining('Header');
    expect(headerSection, findsOneWidget);
    expect(
      tester.getTopLeft(headerSection).dy,
      greaterThan(tester.getTopLeft(find.text('输入 JWT')).dy),
    );
    expect(tester.takeException(), isNull);
  });
}
