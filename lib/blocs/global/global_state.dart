import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/components/code/highlighter_style.dart';

class GlobalState extends Equatable {
  final double height;
  final Color color;
  final String fontFamily;
  final MaterialColor themeColor;
  final bool showBackGround;
  final int codeStyleIndex;
  final int itemStyleIndex;

  const GlobalState({
    this.height,
    this.color,
    this.fontFamily = 'ComicNeue',
    this.themeColor = Colors.blue,
    this.showBackGround = true,
    this.codeStyleIndex,
    this.itemStyleIndex,
  });

  @override
  List<Object> get props =>
      [height, color, fontFamily, themeColor, showBackGround, codeStyleIndex,itemStyleIndex];

  GlobalState copyWith({
    Color color,
    double height,
    String fontFamily,
    MaterialColor themeColor,
    bool showBackGround,
    int codeStyleIndex,
    int itemStyleIndex,
  }) =>
      GlobalState(
        color: color ?? this.color,
        height: height ?? this.height,
        fontFamily: fontFamily ?? this.fontFamily,
        themeColor: themeColor ?? this.themeColor,
        showBackGround: showBackGround ?? this.showBackGround,
        codeStyleIndex: codeStyleIndex ?? this.codeStyleIndex,
        itemStyleIndex: codeStyleIndex ?? this.itemStyleIndex,
      );

  @override
  String toString() {
    return 'GlobalState{height: $height, color: $color, fontFamily: $fontFamily, themeColor: $themeColor, showBackGround: $showBackGround, codeStyleIndex: $codeStyleIndex, itemStyleIndex: $itemStyleIndex}';
  }


}
