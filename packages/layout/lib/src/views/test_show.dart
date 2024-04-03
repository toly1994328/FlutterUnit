import 'package:flutter/material.dart';

class TextShow extends StatelessWidget {
  final String info;

  const TextShow({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(child: Text(info)),
    );
  }
}
