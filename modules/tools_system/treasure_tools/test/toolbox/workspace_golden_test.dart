import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treasure_tools/src/code_gen_page.dart';

void main() {
  testWidgets('桌面工具工作区视觉快照', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4699fb)),
          primaryColor: const Color(0xff4699fb),
          scaffoldBackgroundColor: const Color(0xfff3f4f6),
        ),
        home: const CodeGenPage(),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CodeGenPage),
      matchesGoldenFile('goldens/toolbox-workspace.png'),
    );
  });
}
