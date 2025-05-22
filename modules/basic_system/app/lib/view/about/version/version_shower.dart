import 'package:app/app.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Text('Version $kAppVersion');
  }
}
