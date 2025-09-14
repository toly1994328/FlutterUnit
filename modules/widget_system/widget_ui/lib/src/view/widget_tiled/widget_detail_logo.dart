import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:fx_env/fx_env.dart';
import 'package:widget_ui/widget_ui.dart';

class WidgetDetailLogo extends StatelessWidget {
  final Color background;
  final String widgetName;
  final WidgetModel model;

  const WidgetDetailLogo({
    super.key,
    required this.background,
    required this.widgetName,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    if (!kApp.isDesktop) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 0),
        child: WidgetLogo(
          background: background,
          widgetName: widgetName,
          widgetId: model.id,
          lever: model.lever,
          inDetail: true,
        ),
      );
    }

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
            width: 120,
          ),
        ),
        Positioned(
          top: 6,
          right: 0,
          child: StarScore(
            score: model.lever,
            star: Star(size: 15, fillColor: Colors.white),
          ),
        ),
        Positioned(
            bottom: 2,
            left: 6,
            child: Text(
              "#${model.id}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            )),
        _buildFieldCountBadge(context),
      ],
    );
  }

  Widget _buildFieldCountBadge(BuildContext context) {
    final provider = WidgetStatisticsProvider();
    final stats = provider.statistics;
    if (stats == null) return const SizedBox.shrink();

    final fieldCount = stats.getWidgetFieldCount(model.id);
    if (fieldCount == 0) return const SizedBox.shrink();

    return Positioned(
      right: 0,
      bottom: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _showFieldsDialog(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
          child: Text(
            '属性:$fieldCount 个',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showFieldsDialog(BuildContext context) {
    if (kApp.isMobile) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WidgetFieldsPage(
            widgetId: model.id,
            widgetName: widgetName,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => WidgetFieldsDialog(
          widgetId: model.id,
          widgetName: widgetName,
        ),
      );
    }
  }
}
