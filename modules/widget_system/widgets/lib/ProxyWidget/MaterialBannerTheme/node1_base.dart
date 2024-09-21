import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com

class MaterialBannerThemeDemo extends StatelessWidget {
  const MaterialBannerThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialBannerTheme(
      data: MaterialBannerTheme.of(context).copyWith(
        backgroundColor: Colors.purple,
        padding: const EdgeInsetsDirectional.only(start: 16.0, top: 2.0,end: 2),
        leadingPadding:const EdgeInsetsDirectional.only(end: 16.0) ,
        contentTextStyle:  const TextStyle(color: Colors.white),
      ),
      child: _MaterialBannerDemo(),
    );
  }
}


class _MaterialBannerDemo extends StatelessWidget {
  final info =
      'A banner displays an important, succinct message, and provides actions for users to address. '
      'A user action is required for itto be dismissed.';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[MaterialBanner(
        content: Text(info),
        leading: const Icon(Icons.warning, color: Colors.yellow),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {},
            child: const Text(
              'I KNOW',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {},
            child: const Text(
              'I IGNORE',
              style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ],
      )],
    );
  }
}