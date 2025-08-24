import 'package:flutter/material.dart';
import 'package:widget_repository/widget_repository.dart';

class WidgetIdView extends StatelessWidget {
  final int id;

  const WidgetIdView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Text(
      "#$id",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 10,
        color: Colors.white70,
      ),
    );
  }
}
