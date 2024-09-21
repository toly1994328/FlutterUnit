import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/21
/// contact me by email 1981462002@qq.com

class MaterialBannerDemo extends StatelessWidget {
  const MaterialBannerDemo({Key? key}) : super(key: key);

  final String info = 'Welcome to Flutter Unit!';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MaterialBanner(
          content: Text(
            info,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
          leading: const Icon(Icons.info, color: Colors.lightBlueAccent),
          padding: const EdgeInsetsDirectional.only(start: 16.0, top: 2.0),
          forceActionsBelow: false,
          // 默认false
          actions: const <Widget>[
            Text(
              'I KNOW',
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        )],
    );
  }

}
