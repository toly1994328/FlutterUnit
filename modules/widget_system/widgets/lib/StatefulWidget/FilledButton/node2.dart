import 'package:flutter/material.dart';

class FilledButtonDemo2 extends StatelessWidget {
  const FilledButtonDemo2({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10,
        children: <Widget>[
      FilledButton.tonal(
        onPressed: () {},
        child: const Text('FilledButton'),
      ),
      const FilledButton.tonal(
        onPressed: null,
        child: Text('Disabled'),
      ),
    ]);
  }
}
