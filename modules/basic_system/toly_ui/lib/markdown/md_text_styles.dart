
import 'package:flutter/material.dart';

class MdTextStyles{
  static const Color primaryValue = Color(0xFF24292E);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);
  static const Color miWhite = Color(0xffececec);
  static const Color white = Color(0xFFFFFFFF);
  static const Color actionBlue = Color(0xff267aff);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);
  static const Color mainTextColor = primaryDarkValue;
  static const Color textColorWhite = white;

  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const minText = TextStyle(
    color: subLightTextColor,
    fontSize: minTextSize,
  );


  static const smallTextWhite = TextStyle(
    color: textColorWhite,
    fontSize: smallTextSize,
  );


  static const smallText = TextStyle(
    color: mainTextColor,
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: mainTextColor,
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: subLightTextColor,
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: actionBlue,
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: miWhite,
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: subTextColor,
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: mainTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: textColorWhite,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: subTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: subLightTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: mainTextColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: textColorWhite,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: subTextColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: mainTextColor,
    fontSize: normalTextSize,
  );

  static const normalTextBold = TextStyle(
    color: mainTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color: subTextColor,
    fontSize: normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: textColorWhite,
    fontSize: normalTextSize,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: miWhite,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: actionBlue,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: primaryLightValue,
    fontSize: normalTextSize,
  );

  static const largeText = TextStyle(
    color: mainTextColor,
    fontSize: bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: mainTextColor,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: textColorWhite,
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: textColorWhite,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: textColorWhite,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: primaryValue,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}