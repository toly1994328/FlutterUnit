import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class WidgetLogo extends StatelessWidget {
  final Color background;
  final String widgetName;
  const WidgetLogo({
    super.key,
    required this.background,
    required this.widgetName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), bottomLeft: Radius.circular(6)),
      ),
      child: SvgPicture.asset(
        'assets/images/widgets/${widgetLogo(widgetName)}',
        width: 90,
      ),
    );
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
