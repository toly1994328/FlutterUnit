import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('桌面用户中心默认复用移动端用户能力', () {
    const DesktopUserPage page = DesktopUserPage();

    expect(page.child, isA<UserPage>());
  });

  testWidgets('桌面用户中心限制内容宽度', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SizedBox(
          width: 1440,
          height: 900,
          child: DesktopUserPage(child: SizedBox()),
        ),
      ),
    );

    final Finder constrainedBox = find.byWidgetPredicate(
      (Widget widget) =>
          widget is ConstrainedBox &&
          widget.constraints.maxWidth == DesktopUserPage.maxContentWidth,
    );

    expect(constrainedBox, findsOneWidget);
  });
}
