import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:flutter_unit/components/code/highlighter_style.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}


class EventInitApp extends GlobalEvent {
  const EventInitApp();
  @override
  List<Object> get props => [];
}

class EventSwitchHomeColor extends GlobalEvent {
  final Color color;

  const EventSwitchHomeColor(this.color);

  @override
  List<Object> get props => [color];
}


class EventSwitchFontFamily extends GlobalEvent {
  final String family;
  const EventSwitchFontFamily(this.family);

  @override
  List<Object> get props => [family];
}


class EventSwitchThemeColor extends GlobalEvent {
  final MaterialColor color;

  const EventSwitchThemeColor(this.color);

  @override
  List<Object> get props => [color];
}

class EventSwitchCoderTheme extends GlobalEvent {
  final int codeStyleIndex;

  const EventSwitchCoderTheme(this.codeStyleIndex);

  @override
  List<Object> get props => [codeStyleIndex];
}

class EventSwitchShowBg extends GlobalEvent {
  final bool show;

  const EventSwitchShowBg(this.show);

  @override
  List<Object> get props => [show];
}

class EventChangeItemStyle extends GlobalEvent {
  final int index;

  const EventChangeItemStyle(this.index);

  @override
  List<Object> get props => [index];
}

class UpdateAppBarHeight extends GlobalEvent {
  final double height;

  const UpdateAppBarHeight(this.height);

  @override
  List<Object> get props => [height];
}