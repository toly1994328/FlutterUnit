import 'package:flutter/material.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:widget_ui/widget_ui.dart';
import 'dart:math';

import '../../../blocs/blocs.dart';
import '../../components/widget_logo_map.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:l10n/l10n.dart';
import 'link_widget_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          Hero(
            tag: "hero_widget_image_${model.id}",
            child: WidgetDetailLogo(
              model: model,
              background: color,
              widgetName: model.name,
            ),
          )
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
                  onSelect: (v) {
                    context.read<WidgetDetailBloc>().push(v);
                  })
          ],
        ),
      );
}
