import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionShower extends StatefulWidget {
  const VersionShower({super.key});

  @override
  _VersionShowerState createState() => _VersionShowerState();
}

class _VersionShowerState extends State<VersionShower> {
  String version = '1.0.0';

  @override
  void initState() {
    super.initState();
    _initVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Version $version');
  }

  void _initVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    setState(() {});
  }
}
