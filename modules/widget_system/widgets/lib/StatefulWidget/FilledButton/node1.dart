import 'package:flutter/material.dart';

class FilledButtonDemo1 extends StatelessWidget {
  const FilledButtonDemo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 10, children: <Widget>[
      FilledButton(
        onPressed: () {},
        child: const Text('FilledButton'),
      ),
      const FilledButton(
        onPressed: null,
        child: Text('Disabled'),
      ),
    ]);
  }
}
