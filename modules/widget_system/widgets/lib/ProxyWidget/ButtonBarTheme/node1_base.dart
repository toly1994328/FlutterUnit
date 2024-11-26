import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com


class ButtonBarThemeDemo extends StatelessWidget {
  const ButtonBarThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonBarTheme(
        data: ButtonBarTheme.of(context).copyWith(
            alignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.symmetric(horizontal: 6),
            overflowDirection: VerticalDirection.up,
            buttonMinWidth: 150,
            buttonHeight: 30,
            buttonTextTheme: ButtonTextTheme.primary),
        child: const TempButtonBar());
  }
}

class TempButtonBar extends StatelessWidget {
  const TempButtonBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text("1.Elevated"), onPressed: () {}),
        OutlinedButton(child: const Text("2.Outlined"), onPressed: () {}),
        TextButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: () {},
          child: const Text("3.Text"),
        )
      ],
    );
  }
}
