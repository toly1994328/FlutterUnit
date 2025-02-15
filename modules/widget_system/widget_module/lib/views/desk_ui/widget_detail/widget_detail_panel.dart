import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:widget_repository/widget_repository.dart';
import 'dart:math';

import '../../../blocs/blocs.dart';
import '../../components/widget_logo_map.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:l10n/l10n.dart';
import 'link_widget_buttons.dart';

class DeskWidgetDetailPanel extends StatelessWidget {
  final WidgetModel model;
  final DetailState state;

  const DeskWidgetDetailPanel(
      {Key? key, required this.model, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildLeft(model, context),
          const SizedBox(width: 12),
          _buildRight(color, model),
        ],
      ),
    );
  }

  Widget linkText(BuildContext context) => Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(Icons.link, color: Colors.blue),
          ),
          Text(context.l10n.relatedComponents,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      );

  Widget _buildLeft(WidgetModel model, BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Panel(
              color: Color(0x33E5EAE1),
              child: Text(model.info),

            ),
            const SizedBox(height: 16),
            linkText(context),
            if (state is DetailWithData)
              LinkWidgetButtons(
                  links: (state as DetailWithData).links,
                  onSelect: (v) {})
          ],
        ),
      );

  Widget _buildRight(Color color, WidgetModel model) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Hero(
            tag: "hero_widget_image_${model.id}",
            child: WidgetLogo(
              widgetId: model.id,
              background: color,
              widgetName: model.name,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          StarScore(
            score: model.lever,
            star:  Star(size: 15, fillColor:color),
          )
        ],
      );
}

class WidgetLogo extends StatelessWidget {
  final Color background;
  final String widgetName;
  final int widgetId;

  const WidgetLogo({
    super.key,
    required this.background,
    required this.widgetName, required this.widgetId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 240,
          height: 160,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            gradient: LinearGradient(
                transform: const GradientRotation(270 * 180 / pi),
                colors: [
                  background.withValues(alpha: 0.9),
                  background.withValues(alpha: 0.5)
                ]),
            borderRadius: BorderRadius.circular(6),
          ),
          child: SvgPicture.asset(
            'assets/images/widgets/${widgetLogo(widgetName)}',
            width: 140,
          ),
        ),
        Positioned(
            bottom: 2,
            left: 6,
            child: Text(
              "#$widgetId",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ))
      ],
    );
  }
}
