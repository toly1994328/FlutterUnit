
import 'package:flutter/material.dart';
import 'digital_path.dart';
import 'digital_widget.dart';

class DigitalShower extends StatefulWidget {
  const DigitalShower({Key? key}) : super(key: key);

  @override
  State<DigitalShower> createState() => _DigitalShowerState();
}

class _DigitalShowerState extends State<DigitalShower> {
  int _count = 0;

  final DigitalPath digitalPath = DigitalPath();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _count++;
          setState(() {});
        },
      ),
      body: Center(
          child: MultiDigitalWidget(
            colors: [Colors.indigo,],
        width: 50,
        spacing: 16,
        count: 4,
        value: _count,
      )
          ),
    );
  }
}
