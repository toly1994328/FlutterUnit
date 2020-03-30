import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/utils/color_utils.dart';

/// create by 张风捷特烈 on 2020-03-22
/// contact me by email 1981462002@qq.com
/// 说明: 全局信息的bloc

class GlobalState extends Equatable {
  final double height;
  final Color color;

  const GlobalState({this.height, this.color});

  @override
  List<Object> get props => [height,color];

  GlobalState copyWith({
    Color color,
    double height,
  }) =>
      GlobalState(
        color: color ?? this.color,
        height: height ?? this.height,
      );

  @override
  String toString() {
    return 'GlobalState{height: $height, color: $color}';
  }
}

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

class EventSwitchColor extends GlobalEvent {
  final Color color;

  const EventSwitchColor(this.color);

  @override
  List<Object> get props => [color];
}

class UpdateAppBarHeight extends GlobalEvent {
  final double height;

  const UpdateAppBarHeight(this.height);

  @override
  List<Object> get props => [height];
}

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  @override
  GlobalState get initialState =>
      GlobalState(color: Colors.blue, height: kToolbarHeight * 2 - 20);

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    if (event is EventSwitchColor) {
      yield* _mapLoadWidgetToState(event.color);
    }
    if (event is UpdateAppBarHeight) {
      yield state.copyWith(height: event.height);
    }
  }

  Stream<GlobalState> _mapLoadWidgetToState(Color color) async* {
    yield state.copyWith(color: color);
  }
}
