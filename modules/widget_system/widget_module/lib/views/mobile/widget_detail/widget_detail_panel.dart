import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:widget_ui/widget_ui.dart';

class WidgetDetailPanel extends StatelessWidget {
  final WidgetModel model;

  const WidgetDetailPanel({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Row(
      children: <Widget>[
        _buildLeft(model, context),
        Hero(
          tag: "hero_widget_image_${model.id}",
          child: WidgetDetailLogo(
            model: model,
            background: color,
            widgetName: model.name,
          ),
        )
      ],
    );
  }

  Widget _buildLeft(WidgetModel model, BuildContext context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Panel(
              constraints: BoxConstraints(minHeight: 110),
              alignment: Alignment.topLeft,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Text(model.info)),
        ),
      );
}
