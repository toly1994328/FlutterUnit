import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/panel.dart';

class CustomFlutterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var data = {
      Colors.blue:50.0,
      Colors.red:60.0,
      Colors.green:70.0,
      Colors.yellow:80.0,
    };
    return Wrap(
      children: data.keys
          .map((e) => FlutterLogo(
                size: data[e],
                colors: e,
              ))
          .toList(),
    );
  }
}

class FlutterLogoWithText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = {
      FlutterLogoStyle.horizontal:Colors.blue,
      FlutterLogoStyle.markOnly:Colors.red,
      FlutterLogoStyle.stacked:Colors.green,
    };

    return Wrap(
      spacing: 20,
      children: data.keys.map((e) => FlutterLogo(
        size: 80,
        style: e,
        textColor: data[e],
      ))
          .toList(),
    );
  }
}

