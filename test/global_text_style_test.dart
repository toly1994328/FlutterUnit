import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('深浅主题与本地化后的按钮和正文均不引入额外字距', verifyTextSpacing);
}

Future<void> verifyTextSpacing(WidgetTester tester) async {
  for (final ThemeMode mode in <ThemeMode>[ThemeMode.light, ThemeMode.dark]) {
    for (final Locale locale in <Locale>[
      const Locale('en'),
      const Locale('zh')
    ]) {
      await tester.pumpWidget(MaterialApp(
          theme: lightTheme(const AppConfig()),
          darkTheme: darkTheme(const AppConfig()),
          themeMode: mode,
          locale: locale,
          supportedLocales: const <Locale>[Locale('en'), Locale('zh')],
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const Scaffold(body: _TextSample())));
      await tester.pumpAndSettle();
      final Element body = tester.element(find.text('正文 Body'));
      final Element button = tester.element(find.text('操作 Action'));
      expect(DefaultTextStyle.of(body).style.letterSpacing, 0);
      expect(DefaultTextStyle.of(button).style.letterSpacing, 0);
      expect(tester.takeException(), isNull);
    }
  }
}

/// 在实际 Material 组件中检查主题本地化后的继承样式。
class _TextSample extends StatelessWidget {
  const _TextSample();

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        const Text('正文 Body'),
        TextButton(onPressed: () {}, child: const Text('操作 Action')),
      ]);
}
