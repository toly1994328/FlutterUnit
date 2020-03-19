import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      BannerLocation.topStart: Colors.red,
      BannerLocation.topEnd: Colors.blue,
      BannerLocation.bottomStart: Colors.green,
      BannerLocation.bottomEnd: Colors.yellow,
    };

    return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: data.keys.map((e) =>
            Container(
              color: Color(0xffD8F5FF),
              width: 150,
              height: 150 * 0.618,
              child: Banner(
                message: "Flutter 1.12发布",
                location: e,
                color: data[e],
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: FlutterLogo(colors: Colors.blue,
                      style: FlutterLogoStyle.horizontal,)),
              ),
            )).toList());
  }
}
