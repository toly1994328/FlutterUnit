import 'package:flutter/material.dart';

import 'package:widget_repository/widget_repository.dart';
import '../../desk_ui/widget_panel/widget_tiled.dart';

class MobileWidgetTiled extends StatelessWidget {
  final WidgetModel model;
  final VoidCallback onTap;
  final String? searchArg;

  const MobileWidgetTiled({
    Key? key,
    required this.model,
    required this.onTap,
    this.searchArg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
      child: WidgetTiled(
        model: model,
        onTap: onTap,
        searchArg: searchArg,
      ),
    );
  }
}
