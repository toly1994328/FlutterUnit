import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fx_ability/fx_ability.dart';
import 'package:flutter_unit/src/ability/flutter_unit_toast.dart';
import 'package:tolyui/app/toly_ui.dart';

void main() {
  testWidgets('全局 Toast Ability 不依赖业务页面 context', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    registerFlutterUnitAbilities();
    await tester.pumpWidget(
      TolyUiApp(
        scaffoldMessengerKey: flutterUnitScaffoldMessengerKey,
        home: const SizedBox(),
      ),
    );

    bool actionPressed = false;
    FxAbility().toast.show(
          '收藏成功',
          action: ToastAction(
            label: '收藏夹管理',
            onPressed: () => actionPressed = true,
          ),
        );
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.textContaining('收藏成功', findRichText: true),
      findsOneWidget,
    );
    expect(find.text('收藏夹管理'), findsOneWidget);

    await tester.tap(find.text('收藏夹管理'));
    expect(actionPressed, isTrue);
    await tester.pump(const Duration(seconds: 3));
  });
}
