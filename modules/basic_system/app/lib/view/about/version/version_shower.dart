import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionShower extends StatefulWidget {
  const VersionShower({Key? key}) : super(key: key);

  @override
  _VersionShowerState createState() => _VersionShowerState();
}

class _VersionShowerState extends State<VersionShower> {
  String version = '1.0.0';

  @override
  void initState() {
    super.initState();
    _fetchVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Version $version');
  }

  void _fetchVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if(mounted) {
      setState(() {
      version= packageInfo.version;
    });
    }
  }
}
