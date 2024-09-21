import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com

class CustomLicensePage extends StatelessWidget {
  const CustomLicensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: const LicensePage(
        applicationIcon: FlutterLogo(),
        applicationVersion: 'v0.0.1',
        applicationName: 'Flutter Unit',
        applicationLegalese: 'Copyright© 2018-2024 张风捷特烈',
      ),
    );
  }
}
