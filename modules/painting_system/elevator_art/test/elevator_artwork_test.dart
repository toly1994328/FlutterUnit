import 'package:elevator_art/elevator_art.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('电梯作品可以选择楼层并完成动画', _testElevatorTravel);
}

Future<void> _testElevatorTravel(WidgetTester tester) async {
  await tester.pumpWidget(
    const MaterialApp(home: Scaffold(body: ElevatorArtwork(floorCount: 4))),
  );

  expect(find.text('01'), findsOneWidget);
  await tester.tap(find.text('4'));
  await tester.pumpAndSettle(const Duration(seconds: 5));

  expect(find.text('04'), findsOneWidget);
  expect(tester.takeException(), isNull);
}
