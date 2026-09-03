import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fx_user_ui/fx_user_ui.dart';

void main() {
  testWidgets('桌面登录弹框只展示登录表单', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(presentation: FxLoginPresentation.dialog),
      ),
    );

    expect(find.byType(Dialog), findsOneWidget);
    expect(find.text('FLUTTER UNIT'), findsNothing);
    expect(find.text('邮箱登录'), findsOneWidget);
    expect(find.text('密码登录'), findsOneWidget);
    expect(find.text('登录'), findsOneWidget);
  });
}
