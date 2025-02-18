import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com


class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});

  Map<BannerLocation, Color> get data => {
    BannerLocation.topStart: Colors.red,
    BannerLocation.bottomStart: Colors.green,
    BannerLocation.bottomEnd: Colors.orange,
    BannerLocation.topEnd: Colors.blue,

  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: data.keys
            .map((BannerLocation location) => Container(
          color: const Color(0xffD8F5FF),
                  width: 150,
                  height: 150 * 0.618,
                  child: Banner(
                    message: "Flutter 3.29.0 发布",
                    location: location,
                    textStyle: TextStyle(fontSize: 8,height: 1),
                    color: data[location]!,
                    child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: FlutterLogo(
                          textColor: Colors.blue,
                          style: FlutterLogoStyle.horizontal,
                        )),
                  ),
        )).toList());
  }
}
