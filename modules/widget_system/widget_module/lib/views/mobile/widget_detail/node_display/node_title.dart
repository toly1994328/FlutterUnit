import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';

class NodeTitle extends StatelessWidget {
  final String text;
  const NodeTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {

    return   Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Circle(
            color: Theme.of(context).primaryColor,
            radius: 5,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class LinkedButton extends StatelessWidget {
  const LinkedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


