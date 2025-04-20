import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widget_module.dart';

class WidgetIdView extends StatelessWidget {
  final WidgetModel model;

  const WidgetIdView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Text(
      "#${model.id}",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.white70,
      ),
    );
  }
}
