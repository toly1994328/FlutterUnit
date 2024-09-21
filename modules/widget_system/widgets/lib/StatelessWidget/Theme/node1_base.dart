import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class TextThemeDemo extends StatelessWidget {
  const TextThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme queryData = Theme.of(context).textTheme;
    Map<String, TextStyle> styles = {
      "headlineSmall: ": queryData.headlineSmall!,
      "headlineMedium: ": queryData.headlineMedium!,
      "headlineLarge: ": queryData.headlineLarge!,
      "bodySmall: ": queryData.bodySmall!,
      "bodyMedium: ": queryData.bodyMedium!,
      "bodyLarge: ": queryData.bodyLarge!,
      "titleSmall: ": queryData.titleSmall!,
      "titleMedium: ": queryData.titleMedium!,
      "titleLarge: ": queryData.titleLarge!,
      "labelMedium: ": queryData.labelMedium!,
      "labelSmall: ": queryData.labelSmall!,
      "labelLarge: ": queryData.labelLarge!,
    };

    return Column(
      children: styles.keys
          .map((String styleInfo) => buildItem(styleInfo, styles[styleInfo]!))
          .toList(),
    );
  }

  TextStyle get textStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  Widget buildItem(String styleInfo, TextStyle style) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(styleInfo, style: textStyle),
                Text("@toly", style: style)
              ],
            ),
          ),
          const Divider(height: 1)
        ],
      );
}