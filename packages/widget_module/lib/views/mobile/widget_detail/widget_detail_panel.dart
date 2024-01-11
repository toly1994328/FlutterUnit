import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';

import '../../../data/exp.dart';

class WidgetDetailPanel extends StatelessWidget {
  final WidgetModel model;

  const WidgetDetailPanel({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildLeft(model, context),
            _buildRight(model),
          ],
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildLeft(WidgetModel model, BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Panel(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Text(model.info)),
    ),
  );

  Widget _buildRight(WidgetModel model) => Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
              tag: "hero_widget_image_${model.id}",
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: model.image == null
                      ? Image.asset('assets/images/caver.webp')
                      : Image(image: model.image!))),
        ),
      ),
      StarScore(
        score: model.lever,
        star: const Star(size: 15, fillColor: Colors.blue),
      )
    ],
  );
}
