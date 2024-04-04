import 'package:flutter/material.dart';

class InnerPadding extends StatelessWidget {
  const InnerPadding({super.key});

  @override
  Widget build(BuildContext context) {
    Color? color = Theme.of(context).primaryColor;
    TextStyle? style = const TextStyle(color: Colors.white);
    return Center(
      child: ColoredBox(
        color: color,
        child: SizedBox(
          width: 200,
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
            child: Text("张风捷特烈 " * 10, style: style),
          ),
        ),
      ),
    );
  }
}