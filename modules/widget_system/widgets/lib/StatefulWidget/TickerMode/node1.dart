import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TickerModeDemo1 extends StatefulWidget {
  const TickerModeDemo1({super.key});

  @override
  State<TickerModeDemo1> createState() => _TickerModeDemo1State();
}

class _TickerModeDemo1State extends State<TickerModeDemo1> {
  bool _disable = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildOutSwitch(),
        const SizedBox(height: 4),
        TickerMode(enabled: !_disable, child: buildTestContent()),
      ],
    );
  }

  Widget buildOutSwitch() => Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text('TickerMode外的Switch:'),
          Switch(value: _disable, onChanged: _onChanged)
        ],
      );

  Widget buildTestContent() => Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20,
        children: [
          Switch(value: _disable, onChanged: _onChanged),
          const CupertinoActivityIndicator(),
          const CircularProgressIndicator(),
        ],
      );

  void _onChanged(bool value) {
    setState(() {
      _disable = value;
    });
  }
}
