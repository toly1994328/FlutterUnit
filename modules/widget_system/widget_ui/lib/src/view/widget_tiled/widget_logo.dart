import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:fx_env/fx_env.dart';
import 'package:widget_ui/widget_ui.dart';
import 'widget_fields_dialog.dart';
import 'widget_fields_page.dart';

class WidgetLogo extends StatelessWidget {
  final Color background;
  final String widgetName;
  final int? widgetId;
  final double lever;
  final bool inDetail;

  const WidgetLogo({
    super.key,
    required this.background,
    required this.widgetName,
    this.widgetId,
    required this.lever,
    this.inDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 110,
          height: 110,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            gradient: LinearGradient(
                transform: const GradientRotation(270 * 180 / pi),
                colors: [
                  background.withValues(alpha: 0.9),
                  background.withValues(alpha: 0.5)
                ]),
            borderRadius: inDetail
                ? BorderRadius.circular(6)
                : const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
          ),
          child: SvgPicture.asset(
            'assets/images/widgets/${widgetLogo(widgetName)}',
            width: 80,
          ),
        ),
        Positioned(
            bottom: 4,
            left: 6,
            child: WidgetIdView(
              id: widgetId ?? 0,
            )),
        Positioned(
          top: 6,
          right: -4,
          child: StarScore(
            score: lever,
            star: Star(size: 10, fillColor: Colors.white),
          ),
        ),
        if (widgetId != null) _buildFieldCountBadge(context),
      ],
    );
  }

  Widget _buildFieldCountBadge(BuildContext context) {
    final provider = WidgetStatisticsProvider();
    final stats = provider.statistics;
    if (stats == null) return const SizedBox.shrink();

    final fieldCount = stats.getWidgetFieldCount(widgetId!);
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
            '属性:$fieldCount',
            style: const TextStyle(
              fontSize: 10,
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
            widgetId: widgetId!,
            widgetName: widgetName,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => WidgetFieldsDialog(
          widgetId: widgetId!,
          widgetName: widgetName,
        ),
      );
    }
  }
}

String widgetLogo(String widgetName) {
  return switch (widgetName) {
    'Container' => 'Container.svg',
    'Text' => 'Text.svg',
    'GestureDetector' => 'GestureDetector.svg',
    'CircleAvatar' => 'CircleAvatar.svg',
    'Card' => 'Card.svg',
    'ListView' => 'ListView.svg',
    'GridView' => 'GridView.svg',
    'SingleChildScrollView' => 'SingleChildScrollView.svg',
    'PageView' => 'PageView.svg',
    'InputChip' => 'InputChip.svg',
    'Chip' => 'Chip.svg',
    'FilterChip' => 'FilterChip.svg',
    'MaterialButton' => 'MaterialButton.svg',
    'FlutterLogo' => 'FlutterLogo.svg',
    'RichText' => 'RichText.svg',
    'FloatingActionButton' => 'FloatingActionButton.svg',
    'Banner' => 'Banner.svg',
    'Icon' => 'Icon.svg',
    _ => 'Widget.svg',
  };
}
