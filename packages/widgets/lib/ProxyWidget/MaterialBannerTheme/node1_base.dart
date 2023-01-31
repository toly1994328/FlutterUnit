import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com
/// 说明: 327 MaterialBannerTheme 主要用于为后代的MaterialBanner组件统一设置默认属性,也可以通过该组件获取默认MaterialBanner的属性。
//    {
//      "widgetId": 327,
//      "name": "MaterialBannerTheme基本使用",
//      "priority": 1,
//      "subtitle": "可指定MaterialBannerThemeData数据属性为【后代】的MaterialBanner组件设置默认样式，如背景色、边距、文字样式等。也可以用MaterialBannerTheme.of获取MaterialBanner的主题数据。",
//    }
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