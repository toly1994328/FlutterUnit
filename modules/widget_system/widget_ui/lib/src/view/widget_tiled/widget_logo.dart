import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_repository/widget_repository.dart';
import 'package:fx_env/fx_env.dart';
import 'package:widget_ui/widget_ui.dart';

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

class GlassSquare extends StatelessWidget {
  final Color color; // 主颜色
  final double size; // 边长
  final Widget? child; // 子组件

  const GlassSquare({
    super.key,
    required this.color,
    this.size = 300,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 背景渐变层
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  Color.lerp(color, Colors.white, 0.4)!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 25,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          ),

          // 毛玻璃效果层
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // 高光层
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.45),
                  Colors.transparent,
                ],
                radius: 0.6,
                center: const Alignment(-0.6, -0.6),
              ),
            ),
          ),

          // 柔光层
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.15),
                  Color.fromRGBO(0, 0, 0, 0.25),
                ],
              ),
            ),
          ),

          // 子组件
          if (child != null) child!,
        ],
      ),
    );
  }
}
