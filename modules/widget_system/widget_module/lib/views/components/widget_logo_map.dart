import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class WidgetLogo extends StatelessWidget {
  final Color background;
  final String widgetName;

  const WidgetLogo(
      {super.key, required this.background, required this.widgetName,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: background,
        gradient: LinearGradient(
            transform:GradientRotation(270*180/pi) ,
            colors: [
          background,
          background.withValues(alpha: 0.5)
        ]),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6)
        ),
      ),
      child: SvgPicture.asset(
          'assets/images/widgets/${widgetLogo(widgetName)}'),
    );
  }
}

  String widgetLogo(String widgetName) {
    return switch(widgetName){
      'Container' => 'Container.svg',
      'Text' => 'Text.svg',
      'GestureDetector' => 'GestureDetector.svg',
      'Card' => 'Card.svg',
      'ListView' => 'ListView.svg',
      _ => 'Widget.svg',
    };
  }
